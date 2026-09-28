-- Fixes seven live Physics Energy diagnostic questions that the Physics Subject
-- Expert Review Agent rejected (docs/content-qa/calibration-energy-1.md on the
-- Mastery Engine branch). The corrected versions were reviewed again before
-- this file was written (review blocks energy-live-fix-1 and -2; the reviewer
-- also caught all three seeded defects).
--
--   Energy Stores       "which store is largest?" was indefensible (the ball's
--                        thermal store is larger); now asks which store increased
--   Renewable Resources odd-one-out clue; now tests what "renewable" means, with
--                        distractors from real misconceptions
--   Energy Resources    key was longest and absolute words marked the others;
--                        one option did not answer the question; tier Both
--   Efficiency          100 J total made 20 J = 20% guessable; now 12 J of 60 J
--   Power (kettles)     had a second defensible answer; now fixes mass,
--                        temperatures and assumes no losses
--   Elastic PE          demanded recall of a given equation; now prints it
--   Kinetic (tro-tro)   one wrong-answer feedback named momentum (Higher only)
--                        in a both-tier question; tier Both, difficulty 2
--
-- All seven go to 'changes_requested': approved wording can only be changed
-- by a signed-in reviewer, so they leave the diagnostic until you approve them
-- on the review page. Do that straight after running this: while they are
-- out, Physics has 34 of the 36 approved Foundation/Both questions the
-- Foundation option needs, so Physics Foundation is hidden until they are
-- approved. Once all seven are approved, Physics has 41.
--   https://www.inspireacademic.org/teacher/question-review.html
--
-- Each change must match exactly one approved question or nothing is changed.
-- Rollback: diagnostic_questions_energy_fix_rollback.sql
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

