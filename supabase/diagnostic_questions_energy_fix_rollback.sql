-- Rollback for diagnostic_questions_energy_fix.sql: restores the previous wording,
-- tier and difficulty of the seven Energy questions. All seven stay in
-- 'changes_requested' (only a signed-in reviewer can approve), so re-approve them on
-- the review page afterwards: https://www.inspireacademic.org/teacher/question-review.html
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

begin;

update public.diagnostic_questions
   set question_text = $t$A ball is held still at the top of a hill. Which energy store is largest?$t$,
         explanation = $t$Raised objects store energy in their gravitational potential store. The higher they are, the more they store.$t$,
         difficulty = 1,
         tier = $t$Foundation$t$,
         option_a = $t$Kinetic$t$,
         misconception_a = $t$Kinetic energy is energy of movement; the ball is still, so it has none.$t$,
         option_b = $t$Gravitational potential$t$,
         misconception_b = null,
         option_c = $t$Elastic potential$t$,
         misconception_c = $t$Elastic potential energy is stored in something stretched or squashed, like a spring.$t$,
         option_d = $t$Nuclear$t$,
         misconception_d = $t$Nuclear energy is stored inside atoms; it isn't changed by where the ball is held.$t$,
         correct_answer = $t$b$t$
 where subject = 'Physics' and question_text = $t$A ball is carried from the bottom of a hill to the top, and then held still. Which of the ball's energy stores has increased?$t$;

update public.diagnostic_questions
   set question_text = $t$Which of these energy resources is renewable?$t$,
         explanation = $t$Renewable resources are replaced as they are used. Sunlight keeps arriving, so solar power is renewable.$t$,
         difficulty = 1,
         tier = $t$Foundation$t$,
         option_a = $t$Coal$t$,
         misconception_a = $t$Coal is a fossil fuel; it takes millions of years to form, so it will run out.$t$,
         option_b = $t$Natural gas$t$,
         misconception_b = $t$Natural gas is a fossil fuel and will run out.$t$,
         option_c = $t$Solar$t$,
         misconception_c = null,
         option_d = $t$Oil$t$,
         misconception_d = $t$Oil is a fossil fuel and will run out.$t$,
         correct_answer = $t$c$t$
 where subject = 'Physics' and question_text = $t$Solar power is described as a renewable energy resource. What does "renewable" mean here?$t$;

update public.diagnostic_questions
   set question_text = $t$A village in northern Ghana wants electricity. Why might solar panels be a better choice than a diesel generator?$t$,
         explanation = $t$Northern Ghana gets strong sunshine. Once panels are installed, the energy is free and no carbon dioxide is released while they run.$t$,
         difficulty = 2,
         tier = $t$Foundation$t$,
         option_a = $t$Solar panels work equally well at night$t$,
         misconception_a = $t$Solar panels produce nothing at night; batteries are needed to store energy for then.$t$,
         option_b = $t$Sunlight is free and the panels release no carbon dioxide while working$t$,
         misconception_b = null,
         option_c = $t$Diesel is a renewable fuel$t$,
         misconception_c = $t$Diesel is made from oil, a fossil fuel. It is not renewable.$t$,
         option_d = $t$Solar panels never need any maintenance$t$,
         misconception_d = $t$Panels need cleaning and occasional repair, just less than a generator.$t$,
         correct_answer = $t$b$t$
 where subject = 'Physics' and question_text = $t$A village in northern Ghana wants electricity. Why might solar panels be a better choice than a diesel generator?$t$;

update public.diagnostic_questions
   set question_text = $t$A light bulb transfers \(100\,\text{J}\) of energy each second. \(20\,\text{J}\) is transferred as light. What is its efficiency?$t$,
         explanation = $t$Efficiency \(= \dfrac{\text{useful output}}{\text{total input}} \times 100 = \dfrac{20}{100} \times 100 = 20\%\).$t$,
         difficulty = 3,
         tier = $t$Both$t$,
         option_a = $t$\(80\%\)$t$,
         misconception_a = $t$80% is the share that is wasted as heat. Efficiency is the useful share: 20 ÷ 100 = 20%.$t$,
         option_b = $t$\(20\%\)$t$,
         misconception_b = null,
         option_c = $t$\(5\%\)$t$,
         misconception_c = $t$This divides 100 by 20. Efficiency = useful ÷ total = 20 ÷ 100 = 20%.$t$,
         option_d = $t$\(120\%\)$t$,
         misconception_d = $t$No device can be more than 100% efficient. Efficiency = 20 ÷ 100 = 20%.$t$,
         correct_answer = $t$b$t$
 where subject = 'Physics' and question_text = $t$A light bulb is supplied with \(60\,\text{J}\) of energy each second. It transfers \(12\,\text{J}\) usefully by light each second. What is its efficiency?$t$;

