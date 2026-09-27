-- Correction to the science quiz typesetting (38 questions, 39 fields).
-- The word "a" before a quantity was typeset as the variable a
-- ("lifting \(a\) \(10\,\text{kg}\) mass"); this puts it back as plain text.
-- Run AFTER quiz_typeset_physics/chemistry/biology.sql. Each UPDATE applies
-- only while the field still holds the typeset text. Rollback:
-- quiz_typeset_article_fix_rollback.sql.

BEGIN;

UPDATE questions SET
  question_text = $t$An impulse of 500 N \(s\) acts on a \(50\,\text{kg}\) object. What is the change in velocity?$t$
WHERE id = 440
  AND question_text = $t$An impulse of 500 N \(s\) acts on \(a\) \(50\,\text{kg}\) object. What is the change in velocity?$t$;

UPDATE questions SET
  question_text = $t$What is the weight of a \(60\,\text{kg}\) person on Earth (\(g = 9.8\,\text{N/kg}\))?$t$
WHERE id = 503
  AND question_text = $t$What is the weight of \(a\) \(60\,\text{kg}\) person on Earth (\(g = 9.8\,\text{N/kg}\))?$t$;

UPDATE questions SET
  question_text = $t$What is the weight of a \(60\,\text{kg}\) person? (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 836
  AND question_text = $t$What is the weight of \(a\) \(60\,\text{kg}\) person? (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A resultant force of 30 N acts on a \(6\,\text{kg}\) object. What is the acceleration?$t$
WHERE id = 2177
  AND question_text = $t$A resultant force of 30 N acts on \(a\) \(6\,\text{kg}\) object. What is the acceleration?$t$;

UPDATE questions SET
  question_text = $t$A 500 N force acts on a \(50\,\text{kg}\) object for 4 seconds from rest. Calculate final velocity.$t$
WHERE id = 2196
  AND question_text = $t$A 500 N force acts on \(a\) \(50\,\text{kg}\) object for 4 seconds from rest. Calculate final velocity.$t$;

UPDATE questions SET
  question_text = $t$Calculate the braking force needed to stop a \(1200\,\text{kg}\) car travelling at \(30\,\text{m/s}\) in 6 seconds.$t$
WHERE id = 2198
  AND question_text = $t$Calculate the braking force needed to stop \(a\) \(1200\,\text{kg}\) car travelling at \(30\,\text{m/s}\) in 6 seconds.$t$;

UPDATE questions SET
  explanation = $t$Mass is the quantitative measure of inertia. A \(10\,\text{kg}\) object needs 10× more force than a \(1\,\text{kg}\) object for the same acceleration.$t$
WHERE id = 2201
  AND explanation = $t$Mass is the quantitative measure of inertia. A \(10\,\text{kg}\) object needs 10× more force than \(a\) \(1\,\text{kg}\) object for the same acceleration.$t$;

UPDATE questions SET
  question_text = $t$Calculate the KE of a \(4\,\text{kg}\) ball moving at \(5\,\text{m/s}\).$t$
WHERE id = 2207
  AND question_text = $t$Calculate the KE of \(a\) \(4\,\text{kg}\) ball moving at \(5\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$A spring stores 80 J of elastic PE. This is entirely converted to KE in a \(0.2\,\text{kg}\) object. Calculate the objects speed.$t$
WHERE id = 2218
  AND question_text = $t$A spring stores 80 J of elastic PE. This is entirely converted to KE in \(a\) \(0.2\,\text{kg}\) object. Calculate the objects speed.$t$;

UPDATE questions SET
  question_text = $t$A student heats a \(1\,\text{kg}\) copper block with a 40 W heater for 5 minutes and records \(a 100^\circ C\) temperature rise. Calculate the specific heat capacity.$t$
WHERE id = 2225
  AND question_text = $t$A student heats \(a\) \(1\,\text{kg}\) copper block with a 40 W heater for 5 minutes and records \(a 100^\circ C\) temperature rise. Calculate the specific heat capacity.$t$;

UPDATE questions SET
  question_text = $t$A student lifts a \(5\,\text{kg}\) book from the floor onto a shelf 1.5 m high and then carries it 3 m horizontally to a second shelf at the same height. Calculate the total work done against gravity during the whole journey. (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 2315
  AND question_text = $t$A student lifts \(a\) \(5\,\text{kg}\) book from the floor onto a shelf 1.5 m high and then carries it 3 m horizontally to a second shelf at the same height. Calculate the total work done against gravity during the whole journey. (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A 30 W electric motor lifts a \(2\,\text{kg}\) mass through 4 m in 5 seconds. Calculate the efficiency of the motor. (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 2317
  AND question_text = $t$A 30 W electric motor lifts \(a\) \(2\,\text{kg}\) mass through 4 m in 5 seconds. Calculate the efficiency of the motor. (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A 90% efficient motor with input power 600 W lifts a \(250\,\text{kg}\) load. Calculate how long it takes to lift the load through 3 m. (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 2414
  AND question_text = $t$A 90% efficient motor with input power 600 W lifts \(a\) \(250\,\text{kg}\) load. Calculate how long it takes to lift the load through 3 m. (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A DC motor operates at 12 V drawing a current of 5 A. The motor drives a load lifting a \(10\,\text{kg}\) mass through 1.5 m in 4 seconds. Calculate the efficiency of the motor. (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 2525
  AND question_text = $t$A DC motor operates at 12 V drawing a current of 5 A. The motor drives a load lifting \(a\) \(10\,\text{kg}\) mass through 1.5 m in 4 seconds. Calculate the efficiency of the motor. (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A spring launcher stores 4.5 J of elastic potential energy and fires a \(0.1\,\text{kg}\) ball vertically upward. Assuming all EPE converts to KE calculate the balls initial speed and maximum height. (\(g = 10\,\text{N/kg}\) ignore air resistance)$t$
WHERE id = 2606
  AND question_text = $t$A spring launcher stores 4.5 J of elastic potential energy and fires \(a\) \(0.1\,\text{kg}\) ball vertically upward. Assuming all EPE converts to KE calculate the balls initial speed and maximum height. (\(g = 10\,\text{N/kg}\) ignore air resistance)$t$;

UPDATE questions SET
  question_text = $t$An electric motor of efficiency 80% has an input power of 500 W. It lifts a \(40\,\text{kg}\) mass. Calculate the speed at which it lifts the mass. (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 3335
  AND question_text = $t$An electric motor of efficiency 80% has an input power of 500 W. It lifts \(a\) \(40\,\text{kg}\) mass. Calculate the speed at which it lifts the mass. (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A resultant force of 500 N acts on a \(25\,\text{kg}\) object for 4 seconds, starting from rest. Calculate the final velocity of the object.$t$
WHERE id = 3392
  AND question_text = $t$A resultant force of 500 N acts on \(a\) \(25\,\text{kg}\) object for 4 seconds, starting from rest. Calculate the final velocity of the object.$t$;

UPDATE questions SET
  explanation = $t$The unit of force is the Newton (N). One Newton is the force needed to accelerate a \(1\,\text{kg}\) mass at \(1\,\text{m/s}^{2}\). Other units: speed in m/s, energy in Joules (J), power in Watts (W), pressure in Pascals (Pa). Learning the correct unit for each quantity is essential.$t$
WHERE id = 3582
  AND explanation = $t$The unit of force is the Newton (N). One Newton is the force needed to accelerate \(a\) \(1\,\text{kg}\) mass at \(1\,\text{m/s}^{2}\). Other units: speed in m/s, energy in Joules (J), power in Watts (W), pressure in Pascals (Pa). Learning the correct unit for each quantity is essential.$t$;

UPDATE questions SET
  explanation = $t$Impulse = force × time = area of the force-time graph. Rectangle: \(500 \times 0.04 = 20\,\text{N}\ s\). The area under any force-time graph gives impulse regardless of shape. Impulse = change in momentum. Velocity change = impulse/mass \(= \frac{20}{m}\). For a \(2\,\text{kg}\) object: Δ\(v = 10\,\text{m/s}\).$t$
WHERE id = 3776
  AND explanation = $t$Impulse = force × time = area of the force-time graph. Rectangle: \(500 \times 0.04 = 20\,\text{N}\ s\). The area under any force-time graph gives impulse regardless of shape. Impulse = change in momentum. Velocity change = impulse/mass \(= \frac{20}{m}\). For \(a\) \(2\,\text{kg}\) object: Δ\(v = 10\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$A spring (\(k = 250\,\text{N/m}\)) is compressed 0.06 m and launches a \(0.05\,\text{kg}\) ball vertically. Calculate the maximum height. (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 3800
  AND question_text = $t$A spring (\(k = 250\,\text{N/m}\)) is compressed 0.06 m and launches \(a\) \(0.05\,\text{kg}\) ball vertically. Calculate the maximum height. (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A crane jib is 8 m long at \(60^\circ\) to the vertical, lifting a \(2000\,\text{kg}\) load. Calculate the moment about the base. (\(g = 10\,\text{N/kg}\); \(\sin 60^\circ = 0.87\), \(\cos 60^\circ = 0.5\))$t$
WHERE id = 3808
  AND question_text = $t$A crane jib is 8 m long at \(60^\circ\) to the vertical, lifting \(a\) \(2000\,\text{kg}\) load. Calculate the moment about the base. (\(g = 10\,\text{N/kg}\); \(\sin 60^\circ = 0.87\), \(\cos 60^\circ = 0.5\))$t$;

UPDATE questions SET
  question_text = $t$What is the gravitational potential energy of a \(5\,\text{kg}\) object raised 4 m? (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 4491
  AND question_text = $t$What is the gravitational potential energy of \(a\) \(5\,\text{kg}\) object raised 4 m? (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$Calculate the kinetic energy of a \(2\,\text{kg}\) ball moving at \(6\,\text{m/s}\).$t$
WHERE id = 4492
  AND question_text = $t$Calculate the kinetic energy of \(a\) \(2\,\text{kg}\) ball moving at \(6\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$Calculate the specific heat capacity of a \(2\,\text{kg}\) metal block heated from \(20^\circ C\) to \(70^\circ C\) using 18 000 J.$t$
WHERE id = 4532
  AND question_text = $t$Calculate the specific heat capacity of \(a\) \(2\,\text{kg}\) metal block heated from \(20^\circ C\) to \(70^\circ C\) using 18 000 J.$t$;

UPDATE questions SET
  question_text = $t$A crane lifts a \(200\,\text{kg}\) load 8 m in 10 seconds. Calculate the useful power output of the crane. (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 4538
  AND question_text = $t$A crane lifts \(a\) \(200\,\text{kg}\) load 8 m in 10 seconds. Calculate the useful power output of the crane. (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A 1200 W motor lifts a \(60\,\text{kg}\) load. How high can it lift the load in 10 seconds, assuming 100% efficiency? (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 4568
  AND question_text = $t$A 1200 W motor lifts \(a\) \(60\,\text{kg}\) load. How high can it lift the load in 10 seconds, assuming 100% efficiency? (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$Calculate the gravitational potential energy of a \(2\,\text{kg}\) object raised 5 m (\(g = 10\,\text{N/kg}\)).$t$
WHERE id = 4592
  AND question_text = $t$Calculate the gravitational potential energy of \(a\) \(2\,\text{kg}\) object raised 5 m (\(g = 10\,\text{N/kg}\)).$t$;

UPDATE questions SET
  question_text = $t$A person lifts a \(10\,\text{kg}\) box 2 m above the floor (\(g = 10\,\text{N/kg}\)). How much work do they do against gravity?$t$
WHERE id = 4625
  AND question_text = $t$A person lifts \(a\) \(10\,\text{kg}\) box 2 m above the floor (\(g = 10\,\text{N/kg}\)). How much work do they do against gravity?$t$;

UPDATE questions SET
  question_text = $t$A spring (\(k = 400\,\text{N/m}\)) is compressed by 0.15 m and launches a \(0.3\,\text{kg}\) ball vertically. Assuming all EPE converts to GPE, how high does the ball rise? (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 4653
  AND question_text = $t$A spring (\(k = 400\,\text{N/m}\)) is compressed by 0.15 m and launches \(a\) \(0.3\,\text{kg}\) ball vertically. Assuming all EPE converts to GPE, how high does the ball rise? (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A crane lifts a \(2000\,\text{kg}\) load at constant speed of \(0.5\,\text{m/s}\). What power does the crane develop? (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 4681
  AND question_text = $t$A crane lifts \(a\) \(2000\,\text{kg}\) load at constant speed of \(0.5\,\text{m/s}\). What power does the crane develop? (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$Using \(v^{2} = u^{2} + 2as\), a \(0.1\,\text{kg}\) ball decelerates from \(20\,\text{m/s}\) to rest over 0.5 m. What is the average braking force?$t$
WHERE id = 4689
  AND question_text = $t$Using \(v^{2} = u^{2} + 2as\), \(a\) \(0.1\,\text{kg}\) ball decelerates from \(20\,\text{m/s}\) to rest over 0.5 m. What is the average braking force?$t$;

UPDATE questions SET
  question_text = $t$A spring (\(k = 500\,\text{N/m}\)) is extended 0.08 m. It launches a \(0.2\,\text{kg}\) ball horizontally from a table 1.25 m high. How far horizontally does the ball travel? (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 4700
  AND question_text = $t$A spring (\(k = 500\,\text{N/m}\)) is extended 0.08 m. It launches \(a\) \(0.2\,\text{kg}\) ball horizontally from a table 1.25 m high. How far horizontally does the ball travel? (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$Two springs in parallel (each \(k = 300\,\text{N/m}\)) support a \(12\,\text{kg}\) load. Calculate the extension. (\(g = 10\,\text{N/kg}\))$t$
WHERE id = 4701
  AND question_text = $t$Two springs in parallel (each \(k = 300\,\text{N/m}\)) support \(a\) \(12\,\text{kg}\) load. Calculate the extension. (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  option_b = $t$HBr adds to propene with equal probability at both ends of the double bond giving a \(50 : 50\) mixture$t$
WHERE id = 3086
  AND option_b = $t$HBr adds to propene with equal probability at both ends of the double bond giving \(a\) \(50 : 50\) mixture$t$;

UPDATE questions SET
  option_b = $t$Chlorine exists as two isotopes, Cl- 35 and Cl\(- 37\), in roughly a \(3 : 1\) ratio; the relative atomic mass is the weighted average of their masses$t$
WHERE id = 3511
  AND option_b = $t$Chlorine exists as two isotopes, Cl- 35 and Cl\(- 37\), in roughly \(a\) \(3 : 1\) ratio; the relative atomic mass is the weighted average of their masses$t$;

UPDATE questions SET
  explanation = $t$Electrolysis of dilute H₂SO₄: cathode — 2H⁺ + 2e⁻ → H₂ (hydrogen); anode — 2H₂O → O₂ + 4H⁺ + 4e⁻ (oxygen). H₂ is produced at the cathode and O₂ at the anode in a \(2 : 1\) volume ratio. These are the products of water electrolysis.$t$
WHERE id = 3518
  AND explanation = $t$Electrolysis of dilute H₂SO₄: cathode — 2H⁺ + 2e⁻ → H₂ (hydrogen); anode — 2H₂O → O₂ + 4H⁺ + 4e⁻ (oxygen). H₂ is produced at the cathode and O₂ at the anode in \(a\) \(2 : 1\) volume ratio. These are the products of water electrolysis.$t$;

UPDATE questions SET
  question_text = $t$A student finds that the mass of a potato cylinder increases by 12% when placed in a \(0.1\,\text{mol/dm}^{3}\) sucrose solution. What can be concluded?$t$
WHERE id = 1222
  AND question_text = $t$A student finds that the mass of a potato cylinder increases by 12% when placed in \(a\) \(0.1\,\text{mol/dm}^{3}\) sucrose solution. What can be concluded?$t$;

UPDATE questions SET
  question_text = $t$A recessive lethal allele causes yellow coat in heterozygous mice but death in utero when homozygous. Explain why a cross between two yellow mice gives a \(1 : 2\) ratio of agouti to yellow offspring instead of \(3 : 1\).$t$,
  option_b = $t$The cross between yellow heterozygotes \((A^{y} A \times A^{y} A)\) would normally give \(1 : 2 : 1\). However the \(A^{y} A^{y}\) homozygous genotype is lethal — these embryos die in utero. Of surviving offspring: 1 AA (agouti) : \(2 \text{A}^{y} A\) (yellow) — a \(1 : 2\) ratio. The expected \(3 : 1\) is modified because one phenotype class is lethal.$t$
WHERE id = 2710
  AND question_text = $t$A recessive lethal allele causes yellow coat in heterozygous mice but death in utero when homozygous. Explain why a cross between two yellow mice gives \(a\) \(1 : 2\) ratio of agouti to yellow offspring instead of \(3 : 1\).$t$
  AND option_b = $t$The cross between yellow heterozygotes \((A^{y} A \times A^{y} A)\) would normally give \(1 : 2 : 1\). However the \(A^{y} A^{y}\) homozygous genotype is lethal — these embryos die in utero. Of surviving offspring: 1 AA (agouti) : \(2 \text{A}^{y} A\) (yellow) — \(a\) \(1 : 2\) ratio. The expected \(3 : 1\) is modified because one phenotype class is lethal.$t$;

COMMIT;

-- Check: expect 0 (no question in this file still has the article as maths).
SELECT count(*) AS still_wrong FROM questions
 WHERE id IN (440,503,836,2177,2196,2198,2201,2207,2218,2225,2315,2317,2414,2525,2606,3335,3392,3582,3776,3800,3808,4491,4492,4532,4538,4568,4592,4625,4653,4681,4689,4700,4701,3086,3511,3518,1222,2710)
   AND concat_ws(' ', question_text, option_a, option_b, option_c, option_d, explanation) ~ '\\\(a\\\) ';
