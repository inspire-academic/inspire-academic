\set ON_ERROR_STOP 0
create or replace function pg_temp.check(label text, ok boolean) returns void language plpgsql as $$
begin raise notice '% %', case when ok then 'PASS' else 'FAIL' end, label; end $$;
select pg_temp.check('rollback: column gone',
  not exists (select 1 from information_schema.columns where table_name = 'diagnostic_sessions' and column_name = 'programme_check'));
select pg_temp.check('rollback: tables gone',
  (select count(*) from pg_tables where tablename in ('programme_cohorts', 'intervention_decisions')) = 0);
select pg_temp.check('rollback: ordinary sessions kept', (select count(*) from public.diagnostic_sessions) = 2);