do $$
declare n integer;
begin
  -- physics_batch_03#0 (Energy Stores)
  update public.diagnostic_questions
     set question_text = $t$A ball is carried from the bottom of a hill to the top, and then held still. Which of the ball's energy stores has increased?$t$,
         explanation = $t$Lifting an object higher increases its gravitational potential energy store. The energy came from the chemical store of the person who carried it.$t$,
         difficulty = 1,
         tier = $t$Foundation$t$,
         option_a = $t$Kinetic$t$,
         misconception_a = $t$The ball is held still at the top, so its kinetic store is empty. Lifting it filled its gravitational potential store.$t$,
         option_b = $t$Gravitational potential$t$,
         misconception_b = null,
         option_c = $t$Elastic potential$t$,
         misconception_c = $t$Nothing about the ball is stretched or squashed, so its elastic potential store has not changed.$t$,
         option_d = $t$Chemical$t$,
         misconception_d = $t$The chemical store that changed belongs to the person who carried the ball, and it went down. The ball's chemical store did not change.$t$,
         correct_answer = $t$b$t$,
         review_status = 'changes_requested'
   where subject = 'Physics' and question_text = $t$A ball is held still at the top of a hill. Which energy store is largest?$t$ and review_status = 'approved';
  get diagnostics n = row_count;
  if n <> 1 then raise exception 'Expected 1 approved question for physics_batch_03#0 (Energy Stores), found %. Nothing was changed.', n; end if;

  -- physics_batch_03#3 (Renewable Resources)
  update public.diagnostic_questions
     set question_text = $t$Solar power is described as a renewable energy resource. What does "renewable" mean here?$t$,
         explanation = $t$A renewable resource is one that is being (or can be) replenished as it is used. The Sun keeps supplying energy, so solar power is renewable.$t$,
         difficulty = 1,
         tier = $t$Foundation$t$,
         option_a = $t$It releases no carbon dioxide while it works$t$,
         misconception_a = $t$Solar panels do release no carbon dioxide while they work, but that is not what renewable means. Nuclear power releases none either, and it is not renewable.$t$,
         option_b = $t$It is replaced as quickly as it is used$t$,
         misconception_b = null,
         option_c = $t$It is cheap to set up and to run$t$,
         misconception_c = $t$Cost has nothing to do with whether a resource is renewable.$t$,
         option_d = $t$It can supply energy at any time of day$t$,
         misconception_d = $t$Solar panels supply nothing at night, yet solar is still renewable. Renewable is about the resource being replaced, not about reliability.$t$,
         correct_answer = $t$b$t$,
         review_status = 'changes_requested'
   where subject = 'Physics' and question_text = $t$Which of these energy resources is renewable?$t$ and review_status = 'approved';
  get diagnostics n = row_count;
  if n <> 1 then raise exception 'Expected 1 approved question for physics_batch_03#3 (Renewable Resources), found %. Nothing was changed.', n; end if;

  -- physics_batch_03#4 (Energy Resources)
  update public.diagnostic_questions
     set question_text = $t$A village in northern Ghana wants electricity. Why might solar panels be a better choice than a diesel generator?$t$,
         explanation = $t$Northern Ghana gets strong sunshine. Once panels are installed, the energy is free and no fuel is burned, so no carbon dioxide is released while they run.$t$,
         difficulty = 2,
         tier = $t$Both$t$,
         option_a = $t$The panels keep working through the night$t$,
         misconception_a = $t$Solar panels produce nothing at night; batteries are needed to store energy for then.$t$,
         option_b = $t$Sunlight is free and no fuel is burned$t$,
         misconception_b = null,
         option_c = $t$The panels work as well on cloudy days$t$,
         misconception_c = $t$Panels produce much less on cloudy days. Solar is renewable, but it is not always available.$t$,
         option_d = $t$Making the panels causes no pollution$t$,
         misconception_d = $t$Making, transporting and disposing of panels does cause some pollution. Renewable does not mean no environmental impact.$t$,
         correct_answer = $t$b$t$,
         review_status = 'changes_requested'
   where subject = 'Physics' and question_text = $t$A village in northern Ghana wants electricity. Why might solar panels be a better choice than a diesel generator?$t$ and review_status = 'approved';
  get diagnostics n = row_count;
  if n <> 1 then raise exception 'Expected 1 approved question for physics_batch_03#4 (Energy Resources), found %. Nothing was changed.', n; end if;

  -- physics_batch_03#5 (Efficiency)
  update public.diagnostic_questions
     set question_text = $t$A light bulb is supplied with \(60\,\text{J}\) of energy each second. It transfers \(12\,\text{J}\) usefully by light each second. What is its efficiency?$t$,
         explanation = $t$Efficiency \(= \dfrac{\text{useful output}}{\text{total input}} = \dfrac{12}{60} = 0.20 = 20\%\).$t$,
         difficulty = 2,
         tier = $t$Both$t$,
         option_a = $t$\(12\%\)$t$,
         misconception_a = $t$12 J is the useful energy, not the efficiency. Efficiency = useful ÷ total = 12 ÷ 60 = 0.20 = 20%.$t$,
         option_b = $t$\(20\%\)$t$,
         misconception_b = null,
         option_c = $t$\(80\%\)$t$,
         misconception_c = $t$80% is the share that is dissipated to the surroundings. Efficiency is the useful share: 12 ÷ 60 = 20%.$t$,
         option_d = $t$\(500\%\)$t$,
         misconception_d = $t$This divides the total by the useful energy. No device can be more than 100% efficient. Efficiency = 12 ÷ 60 = 20%.$t$,
         correct_answer = $t$b$t$,
         review_status = 'changes_requested'
   where subject = 'Physics' and question_text = $t$A light bulb transfers \(100\,\text{J}\) of energy each second. \(20\,\text{J}\) is transferred as light. What is its efficiency?$t$ and review_status = 'approved';
  get diagnostics n = row_count;
  if n <> 1 then raise exception 'Expected 1 approved question for physics_batch_03#5 (Efficiency), found %. Nothing was changed.', n; end if;

  -- physics_batch_03#6 (Power)
  update public.diagnostic_questions
     set question_text = $t$Kettle A and kettle B each heat \(1.0\,\text{kg}\) of water from \(20\,^{\circ}\text{C}\) to \(100\,^{\circ}\text{C}\). Kettle A takes 2 minutes and kettle B takes 3 minutes. Assume all the energy each kettle transfers goes to the water. Which statement is correct?$t$,
         explanation = $t$Both kettles transfer the same energy to the water (same mass, same temperature rise). Kettle A does it in less time, so its power (energy transferred per second) is greater.$t$,
         difficulty = 2,
         tier = $t$Both$t$,
         option_a = $t$Kettle A has the greater power$t$,
         misconception_a = null,
         option_b = $t$Kettle B has the greater power$t$,
         misconception_b = $t$Kettle B takes longer to transfer the same energy, so its power is lower. Power is energy transferred per second.$t$,
         option_c = $t$Kettle B transfers more energy to the water$t$,
         misconception_c = $t$Both heat the same mass of water through the same temperature rise, so the water gains the same energy. Taking longer does not mean transferring more.$t$,
         option_d = $t$Kettle A transfers more energy to the water$t$,
         misconception_d = $t$The water in each kettle gains the same energy. Kettle A just transfers it faster.$t$,
         correct_answer = $t$a$t$,
         review_status = 'changes_requested'
   where subject = 'Physics' and question_text = $t$Two kettles boil the same amount of water. Kettle A takes 2 minutes and kettle B takes 3 minutes. What does this tell you?$t$ and review_status = 'approved';
  get diagnostics n = row_count;
  if n <> 1 then raise exception 'Expected 1 approved question for physics_batch_03#6 (Power), found %. Nothing was changed.', n; end if;

  -- physics_batch_01#9 (Elastic Potential Energy)
  update public.diagnostic_questions
     set question_text = $t$A spring with spring constant \(100\,\text{N/m}\) is stretched by \(0.10\,\text{m}\), within its limit of proportionality. The elastic potential energy stored is given by \(E_{e} = \tfrac{1}{2}ke^{2}\). How much elastic potential energy does the spring store?$t$,
         explanation = $t$\(E_{e} = \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 100 \times 0.1^{2} = 50 \times 0.01 = 0.5\,\text{J}\).$t$,
         difficulty = 2,
         tier = $t$Both$t$,
         option_a = $t$\(0.5\,\text{J}\)$t$,
         misconception_a = null,
         option_b = $t$\(1\,\text{J}\)$t$,
         misconception_b = $t$This leaves out the half. \(E_{e} = \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 100 \times 0.10^{2} = 0.5\,\text{J}\).$t$,
         option_c = $t$\(5\,\text{J}\)$t$,
         misconception_c = $t$This forgets to square the extension. \(E_{e} = \tfrac{1}{2}ke^{2} = 0.5 \times 100 \times 0.010 = 0.5\,\text{J}\).$t$,
         option_d = $t$\(10\,\text{J}\)$t$,
         misconception_d = $t$\(k \times e\) gives the force in newtons, not the energy. \(E_{e} = \tfrac{1}{2}ke^{2} = 0.5\,\text{J}\).$t$,
         correct_answer = $t$a$t$,
         review_status = 'changes_requested'
   where subject = 'Physics' and question_text = $t$A spring with spring constant \(100\,\text{N/m}\) is stretched by 0.1 m. How much elastic potential energy does it store?$t$ and review_status = 'approved';
  get diagnostics n = row_count;
  if n <> 1 then raise exception 'Expected 1 approved question for physics_batch_01#9 (Elastic Potential Energy), found %. Nothing was changed.', n; end if;

  -- physics_batch_02#0 (Kinetic Energy)
  update public.diagnostic_questions
     set question_text = $t$A tro-tro of mass \(1200\,\text{kg}\) is travelling at \(15\,\text{m/s}\). How much kinetic energy does it have?$t$,
         explanation = $t$\(E_k = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 1200 \times 15^{2} = 0.5 \times 1200 \times 225 = 135\,000\,\text{J}\).$t$,
         difficulty = 2,
         tier = $t$Both$t$,
         answer_spec = $t${"value":135000,"unit":"J","unit_options":["J","W","N","kg m/s"],"wrong":[{"value":9000,"misconception":"This forgets to square the speed. \\(E_k = \\tfrac{1}{2}mv^{2} = \\tfrac{1}{2} \\times 1200 \\times 15^{2} = 135\\,000\\,\\text{J}\\)."},{"value":270000,"misconception":"This forgets the \\(\\tfrac{1}{2}\\): \\(E_k = \\tfrac{1}{2}mv^{2}\\), so halve \\(1200 \\times 225\\) to get \\(135\\,000\\,\\text{J}\\)."},{"value":18000,"misconception":"\\(1200 \\times 15 = 18\\,000\\) leaves out both the \\(\\tfrac{1}{2}\\) and the square on the speed. Kinetic energy is \\(\\tfrac{1}{2}mv^{2} = 135\\,000\\,\\text{J}\\)."}],"unit_feedback":"Kinetic energy is energy, so it is measured in joules (J)."}$t$::jsonb,
         review_status = 'changes_requested'
   where subject = 'Physics' and question_text = $t$A tro-tro of mass \(1200\,\text{kg}\) is travelling at \(15\,\text{m/s}\). How much kinetic energy does it have?$t$ and review_status = 'approved';
  get diagnostics n = row_count;
  if n <> 1 then raise exception 'Expected 1 approved question for physics_batch_02#0 (Kinetic Energy), found %. Nothing was changed.', n; end if;
end $$;

-- Check. Expected: 7 rows, all changes_requested. Approve them on the review page.
select subtopic, tier, difficulty, review_status
  from public.diagnostic_questions
 where subject = 'Physics' and topic = 'Energy Stores & Transfers'
   and review_status = 'changes_requested'
 order by subtopic;