update public.diagnostic_questions
   set question_text = $t$Two kettles boil the same amount of water. Kettle A takes 2 minutes and kettle B takes 3 minutes. What does this tell you?$t$,
         explanation = $t$Power is how fast energy is transferred. Kettle A transfers the same energy in less time, so it has the higher power.$t$,
         difficulty = 4,
         tier = $t$Both$t$,
         option_a = $t$Kettle A has a higher power$t$,
         misconception_a = null,
         option_b = $t$Kettle B has a higher power$t$,
         misconception_b = $t$Taking longer to transfer the same energy means a lower power.$t$,
         option_c = $t$Kettle B transfers more energy in total$t$,
         misconception_c = $t$Both boil the same water, so they transfer about the same useful energy; A just does it faster.$t$,
         option_d = $t$Both kettles have the same power$t$,
         misconception_d = $t$They take different times for the same job, so their powers are different.$t$,
         correct_answer = $t$a$t$
 where subject = 'Physics' and question_text = $t$Kettle A and kettle B each heat \(1.0\,\text{kg}\) of water from \(20\,^{\circ}\text{C}\) to \(100\,^{\circ}\text{C}\). Kettle A takes 2 minutes and kettle B takes 3 minutes. Assume all the energy each kettle transfers goes to the water. Which statement is correct?$t$;

update public.diagnostic_questions
   set question_text = $t$A spring with spring constant \(100\,\text{N/m}\) is stretched by 0.1 m. How much elastic potential energy does it store?$t$,
         explanation = $t$\(E_{e} = \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 100 \times 0.1^{2} = 50 \times 0.01 = 0.5\,\text{J}\).$t$,
         difficulty = 3,
         tier = $t$Higher$t$,
         option_a = $t$\(1\,\text{J}\)$t$,
         misconception_a = $t$This leaves out the half. \(E_{e} = \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 100 \times 0.1^{2} = 0.5\,\text{J}\).$t$,
         option_b = $t$\(5\,\text{J}\)$t$,
         misconception_b = $t$This forgets to square the extension. \(E_{e} = \tfrac{1}{2}ke^{2} = 0.5 \times 100 \times 0.01 = 0.5\,\text{J}\).$t$,
         option_c = $t$\(0.5\,\text{J}\)$t$,
         misconception_c = null,
         option_d = $t$\(10\,\text{J}\)$t$,
         misconception_d = $t$\(k \times e\) gives the force in newtons, not the energy. \(E_{e} = \tfrac{1}{2}ke^{2} = 0.5\,\text{J}\).$t$,
         correct_answer = $t$c$t$
 where subject = 'Physics' and question_text = $t$A spring with spring constant \(100\,\text{N/m}\) is stretched by \(0.10\,\text{m}\), within its limit of proportionality. The elastic potential energy stored is given by \(E_{e} = \tfrac{1}{2}ke^{2}\). How much elastic potential energy does the spring store?$t$;

update public.diagnostic_questions
   set question_text = $t$A tro-tro of mass \(1200\,\text{kg}\) is travelling at \(15\,\text{m/s}\). How much kinetic energy does it have?$t$,
         explanation = $t$\(E_k = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 1200 \times 15^{2} = 0.5 \times 1200 \times 225 = 135\,000\,\text{J}\).$t$,
         difficulty = 3,
         tier = $t$Higher$t$,
         answer_spec = $t${"value":135000,"unit":"J","unit_options":["J","W","N","kg m/s"],"wrong":[{"value":9000,"misconception":"This forgets to square the speed. \\(E_k = \\tfrac{1}{2}mv^{2} = \\tfrac{1}{2} \\times 1200 \\times 15^{2} = 135\\,000\\,\\text{J}\\)."},{"value":270000,"misconception":"This forgets the \\(\\tfrac{1}{2}\\): \\(E_k = \\tfrac{1}{2}mv^{2}\\), so halve \\(1200 \\times 225\\) to get \\(135\\,000\\,\\text{J}\\)."},{"value":18000,"misconception":"\\(1200 \\times 15 = 18\\,000\\) is the momentum (\\(mv\\)). Kinetic energy is \\(\\tfrac{1}{2}mv^{2} = 135\\,000\\,\\text{J}\\)."}],"unit_feedback":"Kinetic energy is energy, so it is measured in joules (J)."}$t$::jsonb
 where subject = 'Physics' and question_text = $t$A tro-tro of mass \(1200\,\text{kg}\) is travelling at \(15\,\text{m/s}\). How much kinetic energy does it have?$t$;

commit;
