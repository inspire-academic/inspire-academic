-- ════════════════════════════════════════════════════════════════
-- pasco_library_schema.sql
-- Private PASCO file cabinet behind teacher/pasco-library.html:
-- original GCSE Higher-tier papers, mark schemes and Inspire worked
-- solutions, filed by board / subject / year / series / paper.
--
-- PERSONAL USE ONLY. Board papers are third-party copyright material
-- kept for private preparation — they must never be publicly
-- reachable. So:
--   * files live in a PRIVATE storage bucket (never in the repo or
--     under /assets, which Netlify serves to anyone), and
--   * both the table and the bucket are admin-only via is_admin().
--
-- Run in the Supabase SQL Editor. Idempotent.
-- ════════════════════════════════════════════════════════════════

-- Same idempotent helper as attendance_schema.sql / invoices_schema.sql.
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

-- ── 1. pasco_library_files — one row per filled slot ──
CREATE TABLE IF NOT EXISTS pasco_library_files (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  board         text        NOT NULL CHECK (board IN ('AQA','Edexcel')),
  subject       text        NOT NULL CHECK (subject IN ('Physics','Chemistry','Biology','Mathematics')),
  exam_year     integer     NOT NULL CHECK (exam_year >= 2018),
  series        text        NOT NULL CHECK (series IN ('June','November')),
  tier          text        NOT NULL DEFAULT 'Higher' CHECK (tier IN ('Higher')),
  paper_number  integer     NOT NULL CHECK (paper_number BETWEEN 1 AND 3),
  doc_type      text        NOT NULL CHECK (doc_type IN ('paper','mark_scheme','solution')),
  storage_path  text        NOT NULL,
  file_name     text        NOT NULL,
  mime_type     text        NOT NULL CHECK (mime_type IN ('application/pdf','text/html')),
  size_bytes    bigint,
  uploaded_by   uuid        REFERENCES profiles(id),
  uploaded_at   timestamptz NOT NULL DEFAULT now()
);

-- One file per slot — replacing a file upserts onto this key.
CREATE UNIQUE INDEX IF NOT EXISTS idx_pasco_library_slot
  ON pasco_library_files (board, subject, exam_year, series, tier, paper_number, doc_type);

ALTER TABLE pasco_library_files ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "pasco_library_files_admin_all" ON pasco_library_files;
CREATE POLICY "pasco_library_files_admin_all" ON pasco_library_files
  FOR ALL TO authenticated
  USING (is_admin()) WITH CHECK (is_admin());

-- ── 2. Storage — private bucket, admin-only ──
INSERT INTO storage.buckets (id, name, public)
VALUES ('pasco-library', 'pasco-library', false)
ON CONFLICT (id) DO UPDATE SET public = false;

DROP POLICY IF EXISTS "pasco_library_bucket_admin_all" ON storage.objects;
CREATE POLICY "pasco_library_bucket_admin_all" ON storage.objects
  FOR ALL TO authenticated
  USING (bucket_id = 'pasco-library' AND is_admin())
  WITH CHECK (bucket_id = 'pasco-library' AND is_admin());

-- ── Verify after running ──
-- 1. select id, public from storage.buckets where id = 'pasco-library';   -- public = false
-- 2. select policyname from pg_policies where tablename = 'pasco_library_files';
-- 3. select policyname from pg_policies where schemaname = 'storage' and policyname like 'pasco_library%';
