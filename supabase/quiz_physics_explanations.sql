-- Explanations for 66 Physics quiz questions that had none (2026-09-27).
-- Students saw nothing after answering these. Each is a short worked answer
-- (calculations typeset like the rest of the bank). Also fixes option B of
-- question 3324, which was ten times too big. Each UPDATE only fills an
-- explanation that is still empty. Rollback: quiz_physics_explanations_rollback.sql
--
-- Run in the LIVE project only:
-- https://supabase.com/dashboard/project/ygtsrdwoikqnrbexjrtl/sql/new

BEGIN;

UPDATE questions SET
  explanation = $t$Work done \(= F \times d = 40 \times 5 = 200\,\text{J}\).$t$
WHERE id = 3315
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Kinetic energy \(= \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 1200 \times 20^{2} = 240\,000\,\text{J}\). Square the speed before multiplying.$t$
WHERE id = 3316
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Gravitational potential energy \(= mgh = 5 \times 10 \times 8 = 400\,\text{J}\).$t$
WHERE id = 3317
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Energy \(= P \times t = 500 \times 30 = 15\,000\,\text{J}\).$t$
WHERE id = 3318
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Efficiency \(= \dfrac{\text{useful output}}{\text{total input}} \times 100\% = \dfrac{600}{800} \times 100\% = 75\%\). Efficiency can never be more than 100%.$t$
WHERE id = 3319
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Hooke's law: \(F = ke = 250 \times 0.12 = 30\,\text{N}\).$t$
WHERE id = 3320
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$A star like the Sun forms from a nebula, spends most of its life on the main sequence, swells into a red giant, then sheds its outer layers and leaves a white dwarf, which cools to a black dwarf. Only much more massive stars end in a supernova, neutron star or black hole.$t$
WHERE id = 3321
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$In a main sequence star, hydrogen nuclei fuse to form helium, releasing energy. Fission splits heavy nuclei (as in power stations), and helium fusion only starts later, in red giants.$t$
WHERE id = 3322
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$The cosmic microwave background is radiation left over from the early universe, stretched to microwave wavelengths as the universe expanded. It is found in every direction, which is strong evidence that the universe was once very hot and dense — the Big Bang.$t$
WHERE id = 3323
  AND explanation IS NULL;

-- 3324: d = 2.1 × 10⁶ ÷ 2.2 × 10⁻¹⁸ = 9.5 × 10²³ m; the keyed option B said 9.5 × 10²⁴ m (ten times too big).
UPDATE questions SET
  explanation = $t$Hubble's law: \(v = H_{0}d\), so \(d = \dfrac{v}{H_{0}} = \dfrac{2.1 \times 10^{6}}{2.2 \times 10^{-18}} = 9.5 \times 10^{23}\,\text{m}\).$t$,
  option_b = $t$\(9.5 \times 10^{23}\,\text{m}\)$t$
WHERE id = 3324
  AND explanation IS NULL
  AND option_b = $t$\(9.5 \times 10^{24}\,\text{m}\)$t$;

UPDATE questions SET
  explanation = $t$A nebula is a cloud of gas (mainly hydrogen) and dust. Gravity pulls it together; as it collapses it heats up and forms a protostar, which becomes a star once fusion begins.$t$
