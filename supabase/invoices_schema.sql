-- ════════════════════════════════════════════════════════════════
-- invoices_schema.sql
-- Monthly parent invoicing, billed off the real attendance data in
-- attendance_schema.sql (class_sessions / attendance_records). Run in
-- Supabase SQL Editor.
--
-- Rate model: a single global default (billing_settings, one row),
-- overridable per student (student_billing_rates). An invoice snapshots
-- the rate that applied at generation time, so a later rate change never
-- rewrites an already-issued invoice.
-- ════════════════════════════════════════════════════════════════

-- Same idempotent helper as attendance_schema.sql / teacher_student_assignments_rls.sql.
CREATE OR REPLACE FUNCTION is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('admin', 'super_admin')
  );
$$;

-- ── 1. billing_settings — single global row holding the default rate ──
CREATE TABLE IF NOT EXISTS billing_settings (
  id           text        PRIMARY KEY DEFAULT 'default',
  default_rate numeric     NOT NULL DEFAULT 35,
  currency     text        NOT NULL DEFAULT 'GBP',
  updated_at   timestamptz NOT NULL DEFAULT now()
);

INSERT INTO billing_settings (id, default_rate, currency)
VALUES ('default', 35, 'GBP')
ON CONFLICT (id) DO NOTHING;

-- ── 2. student_billing_rates — per-student override; no row = use default ──
CREATE TABLE IF NOT EXISTS student_billing_rates (
  student_id uuid        PRIMARY KEY REFERENCES profiles(id),
  rate       numeric     NOT NULL,
  currency   text        NOT NULL DEFAULT 'GBP',
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- ── 3. invoices — one row per generated invoice ──
CREATE TABLE IF NOT EXISTS invoices (
  id              uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  invoice_number  text        NOT NULL UNIQUE,
  student_id      uuid        NOT NULL REFERENCES profiles(id),
  teacher_id      uuid        NOT NULL REFERENCES profiles(id),
  period_start    date        NOT NULL,
  period_end      date        NOT NULL,
  session_count   integer     NOT NULL,
  rate            numeric     NOT NULL,
  currency        text        NOT NULL DEFAULT 'GBP',
  total           numeric     NOT NULL,
  bank_account    text        NOT NULL CHECK (bank_account IN ('default','cic')),
  recipient_email text,
  status          text        NOT NULL DEFAULT 'draft' CHECK (status IN ('draft','sent','paid','void')),
  created_at      timestamptz NOT NULL DEFAULT now(),
  sent_at         timestamptz,
  paid_at         timestamptz
);

-- Blocks two live (non-void) invoices covering the same student+period —
-- the double-billing guard. Voiding a mistaken invoice frees the period up.
CREATE UNIQUE INDEX IF NOT EXISTS idx_invoices_student_period_live
  ON invoices (student_id, period_start, period_end)
  WHERE status <> 'void';

CREATE INDEX IF NOT EXISTS idx_invoices_student ON invoices(student_id);
CREATE INDEX IF NOT EXISTS idx_invoices_teacher ON invoices(teacher_id);

-- ── 4. invoice_sessions — which class_sessions a given invoice bills for ──
CREATE TABLE IF NOT EXISTS invoice_sessions (
  invoice_id uuid NOT NULL REFERENCES invoices(id) ON DELETE CASCADE,
  session_id uuid NOT NULL REFERENCES class_sessions(id),
  PRIMARY KEY (invoice_id, session_id)
);

ALTER TABLE billing_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE student_billing_rates ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoice_sessions ENABLE ROW LEVEL SECURITY;

-- Rates affect every teacher's billing, so any staff member can see them,
-- but only admins change the shared default / another teacher's override.
CREATE POLICY "Staff view billing settings"
  ON billing_settings FOR SELECT TO authenticated
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('teacher','teacher_manager','admin','super_admin')));

CREATE POLICY "Admins manage billing settings"
  ON billing_settings FOR ALL TO authenticated
  USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "Staff view student billing rates"
  ON student_billing_rates FOR SELECT TO authenticated
  USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role IN ('teacher','teacher_manager','admin','super_admin')));

CREATE POLICY "Admins manage student billing rates"
  ON student_billing_rates FOR ALL TO authenticated
  USING (is_admin()) WITH CHECK (is_admin());

-- Invoices/invoice_sessions: same "owning teacher or admin" shape as
-- class_sessions/attendance_records in attendance_schema.sql.
CREATE POLICY "Teachers manage their own invoices"
  ON invoices FOR ALL TO authenticated
  USING (teacher_id = auth.uid() OR is_admin())
  WITH CHECK (teacher_id = auth.uid() OR is_admin());

CREATE POLICY "Teachers manage sessions on their own invoices"
  ON invoice_sessions FOR ALL TO authenticated
  USING (
    is_admin() OR EXISTS (
      SELECT 1 FROM invoices i WHERE i.id = invoice_sessions.invoice_id AND i.teacher_id = auth.uid()
    )
  )
  WITH CHECK (
    is_admin() OR EXISTS (
      SELECT 1 FROM invoices i WHERE i.id = invoice_sessions.invoice_id AND i.teacher_id = auth.uid()
    )
  );

-- ════════════════════════════════════════════════════════════════
-- Verify after running:
--
--   select policyname, cmd, roles, qual, with_check
--   from pg_policies
--   where tablename in ('billing_settings','student_billing_rates','invoices','invoice_sessions');
--
-- Confirm no other policy on any of these tables (e.g. left over from
-- dashboard work) permits an unintended non-owning, non-admin write —
-- Postgres ORs permissive policies together.
-- ════════════════════════════════════════════════════════════════
