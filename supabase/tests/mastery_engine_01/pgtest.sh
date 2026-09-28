#!/bin/sh
# Fresh Postgres 17 -> Supabase stand-in -> migration 1 (twice) -> curriculum
# SQL -> the given scenario files. Prints PASS/FAIL lines and any errors.
S="$(cd "$(dirname "$0")" && pwd)"
R="$S/../../.."
docker rm -f me-pg >/dev/null 2>&1
docker run -d --name me-pg -e POSTGRES_PASSWORD=pg postgres:17-alpine >/dev/null
for i in $(seq 1 40); do docker exec me-pg pg_isready -U postgres >/dev/null 2>&1 && break; sleep 1; done
sleep 2
run() { docker exec -i -e PGOPTIONS="-c client_min_messages=warning" me-pg psql -U postgres -v ON_ERROR_STOP=1 -q "$@"; }
run < "$S/me01-setup.sql" || { echo "SETUP FAILED"; exit 1; }
for extra in $SETUP_EXTRA; do run < "$extra" || { echo "EXTRA SETUP FAILED: $extra"; exit 1; }; done
run < "$R/supabase/mastery_engine_01_curriculum_and_production.sql" >/dev/null || { echo "MIGRATION FAILED"; exit 1; }
run < "$R/supabase/mastery_engine_01_curriculum_and_production.sql" >/dev/null || { echo "MIGRATION RE-RUN FAILED"; exit 1; }
echo "migration applied twice OK"
run < "$R/supabase/curriculum_physics_energy.sql" | tail -2
for f in "$@"; do
  echo "== $f"
  docker exec -i me-pg psql -U postgres -q < "$f" 2>&1 | grep -E "PASS|FAIL|ERROR" | sed 's/.*NOTICE:  //' | cut -c1-140
done