WHERE id = 3325
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Work done = force × distance moved in the direction of the force, measured in joules. "Mass × acceleration" is the formula for force.$t$
WHERE id = 3326
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Work done \(= F \times d = 30 \times 4 = 120\,\text{J}\).$t$
WHERE id = 3327
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Power is the rate at which energy is transferred or work is done: power = energy ÷ time, measured in watts (1 W = 1 J/s).$t$
WHERE id = 3328
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Power \(= \dfrac{\text{work done}}{\text{time}} = \dfrac{600}{20} = 30\,\text{W}\).$t$
WHERE id = 3329
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Gravitational potential energy \(= mgh = 4 \times 10 \times 3 = 120\,\text{J}\).$t$
WHERE id = 3330
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$The joule (J) is the unit of energy. The watt is the unit of power, the newton of force and the pascal of pressure.$t$
WHERE id = 3331
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Elastic potential energy \(= \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 400 \times 0.06^{2} = 0.72\,\text{J}\). Square the compression first.$t$
WHERE id = 3333
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Kinetic energy lost \(= \tfrac{1}{2}m(u^{2} - v^{2}) = \tfrac{1}{2} \times 1200 \times (30^{2} - 10^{2}) = 600 \times 800 = 480\,000\,\text{J}\). Work out each kinetic energy — don't square the change in speed.$t$
WHERE id = 3334
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Useful power \(= 0.8 \times 500 = 400\,\text{W}\). Lifting at a steady speed, power \(= Fv = mgv\), so \(v = \dfrac{400}{40 \times 10} = 1.0\,\text{m/s}\).$t$
WHERE id = 3335
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Gravitational potential energy lost \(=\) kinetic energy gained: \(mgh = \tfrac{1}{2}mv^{2}\), so \(v = \sqrt{2gh} = \sqrt{2 \times 10 \times 0.45} = 3.0\,\text{m/s}\). The mass cancels.$t$
WHERE id = 3336
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Acceleration \(a = \dfrac{20 - 8}{6} = 2\,\text{m/s}^{2}\). Resultant force \(F = ma = 1400 \times 2 = 2800\,\text{N}\).$t$
WHERE id = 3337
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Impulse \(= F \times t = 120 \times 0.05 = 6\,\text{N s}\) = change in momentum. \(v = \dfrac{6}{0.5} = 12\,\text{m/s}\).$t$
WHERE id = 3338
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Resultant force \(= 15 - 6 = 9\,\text{N}\) to the right. \(a = \dfrac{F}{m} = \dfrac{9}{3} = 3\,\text{m/s}^{2}\).$t$
WHERE id = 3340
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Weight \(= 2000 \times 10 = 20\,000\,\text{N}\). Resultant force \(= 28\,000 - 20\,000 = 8000\,\text{N}\) upwards, so \(a = \dfrac{8000}{2000} = 4\,\text{m/s}^{2}\). Use the resultant force, not the thrust alone.$t$
WHERE id = 3341
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$As the skydiver speeds up, air resistance increases. When it equals their weight the resultant force is zero, so they stop accelerating and fall at a steady terminal velocity. Weight and gravity stay the same.$t$
WHERE id = 3342
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Pressure \(= \dfrac{F}{A} = \dfrac{500}{0.02} = 25\,000\,\text{Pa}\). In a hydraulic system this pressure is transmitted equally through the fluid.$t$
WHERE id = 3343
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$From rest, \(s = \tfrac{1}{2}gt^{2} = \tfrac{1}{2} \times 10 \times 3.5^{2} = 61.25\,\text{m}\).$t$
WHERE id = 3344
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Kinetic energy \(= \tfrac{1}{2} \times 1200 \times 25^{2} = 375\,000\,\text{J}\). The brakes do this much work: \(F \times d = 375\,000\), so \(d = \dfrac{375\,000}{6000} = 62.5\,\text{m}\).$t$
WHERE id = 3345
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Momentum is conserved: \(4 \times 6 + 2 \times 0 = (4 + 2)v\), so \(v = \dfrac{24}{6} = 4\,\text{m/s}\).$t$
WHERE id = 3346
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Energy gained \(= mgh = 500 \times 10 \times 12 = 60\,000\,\text{J}\). Power \(= \dfrac{60\,000}{30} = 2000\,\text{W}\).$t$
WHERE id = 3347
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$35% is useful, so 65% is wasted: \(0.65 \times 2400 = 1560\,\text{J}\). (The useful energy is \(0.35 \times 2400 = 840\,\text{J}\).)$t$
WHERE id = 3348
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$\(P = IV\), so \(I = \dfrac{P}{V} = \dfrac{8500}{230} \approx 37\,\text{A}\). Convert kW to W first.$t$
WHERE id = 3349
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$In series the resistances add: \(6 + 12 + 4 = 22\,\Omega\). \(I = \dfrac{V}{R} = \dfrac{44}{22} = 2\,\text{A}\).$t$
WHERE id = 3350
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$In parallel: \(\dfrac{1}{R} = \dfrac{1}{40} + \dfrac{1}{60} = \dfrac{3 + 2}{120} = \dfrac{5}{120}\), so \(R = 24\,\Omega\). The combined resistance is always less than the smallest resistor.$t$
WHERE id = 3351
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$3 minutes \(= 180\,\text{s}\). Power \(= \dfrac{360\,000}{180} = 2000\,\text{W}\).$t$
WHERE id = 3352
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Current \(I = \dfrac{Q}{t} = \dfrac{180}{60} = 3\,\text{A}\). Power \(P = IV = 3 \times 12 = 36\,\text{W}\).$t$
WHERE id = 3353
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Total resistance \(= 10 + 2 = 12\,\Omega\), so \(I = \dfrac{12}{12} = 1\,\text{A}\). Terminal voltage \(=\) voltage across the external resistor \(= 1 \times 10 = 10\,\text{V}\); the other 2 V is lost inside the battery.$t$
WHERE id = 3354
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$A straight line through the origin means current is directly proportional to voltage, so the resistance is constant: the first component obeys Ohm's law. A curved line means its resistance changes (for example as it heats up), so the second does not.$t$
WHERE id = 3356
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$\(\lambda = \dfrac{v}{f} = \dfrac{3 \times 10^{8}}{2.5 \times 10^{8}} = 1.2\,\text{m}\).$t$
WHERE id = 3357
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$The frequency stays the same when a wave changes medium. \(\lambda = \dfrac{v}{f} = \dfrac{1480}{500} = 2.96\,\text{m}\).$t$
WHERE id = 3358
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Going from glass into air: \(1.5 \times \sin 30^\circ = 1.0 \times \sin r\), so \(\sin r = 0.75\) and \(r = 48.6^\circ\). The light bends away from the normal as it speeds up.$t$
WHERE id = 3359
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$The angle of incidence (\(45^\circ\)) is greater than the critical angle (\(42^\circ\)), so none of the light escapes: it is totally internally reflected.$t$
WHERE id = 3360
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Distance travelled \(= 1500 \times 0.00004 = 0.06\,\text{m}\). That is there and back, so the boundary is \(\dfrac{0.06}{2} = 0.03\,\text{m}\) deep.$t$
WHERE id = 3361
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$X-rays have a much higher frequency than radio waves, so each photon carries much more energy — enough to ionise atoms and damage DNA, which can cause cancer. All electromagnetic waves travel at the same speed and are transverse.$t$
WHERE id = 3362
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$On a string the fundamental wavelength is twice the length. Doubling the length doubles the wavelength; the wave speed is the same, so the frequency halves.$t$
WHERE id = 3363
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$\(v = f\lambda = 240 \times 0.6 = 144\,\text{m/s}\).$t$
WHERE id = 3364
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$The infrared light hits the inside of the fibre at more than the critical angle, so it is totally internally reflected and stays in the fibre all the way along.$t$
WHERE id = 3365
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$\(f = \dfrac{1}{T} = \dfrac{1}{4 \times 10^{-3}} = 250\,\text{Hz}\).$t$
WHERE id = 3366
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Secondary voltage \(= 240 \times \dfrac{50}{800} = 15\,\text{V}\). At 100% efficiency power in = power out: \(240 \times I_{p} = 15 \times 16\), so \(I_{p} = \dfrac{240}{240} = 1\,\text{A}\).$t$
WHERE id = 3367
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Alpha decay removes 2 protons and 2 neutrons: the mass number falls by 4 and the atomic number by 2. \({}^{238}_{92}\text{U} \to {}^{234}_{90}\text{Th} + {}^{4}_{2}\text{He}\).$t$
WHERE id = 3368
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$At constant volume, pressure is proportional to kelvin temperature: \(p_{2} = 1.5 \times 10^{5} \times \dfrac{450}{300} = 2.25 \times 10^{5}\,\text{Pa}\).$t$
WHERE id = 3370
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$\(E = mc\Delta T = 3 \times 385 \times (120 - 20) = 115\,500\,\text{J}\). Use the temperature change, not the final temperature.$t$
WHERE id = 3371
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$\(F = BIL = 0.6 \times 4 \times 0.25 = 0.6\,\text{N}\).$t$
WHERE id = 3372
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Melting: \(mL = 0.2 \times 334\,000 = 66\,800\,\text{J}\). Heating the water: \(mc\Delta T = 0.2 \times 4200 \times 50 = 42\,000\,\text{J}\). Total \(= 108\,800\,\text{J}\). Include both stages.$t$
WHERE id = 3373
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$In beta-minus decay a neutron in the nucleus changes into a proton and an electron, and the electron is emitted at high speed. The atomic number goes up by 1; the mass number stays the same.$t$
WHERE id = 3374
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$The split-ring commutator reverses the current in the coil every half turn, so the force keeps turning it the same way. With slip rings the current would not reverse, so the coil would be pushed back every half turn and just rock back and forth instead of spinning.$t$
WHERE id = 3375
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Doubling the density at the same temperature means twice as many particles in each unit of volume, so twice as many collisions with the walls each second: the pressure doubles.$t$
WHERE id = 3376
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Kinetic energy \(= \tfrac{1}{2} \times 80 \times 12^{2} = 5760\,\text{J}\). Work done by the brakes: \(F \times 18 = 5760\), so \(F = 320\,\text{N}\).$t$
WHERE id = 3377
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Efficiency \(= \dfrac{\text{output}}{\text{input}}\), so input \(= \dfrac{600}{0.30} = 2000\,\text{MW}\).$t$
WHERE id = 3378
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$\(n = \dfrac{1}{\sin c} = \dfrac{1}{0.656} = 1.52\).$t$
WHERE id = 3379
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$\(E = \dfrac{V}{d} = \dfrac{800}{0.04} = 20\,000\,\text{V/m}\).$t$
WHERE id = 3380
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Energy gained \(= QV = 1.6 \times 10^{-19} \times 5000 = 8 \times 10^{-16}\,\text{J}\).$t$
WHERE id = 3381
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Elastic potential energy \(= \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 200 \times 0.1^{2} = 1\,\text{J}\). The mass does not affect the energy stored.$t$
WHERE id = 3383
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$As the filament heats up, its metal ions vibrate more, so the electrons flowing through collide with them more often. That makes it harder for current to flow: the resistance rises.$t$
WHERE id = 3384
  AND explanation IS NULL;

UPDATE questions SET
  explanation = $t$Power in \(= 11\,000 \times 2 = 22\,000\,\text{W}\). Power out \(= 0.95 \times 22\,000 = 20\,900\,\text{W}\). Secondary current \(= \dfrac{20\,900}{400} = 52.25\,\text{A}\).$t$
WHERE id = 3386
  AND explanation IS NULL;

COMMIT;

-- Check: expect 0 (Physics quiz questions still without an explanation).
SELECT count(*) AS still_missing FROM questions WHERE id IN (3315,3316,3317,3318,3319,3320,3321,3322,3323,3324,3325,3326,3327,3328,3329,3330,3331,3333,3334,3335,3336,3337,3338,3340,3341,3342,3343,3344,3345,3346,3347,3348,3349,3350,3351,3352,3353,3354,3356,3357,3358,3359,3360,3361,3362,3363,3364,3365,3366,3367,3368,3370,3371,3372,3373,3374,3375,3376,3377,3378,3379,3380,3381,3383,3384,3386) AND (explanation IS NULL OR btrim(explanation) = '');
