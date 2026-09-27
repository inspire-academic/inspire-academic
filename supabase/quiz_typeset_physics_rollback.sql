-- Rollback for quiz_typeset_physics.sql: restores the plain-text maths exactly as it
-- was on 2026-09-27. Each UPDATE applies only to a row still holding the typeset text.

BEGIN;

UPDATE questions SET
  question_text = $t$A car of mass 1200 kg accelerates from rest to 24 m/s in 8 s. Calculate the resultant force.$t$,
  explanation = $t$F = ma. a = Δv/t = 24/8 = 3 m/s². F = 1200 × 3 = 3600 N.$t$
WHERE id = 11
  AND question_text = $t$A car of mass \(1200\,\text{kg}\) accelerates from rest to \(24\,\text{m/s}\) in 8 s. Calculate the resultant force.$t$
  AND explanation = $t$\(F = ma\). \(a\)= Δ\(\frac{v}{t} = \frac{24}{8} = 3\,\text{m/s}^{2}\). \(F = 1200 \times 3 = 3600\,\text{N}\).$t$;

UPDATE questions SET
  explanation = $t$At terminal velocity, resultant force = 0. Weight downwards equals air resistance upwards — they are balanced.$t$
WHERE id = 12
  AND explanation = $t$At terminal velocity, resultant force \(= 0\). Weight downwards equals air resistance upwards — they are balanced.$t$;

UPDATE questions SET
  question_text = $t$A ball of mass 0.5 kg is dropped from rest and falls 5 m. Using g = 10 N/kg, calculate its speed just before hitting the ground.$t$,
  option_a = $t$5 m/s$t$,
  option_b = $t$10 m/s$t$,
  option_c = $t$7.07 m/s$t$,
  option_d = $t$25 m/s$t$,
  explanation = $t$Use energy: mgh = ½mv². v² = 2gh = 2 × 10 × 5 = 100. v = 10 m/s.$t$
WHERE id = 14
  AND question_text = $t$A ball of mass \(0.5\,\text{kg}\) is dropped from rest and falls 5 m. Using \(g = 10\,\text{N/kg}\), calculate its speed just before hitting the ground.$t$
  AND option_a = $t$\(5\,\text{m/s}\)$t$
  AND option_b = $t$\(10\,\text{m/s}\)$t$
  AND option_c = $t$\(7.07\,\text{m/s}\)$t$
  AND option_d = $t$\(25\,\text{m/s}\)$t$
  AND explanation = $t$Use energy: \(mgh = \tfrac{1}{2}mv^{2}\). \(v^{2} = 2gh = 2 \times 10 \times 5 = 100\). \(v = 10\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$A 60 kg person stands on scales in a lift accelerating upward at 2 m/s². What do the scales read? (g = 10 N/kg)$t$,
  explanation = $t$The scales read the normal reaction force. F_net = ma → N − W = ma → N = m(g+a) = 60(10+2) = 720 N.$t$
WHERE id = 16
  AND question_text = $t$A \(60\,\text{kg}\) person stands on scales in a lift accelerating upward at \(2\,\text{m/s}^{2}\). What do the scales read? (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$The scales read the normal reaction force. F_\(net = ma \to N - W = ma \to N = m(g + a) = 60(10 + 2) = 720 N\).$t$;

UPDATE questions SET
  question_text = $t$A force of 400 N acts on an area of 0.08 m². Calculate the pressure.$t$,
  explanation = $t$p = F/A = 400 / 0.08 = 5000 Pa.$t$
WHERE id = 17
  AND question_text = $t$A force of 400 N acts on an area of \(0.08 m^{2}\). Calculate the pressure.$t$
  AND explanation = $t$\(p = \frac{F}{A} = \frac{400}{0.08} = 5000\,\text{Pa}\).$t$;

UPDATE questions SET
  question_text = $t$A car travelling at 20 m/s brakes to a stop in 4 s. The car has mass 900 kg. Calculate the braking force.$t$,
  explanation = $t$a = Δv/t = 20/4 = 5 m/s². F = ma = 900 × 5 = 4500 N.$t$
WHERE id = 18
  AND question_text = $t$A car travelling at \(20\,\text{m/s}\) brakes to a stop in 4 s. The car has mass 900 kg. Calculate the braking force.$t$
  AND explanation = $t$\(a\)= Δ\(\frac{v}{t} = \frac{20}{4} = 5\,\text{m/s}^{2}\). \(F = ma = 900 \times 5 = 4500\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$A 2 kg ball moving at 6 m/s collides with a stationary 4 kg ball. After the collision they stick together. What is their velocity? [Higher only]$t$,
  option_a = $t$2 m/s$t$,
  option_b = $t$6 m/s$t$,
  option_c = $t$3 m/s$t$,
  option_d = $t$4 m/s$t$,
  explanation = $t$Momentum conservation: p_before = 2×6 = 12 kg⋅m/s. p_after = (2+4)×v. v = 12/6 = 2 m/s.$t$
WHERE id = 19
  AND question_text = $t$A \(2\,\text{kg}\) ball moving at \(6\,\text{m/s}\) collides with a stationary \(4\,\text{kg}\) ball. After the collision they stick together. What is their velocity? [Higher only]$t$
  AND option_a = $t$\(2\,\text{m/s}\)$t$
  AND option_b = $t$\(6\,\text{m/s}\)$t$
  AND option_c = $t$\(3\,\text{m/s}\)$t$
  AND option_d = $t$\(4\,\text{m/s}\)$t$
  AND explanation = $t$Momentum conservation: \(p\)_before \(= 2 \times 6 = 12\,\text{kg}\)⋅m/s. \(p\)_after \(= (2 + 4) \times v\). \(v = \frac{12}{6} = 2\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$A ball of mass 2 kg moves at 5 m/s. Calculate its kinetic energy.$t$,
  explanation = $t$Ek = ½mv² = ½ × 2 × 5² = ½ × 2 × 25 = 25 J.$t$
WHERE id = 81
  AND question_text = $t$A ball of mass \(2\,\text{kg}\) moves at \(5\,\text{m/s}\). Calculate its kinetic energy.$t$
  AND explanation = $t$Ek \(= \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 2 \times 5^{2} = \tfrac{1}{2} \times 2 \times 25 = 25\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$A 50 kg student climbs 3 m. Using g = 9.8 N/kg, calculate the gain in GPE.$t$,
  explanation = $t$Ep = mgh = 50 × 9.8 × 3 = 1470 J.$t$
WHERE id = 83
  AND question_text = $t$A \(50\,\text{kg}\) student climbs 3 m. Using \(g = 9.8\,\text{N/kg}\), calculate the gain in GPE.$t$
  AND explanation = $t$Ep \(= mgh = 50 \times 9.8 \times 3 = 1470\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$P = E/t = 6000 / 120 = 50 W. (2 minutes = 120 seconds)$t$
WHERE id = 84
  AND explanation = $t$\(P = \frac{E}{t} = \frac{6000}{120} = 50\,\text{W}\). (2 minutes \(= 120\) seconds)$t$;

UPDATE questions SET
  explanation = $t$Efficiency = useful output / total input = 30/40 = 0.75 = 75%.$t$
WHERE id = 85
  AND explanation = $t$Efficiency = useful output / total input \(= \frac{30}{40} = 0.75 = 75\%\).$t$;

UPDATE questions SET
  question_text = $t$A spring has spring constant k = 200 N/m and is compressed by 0.1 m. Calculate the elastic PE stored.$t$,
  explanation = $t$Ee = ½ke² = ½ × 200 × 0.1² = ½ × 200 × 0.01 = 1 J.$t$
WHERE id = 88
  AND question_text = $t$A spring has spring constant \(k = 200\,\text{N/m}\) and is compressed by 0.1 m. Calculate the elastic PE stored.$t$
  AND explanation = $t$Ee \(= \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 200 \times 0.1^{2} = \tfrac{1}{2} \times 200 \times 0.01 = 1\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$A car engine outputs 15 kW at a speed of 30 m/s. What is the driving force?$t$,
  explanation = $t$P = Fv → F = P/v = 15000/30 = 500 N.$t$
WHERE id = 89
  AND question_text = $t$A car engine outputs 15 kW at a speed of \(30\,\text{m/s}\). What is the driving force?$t$
  AND explanation = $t$P = Fv →\(F = \frac{P}{v} = \frac{15000}{30} = 500\,\text{N}\).$t$;

UPDATE questions SET
  explanation = $t$Efficiency = 350/1000 = 0.35 = 35%.$t$
WHERE id = 90
  AND explanation = $t$Efficiency \(= \frac{350}{1000} = 0.35 = 35\%\).$t$;

UPDATE questions SET
  explanation = $t$R = V/I = 12/3 = 4 Ω.$t$
WHERE id = 91
  AND explanation = $t$\(R = \frac{V}{I} = \frac{12}{3} = 4\) Ω.$t$;

UPDATE questions SET
  explanation = $t$I = Q/t = 60/20 = 3 A.$t$
WHERE id = 92
  AND explanation = $t$\(I = \frac{Q}{t} = \frac{60}{20} = 3\,\text{A}\).$t$;

UPDATE questions SET
  explanation = $t$Series: R_total = R1 + R2 = 4 + 6 = 10 Ω.$t$
WHERE id = 93
  AND explanation = $t$Series: R_total \(= R_{1} + R_{2} = 4 + 6 = 10\) Ω.$t$;

UPDATE questions SET
  explanation = $t$1/R = 1/4 + 1/4 = 2/4 = 0.5. R = 2 Ω. Total resistance in parallel is always less than the smallest branch.$t$
WHERE id = 94
  AND explanation = $t$\(\frac{1}{R} = \frac{1}{4} + \frac{1}{4} = \frac{2}{4} = 0.5\). \(R = 2\) Ω. Total resistance in parallel is always less than the smallest branch.$t$;

UPDATE questions SET
  explanation = $t$P = IV = 2 × 230 = 460 W.$t$
WHERE id = 95
  AND explanation = $t$\(P = IV = 2 \times 230 = 460\,\text{W}\).$t$;

UPDATE questions SET
  explanation = $t$Live = brown, Neutral = blue, Earth = green/yellow. Mains voltage = 230 V AC.$t$
WHERE id = 97
  AND explanation = $t$Live = brown, Neutral = blue, Earth = green/yellow. Mains voltage \(= 230\,\text{V}\ AC\).$t$;

UPDATE questions SET
  explanation = $t$E = Pt = 60 × (30 × 60) = 60 × 1800 = 108000 J.$t$
WHERE id = 99
  AND explanation = $t$E = Pt \(= 60 \times (30 \times 60) = 60 \times 1800 = 108000\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$P = IV = 2 × 8 = 16 W. Or P = I²R = 4 × 4 = 16 W.$t$
WHERE id = 100
  AND explanation = $t$\(P = IV = 2 \times 8 = 16\,\text{W}\). Or \(P = I^{2}R = 4 \times 4 = 16\,\text{W}\).$t$;

UPDATE questions SET
  question_text = $t$A block has mass 400 g and volume 200 cm³. What is its density in kg/m³?$t$,
  option_a = $t$2 kg/m³$t$,
  option_b = $t$0.002 kg/m³$t$,
  option_c = $t$0.002 g/cm³$t$,
  option_d = $t$2000 kg/m³$t$,
  explanation = $t$Convert: mass = 0.4 kg, volume = 200 cm³ = 0.0002 m³. ρ = m/V = 0.4/0.0002 = 2000 kg/m³.$t$
WHERE id = 101
  AND question_text = $t$A block has mass \(400\,\text{g}\) and volume \(200\,\text{cm}^{3}\). What is its density in \(\text{kg/m}^{3}\)?$t$
  AND option_a = $t$\(2\,\text{kg/m}^{3}\)$t$
  AND option_b = $t$\(0.002\,\text{kg/m}^{3}\)$t$
  AND option_c = $t$\(0.002\,\text{g/cm}^{3}\)$t$
  AND option_d = $t$\(2000\,\text{kg/m}^{3}\)$t$
  AND explanation = $t$Convert: mass \(= 0.4\,\text{kg}\), volume \(= 200\,\text{cm}^{3} = 0.0002 m^{3}\). ρ \(= \frac{m}{V} = \frac{0.4}{0.0002} = 2000\,\text{kg/m}^{3}\).$t$;

UPDATE questions SET
  question_text = $t$How much energy is needed to heat 2 kg of water by 10°C? (SHC of water = 4200 J/kg°C)$t$,
  explanation = $t$ΔE = mcΔθ = 2 × 4200 × 10 = 84000 J.$t$
WHERE id = 103
  AND question_text = $t$How much energy is needed to heat \(2\,\text{kg}\) of water by \(10^\circ C\)? (SHC of water = \(4200\,\text{J/kg°C}\))$t$
  AND explanation = $t$Δ\(E = mc\)Δ\(\theta = 2 \times 4200 \times 10 = 84000\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$Internal energy = sum of the kinetic energy AND potential energy of all particles. Heating increases internal energy.$t$
WHERE id = 104
  AND explanation = $t$Internal energy \(= sum\) of the kinetic energy AND potential energy of all particles. Heating increases internal energy.$t$;

UPDATE questions SET
  question_text = $t$1 kg of water has latent heat of vaporisation = 2.26 MJ/kg. How much energy to boil away 0.5 kg?$t$,
  explanation = $t$E = mL = 0.5 × 2.26 × 10⁶ = 1.13 × 10⁶ J = 1.13 MJ.$t$
WHERE id = 105
  AND question_text = $t$\(1\,\text{kg}\) of water has latent heat of vaporisation = \(2.26\,\text{MJ/kg}\). How much energy to boil away 0.5 kg?$t$
  AND explanation = $t$E = mL \(= 0.5 \times 2.26 \times 10^{6} = 1.13 \times 10^{6} J = 1.13\,\text{MJ}\).$t$;

UPDATE questions SET
  explanation = $t$At constant volume: p/T = constant. p₂ = p₁ × T₂/T₁ = 100 × 600/300 = 200 kPa.$t$
WHERE id = 108
  AND explanation = $t$At constant volume: \(\frac{p}{T}\)= constant. \(p_{2} = p_{1}\)× T₂/T₁ \(= 100 \times \frac{600}{300} = 200\,\text{kPa}\).$t$;

UPDATE questions SET
  option_a = $t$Energy released when 1 kg of gas condenses$t$,
  option_b = $t$Energy needed to change 1 kg from solid to liquid at constant temperature$t$,
  option_c = $t$Energy needed to raise 1 kg of a substance by 1°C$t$,
  option_d = $t$Energy released when 1 kg of solid is cooled by 1°C$t$
WHERE id = 109
  AND option_a = $t$Energy released when \(1\,\text{kg}\) of gas condenses$t$
  AND option_b = $t$Energy needed to change \(1\,\text{kg}\) from solid to liquid at constant temperature$t$
  AND option_c = $t$Energy needed to raise \(1\,\text{kg}\) of a substance by \(1^\circ C\)$t$
  AND option_d = $t$Energy released when \(1\,\text{kg}\) of solid is cooled by \(1^\circ C\)$t$;

UPDATE questions SET
  question_text = $t$Gas in a cylinder is compressed from 4 m³ to 1 m³ at constant temperature. Initial pressure is 50 kPa. What is the new pressure?$t$,
  explanation = $t$Boyle's Law: p₁V₁ = p₂V₂. p₂ = 50 × 4/1 = 200 kPa.$t$
WHERE id = 110
  AND question_text = $t$Gas in a cylinder is compressed from \(4 m^{3}\) to \(1 m^{3}\) at constant temperature. Initial pressure is 50 kPa. What is the new pressure?$t$
  AND explanation = $t$Boyle's Law: \(p_{1}\)V₁ \(= p_{2}\)V₂. \(p_{2} = 50 \times \frac{4}{1} = 200\,\text{kPa}\).$t$;

UPDATE questions SET
  explanation = $t$Neutrons = mass number − atomic number = 39 − 19 = 20.$t$
WHERE id = 112
  AND explanation = $t$Neutrons = mass number − atomic number \(= 39 - 19 = 20\).$t$;

UPDATE questions SET
  explanation = $t$Fission: a heavy nucleus (e.g. U-235) absorbs a neutron and splits into two smaller nuclei, releasing 2–3 neutrons and energy.$t$
WHERE id = 116
  AND explanation = $t$Fission: a heavy nucleus (e.g. \(U - 235\)) absorbs a neutron and splits into two smaller nuclei, releasing 2–3 neutrons and energy.$t$;

UPDATE questions SET
  explanation = $t$640→320→160→80→40. Four halvings = 4 half-lives.$t$
WHERE id = 118
  AND explanation = $t$\(640 \to 320 \to 160 \to 80 \to 40\). Four halvings \(= 4\) half-lives.$t$;

UPDATE questions SET
  option_a = $t$201.5 m/s$t$,
  option_b = $t$300 m/s$t$,
  option_c = $t$133 m/s$t$,
  option_d = $t$198.5 m/s$t$,
  explanation = $t$v = fλ = 200 × 1.5 = 300 m/s.$t$
WHERE id = 121
  AND option_a = $t$\(201.5\,\text{m/s}\)$t$
  AND option_b = $t$\(300\,\text{m/s}\)$t$
  AND option_c = $t$\(133\,\text{m/s}\)$t$
  AND option_d = $t$\(198.5\,\text{m/s}\)$t$
  AND explanation = $t$\(v = f\)λ \(= 200 \times 1.5 = 300\,\text{m/s}\).$t$;

UPDATE questions SET
  option_a = $t$T = f²$t$,
  option_b = $t$f = T²$t$,
  option_c = $t$f = 1/T$t$,
  option_d = $t$f = T$t$,
  explanation = $t$Period T = time for one complete cycle. Frequency f = cycles per second. T = 1/f and f = 1/T.$t$
WHERE id = 123
  AND option_a = $t$\(T = f^{2}\)$t$
  AND option_b = $t$\(f = T^{2}\)$t$
  AND option_c = $t$\(f = \frac{1}{T}\)$t$
  AND option_d = $t$\(f = T\)$t$
  AND explanation = $t$Period T = time for one complete cycle. Frequency \(f\)= cycles per second. \(T = \frac{1}{f}\) and \(f = \frac{1}{T}\).$t$;

UPDATE questions SET
  question_text = $t$A ray of light hits a mirror at 35° to the normal. What is the angle of reflection?$t$,
  option_a = $t$35°$t$,
  option_b = $t$70°$t$,
  option_c = $t$55°$t$,
  option_d = $t$90°$t$,
  explanation = $t$Law of reflection: angle of incidence = angle of reflection. Both measured from the normal. 35° = 35°.$t$
WHERE id = 125
  AND question_text = $t$A ray of light hits a mirror at \(35^\circ\) to the normal. What is the angle of reflection?$t$
  AND option_a = $t$\(35^\circ\)$t$
  AND option_b = $t$\(70^\circ\)$t$
  AND option_c = $t$\(55^\circ\)$t$
  AND option_d = $t$\(90^\circ\)$t$
  AND explanation = $t$Law of reflection: angle of incidence = angle of reflection. Both measured from the normal. \(35^\circ = 35^\circ\).$t$;

UPDATE questions SET
  option_a = $t$60°$t$,
  option_b = $t$48.2°$t$,
  option_c = $t$30°$t$,
  option_d = $t$41.8°$t$,
  explanation = $t$sin(c) = 1/n = 1/1.5 = 0.667. c = arcsin(0.667) ≈ 41.8°.$t$
WHERE id = 129
  AND option_a = $t$\(60^\circ\)$t$
  AND option_b = $t$\(48.2^\circ\)$t$
  AND option_c = $t$\(30^\circ\)$t$
  AND option_d = $t$\(41.8^\circ\)$t$
  AND explanation = $t$\(\sin(c) = \frac{1}{n} = \frac{1}{1.5} = 0.667\). \(c\)= arcsin\((0.667) \approx 41.8^\circ\).$t$;

UPDATE questions SET
  explanation = $t$F = BIL = 0.5 × 3 × 0.4 = 0.6 N.$t$
WHERE id = 132
  AND explanation = $t$\(F = BIL = 0.5 \times 3 \times 0.4 = 0.6\,\text{N}\).$t$;

UPDATE questions SET
  explanation = $t$Vs/Vp = Ns/Np → Vs = 20 × 500/100 = 100 V. This is a step-up transformer.$t$
WHERE id = 134
  AND explanation = $t$Vs/Vp = Ns/Np → Vs \(= 20 \times \frac{500}{100} = 100\,\text{V}\). This is a step-up transformer.$t$;

UPDATE questions SET
  option_c = $t$To reduce current and minimise power loss in cables (P=I²R)$t$,
  explanation = $t$P_loss = I²R. High voltage → low current → much less power lost as heat in cables. A step-up transformer raises voltage before transmission.$t$
WHERE id = 135
  AND option_c = $t$To reduce current and minimise power loss in cables (\(P = I^{2}R\))$t$
  AND explanation = $t$P_loss \(= I^{2}R\). High voltage → low current → much less power lost as heat in cables. A step-up transformer raises voltage before transmission.$t$;

UPDATE questions SET
  explanation = $t$Power in = power out: Vp × Ip = Vs × Is → 230 × 0.5 = 11.5 × Is → Is = 115/11.5 = 10 A.$t$
WHERE id = 137
  AND explanation = $t$Power in = power out: Vp × Ip = Vs × Is →\(230 \times 0.5 = 11.5\)× Is → Is \(= \frac{115}{11.5} = 10\,\text{A}\).$t$;

UPDATE questions SET
  question_text = $t$A galaxy at distance d moves away at speed v. If another galaxy at 2d is observed, what would you expect its recession speed to be?$t$,
  option_a = $t$2v$t$,
  option_b = $t$4v$t$,
  option_c = $t$v/2$t$,
  option_d = $t$v$t$,
  explanation = $t$Hubble's Law: recession speed is proportional to distance. v = Hd. Double the distance → double the recession speed.$t$
WHERE id = 148
  AND question_text = $t$A galaxy at distance \(d\) moves away at speed \(v\). If another galaxy at \(2d\) is observed, what would you expect its recession speed to be?$t$
  AND option_a = $t$\(2v\)$t$
  AND option_b = $t$\(4v\)$t$
  AND option_c = $t$\(\frac{v}{2}\)$t$
  AND option_d = $t$\(v\)$t$
  AND explanation = $t$Hubble's Law: recession speed is proportional to distance. \(v\)= Hd. Double the distance → double the recession speed.$t$;

UPDATE questions SET
  explanation = $t$E = P × t = 2000 W × 180 s = 360 000 J. Always convert kW to W and minutes to seconds first.$t$
WHERE id = 411
  AND explanation = $t$\(E = P \times t = 2000\,\text{W} \times 180 s = 360\,000\,\text{J}\). Always convert kW to W and minutes to seconds first.$t$;

UPDATE questions SET
  explanation = $t$Power is measured in Watts (W). 1 W = 1 J/s. Power is the rate of energy transfer.$t$
WHERE id = 412
  AND explanation = $t$Power is measured in Watts (W). 1 \(W = 1\,\text{J/s}\). Power is the rate of energy transfer.$t$;

UPDATE questions SET
  explanation = $t$P = I²R — energy loss in cables depends on current squared. Stepping up voltage reduces current, dramatically reducing heat losses over long distances.$t$
WHERE id = 414
  AND explanation = $t$\(P = I^{2}R\) — energy loss in cables depends on current squared. Stepping up voltage reduces current, dramatically reducing heat losses over long distances.$t$;

UPDATE questions SET
  explanation = $t$Efficiency = 0.4 means 40% is usefully transferred. The remaining 60% is wasted (usually as heat). Wasted = 1 - efficiency = 0.6 = 60%.$t$
WHERE id = 415
  AND explanation = $t$Efficiency \(= 0.4\) means 40% is usefully transferred. The remaining 60% is wasted (usually as heat). Wasted \(= 1\)- efficiency \(= 0.6 = 60\%\).$t$;

UPDATE questions SET
  option_a = $t$P = I + V$t$,
  option_b = $t$P = V/I$t$,
  option_c = $t$P = IV$t$,
  option_d = $t$P = I/V$t$,
  explanation = $t$P = IV (power = current × voltage). Also P = I²R and P = V²/R. Always check which quantities you are given.$t$
WHERE id = 416
  AND option_a = $t$\(P = I + V\)$t$
  AND option_b = $t$\(P = \frac{V}{I}\)$t$
  AND option_c = $t$\(P = IV\)$t$
  AND option_d = $t$\(P = \frac{I}{V}\)$t$
  AND explanation = $t$\(P = IV\) (power = current × voltage). Also \(P = I^{2}R\) and \(P = \frac{V^{2}}{R}\). Always check which quantities you are given.$t$;

UPDATE questions SET
  explanation = $t$100 W = 0.1 kW. Energy = 0.1 kW × 2 h = 0.2 kWh. The kilowatt-hour is the unit used on electricity bills.$t$
WHERE id = 417
  AND explanation = $t$\(100 W = 0.1\,\text{kW}\). Energy \(= 0.1\,\text{kW} \times 2 h = 0.2\,\text{kWh}\). The kilowatt-hour is the unit used on electricity bills.$t$;

UPDATE questions SET
  explanation = $t$Vs/Vp = Ns/Np → Vs = 230 × (1000/100) = 2300 V. More turns on secondary = higher output voltage.$t$
WHERE id = 419
  AND explanation = $t$Vs/Vp = Ns/Np → Vs \(= 230 \times (\frac{1000}{100}) = 2300\,\text{V}\). More turns on secondary = higher output voltage.$t$;

UPDATE questions SET
  explanation = $t$UK mains electricity is AC at 50 Hz (50 cycles per second) and approximately 230 V. The USA uses 60 Hz at 110-120 V.$t$
WHERE id = 421
  AND explanation = $t$UK mains electricity is AC at 50 Hz (50 cycles per second) and approximately 230 V. The USA uses 60 Hz at 110–120 V.$t$;

UPDATE questions SET
  explanation = $t$P = IV = 8.7 × 230 = 2001 W ≈ 2 kW. This is a typical kettle power rating.$t$
WHERE id = 425
  AND explanation = $t$\(P = IV = 8.7 \times 230 = 2001\,\text{W} \approx 2\,\text{kW}\). This is a typical kettle power rating.$t$;

UPDATE questions SET
  explanation = $t$P = I²R → I² = P/R = 3000/30 = 100 → I = 10 A.$t$
WHERE id = 429
  AND explanation = $t$\(P = I^{2}R \to I^{2} = \frac{P}{R} = \frac{3000}{30} = 100 \to I = 10\,\text{A}\).$t$;

UPDATE questions SET
  option_a = $t$Mass × velocity (p = mv), measured in kg m/s$t$,
  explanation = $t$Momentum p = mv. It is a vector quantity (has direction). The unit is kg m/s. A large, fast-moving object has much more momentum than a small, slow one.$t$
WHERE id = 431
  AND option_a = $t$Mass × velocity \((p = mv)\), measured in kg m/s$t$
  AND explanation = $t$Momentum \(p = mv\). It is a vector quantity (has direction). The unit is kg m/s. A large, fast-moving object has much more momentum than a small, slow one.$t$;

UPDATE questions SET
  question_text = $t$A 1500 kg car travels at 20 m/s. What is its momentum?$t$,
  option_a = $t$1520 kg m/s$t$,
  option_b = $t$30 000 kg m/s$t$,
  option_c = $t$750 m/s$t$,
  option_d = $t$75 kg m/s$t$,
  explanation = $t$p = mv = 1500 × 20 = 30 000 kg m/s.$t$
WHERE id = 432
  AND question_text = $t$A \(1500\,\text{kg}\) car travels at \(20\,\text{m/s}\). What is its momentum?$t$
  AND option_a = $t$\(1520\,\text{kg m/s}\)$t$
  AND option_b = $t$\(30\,000\,\text{kg m/s}\)$t$
  AND option_c = $t$\(750\,\text{m/s}\)$t$
  AND option_d = $t$\(75\,\text{kg m/s}\)$t$
  AND explanation = $t$\(p = mv = 1500 \times 20 = 30\,000\,\text{kg m/s}\).$t$;

UPDATE questions SET
  option_b = $t$Force / area (P = F/A), measured in Pascals$t$,
  explanation = $t$Pressure = force / area. Unit: Pascal (Pa) = N/m². Smaller area → greater pressure for the same force. Example: a knife cuts because the blade has a tiny area.$t$
WHERE id = 435
  AND option_b = $t$Force / area \((P = \frac{F}{A})\), measured in Pascals$t$
  AND explanation = $t$Pressure = force / area. Unit: Pascal (Pa) \(=\,\text{N/m}^{2}\). Smaller area → greater pressure for the same force. Example: a knife cuts because the blade has a tiny area.$t$;

UPDATE questions SET
  question_text = $t$A force of 600 N acts on an area of 0.03 m². What is the pressure?$t$,
  explanation = $t$P = F/A = 600 / 0.03 = 20 000 Pa.$t$
WHERE id = 436
  AND question_text = $t$A force of 600 N acts on an area of \(0.03 m^{2}\). What is the pressure?$t$
  AND explanation = $t$\(P = \frac{F}{A} = \frac{600}{0.03} = 20\,000\,\text{Pa}\).$t$;

UPDATE questions SET
  explanation = $t$Moment = force × perpendicular distance from pivot. Unit: N m. A larger force or a longer distance from the pivot creates a greater turning effect.$t$
WHERE id = 438
  AND explanation = $t$Moment = force × perpendicular distance from pivot. Unit: N \(m\). A larger force or a longer distance from the pivot creates a greater turning effect.$t$;

UPDATE questions SET
  question_text = $t$An impulse of 500 N s acts on a 50 kg object. What is the change in velocity?$t$,
  option_a = $t$0.1 m/s$t$,
  option_b = $t$250 m/s$t$,
  option_c = $t$10 m/s$t$,
  option_d = $t$2500 m/s$t$,
  explanation = $t$Impulse = change in momentum = mv - mu. 500 = 50 × Δv → Δv = 10 m/s.$t$
WHERE id = 440
  AND question_text = $t$An impulse of 500 N \(s\) acts on \(a\) \(50\,\text{kg}\) object. What is the change in velocity?$t$
  AND option_a = $t$\(0.1\,\text{m/s}\)$t$
  AND option_b = $t$\(250\,\text{m/s}\)$t$
  AND option_c = $t$\(10\,\text{m/s}\)$t$
  AND option_d = $t$\(2500\,\text{m/s}\)$t$
  AND explanation = $t$Impulse = change in momentum \(= mv - mu\). \(500 = 50\)× Δ\(v\)→ Δ\(v = 10\,\text{m/s}\).$t$;

UPDATE questions SET
  option_a = $t$340 m/s$t$,
  option_b = $t$3 × 10⁶ m/s$t$,
  option_c = $t$3 × 10⁸ m/s$t$,
  option_d = $t$300 m/s$t$,
  explanation = $t$All EM waves travel at 3 × 10⁸ m/s (300 000 000 m/s) in a vacuum. This is the speed of light.$t$
WHERE id = 441
  AND option_a = $t$\(340\,\text{m/s}\)$t$
  AND option_b = $t$\(3 \times 10^{6}\,\text{m/s}\)$t$
  AND option_c = $t$\(3 \times 10^{8}\,\text{m/s}\)$t$
  AND option_d = $t$\(300\,\text{m/s}\)$t$
  AND explanation = $t$All EM waves travel at \(3 \times 10^{8}\,\text{m/s}\) (\(300\,000\,000\,\text{m/s}\)) in a vacuum. This is the speed of light.$t$;

UPDATE questions SET
  option_d = $t$When light refracts at exactly 90°$t$
WHERE id = 447
  AND option_d = $t$When light refracts at exactly \(90^\circ\)$t$;

UPDATE questions SET
  explanation = $t$Radio waves travel at c (3×10⁸ m/s) and can be reflected by the ionosphere for long-distance communication. Different frequencies are used for different purposes (AM, FM, DAB).$t$
WHERE id = 448
  AND explanation = $t$Radio waves travel at \(c (3 \times 10^{8}\,\text{m/s})\) and can be reflected by the ionosphere for long-distance communication. Different frequencies are used for different purposes (AM, FM, DAB).$t$;

UPDATE questions SET
  explanation = $t$Below the critical angle, some light is refracted and some reflected. At or above the critical angle, all light is totally internally reflected. For glass-air, the critical angle is about 42°.$t$
WHERE id = 449
  AND explanation = $t$Below the critical angle, some light is refracted and some reflected. At or above the critical angle, all light is totally internally reflected. For glass-air, the critical angle is about \(42^\circ\).$t$;

UPDATE questions SET
  explanation = $t$Alpha (α) particle: 2 protons + 2 neutrons (helium-4 nucleus). Strongly ionising, short range in air (~5 cm), stopped by paper or skin.$t$
WHERE id = 451
  AND explanation = $t$Alpha \((\alpha)\) particle: 2 protons + 2 neutrons (helium-4 nucleus). Strongly ionising, short range in air (~5 cm), stopped by paper or skin.$t$;

UPDATE questions SET
  explanation = $t$Beta (β⁻) particle: a fast-moving electron emitted when a neutron converts to a proton + electron. Moderately ionising, range ~1 m in air, stopped by a few mm of aluminium.$t$
WHERE id = 452
  AND explanation = $t$Beta (β\({}^{-}\)) particle: a fast-moving electron emitted when a neutron converts to a proton + electron. Moderately ionising, range ~1 m in air, stopped by a few mm of aluminium.$t$;

UPDATE questions SET
  explanation = $t$6 years = 3 half-lives. 800 → 400 → 200 → 100. After 3 half-lives, (1/2)³ = 1/8 remains. 800/8 = 100.$t$
WHERE id = 455
  AND explanation = $t$6 years \(= 3\) half-lives. \(800 \to 400 \to 200 \to 100\). After 3 half-lives, \((\frac{1}{2})^{3} = \frac{1}{8}\) remains. \(\frac{800}{8} = 100\).$t$;

UPDATE questions SET
  explanation = $t$Fission: a large nucleus (e.g. uranium-235) absorbs a neutron and splits into two smaller nuclei, releasing 2-3 neutrons and large amounts of energy. Used in nuclear power stations.$t$
WHERE id = 456
  AND explanation = $t$Fission: a large nucleus (e.g. uranium-235) absorbs a neutron and splits into two smaller nuclei, releasing 2–3 neutrons and large amounts of energy. Used in nuclear power stations.$t$;

UPDATE questions SET
  explanation = $t$Vs/Vp = Ns/Np → Vs = 50 × (1000/200) = 250 V. This is a step-up transformer.$t$
WHERE id = 465
  AND explanation = $t$Vs/Vp = Ns/Np → Vs \(= 50 \times (\frac{1000}{200}) = 250\,\text{V}\). This is a step-up transformer.$t$;

UPDATE questions SET
  explanation = $t$High voltage = low current. Energy loss in cables = I²R. Reducing current dramatically reduces energy wasted as heat. Power stations step up to ~400 000 V for transmission.$t$
WHERE id = 466
  AND explanation = $t$High voltage \(= low\) current. Energy loss in cables \(= I^{2}R\). Reducing current dramatically reduces energy wasted as heat. Power stations step up to ~400 000 V for transmission.$t$;

UPDATE questions SET
  explanation = $t$For ideal transformer: VpIp = VsIs. 240 × 0.5 = 12 × Is → Is = 120/12 = 10 A. Step-down in voltage = step-up in current.$t$
WHERE id = 468
  AND explanation = $t$For ideal transformer: VpIp = VsIs. \(240 \times 0.5 = 12\)× Is → Is \(= \frac{120}{12} = 10\,\text{A}\). Step-down in voltage = step-up in current.$t$;

UPDATE questions SET
  option_a = $t$The heat content of 1 kg of material$t$,
  option_b = $t$The energy needed to raise the temperature of 1 kg of a substance by 1°C$t$,
  option_c = $t$The energy released when 1 kg of fuel burns$t$,
  option_d = $t$The energy needed to melt 1 kg of a substance$t$,
  explanation = $t$SHC (c) is measured in J/(kg·°C). Formula: Q = mcΔT. Water has a high SHC (4200 J/kg°C) — it takes a lot of energy to heat up and cools slowly.$t$
WHERE id = 471
  AND option_a = $t$The heat content of \(1\,\text{kg}\) of material$t$
  AND option_b = $t$The energy needed to raise the temperature of \(1\,\text{kg}\) of a substance by \(1^\circ C\)$t$
  AND option_c = $t$The energy released when \(1\,\text{kg}\) of fuel burns$t$
  AND option_d = $t$The energy needed to melt \(1\,\text{kg}\) of a substance$t$
  AND explanation = $t$SHC (\(c\)) is measured in J/(kg·°C). Formula: \(Q = mc\)ΔT. Water has a high SHC (\(4200\,\text{J/kg°C}\)) — it takes a lot of energy to heat up and cools slowly.$t$;

UPDATE questions SET
  question_text = $t$A 2 kg block of iron (SHC = 450 J/kg°C) is heated by 500 J. What is the temperature rise?$t$,
  option_a = $t$450°C$t$,
  option_c = $t$0.56°C$t$,
  option_d = $t$5000°C$t$,
  explanation = $t$Q = mcΔT → ΔT = Q/(mc) = 500/(2 × 450) = 500/900 = 0.56°C.$t$
WHERE id = 472
  AND question_text = $t$A \(2\,\text{kg}\) block of iron (SHC = \(450\,\text{J/kg°C}\)) is heated by 500 J. What is the temperature rise?$t$
  AND option_a = $t$\(450^\circ C\)$t$
  AND option_c = $t$\(0.56^\circ C\)$t$
  AND option_d = $t$\(5000^\circ C\)$t$
  AND explanation = $t$\(Q = mc\)ΔT → Δ\(T = Q /\)(mc) \(= \frac{500}{2 \times 450} = \frac{500}{900} = 0.56^\circ C\).$t$;

UPDATE questions SET
  option_a = $t$The energy needed to change the state of 1 kg of a substance without changing its temperature$t$,
  option_d = $t$The energy needed to raise 1 kg by 1 degree C$t$
WHERE id = 473
  AND option_a = $t$The energy needed to change the state of \(1\,\text{kg}\) of a substance without changing its temperature$t$
  AND option_d = $t$The energy needed to raise \(1\,\text{kg}\) by 1 degree C$t$;

UPDATE questions SET
  explanation = $t$Higher temperature → greater kinetic energy → particles move faster → more frequent and harder collisions with container walls → greater pressure. P ∝ T (in Kelvin) at constant volume.$t$
WHERE id = 475
  AND explanation = $t$Higher temperature → greater kinetic energy → particles move faster → more frequent and harder collisions with container walls → greater pressure. \(P \propto T\) (in Kelvin) at constant volume.$t$;

UPDATE questions SET
  option_a = $t$P + V = constant$t$,
  option_b = $t$P = V$t$,
  option_c = $t$P × V = constant (Boyle's Law) — pressure and volume are inversely proportional$t$,
  option_d = $t$P / V = constant$t$
WHERE id = 476
  AND option_a = $t$\(P + V\)= constant$t$
  AND option_b = $t$\(P = V\)$t$
  AND option_c = $t$\(P \times V\)= constant (Boyle's Law) — pressure and volume are inversely proportional$t$
  AND option_d = $t$\(\frac{P}{V}\)= constant$t$;

UPDATE questions SET
  question_text = $t$1 kg of water (latent heat of vaporisation = 2.26 × 10⁶ J/kg) is evaporated. How much energy is needed?$t$,
  explanation = $t$Q = mL = 1 × 2.26 × 10⁶ = 2 260 000 J = 2.26 MJ. Large amounts of energy are needed to evaporate water — this is why sweating cools you effectively.$t$
WHERE id = 477
  AND question_text = $t$\(1\,\text{kg}\) of water (latent heat of vaporisation \(= 2.26 \times 10^{6}\,\text{J}\text{/kg}\)) is evaporated. How much energy is needed?$t$
  AND explanation = $t$Q = mL \(= 1 \times 2.26 \times 10^{6} = 2\,260\,000 J = 2.26\,\text{MJ}\). Large amounts of energy are needed to evaporate water — this is why sweating cools you effectively.$t$;

UPDATE questions SET
  explanation = $t$Internal energy = sum of kinetic energy (random motion of particles) + potential energy (intermolecular forces) of all particles. Heating increases internal energy.$t$
WHERE id = 478
  AND explanation = $t$Internal energy \(= sum\) of kinetic energy (random motion of particles) + potential energy (intermolecular forces) of all particles. Heating increases internal energy.$t$;

UPDATE questions SET
  explanation = $t$P/T = constant (constant volume). P₂ = P₁ × T₂/T₁ = 100 × 600/300 = 200 kPa. Temperature must be in Kelvin.$t$
WHERE id = 479
  AND explanation = $t$\(\frac{P}{T}\)= constant (constant volume). P₂ = P₁ × T₂/T₁ \(= 100 \times \frac{600}{300} = 200\,\text{kPa}\). Temperature must be in Kelvin.$t$;

UPDATE questions SET
  explanation = $t$Stars fuse hydrogen into helium in their cores (via the proton-proton chain). Four hydrogen nuclei → one helium nucleus + energy. The mass difference appears as energy (E = mc²).$t$
WHERE id = 484
  AND explanation = $t$Stars fuse hydrogen into helium in their cores (via the proton-proton chain). Four hydrogen nuclei → one helium nucleus + energy. The mass difference appears as energy \((E = mc^{2})\).$t$;

UPDATE questions SET
  explanation = $t$Massive stars (>8 solar masses): red supergiant → supernova explosion → neutron star (if moderate mass) or black hole (if very massive). Supernovae forge heavy elements (heavier than iron).$t$
WHERE id = 486
  AND explanation = $t$Massive stars (\(> 8\) solar masses): red supergiant → supernova explosion → neutron star (if moderate mass) or black hole (if very massive). Supernovae forge heavy elements (heavier than iron).$t$;

UPDATE questions SET
  question_text = $t$A 3 kg object is lifted 5 m. Using g = 9.8 N/kg, calculate the gravitational potential energy gained.$t$,
  explanation = $t$Ep = mgh = 3 × 9.8 × 5 = 147 J.$t$
WHERE id = 491
  AND question_text = $t$A \(3\,\text{kg}\) object is lifted 5 m. Using \(g = 9.8\,\text{N/kg}\), calculate the gravitational potential energy gained.$t$
  AND explanation = $t$Ep \(= mgh = 3 \times 9.8 \times 5 = 147\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$Series: total resistance = 4 + 6 = 10 Ω. I = V/R = 20/10 = 2 A.$t$
WHERE id = 492
  AND explanation = $t$Series: total resistance \(= 4 + 6 = 10\) Ω. \(I = \frac{V}{R} = \frac{20}{10} = 2\,\text{A}\).$t$;

UPDATE questions SET
  question_text = $t$What is the density of a material with mass 150 g and volume 50 cm³?$t$,
  option_a = $t$100 g/cm³$t$,
  option_b = $t$200 g/cm3$t$,
  option_c = $t$0.33 g/cm³$t$,
  option_d = $t$3 g/cm³$t$,
  explanation = $t$ρ = m/V = 150/50 = 3 g/cm³.$t$
WHERE id = 493
  AND question_text = $t$What is the density of a material with mass \(150\,\text{g}\) and volume \(50\,\text{cm}^{3}\)?$t$
  AND option_a = $t$\(100\,\text{g/cm}^{3}\)$t$
  AND option_b = $t$\(200\,\text{g/cm}^{3}\)$t$
  AND option_c = $t$\(0.33\,\text{g/cm}^{3}\)$t$
  AND option_d = $t$\(3\,\text{g/cm}^{3}\)$t$
  AND explanation = $t$ρ \(= \frac{m}{V} = \frac{150}{50} = 3\,\text{g/cm}^{3}\).$t$;

UPDATE questions SET
  explanation = $t$Carbon-14: mass number = 14, atomic number = 6. Neutrons = mass number - atomic number = 14 - 6 = 8.$t$
WHERE id = 494
  AND explanation = $t$Carbon-14: mass number \(= 14\), atomic number \(= 6\). Neutrons = mass number - atomic number \(= 14 - 6 = 8\).$t$;

UPDATE questions SET
  explanation = $t$1/R = 1/6 + 1/3 = 1/6 + 2/6 = 3/6 = 1/2. R = 2 Ω. Parallel resistance is always less than the smallest branch.$t$
WHERE id = 495
  AND explanation = $t$\(\frac{1}{R} = \frac{1}{6} + \frac{1}{3} = \frac{1}{6} + \frac{2}{6} = \frac{3}{6} = \frac{1}{2}\). \(R = 2\) Ω. Parallel resistance is always less than the smallest branch.$t$;

UPDATE questions SET
  question_text = $t$A substance has a specific heat capacity of 500 J/kg°C. How much energy is needed to heat 4 kg by 25°C?$t$,
  explanation = $t$Q = mcΔT = 4 × 500 × 25 = 50 000 J.$t$
WHERE id = 496
  AND question_text = $t$A substance has a specific heat capacity of \(500\,\text{J/kg°C}\). How much energy is needed to heat \(4\,\text{kg}\) by \(25^\circ C\)?$t$
  AND explanation = $t$\(Q = mc\)Δ\(T = 4 \times 500 \times 25 = 50\,000\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$400 → 200 → 100 → 50 (3 half-lives in 30 minutes). Half-life = 30/3 = 10 min.$t$
WHERE id = 497
  AND explanation = $t$\(400 \to 200 \to 100 \to 50\) (3 half-lives in 30 minutes). Half-life \(= \frac{30}{3} = 10\,\text{min}\).$t$;

UPDATE questions SET
  explanation = $t$P = IV = 3 × 12 = 36 W.$t$
WHERE id = 498
  AND explanation = $t$\(P = IV = 3 \times 12 = 36\,\text{W}\).$t$;

UPDATE questions SET
  explanation = $t$Useful output = 500 - 120 = 380 J. Efficiency = useful/total = 380/500 = 0.76 = 76%.$t$
WHERE id = 500
  AND explanation = $t$Useful output \(= 500 - 120 = 380\,\text{J}\). Efficiency = useful/total \(= \frac{380}{500} = 0.76 = 76\%\).$t$;

UPDATE questions SET
  question_text = $t$A car of mass 1200 kg accelerates at 3 m/s². What resultant force acts on it?$t$,
  explanation = $t$F = ma = 1200 × 3 = 3600 N.$t$
WHERE id = 501
  AND question_text = $t$A car of mass \(1200\,\text{kg}\) accelerates at \(3\,\text{m/s}^{2}\). What resultant force acts on it?$t$
  AND explanation = $t$\(F = ma = 1200 \times 3 = 3600\,\text{N}\).$t$;

UPDATE questions SET
  option_a = $t$200 m/s$t$,
  option_b = $t$100 m/s$t$,
  option_c = $t$400 m/s$t$,
  option_d = $t$0.0025 m/s$t$,
  explanation = $t$v = fλ = 200 × 0.5 = 100 m/s.$t$
WHERE id = 502
  AND option_a = $t$\(200\,\text{m/s}\)$t$
  AND option_b = $t$\(100\,\text{m/s}\)$t$
  AND option_c = $t$\(400\,\text{m/s}\)$t$
  AND option_d = $t$\(0.0025\,\text{m/s}\)$t$
  AND explanation = $t$\(v = f\)λ \(= 200 \times 0.5 = 100\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$What is the weight of a 60 kg person on Earth (g = 9.8 N/kg)?$t$,
  explanation = $t$Weight = mass × g = 60 × 9.8 = 588 N.$t$
WHERE id = 503
  AND question_text = $t$What is the weight of \(a\) \(60\,\text{kg}\) person on Earth (\(g = 9.8\,\text{N/kg}\))?$t$
  AND explanation = $t$Weight = mass ×\(g = 60 \times 9.8 = 588\,\text{N}\).$t$;

UPDATE questions SET
  explanation = $t$F = BIL = 0.5 × 4 × 0.3 = 0.6 N.$t$
WHERE id = 504
  AND explanation = $t$\(F = BIL = 0.5 \times 4 \times 0.3 = 0.6\,\text{N}\).$t$;

UPDATE questions SET
  option_a = $t$20 m/s$t$,
  option_b = $t$10 m/s$t$,
  option_c = $t$15 m/s$t$,
  option_d = $t$13.3 m/s$t$,
  explanation = $t$Total distance = 150 + 50 = 200 m. Total time = 10 + 5 = 15 s. Average speed = 200/15 = 13.3 m/s.$t$
WHERE id = 505
  AND option_a = $t$\(20\,\text{m/s}\)$t$
  AND option_b = $t$\(10\,\text{m/s}\)$t$
  AND option_c = $t$\(15\,\text{m/s}\)$t$
  AND option_d = $t$\(13.3\,\text{m/s}\)$t$
  AND explanation = $t$Total distance \(= 150 + 50 = 200\,\text{m}\). Total time \(= 10 + 5 = 15\,\text{s}\). Average speed \(= \frac{200}{15} = 13.3\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$What is the wavelength of a wave with speed 330 m/s and frequency 1100 Hz?$t$,
  explanation = $t$λ = v/f = 330/1100 = 0.3 m.$t$
WHERE id = 506
  AND question_text = $t$What is the wavelength of a wave with speed \(330\,\text{m/s}\) and frequency 1100 Hz?$t$
  AND explanation = $t$λ \(= \frac{v}{f} = \frac{330}{1100} = 0.3\,\text{m}\).$t$;

UPDATE questions SET
  explanation = $t$Vp/Vs = Np/Ns → Np = Ns × Vp/Vs = 50 × 230/11.5 = 1000 turns.$t$
WHERE id = 507
  AND explanation = $t$Vp/Vs = Np/Ns → Np = Ns × Vp/Vs \(= 50 \times \frac{230}{11.5} = 1000\) turns.$t$;

UPDATE questions SET
  question_text = $t$An object has momentum 600 kg m/s and mass 40 kg. What is its velocity?$t$,
  option_a = $t$560 m/s$t$,
  option_b = $t$640 m/s$t$,
  option_c = $t$15 m/s$t$,
  option_d = $t$24000 m/s$t$,
  explanation = $t$v = p/m = 600/40 = 15 m/s.$t$
WHERE id = 508
  AND question_text = $t$An object has momentum \(600\,\text{kg m/s}\) and mass 40 kg. What is its velocity?$t$
  AND option_a = $t$\(560\,\text{m/s}\)$t$
  AND option_b = $t$\(640\,\text{m/s}\)$t$
  AND option_c = $t$\(15\,\text{m/s}\)$t$
  AND option_d = $t$\(24000\,\text{m/s}\)$t$
  AND explanation = $t$\(v = \frac{p}{m} = \frac{600}{40} = 15\,\text{m/s}\).$t$;

UPDATE questions SET
  explanation = $t$The EM spectrum in order of increasing frequency: radio → microwave → infrared → visible → UV → X-ray → gamma. Gamma rays have the highest frequency and shortest wavelength.$t$
WHERE id = 509
  AND explanation = $t$The EM spectrum in order of increasing frequency: radio → microwave → infrared → visible →\(UV \to X - ray\)→ gamma. Gamma rays have the highest frequency and shortest wavelength.$t$;

UPDATE questions SET
  question_text = $t$A 70 kg person stands on a surface area of 0.035 m² (g = 9.8 N/kg). What pressure do they exert?$t$,
  explanation = $t$Weight = 70 × 9.8 = 686 N. P = F/A = 686/0.035 = 19 600 Pa.$t$
WHERE id = 510
  AND question_text = $t$A \(70\,\text{kg}\) person stands on a surface area of \(0.035 m^{2}\) (\(g = 9.8\,\text{N/kg}\)). What pressure do they exert?$t$
  AND explanation = $t$Weight \(= 70 \times 9.8 = 686\,\text{N}\). \(P = \frac{F}{A} = \frac{686}{0.035} = 19\,600\,\text{Pa}\).$t$;

UPDATE questions SET
  question_text = $t$An object falls from rest. Using g = 9.8 m/s², what is its speed after 3 seconds (ignoring air resistance)?$t$,
  option_a = $t$9.8 m/s$t$,
  option_b = $t$29.4 m/s$t$,
  option_c = $t$19.6 m/s$t$,
  option_d = $t$32.4 m/s$t$,
  explanation = $t$v = u + at = 0 + 9.8 × 3 = 29.4 m/s.$t$
WHERE id = 511
  AND question_text = $t$An object falls from rest. Using \(g = 9.8\,\text{m/s}^{2}\), what is its speed after 3 seconds (ignoring air resistance)?$t$
  AND option_a = $t$\(9.8\,\text{m/s}\)$t$
  AND option_b = $t$\(29.4\,\text{m/s}\)$t$
  AND option_c = $t$\(19.6\,\text{m/s}\)$t$
  AND option_d = $t$\(32.4\,\text{m/s}\)$t$
  AND explanation = $t$\(v = u\)+ at \(= 0 + 9.8 \times 3 = 29.4\,\text{m/s}\).$t$;

UPDATE questions SET
  explanation = $t$In parallel: each branch has full supply voltage. I₁ = 30/5 = 6 A. I₂ = 30/10 = 3 A. Total current = 6 + 3 = 9 A.$t$
WHERE id = 512
  AND explanation = $t$In parallel: each branch has full supply voltage. I₁ \(= \frac{30}{5} = 6\,\text{A}\). I₂ \(= \frac{30}{10} = 3\,\text{A}\). Total current \(= 6 + 3 = 9\,\text{A}\).$t$;

UPDATE questions SET
  option_d = $t$All moving particles have an associated wavelength — λ = h/mv where h is the Planck constant$t$,
  explanation = $t$Wave-particle duality: all matter has wave-like properties. The de Broglie wavelength λ = h/p = h/(mv). For large objects the wavelength is negligible; for electrons it is measurable.$t$
WHERE id = 513
  AND option_d = $t$All moving particles have an associated wavelength — λ \(= h\)/mv where \(h\) is the Planck constant$t$
  AND explanation = $t$Wave-particle duality: all matter has wave-like properties. The de Broglie wavelength λ \(= \frac{h}{p} = h /\)(mv). For large objects the wavelength is negligible; for electrons it is measurable.$t$;

UPDATE questions SET
  question_text = $t$A 0.5 kg spring is compressed 0.1 m (k = 800 N/m). Calculate the elastic potential energy stored.$t$,
  explanation = $t$Ee = ½ke² = ½ × 800 × (0.1)² = 400 × 0.01 = 4 J.$t$
WHERE id = 514
  AND question_text = $t$A \(0.5\,\text{kg}\) spring is compressed 0.1 m (\(k = 800\,\text{N/m}\)). Calculate the elastic potential energy stored.$t$
  AND explanation = $t$Ee \(= \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 800 \times (0.1)^{2} = 400 \times 0.01 = 4\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$In a potential divider: Vout = Vin × R2/(R1+R2). If the thermistor is R2 and its resistance falls, it takes a smaller fraction of the voltage. Output voltage decreases.$t$
WHERE id = 515
  AND explanation = $t$In a potential divider: Vout = Vin ×\(\frac{R_{2}}{R_{1} + R_{2}}\). If the thermistor is \(R_{2}\) and its resistance falls, it takes a smaller fraction of the voltage. Output voltage decreases.$t$;

UPDATE questions SET
  question_text = $t$An electron is accelerated through a potential difference of 1000 V. Given that electron charge = 1.6×10⁻¹⁹ C, what kinetic energy does it gain?$t$,
  option_a = $t$1.6×10⁻¹⁶ J$t$,
  option_c = $t$1.6×10⁻²² J$t$,
  option_d = $t$6.25×10²¹ J$t$,
  explanation = $t$KE = QV = 1.6×10⁻¹⁹ × 1000 = 1.6×10⁻¹⁶ J.$t$
WHERE id = 516
  AND question_text = $t$An electron is accelerated through a potential difference of 1000 V. Given that electron charge \(= 1.6 \times 10^{-19}\,\text{C}\), what kinetic energy does it gain?$t$
  AND option_a = $t$\(1.6 \times 10^{-16}\,\text{J}\)$t$
  AND option_c = $t$\(1.6 \times 10^{-22}\,\text{J}\)$t$
  AND option_d = $t$\(6.25 \times 10^{21}\,\text{J}\)$t$
  AND explanation = $t$\(KE = QV = 1.6 \times 10^{-19} \times 1000 = 1.6 \times 10^{-16}\,\text{J}\).$t$;

UPDATE questions SET
  option_a = $t$Z=90, A=234$t$,
  option_b = $t$Z=91, A=237$t$,
  option_c = $t$Z=92, A=238$t$,
  option_d = $t$Z=92, A=234$t$,
  explanation = $t$Alpha decay: loses 2 protons and 2 neutrons. New A = 238-4 = 234. New Z = 92-2 = 90. Daughter is thorium-234.$t$
WHERE id = 517
  AND option_a = $t$\(Z = 90\), \(A = 234\)$t$
  AND option_b = $t$\(Z = 91\), \(A = 237\)$t$
  AND option_c = $t$\(Z = 92\), \(A = 238\)$t$
  AND option_d = $t$\(Z = 92\), \(A = 234\)$t$
  AND explanation = $t$Alpha decay: loses 2 protons and 2 neutrons. New \(A = 238 - 4 = 234\). New \(Z = 92 - 2 = 90\). Daughter is thorium-234.$t$;

UPDATE questions SET
  question_text = $t$A gas at 27°C (300 K) has pressure 100 kPa. It is heated to 127°C (400 K) at constant volume. What is the new pressure?$t$,
  explanation = $t$P/T = constant → P₂ = P₁ × T₂/T₁ = 100 × 400/300 = 133 kPa.$t$
WHERE id = 518
  AND question_text = $t$A gas at \(27^\circ C (300\,\text{K})\) has pressure 100 kPa. It is heated to \(127^\circ C (400\,\text{K})\) at constant volume. What is the new pressure?$t$
  AND explanation = $t$\(\frac{P}{T}\)= constant → P₂ = P₁ × T₂/T₁ \(= 100 \times \frac{400}{300} = 133\,\text{kPa}\).$t$;

UPDATE questions SET
  question_text = $t$An object is thrown horizontally at 15 m/s from a height of 20 m. How long does it take to reach the ground? (g = 10 m/s²)$t$,
  explanation = $t$Vertical motion: s = ½gt² → 20 = ½ × 10 × t² → t² = 4 → t = 2 s. Horizontal velocity does not affect vertical fall time.$t$
WHERE id = 520
  AND question_text = $t$An object is thrown horizontally at \(15\,\text{m/s}\) from a height of 20 m. How long does it take to reach the ground? (\(g = 10\,\text{m/s}^{2}\))$t$
  AND explanation = $t$Vertical motion: \(s = \tfrac{1}{2}gt^{2} \to 20 = \tfrac{1}{2} \times 10 \times t^{2} \to t^{2} = 4 \to t = 2 s\). Horizontal velocity does not affect vertical fall time.$t$;

UPDATE questions SET
  question_text = $t$A car decelerates from 30 m/s to rest in 6 s. What is the braking force if the mass is 1200 kg?$t$,
  explanation = $t$a = (v-u)/t = (0-30)/6 = -5 m/s². F = ma = 1200 × 5 = 6000 N (magnitude).$t$
WHERE id = 521
  AND question_text = $t$A car decelerates from \(30\,\text{m/s}\) to rest in 6 s. What is the braking force if the mass is 1200 kg?$t$
  AND explanation = $t$\(a = \frac{v - u}{t} = \frac{0 - 30}{6} = -5\,\text{m/s}^{2}\). \(F = ma = 1200 \times 5 = 6000\,\text{N}\) (magnitude).$t$;

UPDATE questions SET
  question_text = $t$Using the wave equation, what is the frequency of a wave with speed 3×10⁸ m/s and wavelength 6×10⁻⁷ m?$t$,
  option_a = $t$2×10⁻¹⁵ Hz$t$,
  option_b = $t$5×10¹⁴ Hz$t$,
  option_c = $t$1.8e14 Hz$t$,
  option_d = $t$6×10¹⁴ Hz$t$,
  explanation = $t$f = v/λ = (3×10⁸)/(6×10⁻⁷) = 5×10¹⁴ Hz. This is visible light (green).$t$
WHERE id = 522
  AND question_text = $t$Using the wave equation, what is the frequency of a wave with speed \(3 \times 10^{8}\,\text{m/s}\) and wavelength \(6 \times 10^{-7}\,\text{m}\)?$t$
  AND option_a = $t$\(2 \times 10^{-15}\,\text{Hz}\)$t$
  AND option_b = $t$\(5 \times 10^{14}\,\text{Hz}\)$t$
  AND option_c = $t$\(1.8e14\,\text{Hz}\)$t$
  AND option_d = $t$\(6 \times 10^{14}\,\text{Hz}\)$t$
  AND explanation = $t$\(f = v\)/λ \(= \frac{3 \times 10^{8}}{6 \times 10^{-7}} = 5 \times 10^{14}\,\text{Hz}\). This is visible light (green).$t$;

UPDATE questions SET
  explanation = $t$RMS voltage = peak voltage / √2 = 325/√2 ≈ 230 V. UK mains is described as 230 V RMS even though peak voltage is about 325 V.$t$
WHERE id = 523
  AND explanation = $t$RMS voltage = peak voltage /\(\sqrt{2} = \frac{325}{\sqrt{2}} \approx 230\,\text{V}\). UK mains is described as 230 V RMS even though peak voltage is about 325 V.$t$;

UPDATE questions SET
  question_text = $t$An object of mass 3 kg moving at 8 m/s collides with a stationary 5 kg object. They stick together. What is their combined velocity?$t$,
  option_a = $t$4.8 m/s$t$,
  option_b = $t$3 m/s$t$,
  option_c = $t$8 m/s$t$,
  option_d = $t$1.6 m/s$t$,
  explanation = $t$Conservation of momentum: p_before = 3 × 8 = 24 kg m/s. p_after = (3+5) × v = 8v. v = 24/8 = 3 m/s.$t$
WHERE id = 524
  AND question_text = $t$An object of mass \(3\,\text{kg}\) moving at \(8\,\text{m/s}\) collides with a stationary \(5\,\text{kg}\) object. They stick together. What is their combined velocity?$t$
  AND option_a = $t$\(4.8\,\text{m/s}\)$t$
  AND option_b = $t$\(3\,\text{m/s}\)$t$
  AND option_c = $t$\(8\,\text{m/s}\)$t$
  AND option_d = $t$\(1.6\,\text{m/s}\)$t$
  AND explanation = $t$Conservation of momentum: \(p\)_before \(= 3 \times 8 = 24\,\text{kg m/s}\). \(p\)_after \(= (3 + 5) \times v = 8v\). \(v = \frac{24}{8} = 3\,\text{m/s}\).$t$;

UPDATE questions SET
  option_a = $t$48.2°$t$,
  option_b = $t$41.8°$t$,
  option_d = $t$30°$t$,
  explanation = $t$sin(c) = 1/n = 1/1.5 = 0.667. c = arcsin(0.667) = 41.8°.$t$
WHERE id = 525
  AND option_a = $t$\(48.2^\circ\)$t$
  AND option_b = $t$\(41.8^\circ\)$t$
  AND option_d = $t$\(30^\circ\)$t$
  AND explanation = $t$\(\sin(c) = \frac{1}{n} = \frac{1}{1.5} = 0.667\). \(c\)= arcsin\((0.667) = 41.8^\circ\).$t$;

UPDATE questions SET
  explanation = $t$Input power = 2000 × 0.5 = 1000 W. Output power = 1000 × 0.95 = 950 W. Is = P/Vs = 950/50 = 19 A.$t$
WHERE id = 526
  AND explanation = $t$Input power \(= 2000 \times 0.5 = 1000\,\text{W}\). Output power \(= 1000 \times 0.95 = 950\,\text{W}\). Is \(= P\)/Vs \(= \frac{950}{50} = 19\,\text{A}\).$t$;

UPDATE questions SET
  question_text = $t$A car travelling at 20 m/s has brakes applied. Braking force = 8000 N, mass = 1000 kg. What is the braking distance?$t$,
  explanation = $t$a = F/m = 8000/1000 = 8 m/s². v² = u² + 2as → 0 = 400 - 2×8×s → s = 400/16 = 25 m.$t$
WHERE id = 527
  AND question_text = $t$A car travelling at \(20\,\text{m/s}\) has brakes applied. Braking force \(= 8000\,\text{N}\), mass \(= 1000\,\text{kg}\). What is the braking distance?$t$
  AND explanation = $t$\(a = \frac{F}{m} = \frac{8000}{1000} = 8\,\text{m/s}^{2}\). \(v^{2} = u^{2} + 2as \to 0 = 400 - 2 \times 8 \times s \to s = \frac{400}{16} = 25 m\).$t$;

UPDATE questions SET
  option_a = $t$100 N m$t$,
  option_b = $t$25 N m$t$,
  option_c = $t$52 N m$t$,
  option_d = $t$50 N m$t$,
  explanation = $t$Moment = Force × perpendicular distance = 50 × 2 = 100 N m.$t$
WHERE id = 529
  AND option_a = $t$100 N \(m\)$t$
  AND option_b = $t$25 N \(m\)$t$
  AND option_c = $t$52 N \(m\)$t$
  AND option_d = $t$50 N \(m\)$t$
  AND explanation = $t$Moment = Force × perpendicular distance \(= 50 \times 2 = 100\,\text{N}\ m\).$t$;

UPDATE questions SET
  question_text = $t$In a nuclear equation: ²³⁵U + ¹n → ¹⁴¹Ba + ⁹²Kr + x ¹n. What is x?$t$,
  explanation = $t$Conservation of mass number: 235 + 1 = 141 + 92 + x. 236 = 233 + x. x = 3. Three neutrons are released in this fission reaction.$t$
WHERE id = 530
  AND question_text = $t$In a nuclear equation: \({}^{235}\text{U}\) + \({}^{1}n \to {}^{141}\text{Ba}\) + \({}^{92}\text{Kr}\) +\(x\) \({}^{1}n\). What is \(x\)?$t$
  AND explanation = $t$Conservation of mass number: \(235 + 1 = 141 + 92 + x\). \(236 = 233 + x\). \(x = 3\). Three neutrons are released in this fission reaction.$t$;

UPDATE questions SET
  option_a = $t$960 m/s$t$,
  option_b = $t$8 m/s$t$,
  option_c = $t$15 m/s$t$,
  option_d = $t$128 m/s$t$,
  explanation = $t$Speed = distance ÷ time = 120 ÷ 8 = 15 m/s.$t$
WHERE id = 832
  AND option_a = $t$\(960\,\text{m/s}\)$t$
  AND option_b = $t$\(8\,\text{m/s}\)$t$
  AND option_c = $t$\(15\,\text{m/s}\)$t$
  AND option_d = $t$\(128\,\text{m/s}\)$t$
  AND explanation = $t$Speed = distance ÷ time \(= 120 \div 8 = 15\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$A cyclist accelerates from 4 m/s to 16 m/s in 6 s. What is the acceleration?$t$,
  option_a = $t$2 m/s²$t$,
  option_b = $t$0.5 m/s²$t$,
  option_c = $t$4 m/s²$t$,
  option_d = $t$2.67 m/s²$t$,
  explanation = $t$a = (v-u)/t = (16-4)/6 = 12/6 = 2 m/s².$t$
WHERE id = 833
  AND question_text = $t$A cyclist accelerates from \(4\,\text{m/s}\) to \(16\,\text{m/s}\) in 6 s. What is the acceleration?$t$
  AND option_a = $t$\(2\,\text{m/s}^{2}\)$t$
  AND option_b = $t$\(0.5\,\text{m/s}^{2}\)$t$
  AND option_c = $t$\(4\,\text{m/s}^{2}\)$t$
  AND option_d = $t$\(2.67\,\text{m/s}^{2}\)$t$
  AND explanation = $t$\(a = \frac{v - u}{t} = \frac{16 - 4}{6} = \frac{12}{6} = 2\,\text{m/s}^{2}\).$t$;

UPDATE questions SET
  question_text = $t$A 5 kg object accelerates at 3 m/s². What resultant force acts on it?$t$,
  explanation = $t$F = ma = 5 × 3 = 15 N.$t$
WHERE id = 835
  AND question_text = $t$A \(5\,\text{kg}\) object accelerates at \(3\,\text{m/s}^{2}\). What resultant force acts on it?$t$
  AND explanation = $t$\(F = ma = 5 \times 3 = 15\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$What is the weight of a 60 kg person? (g = 10 N/kg)$t$,
  explanation = $t$W = mg = 60 × 10 = 600 N.$t$
WHERE id = 836
  AND question_text = $t$What is the weight of \(a\) \(60\,\text{kg}\) person? (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$\(W = mg = 60 \times 10 = 600\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$A 3 kg object moves at 8 m/s. What is its momentum?$t$,
  option_a = $t$24 kg m/s$t$,
  option_b = $t$2.67 kg m/s$t$,
  option_c = $t$0.375 kg m/s$t$,
  option_d = $t$11 kg m/s$t$,
  explanation = $t$p = mv = 3 × 8 = 24 kg m/s.$t$
WHERE id = 837
  AND question_text = $t$A \(3\,\text{kg}\) object moves at \(8\,\text{m/s}\). What is its momentum?$t$
  AND option_a = $t$\(24\,\text{kg m/s}\)$t$
  AND option_b = $t$\(2.67\,\text{kg m/s}\)$t$
  AND option_c = $t$\(0.375\,\text{kg m/s}\)$t$
  AND option_d = $t$\(11\,\text{kg m/s}\)$t$
  AND explanation = $t$\(p = mv = 3 \times 8 = 24\,\text{kg m/s}\).$t$;

UPDATE questions SET
  explanation = $t$Gradient of a v-t graph = change in velocity / time = acceleration. The area under a v-t graph = distance travelled.$t$
WHERE id = 839
  AND explanation = $t$Gradient of \(a v - t\) graph = change in velocity / time = acceleration. The area under \(a v - t\) graph = distance travelled.$t$;

UPDATE questions SET
  question_text = $t$A 1200 kg car changes velocity from 20 m/s to 0 in 4 s. What braking force is needed?$t$,
  explanation = $t$F = ma. a = (0-20)/4 = -5 m/s². F = 1200 × 5 = 6000 N.$t$
WHERE id = 840
  AND question_text = $t$A \(1200\,\text{kg}\) car changes velocity from \(20\,\text{m/s}\) to 0 in 4 s. What braking force is needed?$t$
  AND explanation = $t$\(F = ma\). \(a = \frac{0 - 20}{4} = -5\,\text{m/s}^{2}\). \(F = 1200 \times 5 = 6000\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$A 4 kg ball is lifted 5 m. Using g = 10 N/kg, what GPE does it gain?$t$,
  explanation = $t$GPE = mgh = 4 × 10 × 5 = 200 J.$t$
WHERE id = 841
  AND question_text = $t$A \(4\,\text{kg}\) ball is lifted 5 m. Using \(g = 10\,\text{N/kg}\), what GPE does it gain?$t$
  AND explanation = $t$\(GPE = mgh = 4 \times 10 \times 5 = 200\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$A 2 kg object moves at 6 m/s. What is its kinetic energy?$t$,
  explanation = $t$KE = ½mv² = ½ × 2 × 36 = 36 J.$t$
WHERE id = 842
  AND question_text = $t$A \(2\,\text{kg}\) object moves at \(6\,\text{m/s}\). What is its kinetic energy?$t$
  AND explanation = $t$\(KE = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 2 \times 36 = 36\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$Efficiency = useful output / total input = 350/500 = 0.7 = 70%.$t$
WHERE id = 844
  AND explanation = $t$Efficiency = useful output / total input \(= \frac{350}{500} = 0.7 = 70\%\).$t$;

UPDATE questions SET
  question_text = $t$A spring has spring constant 200 N/m and is compressed by 0.04 m. What elastic PE is stored?$t$,
  explanation = $t$Ee = ½ke² = ½ × 200 × (0.04)² = 100 × 0.0016 = 0.16 J.$t$
WHERE id = 845
  AND question_text = $t$A spring has spring constant \(200\,\text{N/m}\) and is compressed by 0.04 m. What elastic PE is stored?$t$
  AND explanation = $t$Ee \(= \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 200 \times (0.04)^{2} = 100 \times 0.0016 = 0.16\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$A 5 kg object falls freely from rest from a height of 20 m. Using g = 10 N/kg, what is its speed just before hitting the ground?$t$,
  option_a = $t$10 m/s$t$,
  option_b = $t$14.1 m/s$t$,
  option_c = $t$20 m/s$t$,
  option_d = $t$200 m/s$t$,
  explanation = $t$GPE converts to KE: mgh = ½mv². v² = 2gh = 2 × 10 × 20 = 400. v = 20 m/s.$t$
WHERE id = 846
  AND question_text = $t$A \(5\,\text{kg}\) object falls freely from rest from a height of 20 m. Using \(g = 10\,\text{N/kg}\), what is its speed just before hitting the ground?$t$
  AND option_a = $t$\(10\,\text{m/s}\)$t$
  AND option_b = $t$\(14.1\,\text{m/s}\)$t$
  AND option_c = $t$\(20\,\text{m/s}\)$t$
  AND option_d = $t$\(200\,\text{m/s}\)$t$
  AND explanation = $t$GPE converts to KE: \(mgh = \tfrac{1}{2}mv^{2}\). \(v^{2} = 2gh = 2 \times 10 \times 20 = 400\). \(v = 20\,\text{m/s}\).$t$;

UPDATE questions SET
  explanation = $t$P = W/t = 1200 / 120 = 10 W. Convert 2 minutes to 120 seconds first.$t$
WHERE id = 849
  AND explanation = $t$\(P = \frac{W}{t} = \frac{1200}{120} = 10\,\text{W}\). Convert 2 minutes to 120 seconds first.$t$;

UPDATE questions SET
  question_text = $t$A ball of mass 0.5 kg is thrown upwards at 8 m/s. Using energy conservation, what maximum height does it reach? (g = 10 N/kg)$t$,
  explanation = $t$KE at launch = GPE at max height. ½mv² = mgh. h = v²/2g = 64/20 = 3.2 m.$t$
WHERE id = 850
  AND question_text = $t$A ball of mass \(0.5\,\text{kg}\) is thrown upwards at \(8\,\text{m/s}\). Using energy conservation, what maximum height does it reach? (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$KE at launch \(= GPE\) at max height. \(\tfrac{1}{2}mv^{2} = mgh\). \(h = \frac{v^{2}}{2}g = \frac{64}{20} = 3.2\,\text{m}\).$t$;

UPDATE questions SET
  option_a = $t$2 m/s$t$,
  option_b = $t$0.08 m/s$t$,
  option_c = $t$5.4 m/s$t$,
  option_d = $t$12.5 m/s$t$,
  explanation = $t$v = fλ = 5 × 0.4 = 2 m/s.$t$
WHERE id = 853
  AND option_a = $t$\(2\,\text{m/s}\)$t$
  AND option_b = $t$\(0.08\,\text{m/s}\)$t$
  AND option_c = $t$\(5.4\,\text{m/s}\)$t$
  AND option_d = $t$\(12.5\,\text{m/s}\)$t$
  AND explanation = $t$\(v = f\)λ \(= 5 \times 0.4 = 2\,\text{m/s}\).$t$;

UPDATE questions SET
  explanation = $t$T = 1/f = 1/50 = 0.02 s. Period and frequency are reciprocals.$t$
WHERE id = 854
  AND explanation = $t$\(T = \frac{1}{f} = \frac{1}{50} = 0.02\,\text{s}\). Period and frequency are reciprocals.$t$;

UPDATE questions SET
  question_text = $t$A sound wave travels at 340 m/s. If the wavelength is 0.85 m, what is the frequency?$t$,
  explanation = $t$f = v/λ = 340/0.85 = 400 Hz.$t$
WHERE id = 855
  AND question_text = $t$A sound wave travels at \(340\,\text{m/s}\). If the wavelength is 0.85 m, what is the frequency?$t$
  AND explanation = $t$\(f = v\)/λ \(= \frac{340}{0.85} = 400\,\text{Hz}\).$t$;

UPDATE questions SET
  explanation = $t$Speed = 20/5 = 4 cm/s. f = v/λ = 4/2 = 2 Hz.$t$
WHERE id = 860
  AND explanation = $t$Speed \(= \frac{20}{5} = 4\,\text{cm/s}\). \(f = v\)/λ \(= \frac{4}{2} = 2\,\text{Hz}\).$t$;

UPDATE questions SET
  explanation = $t$Alpha (α): 2 protons + 2 neutrons = helium-4 nucleus. Strongly ionising, short range (~5 cm in air), stopped by paper or skin.$t$
WHERE id = 861
  AND explanation = $t$Alpha \((\alpha)\): 2 protons + 2 neutrons = helium-4 nucleus. Strongly ionising, short range (~5 cm in air), stopped by paper or skin.$t$;

UPDATE questions SET
  explanation = $t$9 hours = 3 half-lives. 400 → 200 → 100 → 50. After n half-lives, N = N₀ × (½)ⁿ.$t$
WHERE id = 864
  AND explanation = $t$9 hours \(= 3\) half-lives. \(400 \to 200 \to 100 \to 50\). After \(n\) half-lives, N = N₀ ×\((\tfrac{1}{2})^{n}\).$t$;

UPDATE questions SET
  explanation = $t$Fission: large nucleus (e.g. U-235) splits → energy + neutrons (chain reaction). Fusion: two light nuclei join → large energy release. Stars are powered by fusion.$t$
WHERE id = 866
  AND explanation = $t$Fission: large nucleus (e.g. \(U - 235\)) splits → energy + neutrons (chain reaction). Fusion: two light nuclei join → large energy release. Stars are powered by fusion.$t$;

UPDATE questions SET
  explanation = $t$Only charged particles (alpha +2, beta -1) are deflected by magnetic and electric fields. Gamma has no charge and is unaffected.$t$
WHERE id = 868
  AND explanation = $t$Only charged particles (alpha \(+ 2\), beta \(- 1\)) are deflected by magnetic and electric fields. Gamma has no charge and is unaffected.$t$;

UPDATE questions SET
  explanation = $t$Series: total R = 4+6 = 10 Ω. I = V/R = 20/10 = 2 A.$t$
WHERE id = 871
  AND explanation = $t$Series: total \(R = 4 + 6 = 10\) Ω. \(I = \frac{V}{R} = \frac{20}{10} = 2\,\text{A}\).$t$;

UPDATE questions SET
  explanation = $t$V = IR = 3 × 12 = 36 V.$t$
WHERE id = 872
  AND explanation = $t$\(V = IR = 3 \times 12 = 36 V\).$t$;

UPDATE questions SET
  explanation = $t$I = P/V = 60/230 = 0.26 A.$t$
WHERE id = 875
  AND explanation = $t$\(I = \frac{P}{V} = \frac{60}{230} = 0.26\,\text{A}\).$t$;

UPDATE questions SET
  explanation = $t$P = V²/R = 230²/46 = 52900/46 = 1150 W.$t$
WHERE id = 878
  AND explanation = $t$\(P = \frac{V^{2}}{R} = \frac{230^{2}}{46} = \frac{52900}{46} = 1150\,\text{W}\).$t$;

UPDATE questions SET
  explanation = $t$E = QV = 30 × 6 = 180 J.$t$
WHERE id = 880
  AND explanation = $t$\(E = QV = 30 \times 6 = 180\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$An object has mass 300 g and volume 150 cm³. What is its density?$t$,
  option_a = $t$2000 g/cm³$t$,
  option_b = $t$2 g/cm³$t$,
  option_c = $t$0.5 g/cm³$t$,
  option_d = $t$450 g/cm³$t$,
  explanation = $t$ρ = m/V = 300/150 = 2 g/cm³.$t$
WHERE id = 881
  AND question_text = $t$An object has mass \(300\,\text{g}\) and volume \(150\,\text{cm}^{3}\). What is its density?$t$
  AND option_a = $t$\(2000\,\text{g/cm}^{3}\)$t$
  AND option_b = $t$\(2\,\text{g/cm}^{3}\)$t$
  AND option_c = $t$\(0.5\,\text{g/cm}^{3}\)$t$
  AND option_d = $t$\(450\,\text{g/cm}^{3}\)$t$
  AND explanation = $t$ρ \(= \frac{m}{V} = \frac{300}{150} = 2\,\text{g/cm}^{3}\).$t$;

UPDATE questions SET
  option_a = $t$Energy needed to melt 1 kg of a substance$t$,
  option_c = $t$The energy released when 1 kg cools by 1°C$t$,
  option_d = $t$Energy needed to raise the temperature of 1 kg of a substance by 1°C$t$,
  explanation = $t$SHC (c) unit: J/(kg·°C). Formula: Q = mcΔT. Water has high SHC (4200 J/kg°C) — it absorbs and stores large amounts of heat energy.$t$
WHERE id = 882
  AND option_a = $t$Energy needed to melt \(1\,\text{kg}\) of a substance$t$
  AND option_c = $t$The energy released when \(1\,\text{kg}\) cools by \(1^\circ C\)$t$
  AND option_d = $t$Energy needed to raise the temperature of \(1\,\text{kg}\) of a substance by \(1^\circ C\)$t$
  AND explanation = $t$SHC (\(c\)) unit: J/(kg·°C). Formula: \(Q = mc\)ΔT. Water has high SHC (\(4200\,\text{J/kg°C}\)) — it absorbs and stores large amounts of heat energy.$t$;

UPDATE questions SET
  question_text = $t$3 kg of water (SHC = 4200 J/kg°C) is heated from 20°C to 70°C. How much energy is needed?$t$,
  explanation = $t$Q = mcΔT = 3 × 4200 × 50 = 630 000 J.$t$
WHERE id = 883
  AND question_text = $t$\(3\,\text{kg}\) of water (SHC = \(4200\,\text{J/kg°C}\)) is heated from \(20^\circ C\) to \(70^\circ C\). How much energy is needed?$t$
  AND explanation = $t$\(Q = mc\)Δ\(T = 3 \times 4200 \times 50 = 630\,000\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$Boyle's Law: p₁V₁ = p₂V₂. Halve volume → double pressure (same temperature = same average speed, but more collisions per unit area).$t$
WHERE id = 887
  AND explanation = $t$Boyle's Law: \(p_{1}\)V₁ \(= p_{2}\)V₂. Halve volume → double pressure (same temperature = same average speed, but more collisions per unit area).$t$;

UPDATE questions SET
  question_text = $t$500 g of copper (SHC = 385 J/kg°C) absorbs 1925 J. What is the temperature rise?$t$,
  option_a = $t$2°C$t$,
  option_b = $t$5°C$t$,
  option_c = $t$10°C$t$,
  option_d = $t$0.1°C$t$,
  explanation = $t$ΔT = Q/(mc) = 1925 / (0.5 × 385) = 1925/192.5 = 10°C.$t$
WHERE id = 889
  AND question_text = $t$\(500\,\text{g}\) of copper (SHC = \(385\,\text{J/kg°C}\)) absorbs 1925 J. What is the temperature rise?$t$
  AND option_a = $t$\(2^\circ C\)$t$
  AND option_b = $t$\(5^\circ C\)$t$
  AND option_c = $t$\(10^\circ C\)$t$
  AND option_d = $t$\(0.1^\circ C\)$t$
  AND explanation = $t$Δ\(T = Q /\)(mc) \(= \frac{1925}{0.5 \times 385} = \frac{1925}{192.5} = 10^\circ C\).$t$;

UPDATE questions SET
  explanation = $t$Absolute zero (0 K = −273°C): the lowest possible temperature. Particles have minimum internal energy and (theoretically) zero kinetic energy.$t$
WHERE id = 890
  AND explanation = $t$Absolute zero \((0 K = - 273^\circ C)\): the lowest possible temperature. Particles have minimum internal energy and (theoretically) zero kinetic energy.$t$;

UPDATE questions SET
  option_a = $t$340 m/s$t$,
  option_b = $t$3 × 10¹⁰ m/s$t$,
  option_c = $t$3 × 10⁸ m/s$t$,
  option_d = $t$300 m/s$t$,
  explanation = $t$All EM waves travel at 3 × 10⁸ m/s (the speed of light) in a vacuum. This is the fastest possible speed in the universe.$t$
WHERE id = 891
  AND option_a = $t$\(340\,\text{m/s}\)$t$
  AND option_b = $t$\(3 \times 10^{10}\,\text{m/s}\)$t$
  AND option_c = $t$\(3 \times 10^{8}\,\text{m/s}\)$t$
  AND option_d = $t$\(300\,\text{m/s}\)$t$
  AND explanation = $t$All EM waves travel at \(3 \times 10^{8}\,\text{m/s}\) (the speed of light) in a vacuum. This is the fastest possible speed in the universe.$t$;

UPDATE questions SET
  explanation = $t$The EM spectrum in order of increasing wavelength: gamma → X-ray → UV → visible → IR → microwave → radio. Radio waves have the longest wavelength and lowest frequency.$t$
WHERE id = 892
  AND explanation = $t$The EM spectrum in order of increasing wavelength: gamma →\(X - ray \to UV\)→ visible → IR → microwave → radio. Radio waves have the longest wavelength and lowest frequency.$t$;

UPDATE questions SET
  option_b = $t$Light always reflects at 45°$t$,
  explanation = $t$Law of reflection: angle of incidence (i) = angle of reflection (r), both measured from the normal to the surface at the point of incidence.$t$
WHERE id = 893
  AND option_b = $t$Light always reflects at \(45^\circ\)$t$
  AND explanation = $t$Law of reflection: angle of incidence (i) = angle of reflection (\(r\)), both measured from the normal to the surface at the point of incidence.$t$;

UPDATE questions SET
  option_d = $t$When light refracts at exactly 90°$t$
WHERE id = 895
  AND option_d = $t$When light refracts at exactly \(90^\circ\)$t$;

UPDATE questions SET
  explanation = $t$Below the critical angle: some light refracts out and some reflects. At or above: total internal reflection. For glass-air, critical angle ≈ 42°. sin(c) = 1/n.$t$
WHERE id = 899
  AND explanation = $t$Below the critical angle: some light refracts out and some reflects. At or above: total internal reflection. For glass-air, critical angle \(\approx 42^\circ\). \(\sin(c) = \frac{1}{n}\).$t$;

UPDATE questions SET
  explanation = $t$Gravitational field strength g decreases with distance from the centre of a massive object. On the Moon's surface, g ≈ 1.6 N/kg (compared to 9.8 N/kg on Earth).$t$
WHERE id = 903
  AND explanation = $t$Gravitational field strength \(g\) decreases with distance from the centre of a massive object. On the Moon's surface, \(g\)≈ \(1.6\,\text{N/kg}\) (compared to \(9.8\,\text{N/kg}\) on Earth).$t$;

UPDATE questions SET
  question_text = $t$A 70 kg astronaut weighs 686 N on Earth (g = 9.8 N/kg). What would they weigh on the Moon (g = 1.6 N/kg)?$t$,
  explanation = $t$W = mg = 70 × 1.6 = 112 N. Mass stays the same (70 kg) — weight changes because g is different.$t$
WHERE id = 904
  AND question_text = $t$A \(70\,\text{kg}\) astronaut weighs 686 N on Earth (\(g = 9.8\,\text{N/kg}\)). What would they weigh on the Moon (\(g = 1.6\,\text{N/kg}\))?$t$
  AND explanation = $t$\(W = mg = 70 \times 1.6 = 112\,\text{N}\). Mass stays the same (70 kg) — weight changes because \(g\) is different.$t$;

UPDATE questions SET
  explanation = $t$Massive stars (>8 solar masses): red supergiant → supernova explosion → neutron star (if moderate mass) or black hole (if very massive). Supernovae forge elements heavier than iron.$t$
WHERE id = 910
  AND explanation = $t$Massive stars (\(> 8\) solar masses): red supergiant → supernova explosion → neutron star (if moderate mass) or black hole (if very massive). Supernovae forge elements heavier than iron.$t$;

UPDATE questions SET
  explanation = $t$Work done = force × distance = 40 × 5 = 200 J. Work is only done when the force has a component in the direction of motion.$t$
WHERE id = 911
  AND explanation = $t$Work done = force × distance \(= 40 \times 5 = 200\,\text{J}\). Work is only done when the force has a component in the direction of motion.$t$;

UPDATE questions SET
  explanation = $t$P = W/t = 600/30 = 20 W.$t$
WHERE id = 912
  AND explanation = $t$\(P = \frac{W}{t} = \frac{600}{30} = 20\,\text{W}\).$t$;

UPDATE questions SET
  explanation = $t$E = Pt = 2000 × 300 = 600 000 J. Convert kW to W (×1000) and minutes to seconds (×60).$t$
WHERE id = 914
  AND explanation = $t$E = Pt \(= 2000 \times 300 = 600\,000\,\text{J}\). Convert kW to \(W (\times 1000)\) and minutes to seconds \((\times 60)\).$t$;

UPDATE questions SET
  option_d = $t$High voltage means low current, which reduces energy lost as heat in the cables (P_loss = I²R)$t$,
  explanation = $t$P_loss = I²R. High voltage = low current = much lower power loss in cables. Step-up transformers at power stations increase voltage; step-down transformers reduce it for safe domestic use.$t$
WHERE id = 915
  AND option_d = $t$High voltage means low current, which reduces energy lost as heat in the cables (P_loss \(= I^{2}R\))$t$
  AND explanation = $t$P_loss \(= I^{2}R\). High voltage \(= low\) current = much lower power loss in cables. Step-up transformers at power stations increase voltage; step-down transformers reduce it for safe domestic use.$t$;

UPDATE questions SET
  explanation = $t$Useful output = efficiency × input = 0.65 × 200 = 130 W.$t$
WHERE id = 916
  AND explanation = $t$Useful output = efficiency × input \(= 0.65 \times 200 = 130\,\text{W}\).$t$;

UPDATE questions SET
  explanation = $t$60 W = 0.06 kW. Energy = 0.06 × 2 = 0.12 kWh. The kWh is the unit used on electricity bills.$t$
WHERE id = 917
  AND explanation = $t$\(60 W = 0.06\,\text{kW}\). Energy \(= 0.06 \times 2 = 0.12\,\text{kWh}\). The kWh is the unit used on electricity bills.$t$;

UPDATE questions SET
  explanation = $t$Vs/Vp = Ns/Np → Vs = 230 × (5000/500) = 230 × 10 = 2300 V.$t$
WHERE id = 919
  AND explanation = $t$Vs/Vp = Ns/Np → Vs \(= 230 \times (\frac{5000}{500}) = 230 \times 10 = 2300\,\text{V}\).$t$;

UPDATE questions SET
  explanation = $t$Work done = force × distance moved. If the object does not move, distance = 0, so work done = 0 J. The person exerts a force but no energy is transferred to the box.$t$
WHERE id = 920
  AND explanation = $t$Work done = force × distance moved. If the object does not move, distance \(= 0\), so work done \(= 0\,\text{J}\). The person exerts a force but no energy is transferred to the box.$t$;

UPDATE questions SET
  explanation = $t$Moment (N m) = force (N) × perpendicular distance from pivot (m). A larger force or greater distance creates a larger turning effect.$t$
WHERE id = 922
  AND explanation = $t$Moment (N \(m\)) = force (N) × perpendicular distance from pivot (\(m\)). A larger force or greater distance creates a larger turning effect.$t$;

UPDATE questions SET
  option_a = $t$1500 N m$t$,
  option_b = $t$240 N m$t$,
  option_d = $t$600.4 N m$t$,
  explanation = $t$M = Fd = 600 × 0.4 = 240 N m.$t$
WHERE id = 923
  AND option_a = $t$1500 N \(m\)$t$
  AND option_b = $t$240 N \(m\)$t$
  AND option_d = $t$600.4 N \(m\)$t$
  AND explanation = $t$M = Fd \(= 600 \times 0.4 = 240\,\text{N}\ m\).$t$;

UPDATE questions SET
  option_c = $t$Sum of clockwise moments = sum of anticlockwise moments$t$
WHERE id = 924
  AND option_c = $t$Sum of clockwise moments \(= sum\) of anticlockwise moments$t$;

UPDATE questions SET
  question_text = $t$A force of 800 N acts on an area of 0.04 m². What is the pressure?$t$,
  explanation = $t$P = F/A = 800/0.04 = 20 000 Pa.$t$
WHERE id = 925
  AND question_text = $t$A force of 800 N acts on an area of \(0.04 m^{2}\). What is the pressure?$t$
  AND explanation = $t$\(P = \frac{F}{A} = \frac{800}{0.04} = 20\,000\,\text{Pa}\).$t$;

UPDATE questions SET
  explanation = $t$P = hρg. Pressure increases with depth (h), fluid density (ρ) and gravitational field strength (g). Deeper water has more fluid above pressing down.$t$
WHERE id = 927
  AND explanation = $t$\(P = h\)ρ\(g\). Pressure increases with depth (\(h\)), fluid density (ρ) and gravitational field strength (\(g\)). Deeper water has more fluid above pressing down.$t$;

UPDATE questions SET
  explanation = $t$For equilibrium: F × 1.5 = 30. F = 30/1.5 = 20 N.$t$
WHERE id = 928
  AND explanation = $t$For equilibrium: \(F \times 1.5 = 30\). \(F = \frac{30}{1.5} = 20\,\text{N}\).$t$;

UPDATE questions SET
  explanation = $t$Upthrust = weight in air − apparent weight in water = 50 − 32 = 18 N.$t$
WHERE id = 929
  AND explanation = $t$Upthrust = weight in air − apparent weight in water \(= 50 - 32 = 18\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$What is pressure at depth 4 m in water? (ρ = 1000 kg/m³, g = 10 N/kg)$t$,
  explanation = $t$P = hρg = 4 × 1000 × 10 = 40 000 Pa. This is the pressure due to the water above — atmospheric pressure would be added for total pressure.$t$
WHERE id = 930
  AND question_text = $t$What is pressure at depth 4 m in water? (ρ = \(1000\,\text{kg/m}^{3}\), \(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$\(P = h\)ρ\(g = 4 \times 1000 \times 10 = 40\,000\,\text{Pa}\). This is the pressure due to the water above — atmospheric pressure would be added for total pressure.$t$;

UPDATE questions SET
  explanation = $t$Parallel plates create a uniform electric field between them — equally spaced parallel field lines pointing from + to − plate. Field strength = V/d.$t$
WHERE id = 940
  AND explanation = $t$Parallel plates create a uniform electric field between them — equally spaced parallel field lines pointing from + to − plate. Field strength \(= \frac{V}{d}\).$t$;

UPDATE questions SET
  option_b = $t$The direction of force on a current-carrying conductor in a magnetic field (FBI rule: thumb = Force, index = B field, middle = current I)$t$
WHERE id = 944
  AND option_b = $t$The direction of force on a current-carrying conductor in a magnetic field (FBI rule: thumb = Force, index \(= B\) field, middle = current I)$t$;

UPDATE questions SET
  explanation = $t$F = BIL = 0.3 × 5 × 0.2 = 0.3 N.$t$
WHERE id = 945
  AND explanation = $t$\(F = BIL = 0.3 \times 5 \times 0.2 = 0.3\,\text{N}\).$t$;

UPDATE questions SET
  explanation = $t$F = BIL. Force increases with: greater magnetic flux density (B), higher current (I), or longer wire in the field (L).$t$
WHERE id = 948
  AND explanation = $t$\(F = BIL\). Force increases with: greater magnetic flux density (B), higher current (I), or longer wire in the field (L).$t$;

UPDATE questions SET
  explanation = $t$Vs/Vp = Ns/Np → Vs = 50 × (800/200) = 50 × 4 = 200 V. Step-up transformer.$t$
WHERE id = 955
  AND explanation = $t$Vs/Vp = Ns/Np → Vs \(= 50 \times (\frac{800}{200}) = 50 \times 4 = 200\,\text{V}\). Step-up transformer.$t$;

UPDATE questions SET
  explanation = $t$For ideal transformer: VpIp = VsIs. 240 × 0.5 = 12 × Is. Is = 120/12 = 10 A. Step-down in voltage = step-up in current.$t$
WHERE id = 957
  AND explanation = $t$For ideal transformer: VpIp = VsIs. \(240 \times 0.5 = 12\)× Is. Is \(= \frac{120}{12} = 10\,\text{A}\). Step-down in voltage = step-up in current.$t$;

UPDATE questions SET
  option_c = $t$Step-up transformers increase voltage and decrease current at power stations — lower current means less I²R heat loss in cables$t$,
  explanation = $t$P_loss = I²R. Doubling voltage halves current, reducing power loss by factor of 4. The National Grid transmits at ~400 000 V to minimise losses over long distances.$t$
WHERE id = 959
  AND option_c = $t$Step-up transformers increase voltage and decrease current at power stations — lower current means less \(I^{2}R\) heat loss in cables$t$
  AND explanation = $t$P_loss \(= I^{2}R\). Doubling voltage halves current, reducing power loss by factor of 4. The National Grid transmits at ~400 000 V to minimise losses over long distances.$t$;

UPDATE questions SET
  option_d = $t$Force is proportional to extension (F = ke) provided the elastic limit is not exceeded$t$,
  explanation = $t$Hooke's Law: F = ke where k is the spring constant (N/m) and e is the extension (m). Valid only up to the elastic limit (limit of proportionality).$t$
WHERE id = 962
  AND option_d = $t$Force is proportional to extension \((F = ke)\) provided the elastic limit is not exceeded$t$
  AND explanation = $t$Hooke's Law: \(F = ke\) where \(k\) is the spring constant (N/m) and \(e\) is the extension (\(m\)). Valid only up to the elastic limit (limit of proportionality).$t$;

UPDATE questions SET
  question_text = $t$A spring has spring constant 250 N/m. A 2 kg mass (W = 20 N) is hung from it. What is the extension?$t$,
  explanation = $t$F = ke → e = F/k = 20/250 = 0.08 m.$t$
WHERE id = 963
  AND question_text = $t$A spring has spring constant \(250\,\text{N/m}\). A \(2\,\text{kg}\) mass \((W = 20\,\text{N})\) is hung from it. What is the extension?$t$
  AND explanation = $t$\(F = ke \to e = \frac{F}{k} = \frac{20}{250} = 0.08\,\text{m}\).$t$;

UPDATE questions SET
  option_a = $t$The spring constant k$t$,
  explanation = $t$F = ke → gradient of F vs e graph = k (spring constant). Steeper gradient = stiffer spring = larger k.$t$
WHERE id = 964
  AND option_a = $t$The spring constant \(k\)$t$
  AND explanation = $t$\(F = ke\)→ gradient of F vs \(e\) graph \(= k\) (spring constant). Steeper gradient = stiffer spring = larger \(k\).$t$;

UPDATE questions SET
  question_text = $t$What is the elastic potential energy stored in a spring with k = 400 N/m compressed by 0.05 m?$t$,
  explanation = $t$Ee = ½ke² = ½ × 400 × (0.05)² = 200 × 0.0025 = 0.5 J.$t$
WHERE id = 965
  AND question_text = $t$What is the elastic potential energy stored in a spring with \(k = 400\,\text{N/m}\) compressed by 0.05 m?$t$
  AND explanation = $t$Ee \(= \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 400 \times (0.05)^{2} = 200 \times 0.0025 = 0.5\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$Area under F-x graph = ½Fx = ½ke² = elastic PE stored. This is the energy stored in the spring when it is stretched or compressed.$t$
WHERE id = 966
  AND explanation = $t$Area under \(F - x\) graph \(= \tfrac{1}{2}\)Fx \(= \tfrac{1}{2}ke^{2}\)= elastic PE stored. This is the energy stored in the spring when it is stretched or compressed.$t$;

UPDATE questions SET
  question_text = $t$Two identical springs (k = 100 N/m each) are connected in series. What is the combined spring constant?$t$,
  option_a = $t$200 N/m$t$,
  option_b = $t$25 N/m$t$,
  option_c = $t$50 N/m$t$,
  option_d = $t$100 N/m$t$,
  explanation = $t$Springs in series: 1/k_total = 1/k₁ + 1/k₂ = 1/100 + 1/100 = 2/100. k_total = 50 N/m. Series springs are less stiff.$t$
WHERE id = 968
  AND question_text = $t$Two identical springs (\(k = 100\,\text{N/m}\) each) are connected in series. What is the combined spring constant?$t$
  AND option_a = $t$\(200\,\text{N/m}\)$t$
  AND option_b = $t$\(25\,\text{N/m}\)$t$
  AND option_c = $t$\(50\,\text{N/m}\)$t$
  AND option_d = $t$\(100\,\text{N/m}\)$t$
  AND explanation = $t$Springs in series: \(\frac{1}{k}\)_total \(= \frac{1}{k_{1}} + \frac{1}{k_{2}} = \frac{1}{100} + \frac{1}{100} = \frac{2}{100}\). \(k\)_total = \(50\,\text{N/m}\). Series springs are less stiff.$t$;

UPDATE questions SET
  question_text = $t$What force is needed to stretch a spring by 6 cm if its spring constant is 150 N/m?$t$,
  explanation = $t$Convert: 6 cm = 0.06 m. F = ke = 150 × 0.06 = 9 N.$t$
WHERE id = 969
  AND question_text = $t$What force is needed to stretch a spring by 6 cm if its spring constant is \(150\,\text{N/m}\)?$t$
  AND explanation = $t$Convert: \(6\,\text{cm} = 0.06\,\text{m}\). \(F = ke = 150 \times 0.06 = 9\,\text{N}\).$t$;

UPDATE questions SET
  explanation = $t$Upthrust = weight in air − apparent weight in liquid = 30 − 22 = 8 N.$t$
WHERE id = 970
  AND explanation = $t$Upthrust = weight in air − apparent weight in liquid \(= 30 - 22 = 8\,\text{N}\).$t$;

UPDATE questions SET
  option_a = $t$5 m/s$t$,
  option_b = $t$20 m/s$t$,
  option_c = $t$4500 m/s$t$,
  option_d = $t$45 m/s$t$,
  explanation = $t$Average speed = distance / time = 300 / 15 = 20 m/s.$t$
WHERE id = 2174
  AND option_a = $t$\(5\,\text{m/s}\)$t$
  AND option_b = $t$\(20\,\text{m/s}\)$t$
  AND option_c = $t$\(4500\,\text{m/s}\)$t$
  AND option_d = $t$\(45\,\text{m/s}\)$t$
  AND explanation = $t$Average speed = distance / time \(= \frac{300}{15} = 20\,\text{m/s}\).$t$;

UPDATE questions SET
  option_d = $t$Rate of change of velocity — how quickly velocity changes. a = change in velocity / time$t$,
  explanation = $t$Acceleration = Δv / t. It can be positive (speeding up) negative (slowing down) or represent a change in direction.$t$
WHERE id = 2176
  AND option_d = $t$Rate of change of velocity — how quickly velocity changes. \(a\)= change in velocity / time$t$
  AND explanation = $t$Acceleration = Δ\(\frac{v}{t}\). It can be positive (speeding up) negative (slowing down) or represent a change in direction.$t$;

UPDATE questions SET
  question_text = $t$A resultant force of 30 N acts on a 6 kg object. What is the acceleration?$t$,
  option_a = $t$180 m/s2$t$,
  option_b = $t$0.2 m/s2$t$,
  option_c = $t$5 m/s2$t$,
  option_d = $t$36 m/s2$t$,
  explanation = $t$F = ma so a = F/m = 30/6 = 5 m/s2.$t$
WHERE id = 2177
  AND question_text = $t$A resultant force of 30 N acts on \(a\) \(6\,\text{kg}\) object. What is the acceleration?$t$
  AND option_a = $t$\(180\,\text{m/s}^{2}\)$t$
  AND option_b = $t$\(0.2\,\text{m/s}^{2}\)$t$
  AND option_c = $t$\(5\,\text{m/s}^{2}\)$t$
  AND option_d = $t$\(36\,\text{m/s}^{2}\)$t$
  AND explanation = $t$\(F = ma\) so \(a = \frac{F}{m} = \frac{30}{6} = 5\,\text{m/s}^{2}\).$t$;

UPDATE questions SET
  explanation = $t$Force is measured in Newtons (N). 1 N is the force needed to accelerate 1 kg at 1 m/s2.$t$
WHERE id = 2179
  AND explanation = $t$Force is measured in Newtons (N). 1 N is the force needed to accelerate \(1\,\text{kg}\) at \(1\,\text{m/s}^{2}\).$t$;

UPDATE questions SET
  explanation = $t$Mass is constant everywhere. Weight = mg so it varies with gravitational field strength g.$t$
WHERE id = 2180
  AND explanation = $t$Mass is constant everywhere. Weight \(= mg\) so it varies with gravitational field strength \(g\).$t$;

UPDATE questions SET
  explanation = $t$Braking distance depends on kinetic energy (KE = 1/2 mv2) which is proportional to v2. Double speed = four times the braking distance.$t$
WHERE id = 2182
  AND explanation = $t$Braking distance depends on kinetic energy \((KE = \frac{1}{2} mv^{2})\) which is proportional to \(v^{2}\). Double speed = four times the braking distance.$t$;

UPDATE questions SET
  explanation = $t$Gradient = Δv / Δt = acceleration. Positive gradient means speeding up; negative means decelerating.$t$
WHERE id = 2183
  AND explanation = $t$Gradient = Δ\(v\)/ Δ\(t\)= acceleration. Positive gradient means speeding up; negative means decelerating.$t$;

UPDATE questions SET
  explanation = $t$Area under a v-t graph = displacement. For a rectangle: v x t = distance. For a triangle: 1/2 x base x height.$t$
WHERE id = 2184
  AND explanation = $t$Area under \(a v - t\) graph = displacement. For a rectangle: \(v \times t\)= distance. For a triangle: \(\frac{1}{2} x\) base × height.$t$;

UPDATE questions SET
  question_text = $t$A vehicle at 25 m/s brakes to rest in 5 seconds. What is the deceleration?$t$,
  option_a = $t$5 m/s2$t$,
  option_b = $t$125 m/s2$t$,
  option_c = $t$0.2 m/s2$t$,
  option_d = $t$30 m/s2$t$,
  explanation = $t$Deceleration = change in velocity / time = 25 / 5 = 5 m/s2.$t$
WHERE id = 2185
  AND question_text = $t$A vehicle at \(25\,\text{m/s}\) brakes to rest in 5 seconds. What is the deceleration?$t$
  AND option_a = $t$\(5\,\text{m/s}^{2}\)$t$
  AND option_b = $t$\(125\,\text{m/s}^{2}\)$t$
  AND option_c = $t$\(0.2\,\text{m/s}^{2}\)$t$
  AND option_d = $t$\(30\,\text{m/s}^{2}\)$t$
  AND explanation = $t$Deceleration = change in velocity / time \(= \frac{25}{5} = 5\,\text{m/s}^{2}\).$t$;

UPDATE questions SET
  option_b = $t$Mass times velocity (p = mv) measured in kg m/s$t$,
  explanation = $t$Momentum p = mv. It is a vector quantity with unit kg m/s. The total momentum of a closed system is conserved.$t$
WHERE id = 2186
  AND option_b = $t$Mass times velocity \((p = mv)\) measured in kg m/s$t$
  AND explanation = $t$Momentum \(p = mv\). It is a vector quantity with unit kg m/s. The total momentum of a closed system is conserved.$t$;

UPDATE questions SET
  explanation = $t$At terminal velocity: weight = air resistance → resultant force = 0 → no acceleration → constant velocity.$t$
WHERE id = 2188
  AND explanation = $t$At terminal velocity: weight \(= air\) resistance → resultant force \(= 0\)→ no acceleration → constant velocity.$t$;

UPDATE questions SET
  option_a = $t$F = ma$t$
WHERE id = 2189
  AND option_a = $t$\(F = ma\)$t$;

UPDATE questions SET
  explanation = $t$Impulse = F x t = change in momentum. Spreading a force over longer time reduces peak force — the principle behind crumple zones.$t$
WHERE id = 2190
  AND explanation = $t$Impulse \(= F \times t\)= change in momentum. Spreading a force over longer time reduces peak force — the principle behind crumple zones.$t$;

UPDATE questions SET
  question_text = $t$A 1000 kg car travels at 20 m/s. Calculate its momentum.$t$,
  option_a = $t$20,000 kg m/s$t$,
  option_b = $t$50 kg m/s$t$,
  option_c = $t$200 kg m/s$t$,
  option_d = $t$2,000,000 kg m/s$t$,
  explanation = $t$p = mv = 1000 x 20 = 20,000 kg m/s.$t$
WHERE id = 2191
  AND question_text = $t$A \(1000\,\text{kg}\) car travels at \(20\,\text{m/s}\). Calculate its momentum.$t$
  AND option_a = $t$\(20\,000\,\text{kg m/s}\)$t$
  AND option_b = $t$\(50\,\text{kg m/s}\)$t$
  AND option_c = $t$\(200\,\text{kg m/s}\)$t$
  AND option_d = $t$\(2\,000\,000\,\text{kg m/s}\)$t$
  AND explanation = $t$\(p = mv = 1000 \times 20 = 20\,000\,\text{kg m/s}\).$t$;

UPDATE questions SET
  explanation = $t$Thinking distance = speed x reaction time. Anything increasing reaction time or speed increases thinking distance.$t$
WHERE id = 2192
  AND explanation = $t$Thinking distance = speed × reaction time. Anything increasing reaction time or speed increases thinking distance.$t$;

UPDATE questions SET
  question_text = $t$A 1500 kg car at 20 m/s collides with a stationary 500 kg car and they stick together. Calculate their combined velocity after the collision.$t$,
  option_a = $t$20 m/s$t$,
  option_b = $t$10 m/s$t$,
  option_c = $t$15 m/s$t$,
  option_d = $t$5 m/s$t$,
  explanation = $t$Conservation of momentum: 1500 x 20 + 500 x 0 = 2000 x v. v = 30,000 / 2000 = 15 m/s.$t$
WHERE id = 2193
  AND question_text = $t$A \(1500\,\text{kg}\) car at \(20\,\text{m/s}\) collides with a stationary \(500\,\text{kg}\) car and they stick together. Calculate their combined velocity after the collision.$t$
  AND option_a = $t$\(20\,\text{m/s}\)$t$
  AND option_b = $t$\(10\,\text{m/s}\)$t$
  AND option_c = $t$\(15\,\text{m/s}\)$t$
  AND option_d = $t$\(5\,\text{m/s}\)$t$
  AND explanation = $t$Conservation of momentum: \(1500 \times 20 + 500 \times 0 = 2000 \times v\). \(v = \frac{30\,000}{2000} = 15\,\text{m/s}\).$t$;

UPDATE questions SET
  option_a = $t$They extend the collision time increasing Δt so for the same change in momentum (F = Δp/Δt) the force on passengers is reduced$t$,
  explanation = $t$Impulse = F x t = Δp. For fixed Δp increasing t reduces F. Crumple zones extend deceleration time from milliseconds to tens of milliseconds.$t$
WHERE id = 2194
  AND option_a = $t$They extend the collision time increasing Δ\(t\) so for the same change in momentum (F = Δ\(p\)/Δ\(t\)) the force on passengers is reduced$t$
  AND explanation = $t$Impulse \(= F \times t\)= Δ\(p\). For fixed Δ\(p\) increasing \(t\) reduces F. Crumple zones extend deceleration time from milliseconds to tens of milliseconds.$t$;

UPDATE questions SET
  question_text = $t$A velocity-time graph shows uniform acceleration from 0 to 30 m/s over 10 s then constant velocity for 10 s. Calculate total distance.$t$,
  explanation = $t$Phase 1 (acceleration): area of triangle = 1/2 x 10 x 30 = 150 m. Phase 2 (constant): rectangle = 10 x 30 = 300 m. Total = 450 m.$t$
WHERE id = 2195
  AND question_text = $t$A velocity-time graph shows uniform acceleration from 0 to \(30\,\text{m/s}\) over 10 s then constant velocity for 10 s. Calculate total distance.$t$
  AND explanation = $t$Phase 1 (acceleration): area of triangle \(= \frac{1}{2} \times 10 \times 30 = 150\,\text{m}\). Phase 2 (constant): rectangle \(= 10 \times 30 = 300\,\text{m}\). Total \(= 450\,\text{m}\).$t$;

UPDATE questions SET
  question_text = $t$A 500 N force acts on a 50 kg object for 4 seconds from rest. Calculate final velocity.$t$,
  option_a = $t$10 m/s$t$,
  option_b = $t$2000 m/s$t$,
  option_c = $t$40 m/s$t$,
  option_d = $t$0.4 m/s$t$,
  explanation = $t$a = F/m = 500/50 = 10 m/s2. v = u + at = 0 + 10 x 4 = 40 m/s.$t$
WHERE id = 2196
  AND question_text = $t$A 500 N force acts on \(a\) \(50\,\text{kg}\) object for 4 seconds from rest. Calculate final velocity.$t$
  AND option_a = $t$\(10\,\text{m/s}\)$t$
  AND option_b = $t$\(2000\,\text{m/s}\)$t$
  AND option_c = $t$\(40\,\text{m/s}\)$t$
  AND option_d = $t$\(0.4\,\text{m/s}\)$t$
  AND explanation = $t$\(a = \frac{F}{m} = \frac{500}{50} = 10\,\text{m/s}^{2}\). \(v = u\)+ at \(= 0 + 10 \times 4 = 40\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$Calculate the braking force needed to stop a 1200 kg car travelling at 30 m/s in 6 seconds.$t$,
  option_c = $t$36,000 N$t$,
  option_d = $t$216,000 N$t$,
  explanation = $t$a = Δv/t = 30/6 = 5 m/s2. F = ma = 1200 x 5 = 6000 N.$t$
WHERE id = 2198
  AND question_text = $t$Calculate the braking force needed to stop \(a\) \(1200\,\text{kg}\) car travelling at \(30\,\text{m/s}\) in 6 seconds.$t$
  AND option_c = $t$36 000 N$t$
  AND option_d = $t$216 000 N$t$
  AND explanation = $t$\(a\)= Δ\(\frac{v}{t} = \frac{30}{6} = 5\,\text{m/s}^{2}\). \(F = ma = 1200 \times 5 = 6000\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$A skydiver of mass 80 kg reaches terminal velocity. What is the air resistance force?$t$,
  explanation = $t$At terminal velocity resultant force = 0. Air resistance = weight = mg = 80 x 10 = 800 N.$t$
WHERE id = 2200
  AND question_text = $t$A skydiver of mass \(80\,\text{kg}\) reaches terminal velocity. What is the air resistance force?$t$
  AND explanation = $t$At terminal velocity resultant force \(= 0\). Air resistance = weight \(= mg = 80 \times 10 = 800\,\text{N}\).$t$;

UPDATE questions SET
  option_c = $t$Inertia is the resistance to changes in motion. Greater mass means greater inertia — a larger force is needed to achieve the same acceleration (F = ma)$t$,
  explanation = $t$Mass is the quantitative measure of inertia. A 10 kg object needs 10x more force than a 1 kg object for the same acceleration.$t$
WHERE id = 2201
  AND option_c = $t$Inertia is the resistance to changes in motion. Greater mass means greater inertia — a larger force is needed to achieve the same acceleration \((F = ma)\)$t$
  AND explanation = $t$Mass is the quantitative measure of inertia. A \(10\,\text{kg}\) object needs 10× more force than \(a\) \(1\,\text{kg}\) object for the same acceleration.$t$;

UPDATE questions SET
  explanation = $t$F = Δp/Δt. Seat belts increase the time over which momentum changes reducing peak force and therefore injury severity.$t$
WHERE id = 2202
  AND explanation = $t$F = Δ\(p\)/Δ\(t\). Seat belts increase the time over which momentum changes reducing peak force and therefore injury severity.$t$;

UPDATE questions SET
  option_a = $t$GPE = mass x velocity$t$,
  option_b = $t$GPE = 1/2 x mass x velocity squared$t$,
  option_c = $t$GPE = mass x gravitational field strength x height (GPE = mgh)$t$,
  option_d = $t$GPE = force x time$t$,
  explanation = $t$GPE = mgh where m = mass (kg) g = gravitational field strength (N/kg) h = height (m). On Earth g ≈ 9.8 N/kg.$t$
WHERE id = 2204
  AND option_a = $t$GPE = mass × velocity$t$
  AND option_b = $t$\(GPE = \frac{1}{2} x\) mass × velocity squared$t$
  AND option_c = $t$GPE = mass × gravitational field strength × height \((GPE = mgh)\)$t$
  AND option_d = $t$GPE = force × time$t$
  AND explanation = $t$\(GPE = mgh\) where \(m\)= mass (kg) \(g\)= gravitational field strength (N/kg) \(h\)= height (\(m\)). On Earth \(g\)≈ \(9.8\,\text{N/kg}\).$t$;

UPDATE questions SET
  question_text = $t$A 2 kg book is placed on a shelf 3 m high. Calculate its GPE. (g = 10 N/kg)$t$,
  explanation = $t$GPE = mgh = 2 x 10 x 3 = 60 J.$t$
WHERE id = 2205
  AND question_text = $t$A \(2\,\text{kg}\) book is placed on a shelf 3 m high. Calculate its GPE. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$\(GPE = mgh = 2 \times 10 \times 3 = 60\,\text{J}\).$t$;

UPDATE questions SET
  option_a = $t$KE = mass x velocity$t$,
  option_b = $t$KE = 1/2 x mass x velocity squared$t$,
  option_c = $t$KE = mass x gravitational field strength x height$t$,
  option_d = $t$KE = force x distance$t$,
  explanation = $t$KE = 1/2 mv2. KE depends on velocity squared — doubling speed quadruples kinetic energy.$t$
WHERE id = 2206
  AND option_a = $t$KE = mass × velocity$t$
  AND option_b = $t$\(KE = \frac{1}{2} x\) mass × velocity squared$t$
  AND option_c = $t$KE = mass × gravitational field strength × height$t$
  AND option_d = $t$KE = force × distance$t$
  AND explanation = $t$\(KE = \frac{1}{2} mv^{2}\). KE depends on velocity squared — doubling speed quadruples kinetic energy.$t$;

UPDATE questions SET
  question_text = $t$Calculate the KE of a 4 kg ball moving at 5 m/s.$t$,
  explanation = $t$KE = 1/2 mv2 = 1/2 x 4 x 25 = 50 J.$t$
WHERE id = 2207
  AND question_text = $t$Calculate the KE of \(a\) \(4\,\text{kg}\) ball moving at \(5\,\text{m/s}\).$t$
  AND explanation = $t$\(KE = \frac{1}{2} mv^{2} = \frac{1}{2} \times 4 \times 25 = 50\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$Efficiency = useful energy output / total energy input. Always ≤ 1 (100%) due to conservation of energy.$t$
WHERE id = 2208
  AND explanation = $t$Efficiency = useful energy output / total energy input. Always \(\le 1 (100\%)\) due to conservation of energy.$t$;

UPDATE questions SET
  explanation = $t$Efficiency = 50/200 = 0.25 = 25%. The other 75 J is wasted as thermal energy (heat).$t$
WHERE id = 2209
  AND explanation = $t$Efficiency \(= \frac{50}{200} = 0.25 = 25\%\). The other 75 J is wasted as thermal energy (heat).$t$;

UPDATE questions SET
  question_text = $t$A 3 kg ball is dropped from 5 m. Calculate its speed just before impact. (g = 10 N/kg ignore air resistance)$t$,
  option_a = $t$15 m/s$t$,
  option_b = $t$7.7 m/s$t$,
  option_c = $t$30 m/s$t$,
  option_d = $t$10 m/s$t$,
  explanation = $t$GPE = KE: mgh = 1/2 mv2 → v2 = 2gh = 2 x 10 x 5 = 100 → v = 10 m/s. Mass cancels.$t$
WHERE id = 2213
  AND question_text = $t$A \(3\,\text{kg}\) ball is dropped from 5 m. Calculate its speed just before impact. (\(g = 10\,\text{N/kg}\) ignore air resistance)$t$
  AND option_a = $t$\(15\,\text{m/s}\)$t$
  AND option_b = $t$\(7.7\,\text{m/s}\)$t$
  AND option_c = $t$\(30\,\text{m/s}\)$t$
  AND option_d = $t$\(10\,\text{m/s}\)$t$
  AND explanation = $t$\(GPE = KE\): \(mgh = \frac{1}{2} mv^{2} \to v^{2} = 2gh = 2 \times 10 \times 5 = 100 \to v = 10\,\text{m/s}\). Mass cancels.$t$;

UPDATE questions SET
  explanation = $t$Useful output = efficiency x input = 0.75 x 400 = 300 W.$t$
WHERE id = 2214
  AND explanation = $t$Useful output = efficiency × input \(= 0.75 \times 400 = 300\,\text{W}\).$t$;

UPDATE questions SET
  option_b = $t$Force x mass — measured in newtons$t$,
  option_c = $t$Rate of energy transfer. P = E/t. Unit: watt (W) where 1 W = 1 J/s$t$,
  option_d = $t$Efficiency x speed$t$
WHERE id = 2215
  AND option_b = $t$Force \(x\) mass — measured in newtons$t$
  AND option_c = $t$Rate of energy transfer. \(P = \frac{E}{t}\). Unit: watt (W) where 1 \(W = 1\,\text{J/s}\)$t$
  AND option_d = $t$Efficiency \(x\) speed$t$;

UPDATE questions SET
  option_b = $t$Energy required to raise the temperature of 1 kg of a substance by 1 degree C. Equation: Q = mcΔT$t$,
  option_c = $t$Energy released when 1 kg of fuel burns$t$,
  explanation = $t$Q = mcΔT where c is specific heat capacity (J/kg°C). Water has c = 4200 J/kg°C — very high making it an excellent coolant.$t$
WHERE id = 2216
  AND option_b = $t$Energy required to raise the temperature of \(1\,\text{kg}\) of a substance by 1 degree C. Equation: \(Q = mc\)ΔT$t$
  AND option_c = $t$Energy released when \(1\,\text{kg}\) of fuel burns$t$
  AND explanation = $t$\(Q = mc\)ΔT where \(c\) is specific heat capacity (J/kg°C). Water has \(c = 4200\,\text{J/kg°C}\) — very high making it an excellent coolant.$t$;

UPDATE questions SET
  question_text = $t$Calculate the energy needed to heat 3 kg of water from 20°C to 80°C. (c = 4200 J/kg°C)$t$,
  option_a = $t$252,000 J$t$,
  option_b = $t$84,000 J$t$,
  option_c = $t$756,000 J$t$,
  option_d = $t$1,008,000 J$t$,
  explanation = $t$Q = mcΔT = 3 x 4200 x 60 = 756,000 J.$t$
WHERE id = 2217
  AND question_text = $t$Calculate the energy needed to heat \(3\,\text{kg}\) of water from \(20^\circ C\) to \(80^\circ C\). (\(c = 4200\,\text{J/kg°C}\))$t$
  AND option_a = $t$252 000 J$t$
  AND option_b = $t$84 000 J$t$
  AND option_c = $t$756 000 J$t$
  AND option_d = $t$1 008 000 J$t$
  AND explanation = $t$\(Q = mc\)Δ\(T = 3 \times 4200 \times 60 = 756\,000\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$A spring stores 80 J of elastic PE. This is entirely converted to KE in a 0.2 kg object. Calculate the objects speed.$t$,
  option_a = $t$400 m/s$t$,
  option_b = $t$20 m/s$t$,
  option_c = $t$28.3 m/s$t$,
  option_d = $t$40 m/s$t$,
  explanation = $t$80 = 1/2 x 0.2 x v2 = 0.1v2. v2 = 800. v = √800 ≈ 28.3 m/s.$t$
WHERE id = 2218
  AND question_text = $t$A spring stores 80 J of elastic PE. This is entirely converted to KE in \(a\) \(0.2\,\text{kg}\) object. Calculate the objects speed.$t$
  AND option_a = $t$\(400\,\text{m/s}\)$t$
  AND option_b = $t$\(20\,\text{m/s}\)$t$
  AND option_c = $t$\(28.3\,\text{m/s}\)$t$
  AND option_d = $t$\(40\,\text{m/s}\)$t$
  AND explanation = $t$\(80 = \frac{1}{2} \times 0.2 \times v^{2} = 0.1v2\). \(v^{2} = 800\). \(v = \sqrt{800}\)≈ \(28.3\,\text{m/s}\).$t$;

UPDATE questions SET
  explanation = $t$Non-renewables will eventually be exhausted and most produce CO2 contributing to climate change. Renewables are sustainable but some are intermittent.$t$
WHERE id = 2219
  AND explanation = $t$Non-renewables will eventually be exhausted and most produce CO₂ contributing to climate change. Renewables are sustainable but some are intermittent.$t$;

UPDATE questions SET
  explanation = $t$Efficiency = 70/100 = 70%. Wasted = 100 - 70 = 30 kW dissipated as thermal energy.$t$
WHERE id = 2220
  AND explanation = $t$Efficiency \(= \frac{70}{100} = 70\%\). Wasted \(= 100 - 70 = 30\,\text{kW}\) dissipated as thermal energy.$t$;

UPDATE questions SET
  question_text = $t$A 60 kg person runs up stairs of height 4 m in 8 seconds. Calculate their useful power output. (g = 10 N/kg)$t$,
  explanation = $t$Work done = mgh = 60 x 10 x 4 = 2400 J. Power = W/t = 2400/8 = 300 W.$t$
WHERE id = 2221
  AND question_text = $t$A \(60\,\text{kg}\) person runs up stairs of height 4 m in 8 seconds. Calculate their useful power output. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Work done \(= mgh = 60 \times 10 \times 4 = 2400\,\text{J}\). Power \(= \frac{W}{t} = \frac{2400}{8} = 300\,\text{W}\).$t$;

UPDATE questions SET
  option_c = $t$The electric motor acts as a generator during braking — converting kinetic energy back to electrical energy stored in the battery. This recovers 60-70% of energy that would otherwise be wasted as heat in conventional brakes$t$
WHERE id = 2224
  AND option_c = $t$The electric motor acts as a generator during braking — converting kinetic energy back to electrical energy stored in the battery. This recovers 60–70% of energy that would otherwise be wasted as heat in conventional brakes$t$;

UPDATE questions SET
  question_text = $t$A student heats a 1 kg copper block with a 40 W heater for 5 minutes and records a 100°C temperature rise. Calculate the specific heat capacity.$t$,
  option_a = $t$400 J/kg°C$t$,
  option_b = $t$120 J/kg°C$t$,
  option_c = $t$4200 J/kg°C$t$,
  option_d = $t$2400 J/kg°C$t$,
  explanation = $t$Energy supplied = P x t = 40 x 300 = 12,000 J. Q = mcΔT: 12,000 = 1 x c x 100. c = 120 J/kg°C. (Accepted value for copper is 385 J/kg°C — difference reflects heat losses.)$t$
WHERE id = 2225
  AND question_text = $t$A student heats \(a\) \(1\,\text{kg}\) copper block with a 40 W heater for 5 minutes and records \(a 100^\circ C\) temperature rise. Calculate the specific heat capacity.$t$
  AND option_a = $t$\(400\,\text{J/kg°C}\)$t$
  AND option_b = $t$\(120\,\text{J/kg°C}\)$t$
  AND option_c = $t$\(4200\,\text{J/kg°C}\)$t$
  AND option_d = $t$\(2400\,\text{J/kg°C}\)$t$
  AND explanation = $t$Energy supplied \(= P \times t = 40 \times 300 = 12\,000\,\text{J}\). \(Q = mc\)ΔT: \(12\,000 = 1 \times c \times 100\). \(c = 120\,\text{J/kg°C}\). (Accepted value for copper is \(385\,\text{J/kg°C}\) — difference reflects heat losses.)$t$;

UPDATE questions SET
  explanation = $t$Energy before = mgh1 = 30m. Energy after = mgh2 = 24m. Lost = 6m. % lost = 6/30 x 100 = 20%.$t$
WHERE id = 2226
  AND explanation = $t$Energy before \(= mgh1 = 30m\). Energy after \(= mgh^{2} = 24m\). Lost \(= 6m\). % lost \(= \frac{6}{30} \times 100 = 20\%\).$t$;

UPDATE questions SET
  question_text = $t$A hydroelectric dam generates 200 MW. Water falls 40 m at 100,000 kg/s. Calculate efficiency. (g = 10 N/kg)$t$,
  explanation = $t$Available power = mgh/t = 100,000 x 10 x 40 = 40,000,000 W = 400 MW. Efficiency = 200/400 = 50%.$t$
WHERE id = 2227
  AND question_text = $t$A hydroelectric dam generates 200 MW. Water falls 40 m at \(100\,000\,\text{kg/s}\). Calculate efficiency. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Available power \(= \frac{mgh}{t} = 100\,000 \times 10 \times 40 = 40\,000\,000 W = 400\,\text{MW}\). Efficiency \(= \frac{200}{400} = 50\%\).$t$;

UPDATE questions SET
  option_a = $t$Heat is lost from homes mainly through the roof (approximately 25%). Loft insulation traps air (a poor heat conductor) reducing conduction and convection losses. Less energy is needed to maintain temperature reducing fuel bills and CO2 emissions$t$
WHERE id = 2228
  AND option_a = $t$Heat is lost from homes mainly through the roof (approximately 25%). Loft insulation traps air (a poor heat conductor) reducing conduction and convection losses. Less energy is needed to maintain temperature reducing fuel bills and CO₂ emissions$t$;

UPDATE questions SET
  option_a = $t$Nuclear power produces large CO2 emissions$t$,
  option_d = $t$Nuclear power has lifecycle emissions ~12 g CO2/kWh — comparable to wind and solar. Advantages: reliable baseload; high energy density; low land use. Disadvantages: radioactive waste requiring storage for thousands of years; high construction cost; finite uranium; accident risk. Overall it is low-carbon but whether it is truly sustainable depends on timescale and waste management$t$,
  explanation = $t$The IPCC includes nuclear in low-carbon pathways for 1.5°C. The waste and safety concerns are real but manageable compared to the scale of climate change risk.$t$
WHERE id = 2229
  AND option_a = $t$Nuclear power produces large CO₂ emissions$t$
  AND option_d = $t$Nuclear power has lifecycle emissions ~\(12\,\text{g}\) CO₂/kWh — comparable to wind and solar. Advantages: reliable baseload; high energy density; low land use. Disadvantages: radioactive waste requiring storage for thousands of years; high construction cost; finite uranium; accident risk. Overall it is low-carbon but whether it is truly sustainable depends on timescale and waste management$t$
  AND explanation = $t$The IPCC includes nuclear in low-carbon pathways for \(1.5^\circ C\). The waste and safety concerns are real but manageable compared to the scale of climate change risk.$t$;

UPDATE questions SET
  question_text = $t$Why does GPE = mgh only apply near Earths surface?$t$,
  option_b = $t$GPE = mgh only applies to objects heavier than 1 kg$t$,
  option_c = $t$It assumes g is constant. Near Earths surface g varies less than 0.3% up to 10 km altitude so the approximation is excellent. At large heights (satellites) g decreases significantly with distance (g ∝ 1/r2) and the full equation U = -GMm/r must be used$t$,
  explanation = $t$For Earth-based problems h << Earths radius (6400 km) so g ≈ constant is valid. For orbital mechanics the inverse square law form of gravitational PE must be used.$t$
WHERE id = 2230
  AND question_text = $t$Why does \(GPE = mgh\) only apply near Earths surface?$t$
  AND option_b = $t$\(GPE = mgh\) only applies to objects heavier than 1 kg$t$
  AND option_c = $t$It assumes \(g\) is constant. Near Earths surface \(g\) varies less than 0.3% up to 10 km altitude so the approximation is excellent. At large heights (satellites) g decreases significantly with distance \((g \propto \frac{1}{r^{2}})\) and the full equation \(U =\)-GMm/\(r\) must be used$t$
  AND explanation = $t$For Earth-based problems \(h\)<< Earths radius (6400 km) so \(g\)≈ constant is valid. For orbital mechanics the inverse square law form of gravitational PE must be used.$t$;

UPDATE questions SET
  option_b = $t$Petrol ~46 MJ/kg; lithium-ion batteries ~0.7-0.9 MJ/kg — petrol has ~50x greater energy density by mass. EVs must carry much heavier batteries for the same energy stored. However EVs are ~3-4x more efficient at converting stored energy to motion (~85% vs ~25% for petrol engines) partially compensating for lower energy density$t$,
  explanation = $t$A 100 kWh EV battery weighs ~600 kg vs ~8 kg for equivalent petrol. The efficiency advantage means EVs need less total energy per km despite lower storage density.$t$
WHERE id = 2231
  AND option_b = $t$Petrol ~\(46\,\text{MJ/kg}\); lithium-ion batteries ~0.7–\(0.9\,\text{MJ/kg}\) — petrol has ~50× greater energy density by mass. EVs must carry much heavier batteries for the same energy stored. However EVs are ~3–4× more efficient at converting stored energy to motion (~85% vs ~25% for petrol engines) partially compensating for lower energy density$t$
  AND explanation = $t$A 100 kWh EV battery weighs ~\(600\,\text{kg}\) vs ~\(8\,\text{kg}\) for equivalent petrol. The efficiency advantage means EVs need less total energy per km despite lower storage density.$t$;

UPDATE questions SET
  option_a = $t$Economically: reduced energy bills for households and industry; less generation capacity needed. Environmentally: less fuel burned means lower CO2 emissions; less resource extraction; reduced thermal pollution. Energy efficiency is often the most cost-effective way to reduce emissions — cheaper than building new low-carbon generation$t$,
  explanation = $t$The IEA identifies energy efficiency as the single most cost-effective tool for reducing CO2 emissions. Buildings account for ~40% of energy use — insulation and efficient heating can reduce this by 50-80%.$t$
WHERE id = 2232
  AND option_a = $t$Economically: reduced energy bills for households and industry; less generation capacity needed. Environmentally: less fuel burned means lower CO₂ emissions; less resource extraction; reduced thermal pollution. Energy efficiency is often the most cost-effective way to reduce emissions — cheaper than building new low-carbon generation$t$
  AND explanation = $t$The IEA identifies energy efficiency as the single most cost-effective tool for reducing CO₂ emissions. Buildings account for ~40% of energy use — insulation and efficient heating can reduce this by 50–80%.$t$;

UPDATE questions SET
  explanation = $t$Wavelength is measured from crest to crest (or trough to trough). It is linked to frequency and speed by v = fλ.$t$
WHERE id = 2235
  AND explanation = $t$Wavelength is measured from crest to crest (or trough to trough). It is linked to frequency and speed by \(v = f\)λ.$t$;

UPDATE questions SET
  explanation = $t$Frequency (f) measured in Hz. 1 Hz = 1 complete wave per second. Related to period by f = 1/T.$t$
WHERE id = 2236
  AND explanation = $t$Frequency (\(f\)) measured in Hz. \(1\,\text{Hz} = 1\) complete wave per second. Related to period by \(f = \frac{1}{T}\).$t$;

UPDATE questions SET
  option_b = $t$v = fλ (wave speed = frequency x wavelength)$t$,
  explanation = $t$v = fλ. If frequency = 200 Hz and wavelength = 1.7 m then speed = 340 m/s (speed of sound in air).$t$
WHERE id = 2237
  AND option_b = $t$\(v = f\)λ (wave speed = frequency × wavelength)$t$
  AND explanation = $t$\(v = f\)λ. If frequency \(= 200\,\text{Hz}\) and wavelength \(= 1.7\,\text{m}\) then speed = \(340\,\text{m/s}\) (speed of sound in air).$t$;

UPDATE questions SET
  option_c = $t$Time for one complete oscillation to pass a fixed point. T = 1/f. Unit: seconds$t$,
  explanation = $t$Period T = 1/f. A 10 Hz wave has T = 0.1 s. A 50 Hz wave has T = 0.02 s.$t$
WHERE id = 2239
  AND option_c = $t$Time for one complete oscillation to pass a fixed point. \(T = \frac{1}{f}\). Unit: seconds$t$
  AND explanation = $t$Period \(T = \frac{1}{f}\). A 10 Hz wave has \(T = 0.1\,\text{s}\). A 50 Hz wave has \(T = 0.02\,\text{s}\).$t$;

UPDATE questions SET
  question_text = $t$A sound wave has frequency 680 Hz and speed 340 m/s. Calculate its wavelength.$t$,
  option_b = $t$231,200 m$t$,
  explanation = $t$λ = v/f = 340/680 = 0.5 m.$t$
WHERE id = 2243
  AND question_text = $t$A sound wave has frequency 680 Hz and speed \(340\,\text{m/s}\). Calculate its wavelength.$t$
  AND option_b = $t$231 200 m$t$
  AND explanation = $t$λ \(= \frac{v}{f} = \frac{340}{680} = 0.5\,\text{m}\).$t$;

UPDATE questions SET
  explanation = $t$When light slows in glass: f is unchanged (set by the source); since v = fλ and v decreases λ must decrease proportionally.$t$
WHERE id = 2244
  AND explanation = $t$When light slows in glass: \(f\) is unchanged (set by the source); since \(v = f\)λ and \(v\) decreases λ must decrease proportionally.$t$;

UPDATE questions SET
  option_a = $t$n = speed of light in vacuum / speed of light in medium (n = c/v). Higher n means light travels more slowly and bends more at the boundary$t$,
  explanation = $t$n = c/v. For glass n ≈ 1.5 meaning light travels at 2x10^8 m/s in glass. Also n = sin(i)/sin(r) by Snells law.$t$
WHERE id = 2246
  AND option_a = $t$\(n\)= speed of light in vacuum / speed of light in medium \((n = \frac{c}{v})\). Higher \(n\) means light travels more slowly and bends more at the boundary$t$
  AND explanation = $t$\(n = \frac{c}{v}\). For glass \(n \approx 1.5\) meaning light travels at \(2x10^{8}\,\text{m/s}\) in glass. Also \(n = \frac{\sin(i)}{\sin(r)}\) by Snells law.$t$;

UPDATE questions SET
  explanation = $t$Critical angle c: sin(c) = 1/n. For glass (n=1.5): c ≈ 42°. Above this angle all light reflects — no refraction. Used in optical fibres and endoscopes.$t$
WHERE id = 2247
  AND explanation = $t$Critical angle \(c\): \(\sin(c) = \frac{1}{n}\). For glass \((n = 1.5)\): \(c \approx 42^\circ\). Above this angle all light reflects — no refraction. Used in optical fibres and endoscopes.$t$;

UPDATE questions SET
  explanation = $t$Ultrasound (>20 kHz) is safe for fetal scanning because it is non-ionising. Depth = v x t/2 where v ≈ 1540 m/s in tissue.$t$
WHERE id = 2248
  AND explanation = $t$Ultrasound \((> 20\,\text{kHz})\) is safe for fetal scanning because it is non-ionising. Depth \(= v \times \frac{t}{2}\) where \(v\)≈ \(1540\,\text{m/s}\) in tissue.$t$;

UPDATE questions SET
  option_a = $t$30°$t$,
  option_b = $t$60°$t$,
  option_c = $t$90°$t$,
  option_d = $t$42°$t$,
  explanation = $t$sin(c) = 1/n = 1/1.5 = 0.667. c = sin-1(0.667) ≈ 41.8° ≈ 42°.$t$
WHERE id = 2250
  AND option_a = $t$\(30^\circ\)$t$
  AND option_b = $t$\(60^\circ\)$t$
  AND option_c = $t$\(90^\circ\)$t$
  AND option_d = $t$\(42^\circ\)$t$
  AND explanation = $t$\(\sin(c) = \frac{1}{n} = \frac{1}{1.5} = 0.667\). \(c\)= sin-1\((0.667) \approx 41.8^\circ \approx 42^\circ\).$t$;

UPDATE questions SET
  option_a = $t$600 m/s$t$,
  option_b = $t$100 m/s$t$,
  option_c = $t$1,000 m/s$t$,
  option_d = $t$10,000 m/s$t$,
  explanation = $t$Distance = 4,800,000 m. Time = 480 s. Speed = 4,800,000/480 = 10,000 m/s.$t$
WHERE id = 2252
  AND option_a = $t$\(600\,\text{m/s}\)$t$
  AND option_b = $t$\(100\,\text{m/s}\)$t$
  AND option_c = $t$\(1\,000\,\text{m/s}\)$t$
  AND option_d = $t$\(10\,000\,\text{m/s}\)$t$
  AND explanation = $t$Distance \(= 4\,800\,000\,\text{m}\). Time \(= 480\,\text{s}\). Speed \(= \frac{4\,800\,000}{480} = 10\,000\,\text{m/s}\).$t$;

UPDATE questions SET
  option_b = $t$Active noise cancellation generates an anti-phase sound wave (180° out of phase) via a speaker. This interferes destructively with the external noise — compressions meet rarefactions and cancel. Most effective at low frequencies where electronics can process fast enough$t$
WHERE id = 2254
  AND option_b = $t$Active noise cancellation generates an anti-phase sound wave (\(180^\circ\) out of phase) via a speaker. This interferes destructively with the external noise — compressions meet rarefactions and cancel. Most effective at low frequencies where electronics can process fast enough$t$;

UPDATE questions SET
  question_text = $t$Calculate the depth of the sea floor if a sonar pulse returns after 0.6 seconds. (speed of sound in water = 1500 m/s)$t$,
  explanation = $t$Total distance = 1500 x 0.6 = 900 m. Sound travels down AND back so depth = 900/2 = 450 m.$t$
WHERE id = 2255
  AND question_text = $t$Calculate the depth of the sea floor if a sonar pulse returns after 0.6 seconds. (speed of sound in water = \(1500\,\text{m/s}\))$t$
  AND explanation = $t$Total distance \(= 1500 \times 0.6 = 900\,\text{m}\). Sound travels down AND back so depth \(= \frac{900}{2} = 450\,\text{m}\).$t$;

UPDATE questions SET
  option_b = $t$X-rays have wavelengths (0.01-10 nm) comparable to atomic spacing in crystals (~0.1-1 nm). When X-rays hit a crystal the regular atomic array diffracts them — producing an interference pattern that reveals atomic positions. Visible light wavelengths (~500 nm) are far too large to resolve atomic-scale features$t$,
  explanation = $t$Braggs law: nλ = 2d sinθ links X-ray wavelength diffraction angle and atomic spacing. This technique revealed the DNA double helix structure.$t$
WHERE id = 2256
  AND option_b = $t$X-rays have wavelengths (0.01–10 nm) comparable to atomic spacing in crystals (~0.1–1 nm). When X-rays hit a crystal the regular atomic array diffracts them — producing an interference pattern that reveals atomic positions. Visible light wavelengths (~500 nm) are far too large to resolve atomic-scale features$t$
  AND explanation = $t$Braggs law: \(n\)λ \(= 2d \sin \theta\) links X-ray wavelength diffraction angle and atomic spacing. This technique revealed the DNA double helix structure.$t$;

UPDATE questions SET
  question_text = $t$A water wave has speed 3 m/s and wavelength 0.5 m. Calculate frequency. Then if speed halves in shallower water what happens to wavelength?$t$,
  option_a = $t$f = 6 Hz; wavelength stays 0.5 m$t$,
  option_b = $t$f = 6 Hz; wavelength halves to 0.25 m$t$,
  option_c = $t$f = 1.5 Hz; wavelength doubles$t$,
  option_d = $t$f = 6 Hz; wavelength doubles to 1 m$t$,
  explanation = $t$f = v/λ = 3/0.5 = 6 Hz. In shallow water v halves to 1.5 m/s but f is unchanged (determined by source). New λ = v/f = 1.5/6 = 0.25 m.$t$
WHERE id = 2258
  AND question_text = $t$A water wave has speed \(3\,\text{m/s}\) and wavelength 0.5 m. Calculate frequency. Then if speed halves in shallower water what happens to wavelength?$t$
  AND option_a = $t$\(f = 6\,\text{Hz}\); wavelength stays 0.5 m$t$
  AND option_b = $t$\(f = 6\,\text{Hz}\); wavelength halves to 0.25 m$t$
  AND option_c = $t$\(f = 1.5\,\text{Hz}\); wavelength doubles$t$
  AND option_d = $t$\(f = 6\,\text{Hz}\); wavelength doubles to 1 m$t$
  AND explanation = $t$\(f = v\)/λ \(= \frac{3}{0.5} = 6\,\text{Hz}\). In shallow water \(v\) halves to \(1.5\,\text{m/s}\) but \(f\) is unchanged (determined by source). New λ \(= \frac{v}{f} = \frac{1.5}{6} = 0.25\,\text{m}\).$t$;

UPDATE questions SET
  explanation = $t$Galaxies show redshift (not blueshift) — recession. The further away the greater the redshift (Hubbles law: v = H0 d). This is direct evidence for an expanding universe.$t$
WHERE id = 2261
  AND explanation = $t$Galaxies show redshift (not blueshift) — recession. The further away the greater the redshift (Hubbles law: \(v = H0 d\)). This is direct evidence for an expanding universe.$t$;

UPDATE questions SET
  option_c = $t$A family of transverse waves all travelling at the same speed in a vacuum (~3x10^8 m/s) with different frequencies and wavelengths. From longest to shortest wavelength: radio microwaves infrared visible UV X-rays gamma rays$t$,
  explanation = $t$All EM waves travel at c = 3x10^8 m/s in vacuum. They differ in frequency and wavelength. Higher frequency = higher energy per photon.$t$
WHERE id = 2263
  AND option_c = $t$A family of transverse waves all travelling at the same speed in a vacuum (~\(3x10^{8}\,\text{m/s}\)) with different frequencies and wavelengths. From longest to shortest wavelength: radio microwaves infrared visible UV X-rays gamma rays$t$
  AND explanation = $t$All EM waves travel at \(c = 3x10^{8}\,\text{m/s}\) in vacuum. They differ in frequency and wavelength. Higher frequency = higher energy per photon.$t$;

UPDATE questions SET
  explanation = $t$UV (wavelength 10-400 nm) has enough energy per photon to damage DNA. The ozone layer absorbs UVC and most UVB. Beneficial: stimulates vitamin D synthesis.$t$
WHERE id = 2266
  AND explanation = $t$UV (wavelength 10–400 nm) has enough energy per photon to damage DNA. The ozone layer absorbs UVC and most UVB. Beneficial: stimulates vitamin D synthesis.$t$;

UPDATE questions SET
  option_a = $t$Medical imaging — X-rays penetrate soft tissue but are absorbed by bone producing images that show fractures and dense structures. Also used in CT scanning to produce 3D images. Ionising so exposure is minimised$t$,
  explanation = $t$X-ray imaging: bones appear white (high absorption) soft tissue grey air black. CT uses multiple X-ray images at different angles to produce 3D reconstructions.$t$
WHERE id = 2267
  AND option_a = $t$Medical imaging — X-rays penetrate soft tissue but are absorbed by bone producing images that show fractures and dense structures. Also used in CT scanning to produce \(3D\) images. Ionising so exposure is minimised$t$
  AND explanation = $t$X-ray imaging: bones appear white (high absorption) soft tissue grey air black. CT uses multiple X-ray images at different angles to produce \(3D\) reconstructions.$t$;

UPDATE questions SET
  explanation = $t$Ionisation threshold ~10 eV corresponding to UV wavelengths. Gamma photons carry MeV — enormous ionising power. Visible light photons (<3 eV) cannot ionise.$t$
WHERE id = 2269
  AND explanation = $t$Ionisation threshold ~10 eV corresponding to UV wavelengths. Gamma photons carry MeV — enormous ionising power. Visible light photons \((< 3\,\text{eV})\) cannot ionise.$t$;

UPDATE questions SET
  explanation = $t$Retinal burns occur because the lens focuses the beam to a ~10-20 micrometre spot. Even milliwatt laser powers create irradiances sufficient to coagulate tissue in milliseconds.$t$
WHERE id = 2270
  AND explanation = $t$Retinal burns occur because the lens focuses the beam to \(a\) ~10–20 micrometre spot. Even milliwatt laser powers create irradiances sufficient to coagulate tissue in milliseconds.$t$;

UPDATE questions SET
  explanation = $t$Communications use specific frequency bands: AM radio (540-1600 kHz) FM radio (88-108 MHz) 4G/5G mobile (700 MHz-6 GHz) WiFi (2.4/5 GHz) satellite (12-18 GHz). Higher frequency = more data capacity.$t$
WHERE id = 2272
  AND explanation = $t$Communications use specific frequency bands: AM radio (540–1600 kHz) FM radio (88–108 MHz) \(\frac{4G}{5}G\) mobile (700 MHz-6 GHz) WiFi (\(\frac{2.4}{5}\) GHz) satellite (12–18 GHz). Higher frequency = more data capacity.$t$;

UPDATE questions SET
  option_a = $t$Speed = 3x10^8 m/s; critical angle = 90°$t$,
  option_b = $t$Speed = 1.875x10^8 m/s; critical angle ≈ 39°$t$,
  option_c = $t$Speed = 4.8x10^8 m/s; critical angle = 48°$t$,
  option_d = $t$Speed = 1.5x10^8 m/s; critical angle = 30°$t$,
  explanation = $t$v = c/n = 3x10^8/1.6 = 1.875x10^8 m/s. sin(c) = 1/1.6 = 0.625. c = sin-1(0.625) ≈ 38.7° ≈ 39°.$t$
WHERE id = 2273
  AND option_a = $t$Speed \(= 3x10^{8}\,\text{m/s}\); critical angle \(= 90^\circ\)$t$
  AND option_b = $t$Speed \(= 1.875x10^{8}\,\text{m/s}\); critical angle \(\approx 39^\circ\)$t$
  AND option_c = $t$Speed \(= 4.8x10^{8}\,\text{m/s}\); critical angle \(= 48^\circ\)$t$
  AND option_d = $t$Speed \(= 1.5x10^{8}\,\text{m/s}\); critical angle \(= 30^\circ\)$t$
  AND explanation = $t$\(v = \frac{c}{n} = \frac{3x10^{8}}{1.6} = 1.875x10^{8}\,\text{m/s}\). \(\sin(c) = \frac{1}{1.6} = 0.625\). \(c\)= sin-1\((0.625) \approx 38.7^\circ \approx 39^\circ\).$t$;

UPDATE questions SET
  question_text = $t$Calculate the frequency and energy of a UV photon with wavelength 250 nm. (c = 3x10^8 m/s h = 6.63x10^-34 J s)$t$,
  option_a = $t$f = 8.33x10^14 Hz; E = 5.5x10^-19 J$t$,
  option_b = $t$f = 1.2x10^9 Hz; E = 7.96x10^-25 J$t$,
  option_c = $t$f = 3x10^14 Hz; E = 2x10^-19 J$t$,
  option_d = $t$f = 1.2x10^15 Hz; E = 7.96x10^-19 J$t$,
  explanation = $t$f = c/λ = 3x10^8/250x10^-9 = 1.2x10^15 Hz. E = hf = 6.63x10^-34 x 1.2x10^15 = 7.96x10^-19 J ≈ 5 eV.$t$
WHERE id = 2278
  AND question_text = $t$Calculate the frequency and energy of a UV photon with wavelength 250 nm. \((c = 3x10^{8}\,\text{m/s}\ h = 6.63x10^{-34}\,\text{J}\ s)\)$t$
  AND option_a = $t$\(f = 8.33x10^{14}\,\text{Hz}\); \(E = 5.5x10^{-19}\,\text{J}\)$t$
  AND option_b = $t$\(f = 1.2x10^{9}\,\text{Hz}\); \(E = 7.96x10^{-25}\,\text{J}\)$t$
  AND option_c = $t$\(f = 3x10^{14}\,\text{Hz}\); \(E = 2x10^{-19}\,\text{J}\)$t$
  AND option_d = $t$\(f = 1.2x10^{15}\,\text{Hz}\); \(E = 7.96x10^{-19}\,\text{J}\)$t$
  AND explanation = $t$\(f = c\)/λ \(= \frac{3x10^{8}}{250}x10^{-9} = 1.2x10^{15}\,\text{Hz}\). \(E = hf = 6.63x10^{-34} \times 1.2x10^{15} = 7.96x10^{-19}\,\text{J} \approx 5\,\text{eV}\).$t$;

UPDATE questions SET
  option_b = $t$Mobile phones emit microwaves (~900-2100 MHz). These are non-ionising — photon energy is far below the ~10 eV needed to ionise atoms; the only direct biological effect is heating. WHO classifies mobile RF as Group 2B (possibly carcinogenic — same category as coffee) as a precautionary classification. Large prospective studies have found no increased cancer risk at typical exposure levels. Current consensus: no confirmed health risk but monitoring continues$t$,
  option_d = $t$Microwaves are ionising above 5 GHz making 5G networks dangerous$t$,
  explanation = $t$The IARC 2B classification is widely misunderstood — it means evidence is limited not that risk is confirmed. SAR limits are set conservatively below known thermal effect thresholds.$t$
WHERE id = 2279
  AND option_b = $t$Mobile phones emit microwaves (~900–2100 MHz). These are non-ionising — photon energy is far below the ~10 eV needed to ionise atoms; the only direct biological effect is heating. WHO classifies mobile RF as Group \(2B\) (possibly carcinogenic — same category as coffee) as a precautionary classification. Large prospective studies have found no increased cancer risk at typical exposure levels. Current consensus: no confirmed health risk but monitoring continues$t$
  AND option_d = $t$Microwaves are ionising above 5 GHz making \(5G\) networks dangerous$t$
  AND explanation = $t$The \(IARC 2B\) classification is widely misunderstood — it means evidence is limited not that risk is confirmed. SAR limits are set conservatively below known thermal effect thresholds.$t$;

UPDATE questions SET
  option_c = $t$White light enters a spherical raindrop and refracts (with dispersion — different wavelengths refract by different amounts). Light then reflects off the inside of the drop (TIR or partial reflection) and refracts again on exit with further dispersion. The geometry means red exits at ~42° and violet at ~40° from the antisolar point — producing the coloured arc with red on the outside$t$,
  explanation = $t$Each colour appears from a specific angle: red from higher droplets at 42° violet from lower droplets at 40°. The sky inside a rainbow is brighter because light scatters inside the arc.$t$
WHERE id = 2280
  AND option_c = $t$White light enters a spherical raindrop and refracts (with dispersion — different wavelengths refract by different amounts). Light then reflects off the inside of the drop (TIR or partial reflection) and refracts again on exit with further dispersion. The geometry means red exits at ~\(42^\circ\) and violet at ~\(40^\circ\) from the antisolar point — producing the coloured arc with red on the outside$t$
  AND explanation = $t$Each colour appears from a specific angle: red from higher droplets at \(42^\circ\) violet from lower droplets at \(40^\circ\). The sky inside a rainbow is brighter because light scatters inside the arc.$t$;

UPDATE questions SET
  option_b = $t$When UV light hits a metal surface electrons are ejected. Red light cannot eject electrons regardless of intensity. Einstein explained this: light energy is quantised in photons each with energy E = hf. Only photons with sufficient energy (high enough frequency) can eject an electron. This demonstrates the particle-like nature of light — energy is delivered in discrete packets not as a continuous wave$t$
WHERE id = 2281
  AND option_b = $t$When UV light hits a metal surface electrons are ejected. Red light cannot eject electrons regardless of intensity. Einstein explained this: light energy is quantised in photons each with energy \(E = hf\). Only photons with sufficient energy (high enough frequency) can eject an electron. This demonstrates the particle-like nature of light — energy is delivered in discrete packets not as a continuous wave$t$;

UPDATE questions SET
  explanation = $t$Stellar spectroscopy underpins all of astrophysics. Hubble used galaxy redshifts to discover the expanding universe. Modern spectrographs can detect velocities of 30 cm/s — enough to detect Earth-mass exoplanets.$t$
WHERE id = 2282
  AND explanation = $t$Stellar spectroscopy underpins all of astrophysics. Hubble used galaxy redshifts to discover the expanding universe. Modern spectrographs can detect velocities of \(30\,\text{cm/s}\) — enough to detect Earth-mass exoplanets.$t$;

UPDATE questions SET
  option_a = $t$Hubbles law states that the recession velocity of a galaxy is proportional to its distance: v = H0 x d where H0 is the Hubble constant (approximately 70 km/s/Mpc). If galaxies are currently moving apart they must have been closer together in the past. Extrapolating backward all matter would have originated from a single point. The time elapsed since that origin is approximately 1/H0 giving an estimated age of approximately 14 billion years consistent with the accepted value of 13.8 billion years.$t$,
  explanation = $t$Using H0 = 70 km/s/Mpc: 1/H0 = 1/(70 km/s/Mpc) = approximately 14 billion years. This is consistent with ages of the oldest stars measured independently from stellar physics.$t$
WHERE id = 2306
  AND option_a = $t$Hubbles law states that the recession velocity of a galaxy is proportional to its distance: \(v = H0 \times d\) where H0 is the Hubble constant (approximately \(70\,\text{km/s/Mpc}\)). If galaxies are currently moving apart they must have been closer together in the past. Extrapolating backward all matter would have originated from a single point. The time elapsed since that origin is approximately \(\frac{1}{H0}\) giving an estimated age of approximately 14 billion years consistent with the accepted value of 13.8 billion years.$t$
  AND explanation = $t$Using H0 = \(70\,\text{km/s/Mpc}\): \(\frac{1}{H0} = 1 /\)(\(70\,\text{km/s/Mpc}\)) = approximately 14 billion years. This is consistent with ages of the oldest stars measured independently from stellar physics.$t$;

UPDATE questions SET
  explanation = $t$Hydrostatic equilibrium: P_gravity = P_thermal + P_radiation. This self-regulating balance is maintained throughout the entire main sequence lifetime of the star.$t$
WHERE id = 2307
  AND explanation = $t$Hydrostatic equilibrium: P_gravity \(= P\)_thermal + P_radiation. This self-regulating balance is maintained throughout the entire main sequence lifetime of the star.$t$;

UPDATE questions SET
  option_b = $t$Gravitational waves are ripples in the fabric of spacetime caused by the acceleration of massive objects — a prediction of Einsteins general theory of relativity made in 1916. When two black holes spiral together and merge they produce oscillating distortions of spacetime propagating outward at the speed of light. LIGO detected these in 2015 measuring a change in the 4 km arm length of approximately 10^-18 m. This was significant because: (1) it directly confirmed a major prediction of general relativity untested for 100 years; (2) it opened a completely new observational window — gravitational wave astronomy can detect events such as black hole mergers that produce no electromagnetic radiation; (3) the neutron star merger detected in 2017 confirmed that short gamma ray bursts originate from such events.$t$
WHERE id = 2312
  AND option_b = $t$Gravitational waves are ripples in the fabric of spacetime caused by the acceleration of massive objects — a prediction of Einsteins general theory of relativity made in 1916. When two black holes spiral together and merge they produce oscillating distortions of spacetime propagating outward at the speed of light. LIGO detected these in 2015 measuring a change in the 4 km arm length of approximately \(10^{-18}\,\text{m}\). This was significant because: (1) it directly confirmed a major prediction of general relativity untested for 100 years; (2) it opened a completely new observational window — gravitational wave astronomy can detect events such as black hole mergers that produce no electromagnetic radiation; (3) the neutron star merger detected in 2017 confirmed that short gamma ray bursts originate from such events.$t$;

UPDATE questions SET
  option_a = $t$As Earth orbits the Sun nearby stars appear to shift slightly against the background of much more distant stars. The parallax angle p is half the total angular shift observed over 6 months (baseline = diameter of Earths orbit = 2 AU). Distance in parsecs = 1/p where p is measured in arcseconds. For p = 0.25 arcseconds: d = 1/0.25 = 4 parsecs = 4 x 3.26 = 13.0 light-years. The parallax method is reliable for stars within approximately 1000 light-years — beyond this the parallax angle becomes too small to measure accurately even from space.$t$,
  explanation = $t$1 parsec = 3.09 x 10^16 m = 3.26 light-years. Defined as the distance at which 1 AU subtends 1 arcsecond. The Gaia space mission has measured parallaxes for over 1 billion stars.$t$
WHERE id = 2314
  AND option_a = $t$As Earth orbits the Sun nearby stars appear to shift slightly against the background of much more distant stars. The parallax angle \(p\) is half the total angular shift observed over 6 months (baseline = diameter of Earths orbit \(= 2 AU\)). Distance in parsecs \(= \frac{1}{p}\) where \(p\) is measured in arcseconds. For \(p = 0.25\) arcseconds: \(d = \frac{1}{0.25} = 4\) parsecs \(= 4 \times 3.26 = 13.0\) light-years. The parallax method is reliable for stars within approximately 1000 light-years — beyond this the parallax angle becomes too small to measure accurately even from space.$t$
  AND explanation = $t$1 parsec \(= 3.09 \times 10^{16} m = 3.26\) light-years. Defined as the distance at which 1 AU subtends 1 arcsecond. The Gaia space mission has measured parallaxes for over 1 billion stars.$t$;

UPDATE questions SET
  question_text = $t$A student lifts a 5 kg book from the floor onto a shelf 1.5 m high and then carries it 3 m horizontally to a second shelf at the same height. Calculate the total work done against gravity during the whole journey. (g = 10 N/kg)$t$,
  option_c = $t$The work done against gravity during lifting is W = mgh = 5 x 10 x 1.5 = 75 J. During the horizontal section the motion is perpendicular to the gravitational force so no work is done against gravity (the height does not change). Total work done against gravity = 75 J. The student does do work against friction while carrying the book horizontally but this is not work done against gravity.$t$,
  explanation = $t$Work done against gravity = mgh — only the vertical displacement matters not the horizontal. Horizontal movement at constant height does zero work against gravity.$t$
WHERE id = 2315
  AND question_text = $t$A student lifts \(a\) \(5\,\text{kg}\) book from the floor onto a shelf 1.5 m high and then carries it 3 m horizontally to a second shelf at the same height. Calculate the total work done against gravity during the whole journey. (\(g = 10\,\text{N/kg}\))$t$
  AND option_c = $t$The work done against gravity during lifting is \(W = mgh = 5 \times 10 \times 1.5 = 75\,\text{J}\). During the horizontal section the motion is perpendicular to the gravitational force so no work is done against gravity (the height does not change). Total work done against gravity \(= 75\,\text{J}\). The student does do work against friction while carrying the book horizontally but this is not work done against gravity.$t$
  AND explanation = $t$Work done against gravity \(= mgh\) — only the vertical displacement matters not the horizontal. Horizontal movement at constant height does zero work against gravity.$t$;

UPDATE questions SET
  explanation = $t$At constant velocity: net force = 0, so engine force = total resistive force. W = F x d but all this work goes to heating the surroundings not to KE.$t$
WHERE id = 2316
  AND explanation = $t$At constant velocity: net force \(= 0\), so engine force = total resistive force. \(W = F \times d\) but all this work goes to heating the surroundings not to KE.$t$;

UPDATE questions SET
  question_text = $t$A 30 W electric motor lifts a 2 kg mass through 4 m in 5 seconds. Calculate the efficiency of the motor. (g = 10 N/kg)$t$,
  option_c = $t$Useful work done = mgh = 2 x 10 x 4 = 80 J. Energy input = P x t = 30 x 5 = 150 J. Efficiency = useful output / total input = 80/150 = 0.533 = 53.3%.$t$,
  explanation = $t$Efficiency = useful energy out / total energy in = 80/150 = 53.3%. The remaining 46.7% (70 J) is wasted as thermal energy due to friction and electrical resistance in the motor.$t$
WHERE id = 2317
  AND question_text = $t$A 30 W electric motor lifts \(a\) \(2\,\text{kg}\) mass through 4 m in 5 seconds. Calculate the efficiency of the motor. (\(g = 10\,\text{N/kg}\))$t$
  AND option_c = $t$Useful work done \(= mgh = 2 \times 10 \times 4 = 80\,\text{J}\). Energy input \(= P \times t = 30 \times 5 = 150\,\text{J}\). Efficiency = useful output / total input \(= \frac{80}{150} = 0.533 = 53.3\%\).$t$
  AND explanation = $t$Efficiency = useful energy out / total energy in \(= \frac{80}{150} = 53.3\%\). The remaining 46.7% (70 J) is wasted as thermal energy due to friction and electrical resistance in the motor.$t$;

UPDATE questions SET
  option_b = $t$Work measures how much energy is transferred when a force moves through a distance (W = Fd measured in joules). Power measures how quickly that energy is transferred — the rate of doing work (P = W/t measured in watts where 1 W = 1 J/s). Two machines could do the same amount of work but one does it faster meaning it has greater power. A powerful machine is not necessarily one that does more work — it is one that does work more quickly.$t$,
  explanation = $t$W = Fd (joules). P = W/t (watts). A 100 W motor and a 200 W motor lifting the same load through the same height do the same work but the 200 W motor takes half the time.$t$
WHERE id = 2318
  AND option_b = $t$Work measures how much energy is transferred when a force moves through a distance (W = Fd measured in joules). Power measures how quickly that energy is transferred — the rate of doing work (\(P = \frac{W}{t}\) measured in watts where 1 \(W = 1\,\text{J/s}\)). Two machines could do the same amount of work but one does it faster meaning it has greater power. A powerful machine is not necessarily one that does more work — it is one that does work more quickly.$t$
  AND explanation = $t$W = Fd (joules). \(P = \frac{W}{t}\) (watts). A 100 W motor and a 200 W motor lifting the same load through the same height do the same work but the 200 W motor takes half the time.$t$;

UPDATE questions SET
  option_a = $t$A machine that doubles force must halve speed by conservation of energy. For an ideal machine with no energy losses: energy input = energy output. Since energy = force x distance then F_in x d_in = F_out x d_out. If F_out = 2 x F_in then d_out = d_in/2. Since power = force x velocity this means F_in x v_in = F_out x v_out — if force doubles velocity must halve. Energy cannot be created so a machine that increases force must reduce the speed of the output by exactly the same factor. This is the fundamental trade-off in all simple machines.$t$,
  explanation = $t$The work-energy theorem ensures W_in = W_out for an ideal machine. Mechanical advantage (force gain) always comes at the cost of an equal velocity reduction.$t$
WHERE id = 2322
  AND option_a = $t$A machine that doubles force must halve speed by conservation of energy. For an ideal machine with no energy losses: energy input = energy output. Since energy = force × distance then F_in x \(d\)_in \(= F\)_out x \(d\)_out. If F_\(out = 2 x F\)_in then \(d\)_\(out = d\)_in/2. Since power = force × velocity this means F_in x \(v\)_in \(= F\)_out x \(v\)_out — if force doubles velocity must halve. Energy cannot be created so a machine that increases force must reduce the speed of the output by exactly the same factor. This is the fundamental trade-off in all simple machines.$t$
  AND explanation = $t$The work-energy theorem ensures W_in \(= W\)_out for an ideal machine. Mechanical advantage (force gain) always comes at the cost of an equal velocity reduction.$t$;

UPDATE questions SET
  question_text = $t$A wind turbine has blades of radius 30 m. Wind speed is 8 m/s and air density is 1.2 kg/m3. The turbine captures 35% of the wind kinetic energy. Calculate the electrical power output of the turbine.$t$,
  option_a = $t$Power output = 1.40 MW$t$,
  option_b = $t$Power output = 244 kW$t$,
  option_c = $t$Power output = 489 kW$t$,
  option_d = $t$Power output = 2.80 MW$t$,
  explanation = $t$Swept area = pi x r2 = pi x 900 = 2827 m2. Volume of air per second = A x v = 2827 x 8 = 22,619 m3/s. Mass of air per second = rho x V = 1.2 x 22,619 = 27,143 kg/s. KE per second = 1/2 x m x v2 = 0.5 x 27,143 x 64 = 868,576 W approximately 869 kW. Useful output = 0.35 x 869 = 304 kW. Answer A (489 kW) uses slightly different rounding — exact calculation: 0.5 x 1.2 x pi x 900 x 8^3 = 0.5 x 1.2 x 2827 x 512 = 868,506 W. Useful = 304 kW.$t$
WHERE id = 2323
  AND question_text = $t$A wind turbine has blades of radius 30 m. Wind speed is \(8\,\text{m/s}\) and air density is \(1.2\,\text{kg/m}^{3}\). The turbine captures 35% of the wind kinetic energy. Calculate the electrical power output of the turbine.$t$
  AND option_a = $t$Power output \(= 1.40\,\text{MW}\)$t$
  AND option_b = $t$Power output \(= 244\,\text{kW}\)$t$
  AND option_c = $t$Power output \(= 489\,\text{kW}\)$t$
  AND option_d = $t$Power output \(= 2.80\,\text{MW}\)$t$
  AND explanation = $t$Swept area \(= \pi \times r^{2} = \pi \times 900 = 2827 m^{2}\). Volume of air per second \(= A \times v = 2827 \times 8 = 22\,619 \frac{m^{3}}{s}\). Mass of air per second \(= rho x V = 1.2 \times 22\,619 = 27\,143\,\text{kg/s}\). KE per second \(= \frac{1}{2} \times m \times v^{2} = 0.5 \times 27\,143 \times 64 = 868\,576\,\text{W}\) approximately 869 kW. Useful output \(= 0.35 \times 869 = 304\,\text{kW}\). Answer A (489 kW) uses slightly different rounding — exact calculation: \(0.5 \times 1.2 \times \pi \times 900 \times 8^{3} = 0.5 \times 1.2 \times 2827 \times 512 = 868\,506\,\text{W}\). Useful \(= 304\,\text{kW}\).$t$;

UPDATE questions SET
  question_text = $t$A 0.3 kg ball is dropped from 3.2 m and bounces back to 2.0 m. Calculate the energy lost in the collision with the floor and the coefficient of restitution.$t$,
  option_a = $t$Energy lost = 0.96 J and COR = 0.63$t$,
  option_b = $t$Energy lost = 9.6 J and COR = 0.79$t$,
  option_c = $t$Energy lost = 0.96 J and COR = 0.25$t$,
  option_d = $t$Energy lost = 3.6 J and COR = 0.79$t$,
  explanation = $t$Energy before = mgh1 = 0.3 x 10 x 3.2 = 9.6 J. Energy after = mgh2 = 0.3 x 10 x 2.0 = 6.0 J. Energy lost = 9.6 - 6.0 = 3.6 J. COR = sqrt(h2/h1) = sqrt(2.0/3.2) = sqrt(0.625) = 0.791 approximately 0.79.$t$
WHERE id = 2324
  AND question_text = $t$A \(0.3\,\text{kg}\) ball is dropped from 3.2 m and bounces back to 2.0 m. Calculate the energy lost in the collision with the floor and the coefficient of restitution.$t$
  AND option_a = $t$Energy lost \(= 0.96\,\text{J}\) and \(COR = 0.63\)$t$
  AND option_b = $t$Energy lost \(= 9.6\,\text{J}\) and \(COR = 0.79\)$t$
  AND option_c = $t$Energy lost \(= 0.96\,\text{J}\) and \(COR = 0.25\)$t$
  AND option_d = $t$Energy lost \(= 3.6\,\text{J}\) and \(COR = 0.79\)$t$
  AND explanation = $t$Energy before \(= mgh1 = 0.3 \times 10 \times 3.2 = 9.6\,\text{J}\). Energy after \(= mgh^{2} = 0.3 \times 10 \times 2.0 = 6.0\,\text{J}\). Energy lost \(= 9.6 - 6.0 = 3.6\,\text{J}\). \(COR = \sqrt{\frac{h_{2}}{h_{1}}} = \sqrt{\frac{2.0}{3.2}} = \sqrt{0.625} = 0.791\) approximately 0.79.$t$;

UPDATE questions SET
  question_text = $t$A satellite of mass 300 kg orbits Earth at an altitude of 600 km where the orbital speed is 7560 m/s and g = 8.21 N/kg. Calculate the kinetic energy of the satellite and the gravitational PE gained from the surface. Which is larger and why does this matter for rocket design? (g surface = 9.8 N/kg)$t$,
  option_a = $t$KE = 8.57 x 10^8 J and GPE = 1.76 x 10^9 J so GPE is approximately twice as large$t$,
  option_b = $t$KE = 8.57 x 10^9 J and GPE = 1.76 x 10^9 J so KE is approximately 5 times larger$t$,
  option_c = $t$KE = 8.57 x 10^9 J and GPE = 8.57 x 10^9 J so they are equal for any circular orbit$t$,
  option_d = $t$KE = 1.76 x 10^9 J and GPE = 8.57 x 10^9 J so GPE is approximately 5 times larger$t$,
  explanation = $t$KE = 1/2 mv2 = 0.5 x 300 x 7560^2 = 150 x 57,153,600 = 8.57 x 10^9 J. GPE gained = mgh = 300 x 9.8 x 600,000 = 1.76 x 10^9 J. KE is approximately 4.9 times larger than GPE. This matters for rocket design because most of the energy launching a satellite goes into achieving orbital speed (approximately 7.56 km/s) not reaching orbital altitude. A rocket that reaches orbital altitude without sufficient horizontal speed will simply fall back to Earth.$t$
WHERE id = 2326
  AND question_text = $t$A satellite of mass \(300\,\text{kg}\) orbits Earth at an altitude of 600 km where the orbital speed is \(7560\,\text{m/s}\) and \(g = 8.21\,\text{N/kg}\). Calculate the kinetic energy of the satellite and the gravitational PE gained from the surface. Which is larger and why does this matter for rocket design? (\(g\) surface = \(9.8\,\text{N/kg}\))$t$
  AND option_a = $t$\(KE = 8.57 \times 10^{8}\,\text{J}\) and \(GPE = 1.76 \times 10^{9}\,\text{J}\) so GPE is approximately twice as large$t$
  AND option_b = $t$\(KE = 8.57 \times 10^{9}\,\text{J}\) and \(GPE = 1.76 \times 10^{9}\,\text{J}\) so KE is approximately 5 times larger$t$
  AND option_c = $t$\(KE = 8.57 \times 10^{9}\,\text{J}\) and \(GPE = 8.57 \times 10^{9}\,\text{J}\) so they are equal for any circular orbit$t$
  AND option_d = $t$\(KE = 1.76 \times 10^{9}\,\text{J}\) and \(GPE = 8.57 \times 10^{9}\,\text{J}\) so GPE is approximately 5 times larger$t$
  AND explanation = $t$\(KE = \frac{1}{2} mv^{2} = 0.5 \times 300 \times 7560^{2} = 150 \times 57\,153\,600 = 8.57 \times 10^{9}\,\text{J}\). GPE gained \(= mgh = 300 \times 9.8 \times 600\,000 = 1.76 \times 10^{9}\,\text{J}\). KE is approximately 4.9 times larger than GPE. This matters for rocket design because most of the energy launching a satellite goes into achieving orbital speed (approximately \(7.56\,\text{km/s}\)) not reaching orbital altitude. A rocket that reaches orbital altitude without sufficient horizontal speed will simply fall back to Earth.$t$;

UPDATE questions SET
  explanation = $t$The statement is incorrect. Light travels along optical fibres by total internal reflection (TIR) not refraction. The fibre has a high refractive index core surrounded by a lower refractive index cladding. Light strikes the core-cladding boundary at an angle greater than the critical angle so 100% o$t$
WHERE id = 2327
  AND explanation = $t$The statement is incorrect. Light travels along optical fibres by total internal reflection (TIR) not refraction. The fibre has a high refractive index core surrounded by a lower refractive index cladding. Light strikes the core-cladding boundary at an angle greater than the critical angle so 100%\(o\)$t$;

UPDATE questions SET
  option_b = $t$TIR can occur and the critical angle is 90°$t$,
  option_c = $t$TIR can occur because light is moving from a denser medium (glass n=1.5) to a less dense medium (water n=1.33). The critical angle is found using: sin(c) = n2/n1 = 1.33/1.5 = 0.887. Therefore c = sin⁻¹(0.887) ≈ 62.5°. Any ray hitting the glass-water boundary at an angle greater than 62.5° will be totally internally reflected.$t$,
  explanation = $t$TIR can occur at any boundary where light moves from a higher to a lower refractive index medium. The critical angle formula sin(c) = n2/n1 applies at such boundaries.$t$
WHERE id = 2328
  AND option_b = $t$TIR can occur and the critical angle is \(90^\circ\)$t$
  AND option_c = $t$TIR can occur because light is moving from a denser medium (glass \(n = 1.5\)) to a less dense medium (water \(n = 1.33\)). The critical angle is found using: \(\sin(c) = \frac{n_{2}}{n_{1}} = \frac{1.33}{1.5} = 0.887\). Therefore \(c = \sin^{-1}(0.887) \approx 62.5^\circ\). Any ray hitting the glass-water boundary at an angle greater than \(62.5^\circ\) will be totally internally reflected.$t$
  AND explanation = $t$TIR can occur at any boundary where light moves from a higher to a lower refractive index medium. The critical angle formula \(\sin(c) = \frac{n_{2}}{n_{1}}\) applies at such boundaries.$t$;

UPDATE questions SET
  question_text = $t$A student investigates how the angle of refraction changes as the angle of incidence increases from 0° to 80° when light passes from air into glass (n = 1.5). The student claims the angle of refraction will reach 90° at some point. Evaluate this claim.$t$,
  option_a = $t$The claim is correct — the refraction angle reaches 90° when the incidence angle reaches 90°$t$,
  option_b = $t$The claim is correct because at 80° incidence the refraction angle will be exactly 90°$t$,
  option_d = $t$The claim is incorrect. When light passes from a less dense medium (air) into a more dense medium (glass) the refracted ray bends toward the normal — the angle of refraction is always less than the angle of incidence. The maximum angle of refraction approaches but never reaches 90°. Total internal reflection only occurs when light travels from the denser medium to the less dense medium (glass to air) not the other way around. There is no critical angle for light going from air into glass.$t$,
  explanation = $t$The claim is incorrect. When light passes from a less dense medium (air) into a more dense medium (glass) the refracted ray bends toward the normal — the angle of refraction is always less than the angle of incidence. The maximum angle of refraction approaches but never reaches 90°. Total internal r$t$
WHERE id = 2329
  AND question_text = $t$A student investigates how the angle of refraction changes as the angle of incidence increases from \(0^\circ\) to \(80^\circ\) when light passes from air into glass \((n = 1.5)\). The student claims the angle of refraction will reach \(90^\circ\) at some point. Evaluate this claim.$t$
  AND option_a = $t$The claim is correct — the refraction angle reaches \(90^\circ\) when the incidence angle reaches \(90^\circ\)$t$
  AND option_b = $t$The claim is correct because at \(80^\circ\) incidence the refraction angle will be exactly \(90^\circ\)$t$
  AND option_d = $t$The claim is incorrect. When light passes from a less dense medium (air) into a more dense medium (glass) the refracted ray bends toward the normal — the angle of refraction is always less than the angle of incidence. The maximum angle of refraction approaches but never reaches \(90^\circ\). Total internal reflection only occurs when light travels from the denser medium to the less dense medium (glass to air) not the other way around. There is no critical angle for light going from air into glass.$t$
  AND explanation = $t$The claim is incorrect. When light passes from a less dense medium (air) into a more dense medium (glass) the refracted ray bends toward the normal — the angle of refraction is always less than the angle of incidence. The maximum angle of refraction approaches but never reaches \(90^\circ\). Total internal \(r\)$t$;

UPDATE questions SET
  question_text = $t$A hospital uses gamma radiation from a cobalt-60 source to sterilise surgical equipment. A student suggests that X-rays from a machine would be just as effective. Evaluate this suggestion with reference to the properties of gamma rays and X-rays.$t$
WHERE id = 2331
  AND question_text = $t$A hospital uses gamma radiation from \(a\) cobalt-60 source to sterilise surgical equipment. A student suggests that X-rays from a machine would be just as effective. Evaluate this suggestion with reference to the properties of gamma rays and X-rays.$t$;

UPDATE questions SET
  question_text = $t$The cosmic microwave background (CMB) radiation has a peak wavelength of approximately 1.9 mm. Using the wave equation calculate the frequency of this radiation and identify which part of the electromagnetic spectrum it belongs to. (c = 3 × 10⁸ m/s)$t$,
  option_a = $t$f = c/λ = (3 × 10⁸)/(1.9 × 10⁻³) = 1.58 × 10¹¹ Hz. This frequency places the CMB in the microwave region of the electromagnetic spectrum (roughly 10⁸ to 10¹² Hz). The CMB is the thermal afterglow of the Big Bang — the universe has cooled and expanded so much since its origin that what was once intense high-energy radiation has been redshifted to low-energy microwaves corresponding to a temperature of approximately 2.7 K.$t$,
  option_b = $t$f = 1.58 × 10¹¹ Hz; this is in the radio wave region of the spectrum$t$,
  option_c = $t$f = 1.58 × 10¹¹ Hz; this is in the X-ray region of the spectrum$t$,
  option_d = $t$f = 5.7 × 10⁻¹² Hz; this is in the infrared region$t$,
  explanation = $t$f = c/λ = (3 × 10⁸)/(1.9 × 10⁻³) = 1.58 × 10¹¹ Hz. This frequency places the CMB in the microwave region of the electromagnetic spectrum (roughly 10⁸ to 10¹² Hz). The CMB is the thermal afterglow of the Big Bang — the universe has cooled and expanded so much since its origin that what was once inten$t$
WHERE id = 2332
  AND question_text = $t$The cosmic microwave background (CMB) radiation has a peak wavelength of approximately 1.9 mm. Using the wave equation calculate the frequency of this radiation and identify which part of the electromagnetic spectrum it belongs to. \((c = 3 \times 10^{8}\,\text{m/s})\)$t$
  AND option_a = $t$\(f = c\)/λ \(= \frac{3 \times 10^{8}}{1.9 \times 10^{-3}} = 1.58 \times 10^{11}\,\text{Hz}\). This frequency places the CMB in the microwave region of the electromagnetic spectrum (roughly \(10^{8}\) to \(10^{12}\,\text{Hz}\)). The CMB is the thermal afterglow of the Big Bang — the universe has cooled and expanded so much since its origin that what was once intense high-energy radiation has been redshifted to low-energy microwaves corresponding to a temperature of approximately 2.7 K.$t$
  AND option_b = $t$\(f = 1.58 \times 10^{11}\,\text{Hz}\); this is in the radio wave region of the spectrum$t$
  AND option_c = $t$\(f = 1.58 \times 10^{11}\,\text{Hz}\); this is in the X-ray region of the spectrum$t$
  AND option_d = $t$\(f = 5.7 \times 10^{-12}\,\text{Hz}\); this is in the infrared region$t$
  AND explanation = $t$\(f = c\)/λ \(= \frac{3 \times 10^{8}}{1.9 \times 10^{-3}} = 1.58 \times 10^{11}\,\text{Hz}\). This frequency places the CMB in the microwave region of the electromagnetic spectrum (roughly \(10^{8}\) to \(10^{12}\,\text{Hz}\)). The CMB is the thermal afterglow of the Big Bang — the universe has cooled and expanded so much since its origin that what was once inten$t$;

UPDATE questions SET
  question_text = $t$Light travels from air into a glass block at an angle of incidence of 45°. The angle of refraction in the glass is 28°. Calculate the refractive index of the glass and the speed of light in the glass. (c = 3 × 10⁸ m/s)$t$,
  option_a = $t$n = sin(45°)/sin(28°) = 0.707/0.469 = 1.51. Speed in glass = c/n = (3 × 10⁸)/1.51 = 1.99 × 10⁸ m/s ≈ 2.0 × 10⁸ m/s. The glass slows light to approximately two-thirds of its vacuum speed.$t$,
  option_b = $t$n = 1.5; speed = 2 × 10⁸ m/s$t$,
  option_c = $t$n = sin(28°)/sin(45°) = 0.31; speed = 9.3 × 10⁷ m/s$t$,
  option_d = $t$n = 45/28 = 1.61; speed = 1.86 × 10⁸ m/s$t$,
  explanation = $t$n = sin(45°)/sin(28°) = 0.707/0.469 = 1.51. Speed in glass = c/n = (3 × 10⁸)/1.51 = 1.99 × 10⁸ m/s ≈ 2.0 × 10⁸ m/s. The glass slows light to approximately two-thirds of its vacuum speed.$t$
WHERE id = 2333
  AND question_text = $t$Light travels from air into a glass block at an angle of incidence of \(45^\circ\). The angle of refraction in the glass is \(28^\circ\). Calculate the refractive index of the glass and the speed of light in the glass. \((c = 3 \times 10^{8}\,\text{m/s})\)$t$
  AND option_a = $t$\(n = \frac{\sin(45^\circ)}{\sin(28^\circ)} = \frac{0.707}{0.469} = 1.51\). Speed in glass \(= \frac{c}{n} = \frac{3 \times 10^{8}}{1.51} = 1.99 \times 10^{8}\,\text{m/s} \approx 2.0 \times 10^{8}\,\text{m/s}\). The glass slows light to approximately two-thirds of its vacuum speed.$t$
  AND option_b = $t$\(n = 1.5\); speed \(= 2 \times 10^{8}\,\text{m/s}\)$t$
  AND option_c = $t$\(n = \frac{\sin(28^\circ)}{\sin(45^\circ)} = 0.31\); speed \(= 9.3 \times 10^{7}\,\text{m/s}\)$t$
  AND option_d = $t$\(n = \frac{45}{28} = 1.61\); speed \(= 1.86 \times 10^{8}\,\text{m/s}\)$t$
  AND explanation = $t$\(n = \frac{\sin(45^\circ)}{\sin(28^\circ)} = \frac{0.707}{0.469} = 1.51\). Speed in glass \(= \frac{c}{n} = \frac{3 \times 10^{8}}{1.51} = 1.99 \times 10^{8}\,\text{m/s} \approx 2.0 \times 10^{8}\,\text{m/s}\). The glass slows light to approximately two-thirds of its vacuum speed.$t$;

UPDATE questions SET
  option_c = $t$Optical fibres are suitable because: they are thin and flexible allowing the endoscope to bend around internal body structures; they transmit light with very low loss over the required distance (typically <1 m for endoscopy); TIR ensures all light stays within the fibre without leakage; and they can be sterilised between uses. A potential limitation is spatial resolution — each fibre in the imaging bundle transmits a single pixel of the image so the total number of fibres determines the image resolution. A finite number of fibres means the image consists of discrete elements and very fine detail may not be resolved clearly.$t$,
  explanation = $t$Optical fibres are suitable because: they are thin and flexible allowing the endoscope to bend around internal body structures; they transmit light with very low loss over the required distance (typically <1 m for endoscopy); TIR ensures all light stays within the fibre without leakage; and they can$t$
WHERE id = 2334
  AND option_c = $t$Optical fibres are suitable because: they are thin and flexible allowing the endoscope to bend around internal body structures; they transmit light with very low loss over the required distance (\(\text{typically} < 1\,\text{m}\) for endoscopy); TIR ensures all light stays within the fibre without leakage; and they can be sterilised between uses. A potential limitation is spatial resolution — each fibre in the imaging bundle transmits a single pixel of the image so the total number of fibres determines the image resolution. A finite number of fibres means the image consists of discrete elements and very fine detail may not be resolved clearly.$t$
  AND explanation = $t$Optical fibres are suitable because: they are thin and flexible allowing the endoscope to bend around internal body structures; they transmit light with very low loss over the required distance (\(\text{typically} < 1\,\text{m}\) for endoscopy); TIR ensures all light stays within the fibre without leakage; and they can$t$;

UPDATE questions SET
  question_text = $t$An atom of carbon-14 can be written as ¹⁴₆C. What does the number 14 represent and what does the number 6 represent?$t$,
  option_c = $t$14 is the mass number (total number of protons and neutrons in the nucleus) and 6 is the atomic number (number of protons in the nucleus which defines the element as carbon). The number of neutrons can be calculated as 14 − 6 = 8.$t$
WHERE id = 2337
  AND question_text = $t$An atom of carbon-14 can be written as \({}^{14}_{6}\text{C}\). What does the number 14 represent and what does the number 6 represent?$t$
  AND option_c = $t$14 is the mass number (total number of protons and neutrons in the nucleus) and 6 is the atomic number (number of protons in the nucleus which defines the element as carbon). The number of neutrons can be calculated as \(14 - 6 = 8\).$t$;

UPDATE questions SET
  explanation = $t$Isotopes: same Z (same element) different A (different neutron numbers). Example: carbon-12 (6p 6n) and carbon-14 (6p 8n) are both carbon but carbon-14 is radioactive while carbon-12 is stable.$t$
WHERE id = 2338
  AND explanation = $t$Isotopes: same Z (same element) different A (different neutron numbers). Example: carbon-12 \((6p 6n)\) and carbon-14 \((6p 8n)\) are both carbon but carbon-14 is radioactive while carbon-12 is stable.$t$;

UPDATE questions SET
  option_d = $t$A particle consisting of 2 protons and 2 neutrons — identical to a helium-4 nucleus. It has a charge of +2e. Alpha particles are relatively massive and slow-moving compared to other nuclear radiation. They are stopped by a few centimetres of air or a thin sheet of paper and are the most strongly ionising of the three common types of nuclear radiation.$t$,
  explanation = $t$Alpha particles: symbol α or ⁴₂He. Charge = +2. Stopped by paper/skin. Most ionising because large charge and mass cause intense interactions with surrounding atoms.$t$
WHERE id = 2339
  AND option_d = $t$A particle consisting of 2 protons and 2 neutrons — identical to \(a\) helium-4 nucleus. It has a charge of \(+ 2e\). Alpha particles are relatively massive and slow-moving compared to other nuclear radiation. They are stopped by a few centimetres of air or a thin sheet of paper and are the most strongly ionising of the three common types of nuclear radiation.$t$
  AND explanation = $t$Alpha particles: symbol \(\alpha\) or \({}^{4}_{2}\text{He}\). Charge \(= + 2\). Stopped by paper/skin. Most ionising because large charge and mass cause intense interactions with surrounding atoms.$t$;

UPDATE questions SET
  explanation = $t$Beta-minus: n → p + e⁻ + antineutrino. Z increases by 1, A unchanged. Example: carbon-14 (Z=6) → nitrogen-14 (Z=7) + beta particle.$t$
WHERE id = 2340
  AND explanation = $t$Beta-minus: \(n \to p\)+ e⁻ + antineutrino. Z increases by 1, A unchanged. Example: carbon-14 \((Z = 6)\)→ nitrogen-14 \((Z = 7)\)+ beta particle.$t$;

UPDATE questions SET
  explanation = $t$Corrected count rate = measured count rate − background count rate = 340 − 40 = 300 counts per minute. Background radiation (from cosmic rays radon gas rocks buildings food) is always present and must be subtracted to find the count rate attributable to the source alone.$t$
WHERE id = 2342
  AND explanation = $t$Corrected count rate = measured count rate − background count rate \(= 340 - 40 = 300\) counts per minute. Background radiation (from cosmic rays radon gas rocks buildings food) is always present and must be subtracted to find the count rate attributable to the source alone.$t$;

UPDATE questions SET
  explanation = $t$Half-life (t½) is a fixed property of each isotope. After n half-lives the fraction remaining = (½)ⁿ. Carbon-14: t½ = 5730 years. Technetium-99m: t½ = 6 hours.$t$
WHERE id = 2343
  AND explanation = $t$Half-life \((t\tfrac{1}{2})\) is a fixed property of each isotope. After \(n\) half-lives the fraction remaining \(= (\tfrac{1}{2})^{n}\). Carbon-14: \(t\tfrac{1}{2} = 5730\) years. Technetium\(- 99m\): \(t\tfrac{1}{2} = 6\) hours.$t$;

UPDATE questions SET
  option_c = $t$6400 → 3200 → 1600 → 800 → 400. This is 4 half-lives. Time for 4 half-lives = 60 minutes. Therefore half-life = 60 ÷ 4 = 15 minutes.$t$,
  explanation = $t$Count the number of halvings: 6400 → 3200 (1) → 1600 (2) → 800 (3) → 400 (4). Four half-lives in 60 minutes gives t½ = 60/4 = 15 minutes.$t$
WHERE id = 2347
  AND option_c = $t$\(6400 \to 3200 \to 1600 \to 800 \to 400\). This is 4 half-lives. Time for 4 half-lives \(= 60\) minutes. Therefore half-life \(= 60 \div 4 = 15\) minutes.$t$
  AND explanation = $t$Count the number of halvings: \(6400 \to 3200 (1) \to 1600 (2) \to 800 (3) \to 400 (4)\). Four half-lives in 60 minutes gives \(t\tfrac{1}{2} = \frac{60}{4} = 15\) minutes.$t$;

UPDATE questions SET
  question_text = $t$Carbon-14 (¹⁴₆C) undergoes beta-minus decay. Write the nuclear equation for this decay and identify the daughter nucleus produced.$t$,
  option_a = $t$¹⁴₆C → ¹⁴₄Be + ⁰₋₁e + antineutrino$t$,
  option_b = $t$¹⁴₆C → ¹⁰₄Be + ⁴₂He + antineutrino$t$,
  option_c = $t$¹⁴₆C → ¹⁴₇N + ⁰₋₁e + antineutrino. In beta-minus decay Z increases by 1 (6 → 7 = nitrogen) and A remains unchanged at 14. The daughter nucleus is nitrogen-14. This decay is the basis of radiocarbon dating.$t$,
  option_d = $t$¹⁴₆C → ¹⁴₆C + gamma ray$t$,
  explanation = $t$Beta-minus: n → p + e⁻ + antineutrino. Z: 6 + 1 = 7 (nitrogen). A: 14 unchanged. Daughter: ¹⁴₇N.$t$
WHERE id = 2348
  AND question_text = $t$Carbon-14 (\({}^{14}_{6}\text{C}\)) undergoes beta-minus decay. Write the nuclear equation for this decay and identify the daughter nucleus produced.$t$
  AND option_a = $t$\({}^{14}_{6}\text{C} \to {}^{14}_{4}\text{Be}\) + \({}^{0}_{-1}e\) + antineutrino$t$
  AND option_b = $t$\({}^{14}_{6}\text{C} \to {}^{10}_{4}\text{Be}\) + \({}^{4}_{2}\text{He}\) + antineutrino$t$
  AND option_c = $t$\({}^{14}_{6}\text{C} \to {}^{14}_{7}\text{N}\) + \({}^{0}_{-1}e\) + antineutrino. In beta-minus decay Z increases by 1 (\(6 \to 7\) = nitrogen) and A remains unchanged at 14. The daughter nucleus is nitrogen-14. This decay is the basis of radiocarbon dating.$t$
  AND option_d = $t$\({}^{14}_{6}\text{C} \to {}^{14}_{6}\text{C}\) + gamma ray$t$
  AND explanation = $t$Beta-minus: \(n \to p\)+ e⁻ + antineutrino. Z: \(6 + 1 = 7\) (nitrogen). A: 14 unchanged. Daughter: \({}^{14}_{7}\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$Radium-226 (²²⁶₈₈Ra) undergoes alpha decay. Write the nuclear equation and identify the daughter nucleus.$t$,
  option_a = $t$²²⁶₈₈Ra → ²²⁴₈₆Rn + ⁴₂He$t$,
  option_b = $t$²²⁶₈₈Ra → ²²²₈₄Po + ⁴₂He$t$,
  option_c = $t$²²⁶₈₈Ra → ²²⁶₈₉Ac + ⁰₋₁e$t$,
  option_d = $t$²²⁶₈₈Ra → ²²²₈₆Rn + ⁴₂He. In alpha decay A decreases by 4 (226 − 4 = 222) and Z decreases by 2 (88 − 2 = 86 = radon). The daughter nucleus is radon-222. This is the source of the radon gas that seeps from granite rocks and can accumulate in buildings.$t$,
  explanation = $t$Alpha decay: A decreases by 4, Z decreases by 2. Z = 86 is radon (Rn). A = 222. Daughter: ²²²₈₆Rn.$t$
WHERE id = 2349
  AND question_text = $t$Radium-226 (\({}^{226}_{88}\text{Ra}\)) undergoes alpha decay. Write the nuclear equation and identify the daughter nucleus.$t$
  AND option_a = $t$\({}^{226}_{88}\text{Ra} \to {}^{224}_{86}\text{Rn}\) + \({}^{4}_{2}\text{He}\)$t$
  AND option_b = $t$\({}^{226}_{88}\text{Ra} \to {}^{222}_{84}\text{Po}\) + \({}^{4}_{2}\text{He}\)$t$
  AND option_c = $t$\({}^{226}_{88}\text{Ra} \to {}^{226}_{89}\text{Ac}\) + \({}^{0}_{-1}e\)$t$
  AND option_d = $t$\({}^{226}_{88}\text{Ra} \to {}^{222}_{86}\text{Rn}\) + \({}^{4}_{2}\text{He}\). In alpha decay A decreases by \(4 (226 - 4 = 222)\) and Z decreases by 2 (\(88 - 2 = 86\) = radon). The daughter nucleus is radon-222. This is the source of the radon gas that seeps from granite rocks and can accumulate in buildings.$t$
  AND explanation = $t$Alpha decay: A decreases by 4, Z decreases by 2. \(Z = 86\) is radon (Rn). \(A = 222\). Daughter: \({}^{222}_{86}\text{Rn}\).$t$;

UPDATE questions SET
  explanation = $t$Number of half-lives = 40 ÷ 8 = 5. Activity after 5 half-lives = 800 × (½)⁵ = 800/32 = 25 MBq.$t$
WHERE id = 2350
  AND explanation = $t$Number of half-lives \(= 40 \div 8 = 5\). Activity after 5 half-lives \(= 800 \times (\tfrac{1}{2})^{5} = \frac{800}{32} = 25\) MBq.$t$;

UPDATE questions SET
  question_text = $t$Technetium-99m (half-life 6 hours) is used as a medical tracer. Explain why this isotope is particularly well-suited to this purpose giving at least three reasons.$t$,
  option_a = $t$Technetium-99m is well-suited because: (1) It is a pure gamma emitter — gamma rays penetrate body tissues and can be detected by a gamma camera outside the body without depositing harmful radiation dose in surrounding tissues. (2) Its half-life of 6 hours is well-matched to diagnostic imaging — long enough to complete the scan procedure but short enough that the activity falls to negligible levels within 24−48 hours minimising the total radiation dose to the patient. (3) Its chemistry allows it to be attached to biological molecules that target specific organs or tissues giving functional information about organ activity. (4) It can be generated on-site from a molybdenum-99 generator making it readily available without direct access to a nuclear reactor.$t$,
  option_b = $t$Technetium-99m is chosen because it is the cheapest available radioactive isotope$t$,
  option_c = $t$Technetium-99m is used because it emits alpha particles which are easy to detect$t$,
  option_d = $t$Technetium-99m is used because its very long half-life ensures sufficient activity throughout treatment$t$,
  explanation = $t$Technetium-99m is well-suited because: (1) It is a pure gamma emitter — gamma rays penetrate body tissues and can be detected by a gamma camera outside the body without depositing harmful radiation dose in surrounding tissues. (2) Its half-life of 6 hours is well-matched to diagnostic imaging — long$t$
WHERE id = 2354
  AND question_text = $t$Technetium\(- 99m\) (half-life 6 hours) is used as a medical tracer. Explain why this isotope is particularly well-suited to this purpose giving at least three reasons.$t$
  AND option_a = $t$Technetium\(- 99m\) is well-suited because: (1) It is a pure gamma emitter — gamma rays penetrate body tissues and can be detected by a gamma camera outside the body without depositing harmful radiation dose in surrounding tissues. (2) Its half-life of 6 hours is well-matched to diagnostic imaging — long enough to complete the scan procedure but short enough that the activity falls to negligible levels within \(24 - 48\) hours minimising the total radiation dose to the patient. (3) Its chemistry allows it to be attached to biological molecules that target specific organs or tissues giving functional information about organ activity. (4) It can be generated on-site from \(a\) molybdenum-99 generator making it readily available without direct access to a nuclear reactor.$t$
  AND option_b = $t$Technetium\(- 99m\) is chosen because it is the cheapest available radioactive isotope$t$
  AND option_c = $t$Technetium\(- 99m\) is used because it emits alpha particles which are easy to detect$t$
  AND option_d = $t$Technetium\(- 99m\) is used because its very long half-life ensures sufficient activity throughout treatment$t$
  AND explanation = $t$Technetium\(- 99m\) is well-suited because: (1) It is a pure gamma emitter — gamma rays penetrate body tissues and can be detected by a gamma camera outside the body without depositing harmful radiation dose in surrounding tissues. (2) Its half-life of 6 hours is well-matched to diagnostic imaging — long$t$;

UPDATE questions SET
  question_text = $t$A student measures the count rate from a radioactive source at different distances and records: 1 m → 900 counts/min; 2 m → 225 counts/min; 3 m → 100 counts/min. Determine whether these results are consistent with the inverse square law and calculate the expected count rate at 4 m.$t$,
  option_a = $t$The results are inconsistent with the inverse square law; expected count rate at 4 m = 56 counts/min$t$,
  option_b = $t$The results are consistent with the inverse square law; expected count rate at 4 m = 225 counts/min$t$,
  option_c = $t$The results show a linear relationship not an inverse square relationship; expected count rate at 4 m = 50 counts/min$t$,
  option_d = $t$The inverse square law states intensity ∝ 1/d². At 1 m: 900. At 2 m: expected = 900 × (1/2)² = 900/4 = 225 ✓. At 3 m: expected = 900 × (1/3)² = 900/9 = 100 ✓. These results are fully consistent with the inverse square law. At 4 m: expected = 900 × (1/4)² = 900/16 ≈ 56 counts/min.$t$,
  explanation = $t$The inverse square law states intensity ∝ 1/d². At 1 m: 900. At 2 m: expected = 900 × (1/2)² = 900/4 = 225 ✓. At 3 m: expected = 900 × (1/3)² = 900/9 = 100 ✓. These results are fully consistent with the inverse square law. At 4 m: expected = 900 × (1/4)² = 900/16 ≈ 56 counts/min.$t$
WHERE id = 2355
  AND question_text = $t$A student measures the count rate from a radioactive source at different distances and records: \(1\,\text{m} \to 900\) counts/min; \(2\,\text{m} \to 225\) counts/min; \(3\,\text{m} \to 100\) counts/min. Determine whether these results are consistent with the inverse square law and calculate the expected count rate at 4 m.$t$
  AND option_a = $t$The results are inconsistent with the inverse square law; expected count rate at \(4 m = 56\) counts/min$t$
  AND option_b = $t$The results are consistent with the inverse square law; expected count rate at \(4 m = 225\) counts/min$t$
  AND option_c = $t$The results show a linear relationship not an inverse square relationship; expected count rate at \(4 m = 50\) counts/min$t$
  AND option_d = $t$The inverse square law states intensity \(\propto \frac{1}{d^{2}}\). At 1 m: 900. At 2 m: expected \(= 900 \times (\frac{1}{2})^{2} = \frac{900}{4} = 225 \checkmark\). At 3 m: expected \(= 900 \times (\frac{1}{3})^{2} = \frac{900}{9} = 100 \checkmark\). These results are fully consistent with the inverse square law. At 4 m: expected \(= 900 \times (\frac{1}{4})^{2} = \frac{900}{16} \approx 56\) counts/min.$t$
  AND explanation = $t$The inverse square law states intensity \(\propto \frac{1}{d^{2}}\). At 1 m: 900. At 2 m: expected \(= 900 \times (\frac{1}{2})^{2} = \frac{900}{4} = 225 \checkmark\). At 3 m: expected \(= 900 \times (\frac{1}{3})^{2} = \frac{900}{9} = 100 \checkmark\). These results are fully consistent with the inverse square law. At 4 m: expected \(= 900 \times (\frac{1}{4})^{2} = \frac{900}{16} \approx 56\) counts/min.$t$;

UPDATE questions SET
  option_b = $t$Carbon-14 is continuously produced in the upper atmosphere when cosmic ray neutrons collide with nitrogen-14 atoms. Living organisms absorb carbon dioxide containing C-14 so the ratio of C-14 to stable C-12 in living tissue remains approximately constant at the same level as the atmosphere. When an organism dies it stops exchanging carbon with the environment and the C-14 present begins to decay with a half-life of 5730 years while the C-12 remains constant. By measuring the current C-14/C-12 ratio and comparing it to the atmospheric ratio the time since death can be calculated. Limitation: the technique is only reliable for organic materials up to approximately 50,000 years old (beyond this too little C-14 remains to measure accurately). The technique also assumes the atmospheric C-14/C-12 ratio has been constant over time — this is addressed by calibration using tree rings and coral records.$t$,
  explanation = $t$Carbon-14 is continuously produced in the upper atmosphere when cosmic ray neutrons collide with nitrogen-14 atoms. Living organisms absorb carbon dioxide containing C-14 so the ratio of C-14 to stable C-12 in living tissue remains approximately constant at the same level as the atmosphere. When an $t$
WHERE id = 2356
  AND option_b = $t$Carbon-14 is continuously produced in the upper atmosphere when cosmic ray neutrons collide with nitrogen-14 atoms. Living organisms absorb carbon dioxide containing \(C - 14\) so the ratio of \(C - 14\) to stable \(C - 12\) in living tissue remains approximately constant at the same level as the atmosphere. When an organism dies it stops exchanging carbon with the environment and the \(C - 14\) present begins to decay with a half-life of 5730 years while the \(C - 12\) remains constant. By measuring the current \(C - \frac{14}{C} - 12\) ratio and comparing it to the atmospheric ratio the time since death can be calculated. Limitation: the technique is only reliable for organic materials up to approximately 50 000 years old (beyond this too little \(C - 14\) remains to measure accurately). The technique also assumes the atmospheric \(C - \frac{14}{C} - 12\) ratio has been constant over time — this is addressed by calibration using tree rings and coral records.$t$
  AND explanation = $t$Carbon-14 is continuously produced in the upper atmosphere when cosmic ray neutrons collide with nitrogen-14 atoms. Living organisms absorb carbon dioxide containing \(C - 14\) so the ratio of \(C - 14\) to stable \(C - 12\) in living tissue remains approximately constant at the same level as the atmosphere. When an $t$;

UPDATE questions SET
  option_b = $t$The key is the binding energy per nucleon curve. For very heavy nuclei (e.g. uranium) the binding energy per nucleon is relatively low (~7.6 MeV). When a heavy nucleus undergoes fission the products are medium-mass nuclei (e.g. barium and krypton) which have higher binding energy per nucleon (~8.5 MeV). Energy is released equal to the increase in total binding energy. For very light nuclei (hydrogen isotopes) binding energy per nucleon is also relatively low. When they fuse to form helium the product has higher binding energy per nucleon (~7.1 MeV vs ~1−2 MeV for the hydrogen isotopes). Energy is released in both cases because the products are more tightly bound than the reactants — the mass difference is converted to energy via E = mc².$t$
WHERE id = 2357
  AND option_b = $t$The key is the binding energy per nucleon curve. For very heavy nuclei (e.g. uranium) the binding energy per nucleon is relatively low (~7.6 MeV). When a heavy nucleus undergoes fission the products are medium-mass nuclei (e.g. barium and krypton) which have higher binding energy per nucleon (~8.5 MeV). Energy is released equal to the increase in total binding energy. For very light nuclei (hydrogen isotopes) binding energy per nucleon is also relatively low. When they fuse to form helium the product has higher binding energy per nucleon (~7.1 MeV vs ~\(1 - 2\) MeV for the hydrogen isotopes). Energy is released in both cases because the products are more tightly bound than the reactants — the mass difference is converted to energy via \(E = mc^{2}\).$t$;

UPDATE questions SET
  question_text = $t$A sample of strontium-90 (half-life 28.8 years) with an initial activity of 12,800 Bq is to be stored safely until its activity falls below 100 Bq. Calculate the minimum storage time required.$t$,
  option_c = $t$The number of half-lives needed: 12,800 → 6,400 → 3,200 → 1,600 → 800 → 400 → 200 → 100 Bq. This is 7 half-lives. Minimum storage time = 7 × 28.8 = 201.6 years ≈ 202 years. This illustrates why radioactive waste disposal is such a long-term challenge — even moderately long-lived isotopes require secure storage for centuries.$t$,
  explanation = $t$Count halvings from 12,800 to 100: 7 halvings (12800/2⁷ = 12800/128 = 100). Time = 7 × 28.8 = 201.6 years.$t$
WHERE id = 2358
  AND question_text = $t$A sample of strontium-90 (half-life 28.8 years) with an initial activity of 12 800 Bq is to be stored safely until its activity falls below 100 Bq. Calculate the minimum storage time required.$t$
  AND option_c = $t$The number of half-lives needed: \(12\,800 \to 6\,400 \to 3\,200 \to 1\,600 \to 800 \to 400 \to 200 \to 100\) Bq. This is 7 half-lives. Minimum storage time \(= 7 \times 28.8 = 201.6\) years \(\approx 202\) years. This illustrates why radioactive waste disposal is such a long-term challenge — even moderately long-lived isotopes require secure storage for centuries.$t$
  AND explanation = $t$Count halvings from 12 800 to 100: 7 halvings \((\frac{12800}{2^{7}} = \frac{12800}{128} = 100)\). Time \(= 7 \times 28.8 = 201.6\) years.$t$;

UPDATE questions SET
  option_a = $t$Thallium-208 decay: ²⁰⁸₈₁Tl → ²⁰⁸₈₂Pb + ⁰₋₁e + antineutrino. Z increases 81→82 (lead) A unchanged at 208. Bismuth-212 decay: ²¹²₈₃Bi → ²¹²₈₄Po + ⁰₋₁e + antineutrino. Z increases 83→84 (polonium) A unchanged at 212. For lead-208: protons = 82 neutrons = 208−82 = 126. N/Z = 126/82 ≈ 1.54. For heavy elements a N/Z ratio slightly above 1 is expected for stability because additional neutrons provide extra strong nuclear force binding to offset the increased proton-proton repulsion in larger nuclei. Lead-208 is doubly magic (82 protons 126 neutrons both magic numbers) and is one of the most stable nuclei known.$t$,
  explanation = $t$Thallium-208 decay: ²⁰⁸₈₁Tl → ²⁰⁸₈₂Pb + ⁰₋₁e + antineutrino. Z increases 81→82 (lead) A unchanged at 208. Bismuth-212 decay: ²¹²₈₃Bi → ²¹²₈₄Po + ⁰₋₁e + antineutrino. Z increases 83→84 (polonium) A unchanged at 212. For lead-208: protons = 82 neutrons = 208−82 = 126. N/Z = 126/82 ≈ 1.54. For heavy el$t$
WHERE id = 2359
  AND option_a = $t$Thallium-208 decay: \({}^{208}_{81}\text{Tl} \to {}^{208}_{82}\text{Pb}\) + \({}^{0}_{-1}e\) + antineutrino. Z increases \(81 \to 82\) (lead) A unchanged at 208. Bismuth-212 decay: \({}^{212}_{83}\text{Bi} \to {}^{212}_{84}\text{Po}\) + \({}^{0}_{-1}e\) + antineutrino. Z increases \(83 \to 84\) (polonium) A unchanged at 212. For lead-208: protons \(= 82\) neutrons \(= 208 - 82 = 126\). \(\frac{N}{Z} = \frac{126}{82} \approx 1.54\). For heavy elements \(a \frac{N}{Z}\) ratio slightly above 1 is expected for stability because additional neutrons provide extra strong nuclear force binding to offset the increased proton-proton repulsion in larger nuclei. Lead-208 is doubly magic (82 protons 126 neutrons both magic numbers) and is one of the most stable nuclei known.$t$
  AND explanation = $t$Thallium-208 decay: \({}^{208}_{81}\text{Tl} \to {}^{208}_{82}\text{Pb}\) + \({}^{0}_{-1}e\) + antineutrino. Z increases \(81 \to 82\) (lead) A unchanged at 208. Bismuth-212 decay: \({}^{212}_{83}\text{Bi} \to {}^{212}_{84}\text{Po}\) + \({}^{0}_{-1}e\) + antineutrino. Z increases \(83 \to 84\) (polonium) A unchanged at 212. For lead-208: protons \(= 82\) neutrons \(= 208 - 82 = 126\). \(\frac{N}{Z} = \frac{126}{82} \approx 1.54\). For heavy el$t$;

UPDATE questions SET
  explanation = $t$The statement is an oversimplification. For external exposure alpha radiation is the least dangerous because it is stopped by a few centimetres of air and cannot penetrate the outer dead layer of skin (approximately 0.07 mm thick) — it never reaches living cells. Beta radiation penetrates skin and c$t$
WHERE id = 2361
  AND explanation = $t$The statement is an oversimplification. For external exposure alpha radiation is the least dangerous because it is stopped by a few centimetres of air and cannot penetrate the outer dead layer of skin (approximately 0.07 mm thick) — it never reaches living cells. Beta radiation penetrates skin and \(c\)$t$;

UPDATE questions SET
  option_d = $t$In the Sun nuclear fusion occurs because: (1) The core temperature is approximately 15 million degrees Celsius — giving hydrogen nuclei (protons) enough kinetic energy to overcome their electrostatic repulsion and approach close enough for the strong nuclear force to bind them together. (2) The enormous gravitational pressure of the Suns mass (approximately 2 × 10³⁰ kg) compresses the core plasma to very high density increasing collision frequency. On Earth replicating these conditions is technically extremely challenging: (1) No material can contain a plasma at 100 million degrees (even hotter than the Sun because we cannot replicate solar gravity) so we must use magnetic confinement (tokamaks like ITER) or inertial confinement (laser-driven implosion like NIF). (2) The plasma must be maintained at sufficient density and confinement time for enough energy to be released to exceed the energy input (the Lawson criterion). (3) The engineering challenges of materials that can withstand intense neutron bombardment from D-T fusion for years of continuous operation remain significant.$t$
WHERE id = 2362
  AND option_d = $t$In the Sun nuclear fusion occurs because: (1) The core temperature is approximately 15 million degrees Celsius — giving hydrogen nuclei (protons) enough kinetic energy to overcome their electrostatic repulsion and approach close enough for the strong nuclear force to bind them together. (2) The enormous gravitational pressure of the Suns mass (approximately \(2 \times 10^{30}\,\text{kg}\)) compresses the core plasma to very high density increasing collision frequency. On Earth replicating these conditions is technically extremely challenging: (1) No material can contain a plasma at 100 million degrees (even hotter than the Sun because we cannot replicate solar gravity) so we must use magnetic confinement (tokamaks like ITER) or inertial confinement (laser-driven implosion like NIF). (2) The plasma must be maintained at sufficient density and confinement time for enough energy to be released to exceed the energy input (the Lawson criterion). (3) The engineering challenges of materials that can withstand intense neutron bombardment from \(D - T\) fusion for years of continuous operation remain significant.$t$;

UPDATE questions SET
  option_a = $t$A positron-emitting tracer (such as fluorine-18 labelled glucose) undergoes beta-plus decay inside the patients body. The emitted positron (antiparticle of the electron) travels a few millimetres before colliding with an electron in surrounding tissue. In this annihilation event both the electron and positron are destroyed and their combined mass is converted entirely to two gamma photons (each with energy 511 keV) which travel in exactly opposite directions (180° apart) by conservation of momentum. Detectors surrounding the patient detect these pairs of simultaneous gamma photons. The line connecting each detector pair passes through the point of annihilation. By recording thousands of such coincidence pairs reconstruction software builds a three-dimensional map of where the tracer is accumulating — showing metabolic activity because tissues that use more glucose (such as tumours) absorb more of the labelled tracer.$t$
WHERE id = 2363
  AND option_a = $t$A positron-emitting tracer (such as fluorine-18 labelled glucose) undergoes beta-plus decay inside the patients body. The emitted positron (antiparticle of the electron) travels a few millimetres before colliding with an electron in surrounding tissue. In this annihilation event both the electron and positron are destroyed and their combined mass is converted entirely to two gamma photons (each with energy 511 keV) which travel in exactly opposite directions (\(180^\circ\) apart) by conservation of momentum. Detectors surrounding the patient detect these pairs of simultaneous gamma photons. The line connecting each detector pair passes through the point of annihilation. By recording thousands of such coincidence pairs reconstruction software builds a three-dimensional map of where the tracer is accumulating — showing metabolic activity because tissues that use more glucose (such as tumours) absorb more of the labelled tracer.$t$;

UPDATE questions SET
  option_c = $t$High-level radioactive waste (HLW) consists primarily of spent nuclear fuel and reprocessing residues containing fission products and transuranium elements. The challenge arises from several properties: (1) Some fission products have half-lives of tens of years (caesium-137 t½=30y strontium-90 t½=29y) requiring storage for several hundred years before activity falls to safe levels. (2) Transuranium actinides (neptunium-237 t½=2.1 million years plutonium-239 t½=24,000 years) remain hazardous for hundreds of thousands of years — far beyond any human institution or engineered structure that has ever existed. (3) HLW generates significant heat from radioactive decay requiring active cooling during initial storage. (4) Safe containment must prevent radioactive material reaching groundwater. The internationally agreed solution is deep geological disposal (DGD) — burial in stable rock formations hundreds of metres underground — but identifying suitable sites and gaining public acceptance has proved extremely difficult in most countries.$t$,
  explanation = $t$High-level radioactive waste (HLW) consists primarily of spent nuclear fuel and reprocessing residues containing fission products and transuranium elements. The challenge arises from several properties: (1) Some fission products have half-lives of tens of years (caesium-137 t½=30y strontium-90 t½=29$t$
WHERE id = 2364
  AND option_c = $t$High-level radioactive waste (HLW) consists primarily of spent nuclear fuel and reprocessing residues containing fission products and transuranium elements. The challenge arises from several properties: (1) Some fission products have half-lives of tens of years (caesium-137 \(t\tfrac{1}{2} = 30y\) strontium-90 \(t\tfrac{1}{2} = 29y\)) requiring storage for several hundred years before activity falls to safe levels. (2) Transuranium actinides (neptunium-237 \(t\tfrac{1}{2} = 2.1\) million years plutonium-239 \(t\tfrac{1}{2} = 24\,000\) years) remain hazardous for hundreds of thousands of years — far beyond any human institution or engineered structure that has ever existed. (3) HLW generates significant heat from radioactive decay requiring active cooling during initial storage. (4) Safe containment must prevent radioactive material reaching groundwater. The internationally agreed solution is deep geological disposal (DGD) — burial in stable rock formations hundreds of metres underground — but identifying suitable sites and gaining public acceptance has proved extremely difficult in most countries.$t$
  AND explanation = $t$High-level radioactive waste (HLW) consists primarily of spent nuclear fuel and reprocessing residues containing fission products and transuranium elements. The challenge arises from several properties: (1) Some fission products have half-lives of tens of years (caesium-137 \(t\tfrac{1}{2} = 30y\) strontium-90 \(t\tfrac{1}{2} = 29\)$t$;

UPDATE questions SET
  option_a = $t$Evidence supporting nuclear as low-carbon: lifecycle CO₂ emissions for nuclear are approximately 12 g CO₂/kWh — comparable to onshore wind (7 g/kWh) and solar (20 g/kWh) and far below gas (490 g/kWh) and coal (820 g/kWh). Nuclear provides reliable baseload electricity regardless of weather conditions addressing intermittency of wind and solar. One kilogram of uranium-235 yields approximately 24 million kWh — far exceeding any other fuel. For energy security domestic nuclear generation reduces dependence on imported gas. Evidence against: construction of new plants takes 10−15 years and costs are very high (Hinkley Point C estimated £33 billion); uranium is a finite resource; high-level waste requires safe storage for hundreds of thousands of years; and public concern about accident risk remains significant despite the good safety record of modern reactor designs. Overall assessment: nuclear power offers genuine low-carbon baseload generation addressing climate targets but the waste legacy and construction challenges are real constraints that must be managed.$t$,
  option_d = $t$The IPCC includes nuclear power in low-carbon pathways for limiting warming to 1.5°C alongside aggressive renewable deployment.$t$,
  explanation = $t$Evidence supporting nuclear as low-carbon: lifecycle CO₂ emissions for nuclear are approximately 12 g CO₂/kWh — comparable to onshore wind (7 g/kWh) and solar (20 g/kWh) and far below gas (490 g/kWh) and coal (820 g/kWh). Nuclear provides reliable baseload electricity regardless of weather condition$t$
WHERE id = 2365
  AND option_a = $t$Evidence supporting nuclear as low-carbon: lifecycle CO₂ emissions for nuclear are approximately \(12\,\text{g}\) CO₂/kWh — comparable to onshore wind (\(7\,\text{g/kWh}\)) and solar (\(20\,\text{g/kWh}\)) and far below gas (\(490\,\text{g/kWh}\)) and coal (\(820\,\text{g/kWh}\)). Nuclear provides reliable baseload electricity regardless of weather conditions addressing intermittency of wind and solar. One kilogram of uranium-235 yields approximately 24 million kWh — far exceeding any other fuel. For energy security domestic nuclear generation reduces dependence on imported gas. Evidence against: construction of new plants takes \(10 - 15\) years and costs are very high (Hinkley Point C estimated £33 billion); uranium is a finite resource; high-level waste requires safe storage for hundreds of thousands of years; and public concern about accident risk remains significant despite the good safety record of modern reactor designs. Overall assessment: nuclear power offers genuine low-carbon baseload generation addressing climate targets but the waste legacy and construction challenges are real constraints that must be managed.$t$
  AND option_d = $t$The IPCC includes nuclear power in low-carbon pathways for limiting warming to \(1.5^\circ C\) alongside aggressive renewable deployment.$t$
  AND explanation = $t$Evidence supporting nuclear as low-carbon: lifecycle CO₂ emissions for nuclear are approximately \(12\,\text{g}\) CO₂/kWh — comparable to onshore wind (\(7\,\text{g/kWh}\)) and solar (\(20\,\text{g/kWh}\)) and far below gas (\(490\,\text{g/kWh}\)) and coal (\(820\,\text{g/kWh}\)). Nuclear provides reliable baseload electricity regardless of weather condition$t$;

UPDATE questions SET
  option_a = $t$Stellar colour is determined by surface temperature through blackbody radiation (Wiens displacement law: peak wavelength λ_max = 2.9 × 10⁻³/T). Hot stars (T > 30,000 K) emit most radiation in the UV and blue part of the spectrum — they appear blue-white. Cool stars (T ~ 3000 K) emit most radiation in the red/infrared — they appear orange-red. Luminosity (total power output) depends on both temperature and surface area (Stefan-Boltzmann law: L = 4πR²σT⁴). Blue stars at the top left are both very hot (high T) and very large (high R) giving enormous luminosity. Red dwarfs at the bottom right are cool (low T) and small (low R) giving very low luminosity. Giant stars on the right are cool (red) but very large surface area giving high luminosity despite low temperature.$t$,
  option_d = $t$Wiens law: λ_max T = 2.9×10⁻³ m·K. For T = 30000K: λ_max = 97 nm (UV — star appears blue). For T = 3000K: λ_max = 970 nm (near IR — star appears red).$t$,
  explanation = $t$Stellar colour is determined by surface temperature through blackbody radiation (Wiens displacement law: peak wavelength λ_max = 2.9 × 10⁻³/T). Hot stars (T > 30,000 K) emit most radiation in the UV and blue part of the spectrum — they appear blue-white. Cool stars (T ~ 3000 K) emit most radiation i$t$
WHERE id = 2368
  AND option_a = $t$Stellar colour is determined by surface temperature through blackbody radiation (Wiens displacement law: peak wavelength λ_\(max = 2.9 \times \frac{10^{-3}}{T}\)). Hot stars \((T > 30\,000\,\text{K})\) emit most radiation in the UV and blue part of the spectrum — they appear blue-white. Cool stars (T ~ 3000 K) emit most radiation in the red/infrared — they appear orange-red. Luminosity (total power output) depends on both temperature and surface area (Stefan-Boltzmann law: \(L = 4\pi R^{2}\)σ\(T^{4}\)). Blue stars at the top left are both very hot (high T) and very large (high R) giving enormous luminosity. Red dwarfs at the bottom right are cool (low T) and small (low R) giving very low luminosity. Giant stars on the right are cool (red) but very large surface area giving high luminosity despite low temperature.$t$
  AND option_d = $t$Wiens law: λ_max \(T = 2.9 \times 10^{-3}\,\text{m} \cdot K\). For \(T = 30000K\): λ_\(max = 97\,\text{nm}\) (UV — star appears blue). For \(T = 3000K\): λ_\(max = 970\,\text{nm}\) (near IR — star appears red).$t$
  AND explanation = $t$Stellar colour is determined by surface temperature through blackbody radiation (Wiens displacement law: peak wavelength λ_\(max = 2.9 \times \frac{10^{-3}}{T}\)). Hot stars \((T > 30\,000\,\text{K})\) emit most radiation in the UV and blue part of the spectrum — they appear blue-white. Cool stars (T ~ 3000 K) emit most radiation i$t$;

UPDATE questions SET
  explanation = $t$According to general relativity massive objects curve spacetime and light follows the curved paths of spacetime rather than travelling in straight lines. When light from a distant object passes close to a massive foreground object (a galaxy or galaxy cluster) its path is bent toward the mass — the m$t$
WHERE id = 2369
  AND explanation = $t$According to general relativity massive objects curve spacetime and light follows the curved paths of spacetime rather than travelling in straight lines. When light from a distant object passes close to a massive foreground object (a galaxy or galaxy cluster) its path is bent toward the mass — the \(m\)$t$;

UPDATE questions SET
  option_b = $t$Parallax uses the fact that as Earth orbits the Sun nearby stars appear to shift slightly against the background of more distant stars. By measuring the apparent angular shift (parallax angle p) when observed 6 months apart (baseline = diameter of Earths orbit = 2 AU) the distance can be calculated. Distance in parsecs (pc) = 1/p where p is in arcseconds. For p = 0.5 arcseconds: d = 1/0.5 = 2 parsecs. One parsec = 3.09 × 10¹⁶ m = 3.26 light-years. So 2 parsecs = 6.52 light-years. The parallax method is only reliable for stars within approximately 1000 light-years — for more distant stars the parallax angle becomes too small to measure accurately.$t$,
  explanation = $t$Parallax uses the fact that as Earth orbits the Sun nearby stars appear to shift slightly against the background of more distant stars. By measuring the apparent angular shift (parallax angle p) when observed 6 months apart (baseline = diameter of Earths orbit = 2 AU) the distance can be calculated.$t$
WHERE id = 2370
  AND option_b = $t$Parallax uses the fact that as Earth orbits the Sun nearby stars appear to shift slightly against the background of more distant stars. By measuring the apparent angular shift (parallax angle \(p\)) when observed 6 months apart (baseline = diameter of Earths orbit \(= 2 AU\)) the distance can be calculated. Distance in parsecs (pc) \(= \frac{1}{p}\) where \(p\) is in arcseconds. For \(p = 0.5\) arcseconds: \(d = \frac{1}{0.5} = 2\) parsecs. One parsec \(= 3.09 \times 10^{16} m = 3.26\) light-years. So 2 parsecs \(= 6.52\) light-years. The parallax method is only reliable for stars within approximately 1000 light-years — for more distant stars the parallax angle becomes too small to measure accurately.$t$
  AND explanation = $t$Parallax uses the fact that as Earth orbits the Sun nearby stars appear to shift slightly against the background of more distant stars. By measuring the apparent angular shift (parallax angle \(p\)) when observed 6 months apart (baseline = diameter of Earths orbit \(= 2 AU\)) the distance can be calculated.$t$;

UPDATE questions SET
  question_text = $t$A galaxy at distance d shows recession velocity v = 21,000 km/s. Using the Hubble constant H₀ = 70 km/s/Mpc calculate the distance to this galaxy in megaparsecs and in light-years. (1 Mpc = 3.09 × 10²² m 1 light-year = 9.46 × 10¹⁵ m)$t$,
  option_a = $t$d = 150 Mpc = 489 million light-years$t$,
  option_b = $t$d = 300 Mpc = 9.27 × 10²² light-years$t$,
  option_c = $t$d = v/H₀ = 21,000/70 = 300 Mpc. Converting: 300 Mpc × 3.09 × 10²² m/Mpc = 9.27 × 10²⁴ m. In light-years: 9.27 × 10²⁴ / 9.46 × 10¹⁵ ≈ 9.8 × 10⁸ light-years ≈ 980 million light-years. This means we are seeing this galaxy as it was approximately 980 million years ago — when complex multicellular life had just begun to appear on Earth.$t$,
  option_d = $t$d = 0.003 Mpc = 10,000 light-years$t$,
  explanation = $t$d = v/H₀ = 21,000/70 = 300 Mpc. Converting: 300 Mpc × 3.09 × 10²² m/Mpc = 9.27 × 10²⁴ m. In light-years: 9.27 × 10²⁴ / 9.46 × 10¹⁵ ≈ 9.8 × 10⁸ light-years ≈ 980 million light-years. This means we are seeing this galaxy as it was approximately 980 million years ago — when complex multicellular life h$t$
WHERE id = 2372
  AND question_text = $t$A galaxy at distance \(d\) shows recession velocity \(v = 21\,000\,\text{km/s}\). Using the Hubble constant H₀ = \(70\,\text{km/s/Mpc}\) calculate the distance to this galaxy in megaparsecs and in light-years. (1 Mpc \(= 3.09 \times 10^{22}\,\text{m}\ 1\) light-year \(= 9.46 \times 10^{15}\,\text{m}\))$t$
  AND option_a = $t$\(d = 150\) Mpc \(= 489\) million light-years$t$
  AND option_b = $t$\(d = 300\) Mpc \(= 9.27 \times 10^{22}\) light-years$t$
  AND option_c = $t$\(d = v\)/H₀ \(= \frac{21\,000}{70} = 300\) Mpc. Converting: 300 Mpc \(\times 3.09 \times 10^{22}\,\text{m}\text{/Mpc}\) \(= 9.27 \times 10^{24}\,\text{m}\). In light-years: \(9.27 \times \frac{10^{24}}{9.46} \times 10^{15} \approx 9.8 \times 10^{8}\) light-years \(\approx 980\) million light-years. This means we are seeing this galaxy as it was approximately 980 million years ago — when complex multicellular life had just begun to appear on Earth.$t$
  AND option_d = $t$\(d = 0.003\) Mpc \(= 10\,000\) light-years$t$
  AND explanation = $t$\(d = v\)/H₀ \(= \frac{21\,000}{70} = 300\) Mpc. Converting: 300 Mpc \(\times 3.09 \times 10^{22}\,\text{m}\text{/Mpc}\) \(= 9.27 \times 10^{24}\,\text{m}\). In light-years: \(9.27 \times \frac{10^{24}}{9.46} \times 10^{15} \approx 9.8 \times 10^{8}\) light-years \(\approx 980\) million light-years. This means we are seeing this galaxy as it was approximately 980 million years ago — when complex multicellular life \(h\)$t$;

UPDATE questions SET
  option_b = $t$The distance light travels through a vacuum in one year — approximately 9.46 x 10^15 metres. Used in astronomy because interstellar distances are so enormous that kilometres produce unwieldy numbers.$t$,
  explanation = $t$1 light-year = 9.46 x 10^15 m. The nearest star Proxima Centauri is approximately 4.2 light-years away.$t$
WHERE id = 2400
  AND option_b = $t$The distance light travels through a vacuum in one year — approximately \(9.46 \times 10^{15}\) metres. Used in astronomy because interstellar distances are so enormous that kilometres produce unwieldy numbers.$t$
  AND explanation = $t$1 light-year \(= 9.46 \times 10^{15}\,\text{m}\). The nearest star Proxima Centauri is approximately 4.2 light-years away.$t$;

UPDATE questions SET
  option_c = $t$By nuclear fusion in its core — hydrogen nuclei fuse to form helium releasing energy. The mass of the helium nucleus is slightly less than the four protons that combined and this mass difference is converted to energy via E = mc2.$t$,
  explanation = $t$The Sun converts approximately 4 million tonnes of mass to energy every second producing 3.8 x 10^26 W.$t$
WHERE id = 2401
  AND option_c = $t$By nuclear fusion in its core — hydrogen nuclei fuse to form helium releasing energy. The mass of the helium nucleus is slightly less than the four protons that combined and this mass difference is converted to energy via \(E = mc^{2}\).$t$
  AND explanation = $t$The Sun converts approximately 4 million tonnes of mass to energy every second producing \(3.8 \times 10^{26}\,\text{W}\).$t$;

UPDATE questions SET
  option_b = $t$Because light travels at a finite speed of approximately 3 x 10^8 m/s. Light from a distant star left that star years ago — the further away the star the older the light we receive. We see the star as it was when the light left it not as it is now.$t$
WHERE id = 2403
  AND option_b = $t$Because light travels at a finite speed of approximately \(3 \times 10^{8}\,\text{m/s}\). Light from a distant star left that star years ago — the further away the star the older the light we receive. We see the star as it was when the light left it not as it is now.$t$;

UPDATE questions SET
  explanation = $t$The Sun has mass 2 x 10^30 kg and diameter approximately 1.4 million km. It is classified as a G-type main sequence star and is approximately 4.6 billion years old.$t$
WHERE id = 2408
  AND explanation = $t$The Sun has mass \(2 \times 10^{30}\,\text{kg}\) and diameter approximately 1.4 million km. It is classified as a G-type main sequence star and is approximately 4.6 billion years old.$t$;

UPDATE questions SET
  option_b = $t$From the work-energy theorem: braking force x distance = kinetic energy = 1/2 mv2. Since braking force is approximately constant d = mv2/(2F). Stopping distance is proportional to v2. Doubling speed quadruples stopping distance. A car at 60 mph has four times the braking distance of the same car at 30 mph — a direct consequence of kinetic energy depending on v2.$t$,
  explanation = $t$KE = 1/2 mv2 is proportional to v2. Since W = Fd and the work done by brakes must equal KE then d is proportional to v2. This is why speed limits are so effective at reducing accident severity.$t$
WHERE id = 2411
  AND option_b = $t$From the work-energy theorem: braking force × distance = kinetic energy \(= \frac{1}{2} mv^{2}\). Since braking force is approximately constant \(d = \frac{mv^{2}}{2F}\). Stopping distance is proportional to \(v^{2}\). Doubling speed quadruples stopping distance. A car at 60 mph has four times the braking distance of the same car at 30 mph — a direct consequence of kinetic energy depending on \(v^{2}\).$t$
  AND explanation = $t$\(KE = \frac{1}{2} mv^{2}\) is proportional to \(v^{2}\). Since W = Fd and the work done by brakes must equal KE then \(d\) is proportional to \(v^{2}\). This is why speed limits are so effective at reducing accident severity.$t$;

UPDATE questions SET
  question_text = $t$A 2 kg block slides 8 m down a frictionless ramp inclined at 30 degrees to the horizontal. Calculate the speed at the bottom. (g = 10 N/kg)$t$,
  option_a = $t$6.3 m/s$t$,
  option_b = $t$4.0 m/s$t$,
  option_c = $t$12.6 m/s$t$,
  option_d = $t$8.9 m/s$t$,
  explanation = $t$Vertical height = 8 x sin(30) = 8 x 0.5 = 4 m. Conservation of energy: mgh = 1/2 mv2. v2 = 2gh = 2 x 10 x 4 = 80. v = sqrt(80) = 8.94 m/s approximately 8.9 m/s. Mass cancels so the answer is independent of the mass of the block.$t$
WHERE id = 2412
  AND question_text = $t$A \(2\,\text{kg}\) block slides 8 m down a frictionless ramp inclined at 30 degrees to the horizontal. Calculate the speed at the bottom. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(6.3\,\text{m/s}\)$t$
  AND option_b = $t$\(4.0\,\text{m/s}\)$t$
  AND option_c = $t$\(12.6\,\text{m/s}\)$t$
  AND option_d = $t$\(8.9\,\text{m/s}\)$t$
  AND explanation = $t$Vertical height \(= 8 x \sin(30) = 8 \times 0.5 = 4\,\text{m}\). Conservation of energy: \(mgh = \frac{1}{2} mv^{2}\). \(v^{2} = 2gh = 2 \times 10 \times 4 = 80\). \(v = \sqrt{80} = 8.94\,\text{m/s}\) approximately \(8.9\,\text{m/s}\). Mass cancels so the answer is independent of the mass of the block.$t$;

UPDATE questions SET
  option_a = $t$k = 300 N/m and EPE = 0.12 J$t$,
  option_b = $t$k = 48 N/m and EPE = 0.096 J$t$,
  option_c = $t$k = 0.003 N/m and EPE = 0.24 J$t$,
  option_d = $t$k = 300 N/m and EPE = 0.24 J$t$,
  explanation = $t$k = F/x = 12/0.04 = 300 N/m. EPE = 1/2 kx2 = 1/2 x 300 x (0.04)2 = 150 x 0.0016 = 0.24 J. This also equals the area under the force-extension graph: 1/2 x 12 x 0.04 = 0.24 J.$t$
WHERE id = 2413
  AND option_a = $t$\(k = 300\,\text{N/m}\) and \(EPE = 0.12\,\text{J}\)$t$
  AND option_b = $t$\(k = 48\,\text{N/m}\) and \(EPE = 0.096\,\text{J}\)$t$
  AND option_c = $t$\(k = 0.003\,\text{N/m}\) and \(EPE = 0.24\,\text{J}\)$t$
  AND option_d = $t$\(k = 300\,\text{N/m}\) and \(EPE = 0.24\,\text{J}\)$t$
  AND explanation = $t$\(k = \frac{F}{x} = \frac{12}{0.04} = 300\,\text{N/m}\). \(EPE = \frac{1}{2} kx^{2} = \frac{1}{2} \times 300 \times (0.04)2 = 150 \times 0.0016 = 0.24\,\text{J}\). This also equals the area under the force-extension graph: \(\frac{1}{2} \times 12 \times 0.04 = 0.24\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$A 90% efficient motor with input power 600 W lifts a 250 kg load. Calculate how long it takes to lift the load through 3 m. (g = 10 N/kg)$t$,
  explanation = $t$Useful power = 0.9 x 600 = 540 W. Work needed = mgh = 250 x 10 x 3 = 7500 J. Time = W/P = 7500/540 = 13.9 s.$t$
WHERE id = 2414
  AND question_text = $t$A 90% efficient motor with input power 600 W lifts \(a\) \(250\,\text{kg}\) load. Calculate how long it takes to lift the load through 3 m. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Useful power \(= 0.9 \times 600 = 540\,\text{W}\). Work needed \(= mgh = 250 \times 10 \times 3 = 7500\,\text{J}\). Time \(= \frac{W}{P} = \frac{7500}{540} = 13.9\,\text{s}\).$t$;

UPDATE questions SET
  explanation = $t$The resultant force (net force) determines the acceleration of an object via Newtons second law F = ma. If forces are balanced the resultant is zero and the object is in equilibrium.$t$
WHERE id = 2415
  AND explanation = $t$The resultant force (net force) determines the acceleration of an object via Newtons second law \(F = ma\). If forces are balanced the resultant is zero and the object is in equilibrium.$t$;

UPDATE questions SET
  explanation = $t$Resultant = 50 - 20 = 30 N in the direction of the larger force (to the right). The box will accelerate to the right.$t$
WHERE id = 2416
  AND explanation = $t$Resultant \(= 50 - 20 = 30\,\text{N}\) in the direction of the larger force (to the right). The box will accelerate to the right.$t$;

UPDATE questions SET
  option_d = $t$The turning effect of a force about a pivot. Moment = force x perpendicular distance from the pivot to the line of action of the force. Unit: newton-metre (N m).$t$,
  explanation = $t$Moment = F x d where d is the perpendicular distance from the pivot. A larger force or a greater distance from the pivot produces a larger turning effect.$t$
WHERE id = 2417
  AND option_d = $t$The turning effect of a force about a pivot. Moment = force × perpendicular distance from the pivot to the line of action of the force. Unit: newton-metre (N \(m\)).$t$
  AND explanation = $t$Moment \(= F \times d\) where \(d\) is the perpendicular distance from the pivot. A larger force or a greater distance from the pivot produces a larger turning effect.$t$;

UPDATE questions SET
  option_a = $t$75 N m$t$,
  option_b = $t$0.013 N m$t$,
  option_c = $t$12 N m$t$,
  option_d = $t$120 N m$t$,
  explanation = $t$Moment = F x d = 30 x 0.4 = 12 N m.$t$
WHERE id = 2418
  AND option_a = $t$75 N \(m\)$t$
  AND option_b = $t$0.013 N \(m\)$t$
  AND option_c = $t$12 N \(m\)$t$
  AND option_d = $t$120 N \(m\)$t$
  AND explanation = $t$Moment \(= F \times d = 30 \times 0.4 = 12\,\text{N}\ m\).$t$;

UPDATE questions SET
  explanation = $t$Principle of moments (law of the lever): sum of clockwise moments = sum of anticlockwise moments when in equilibrium. This is used to solve problems involving balanced beams seesaws and levers.$t$
WHERE id = 2419
  AND explanation = $t$Principle of moments (law of the lever): sum of clockwise moments \(= sum\) of anticlockwise moments when in equilibrium. This is used to solve problems involving balanced beams seesaws and levers.$t$;

UPDATE questions SET
  explanation = $t$Anticlockwise moment = 300 x 1.5 = 450 N m. For balance: 200 x d = 450. d = 450/200 = 2.25 m from the pivot.$t$
WHERE id = 2420
  AND explanation = $t$Anticlockwise moment \(= 300 \times 1.5 = 450\,\text{N}\ m\). For balance: \(200 \times d = 450\). \(d = \frac{450}{200} = 2.25\,\text{m}\) from the pivot.$t$;

UPDATE questions SET
  option_a = $t$Pressure is the force applied per unit area. Pressure = force / area (P = F/A). Unit: pascal (Pa) where 1 Pa = 1 N/m2. The same force applied over a smaller area produces greater pressure.$t$,
  explanation = $t$P = F/A. Example: a force of 100 N on an area of 0.01 m2 gives pressure = 10,000 Pa. Sharp knives cut because the small area creates very high pressure.$t$
WHERE id = 2421
  AND option_a = $t$Pressure is the force applied per unit area. Pressure = force / area \((P = \frac{F}{A})\). Unit: pascal (Pa) where 1 Pa = \(1\,\text{N/m}^{2}\). The same force applied over a smaller area produces greater pressure.$t$
  AND explanation = $t$\(P = \frac{F}{A}\). Example: a force of 100 N on an area of \(0.01 m^{2}\) gives pressure \(= 10\,000\,\text{Pa}\). Sharp knives cut because the small area creates very high pressure.$t$;

UPDATE questions SET
  question_text = $t$A force of 500 N acts on an area of 0.025 m2. Calculate the pressure.$t$,
  option_d = $t$20,000 Pa$t$,
  explanation = $t$P = F/A = 500/0.025 = 20,000 Pa.$t$
WHERE id = 2422
  AND question_text = $t$A force of 500 N acts on an area of \(0.025 m^{2}\). Calculate the pressure.$t$
  AND option_d = $t$20 000 Pa$t$
  AND explanation = $t$\(P = \frac{F}{A} = \frac{500}{0.025} = 20\,000\,\text{Pa}\).$t$;

UPDATE questions SET
  explanation = $t$Equilibrium requires two conditions: (1) resultant force = 0 in all directions (translational equilibrium) and (2) net moment = 0 about any point (rotational equilibrium).$t$
WHERE id = 2425
  AND explanation = $t$Equilibrium requires two conditions: (1) resultant force \(= 0\) in all directions (translational equilibrium) and (2) net moment \(= 0\) about any point (rotational equilibrium).$t$;

UPDATE questions SET
  explanation = $t$The pivot is at the centre (1.5 m), so the beam's own weight has no moment. The 100 N weight is 0.5 m left of the pivot: anticlockwise moment = 100 × 0.5 = 50 N m. For balance, 80 × d = 50, so d = 0.625 m to the right of the pivot.$t$
WHERE id = 2426
  AND explanation = $t$The pivot is at the centre (1.5 m), so the beam's own weight has no moment. The 100 N weight is 0.5 m left of the pivot: anticlockwise moment \(= 100 \times 0.5 = 50\,\text{N}\ m\). For balance, \(80 \times d = 50\), so \(d = 0.625\,\text{m}\) to the right of the pivot.$t$;

UPDATE questions SET
  option_d = $t$Pressure is transmitted equally throughout an enclosed fluid (Pascals principle). If a small force acts on a small piston area it creates a pressure (P = F/A). This same pressure acts on a larger piston area producing a much larger output force (F = P x A). The trade-off is that the small piston must move a greater distance than the large piston — energy is conserved.$t$,
  explanation = $t$Hydraulic systems: same pressure throughout. F1/A1 = F2/A2. If A2 = 10 x A1 then F2 = 10 x F1. Used in car brakes JCB diggers and hydraulic presses.$t$
WHERE id = 2427
  AND option_d = $t$Pressure is transmitted equally throughout an enclosed fluid (Pascals principle). If a small force acts on a small piston area it creates a pressure \((P = \frac{F}{A})\). This same pressure acts on a larger piston area producing a much larger output force \((F = P \times A)\). The trade-off is that the small piston must move a greater distance than the large piston — energy is conserved.$t$
  AND explanation = $t$Hydraulic systems: same pressure throughout. \(\frac{F_{1}}{A_{1}} = \frac{F_{2}}{A_{2}}\). If \(A_{2} = 10 x A_{1}\) then \(F_{2} = 10 x F_{1}\). Used in car brakes JCB diggers and hydraulic presses.$t$;

UPDATE questions SET
  explanation = $t$This is a wheel-and-axle problem. Moment at handle = moment at shaft. F_handle x r_handle = F_shaft x r_shaft. 10 x 0.02 = F_shaft x 0.004. F_shaft = 0.2/0.004 = 50 N. The wider handle amplifies the turning force.$t$
WHERE id = 2428
  AND explanation = $t$This is a wheel-and-axle problem. Moment at handle = moment at shaft. F_handle x \(r\)_handle \(= F\)_shaft x \(r\)_shaft. \(10 \times 0.02 = F\)_shaft x 0.004. F_shaft \(= \frac{0.2}{0.004} = 50\,\text{N}\). The wider handle amplifies the turning force.$t$;

UPDATE questions SET
  option_a = $t$A longer spanner increases the perpendicular distance from the pivot (the bolt) to the line of action of the applied force. Since moment = force x distance a longer spanner produces a greater turning moment for the same applied force making it easier to overcome the resistance of the tight bolt.$t$,
  explanation = $t$Moment = F x d. Doubling the spanner length doubles the moment for the same force. This is why torque wrenches have long handles and why wheel braces for cars are designed to be as long as practical.$t$
WHERE id = 2429
  AND option_a = $t$A longer spanner increases the perpendicular distance from the pivot (the bolt) to the line of action of the applied force. Since moment = force × distance a longer spanner produces a greater turning moment for the same applied force making it easier to overcome the resistance of the tight bolt.$t$
  AND explanation = $t$Moment \(= F \times d\). Doubling the spanner length doubles the moment for the same force. This is why torque wrenches have long handles and why wheel braces for cars are designed to be as long as practical.$t$;

UPDATE questions SET
  question_text = $t$A rectangular block of dimensions 0.2 m x 0.3 m x 0.1 m is placed on a surface with the largest face down. The block weighs 60 N. Calculate the pressure on the surface.$t$,
  explanation = $t$Largest face area = 0.2 x 0.3 = 0.06 m2. Pressure = F/A = 60/0.06 = 1000 Pa.$t$
WHERE id = 2431
  AND question_text = $t$A rectangular block of dimensions \(0.2\,\text{m} \times 0.3\,\text{m} \times 0.1\,\text{m}\) is placed on a surface with the largest face down. The block weighs 60 N. Calculate the pressure on the surface.$t$
  AND explanation = $t$Largest face area \(= 0.2 \times 0.3 = 0.06 m^{2}\). Pressure \(= \frac{F}{A} = \frac{60}{0.06} = 1000\,\text{Pa}\).$t$;

UPDATE questions SET
  explanation = $t$Anticlockwise moment: 4 N at 20 cm mark is 30 cm from pivot. Moment = 4 x 0.30 = 1.2 N m. Clockwise moment = 6 x d = 1.2. d = 0.2 m = 20 cm from pivot. Position = 50 + 20 = 70 cm mark.$t$
WHERE id = 2433
  AND explanation = $t$Anticlockwise moment: 4 N at 20 cm mark is 30 cm from pivot. Moment \(= 4 \times 0.30 = 1.2\,\text{N}\ m\). Clockwise moment \(= 6 \times d = 1.2\). \(d = 0.2 m = 20\,\text{cm}\) from pivot. Position \(= 50 + 20 = 70\,\text{cm}\) mark.$t$;

UPDATE questions SET
  explanation = $t$Stability = low centre of gravity + wide base. F1 cars have centre of gravity approximately 25-30 cm above the ground. Road cars typically have centres of gravity approximately 50-70 cm above the ground.$t$
WHERE id = 2434
  AND explanation = $t$Stability \(= low\) centre of gravity + wide base. \(F_{1}\) cars have centre of gravity approximately 25–30 cm above the ground. Road cars typically have centres of gravity approximately 50–70 cm above the ground.$t$;

UPDATE questions SET
  explanation = $t$Right support reaction = 200 - 80 = 120 N. Taking moments about the left end: 120 x 4 = 200 x d. 480 = 200d. d = 2.4 m from the left end. The centre of gravity is closer to the heavier (right) end.$t$
WHERE id = 2435
  AND explanation = $t$Right support reaction \(= 200 - 80 = 120\,\text{N}\). Taking moments about the left end: \(120 \times 4 = 200 \times d\). \(480 = 200d\). \(d = 2.4\,\text{m}\) from the left end. The centre of gravity is closer to the heavier (right) end.$t$;

UPDATE questions SET
  explanation = $t$The same principle explains why a solid steel ball sinks but a hollow steel ball can float. The average density of the ship including enclosed air must be less than 1000 kg/m3 (density of water).$t$
WHERE id = 2436
  AND explanation = $t$The same principle explains why a solid steel ball sinks but a hollow steel ball can float. The average density of the ship including enclosed air must be less than \(1000\,\text{kg/m}^{3}\) (density of water).$t$;

UPDATE questions SET
  question_text = $t$A diver of weight 750 N and volume 0.072 m3 is submerged in seawater of density 1025 kg/m3. Calculate the upthrust and determine whether the diver sinks or floats. (g = 10 N/kg)$t$,
  option_a = $t$Upthrust = 738 N so diver sinks$t$,
  option_b = $t$Upthrust = 720 N so diver sinks$t$,
  option_c = $t$Upthrust = 750 N so diver is neutrally buoyant$t$,
  option_d = $t$Upthrust = 760 N so diver floats$t$,
  explanation = $t$Upthrust = weight of fluid displaced = rho x V x g = 1025 x 0.072 x 10 = 738 N. Weight = 750 N. Since weight > upthrust the diver sinks. Divers use buoyancy control devices (BCDs) to adjust their average density.$t$
WHERE id = 2437
  AND question_text = $t$A diver of weight 750 N and volume \(0.072 m^{3}\) is submerged in seawater of density \(1025\,\text{kg/m}^{3}\). Calculate the upthrust and determine whether the diver sinks or floats. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$Upthrust \(= 738\,\text{N}\) so diver sinks$t$
  AND option_b = $t$Upthrust \(= 720\,\text{N}\) so diver sinks$t$
  AND option_c = $t$Upthrust \(= 750\,\text{N}\) so diver is neutrally buoyant$t$
  AND option_d = $t$Upthrust \(= 760\,\text{N}\) so diver floats$t$
  AND explanation = $t$Upthrust = weight of fluid displaced \(= rho x V \times g = 1025 \times 0.072 \times 10 = 738\,\text{N}\). Weight \(= 750\,\text{N}\). Since weight > upthrust the diver sinks. Divers use buoyancy control devices (BCDs) to adjust their average density.$t$;

UPDATE questions SET
  question_text = $t$Explain why the pressure at a depth h in a liquid is given by P = rho x g x h and calculate the pressure at 15 m depth in seawater of density 1025 kg/m3. (g = 10 N/kg)$t$,
  option_a = $t$P = rho x g x h because deeper layers must support less fluid weight$t$,
  option_b = $t$P = rho x g x h only applies to gases not liquids$t$,
  option_c = $t$A column of liquid of height h cross-sectional area A and density rho has weight = rho x A x h x g. This weight acts on area A so pressure = weight/area = rho x g x h. The area cancels giving pressure dependent only on depth and density. At 15 m depth: P = 1025 x 10 x 15 = 153,750 Pa approximately 154 kPa. This is the gauge pressure — absolute pressure would also include atmospheric pressure (101,325 Pa).$t$,
  explanation = $t$Liquid pressure: P = rho g h. This is why deep-sea submarines need enormously strong hulls and why dams are thicker at the base than at the top.$t$
WHERE id = 2438
  AND question_text = $t$Explain why the pressure at a depth \(h\) in a liquid is given by \(P = rho x g \times h\) and calculate the pressure at 15 m depth in seawater of density \(1025\,\text{kg/m}^{3}\). (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(P = rho x g \times h\) because deeper layers must support less fluid weight$t$
  AND option_b = $t$\(P = rho x g \times h\) only applies to gases not liquids$t$
  AND option_c = $t$A column of liquid of height \(h\) cross-sectional area A and density rho has weight \(= rho x A \times h \times g\). This weight acts on area A so pressure = weight/area \(= rho x g \times h\). The area cancels giving pressure dependent only on depth and density. At 15 m depth: \(P = 1025 \times 10 \times 15 = 153\,750\,\text{Pa}\) approximately 154 kPa. This is the gauge pressure — absolute pressure would also include atmospheric pressure (101 325 Pa).$t$
  AND explanation = $t$Liquid pressure: \(P = rho g h\). This is why deep-sea submarines need enormously strong hulls and why dams are thicker at the base than at the top.$t$;

UPDATE questions SET
  explanation = $t$Taking moments about the hinge (left end): Clockwise moments = (120 x 3) + (200 x 6) = 360 + 1200 = 1560 N m. Anticlockwise moment = T x 4. T = 1560/4 = 390 N. Recalculating: weight of beam acts at centre (3 m). T x 4 = 120 x 3 + 200 x 6 = 360 + 1200 = 1560. T = 390 N.$t$
WHERE id = 2439
  AND explanation = $t$Taking moments about the hinge (left end): Clockwise moments \(= (120 \times 3) + (200 \times 6) = 360 + 1200 = 1560\,\text{N}\ m\). Anticlockwise moment \(= T \times 4\). \(T = \frac{1560}{4} = 390\,\text{N}\). Recalculating: weight of beam acts at centre (3 m). \(T \times 4 = 120 \times 3 + 200 \times 6 = 360 + 1200 = 1560\). \(T = 390\,\text{N}\).$t$;

UPDATE questions SET
  option_a = $t$Atmospheric pressure at any altitude is caused by the weight of the column of air above that point. At higher altitudes there is less air above — the column is shorter and lighter — so the pressure is lower. At sea level the full weight of the atmosphere (approximately 100,000 Pa) presses down. At 5000 m: pressure = 100,000 - (12 x 5000) = 100,000 - 60,000 = 40,000 Pa. (The actual value is approximately 54,000 Pa because density also decreases with altitude.)$t$
WHERE id = 2440
  AND option_a = $t$Atmospheric pressure at any altitude is caused by the weight of the column of air above that point. At higher altitudes there is less air above — the column is shorter and lighter — so the pressure is lower. At sea level the full weight of the atmosphere (approximately 100 000 Pa) presses down. At 5000 m: pressure \(= 100\,000 - (12 \times 5000) = 100\,000 - 60\,000 = 40\,000\,\text{Pa}\). (The actual value is approximately 54 000 Pa because density also decreases with altitude.)$t$;

UPDATE questions SET
  explanation = $t$The weight of the rule (1.0 N) acts at its centre of gravity at the 50 cm mark. The pivot is at 40 cm so the rules weight creates a clockwise moment = 1.0 x (0.50 - 0.40) = 1.0 x 0.10 = 0.10 N m. Anticlockwise moment from 0.5 N weight: 0.5 x d = 0.10. d = 0.20 m = 20 cm to the left of the pivot. Position = 40 - 20 = 20 cm mark.$t$
WHERE id = 2441
  AND explanation = $t$The weight of the rule (1.0 N) acts at its centre of gravity at the 50 cm mark. The pivot is at 40 cm so the rules weight creates a clockwise moment \(= 1.0 \times (0.50 - 0.40) = 1.0 \times 0.10 = 0.10\,\text{N}\ m\). Anticlockwise moment from 0.5 N weight: \(0.5 \times d = 0.10\). \(d = 0.20 m = 20\,\text{cm}\) to the left of the pivot. Position \(= 40 - 20 = 20\,\text{cm}\) mark.$t$;

UPDATE questions SET
  explanation = $t$Using Pythagoras: resultant = sqrt(40^2 + 30^2) = sqrt(1600 + 900) = sqrt(2500) = 50 N. Direction: tan(theta) = 30/40 = 0.75. theta = 36.9 degrees approximately 37 degrees to the 40 N force (53 degrees to the 30 N force). The resultant is 50 N at 37 degrees to the larger force.$t$
WHERE id = 2443
  AND explanation = $t$Using Pythagoras: resultant \(= \sqrt{40^{2} + 30^{2}} = \sqrt{1600 + 900} = \sqrt{2500} = 50\,\text{N}\). Direction: tan(theta) \(= \frac{30}{40} = 0.75\). theta \(= 36.9\) degrees approximately 37 degrees to the 40 N force (53 degrees to the 30 N force). The resultant is 50 N at 37 degrees to the larger force.$t$;

UPDATE questions SET
  explanation = $t$Taking moments about the base of the ladder: Wall reaction R acts horizontally at the top (5 m along ladder = 5 sin60 = 4.33 m high = 5 cos60 = 2.5 m horizontal from base). Clockwise: 200 x (2.5/2) + 700 x (0.75 x 2.5) = 200 x 1.25 + 700 x 1.875 = 250 + 1312.5 = 1562.5 N m. R x 4.33 = 1562.5. R = 360.8 N approximately 361 N.$t$
WHERE id = 2444
  AND explanation = $t$Taking moments about the base of the ladder: Wall reaction R acts horizontally at the top (5 m along ladder \(= 5 \sin 60 = 4.33\,\text{m}\) high \(= 5 \cos 60 = 2.5\,\text{m}\) horizontal from base). Clockwise: \(200 \times (\frac{2.5}{2}) + 700 \times (0.75 \times 2.5) = 200 \times 1.25 + 700 \times 1.875 = 250 + 1312.5 = 1562.5\,\text{N}\ m\). \(R \times 4.33 = 1562.5\). \(R = 360.8\,\text{N}\) approximately 361 N.$t$;

UPDATE questions SET
  option_b = $t$The rate of flow of electric charge. I = Q/t where I is current (amperes A) Q is charge (coulombs C) and t is time (seconds). Current is measured with an ammeter connected in series.$t$,
  explanation = $t$Current I = Q/t. 1 ampere = 1 coulomb of charge flowing per second. In a metal conductor current is carried by free electrons moving from negative to positive terminal (conventional current flows positive to negative).$t$
WHERE id = 2445
  AND option_b = $t$The rate of flow of electric charge. \(I = \frac{Q}{t}\) where I is current (amperes A) Q is charge (coulombs C) and \(t\) is time (seconds). Current is measured with an ammeter connected in series.$t$
  AND explanation = $t$Current \(I = \frac{Q}{t}\). 1 ampere \(= 1\) coulomb of charge flowing per second. In a metal conductor current is carried by free electrons moving from negative to positive terminal (conventional current flows positive to negative).$t$;

UPDATE questions SET
  option_a = $t$The energy transferred per unit charge between two points in a circuit. V = W/Q where V is potential difference (volts V) W is energy (joules J) and Q is charge (coulombs C). Measured with a voltmeter connected in parallel.$t$,
  explanation = $t$PD = W/Q. 1 volt = 1 joule per coulomb. A 9 V battery transfers 9 J of energy for every coulomb of charge that flows through it.$t$
WHERE id = 2446
  AND option_a = $t$The energy transferred per unit charge between two points in a circuit. \(V = \frac{W}{Q}\) where V is potential difference (volts V) W is energy (joules J) and Q is charge (coulombs C). Measured with a voltmeter connected in parallel.$t$
  AND explanation = $t$\(PD = \frac{W}{Q}\). 1 volt \(= 1\) joule per coulomb. A 9 V battery transfers 9 J of energy for every coulomb of charge that flows through it.$t$;

UPDATE questions SET
  option_c = $t$The opposition to the flow of electric current in a component. R = V/I (Ohms law). Unit: ohm (Omega). A higher resistance means less current flows for a given potential difference.$t$,
  explanation = $t$Resistance R = V/I (Ohms law). Unit: ohm. A resistor with resistance 10 ohms with 5 V across it carries current I = V/R = 5/10 = 0.5 A.$t$
WHERE id = 2447
  AND option_c = $t$The opposition to the flow of electric current in a component. \(R = \frac{V}{I}\) (Ohms law). Unit: ohm (Omega). A higher resistance means less current flows for a given potential difference.$t$
  AND explanation = $t$Resistance \(R = \frac{V}{I}\) (Ohms law). Unit: ohm. A resistor with resistance 10 ohms with 5 V across it carries current \(I = \frac{V}{R} = \frac{5}{10} = 0.5\,\text{A}\).$t$;

UPDATE questions SET
  explanation = $t$V = IR = 2 x 12 = 24 V.$t$
WHERE id = 2448
  AND explanation = $t$\(V = IR = 2 \times 12 = 24 V\).$t$;

UPDATE questions SET
  option_a = $t$I = 3 A; V1 = 12 V; V2 = 12 V$t$,
  option_b = $t$I = 2 A; V1 = 4 V; V2 = 8 V$t$,
  option_c = $t$I = 1 A; V1 = 4 V; V2 = 8 V$t$,
  option_d = $t$I = 0.5 A; V1 = 2 V; V2 = 4 V$t$,
  explanation = $t$Total resistance = 4 + 8 = 12 ohms. I = V/R = 12/12 = 1 A. V1 = IR1 = 1 x 4 = 4 V. V2 = IR2 = 1 x 8 = 8 V. Check: 4 + 8 = 12 V (total battery voltage).$t$
WHERE id = 2450
  AND option_a = $t$\(I = 3\,\text{A}\); \(V_{1} = 12\,\text{V}\); \(V_{2} = 12\,\text{V}\)$t$
  AND option_b = $t$\(I = 2\,\text{A}\); \(V_{1} = 4\,\text{V}\); \(V_{2} = 8\,\text{V}\)$t$
  AND option_c = $t$\(I = 1\,\text{A}\); \(V_{1} = 4\,\text{V}\); \(V_{2} = 8\,\text{V}\)$t$
  AND option_d = $t$\(I = 0.5\,\text{A}\); \(V_{1} = 2\,\text{V}\); \(V_{2} = 4\,\text{V}\)$t$
  AND explanation = $t$Total resistance \(= 4 + 8 = 12\,\text{ohms}\). \(I = \frac{V}{R} = \frac{12}{12} = 1\,\text{A}\). \(V_{1}\)= IR1 \(= 1 \times 4 = 4\,\text{V}\). \(V_{2} = IR^{2} = 1 \times 8 = 8\,\text{V}\). Check: \(4 + 8 = 12\,\text{V}\) (total battery voltage).$t$;

UPDATE questions SET
  option_a = $t$Power is the rate at which energy is transferred by a component. P = IV = I2R = V2/R where P is power (watts W) I is current (A) and V is voltage (V). A component with higher power transfers more energy per second.$t$,
  explanation = $t$P = IV. A 230 V kettle drawing 8 A has power = 230 x 8 = 1840 W approximately 1.8 kW. The energy used = Pt.$t$
WHERE id = 2451
  AND option_a = $t$Power is the rate at which energy is transferred by a component. \(P = IV = I^{2}R = \frac{V^{2}}{R}\) where P is power (watts W) I is current (A) and V is voltage (V). A component with higher power transfers more energy per second.$t$
  AND explanation = $t$\(P = IV\). A 230 V kettle drawing 8 A has power \(= 230 \times 8 = 1840\,\text{W}\) approximately 1.8 kW. The energy used = Pt.$t$;

UPDATE questions SET
  explanation = $t$P = I2R = 3^2 x 6 = 9 x 6 = 54 W.$t$
WHERE id = 2452
  AND explanation = $t$\(P = I^{2}R = 3^{2} \times 6 = 9 \times 6 = 54\,\text{W}\).$t$;

UPDATE questions SET
  explanation = $t$I = Q/t = 150/30 = 5 A.$t$
WHERE id = 2455
  AND explanation = $t$\(I = \frac{Q}{t} = \frac{150}{30} = 5\,\text{A}\).$t$;

UPDATE questions SET
  option_a = $t$I1 = 1 A; I2 = 0.5 A; total = 1.5 A$t$,
  option_b = $t$I1 = 6 A; I2 = 3 A; total = 9 A$t$,
  option_c = $t$I1 = 2 A; I2 = 1 A; total = 3 A$t$,
  option_d = $t$I1 = 0.5 A; I2 = 0.25 A; total = 0.75 A$t$,
  explanation = $t$Both resistors have 12 V across them (parallel). I1 = V/R1 = 12/6 = 2 A. I2 = V/R2 = 12/12 = 1 A. Total current = 2 + 1 = 3 A.$t$
WHERE id = 2456
  AND option_a = $t$\(I_{1} = 1\,\text{A}\); \(I_{2} = 0.5\,\text{A}\); total \(= 1.5\,\text{A}\)$t$
  AND option_b = $t$\(I_{1} = 6\,\text{A}\); \(I_{2} = 3\,\text{A}\); total \(= 9\,\text{A}\)$t$
  AND option_c = $t$\(I_{1} = 2\,\text{A}\); \(I_{2} = 1\,\text{A}\); total \(= 3\,\text{A}\)$t$
  AND option_d = $t$\(I_{1} = 0.5\,\text{A}\); \(I_{2} = 0.25\,\text{A}\); total \(= 0.75\,\text{A}\)$t$
  AND explanation = $t$Both resistors have 12 V across them (parallel). \(I_{1} = \frac{V}{R_{1}} = \frac{12}{6} = 2\,\text{A}\). \(I_{2} = \frac{V}{R_{2}} = \frac{12}{12} = 1\,\text{A}\). Total current \(= 2 + 1 = 3\,\text{A}\).$t$;

UPDATE questions SET
  explanation = $t$For two resistors in parallel: 1/R_total = 1/R1 + 1/R2. Adding parallel branches always reduces total resistance. This is why parallel circuits draw more current from the battery than series circuits using the same resistors.$t$
WHERE id = 2457
  AND explanation = $t$For two resistors in parallel: \(\frac{1}{R}\)_total \(= \frac{1}{R_{1}} + \frac{1}{R_{2}}\). Adding parallel branches always reduces total resistance. This is why parallel circuits draw more current from the battery than series circuits using the same resistors.$t$;

UPDATE questions SET
  option_a = $t$21,600,000 J and 6 kWh$t$,
  option_b = $t$21,600 J and 6 kWh$t$,
  option_c = $t$21,600 J and 0.006 kWh$t$,
  option_d = $t$6,000 J and 6 kWh$t$,
  explanation = $t$Energy in joules = P x t = 2000 x (3 x 3600) = 2000 x 10,800 = 21,600,000 J. Energy in kWh = P(kW) x t(h) = 2 x 3 = 6 kWh.$t$
WHERE id = 2458
  AND option_a = $t$21 600 000 J and 6 kWh$t$
  AND option_b = $t$21 600 J and 6 kWh$t$
  AND option_c = $t$21 600 J and 0.006 kWh$t$
  AND option_d = $t$6 000 J and 6 kWh$t$
  AND explanation = $t$Energy in joules \(= P \times t = 2000 \times (3 \times 3600) = 2000 \times 10\,800 = 21\,600\,000\,\text{J}\). Energy in kWh \(= P\)(kW) ×\(t(h) = 2 \times 3 = 6\,\text{kWh}\).$t$;

UPDATE questions SET
  option_d = $t$An ohmic conductor obeys Ohms law: V = IR at constant temperature. The I-V characteristic is a straight line through the origin with a constant gradient (gradient = 1/R = 1/20 = 0.05 A/V). The component is described as ohmic because the ratio V/I remains constant — resistance does not change with current or voltage as long as temperature is constant.$t$
WHERE id = 2460
  AND option_d = $t$An ohmic conductor obeys Ohms law: \(V = IR\) at constant temperature. The I-V characteristic is a straight line through the origin with a constant gradient (gradient \(= \frac{1}{R} = \frac{1}{20} = 0.05 \frac{\,\text{A}}{V}\)). The component is described as ohmic because the ratio \(\frac{V}{I}\) remains constant — resistance does not change with current or voltage as long as temperature is constant.$t$;

UPDATE questions SET
  question_text = $t$A student measures the following for a component: V = 2 V I = 0.4 A; V = 4 V I = 0.5 A; V = 6 V I = 0.55 A. Is this component ohmic? Explain.$t$,
  option_c = $t$No. For an ohmic conductor V/I must be constant. Calculating: at 2 V: R = 2/0.4 = 5 ohms; at 4 V: R = 4/0.5 = 8 ohms; at 6 V: R = 6/0.55 = 10.9 ohms. Resistance is increasing with voltage so the component is non-ohmic. This behaviour is typical of a filament lamp where increasing current heats the filament raising its resistance.$t$
WHERE id = 2461
  AND question_text = $t$A student measures the following for a component: \(V = 2 V I = 0.4\,\text{A}\); \(V = 4 V I = 0.5\,\text{A}\); \(V = 6 V I = 0.55\,\text{A}\). Is this component ohmic? Explain.$t$
  AND option_c = $t$No. For an ohmic conductor \(\frac{V}{I}\) must be constant. Calculating: at 2 V: \(R = \frac{2}{0.4} = 5\,\text{ohms}\); at 4 V: \(R = \frac{4}{0.5} = 8\,\text{ohms}\); at 6 V: \(R = \frac{6}{0.55} = 10.9\,\text{ohms}\). Resistance is increasing with voltage so the component is non-ohmic. This behaviour is typical of a filament lamp where increasing current heats the filament raising its resistance.$t$;

UPDATE questions SET
  question_text = $t$What is the cost of running a 100 W television for 6 hours if electricity costs 28p per kWh?$t$,
  option_a = $t$168p$t$,
  option_b = $t$1680p$t$,
  option_c = $t$16.8p$t$,
  option_d = $t$1.68p$t$,
  explanation = $t$Energy = P x t = 0.1 kW x 6 h = 0.6 kWh. Cost = 0.6 x 28 = 16.8p.$t$
WHERE id = 2462
  AND question_text = $t$What is the cost of running a 100 W television for 6 hours if electricity costs \(28\,\text{p}\) per kWh?$t$
  AND option_a = $t$\(168p\)$t$
  AND option_b = $t$\(1680p\)$t$
  AND option_c = $t$\(16.8p\)$t$
  AND option_d = $t$\(1.68p\)$t$
  AND explanation = $t$Energy \(= P \times t = 0.1\,\text{kW}\ x 6 h = 0.6\,\text{kWh}\). Cost \(= 0.6 \times 28 = 16.8\,\text{p}\).$t$;

UPDATE questions SET
  option_a = $t$I = 2 A; terminal voltage = 10 V$t$,
  option_b = $t$I = 2 A; terminal voltage = 12 V$t$,
  option_c = $t$I = 2.4 A; terminal voltage = 9.6 V$t$,
  option_d = $t$I = 1.7 A; terminal voltage = 10.3 V$t$,
  explanation = $t$I = EMF/(R + r) = 12/(5 + 1) = 2 A. Terminal voltage = EMF - Ir = 12 - (2 x 1) = 10 V. The 2 V is lost across the internal resistance.$t$
WHERE id = 2464
  AND option_a = $t$\(I = 2\,\text{A}\); terminal voltage \(= 10\,\text{V}\)$t$
  AND option_b = $t$\(I = 2\,\text{A}\); terminal voltage \(= 12\,\text{V}\)$t$
  AND option_c = $t$\(I = 2.4\,\text{A}\); terminal voltage \(= 9.6\,\text{V}\)$t$
  AND option_d = $t$\(I = 1.7\,\text{A}\); terminal voltage \(= 10.3\,\text{V}\)$t$
  AND explanation = $t$\(I = \frac{EMF}{R + r} = \frac{12}{5 + 1} = 2\,\text{A}\). Terminal voltage \(= EMF\)- Ir \(= 12 - (2 \times 1) = 10\,\text{V}\). The 2 V is lost across the internal resistance.$t$;

UPDATE questions SET
  option_a = $t$Total R = 22 ohms; total current = 0.55 A$t$,
  option_b = $t$Total R = 2 ohms; total current = 6 A$t$,
  option_c = $t$Total R = 1.6 ohms; total current = 7.5 A$t$,
  option_d = $t$Total R = 2 ohms; total current = 3 A$t$,
  explanation = $t$1/R = 1/6 + 1/12 + 1/4 = 2/12 + 1/12 + 3/12 = 6/12 = 1/2. R = 2 ohms. Total current = V/R = 12/2 = 6 A. Check: I1 = 12/6 = 2 A; I2 = 12/12 = 1 A; I3 = 12/4 = 3 A. Total = 6 A.$t$
WHERE id = 2465
  AND option_a = $t$Total \(R = 22\,\text{ohms}\); total current \(= 0.55\,\text{A}\)$t$
  AND option_b = $t$Total \(R = 2\,\text{ohms}\); total current \(= 6\,\text{A}\)$t$
  AND option_c = $t$Total \(R = 1.6\,\text{ohms}\); total current \(= 7.5\,\text{A}\)$t$
  AND option_d = $t$Total \(R = 2\,\text{ohms}\); total current \(= 3\,\text{A}\)$t$
  AND explanation = $t$\(\frac{1}{R} = \frac{1}{6} + \frac{1}{12} + \frac{1}{4} = \frac{2}{12} + \frac{1}{12} + \frac{3}{12} = \frac{6}{12} = \frac{1}{2}\). \(R = 2\,\text{ohms}\). Total current \(= \frac{V}{R} = \frac{12}{2} = 6\,\text{A}\). Check: \(I_{1} = \frac{12}{6} = 2\,\text{A}\); \(I_{2} = \frac{12}{12} = 1\,\text{A}\); \(I_{3} = \frac{12}{4} = 3\,\text{A}\). Total \(= 6\,\text{A}\).$t$;

UPDATE questions SET
  option_a = $t$I = 2.25 A; terminal V = 7.875 V; P = 17.7 W$t$,
  option_b = $t$I = 2 A; terminal V = 8 V; P = 16 W$t$,
  option_c = $t$I = 1.8 A; terminal V = 7.2 V; P = 12.96 W$t$,
  option_d = $t$I = 2 A; terminal V = 9 V; P = 18 W$t$,
  explanation = $t$I = EMF/(R+r) = 9/4.5 = 2 A. Terminal V = EMF - Ir = 9 - (2 x 0.5) = 8 V. P_external = I2 x R = 4 x 4 = 16 W. (Or P = V x I = 8 x 2 = 16 W.)$t$
WHERE id = 2466
  AND option_a = $t$\(I = 2.25\,\text{A}\); terminal \(V = 7.875 V\); \(P = 17.7\,\text{W}\)$t$
  AND option_b = $t$\(I = 2\,\text{A}\); terminal \(V = 8 V\); \(P = 16\,\text{W}\)$t$
  AND option_c = $t$\(I = 1.8\,\text{A}\); terminal \(V = 7.2 V\); \(P = 12.96\,\text{W}\)$t$
  AND option_d = $t$\(I = 2\,\text{A}\); terminal \(V = 9 V\); \(P = 18\,\text{W}\)$t$
  AND explanation = $t$\(I = \frac{EMF}{R + r} = \frac{9}{4.5} = 2\,\text{A}\). Terminal \(V = EMF\)- Ir \(= 9 - (2 \times 0.5) = 8 V\). P_external \(= I^{2} \times R = 4 \times 4 = 16\,\text{W}\). (Or \(P = V \times I = 8 \times 2 = 16\,\text{W}\).)$t$;

UPDATE questions SET
  option_c = $t$The battery has internal resistance r. When current I flows a voltage of Ir is dropped across this internal resistance reducing the voltage available at the terminals. Terminal voltage = EMF - Ir. As current increases the voltage lost internally (Ir) increases so the terminal voltage falls. This explains why batteries seem weaker under heavy load — a torch bulb dims as the battery ages because increasing internal resistance causes greater voltage loss.$t$,
  explanation = $t$V_terminal = EMF - Ir. For a fresh battery r is small so V_terminal approximately equals EMF. As a battery ages internal resistance increases causing more voltage drop at the same current.$t$
WHERE id = 2467
  AND option_c = $t$The battery has internal resistance \(r\). When current I flows a voltage of Ir is dropped across this internal resistance reducing the voltage available at the terminals. Terminal voltage \(= EMF\)- Ir. As current increases the voltage lost internally (Ir) increases so the terminal voltage falls. This explains why batteries seem weaker under heavy load — a torch bulb dims as the battery ages because increasing internal resistance causes greater voltage loss.$t$
  AND explanation = $t$V_terminal \(= EMF\)- Ir. For a fresh battery \(r\) is small so V_terminal approximately equals EMF. As a battery ages internal resistance increases causing more voltage drop at the same current.$t$;

UPDATE questions SET
  option_a = $t$R = 960 ohms; cold resistance is the same because resistance does not depend on temperature$t$,
  option_b = $t$R = 960 ohms; cold resistance is much lower because the filament is at a lower temperature and the ions in the tungsten lattice vibrate less causing fewer electron-ion collisions and lower resistance$t$,
  option_c = $t$R = 4 ohms; cold resistance is the same$t$,
  option_d = $t$R = 960 ohms; cold resistance is higher because the filament contracts when cold increasing resistance$t$,
  explanation = $t$R = V2/P = 240^2/60 = 57600/60 = 960 ohms at operating temperature (~2700 K). At room temperature (~300 K) resistance is approximately 60-100 ohms — about 10-15x lower. This is why light bulbs most often blow when first switched on (the initial large current surge through low cold resistance).$t$
WHERE id = 2468
  AND option_a = $t$\(R = 960\,\text{ohms}\); cold resistance is the same because resistance does not depend on temperature$t$
  AND option_b = $t$\(R = 960\,\text{ohms}\); cold resistance is much lower because the filament is at a lower temperature and the ions in the tungsten lattice vibrate less causing fewer electron-ion collisions and lower resistance$t$
  AND option_c = $t$\(R = 4\,\text{ohms}\); cold resistance is the same$t$
  AND option_d = $t$\(R = 960\,\text{ohms}\); cold resistance is higher because the filament contracts when cold increasing resistance$t$
  AND explanation = $t$\(R = \frac{V^{2}}{P} = \frac{240^{2}}{60} = \frac{57600}{60} = 960\,\text{ohms}\) at operating temperature (~2700 K). At room temperature (~300 K) resistance is approximately 60–100 ohms — about 10–15× lower. This is why light bulbs most often blow when first switched on (the initial large current surge through low cold resistance).$t$;

UPDATE questions SET
  option_a = $t$A potential divider consists of two (or more) resistors in series across a supply voltage. The supply voltage is divided between the resistors in proportion to their resistances. V_out/V_in = R2/(R1 + R2). Here: V_out = 12 x 8/(4+8) = 12 x 8/12 = 8 V. Potential dividers are used to provide variable voltages in circuits and as the basis of sensor circuits using LDRs and thermistors.$t$,
  option_b = $t$Output voltage = 12 V because the full supply appears across each resistor$t$,
  option_c = $t$Output voltage = 4 V because the smaller resistor gets more voltage$t$,
  option_d = $t$Output voltage = 6 V because the two resistors always share the voltage equally$t$,
  explanation = $t$Potential divider: V_out = V_in x R2/(R1+R2). The larger resistor gets the larger share of the voltage. This circuit is used in sensor applications where R2 is a thermistor or LDR.$t$
WHERE id = 2469
  AND option_a = $t$A potential divider consists of two (or more) resistors in series across a supply voltage. The supply voltage is divided between the resistors in proportion to their resistances. V_out/V_in \(= \frac{R_{2}}{R_{1} + R_{2}}\). Here: V_\(out = 12 \times \frac{8}{4 + 8} = 12 \times \frac{8}{12} = 8\,\text{V}\). Potential dividers are used to provide variable voltages in circuits and as the basis of sensor circuits using LDRs and thermistors.$t$
  AND option_b = $t$Output voltage \(= 12\,\text{V}\) because the full supply appears across each resistor$t$
  AND option_c = $t$Output voltage \(= 4\,\text{V}\) because the smaller resistor gets more voltage$t$
  AND option_d = $t$Output voltage \(= 6\,\text{V}\) because the two resistors always share the voltage equally$t$
  AND explanation = $t$Potential divider: V_\(out = V\)_in \(x \frac{R_{2}}{R_{1} + R_{2}}\). The larger resistor gets the larger share of the voltage. This circuit is used in sensor applications where \(R_{2}\) is a thermistor or LDR.$t$;

UPDATE questions SET
  question_text = $t$A student investigates a thermistor and finds its resistance decreases from 10,000 ohms at 20 degrees C to 500 ohms at 80 degrees C. It is used in a potential divider with a 10,000 ohm fixed resistor and 5 V supply with the output taken across the fixed resistor. Calculate the output voltage at both temperatures.$t$,
  option_a = $t$V_out = 2.5 V at 20 degrees C and 2.5 V at 80 degrees C$t$,
  option_b = $t$V_out = 2.5 V at 20 degrees C and 4.76 V at 80 degrees C$t$,
  option_c = $t$V_out = 4.76 V at 20 degrees C and 0.5 V at 80 degrees C$t$,
  option_d = $t$V_out = 0.5 V at 20 degrees C and 4.76 V at 80 degrees C$t$,
  explanation = $t$At 20 degrees C (thermistor R = 10000 ohms): V_out = 5 x 10000/(10000+10000) = 5 x 0.5 = 2.5 V. At 80 degrees C (thermistor R = 500 ohms): V_out = 5 x 10000/(500+10000) = 5 x 10000/10500 = 4.76 V. As temperature rises thermistor resistance falls so more voltage appears across the fixed resistor.$t$
WHERE id = 2471
  AND question_text = $t$A student investigates a thermistor and finds its resistance decreases from 10 000 ohms at 20 degrees C to 500 ohms at 80 degrees C. It is used in a potential divider with a 10 000 ohm fixed resistor and 5 V supply with the output taken across the fixed resistor. Calculate the output voltage at both temperatures.$t$
  AND option_a = $t$V_\(out = 2.5\,\text{V}\) at 20 degrees C and 2.5 V at 80 degrees C$t$
  AND option_b = $t$V_\(out = 2.5\,\text{V}\) at 20 degrees C and 4.76 V at 80 degrees C$t$
  AND option_c = $t$V_\(out = 4.76\,\text{V}\) at 20 degrees C and 0.5 V at 80 degrees C$t$
  AND option_d = $t$V_\(out = 0.5\,\text{V}\) at 20 degrees C and 4.76 V at 80 degrees C$t$
  AND explanation = $t$At 20 degrees C (thermistor \(R = 10000\,\text{ohms}\)): V_\(out = 5 \times \frac{10000}{10000 + 10000} = 5 \times 0.5 = 2.5\,\text{V}\). At 80 degrees C (thermistor \(R = 500\,\text{ohms}\)): V_\(out = 5 \times \frac{10000}{500 + 10000} = 5 \times \frac{10000}{10500} = 4.76\,\text{V}\). As temperature rises thermistor resistance falls so more voltage appears across the fixed resistor.$t$;

UPDATE questions SET
  option_b = $t$Power loss in transmission cables = I2R. At 200 A: P_loss = 200^2 x 5 = 200,000 W = 200 kW. At 20 A: P_loss = 20^2 x 5 = 2,000 W = 2 kW. Reducing current by a factor of 10 reduces power loss by a factor of 100 (because P proportional to I2). High voltage transformers step up voltage before transmission (reducing current for the same power since P = IV) and step down again near consumers — dramatically reducing I2R losses in the cables.$t$,
  option_d = $t$Power loss = IR so reducing current by 10 reduces power loss by 10 not 100$t$,
  explanation = $t$P = I2R so power loss proportional to I2. The National Grid operates at 132,000 V to 400,000 V to minimise transmission losses. Step-up transformers at power stations and step-down transformers at substations make this possible.$t$
WHERE id = 2472
  AND option_b = $t$Power loss in transmission cables \(= I^{2}R\). At 200 A: P_loss \(= 200^{2} \times 5 = 200\,000 W = 200\,\text{kW}\). At 20 A: P_loss \(= 20^{2} \times 5 = 2\,000 W = 2\,\text{kW}\). Reducing current by a factor of 10 reduces power loss by a factor of 100 (because P proportional to \(I^{2}\)). High voltage transformers step up voltage before transmission (reducing current for the same power since \(P = IV\)) and step down again near consumers — dramatically reducing \(I^{2}R\) losses in the cables.$t$
  AND option_d = $t$Power loss \(= IR\) so reducing current by 10 reduces power loss by 10 not 100$t$
  AND explanation = $t$\(P = I^{2}R\) so power loss proportional to \(I^{2}\). The National Grid operates at 132 000 V to 400 000 V to minimise transmission losses. Step-up transformers at power stations and step-down transformers at substations make this possible.$t$;

UPDATE questions SET
  explanation = $t$Electrostatic spraying reduces paint waste by approximately 30-60% compared to conventional spraying and gives more uniform coverage. Used in car manufacturing and agricultural spraying.$t$
WHERE id = 2481
  AND explanation = $t$Electrostatic spraying reduces paint waste by approximately 30–60% compared to conventional spraying and gives more uniform coverage. Used in car manufacturing and agricultural spraying.$t$;

UPDATE questions SET
  option_b = $t$Electric field strength (E) at a point is defined as the force per unit positive charge at that point: E = F/Q. Units: newtons per coulomb (N/C) or equivalently volts per metre (V/m). The field strength indicates how strongly a charge would experience a force at that location. In a uniform field between parallel plates: E = V/d where V is the potential difference and d is the separation.$t$,
  explanation = $t$E = F/Q in N/C. Between parallel plates E = V/d. A stronger field means a larger force on a given charge.$t$
WHERE id = 2485
  AND option_b = $t$Electric field strength (E) at a point is defined as the force per unit positive charge at that point: \(E = \frac{F}{Q}\). Units: newtons per coulomb \((\frac{N}{C})\) or equivalently volts per metre \((\frac{V}{m})\). The field strength indicates how strongly a charge would experience a force at that location. In a uniform field between parallel plates: \(E = \frac{V}{d}\) where V is the potential difference and \(d\) is the separation.$t$
  AND explanation = $t$\(E = \frac{F}{Q}\) in \(\frac{N}{C}\). Between parallel plates \(E = \frac{V}{d}\). A stronger field means a larger force on a given charge.$t$;

UPDATE questions SET
  question_text = $t$Two parallel plates are separated by 5 mm with a potential difference of 500 V between them. Calculate the electric field strength and the force on a charge of 2 x 10^-6 C placed between the plates.$t$,
  option_a = $t$E = 2500 V/m; F = 0.005 N$t$,
  option_b = $t$E = 100,000 V/m; F = 0.2 N$t$,
  option_c = $t$E = 100,000 V/m; F = 2 N$t$,
  option_d = $t$E = 10,000 V/m; F = 0.02 N$t$,
  explanation = $t$E = V/d = 500/(5 x 10^-3) = 100,000 V/m. F = EQ = 100,000 x 2 x 10^-6 = 0.2 N.$t$
WHERE id = 2486
  AND question_text = $t$Two parallel plates are separated by 5 mm with a potential difference of 500 V between them. Calculate the electric field strength and the force on a charge of \(2 \times 10^{-6}\,\text{C}\) placed between the plates.$t$
  AND option_a = $t$\(E = 2500 \frac{\,\text{V}}{m}\); \(F = 0.005\,\text{N}\)$t$
  AND option_b = $t$\(E = 100\,000 \frac{\,\text{V}}{m}\); \(F = 0.2\,\text{N}\)$t$
  AND option_c = $t$\(E = 100\,000 \frac{\,\text{V}}{m}\); \(F = 2\,\text{N}\)$t$
  AND option_d = $t$\(E = 10\,000 \frac{\,\text{V}}{m}\); \(F = 0.02\,\text{N}\)$t$
  AND explanation = $t$\(E = \frac{V}{d} = \frac{500}{5 \times 10^{-3}} = 100\,000 \frac{\,\text{V}}{m}\). \(F = EQ = 100\,000 \times 2 \times 10^{-6} = 0.2\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$An inkjet printer uses charged droplets to form an image. A droplet of mass 1.5 x 10^-10 kg carries charge 8 x 10^-13 C and enters a uniform electric field of 200,000 V/m perpendicular to its initial velocity. Calculate the deflecting force and the acceleration of the droplet. (g = 10 N/kg)$t$,
  option_a = $t$F = 1.6 x 10^-7 N; a = 2.5 x 10^6 m/s2$t$,
  option_b = $t$F = 4 x 10^-8 N; a = 2.67 x 10^2 m/s2$t$,
  option_c = $t$F = 1.6 x 10^-7 N; a = 1.07 x 10^3 m/s2$t$,
  option_d = $t$F = 2.5 x 10^-6 N; a = 1.67 x 10^4 m/s2$t$,
  explanation = $t$F = EQ = 200,000 x 8 x 10^-13 = 1.6 x 10^-7 N. a = F/m = 1.6 x 10^-7 / 1.5 x 10^-10 = 1067 m/s2 approximately 1.07 x 10^3 m/s2.$t$
WHERE id = 2488
  AND question_text = $t$An inkjet printer uses charged droplets to form an image. A droplet of mass \(1.5 \times 10^{-10}\,\text{kg}\) carries charge \(8 \times 10^{-13}\,\text{C}\) and enters a uniform electric field of \(200\,000 \frac{\,\text{V}}{m}\) perpendicular to its initial velocity. Calculate the deflecting force and the acceleration of the droplet. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(F = 1.6 \times 10^{-7}\,\text{N}\); \(a = 2.5 \times 10^{6}\,\text{m/s}^{2}\)$t$
  AND option_b = $t$\(F = 4 \times 10^{-8}\,\text{N}\); \(a = 2.67 \times 10^{2}\,\text{m/s}^{2}\)$t$
  AND option_c = $t$\(F = 1.6 \times 10^{-7}\,\text{N}\); \(a = 1.07 \times 10^{3}\,\text{m/s}^{2}\)$t$
  AND option_d = $t$\(F = 2.5 \times 10^{-6}\,\text{N}\); \(a = 1.67 \times 10^{4}\,\text{m/s}^{2}\)$t$
  AND explanation = $t$\(F = EQ = 200\,000 \times 8 \times 10^{-13} = 1.6 \times 10^{-7}\,\text{N}\). \(a = \frac{F}{m} = 1.6 \times \frac{10^{-7}}{1.5} \times 10^{-10} = 1067\,\text{m/s}^{2}\) approximately \(1.07 \times 10^{3}\,\text{m/s}^{2}\).$t$;

UPDATE questions SET
  explanation = $t$Electrostatic precipitators (ESPs) remove particulate matter (PM2.5 and PM10) that causes respiratory disease. A 300 MW coal power station without an ESP would emit approximately 30,000 tonnes of fly ash per year.$t$
WHERE id = 2491
  AND explanation = $t$Electrostatic precipitators (ESPs) remove particulate matter (PM2.5 and PM10) that causes respiratory disease. A 300 MW coal power station without an ESP would emit approximately 30 000 tonnes of fly ash per year.$t$;

UPDATE questions SET
  option_b = $t$Potential difference between two points is defined as the work done per unit charge in moving a positive charge between those points: V = W/Q. Therefore W = QV. Moving a charge of 5 C through a potential difference of 12 V requires work W = 5 x 12 = 60 J of work. This work is done against or by the electric force between the charges. In a circuit this is the energy transferred by each coulomb of charge as it moves through a component.$t$,
  explanation = $t$W = QV is fundamental. In a circuit: energy transferred by component = charge x voltage. This is where P = IV comes from: P = W/t = QV/t = IV (since I = Q/t).$t$
WHERE id = 2492
  AND option_b = $t$Potential difference between two points is defined as the work done per unit charge in moving a positive charge between those points: \(V = \frac{W}{Q}\). Therefore \(W = QV\). Moving a charge of 5 C through a potential difference of 12 V requires work \(W = 5 \times 12 = 60\,\text{J}\) of work. This work is done against or by the electric force between the charges. In a circuit this is the energy transferred by each coulomb of charge as it moves through a component.$t$
  AND explanation = $t$\(W = QV\) is fundamental. In a circuit: energy transferred by component = charge × voltage. This is where \(P = IV\) comes from: \(P = \frac{W}{t} = \frac{QV}{t} = IV\) (since \(I = \frac{Q}{t}\)).$t$;

UPDATE questions SET
  explanation = $t$Uniform electric field: constant force (F = EQ). This is directly analogous to projectile motion in a gravitational field. The charge follows a parabola just as a ball thrown horizontally follows a parabola under gravity.$t$
WHERE id = 2493
  AND explanation = $t$Uniform electric field: constant force \((F = EQ)\). This is directly analogous to projectile motion in a gravitational field. The charge follows a parabola just as a ball thrown horizontally follows a parabola under gravity.$t$;

UPDATE questions SET
  question_text = $t$A Van de Graaff generator builds up charge on a metal dome until the electric field strength at the dome surface reaches 3 x 10^6 V/m (the breakdown strength of air causing sparking). If the dome has a radius of 0.15 m calculate the potential of the dome when sparking begins. (Assume E = V/r for a sphere)$t$,
  option_a = $t$V = 45,000 V$t$,
  option_b = $t$V = 450,000 V$t$,
  option_c = $t$V = 2 x 10^7 V$t$,
  option_d = $t$V = 4500 V$t$,
  explanation = $t$For a spherical conductor: E = V/r at the surface. V = E x r = 3 x 10^6 x 0.15 = 450,000 V = 450 kV.$t$
WHERE id = 2496
  AND question_text = $t$A Van de Graaff generator builds up charge on a metal dome until the electric field strength at the dome surface reaches \(3 \times 10^{6} \frac{\,\text{V}}{m}\) (the breakdown strength of air causing sparking). If the dome has a radius of 0.15 m calculate the potential of the dome when sparking begins. (Assume \(E = \frac{V}{r}\) for a sphere)$t$
  AND option_a = $t$\(V = 45\,000 V\)$t$
  AND option_b = $t$\(V = 450\,000 V\)$t$
  AND option_c = $t$\(V = 2 \times 10^{7} V\)$t$
  AND option_d = $t$\(V = 4500 V\)$t$
  AND explanation = $t$For a spherical conductor: \(E = \frac{V}{r}\) at the surface. \(V = E \times r = 3 \times 10^{6} \times 0.15 = 450\,000 V = 450\,\text{kV}\).$t$;

UPDATE questions SET
  option_c = $t$On a conductor at a given potential the surface charge density is higher at points of higher curvature (sharper curves). Since electric field strength is proportional to surface charge density the field is much stronger at sharp points (E = V/r — smaller r gives larger E). Beneficial consequence: lightning conductors use pointed tips to create strong local fields that cause corona discharge (ion leakage) continuously reducing charge build-up and providing a preferred path for lightning. Harmful consequence: high-voltage power lines can cause corona discharge at surface irregularities and sharp edges wasting energy as electrical noise heat and ozone production — which is why high-voltage conductors are made smooth and round.$t$
WHERE id = 2497
  AND option_c = $t$On a conductor at a given potential the surface charge density is higher at points of higher curvature (sharper curves). Since electric field strength is proportional to surface charge density the field is much stronger at sharp points (\(E = \frac{V}{r}\) — smaller \(r\) gives larger E). Beneficial consequence: lightning conductors use pointed tips to create strong local fields that cause corona discharge (ion leakage) continuously reducing charge build-up and providing a preferred path for lightning. Harmful consequence: high-voltage power lines can cause corona discharge at surface irregularities and sharp edges wasting energy as electrical noise heat and ozone production — which is why high-voltage conductors are made smooth and round.$t$;

UPDATE questions SET
  question_text = $t$In an inkjet printer a droplet of mass 2 x 10^-10 kg is given charge Q and enters a uniform electric field E = 150,000 V/m at right angles to field lines with horizontal velocity 20 m/s. The plates are 30 mm long. The required deflection is 2 mm. Calculate the required charge on the droplet. (g = 10 N/kg ignore gravity)$t$,
  option_a = $t$Q = 4.4 x 10^-12 C$t$,
  option_b = $t$Q = 1.78 x 10^-13 C$t$,
  option_c = $t$Q = 8.9 x 10^-13 C$t$,
  option_d = $t$Q = 3.0 x 10^-12 C$t$,
  explanation = $t$Time in field: t = L/v = 0.030/20 = 0.0015 s. Acceleration needed: y = 1/2 at^2. 0.002 = 1/2 x a x (0.0015)^2 = 1/2 x a x 2.25 x 10^-6. a = 0.004/(2.25 x 10^-6) = 1778 m/s^2. Force: F = ma = 2 x 10^-10 x 1778 = 3.556 x 10^-7 N. Charge: Q = F/E = 3.556 x 10^-7 / 150,000 = 2.37 x 10^-12 C. Closest to option A in order of magnitude.$t$
WHERE id = 2498
  AND question_text = $t$In an inkjet printer a droplet of mass \(2 \times 10^{-10}\,\text{kg}\) is given charge Q and enters a uniform electric field \(E = 150\,000 \frac{\,\text{V}}{m}\) at right angles to field lines with horizontal velocity \(20\,\text{m/s}\). The plates are 30 mm long. The required deflection is 2 mm. Calculate the required charge on the droplet. (\(g = 10\,\text{N/kg}\) ignore gravity)$t$
  AND option_a = $t$\(Q = 4.4 \times 10^{-12}\,\text{C}\)$t$
  AND option_b = $t$\(Q = 1.78 \times 10^{-13}\,\text{C}\)$t$
  AND option_c = $t$\(Q = 8.9 \times 10^{-13}\,\text{C}\)$t$
  AND option_d = $t$\(Q = 3.0 \times 10^{-12}\,\text{C}\)$t$
  AND explanation = $t$Time in field: \(t = \frac{L}{v} = \frac{0.030}{20} = 0.0015\,\text{s}\). Acceleration needed: \(y = \frac{1}{2}\) \(at^{2}\). \(0.002 = \frac{1}{2} \times a \times (0.0015)^{2} = \frac{1}{2} \times a \times 2.25 \times 10 - 6\). \(a = \frac{0.004}{2.25 \times 10^{-6}} = 1778\,\text{m/s}^{2}\). Force: \(F = ma = 2 \times 10^{-10} \times 1778 = 3.556 \times 10^{-7}\,\text{N}\). Charge: \(Q = \frac{F}{E} = 3.556 \times \frac{10^{-7}}{150\,000} = 2.37 \times 10^{-12}\,\text{C}\). Closest to option A in order of magnitude.$t$;

UPDATE questions SET
  option_b = $t$The collection process involves three stages: (1) Ionisation zone — high-voltage corona discharge wires (typically at -50 kV) strip electrons from gas molecules creating positive ions and free electrons. Particles passing through acquire negative charges from electron attachment. (2) Collection zone — strongly negatively charged particles migrate through the gas under the influence of the electric field toward positively charged collection plates. Migration velocity depends on particle charge particle size gas viscosity and field strength. (3) Rapping — plates are periodically vibrated to release accumulated ash. Factors reducing efficiency: particles too small to acquire sufficient charge (sub-micron particles are poorly charged); high gas velocity (insufficient residence time for particles to reach plates); resistive dust layer building up on plates (reduces field strength); and mechanical bypassing around damaged or misaligned plates.$t$,
  explanation = $t$Modern ESPs can achieve collection efficiencies of 99.5-99.9% for particles above 1 micrometre. Sub-micron particles (PM2.5) are increasingly regulated and require additional baghouse filters or wet scrubbers to supplement ESP performance.$t$
WHERE id = 2499
  AND option_b = $t$The collection process involves three stages: (1) Ionisation zone — high-voltage corona discharge wires (typically at \(- 50\,\text{kV}\)) strip electrons from gas molecules creating positive ions and free electrons. Particles passing through acquire negative charges from electron attachment. (2) Collection zone — strongly negatively charged particles migrate through the gas under the influence of the electric field toward positively charged collection plates. Migration velocity depends on particle charge particle size gas viscosity and field strength. (3) Rapping — plates are periodically vibrated to release accumulated ash. Factors reducing efficiency: particles too small to acquire sufficient charge (sub-micron particles are poorly charged); high gas velocity (insufficient residence time for particles to reach plates); resistive dust layer building up on plates (reduces field strength); and mechanical bypassing around damaged or misaligned plates.$t$
  AND explanation = $t$Modern ESPs can achieve collection efficiencies of 99.5–99.9% for particles above 1 micrometre. Sub-micron particles (PM2.5) are increasingly regulated and require additional baghouse filters or wet scrubbers to supplement ESP performance.$t$;

UPDATE questions SET
  option_d = $t$Between parallel plates the electric field is uniform — the field lines are parallel and equally spaced and the field strength E = V/d is constant throughout the region. A charge placed anywhere between the plates experiences the same magnitude force (F = EQ) in the same direction. Around a point charge the field is radial and non-uniform — field strength decreases with distance (E proportional to 1/r^2). A charge placed at different distances from a point charge experiences very different forces. The uniform field of parallel plates is exploited in cathode ray tubes and mass spectrometers where controlled constant deflection is needed.$t$,
  explanation = $t$Uniform field (parallel plates): F = constant regardless of position. Non-uniform field (point charge): F decreases with r^2. This distinction is crucial for designing devices requiring controlled deflection of charged particles.$t$
WHERE id = 2500
  AND option_d = $t$Between parallel plates the electric field is uniform — the field lines are parallel and equally spaced and the field strength \(E = \frac{V}{d}\) is constant throughout the region. A charge placed anywhere between the plates experiences the same magnitude force \((F = EQ)\) in the same direction. Around a point charge the field is radial and non-uniform — field strength decreases with distance (E proportional to \(\frac{1}{r^{2}}\)). A charge placed at different distances from a point charge experiences very different forces. The uniform field of parallel plates is exploited in cathode ray tubes and mass spectrometers where controlled constant deflection is needed.$t$
  AND explanation = $t$Uniform field (parallel plates): F = constant regardless of position. Non-uniform field (point charge): F decreases with \(r^{2}\). This distinction is crucial for designing devices requiring controlled deflection of charged particles.$t$;

UPDATE questions SET
  option_a = $t$In a mass spectrometer: (1) Ionisation — sample atoms are ionised (lose one or more electrons). (2) Acceleration — ions are accelerated through a potential difference V gaining kinetic energy QV = 1/2 mv^2. Heavier ions gain the same kinetic energy but lower speed. (3) Deflection — ions enter a magnetic field at right angles. The magnetic force provides centripetal force: BQv = mv^2/r so r = mv/(BQ). Heavier ions (larger m) travel in larger radius arcs than lighter ions of the same charge. Different masses are separated spatially and detected. The electric field does work on the ions converting electrical potential energy to kinetic energy before they enter the magnetic analyser.$t$,
  explanation = $t$Mass spectrometry: QV = 1/2 mv^2 so v = sqrt(2QV/m). In the magnetic field r = mv/(BQ) = sqrt(2mV/(QB^2)). Therefore r^2 proportional to m — the radius of circular motion is proportional to the square root of mass.$t$
WHERE id = 2502
  AND option_a = $t$In a mass spectrometer: (1) Ionisation — sample atoms are ionised (lose one or more electrons). (2) Acceleration — ions are accelerated through a potential difference V gaining kinetic energy \(QV = \frac{1}{2} mv^{2}\). Heavier ions gain the same kinetic energy but lower speed. (3) Deflection — ions enter a magnetic field at right angles. The magnetic force provides centripetal force: BQv \(= \frac{mv^{2}}{r}\) so \(r = \frac{mv}{BQ}\). Heavier ions (larger \(m\)) travel in larger radius arcs than lighter ions of the same charge. Different masses are separated spatially and detected. The electric field does work on the ions converting electrical potential energy to kinetic energy before they enter the magnetic analyser.$t$
  AND explanation = $t$Mass spectrometry: \(QV = \frac{1}{2} mv^{2}\) so \(v = \sqrt{\frac{2QV}{m}}\). In the magnetic field \(r = \frac{mv}{BQ} = \sqrt{}\)(2mV/\((QB^{2})\)). Therefore \(r^{2}\) proportional to \(m\) — the radius of circular motion is proportional to the square root of mass.$t$;

UPDATE questions SET
  option_d = $t$During a thunderstorm strong updrafts carry ice crystals and water droplets upward. Collisions between these particles cause charge separation: smaller ice crystals carried upward become positively charged while larger graupel (soft hail) falling downward becomes negatively charged. This creates a large negative charge at the base of the cloud and positive charges at the top. The negative charge at the cloud base induces a positive charge on the Earths surface below. When the electric field between cloud and ground exceeds approximately 3 x 10^6 V/m (breakdown of air) a stepped leader of ionised air descends from the cloud. When it connects with a streamer rising from the ground a conducting channel is complete and a massive current discharge (the lightning bolt) flows. The rapid heating of air causes the explosive expansion heard as thunder.$t$,
  explanation = $t$A typical lightning bolt carries approximately 1-5 GJ of energy in approximately 0.2 seconds. The peak current is approximately 30,000 A. The thunder delay (approximately 3 seconds per kilometre) allows distance estimation.$t$
WHERE id = 2503
  AND option_d = $t$During a thunderstorm strong updrafts carry ice crystals and water droplets upward. Collisions between these particles cause charge separation: smaller ice crystals carried upward become positively charged while larger graupel (soft hail) falling downward becomes negatively charged. This creates a large negative charge at the base of the cloud and positive charges at the top. The negative charge at the cloud base induces a positive charge on the Earths surface below. When the electric field between cloud and ground exceeds approximately \(3 \times 10^{6} \frac{\,\text{V}}{m}\) (breakdown of air) a stepped leader of ionised air descends from the cloud. When it connects with a streamer rising from the ground a conducting channel is complete and a massive current discharge (the lightning bolt) flows. The rapid heating of air causes the explosive expansion heard as thunder.$t$
  AND explanation = $t$A typical lightning bolt carries approximately 1–5 GJ of energy in approximately 0.2 seconds. The peak current is approximately 30 000 A. The thunder delay (approximately 3 seconds per kilometre) allows distance estimation.$t$;

UPDATE questions SET
  question_text = $t$A conducting sphere of radius 0.1 m is charged to a potential of 90,000 V. Calculate the electric field strength at the surface and at a distance of 0.3 m from the centre. Explain why the field inside the conducting sphere is zero.$t$,
  option_a = $t$E at surface = 900,000 V/m; E at 0.3 m = 300,000 V/m; field inside is zero because no charge can enter the sphere$t$,
  option_b = $t$E at surface = 900,000 V/m; E at 0.3 m = 100,000 V/m; field inside is zero because charge distributes on the surface only$t$,
  option_c = $t$E at surface = 9,000 V/m; E at 0.3 m = 1,000 V/m; field inside is zero because the potential is zero inside$t$,
  option_d = $t$E at surface = 90,000 V/m; E at 0.3 m = 30,000 V/m; field inside is zero by definition$t$,
  explanation = $t$For a spherical conductor: E at surface = V/r = 90,000/0.1 = 900,000 V/m. At 0.3 m from centre (a spherical conductor behaves like a point charge outside): V at 0.3 m = V_surface x r_surface/r = 90,000 x 0.1/0.3 = 30,000 V. E at 0.3 m = V/r = 30,000/0.3 = 100,000 V/m. Inside: all free electrons redistributed to surface leaving zero net field inside — any field inside would cause electron movement until equilibrium.$t$
WHERE id = 2504
  AND question_text = $t$A conducting sphere of radius 0.1 m is charged to a potential of 90 000 V. Calculate the electric field strength at the surface and at a distance of 0.3 m from the centre. Explain why the field inside the conducting sphere is zero.$t$
  AND option_a = $t$E at surface \(= 900\,000 \frac{\,\text{V}}{m}\); E at \(0.3 m = 300\,000 \frac{\,\text{V}}{m}\); field inside is zero because no charge can enter the sphere$t$
  AND option_b = $t$E at surface \(= 900\,000 \frac{\,\text{V}}{m}\); E at \(0.3 m = 100\,000 \frac{\,\text{V}}{m}\); field inside is zero because charge distributes on the surface only$t$
  AND option_c = $t$E at surface \(= 9\,000 \frac{\,\text{V}}{m}\); E at \(0.3 m = 1\,000 \frac{\,\text{V}}{m}\); field inside is zero because the potential is zero inside$t$
  AND option_d = $t$E at surface \(= 90\,000 \frac{\,\text{V}}{m}\); E at \(0.3 m = 30\,000 \frac{\,\text{V}}{m}\); field inside is zero by definition$t$
  AND explanation = $t$For a spherical conductor: E at surface \(= \frac{V}{r} = \frac{90\,000}{0.1} = 900\,000 \frac{\,\text{V}}{m}\). At 0.3 \(m\) from centre (a spherical conductor behaves like a point charge outside): V at \(0.3 m = V\)_surface x \(r\)_surface/\(r = 90\,000 \times \frac{0.1}{0.3} = 30\,000\,\text{V}\). E at \(0.3 m = \frac{V}{r} = \frac{30\,000}{0.3} = 100\,000 \frac{\,\text{V}}{m}\). Inside: all free electrons redistributed to surface leaving zero net field inside — any field inside would cause electron movement until equilibrium.$t$;

UPDATE questions SET
  explanation = $t$Right-hand grip rule for a straight wire: thumb points in direction of conventional current fingers curl in direction of magnetic field. Field strength decreases with distance from the wire (B proportional to 1/r).$t$
WHERE id = 2506
  AND explanation = $t$Right-hand grip rule for a straight wire: thumb points in direction of conventional current fingers curl in direction of magnetic field. Field strength decreases with distance from the wire (B proportional to \(\frac{1}{r}\)).$t$;

UPDATE questions SET
  explanation = $t$The motor effect is the basis of all electric motors. F = BIL where B is flux density I is current and L is length of conductor in the field.$t$
WHERE id = 2507
  AND explanation = $t$The motor effect is the basis of all electric motors. \(F = BIL\) where B is flux density I is current and L is length of conductor in the field.$t$;

UPDATE questions SET
  explanation = $t$F = BIL = 0.4 x 5 x 0.3 = 0.6 N.$t$
WHERE id = 2509
  AND explanation = $t$\(F = BIL = 0.4 \times 5 \times 0.3 = 0.6\,\text{N}\).$t$;

UPDATE questions SET
  option_b = $t$By increasing the current in the wire increasing the magnetic flux density of the field or increasing the length of conductor within the field. F = BIL — force is proportional to each of these three factors.$t$,
  explanation = $t$F = BIL. To double force: double B (stronger magnets) or double I (more current) or double L (longer conductor in the field). Motor designers use all three strategies.$t$
WHERE id = 2511
  AND option_b = $t$By increasing the current in the wire increasing the magnetic flux density of the field or increasing the length of conductor within the field. \(F = BIL\) — force is proportional to each of these three factors.$t$
  AND explanation = $t$\(F = BIL\). To double force: double B (stronger magnets) or double I (more current) or double L (longer conductor in the field). Motor designers use all three strategies.$t$;

UPDATE questions SET
  option_a = $t$Magnetic flux density (B) is a measure of the strength of a magnetic field — specifically the force per unit current per unit length on a conductor at right angles to the field: B = F/(IL). Unit: tesla (T) where 1 T = 1 N/(A m). A flux density of 1 T means a 1 m wire carrying 1 A experiences a force of 1 N.$t$,
  explanation = $t$B is measured in tesla (T). The Earths magnetic field is approximately 50 x 10^-6 T (50 microtelsa). MRI scanner magnets have B of 1.5-7 T. The force equation F = BIL uses this value.$t$
WHERE id = 2513
  AND option_a = $t$Magnetic flux density (B) is a measure of the strength of a magnetic field — specifically the force per unit current per unit length on a conductor at right angles to the field: \(B = \frac{F}{IL}\). Unit: tesla (T) where \(1 T = 1 \frac{\,\text{N}}{A m}\). A flux density of 1 T means a 1 m wire carrying 1 A experiences a force of 1 N.$t$
  AND explanation = $t$B is measured in tesla (T). The Earths magnetic field is approximately \(50 \times 10^{-6}\,\text{T}\) (50 microtelsa). MRI scanner magnets have B of 1.5–7 T. The force equation \(F = BIL\) uses this value.$t$;

UPDATE questions SET
  explanation = $t$B = F/(IL) = 0.15/(3 x 0.25) = 0.15/0.75 = 0.2 T.$t$
WHERE id = 2514
  AND explanation = $t$\(B = \frac{F}{IL} = \frac{0.15}{3 \times 0.25} = \frac{0.15}{0.75} = 0.2\,\text{T}\).$t$;

UPDATE questions SET
  question_text = $t$A rectangular coil with 50 turns carries a current of 2 A in a uniform magnetic field of 0.3 T. The coil dimensions are 0.04 m x 0.06 m and the plane of the coil is parallel to the field. Calculate the torque (turning force) on the coil.$t$,
  option_a = $t$3.6 N m$t$,
  option_b = $t$0.0036 N m$t$,
  option_c = $t$0.072 N m$t$,
  option_d = $t$0.36 N m$t$,
  explanation = $t$Force on each side (length 0.06 m in field): F = NBIL = 50 x 0.3 x 2 x 0.06 = 1.8 N. Torque = F x perpendicular distance = F x width = 1.8 x 0.04 = 0.072 N m.$t$
WHERE id = 2516
  AND question_text = $t$A rectangular coil with 50 turns carries a current of 2 A in a uniform magnetic field of 0.3 T. The coil dimensions are \(0.04\,\text{m} \times 0.06\,\text{m}\) and the plane of the coil is parallel to the field. Calculate the torque (turning force) on the coil.$t$
  AND option_a = $t$3.6 N \(m\)$t$
  AND option_b = $t$0.0036 N \(m\)$t$
  AND option_c = $t$0.072 N \(m\)$t$
  AND option_d = $t$0.36 N \(m\)$t$
  AND explanation = $t$Force on each side (length 0.06 m in field): \(F = NBIL = 50 \times 0.3 \times 2 \times 0.06 = 1.8\,\text{N}\). Torque \(= F x\) perpendicular distance \(= F x\) width \(= 1.8 \times 0.04 = 0.072\,\text{N}\ m\).$t$;

UPDATE questions SET
  option_c = $t$A loudspeaker consists of a coil of wire attached to a paper cone suspended in a strong permanent magnetic field. When an alternating current (the audio signal) flows through the coil it experiences a force due to the motor effect (F = BIL). As the current alternates direction the force on the coil alternates direction causing the cone to vibrate back and forth. These vibrations create pressure variations in the surrounding air which travel as sound waves to the listener.$t$
WHERE id = 2517
  AND option_c = $t$A loudspeaker consists of a coil of wire attached to a paper cone suspended in a strong permanent magnetic field. When an alternating current (the audio signal) flows through the coil it experiences a force due to the motor effect \((F = BIL)\). As the current alternates direction the force on the coil alternates direction causing the cone to vibrate back and forth. These vibrations create pressure variations in the surrounding air which travel as sound waves to the listener.$t$;

UPDATE questions SET
  option_a = $t$Secondary voltage = 960 V; this is a step-up transformer$t$,
  option_b = $t$Secondary voltage = 60 V; this is a step-down transformer$t$,
  option_c = $t$Secondary voltage = 60 V; this is a step-up transformer$t$,
  option_d = $t$Secondary voltage = 240 V; this is neither because turns are different$t$,
  explanation = $t$Vs/Vp = Ns/Np. Vs = 240 x (100/400) = 60 V. Since output voltage (60 V) is less than input voltage (240 V) this is a step-down transformer.$t$
WHERE id = 2519
  AND option_a = $t$Secondary voltage \(= 960\,\text{V}\); this is a step-up transformer$t$
  AND option_b = $t$Secondary voltage \(= 60\,\text{V}\); this is a step-down transformer$t$
  AND option_c = $t$Secondary voltage \(= 60\,\text{V}\); this is a step-up transformer$t$
  AND option_d = $t$Secondary voltage \(= 240\,\text{V}\); this is neither because turns are different$t$
  AND explanation = $t$Vs/Vp = Ns/Np. Vs \(= 240 \times (\frac{100}{400}) = 60\,\text{V}\). Since output voltage (60 V) is less than input voltage (240 V) this is a step-down transformer.$t$;

UPDATE questions SET
  explanation = $t$Faradays law: induced EMF = -N x d(phi)/dt. DC: d(phi)/dt = 0 so no EMF induced. AC: flux changes continuously so EMF is continuously induced. This is why the National Grid uses AC.$t$
WHERE id = 2520
  AND explanation = $t$Faradays law: induced \(EMF = - N \times d\)(phi)/dt. DC: \(d\)(phi)/\(dt = 0\) so no EMF induced. AC: flux changes continuously so EMF is continuously induced. This is why the National Grid uses AC.$t$;

UPDATE questions SET
  question_text = $t$An ideal transformer has primary voltage 230 V primary current 2 A secondary voltage 11,500 V. Calculate the secondary current and the turns ratio.$t$,
  option_a = $t$Secondary current = 100 A; turns ratio Np:Ns = 1:50$t$,
  option_b = $t$Secondary current = 0.04 A; turns ratio Np:Ns = 50:1$t$,
  option_c = $t$Secondary current = 46 A; turns ratio Np:Ns = 50:1$t$,
  option_d = $t$Secondary current = 0.04 A; turns ratio Np:Ns = 1:50$t$,
  explanation = $t$For ideal transformer: P_primary = P_secondary. Is = (Vp x Ip)/Vs = (230 x 2)/11,500 = 460/11,500 = 0.04 A. Turns ratio: Ns/Np = Vs/Vp = 11,500/230 = 50. So Np:Ns = 1:50 (step-up transformer).$t$
WHERE id = 2521
  AND question_text = $t$An ideal transformer has primary voltage 230 V primary current 2 A secondary voltage 11 500 V. Calculate the secondary current and the turns ratio.$t$
  AND option_a = $t$Secondary current \(= 100\,\text{A}\); turns ratio Np:Ns \(= 1 : 50\)$t$
  AND option_b = $t$Secondary current \(= 0.04\,\text{A}\); turns ratio Np:Ns \(= 50 : 1\)$t$
  AND option_c = $t$Secondary current \(= 46\,\text{A}\); turns ratio Np:Ns \(= 50 : 1\)$t$
  AND option_d = $t$Secondary current \(= 0.04\,\text{A}\); turns ratio Np:Ns \(= 1 : 50\)$t$
  AND explanation = $t$For ideal transformer: P_primary \(= P\)_secondary. Is \(=\) (Vp × Ip)/Vs \(= \frac{230 \times 2}{11\,500} = \frac{460}{11\,500} = 0.04\,\text{A}\). Turns ratio: Ns/Np = Vs/Vp \(= \frac{11\,500}{230} = 50\). So Np:Ns \(= 1 : 50\) (step-up transformer).$t$;

UPDATE questions SET
  question_text = $t$Explain the purpose of using high-voltage transmission in the National Grid and calculate the power saved when voltage is stepped up from 25,000 V to 400,000 V for transmission. The cable resistance is 10 ohms and the power transmitted is 500 MW.$t$,
  option_a = $t$At 25,000 V: I = P/V = 500 x 10^6/25,000 = 20,000 A. Power loss = I2R = (20,000)^2 x 10 = 4 x 10^9 W = 4,000 MW (exceeds the transmitted power — impossible). At 400,000 V: I = 500 x 10^6/400,000 = 1,250 A. Power loss = (1,250)^2 x 10 = 15,625,000 W = 15.6 MW. Power saving = virtually all of the power that would otherwise be lost. Stepping up voltage by a factor of 16 reduces current by 16 and power loss by 16^2 = 256 times.$t$,
  option_c = $t$High voltage is used because transformers only work at voltages above 100,000 V$t$,
  explanation = $t$P_loss = I^2R proportional to 1/V^2 for constant transmitted power. Doubling voltage quarters power loss. The National Grid uses 400,000 V for long-distance transmission with losses of approximately 2% of transmitted power.$t$
WHERE id = 2522
  AND question_text = $t$Explain the purpose of using high-voltage transmission in the National Grid and calculate the power saved when voltage is stepped up from 25 000 V to 400 000 V for transmission. The cable resistance is 10 ohms and the power transmitted is 500 MW.$t$
  AND option_a = $t$At 25 000 V: \(I = \frac{P}{V} = 500 \times \frac{10^{6}}{25\,000} = 20\,000\,\text{A}\). Power loss \(= I^{2}R = (20\,000)^{2} \times 10 = 4 \times 10^{9} W = 4\,000\,\text{MW}\) (exceeds the transmitted power — impossible). At 400 000 V: \(I = 500 \times \frac{10^{6}}{400\,000} = 1\,250\,\text{A}\). Power loss \(= (1\,250)^{2} \times 10 = 15\,625\,000 W = 15.6\,\text{MW}\). Power saving = virtually all of the power that would otherwise be lost. Stepping up voltage by a factor of 16 reduces current by 16 and power loss by \(16^{2} = 256\) times.$t$
  AND option_c = $t$High voltage is used because transformers only work at voltages above 100 000 V$t$
  AND explanation = $t$P_loss \(= I^{2}R\) proportional to \(\frac{1}{V^{2}}\) for constant transmitted power. Doubling voltage quarters power loss. The National Grid uses 400 000 V for long-distance transmission with losses of approximately 2% of transmitted power.$t$;

UPDATE questions SET
  option_a = $t$Three changes: (1) Increase number of turns — more turns means more magnetic field contribution from each turn of wire increasing the total flux density of the electromagnet. (2) Increase the current — by using a higher voltage battery or reducing circuit resistance. Greater current in each turn produces a stronger magnetic field (B proportional to NI/L). (3) Use a larger iron core or a different core material with higher magnetic permeability — soft iron concentrates magnetic flux more effectively than many other materials increasing the field strength in and around the core.$t$
WHERE id = 2523
  AND option_a = $t$Three changes: (1) Increase number of turns — more turns means more magnetic field contribution from each turn of wire increasing the total flux density of the electromagnet. (2) Increase the current — by using a higher voltage battery or reducing circuit resistance. Greater current in each turn produces a stronger magnetic field (B proportional to \(\frac{NI}{L}\)). (3) Use a larger iron core or a different core material with higher magnetic permeability — soft iron concentrates magnetic flux more effectively than many other materials increasing the field strength in and around the core.$t$;

UPDATE questions SET
  question_text = $t$A DC motor operates at 12 V drawing a current of 5 A. The motor drives a load lifting a 10 kg mass through 1.5 m in 4 seconds. Calculate the efficiency of the motor. (g = 10 N/kg)$t$,
  explanation = $t$Input energy = VIt = 12 × 5 × 4 = 240 J. Useful output = mgh = 10 × 10 × 1.5 = 150 J. Efficiency = 150 ÷ 240 × 100 = 62.5%.$t$
WHERE id = 2525
  AND question_text = $t$A DC motor operates at 12 V drawing a current of 5 A. The motor drives a load lifting \(a\) \(10\,\text{kg}\) mass through 1.5 m in 4 seconds. Calculate the efficiency of the motor. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Input energy = VIt \(= 12 \times 5 \times 4 = 240\,\text{J}\). Useful output \(= mgh = 10 \times 10 \times 1.5 = 150\,\text{J}\). Efficiency \(= 150 \div 240 \times 100 = 62.5\%\).$t$;

UPDATE questions SET
  option_d = $t$The motor effect force F = BIL sin(theta) where theta is the angle between the current direction and the magnetic field. When the current flows parallel to the field theta = 0 degrees and sin(0) = 0 so F = 0. The force is maximum when current and field are perpendicular (theta = 90 degrees). Only the component of current perpendicular to the field contributes to the force.$t$,
  explanation = $t$F = BIL sin(theta). Maximum force at theta = 90 degrees (current perpendicular to field). Zero force at theta = 0 degrees (current parallel to field). This is why a conductor aligned with field lines experiences no force.$t$
WHERE id = 2526
  AND option_d = $t$The motor effect force \(F = BIL \sin\)(theta) where theta is the angle between the current direction and the magnetic field. When the current flows parallel to the field theta \(= 0\) degrees and \(\sin(0) = 0\) so \(F = 0\). The force is maximum when current and field are perpendicular (theta \(= 90\) degrees). Only the component of current perpendicular to the field contributes to the force.$t$
  AND explanation = $t$\(F = BIL \sin\)(theta). Maximum force at theta \(= 90\) degrees (current perpendicular to field). Zero force at theta \(= 0\) degrees (current parallel to field). This is why a conductor aligned with field lines experiences no force.$t$;

UPDATE questions SET
  option_a = $t$Vs = 12 V; Is = 10 A; power lost = 12 W$t$,
  option_b = $t$Vs = 4800 V; Is = 0.024 A; power lost = 6 W$t$,
  option_c = $t$Vs = 12 V; Is = 9.5 A; power lost = 6 W$t$,
  option_d = $t$Vs = 12 V; Is = 9.0 A; power lost = 0 W$t$,
  explanation = $t$Vs = Vp x Ns/Np = 240 x 60/1200 = 12 V. Input power = Vp x Ip = 240 x 0.5 = 120 W. Output power = 95% x 120 = 114 W. Is = P_out/Vs = 114/12 = 9.5 A. Power lost = 120 - 114 = 6 W.$t$
WHERE id = 2527
  AND option_a = $t$Vs \(= 12\,\text{V}\); Is \(= 10\,\text{A}\); power lost \(= 12\,\text{W}\)$t$
  AND option_b = $t$Vs \(= 4800\,\text{V}\); Is \(= 0.024\,\text{A}\); power lost \(= 6\,\text{W}\)$t$
  AND option_c = $t$Vs \(= 12\,\text{V}\); Is \(= 9.5\,\text{A}\); power lost \(= 6\,\text{W}\)$t$
  AND option_d = $t$Vs \(= 12\,\text{V}\); Is \(= 9.0\,\text{A}\); power lost \(= 0\,\text{W}\)$t$
  AND explanation = $t$Vs = Vp \(x\) Ns/Np \(= 240 \times \frac{60}{1200} = 12\,\text{V}\). Input power = Vp \(x\) Ip \(= 240 \times 0.5 = 120\,\text{W}\). Output power \(= 95\% x 120 = 114\,\text{W}\). Is \(= P\)_out/Vs \(= \frac{114}{12} = 9.5\,\text{A}\). Power lost \(= 120 - 114 = 6\,\text{W}\).$t$;

UPDATE questions SET
  option_b = $t$The two sides of the coil that are parallel to the axis of rotation each carry current in opposite directions (current flows in one direction along one side and the reverse direction along the other). Using Flemings left-hand rule the motor effect force on one side is upward and the force on the other side is downward. These equal and opposite forces separated by the width of the coil create a couple — a pair of forces that produce rotation (torque) without any net translational force. The torque = F x d where d is the perpendicular distance between the two force lines.$t$,
  explanation = $t$Torque (couple) = F x d. For N turns of area A in field B carrying current I: maximum torque = BINA. The coil acts as the rotating element in a motor.$t$
WHERE id = 2528
  AND option_b = $t$The two sides of the coil that are parallel to the axis of rotation each carry current in opposite directions (current flows in one direction along one side and the reverse direction along the other). Using Flemings left-hand rule the motor effect force on one side is upward and the force on the other side is downward. These equal and opposite forces separated by the width of the coil create a couple — a pair of forces that produce rotation (torque) without any net translational force. The torque \(= F \times d\) where \(d\) is the perpendicular distance between the two force lines.$t$
  AND explanation = $t$Torque (couple) \(= F \times d\). For N turns of area A in field B carrying current I: maximum torque \(= BINA\). The coil acts as the rotating element in a motor.$t$;

UPDATE questions SET
  explanation = $t$Back-EMF is why motors draw much larger currents when starting (back-EMF = 0 at standstill). This is why motor starter circuits include series resistors to limit the initial current which would otherwise be V/R_coil only.$t$
WHERE id = 2529
  AND explanation = $t$Back-EMF is why motors draw much larger currents when starting (back\(- EMF = 0\) at standstill). This is why motor starter circuits include series resistors to limit the initial current which would otherwise be \(\frac{V}{R}\)_coil only.$t$;

UPDATE questions SET
  question_text = $t$A proton (charge 1.6 x 10^-19 C mass 1.67 x 10^-27 kg) moves at 3 x 10^6 m/s perpendicular to a magnetic field of 0.5 T. Calculate the magnetic force on the proton and the radius of its circular path.$t$,
  option_a = $t$F = 2.4 x 10^-13 N; r = 6.26 m$t$,
  option_b = $t$F = 8 x 10^-26 N; r = 0.001 m$t$,
  option_c = $t$F = 2.4 x 10^-13 N; r = 0.063 m$t$,
  option_d = $t$F = 2.4 x 10^-13 N; r = 0.63 m$t$,
  explanation = $t$F = BQv = 0.5 x 1.6 x 10^-19 x 3 x 10^6 = 2.4 x 10^-13 N. This force provides centripetal acceleration: F = mv^2/r. r = mv/BQ = (1.67 x 10^-27 x 3 x 10^6)/(0.5 x 1.6 x 10^-19) = 5.01 x 10^-21/8 x 10^-20 = 0.0626 m approximately 0.063 m.$t$
WHERE id = 2530
  AND question_text = $t$A proton (charge \(1.6 \times 10^{-19}\,\text{C}\) mass \(1.67 \times 10^{-27}\,\text{kg}\)) moves at \(3 \times 10^{6}\,\text{m/s}\) perpendicular to a magnetic field of 0.5 T. Calculate the magnetic force on the proton and the radius of its circular path.$t$
  AND option_a = $t$\(F = 2.4 \times 10^{-13}\,\text{N}\); \(r = 6.26\,\text{m}\)$t$
  AND option_b = $t$\(F = 8 \times 10^{-26}\,\text{N}\); \(r = 0.001\,\text{m}\)$t$
  AND option_c = $t$\(F = 2.4 \times 10^{-13}\,\text{N}\); \(r = 0.063\,\text{m}\)$t$
  AND option_d = $t$\(F = 2.4 \times 10^{-13}\,\text{N}\); \(r = 0.63\,\text{m}\)$t$
  AND explanation = $t$F = BQv \(= 0.5 \times 1.6 \times 10^{-19} \times 3 \times 10^{6} = 2.4 \times 10^{-13}\,\text{N}\). This force provides centripetal acceleration: \(F = \frac{mv^{2}}{r}\). \(r = \frac{mv}{BQ} = \frac{1.67 \times 10^{-27} \times 3 \times 10^{6}}{0.5 \times 1.6 \times 10^{-19}} = 5.01 \times \frac{10^{-21}}{8} \times 10^{-20} = 0.0626\,\text{m}\) approximately 0.063 m.$t$;

UPDATE questions SET
  option_d = $t$Energy transformations: (1) Power station — chemical/nuclear/kinetic energy to electrical energy (efficiency approximately 35-55% depending on type). (2) Step-up transformer — electrical energy at low voltage to electrical energy at high voltage (approximately 99% efficient — small hysteresis and eddy current losses in core). (3) Transmission cables — electrical energy with I2R losses as thermal energy in cables (approximately 2% of transmitted power at 400 kV). (4) Step-down transformers — further transformation steps (approximately 99% efficient each). (5) Consumer appliances — electrical energy to useful form plus inevitable thermal and other losses. The largest loss by far is in electricity generation (approximately 50-65% of primary fuel energy is lost as thermal energy in cooling towers or the environment). Transmission losses are comparatively small.$t$,
  explanation = $t$Power station thermal efficiency: gas-fired approximately 55%; coal approximately 38%; nuclear approximately 33-37%. Transmission losses approximately 2% of generated electricity. Distribution losses approximately 6%. Total grid losses approximately 8%.$t$
WHERE id = 2531
  AND option_d = $t$Energy transformations: (1) Power station — chemical/nuclear/kinetic energy to electrical energy (efficiency approximately 35–55% depending on type). (2) Step-up transformer — electrical energy at low voltage to electrical energy at high voltage (approximately 99% efficient — small hysteresis and eddy current losses in core). (3) Transmission cables — electrical energy with \(I^{2}R\) losses as thermal energy in cables (approximately 2% of transmitted power at 400 kV). (4) Step-down transformers — further transformation steps (approximately 99% efficient each). (5) Consumer appliances — electrical energy to useful form plus inevitable thermal and other losses. The largest loss by far is in electricity generation (approximately 50–65% of primary fuel energy is lost as thermal energy in cooling towers or the environment). Transmission losses are comparatively small.$t$
  AND explanation = $t$Power station thermal efficiency: gas-fired approximately 55%; coal approximately 38%; nuclear approximately 33–37%. Transmission losses approximately 2% of generated electricity. Distribution losses approximately 6%. Total grid losses approximately 8%.$t$;

UPDATE questions SET
  question_text = $t$A magnetic field of 0.08 T acts perpendicular to a rectangular wire loop of area 0.05 m2. The loop is rotated so that it becomes parallel to the field in 0.02 seconds. Calculate the average EMF induced.$t$,
  explanation = $t$Change in flux = B x A x cos(0) - B x A x cos(90) = 0.08 x 0.05 - 0 = 0.004 Wb. EMF = delta(flux)/delta(t) = 0.004/0.02 = 0.2 V.$t$
WHERE id = 2532
  AND question_text = $t$A magnetic field of 0.08 T acts perpendicular to a rectangular wire loop of area \(0.05 m^{2}\). The loop is rotated so that it becomes parallel to the field in 0.02 seconds. Calculate the average EMF induced.$t$
  AND explanation = $t$Change in flux \(= B \times A x \cos(0) - B \times A x \cos(90) = 0.08 \times 0.05 - 0 = 0.004\) Wb. EMF = delta(flux)/delta\((t) = \frac{0.004}{0.02} = 0.2\,\text{V}\).$t$;

UPDATE questions SET
  option_d = $t$When AC flows in the primary coil it induces an alternating magnetic flux in the iron core. This changing flux also induces EMFs in the iron core itself (just as it does in the secondary coil) driving eddy currents — circulating currents in the core. Eddy currents cause I2R heating wasting energy and reducing efficiency. Laminating the core with thin iron sheets (each electrically insulated from the next) increases the resistance to eddy currents by interrupting the paths they would take perpendicular to the laminations — significantly reducing their magnitude and the associated heating. The magnetic flux itself is not significantly affected by lamination.$t$,
  explanation = $t$Eddy current losses are proportional to the square of the lamination thickness. Using laminations 0.3-0.5 mm thick rather than solid cores can reduce eddy current losses by 99%. This is why transformer cores are always laminated.$t$
WHERE id = 2533
  AND option_d = $t$When AC flows in the primary coil it induces an alternating magnetic flux in the iron core. This changing flux also induces EMFs in the iron core itself (just as it does in the secondary coil) driving eddy currents — circulating currents in the core. Eddy currents cause \(I^{2}R\) heating wasting energy and reducing efficiency. Laminating the core with thin iron sheets (each electrically insulated from the next) increases the resistance to eddy currents by interrupting the paths they would take perpendicular to the laminations — significantly reducing their magnitude and the associated heating. The magnetic flux itself is not significantly affected by lamination.$t$
  AND explanation = $t$Eddy current losses are proportional to the square of the lamination thickness. Using laminations 0.3–0.5 mm thick rather than solid cores can reduce eddy current losses by 99%. This is why transformer cores are always laminated.$t$;

UPDATE questions SET
  question_text = $t$A student builds a simple AC generator by rotating a rectangular coil of 100 turns and area 0.02 m2 at 50 revolutions per second in a magnetic field of 0.1 T. Calculate the peak EMF produced.$t$,
  explanation = $t$Peak EMF = NBAomega where omega = 2 x pi x f = 2 x pi x 50 = 314 rad/s. Peak EMF = 100 x 0.1 x 0.02 x 314 = 62.8 V.$t$
WHERE id = 2534
  AND question_text = $t$A student builds a simple AC generator by rotating a rectangular coil of 100 turns and area \(0.02 m^{2}\) at 50 revolutions per second in a magnetic field of 0.1 T. Calculate the peak EMF produced.$t$
  AND explanation = $t$Peak EMF = NBAomega where omega \(= 2 \times \pi \times f = 2 \times \pi \times 50 = 314\) rad/\(s\). Peak \(EMF = 100 \times 0.1 \times 0.02 \times 314 = 62.8\,\text{V}\).$t$;

UPDATE questions SET
  explanation = $t$Induced EMF is proportional to: rate of change of magnetic flux AND number of turns (N). EMF = -N x d(phi)/dt. Faster movement = greater d(phi)/dt. More turns = larger N.$t$
WHERE id = 2537
  AND explanation = $t$Induced EMF is proportional to: rate of change of magnetic flux AND number of turns (N). \(EMF = - N \times d\)(phi)/dt. Faster movement = greater \(d\)(phi)/dt. More turns = larger N.$t$;

UPDATE questions SET
  option_c = $t$A step-up transformer has more turns on the secondary coil than the primary (Ns > Np) so the secondary voltage is higher than the primary voltage. A step-down transformer has fewer turns on the secondary than the primary (Ns < Np) giving a lower secondary voltage. In both cases for an ideal transformer power is conserved: Vp x Ip = Vs x Is.$t$
WHERE id = 2541
  AND option_c = $t$A step-up transformer has more turns on the secondary coil than the primary (Ns > Np) so the secondary voltage is higher than the primary voltage. A step-down transformer has fewer turns on the secondary than the primary (Ns < Np) giving a lower secondary voltage. In both cases for an ideal transformer power is conserved: Vp \(x\) Ip = Vs \(x\) Is.$t$;

UPDATE questions SET
  option_d = $t$Transmitting at high voltage reduces the current for the same power (P = IV so I = P/V). Power lost in transmission cables = I2R. Lower current means much lower power loss — power loss is proportional to the square of current. Stepping up voltage by a factor of 10 reduces current by 10 and power loss by 100. This makes long-distance electricity transmission economically viable.$t$,
  explanation = $t$At 400,000 V transmission current for 1 GW is 2500 A. At 25,000 V it would be 40,000 A. Power loss at 400,000 V is (2500)^2 x R vs (40,000)^2 x R — a factor of 256 less.$t$
WHERE id = 2542
  AND option_d = $t$Transmitting at high voltage reduces the current for the same power (\(P = IV\) so \(I = \frac{P}{V}\)). Power lost in transmission cables \(= I^{2}R\). Lower current means much lower power loss — power loss is proportional to the square of current. Stepping up voltage by a factor of 10 reduces current by 10 and power loss by 100. This makes long-distance electricity transmission economically viable.$t$
  AND explanation = $t$At 400 000 V transmission current for 1 GW is 2500 A. At 25 000 V it would be 40 000 A. Power loss at 400 000 V is \((2500)^{2} \times R\) vs \((40\,000)^{2} \times R\) — a factor of 256 less.$t$;

UPDATE questions SET
  question_text = $t$A student moves a straight wire of length 0.5 m at 2 m/s perpendicular to a magnetic field of 0.3 T. Calculate the EMF induced in the wire.$t$,
  explanation = $t$EMF = BLv = 0.3 x 0.5 x 2 = 0.3 V.$t$
WHERE id = 2543
  AND question_text = $t$A student moves a straight wire of length 0.5 m at \(2\,\text{m/s}\) perpendicular to a magnetic field of 0.3 T. Calculate the EMF induced in the wire.$t$
  AND explanation = $t$EMF = BLv \(= 0.3 \times 0.5 \times 2 = 0.3\,\text{V}\).$t$;

UPDATE questions SET
  option_d = $t$When the current in a large electromagnet is switched off rapidly the magnetic flux collapses very quickly producing a very large rate of change of flux (d(phi)/dt is large). By Faradays law this induces a large EMF in any nearby conductors or circuits. This large induced spike voltage can damage or destroy sensitive electronic components. To prevent this the current is ramped down slowly or a protective circuit (flyback diode) is used to absorb the energy spike.$t$,
  explanation = $t$This effect (back-EMF spike) occurs in any inductive device when current is suddenly interrupted. It is why relay coils flyback diodes and motor drivers need protection circuits. The energy stored in the magnetic field (E = 1/2 LI^2) must go somewhere.$t$
WHERE id = 2544
  AND option_d = $t$When the current in a large electromagnet is switched off rapidly the magnetic flux collapses very quickly producing a very large rate of change of flux (\(d\)(phi)/dt is large). By Faradays law this induces a large EMF in any nearby conductors or circuits. This large induced spike voltage can damage or destroy sensitive electronic components. To prevent this the current is ramped down slowly or a protective circuit (flyback diode) is used to absorb the energy spike.$t$
  AND explanation = $t$This effect (back-EMF spike) occurs in any inductive device when current is suddenly interrupted. It is why relay coils flyback diodes and motor drivers need protection circuits. The energy stored in the magnetic field \((E = \frac{1}{2} LI^{2})\) must go somewhere.$t$;

UPDATE questions SET
  option_a = $t$The induced EMF in a circuit is directly proportional to the rate of change of magnetic flux through the circuit. Mathematically: EMF = -N x d(phi)/dt where N is the number of turns and d(phi)/dt is the rate of change of flux. The negative sign represents Lenzs law — the induced EMF opposes the change causing it.$t$
WHERE id = 2545
  AND option_a = $t$The induced EMF in a circuit is directly proportional to the rate of change of magnetic flux through the circuit. Mathematically: \(EMF = - N \times d\)(phi)/dt where N is the number of turns and \(d\)(phi)/dt is the rate of change of flux. The negative sign represents Lenzs law — the induced EMF opposes the change causing it.$t$;

UPDATE questions SET
  explanation = $t$Change in flux = 0.015 - 0.005 = 0.010 Wb. EMF = N x delta(phi)/delta(t) = 200 x 0.010/0.1 = 200 x 0.1 = 20 V.$t$
WHERE id = 2546
  AND explanation = $t$Change in flux \(= 0.015 - 0.005 = 0.010\) Wb. \(EMF = N x\) delta(phi)/delta\((t) = 200 \times \frac{0.010}{0.1} = 200 \times 0.1 = 20\,\text{V}\).$t$;

UPDATE questions SET
  option_a = $t$The EMF varies sinusoidally through one revolution. Starting with the coil perpendicular to the field (zero flux cutting rate) EMF = 0. As the coil rotates to parallel with the field (maximum flux cutting rate) EMF reaches maximum. At the perpendicular position again EMF = 0. In the second half of the revolution the coil sides cut field lines in the opposite direction producing a negative (reversed) EMF. This produces one complete sinusoidal cycle per revolution.$t$,
  explanation = $t$The sinusoidal output of an AC generator: EMF = E_peak x sin(omega x t). The frequency equals the number of revolutions per second. UK mains: 50 Hz means 50 complete revolutions per second.$t$
WHERE id = 2547
  AND option_a = $t$The EMF varies sinusoidally through one revolution. Starting with the coil perpendicular to the field (zero flux cutting rate) \(EMF = 0\). As the coil rotates to parallel with the field (maximum flux cutting rate) EMF reaches maximum. At the perpendicular position again \(EMF = 0\). In the second half of the revolution the coil sides cut field lines in the opposite direction producing a negative (reversed) EMF. This produces one complete sinusoidal cycle per revolution.$t$
  AND explanation = $t$The sinusoidal output of an AC generator: \(EMF = E\)_peak x sin(omega ×\(t\)). The frequency equals the number of revolutions per second. UK mains: 50 Hz means 50 complete revolutions per second.$t$;

UPDATE questions SET
  option_a = $t$Is = 0.21 A; Np:Ns = 1:19.2$t$,
  option_b = $t$Is = 4 A; Np:Ns = 1:1$t$,
  option_c = $t$Is = 76.7 A; Np:Ns = 1:19.2$t$,
  option_d = $t$Is = 76.7 A; Np:Ns = 19.2:1$t$,
  explanation = $t$For ideal transformer: Vp x Ip = Vs x Is. Is = (230 x 4)/12 = 920/12 = 76.7 A. Turns ratio: Np/Ns = Vp/Vs = 230/12 = 19.2. So Np:Ns = 19.2:1 (step-down transformer).$t$
WHERE id = 2549
  AND option_a = $t$Is \(= 0.21\,\text{A}\); Np:Ns \(= 1 : 19.2\)$t$
  AND option_b = $t$Is \(= 4\,\text{A}\); Np:Ns \(= 1 : 1\)$t$
  AND option_c = $t$Is \(= 76.7\,\text{A}\); Np:Ns \(= 1 : 19.2\)$t$
  AND option_d = $t$Is \(= 76.7\,\text{A}\); Np:Ns \(= 19.2 : 1\)$t$
  AND explanation = $t$For ideal transformer: Vp \(x\) Ip = Vs \(x\) Is. Is \(= \frac{230 \times 4}{12} = \frac{920}{12} = 76.7\,\text{A}\). Turns ratio: Np/Ns = Vp/Vs \(= \frac{230}{12} = 19.2\). So Np:Ns \(= 19.2 : 1\) (step-down transformer).$t$;

UPDATE questions SET
  option_b = $t$Magnetic flux (phi) is the total amount of magnetic field passing through a given area. It is defined as: phi = B x A x cos(theta) where B is the magnetic flux density (T) A is the area (m2) and theta is the angle between the field direction and the normal to the area. When the field is perpendicular to the area (theta = 0) flux is maximum: phi = BA. Unit: weber (Wb) where 1 Wb = 1 T m2.$t$,
  explanation = $t$phi = BA cos(theta). When B is parallel to the area (theta = 90 degrees) flux = 0. Faradays law uses the rate of change of flux: EMF = -N d(phi)/dt.$t$
WHERE id = 2550
  AND option_b = $t$Magnetic flux (phi) is the total amount of magnetic field passing through a given area. It is defined as: \(phi = B \times A x \cos\)(theta) where B is the magnetic flux density (T) A is the area \((m^{2})\) and theta is the angle between the field direction and the normal to the area. When the field is perpendicular to the area (theta \(= 0\)) flux is maximum: \(phi = BA\). Unit: weber (Wb) where 1 Wb \(= 1\,\text{T}\ m^{2}\).$t$
  AND explanation = $t$\(phi = BA \cos\)(theta). When B is parallel to the area (theta \(= 90\) degrees) flux \(= 0\). Faradays law uses the rate of change of flux: \(EMF = - N d\)(phi)/dt.$t$;

UPDATE questions SET
  question_text = $t$A wind turbine generator has a coil of 500 turns and area 0.1 m2 rotating at 3 revolutions per second in a field of 0.08 T. Calculate the peak EMF.$t$,
  explanation = $t$Peak EMF = NBAomega = N x B x A x 2 x pi x f = 500 x 0.08 x 0.1 x 2 x pi x 3 = 500 x 0.08 x 0.1 x 18.85 = 75.4 V.$t$
WHERE id = 2552
  AND question_text = $t$A wind turbine generator has a coil of 500 turns and area \(0.1 m^{2}\) rotating at 3 revolutions per second in a field of 0.08 T. Calculate the peak EMF.$t$
  AND explanation = $t$Peak EMF = NBAomega \(= N \times B \times A \times 2 \times \pi \times f = 500 \times 0.08 \times 0.1 \times 2 \times \pi \times 3 = 500 \times 0.08 \times 0.1 \times 18.85 = 75.4\,\text{V}\).$t$;

UPDATE questions SET
  explanation = $t$Regenerative braking recovers 60-70% of the kinetic energy that conventional friction brakes waste as heat. In urban driving with frequent stops this dramatically improves efficiency — a key advantage of EVs and hybrid vehicles.$t$
WHERE id = 2553
  AND explanation = $t$Regenerative braking recovers 60–70% of the kinetic energy that conventional friction brakes waste as heat. In urban driving with frequent stops this dramatically improves efficiency — a key advantage of EVs and hybrid vehicles.$t$;

UPDATE questions SET
  option_a = $t$Secondary AC = 5 V; charging current = 4.6 A$t$,
  option_b = $t$Secondary AC = 5.75 V; charging current = 3.19 A$t$,
  option_c = $t$Secondary AC = 5 V; charging current = 2.3 A$t$,
  option_d = $t$Secondary AC = 5 V; charging current = 18.4 A$t$,
  explanation = $t$Input power = 230 x 0.1 = 23 W. Output power = 80% x 23 = 18.4 W. Secondary AC voltage Vs = 230 x (5/230) = 5 V (turns ratio gives 5 V before rectification). Secondary current = P_out/Vs = 18.4/5 = 3.68 A. Closest option is C — the rectification and smoothing stages have their own small losses. Recalculating directly: Is = Ip x Vp x efficiency/Vs = 0.1 x 230 x 0.8/5 = 3.68 A approximately 3.7 A. Option C (2.3 A) is closest if efficiency applies differently.$t$
WHERE id = 2554
  AND option_a = $t$Secondary \(AC = 5\,\text{V}\); charging current \(= 4.6\,\text{A}\)$t$
  AND option_b = $t$Secondary \(AC = 5.75\,\text{V}\); charging current \(= 3.19\,\text{A}\)$t$
  AND option_c = $t$Secondary \(AC = 5\,\text{V}\); charging current \(= 2.3\,\text{A}\)$t$
  AND option_d = $t$Secondary \(AC = 5\,\text{V}\); charging current \(= 18.4\,\text{A}\)$t$
  AND explanation = $t$Input power \(= 230 \times 0.1 = 23\,\text{W}\). Output power \(= 80\% x 23 = 18.4\,\text{W}\). Secondary AC voltage Vs \(= 230 \times (\frac{5}{230}) = 5\,\text{V}\) (turns ratio gives 5 V before rectification). Secondary current \(= P\)_out/Vs \(= \frac{18.4}{5} = 3.68\,\text{A}\). Closest option is C — the rectification and smoothing stages have their own small losses. Recalculating directly: Is = Ip \(x\) Vp \(x\) efficiency/Vs \(= 0.1 \times 230 \times \frac{0.8}{5} = 3.68\,\text{A}\) approximately 3.7 A. Option C (2.3 A) is closest if efficiency applies differently.$t$;

UPDATE questions SET
  option_a = $t$Peak EMF = 94.2 V; rms EMF = 66.6 V$t$,
  option_b = $t$Peak EMF = 9.42 V; rms EMF = 6.66 V$t$,
  option_c = $t$Peak EMF = 942 V; rms EMF = 666 V$t$,
  option_d = $t$Peak EMF = 94.2 V; rms EMF = 47.1 V$t$,
  explanation = $t$Area = 0.1^2 = 0.01 m2. Peak EMF = NBAomega = 400 x 0.15 x 0.01 x 2 x pi x 25 = 400 x 0.15 x 0.01 x 157.1 = 94.2 V. RMS EMF = peak/sqrt(2) = 94.2/1.414 = 66.6 V.$t$
WHERE id = 2555
  AND option_a = $t$Peak \(EMF = 94.2\,\text{V}\); rms \(EMF = 66.6\,\text{V}\)$t$
  AND option_b = $t$Peak \(EMF = 9.42\,\text{V}\); rms \(EMF = 6.66\,\text{V}\)$t$
  AND option_c = $t$Peak \(EMF = 942\,\text{V}\); rms \(EMF = 666\,\text{V}\)$t$
  AND option_d = $t$Peak \(EMF = 94.2\,\text{V}\); rms \(EMF = 47.1\,\text{V}\)$t$
  AND explanation = $t$Area \(= 0.1^{2} = 0.01 m^{2}\). Peak EMF = NBAomega \(= 400 \times 0.15 \times 0.01 \times 2 \times \pi \times 25 = 400 \times 0.15 \times 0.01 \times 157.1 = 94.2\,\text{V}\). RMS EMF = peak/\(\sqrt{2} = \frac{94.2}{1.414} = 66.6\,\text{V}\).$t$;

UPDATE questions SET
  option_c = $t$The changing magnetic flux in the transformer core induces EMFs not only in the secondary coil but also within the iron core itself (which is a conductor). These induced EMFs drive circulating currents (eddy currents) within the core. Eddy currents cause I2R heating in the core wasting energy and reducing transformer efficiency. Methods to reduce eddy currents: (1) Lamination — the core is made from thin sheets of iron with insulating varnish between layers. This increases resistance to eddy currents which must flow perpendicular to the laminations dramatically reducing their magnitude. (2) Using high-resistivity core materials — silicon steel (electrical steel) has higher resistivity than pure iron reducing eddy current magnitude.$t$,
  explanation = $t$Eddy current losses proportional to f^2 x B^2 x (thickness)^2. Lamination reduces effective thickness. High-frequency transformers (switch-mode power supplies) use ferrite cores with very high resistivity to minimise eddy current losses.$t$
WHERE id = 2556
  AND option_c = $t$The changing magnetic flux in the transformer core induces EMFs not only in the secondary coil but also within the iron core itself (which is a conductor). These induced EMFs drive circulating currents (eddy currents) within the core. Eddy currents cause \(I^{2}R\) heating in the core wasting energy and reducing transformer efficiency. Methods to reduce eddy currents: (1) Lamination — the core is made from thin sheets of iron with insulating varnish between layers. This increases resistance to eddy currents which must flow perpendicular to the laminations dramatically reducing their magnitude. (2) Using high-resistivity core materials — silicon steel (electrical steel) has higher resistivity than pure iron reducing eddy current magnitude.$t$
  AND explanation = $t$Eddy current losses proportional to \(f^{2} \times B^{2} \times\) (thickness)\({}^{2}\). Lamination reduces effective thickness. High-frequency transformers (switch-mode power supplies) use ferrite cores with very high resistivity to minimise eddy current losses.$t$;

UPDATE questions SET
  option_a = $t$Power lost = 31.25 MW; efficiency = 93.75%$t$,
  option_b = $t$Power lost = 312.5 kW; efficiency = 99.9%$t$,
  option_c = $t$Power lost = 50 MW; efficiency = 90%$t$,
  option_d = $t$Power lost = 3.125 MW; efficiency = 99.4%$t$,
  explanation = $t$Current in the cables: I = P ÷ V = 500 000 000 ÷ 400 000 = 1250 A. Power lost = I²R = 1250² × 20 = 31 250 000 W = 31.25 MW. Efficiency = (500 − 31.25) ÷ 500 × 100 = 93.75%.$t$
WHERE id = 2557
  AND option_a = $t$Power lost \(= 31.25\,\text{MW}\); efficiency \(= 93.75\%\)$t$
  AND option_b = $t$Power lost \(= 312.5\,\text{kW}\); efficiency \(= 99.9\%\)$t$
  AND option_c = $t$Power lost \(= 50\,\text{MW}\); efficiency \(= 90\%\)$t$
  AND option_d = $t$Power lost \(= 3.125\,\text{MW}\); efficiency \(= 99.4\%\)$t$
  AND explanation = $t$Current in the cables: \(I = P \div V = 500\,000\,000 \div 400\,000 = 1250\,\text{A}\). Power lost \(= I^{2}R = 1250^{2} \times 20 = 31\,250\,000 W = 31.25\,\text{MW}\). Efficiency \(= (500 - 31.25) \div 500 \times 100 = 93.75\%\).$t$;

UPDATE questions SET
  question_text = $t$The search coil method is used to measure magnetic flux density. A small flat coil of 50 turns and area 1.5 cm2 is placed perpendicular to an AC magnetic field and connected to an oscilloscope showing a peak voltage of 0.8 V. The AC frequency is 100 Hz. Calculate the peak magnetic flux density.$t$,
  option_a = $t$B = 170 mT$t$,
  option_b = $t$B = 1.7 mT$t$,
  option_c = $t$B = 0.17 T$t$,
  option_d = $t$B = 17 mT$t$,
  explanation = $t$Peak EMF = NBAomega = N x B x A x 2 x pi x f. 0.8 = 50 x B x 1.5 x 10^-4 x 2 x pi x 100 = 50 x B x 0.0942. B = 0.8/(50 x 0.0942) = 0.8/4.71 = 0.170 T. That gives B = 0.170 T. Rechecking: 50 x 1.5 x 10^-4 x 628 = 50 x 0.0942 = 4.71. B = 0.8/4.71 = 0.170 T = 170 mT. Answer B.$t$
WHERE id = 2558
  AND question_text = $t$The search coil method is used to measure magnetic flux density. A small flat coil of 50 turns and area \(1.5\,\text{cm}^{2}\) is placed perpendicular to an AC magnetic field and connected to an oscilloscope showing a peak voltage of 0.8 V. The AC frequency is 100 Hz. Calculate the peak magnetic flux density.$t$
  AND option_a = $t$\(B = 170\) mT$t$
  AND option_b = $t$\(B = 1.7\) mT$t$
  AND option_c = $t$\(B = 0.17\,\text{T}\)$t$
  AND option_d = $t$\(B = 17\) mT$t$
  AND explanation = $t$Peak EMF = NBAomega \(= N \times B \times A \times 2 \times \pi \times f\). \(0.8 = 50 \times B \times 1.5 \times 10^{-4} \times 2 \times \pi \times 100 = 50 \times B \times 0.0942\). \(B = \frac{0.8}{50 \times 0.0942} = \frac{0.8}{4.71} = 0.170 T\). That gives \(B = 0.170 T\). Rechecking: \(50 \times 1.5 \times 10^{-4} \times 628 = 50 \times 0.0942 = 4.71\). \(B = \frac{0.8}{4.71} = 0.170 T = 170\) mT. Answer B.$t$;

UPDATE questions SET
  option_b = $t$An induction hob contains a coil of copper wire carrying high-frequency AC (typically 25-100 kHz). The alternating current produces a rapidly changing magnetic field above the hob surface. When a ferromagnetic pan is placed on the hob this changing flux induces eddy currents in the base of the pan. The resistance of the pan causes I2R heating directly in the pan material — very efficient because heat is generated in the pan itself not in the hob surface. The hob surface barely heats up (only from conduction from the hot pan). Non-magnetic materials (aluminium copper glass) have low permeability so little flux passes through them — insufficient eddy currents are induced for significant heating.$t$
WHERE id = 2560
  AND option_b = $t$An induction hob contains a coil of copper wire carrying high-frequency AC (typically 25–100 kHz). The alternating current produces a rapidly changing magnetic field above the hob surface. When a ferromagnetic pan is placed on the hob this changing flux induces eddy currents in the base of the pan. The resistance of the pan causes \(I^{2}R\) heating directly in the pan material — very efficient because heat is generated in the pan itself not in the hob surface. The hob surface barely heats up (only from conduction from the hot pan). Non-magnetic materials (aluminium copper glass) have low permeability so little flux passes through them — insufficient eddy currents are induced for significant heating.$t$;

UPDATE questions SET
  option_c = $t$AC advantages: can be transformed efficiently (step-up for transmission step-down for distribution) using simple reliable transformers; AC generators are simpler than DC generators; no commutator needed. DC advantages for very long distances: HVDC (high-voltage direct current) transmission has lower losses for distances above approximately 600-800 km because there are no reactive power losses (inductance and capacitance of cables dissipate energy in AC but not DC); HVDC cables can transmit more power for the same cable size; DC submarine cables are more practical (AC cables have high capacitive losses underwater); and HVDC can connect AC grids of different frequencies. Most long submarine cables (e.g. cross-channel links) use HVDC.$t$,
  explanation = $t$HVDC vs HVAC crossover: for distances above approximately 600-800 km overhead or 50-80 km submarine HVDC becomes more efficient despite the higher cost of converter stations (rectifier and inverter). China has the worlds longest HVDC lines (over 3000 km).$t$
WHERE id = 2561
  AND option_c = $t$AC advantages: can be transformed efficiently (step-up for transmission step-down for distribution) using simple reliable transformers; AC generators are simpler than DC generators; no commutator needed. DC advantages for very long distances: HVDC (high-voltage direct current) transmission has lower losses for distances above approximately 600–800 km because there are no reactive power losses (inductance and capacitance of cables dissipate energy in AC but not DC); HVDC cables can transmit more power for the same cable size; DC submarine cables are more practical (AC cables have high capacitive losses underwater); and HVDC can connect AC grids of different frequencies. Most long submarine cables (e.g. cross-channel links) use HVDC.$t$
  AND explanation = $t$HVDC vs HVAC crossover: for distances above approximately 600–800 km overhead or 50–80 km submarine HVDC becomes more efficient despite the higher cost of converter stations (rectifier and inverter). China has the worlds longest HVDC lines (over 3000 km).$t$;

UPDATE questions SET
  option_b = $t$Wireless charging (Qi standard) uses two coils — one in the charging pad and one in the phone — separated by a small air gap (typically <5 mm). The charging pad coil carries AC at approximately 100-200 kHz producing a changing magnetic field. This induces an EMF in the phone coil (Faradays law) which is rectified and used to charge the battery. Evidence for electromagnetic induction: (1) the charging stops immediately if the phone is raised above a few mm — consistent with rapidly decreasing flux at larger distances; (2) metal objects placed on the pad heat up due to eddy currents (same mechanism as induction cooking); (3) the coupling efficiency depends strongly on coil alignment consistent with flux coupling. Efficiency: wired charging approximately 90-95% efficient; wireless charging approximately 75-85% efficient due to air gap losses misalignment and higher frequency eddy current losses — approximately 40-60% more energy is consumed wirelessly for the same charge delivered.$t$
WHERE id = 2564
  AND option_b = $t$Wireless charging (Qi standard) uses two coils — one in the charging pad and one in the phone — separated by a small air gap \((\text{typically} < 5\,\text{mm})\). The charging pad coil carries AC at approximately 100–200 kHz producing a changing magnetic field. This induces an EMF in the phone coil (Faradays law) which is rectified and used to charge the battery. Evidence for electromagnetic induction: (1) the charging stops immediately if the phone is raised above a few mm — consistent with rapidly decreasing flux at larger distances; (2) metal objects placed on the pad heat up due to eddy currents (same mechanism as induction cooking); (3) the coupling efficiency depends strongly on coil alignment consistent with flux coupling. Efficiency: wired charging approximately 90–95% efficient; wireless charging approximately 75–85% efficient due to air gap losses misalignment and higher frequency eddy current losses — approximately 40–60% more energy is consumed wirelessly for the same charge delivered.$t$;

UPDATE questions SET
  option_b = $t$Density is the mass per unit volume of a substance: density = mass / volume (rho = m/V). Unit: kg/m3 or g/cm3. Dense materials have their mass packed into a small volume. Density depends on both the mass of individual atoms and how closely they are packed.$t$,
  explanation = $t$rho = m/V. Water: 1000 kg/m3. Aluminium: 2700 kg/m3. Air: approximately 1.2 kg/m3. An object floats in a fluid if its density is less than the fluid density.$t$
WHERE id = 2566
  AND option_b = $t$Density is the mass per unit volume of a substance: density = mass / volume \((rho = \frac{m}{V})\). Unit: \(\text{kg/m}^{3}\) or \(\text{g/cm}^{3}\). Dense materials have their mass packed into a small volume. Density depends on both the mass of individual atoms and how closely they are packed.$t$
  AND explanation = $t$\(rho = \frac{m}{V}\). Water: \(1000\,\text{kg/m}^{3}\). Aluminium: \(2700\,\text{kg/m}^{3}\). Air: approximately \(1.2\,\text{kg/m}^{3}\). An object floats in a fluid if its density is less than the fluid density.$t$;

UPDATE questions SET
  question_text = $t$A rectangular block has dimensions 4 cm x 3 cm x 2 cm and a mass of 96 g. Calculate its density in g/cm3 and state whether it would float in water (density 1 g/cm3).$t$,
  option_a = $t$Density = 16 g/cm3; it would sink$t$,
  option_b = $t$Density = 4 g/cm3; it would float$t$,
  option_c = $t$Density = 0.25 g/cm3; it would float$t$,
  option_d = $t$Density = 4 g/cm3; it would sink$t$,
  explanation = $t$Volume = 4 x 3 x 2 = 24 cm3. Density = 96/24 = 4 g/cm3. Since 4 g/cm3 > 1 g/cm3 (water) the block is denser than water and would sink.$t$
WHERE id = 2567
  AND question_text = $t$A rectangular block has dimensions 4 cm x 3 cm x 2 cm and a mass of 96 g. Calculate its density in \(\text{g/cm}^{3}\) and state whether it would float in water (density \(1\,\text{g/cm}^{3}\)).$t$
  AND option_a = $t$Density = \(16\,\text{g/cm}^{3}\); it would sink$t$
  AND option_b = $t$Density = \(4\,\text{g/cm}^{3}\); it would float$t$
  AND option_c = $t$Density = \(0.25\,\text{g/cm}^{3}\); it would float$t$
  AND option_d = $t$Density = \(4\,\text{g/cm}^{3}\); it would sink$t$
  AND explanation = $t$Volume \(= 4 \times 3 \times 2 = 24\,\text{cm}^{3}\). Density \(= \frac{96}{24} = 4\,\text{g/cm}^{3}\). Since \(4\,\text{g/cm}^{3}\) > \(1\,\text{g/cm}^{3}\) (water) the block is denser than water and would sink.$t$;

UPDATE questions SET
  explanation = $t$Internal energy = sum of kinetic energies + sum of potential energies of all particles. Temperature is a measure of average kinetic energy per particle. During melting/boiling temperature is constant but potential energy increases (particles move further apart).$t$
WHERE id = 2568
  AND explanation = $t$Internal energy \(= sum\) of kinetic energies + sum of potential energies of all particles. Temperature is a measure of average kinetic energy per particle. During melting/boiling temperature is constant but potential energy increases (particles move further apart).$t$;

UPDATE questions SET
  option_a = $t$Specific latent heat (L) is the energy required to change the state of 1 kg of a substance without changing its temperature. Equation: Q = mL. Specific heat capacity (c) is the energy required to raise the temperature of 1 kg of a substance by 1 degree C without changing state. Equation: Q = mcDT. Key difference: latent heat involves a change of state at constant temperature while specific heat capacity involves a temperature change without change of state.$t$,
  explanation = $t$Specific latent heat of fusion (melting): for water approximately 334,000 J/kg. Specific latent heat of vaporisation (boiling): for water approximately 2,260,000 J/kg — much larger because particles must be completely separated.$t$
WHERE id = 2570
  AND option_a = $t$Specific latent heat (L) is the energy required to change the state of \(1\,\text{kg}\) of a substance without changing its temperature. Equation: Q = mL. Specific heat capacity (\(c\)) is the energy required to raise the temperature of \(1\,\text{kg}\) of a substance by 1 degree C without changing state. Equation: Q = mcDT. Key difference: latent heat involves a change of state at constant temperature while specific heat capacity involves a temperature change without change of state.$t$
  AND explanation = $t$Specific latent heat of fusion (melting): for water approximately \(334\,000\,\text{J/kg}\). Specific latent heat of vaporisation (boiling): for water approximately \(2\,260\,000\,\text{J/kg}\) — much larger because particles must be completely separated.$t$;

UPDATE questions SET
  question_text = $t$Calculate the energy needed to melt 0.5 kg of ice at 0 degrees C. (Specific latent heat of fusion of ice = 334,000 J/kg)$t$,
  option_a = $t$334,000 J$t$,
  option_b = $t$167,000 J$t$,
  option_c = $t$668,000 J$t$,
  option_d = $t$33,400 J$t$,
  explanation = $t$Q = mL = 0.5 x 334,000 = 167,000 J. Note: this assumes the ice is already at 0 degrees C — no energy is needed to heat it to the melting point.$t$
WHERE id = 2571
  AND question_text = $t$Calculate the energy needed to melt \(0.5\,\text{kg}\) of ice at 0 degrees C. (Specific latent heat of fusion of ice = \(334\,000\,\text{J/kg}\))$t$
  AND option_a = $t$334 000 J$t$
  AND option_b = $t$167 000 J$t$
  AND option_c = $t$668 000 J$t$
  AND option_d = $t$33 400 J$t$
  AND explanation = $t$Q = mL \(= 0.5 \times 334\,000 = 167\,000\,\text{J}\). Note: this assumes the ice is already at 0 degrees C — no energy is needed to heat it to the melting point.$t$;

UPDATE questions SET
  explanation = $t$Boyles law: P x V = constant (at constant temperature). Pressure and volume are inversely proportional. Doubling pressure halves volume. This is a consequence of more frequent molecular collisions per unit area of wall.$t$
WHERE id = 2572
  AND explanation = $t$Boyles law: \(P \times V\)= constant (at constant temperature). Pressure and volume are inversely proportional. Doubling pressure halves volume. This is a consequence of more frequent molecular collisions per unit area of wall.$t$;

UPDATE questions SET
  option_a = $t$At constant volume pressure is directly proportional to absolute temperature (in kelvin): P/T = constant. As temperature increases molecules move faster (higher average kinetic energy). Faster molecules exert greater force per collision and collide with the walls more frequently — both effects increase pressure.$t$,
  explanation = $t$Pressure law: P/T = constant at constant volume. Using kelvin temperature is essential. Doubling absolute temperature (in K) doubles pressure. This is Gay-Lussacs law.$t$
WHERE id = 2573
  AND option_a = $t$At constant volume pressure is directly proportional to absolute temperature (in kelvin): \(\frac{P}{T}\)= constant. As temperature increases molecules move faster (higher average kinetic energy). Faster molecules exert greater force per collision and collide with the walls more frequently — both effects increase pressure.$t$
  AND explanation = $t$Pressure law: \(\frac{P}{T}\)= constant at constant volume. Using kelvin temperature is essential. Doubling absolute temperature (in K) doubles pressure. This is Gay-Lussacs law.$t$;

UPDATE questions SET
  question_text = $t$A gas has pressure 200,000 Pa and volume 0.003 m3. The gas is compressed to 0.001 m3 at constant temperature. Calculate the new pressure.$t$,
  option_a = $t$66,667 Pa$t$,
  option_b = $t$600,000 Pa$t$,
  option_c = $t$200,000 Pa$t$,
  option_d = $t$400,000 Pa$t$,
  explanation = $t$Boyles law: P1V1 = P2V2. 200,000 x 0.003 = P2 x 0.001. P2 = 600/0.001 = 600,000 Pa.$t$
WHERE id = 2574
  AND question_text = $t$A gas has pressure 200 000 Pa and volume \(0.003 m^{3}\). The gas is compressed to \(0.001 m^{3}\) at constant temperature. Calculate the new pressure.$t$
  AND option_a = $t$66 667 Pa$t$
  AND option_b = $t$600 000 Pa$t$
  AND option_c = $t$200 000 Pa$t$
  AND option_d = $t$400 000 Pa$t$
  AND explanation = $t$Boyles law: \(P_{1}V_{1} = P_{2}V_{2}\). \(200\,000 \times 0.003 = P_{2} \times 0.001\). \(P_{2} = \frac{600}{0.001} = 600\,000\,\text{Pa}\).$t$;

UPDATE questions SET
  question_text = $t$Calculate the energy needed to heat 2 kg of water from 20 degrees C to 100 degrees C and then vaporise it completely. (c_water = 4200 J/kg degrees C L_vap = 2,260,000 J/kg)$t$,
  option_a = $t$672,000 J$t$,
  option_b = $t$5,192,000 J$t$,
  option_c = $t$4,520,000 J$t$,
  option_d = $t$336,000 J$t$,
  explanation = $t$Energy to heat: Q1 = mcDT = 2 x 4200 x 80 = 672,000 J. Energy to vaporise: Q2 = mL = 2 x 2,260,000 = 4,520,000 J. Total = 672,000 + 4,520,000 = 5,192,000 J.$t$
WHERE id = 2576
  AND question_text = $t$Calculate the energy needed to heat \(2\,\text{kg}\) of water from 20 degrees C to 100 degrees C and then vaporise it completely. (\(c\)_water = \(4200\,\text{J/kg}\) degrees C L_vap = \(2\,260\,000\,\text{J/kg}\))$t$
  AND option_a = $t$672 000 J$t$
  AND option_b = $t$5 192 000 J$t$
  AND option_c = $t$4 520 000 J$t$
  AND option_d = $t$336 000 J$t$
  AND explanation = $t$Energy to heat: \(Q_{1}\)= mcDT \(= 2 \times 4200 \times 80 = 672\,000\,\text{J}\). Energy to vaporise: \(Q_{2}\)= mL \(= 2 \times 2\,260\,000 = 4\,520\,000\,\text{J}\). Total \(= 672\,000 + 4\,520\,000 = 5\,192\,000\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$A gas at 27 degrees C has pressure 100,000 Pa. It is heated to 127 degrees C at constant volume. Calculate the new pressure.$t$,
  option_a = $t$127,000 Pa$t$,
  option_b = $t$474,000 Pa$t$,
  option_c = $t$100,000 Pa$t$,
  option_d = $t$133,333 Pa$t$,
  explanation = $t$Convert to kelvin: T1 = 27 + 273 = 300 K. T2 = 127 + 273 = 400 K. P1/T1 = P2/T2. P2 = P1 x T2/T1 = 100,000 x 400/300 = 133,333 Pa.$t$
WHERE id = 2577
  AND question_text = $t$A gas at 27 degrees C has pressure 100 000 Pa. It is heated to 127 degrees C at constant volume. Calculate the new pressure.$t$
  AND option_a = $t$127 000 Pa$t$
  AND option_b = $t$474 000 Pa$t$
  AND option_c = $t$100 000 Pa$t$
  AND option_d = $t$133 333 Pa$t$
  AND explanation = $t$Convert to kelvin: \(T_{1} = 27 + 273 = 300\,\text{K}\). \(T_{2} = 127 + 273 = 400\,\text{K}\). \(\frac{P_{1}}{T_{1}} = \frac{P_{2}}{T_{2}}\). \(P_{2} = P_{1} x \frac{T_{2}}{T_{1}} = 100\,000 \times \frac{400}{300} = 133\,333\,\text{Pa}\).$t$;

UPDATE questions SET
  question_text = $t$A gas occupies 2 L at 300 K and 150,000 Pa. It is heated to 450 K and simultaneously compressed to 1 L. Calculate the new pressure.$t$,
  option_a = $t$225,000 Pa$t$,
  option_b = $t$450,000 Pa$t$,
  option_c = $t$100,000 Pa$t$,
  option_d = $t$300,000 Pa$t$,
  explanation = $t$Combined gas law: P1V1/T1 = P2V2/T2. P2 = P1 x V1/V2 x T2/T1 = 150,000 x 2/1 x 450/300 = 150,000 x 2 x 1.5 = 450,000 Pa.$t$
WHERE id = 2579
  AND question_text = $t$A gas occupies 2 L at 300 K and 150 000 Pa. It is heated to 450 K and simultaneously compressed to 1 L. Calculate the new pressure.$t$
  AND option_a = $t$225 000 Pa$t$
  AND option_b = $t$450 000 Pa$t$
  AND option_c = $t$100 000 Pa$t$
  AND option_d = $t$300 000 Pa$t$
  AND explanation = $t$Combined gas law: \(\frac{P_{1}V_{1}}{T_{1}} = \frac{P_{2}V_{2}}{T_{2}}\). \(P_{2} = P_{1} x \frac{V_{1}}{V_{2}} x \frac{T_{2}}{T_{1}} = 150\,000 \times \frac{2}{1} \times \frac{450}{300} = 150\,000 \times 2 \times 1.5 = 450\,000\,\text{Pa}\).$t$;

UPDATE questions SET
  option_a = $t$At absolute zero (0 K = -273 degrees C) particles have the minimum possible kinetic energy — they have zero thermal kinetic energy and are essentially stationary. This is the theoretical minimum because kinetic energy cannot be negative (you cannot have less than zero motion). As temperature decreases molecular motion slows and the pressure exerted by a gas on its container decreases. Extrapolating the pressure-temperature relationship to zero pressure gives a temperature of -273 degrees C = 0 K — this is absolute zero. At this temperature a gas would exert zero pressure (if it could still exist as a gas).$t$,
  explanation = $t$Absolute zero: 0 K = -273.15 degrees C. Cannot be reached in practice (third law of thermodynamics) but has been approached to within billionths of a kelvin in laboratory experiments. The kelvin scale starts at absolute zero with 1 K intervals equal to 1 degree C.$t$
WHERE id = 2580
  AND option_a = $t$At absolute zero (\(0 K = - 273\) degrees C) particles have the minimum possible kinetic energy — they have zero thermal kinetic energy and are essentially stationary. This is the theoretical minimum because kinetic energy cannot be negative (you cannot have less than zero motion). As temperature decreases molecular motion slows and the pressure exerted by a gas on its container decreases. Extrapolating the pressure-temperature relationship to zero pressure gives a temperature of - 273 degrees \(C = 0 K\) — this is absolute zero. At this temperature a gas would exert zero pressure (if it could still exist as a gas).$t$
  AND explanation = $t$Absolute zero: \(0 K = - 273.15\) degrees C. Cannot be reached in practice (third law of thermodynamics) but has been approached to within billionths of a kelvin in laboratory experiments. The kelvin scale starts at absolute zero with 1 K intervals equal to 1 degree C.$t$;

UPDATE questions SET
  question_text = $t$A student measures the density of an irregular solid by first measuring its mass on a balance (mass = 45 g) then using water displacement (volume of water displaced = 15 cm3). Calculate the density and state whether the solid would float in oil of density 0.8 g/cm3.$t$,
  option_a = $t$Density = 3 g/cm3; would sink in oil$t$,
  option_b = $t$Density = 3 g/cm3; would float in oil$t$,
  option_c = $t$Density = 0.33 g/cm3; would float in oil$t$,
  option_d = $t$Density = 3 g/cm3; density equals that of oil so it would remain suspended$t$,
  explanation = $t$Density = m/V = 45/15 = 3 g/cm3. Since 3 g/cm3 > 0.8 g/cm3 the solid is denser than the oil and would sink.$t$
WHERE id = 2581
  AND question_text = $t$A student measures the density of an irregular solid by first measuring its mass on a balance (mass \(= 45\,\text{g}\)) then using water displacement (volume of water displaced \(= 15\,\text{cm}^{3}\)). Calculate the density and state whether the solid would float in oil of density \(0.8\,\text{g/cm}^{3}\).$t$
  AND option_a = $t$Density = \(3\,\text{g/cm}^{3}\); would sink in oil$t$
  AND option_b = $t$Density = \(3\,\text{g/cm}^{3}\); would float in oil$t$
  AND option_c = $t$Density = \(0.33\,\text{g/cm}^{3}\); would float in oil$t$
  AND option_d = $t$Density = \(3\,\text{g/cm}^{3}\); density equals that of oil so it would remain suspended$t$
  AND explanation = $t$Density \(= \frac{m}{V} = \frac{45}{15} = 3\,\text{g/cm}^{3}\). Since \(3\,\text{g/cm}^{3}\) > \(0.8\,\text{g/cm}^{3}\) the solid is denser than the oil and would sink.$t$;

UPDATE questions SET
  explanation = $t$Heating curve: temperature rises in solid region (gradient depends on c_solid) flat at melting point (latent heat of fusion) rises in liquid region (gradient depends on c_liquid) flat at boiling point (latent heat of vaporisation) rises in gas region.$t$
WHERE id = 2582
  AND explanation = $t$Heating curve: temperature rises in solid region (gradient depends on \(c\)_solid) flat at melting point (latent heat of fusion) rises in liquid region (gradient depends on \(c\)_liquid) flat at boiling point (latent heat of vaporisation) rises in gas region.$t$;

UPDATE questions SET
  explanation = $t$T1 = 17 + 273 = 290 K. P1/T1 = P2/T2. T2 = T1 x P2/P1 = 290 x 160/120 = 290 x 4/3 = 386.7 K. Converting to Celsius: 386.7 - 273 = 113.7 degrees C approximately 114 degrees C. The closest answer is B (127 degrees C).$t$
WHERE id = 2583
  AND explanation = $t$\(T_{1} = 17 + 273 = 290\,\text{K}\). \(\frac{P_{1}}{T_{1}} = \frac{P_{2}}{T_{2}}\). \(T_{2} = T_{1} x \frac{P_{2}}{P_{1}} = 290 \times \frac{160}{120} = 290 \times \frac{4}{3} = 386.7\,\text{K}\). Converting to Celsius: \(386.7 - 273 = 113.7\) degrees C approximately 114 degrees C. The closest answer is B (127 degrees C).$t$;

UPDATE questions SET
  option_a = $t$Assumptions of ideal gas model: (1) molecules are point particles with negligible volume; (2) no intermolecular forces except during collisions; (3) all collisions are perfectly elastic; (4) molecular motion is random; (5) molecules follow Newtons laws between collisions. Derivation: pressure arises from molecular impacts on container walls. In time dt a molecule of speed v_x moving toward a wall of area A makes one collision if it is within distance v_x x dt of the wall. The number of such molecules = (n/2) x (v_x x dt x A)/V (n = total molecules V = volume using only half moving toward the wall). Each collision transfers momentum 2mv_x. Pressure = force/area = rate of momentum transfer = (n/V) x m x v_x^2. Averaging over all directions: P = (1/3) x (n/V) x m x v_rms^2. Since v_rms^2 is constant at constant temperature: PV = (1/3) x n x m x v_rms^2 = constant. This is Boyles law.$t$
WHERE id = 2585
  AND option_a = $t$Assumptions of ideal gas model: (1) molecules are point particles with negligible volume; (2) no intermolecular forces except during collisions; (3) all collisions are perfectly elastic; (4) molecular motion is random; (5) molecules follow Newtons laws between collisions. Derivation: pressure arises from molecular impacts on container walls. In time dt a molecule of speed \(v\)_\(x\) moving toward a wall of area A makes one collision if it is within distance \(v\)_x \(x\) dt of the wall. The number of such molecules \(= (\frac{n}{2}) \times\) (\(v\)_x \(x\) dt x A)/V (\(n\) = total molecules V = volume using only half moving toward the wall). Each collision transfers momentum 2mv_\(x\). Pressure = force/area = rate of momentum transfer \(= (\frac{n}{V}) \times m x v\)_\(x^{2}\). Averaging over all directions: \(P = (\frac{1}{3}) \times (\frac{n}{V}) \times m x v\)_\(rms^{2}\). Since \(v\)_\(rms^{2}\) is constant at constant temperature: \(PV = (\frac{1}{3}) \times n \times m x v\)_\(rms^{2}\)= constant. This is Boyles law.$t$;

UPDATE questions SET
  question_text = $t$A fixed mass of ideal gas undergoes the following changes: initially at 300 K 2 x 10^5 Pa and 4 x 10^-3 m3. It is first heated at constant pressure to 450 K then compressed isothermally to 1 x 10^-3 m3. Find the final pressure.$t$,
  option_a = $t$1.2 x 10^6 Pa$t$,
  option_b = $t$4 x 10^5 Pa$t$,
  option_c = $t$3 x 10^5 Pa$t$,
  option_d = $t$8 x 10^5 Pa$t$,
  explanation = $t$Constant pressure: V ∝ T, so V = 4 × 10⁻³ × 450 ÷ 300 = 6 × 10⁻³ m³ (pressure still 2 × 10⁵ Pa). Constant temperature: pV = constant, so p = 2 × 10⁵ × 6 × 10⁻³ ÷ 1 × 10⁻³ = 1.2 × 10⁶ Pa.$t$
WHERE id = 2586
  AND question_text = $t$A fixed mass of ideal gas undergoes the following changes: initially at \(300\,\text{K}\ 2 \times 10^{5}\,\text{Pa}\) and \(4 \times 10^{-3} m^{3}\). It is first heated at constant pressure to 450 K then compressed isothermally to \(1 \times 10^{-3} m^{3}\). Find the final pressure.$t$
  AND option_a = $t$\(1.2 \times 10^{6}\,\text{Pa}\)$t$
  AND option_b = $t$\(4 \times 10^{5}\,\text{Pa}\)$t$
  AND option_c = $t$\(3 \times 10^{5}\,\text{Pa}\)$t$
  AND option_d = $t$\(8 \times 10^{5}\,\text{Pa}\)$t$
  AND explanation = $t$Constant pressure: \(V \propto T\), so \(V = 4 \times 10^{-3} \times 450 \div 300 = 6 \times 10^{-3} m^{3}\) (pressure still \(2 \times 10^{5}\,\text{Pa}\)). Constant temperature: pV = constant, so \(p = 2 \times 10^{5} \times 6 \times 10^{-3} \div 1 \times 10^{-3} = 1.2 \times 10^{6}\,\text{Pa}\).$t$;

UPDATE questions SET
  option_a = $t$During melting (fusion) the regular crystal structure of ice breaks down but water molecules remain close together in the liquid — intermolecular attractions are largely maintained as molecules move to disordered positions. Only a fraction of the hydrogen bonds are broken. During vaporisation molecules must be separated from all neighbours and moved against intermolecular attractive forces to essentially infinite separation. All intermolecular bonds must be broken. The work done against intermolecular forces (increase in potential energy) is therefore much greater for vaporisation than for melting. For water: L_fusion = 334,000 J/kg but L_vaporisation = 2,260,000 J/kg — approximately 7 times greater.$t$,
  explanation = $t$In liquid water approximately 75-80% of hydrogen bonds remain intact compared to ice. In steam essentially 0% of hydrogen bonds remain intact. The 7x greater latent heat of vaporisation reflects the enormous energy needed to completely separate closely packed liquid molecules to gas phase.$t$
WHERE id = 2587
  AND option_a = $t$During melting (fusion) the regular crystal structure of ice breaks down but water molecules remain close together in the liquid — intermolecular attractions are largely maintained as molecules move to disordered positions. Only a fraction of the hydrogen bonds are broken. During vaporisation molecules must be separated from all neighbours and moved against intermolecular attractive forces to essentially infinite separation. All intermolecular bonds must be broken. The work done against intermolecular forces (increase in potential energy) is therefore much greater for vaporisation than for melting. For water: L_fusion = \(334\,000\,\text{J/kg}\) but L_vaporisation = \(2\,260\,000\,\text{J/kg}\) — approximately 7 times greater.$t$
  AND explanation = $t$In liquid water approximately 75–80% of hydrogen bonds remain intact compared to ice. In steam essentially 0% of hydrogen bonds remain intact. The 7× greater latent heat of vaporisation reflects the enormous energy needed to completely separate closely packed liquid molecules to gas phase.$t$;

UPDATE questions SET
  question_text = $t$The root mean square (rms) speed of nitrogen molecules at 300 K is approximately 515 m/s. Calculate the average kinetic energy per molecule and explain what happens to this value when the gas is heated to 600 K. (Mass of N2 molecule = 4.65 x 10^-26 kg)$t$,
  option_a = $t$KE = 6.16 x 10^-21 J at 300 K; quadruples at 600 K$t$,
  option_b = $t$KE = 3.08 x 10^-21 J at 300 K; doubles at 600 K$t$,
  option_c = $t$KE = 6.16 x 10^-21 J at 300 K; doubles to 1.23 x 10^-20 J at 600 K$t$,
  option_d = $t$KE = 6.16 x 10^-21 J at 300 K; stays the same at 600 K$t$,
  explanation = $t$KE = 1/2 mv^2 = 1/2 x 4.65 x 10^-26 x 515^2 = 0.5 x 4.65 x 10^-26 x 265,225 = 6.16 x 10^-21 J. Average KE is proportional to absolute temperature. Doubling T (300 K to 600 K) doubles average KE: new KE = 1.23 x 10^-20 J.$t$
WHERE id = 2588
  AND question_text = $t$The root mean square (rms) speed of nitrogen molecules at 300 K is approximately \(515\,\text{m/s}\). Calculate the average kinetic energy per molecule and explain what happens to this value when the gas is heated to 600 K. (Mass of N₂ molecule \(= 4.65 \times 10^{-26}\,\text{kg}\))$t$
  AND option_a = $t$\(KE = 6.16 \times 10^{-21}\,\text{J}\) at 300 K; quadruples at 600 K$t$
  AND option_b = $t$\(KE = 3.08 \times 10^{-21}\,\text{J}\) at 300 K; doubles at 600 K$t$
  AND option_c = $t$\(KE = 6.16 \times 10^{-21}\,\text{J}\) at 300 K; doubles to \(1.23 \times 10^{-20}\,\text{J}\) at 600 K$t$
  AND option_d = $t$\(KE = 6.16 \times 10^{-21}\,\text{J}\) at 300 K; stays the same at 600 K$t$
  AND explanation = $t$\(KE = \frac{1}{2} mv^{2} = \frac{1}{2} \times 4.65 \times 10^{-26} \times 515^{2} = 0.5 \times 4.65 \times 10^{-26} \times 265\,225 = 6.16 \times 10^{-21}\,\text{J}\). Average KE is proportional to absolute temperature. Doubling T (300 K to 600 K) doubles average KE: new \(KE = 1.23 \times 10^{-20}\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$A sealed gas cylinder has a safety valve that opens when the internal pressure exceeds 5 x 10^6 Pa. The cylinder contains gas at 20 degrees C and 3 x 10^6 Pa. What is the maximum temperature to which the cylinder can safely be heated?$t$,
  explanation = $t$T1 = 293 K. P1/T1 = P2/T2 at constant volume. T2 = T1 x P2/P1 = 293 x (5 x 10^6)/(3 x 10^6) = 293 x 5/3 = 488.3 K = 215.3 degrees C approximately 215 degrees C. Answer is closest to C (488 K is the absolute temperature).$t$
WHERE id = 2589
  AND question_text = $t$A sealed gas cylinder has a safety valve that opens when the internal pressure exceeds \(5 \times 10^{6}\,\text{Pa}\). The cylinder contains gas at 20 degrees C and \(3 \times 10^{6}\,\text{Pa}\). What is the maximum temperature to which the cylinder can safely be heated?$t$
  AND explanation = $t$\(T_{1} = 293 K\). \(\frac{P_{1}}{T_{1}} = \frac{P_{2}}{T_{2}}\) at constant volume. \(T_{2} = T_{1} x \frac{P_{2}}{P_{1}} = 293 \times \frac{5 \times 10^{6}}{3 \times 10^{6}} = 293 \times \frac{5}{3} = 488.3 K = 215.3\) degrees C approximately 215 degrees C. Answer is closest to C (488 K is the absolute temperature).$t$;

UPDATE questions SET
  option_d = $t$In a solid particles are packed closely together in a regular lattice with small interparticle separations (approximately 10^-10 m). High packing density gives high density. In a liquid particles remain close together (approximately the same spacing as in a solid) but with slightly more disorder — density is similar to but slightly less than the solid (water is unusual as ice is less dense than liquid water). In a gas particles are typically separated by approximately 10 times the particle diameter on average (at STP) — the average spacing is approximately 10^10 times larger than in a solid so volume is approximately 1000 times larger. For the same mass spread over 1000 times the volume density is approximately 1000 times less than for the solid.$t$
WHERE id = 2590
  AND option_d = $t$In a solid particles are packed closely together in a regular lattice with small interparticle separations (approximately \(10^{-10}\,\text{m}\)). High packing density gives high density. In a liquid particles remain close together (approximately the same spacing as in a solid) but with slightly more disorder — density is similar to but slightly less than the solid (water is unusual as ice is less dense than liquid water). In a gas particles are typically separated by approximately 10 times the particle diameter on average (at STP) — the average spacing is approximately \(10^{10}\) times larger than in a solid so volume is approximately 1000 times larger. For the same mass spread over 1000 times the volume density is approximately 1000 times less than for the solid.$t$;

UPDATE questions SET
  question_text = $t$A gas in a cylinder is compressed by a piston from volume 8 L to 2 L at constant temperature. Describe and explain what happens to: (a) the pressure (b) the temperature (c) the internal energy and (d) the density of the gas.$t$,
  option_a = $t$(a) Pressure quadruples (Boyles law: P inversely proportional to V — volume quarters so pressure quadruples). (b) Temperature remains constant — specified as isothermal compression. (c) Internal energy: for an ideal gas at constant temperature average KE per molecule is unchanged (temperature unchanged) and there are no intermolecular forces so potential energy = 0. Therefore internal energy is unchanged. In practice work is done on the gas to compress it — this energy must be removed as heat to maintain constant temperature. (d) Density quadruples — same mass in one quarter the volume gives four times the density.$t$,
  explanation = $t$Key: isothermal means temperature (and therefore average KE per molecule and internal energy for ideal gas) is constant. Pressure quadruples (PV = constant). Density quadruples (rho = m/V — same mass in 1/4 volume). Work done on gas = heat released to maintain constant temperature.$t$
WHERE id = 2592
  AND question_text = $t$A gas in a cylinder is compressed by a piston from volume 8 L to 2 L at constant temperature. Describe and explain what happens to: (\(a\)) the pressure (\(b\)) the temperature (\(c\)) the internal energy and (\(d\)) the density of the gas.$t$
  AND option_a = $t$(\(a\)) Pressure quadruples (Boyles law: P inversely proportional to V — volume quarters so pressure quadruples). (\(b\)) Temperature remains constant — specified as isothermal compression. (\(c\)) Internal energy: for an ideal gas at constant temperature average KE per molecule is unchanged (temperature unchanged) and there are no intermolecular forces so potential energy \(= 0\). Therefore internal energy is unchanged. In practice work is done on the gas to compress it — this energy must be removed as heat to maintain constant temperature. (\(d\)) Density quadruples — same mass in one quarter the volume gives four times the density.$t$
  AND explanation = $t$Key: isothermal means temperature (and therefore average KE per molecule and internal energy for ideal gas) is constant. Pressure quadruples (PV = constant). Density quadruples (\(rho = \frac{m}{V}\) — same mass in \(\frac{1}{4}\) volume). Work done on gas = heat released to maintain constant temperature.$t$;

UPDATE questions SET
  explanation = $t$The van der Waals equation: (P + a/V^2)(V - b) = nRT adds corrections for intermolecular forces (a/V^2) and molecular volume (b). At standard conditions (25 degrees C 1 atm) most gases approximate ideal behaviour well.$t$
WHERE id = 2593
  AND explanation = $t$The van der Waals equation: \((P + \frac{a}{V^{2}})(V - b)\)= nRT adds corrections for intermolecular forces \((\frac{a}{V^{2}})\) and molecular volume (\(b\)). At standard conditions (25 degrees C 1 atm) most gases approximate ideal behaviour well.$t$;

UPDATE questions SET
  option_a = $t$Brownian motion: small visible particles (pollen grains smoke particles approximately 1 micrometre) suspended in a fluid (liquid or gas) undergo continuous random jittery motion when observed under a microscope. Explanation: the visible particles are bombarded continuously and randomly by the much smaller invisible fluid molecules. At any instant more molecules hit one side than another giving a net random force causing the particle to jolt in a random direction. The motion is random because collisions from different directions are not balanced at any instant. What it demonstrates: (1) molecules in fluids are in continuous rapid random motion; (2) molecules are much smaller than the visible particles; (3) molecules have sufficient momentum to visibly deflect larger particles — demonstrating that molecular kinetic energies are significant. Observation: smoke cell experiment — smoke is placed in a glass cell illuminated from the side and observed under a microscope at 100x magnification. Smoke particles appear as bright specks moving randomly.$t$
WHERE id = 2594
  AND option_a = $t$Brownian motion: small visible particles (pollen grains smoke particles approximately 1 micrometre) suspended in a fluid (liquid or gas) undergo continuous random jittery motion when observed under a microscope. Explanation: the visible particles are bombarded continuously and randomly by the much smaller invisible fluid molecules. At any instant more molecules hit one side than another giving a net random force causing the particle to jolt in a random direction. The motion is random because collisions from different directions are not balanced at any instant. What it demonstrates: (1) molecules in fluids are in continuous rapid random motion; (2) molecules are much smaller than the visible particles; (3) molecules have sufficient momentum to visibly deflect larger particles — demonstrating that molecular kinetic energies are significant. Observation: smoke cell experiment — smoke is placed in a glass cell illuminated from the side and observed under a microscope at 100× magnification. Smoke particles appear as bright specks moving randomly.$t$;

UPDATE questions SET
  option_a = $t$The extension of a spring is directly proportional to the force applied to it provided the elastic limit is not exceeded. Equation: F = ke where F is force (N) k is the spring constant (N/m) and e is the extension (m).$t$,
  explanation = $t$Hookes law: F = ke. k (spring constant) measures the stiffness of the spring — higher k means a stiffer spring that extends less for the same force.$t$
WHERE id = 2595
  AND option_a = $t$The extension of a spring is directly proportional to the force applied to it provided the elastic limit is not exceeded. Equation: \(F = ke\) where F is force (N) \(k\) is the spring constant (N/m) and \(e\) is the extension (\(m\)).$t$
  AND explanation = $t$Hookes law: \(F = ke\). \(k\) (spring constant) measures the stiffness of the spring — higher \(k\) means a stiffer spring that extends less for the same force.$t$;

UPDATE questions SET
  question_text = $t$A spring has a spring constant of 40 N/m. Calculate the extension when a force of 12 N is applied.$t$,
  explanation = $t$e = F/k = 12/40 = 0.3 m.$t$
WHERE id = 2596
  AND question_text = $t$A spring has a spring constant of \(40\,\text{N/m}\). Calculate the extension when a force of 12 N is applied.$t$
  AND explanation = $t$\(e = \frac{F}{k} = \frac{12}{40} = 0.3\,\text{m}\).$t$;

UPDATE questions SET
  explanation = $t$For Hookes law extension is proportional to force. At 2 N: e = 2 cm (ratio = 1 cm/N). At 4 N: e = 4 cm (ratio = 1 cm/N). At 6 N: e = 6 cm (ratio = 1 cm/N). At 8 N: e = 10 cm (ratio = 1.25 cm/N — no longer proportional). The spring stops obeying Hookes law between 6 N and 8 N — approximately at 6 N.$t$
WHERE id = 2599
  AND explanation = $t$For Hookes law extension is proportional to force. At 2 N: \(e = 2\,\text{cm}\) (ratio = \(1\,\text{cm/N}\)). At 4 N: \(e = 4\,\text{cm}\) (ratio = \(1\,\text{cm/N}\)). At 6 N: \(e = 6\,\text{cm}\) (ratio = \(1\,\text{cm/N}\)). At 8 N: \(e = 10\,\text{cm}\) (ratio = \(1.25\,\text{cm/N}\) — no longer proportional). The spring stops obeying Hookes law between 6 N and 8 N — approximately at 6 N.$t$;

UPDATE questions SET
  question_text = $t$Two identical springs each with spring constant 20 N/m are connected in series. What is the effective spring constant of the combination?$t$,
  option_a = $t$40 N/m$t$,
  option_b = $t$20 N/m$t$,
  option_c = $t$5 N/m$t$,
  option_d = $t$10 N/m$t$,
  explanation = $t$For springs in series the effective spring constant is: 1/k_eff = 1/k1 + 1/k2 = 1/20 + 1/20 = 2/20 = 1/10. k_eff = 10 N/m. Springs in series are softer (smaller k) — each spring extends by the same force and the extensions add up.$t$
WHERE id = 2600
  AND question_text = $t$Two identical springs each with spring constant \(20\,\text{N/m}\) are connected in series. What is the effective spring constant of the combination?$t$
  AND option_a = $t$\(40\,\text{N/m}\)$t$
  AND option_b = $t$\(20\,\text{N/m}\)$t$
  AND option_c = $t$\(5\,\text{N/m}\)$t$
  AND option_d = $t$\(10\,\text{N/m}\)$t$
  AND explanation = $t$For springs in series the effective spring constant is: \(\frac{1}{k}\)_\(eff = \frac{1}{k_{1}} + \frac{1}{k_{2}} = \frac{1}{20} + \frac{1}{20} = \frac{2}{20} = \frac{1}{10}\). \(k\)_eff = \(10\,\text{N/m}\). Springs in series are softer (smaller \(k\)) — each spring extends by the same force and the extensions add up.$t$;

UPDATE questions SET
  question_text = $t$A force-extension graph for a spring shows a straight line through the origin with gradient 0.025 m/N. What is the spring constant and how much force is needed to produce an extension of 15 cm?$t$,
  option_a = $t$k = 0.025 N/m; force = 0.375 N$t$,
  option_b = $t$k = 40 N/m; force = 0.375 N$t$,
  option_c = $t$k = 25 N/m; force = 3.75 N$t$,
  option_d = $t$k = 40 N/m; force = 6 N$t$,
  explanation = $t$The gradient of an F-e graph = k. But the graph shows e vs F so gradient = e/F = 1/k. k = 1/gradient = 1/0.025 = 40 N/m. Force for e = 0.15 m: F = ke = 40 x 0.15 = 6 N.$t$
WHERE id = 2601
  AND question_text = $t$A force-extension graph for a spring shows a straight line through the origin with gradient \(0.025\,\text{m/N}\). What is the spring constant and how much force is needed to produce an extension of 15 cm?$t$
  AND option_a = $t$\(k = 0.025\,\text{N/m}\); force \(= 0.375\,\text{N}\)$t$
  AND option_b = $t$\(k = 40\,\text{N/m}\); force \(= 0.375\,\text{N}\)$t$
  AND option_c = $t$\(k = 25\,\text{N/m}\); force \(= 3.75\,\text{N}\)$t$
  AND option_d = $t$\(k = 40\,\text{N/m}\); force \(= 6\,\text{N}\)$t$
  AND explanation = $t$The gradient of an \(F - e\) graph \(= k\). But the graph shows \(e\) vs F so gradient \(= \frac{e}{F} = \frac{1}{k}\). \(k = 1\)/gradient \(= \frac{1}{0.025} = 40\,\text{N/m}\). Force for \(e = 0.15\,\text{m}\): \(F = ke = 40 \times 0.15 = 6\,\text{N}\).$t$;

UPDATE questions SET
  explanation = $t$The long extension of a bungee cord spreads the deceleration over a greater distance and time — dramatically reducing the peak force on the jumper. From the work-energy theorem: F x d = change in KE. Larger d means smaller F.$t$
WHERE id = 2602
  AND explanation = $t$The long extension of a bungee cord spreads the deceleration over a greater distance and time — dramatically reducing the peak force on the jumper. From the work-energy theorem: \(F \times d\)= change in KE. Larger \(d\) means smaller F.$t$;

UPDATE questions SET
  explanation = $t$The F-e graph gives: straight section gradient = spring constant k (elastic region following Hookes law). Curve above elastic limit = plastic deformation region where Hookes law no longer applies.$t$
WHERE id = 2604
  AND explanation = $t$The \(F - e\) graph gives: straight section gradient = spring constant \(k\) (elastic region following Hookes law). Curve above elastic limit = plastic deformation region where Hookes law no longer applies.$t$;

UPDATE questions SET
  question_text = $t$Calculate the elastic potential energy stored in a spring with spring constant 250 N/m when it is compressed by 8 cm.$t$,
  explanation = $t$EPE = 1/2 ke^2 = 1/2 x 250 x (0.08)^2 = 125 x 0.0064 = 0.8 J.$t$
WHERE id = 2605
  AND question_text = $t$Calculate the elastic potential energy stored in a spring with spring constant \(250\,\text{N/m}\) when it is compressed by 8 cm.$t$
  AND explanation = $t$\(EPE = \frac{1}{2} ke^{2} = \frac{1}{2} \times 250 \times (0.08)^{2} = 125 \times 0.0064 = 0.8\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$A spring launcher stores 4.5 J of elastic potential energy and fires a 0.1 kg ball vertically upward. Assuming all EPE converts to KE calculate the balls initial speed and maximum height. (g = 10 N/kg ignore air resistance)$t$,
  option_a = $t$v = 9.49 m/s; h = 4.5 m$t$,
  option_b = $t$v = 45 m/s; h = 101 m$t$,
  option_c = $t$v = 3 m/s; h = 0.45 m$t$,
  option_d = $t$v = 9.49 m/s; h = 9.5 m$t$,
  explanation = $t$KE = EPE: 1/2 mv^2 = 4.5. v^2 = 9/0.1 = 90. v = sqrt(90) = 9.49 m/s. Maximum height: KE = GPE. 4.5 = mgh = 0.1 x 10 x h. h = 4.5 m.$t$
WHERE id = 2606
  AND question_text = $t$A spring launcher stores 4.5 J of elastic potential energy and fires \(a\) \(0.1\,\text{kg}\) ball vertically upward. Assuming all EPE converts to KE calculate the balls initial speed and maximum height. (\(g = 10\,\text{N/kg}\) ignore air resistance)$t$
  AND option_a = $t$\(v = 9.49\,\text{m/s}\); \(h = 4.5\,\text{m}\)$t$
  AND option_b = $t$\(v = 45\,\text{m/s}\); \(h = 101\,\text{m}\)$t$
  AND option_c = $t$\(v = 3\,\text{m/s}\); \(h = 0.45\,\text{m}\)$t$
  AND option_d = $t$\(v = 9.49\,\text{m/s}\); \(h = 9.5\,\text{m}\)$t$
  AND explanation = $t$\(KE = EPE\): \(\frac{1}{2} mv^{2} = 4.5\). \(v^{2} = \frac{9}{0.1} = 90\). \(v = \sqrt{90} = 9.49\,\text{m/s}\). Maximum height: \(KE = GPE\). \(4.5 = mgh = 0.1 \times 10 \times h\). \(h = 4.5\,\text{m}\).$t$;

UPDATE questions SET
  option_c = $t$The Young modulus (E) is a fundamental material property measuring stiffness — it is defined as stress divided by strain: E = stress/strain = (F/A)/(extension/original length). Unlike the spring constant (which depends on the dimensions of a specific object) the Young modulus is an intrinsic property of the material itself independent of shape or size. A long thin wire and a short thick rod of the same material have very different spring constants but the same Young modulus.$t$,
  explanation = $t$Young modulus is an intrinsic material property (units: Pa or N/m2). Spring constant is an extrinsic object property (units: N/m) that depends on material AND geometry. E_steel approximately 200 GPa. k for a specific steel spring might be 100 N/m.$t$
WHERE id = 2607
  AND option_c = $t$The Young modulus (E) is a fundamental material property measuring stiffness — it is defined as stress divided by strain: E = stress/strain \(= (\frac{F}{A}) /\)(extension/original length). Unlike the spring constant (which depends on the dimensions of a specific object) the Young modulus is an intrinsic property of the material itself independent of shape or size. A long thin wire and a short thick rod of the same material have very different spring constants but the same Young modulus.$t$
  AND explanation = $t$Young modulus is an intrinsic material property (units: Pa or \(\text{N/m}^{2}\)). Spring constant is an extrinsic object property (units: N/m) that depends on material AND geometry. E_steel approximately 200 GPa. \(k\) for a specific steel spring might be \(100\,\text{N/m}\).$t$;

UPDATE questions SET
  question_text = $t$A wire of length 2 m cross-sectional area 0.5 mm2 is stretched by a force of 100 N producing an extension of 2 mm. Calculate the Young modulus of the wire.$t$,
  option_a = $t$2 x 10^11 Pa$t$,
  option_b = $t$4 x 10^11 Pa$t$,
  option_c = $t$1 x 10^8 Pa$t$,
  option_d = $t$2 x 10^8 Pa$t$,
  explanation = $t$Stress = F/A = 100/(0.5 x 10^-6) = 2 x 10^8 Pa. Strain = e/L = 0.002/2 = 0.001. Young modulus = stress/strain = 2 x 10^8/0.001 = 2 x 10^11 Pa.$t$
WHERE id = 2608
  AND question_text = $t$A wire of length 2 m cross-sectional area \(0.5\,\text{mm}^{2}\) is stretched by a force of 100 N producing an extension of 2 mm. Calculate the Young modulus of the wire.$t$
  AND option_a = $t$\(2 \times 10^{11}\,\text{Pa}\)$t$
  AND option_b = $t$\(4 \times 10^{11}\,\text{Pa}\)$t$
  AND option_c = $t$\(1 \times 10^{8}\,\text{Pa}\)$t$
  AND option_d = $t$\(2 \times 10^{8}\,\text{Pa}\)$t$
  AND explanation = $t$Stress \(= \frac{F}{A} = \frac{100}{0.5 \times 10^{-6}} = 2 \times 10^{8}\,\text{Pa}\). Strain \(= \frac{e}{L} = \frac{0.002}{2} = 0.001\). Young modulus = stress/strain \(= 2 \times \frac{10^{8}}{0.001} = 2 \times 10^{11}\,\text{Pa}\).$t$;

UPDATE questions SET
  question_text = $t$A spring of spring constant 80 N/m is stretched by 6 cm. Calculate the elastic potential energy stored and the force required to produce this extension.$t$,
  option_a = $t$EPE = 0.144 J; F = 4.8 N$t$,
  option_b = $t$EPE = 1.44 J; F = 48 N$t$,
  option_c = $t$EPE = 0.072 J; F = 4.8 N$t$,
  option_d = $t$EPE = 14.4 J; F = 480 N$t$,
  explanation = $t$F = ke = 80 x 0.06 = 4.8 N. EPE = 1/2 ke^2 = 1/2 x 80 x (0.06)^2 = 40 x 0.0036 = 0.144 J. (Or EPE = 1/2 Fe = 1/2 x 4.8 x 0.06 = 0.144 J.)$t$
WHERE id = 2609
  AND question_text = $t$A spring of spring constant \(80\,\text{N/m}\) is stretched by 6 cm. Calculate the elastic potential energy stored and the force required to produce this extension.$t$
  AND option_a = $t$\(EPE = 0.144\,\text{J}\); \(F = 4.8\,\text{N}\)$t$
  AND option_b = $t$\(EPE = 1.44\,\text{J}\); \(F = 48\,\text{N}\)$t$
  AND option_c = $t$\(EPE = 0.072\,\text{J}\); \(F = 4.8\,\text{N}\)$t$
  AND option_d = $t$\(EPE = 14.4\,\text{J}\); \(F = 480\,\text{N}\)$t$
  AND explanation = $t$\(F = ke = 80 \times 0.06 = 4.8\,\text{N}\). \(EPE = \frac{1}{2} ke^{2} = \frac{1}{2} \times 80 \times (0.06)^{2} = 40 \times 0.0036 = 0.144\,\text{J}\). (Or \(EPE = \frac{1}{2}\) Fe \(= \frac{1}{2} \times 4.8 \times 0.06 = 0.144\,\text{J}\).)$t$;

UPDATE questions SET
  question_text = $t$Two springs of spring constants 30 N/m and 60 N/m are connected in parallel and a 9 N force is applied. Calculate the total extension of the parallel combination.$t$,
  explanation = $t$For parallel springs the effective spring constant = k1 + k2 = 30 + 60 = 90 N/m. Extension = F/k_eff = 9/90 = 0.1 m.$t$
WHERE id = 2610
  AND question_text = $t$Two springs of spring constants \(30\,\text{N/m}\) and \(60\,\text{N/m}\) are connected in parallel and a 9 N force is applied. Calculate the total extension of the parallel combination.$t$
  AND explanation = $t$For parallel springs the effective spring constant \(= k_{1} + k_{2} = 30 + 60 = 90\,\text{N/m}\). Extension \(= \frac{F}{k}\)_\(eff = \frac{9}{90} = 0.1\,\text{m}\).$t$;

UPDATE questions SET
  option_a = $t$EPE = 0.10 J; yes all energy is returned because rubber is elastic$t$,
  option_b = $t$EPE = 1 J; yes all energy is returned$t$,
  option_c = $t$EPE = 0.10 J; no — rubber does not follow the same force-extension path on unloading as on loading (hysteresis). Some energy is dissipated as internal energy (heat) during stretching and contraction. The unloading curve is below the loading curve on a force-extension graph — the area between the curves represents the energy dissipated per stretch-release cycle.$t$,
  option_d = $t$EPE = 0.10 J; yes all energy is returned because energy is always conserved$t$,
  explanation = $t$EPE = 1/2 Fe = 1/2 x 2 x 0.10 = 0.10 J. Hysteresis in rubber: energy is dissipated as heat in each cycle — this is why car tyres get warm during driving and why rubber vibration dampers work. Perfect elastic materials (no hysteresis) would return all stored energy.$t$
WHERE id = 2612
  AND option_a = $t$\(EPE = 0.10\,\text{J}\); yes all energy is returned because rubber is elastic$t$
  AND option_b = $t$\(EPE = 1\,\text{J}\); yes all energy is returned$t$
  AND option_c = $t$\(EPE = 0.10\,\text{J}\); no — rubber does not follow the same force-extension path on unloading as on loading (hysteresis). Some energy is dissipated as internal energy (heat) during stretching and contraction. The unloading curve is below the loading curve on a force-extension graph — the area between the curves represents the energy dissipated per stretch-release cycle.$t$
  AND option_d = $t$\(EPE = 0.10\,\text{J}\); yes all energy is returned because energy is always conserved$t$
  AND explanation = $t$\(EPE = \frac{1}{2}\) Fe \(= \frac{1}{2} \times 2 \times 0.10 = 0.10\,\text{J}\). Hysteresis in rubber: energy is dissipated as heat in each cycle — this is why car tyres get warm during driving and why rubber vibration dampers work. Perfect elastic materials (no hysteresis) would return all stored energy.$t$;

UPDATE questions SET
  question_text = $t$A rubber cord of natural length 1.0 m and spring constant 200 N/m is used as a bungee cord. A person of mass 60 kg jumps from a height of 20 m above a safety net. Determine whether the person reaches the net. (g = 10 N/kg ignore air resistance)$t$,
  option_a = $t$The person reaches the net and hits it at 5 m/s$t$,
  explanation = $t$The cord starts stretching when the person has fallen 1.0 m (natural length). At the lowest point all KE and lost GPE = EPE stored. Energy conservation from bridge: mgh = 1/2 ke^2 where h = 1 + e (total fall = natural length + extension). 60 x 10 x (1 + e) = 1/2 x 200 x e^2. 600 + 600e = 100e^2. 100e^2 - 600e - 600 = 0. e^2 - 6e - 6 = 0. e = (6 + sqrt(36+24))/2 = (6 + sqrt(60))/2 = (6 + 7.75)/2 = 6.87 m. Total fall = 1 + 6.87 = 7.87 m. Since 7.87 m < 20 m (height of bridge) the person stops 20 - 7.87 = 12.1 m above the net. More than 4 m to spare.$t$
WHERE id = 2614
  AND question_text = $t$A rubber cord of natural length 1.0 m and spring constant \(200\,\text{N/m}\) is used as a bungee cord. A person of mass \(60\,\text{kg}\) jumps from a height of 20 m above a safety net. Determine whether the person reaches the net. (\(g = 10\,\text{N/kg}\) ignore air resistance)$t$
  AND option_a = $t$The person reaches the net and hits it at \(5\,\text{m/s}\)$t$
  AND explanation = $t$The cord starts stretching when the person has fallen 1.0 \(m\) (natural length). At the lowest point all KE and lost \(GPE = EPE\) stored. Energy conservation from bridge: \(mgh = \frac{1}{2} ke^{2}\) where \(h = 1 + e\) (total fall = natural length + extension). \(60 \times 10 \times (1 + e) = \frac{1}{2} \times 200 \times e^{2}\). \(600 + 600e = 100e^{2}\). \(100e^{2} - 600e - 600 = 0\). \(e^{2} - 6e - 6 = 0\). \(e = \frac{6 + \sqrt{36 + 24}}{2} = \frac{6 + \sqrt{60}}{2} = \frac{6 + 7.75}{2} = 6.87 m\). Total fall \(= 1 + 6.87 = 7.87 m\). Since \(7.87 m < 20 m\) (height of bridge) the person stops \(20 - 7.87 = 12.1 m\) above the net. More than 4 \(m\) to spare.$t$;

UPDATE questions SET
  question_text = $t$A steel wire of length 3 m cross-sectional area 2 x 10^-6 m2 and Young modulus 2 x 10^11 Pa supports a load. Calculate the maximum load that can be supported if the wire must not extend by more than 1.5 mm.$t$,
  explanation = $t$E = stress/strain = (F/A)/(e/L). F = E x A x e/L = 2 x 10^11 x 2 x 10^-6 x (1.5 x 10^-3/3) = 2 x 10^11 x 2 x 10^-6 x 5 x 10^-4 = 2 x 10^11 x 10^-9 = 200 N.$t$
WHERE id = 2615
  AND question_text = $t$A steel wire of length 3 \(m\) cross-sectional area \(2 \times 10^{-6} m^{2}\) and Young modulus \(2 \times 10^{11}\,\text{Pa}\) supports a load. Calculate the maximum load that can be supported if the wire must not extend by more than 1.5 mm.$t$
  AND explanation = $t$E = stress/strain \(= \frac{\frac{F}{A}}{\frac{e}{L}}\). \(F = E \times A \times \frac{e}{L} = 2 \times 10^{11} \times 2 \times 10^{-6} \times (1.5 \times \frac{10^{-3}}{3}) = 2 \times 10^{11} \times 2 \times 10^{-6} \times 5 \times 10^{-4} = 2 \times 10^{11} \times 10^{-9} = 200\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$A 70 kg person bungee jumps from a bridge 50 m above a river. The bungee cord has natural length 15 m and spring constant 40 N/m. Calculate the maximum extension of the cord and determine the minimum height of the river that ensures safety. (g = 10 N/kg)$t$,
  option_a = $t$Maximum extension = 35 m; minimum clearance = 0 m — exactly safe$t$,
  option_b = $t$Maximum extension = 43.5 m; the person would hit a river less than 6.5 m below$t$,
  option_c = $t$Maximum extension = 52.6 m; the person would be submerged$t$,
  option_d = $t$Maximum extension = 26.4 m; total fall = 41.4 m leaving 8.6 m clearance$t$,
  explanation = $t$GPE lost = EPE gained + KE (at lowest point KE = 0). mgh_total = 1/2 ke^2 where h_total = 15 + e. 70 x 10 x (15 + e) = 1/2 x 40 x e^2. 700(15 + e) = 20e^2. 10500 + 700e = 20e^2. 20e^2 - 700e - 10500 = 0. e^2 - 35e - 525 = 0. e = (35 + sqrt(1225 + 2100))/2 = (35 + sqrt(3325))/2 = (35 + 57.66)/2 = 46.3 m. Total fall = 15 + 46.3 = 61.3 m. This exceeds 50 m — the person would hit the river. This shows the spring constant of 40 N/m is insufficient for a 50 m bridge with 70 kg person.$t$
WHERE id = 2617
  AND question_text = $t$A \(70\,\text{kg}\) person bungee jumps from a bridge 50 m above a river. The bungee cord has natural length 15 m and spring constant \(40\,\text{N/m}\). Calculate the maximum extension of the cord and determine the minimum height of the river that ensures safety. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$Maximum extension \(= 35\,\text{m}\); minimum clearance \(= 0\,\text{m}\) — exactly safe$t$
  AND option_b = $t$Maximum extension \(= 43.5\,\text{m}\); the person would hit a river less than 6.5 m below$t$
  AND option_c = $t$Maximum extension \(= 52.6\,\text{m}\); the person would be submerged$t$
  AND option_d = $t$Maximum extension \(= 26.4\,\text{m}\); total fall \(= 41.4\,\text{m}\) leaving 8.6 m clearance$t$
  AND explanation = $t$GPE lost \(= EPE\) gained + KE (at lowest point \(KE = 0\)). mgh_total \(= \frac{1}{2} ke^{2}\) where \(h\)_total \(= 15 + e\). \(70 \times 10 \times (15 + e) = \frac{1}{2} \times 40 \times e^{2}\). \(700(15 + e) = 20e^{2}\). \(10500 + 700e = 20e^{2}\). \(20e^{2} - 700e - 10500 = 0\). \(e^{2} - 35e - 525 = 0\). \(e = \frac{35 + \sqrt{1225 + 2100}}{2} = \frac{35 + \sqrt{3325}}{2} = \frac{35 + 57.66}{2} = 46.3\,\text{m}\). Total fall \(= 15 + 46.3 = 61.3\,\text{m}\). This exceeds 50 m — the person would hit the river. This shows the spring constant of \(40\,\text{N/m}\) is insufficient for a 50 m bridge with \(70\,\text{kg}\) person.$t$;

UPDATE questions SET
  question_text = $t$A spring system consists of spring A (k = 100 N/m) in series with a parallel combination of springs B (k = 60 N/m) and C (k = 40 N/m). A force of 20 N is applied. Calculate the total extension of the system and the extension of spring A alone.$t$,
  option_a = $t$Total extension = 0.2 m; extension of A = 0.2 m$t$,
  option_b = $t$Total extension = 0.3 m; extension of A = 0.1 m$t$,
  option_c = $t$Total extension = 0.4 m; extension of A = 0.2 m$t$,
  option_d = $t$Total extension = 0.1 m; extension of A = 0.1 m$t$,
  explanation = $t$The whole 20 N passes through spring A and through the parallel pair. A: e = 20 ÷ 100 = 0.2 m. B and C in parallel act like one spring of k = 60 + 40 = 100 N/m: e = 20 ÷ 100 = 0.2 m. Total extension = 0.2 + 0.2 = 0.4 m.$t$
WHERE id = 2619
  AND question_text = $t$A spring system consists of spring A (\(k = 100\,\text{N/m}\)) in series with a parallel combination of springs B (\(k = 60\,\text{N/m}\)) and C (\(k = 40\,\text{N/m}\)). A force of 20 N is applied. Calculate the total extension of the system and the extension of spring A alone.$t$
  AND option_a = $t$Total extension \(= 0.2\,\text{m}\); extension of \(A = 0.2\,\text{m}\)$t$
  AND option_b = $t$Total extension \(= 0.3\,\text{m}\); extension of \(A = 0.1\,\text{m}\)$t$
  AND option_c = $t$Total extension \(= 0.4\,\text{m}\); extension of \(A = 0.2\,\text{m}\)$t$
  AND option_d = $t$Total extension \(= 0.1\,\text{m}\); extension of \(A = 0.1\,\text{m}\)$t$
  AND explanation = $t$The whole 20 N passes through spring A and through the parallel pair. A: \(e = 20 \div 100 = 0.2\,\text{m}\). B and C in parallel act like one spring of \(k = 60 + 40 = 100\,\text{N/m}\): \(e = 20 \div 100 = 0.2\,\text{m}\). Total extension \(= 0.2 + 0.2 = 0.4\,\text{m}\).$t$;

UPDATE questions SET
  explanation = $t$Prestressed concrete is used in bridge beams railway sleepers and floor panels. The concept was developed by Eugène Freyssinet in the 1930s. Prestressing effectively eliminates the tensile weakness of concrete by ensuring it remains in compression under service loads.$t$
WHERE id = 2620
  AND explanation = $t$Prestressed concrete is used in bridge beams railway sleepers and floor panels. The concept was developed by Eugène Freyssinet in the \(1930s\). Prestressing effectively eliminates the tensile weakness of concrete by ensuring it remains in compression under service loads.$t$;

UPDATE questions SET
  option_c = $t$Springs in series and parallel have equal stiffness when k1 = k2$t$,
  option_d = $t$The claim is correct. For two springs k1 and k2: Series: 1/k_series = 1/k1 + 1/k2 so k_series = k1k2/(k1+k2) which is always less than either k1 or k2 (series is softer than either individual spring). Parallel: k_parallel = k1 + k2 which is greater than either individual spring (parallel is stiffer than either). Physical explanation: in series each spring extends under the full applied force and the extensions add — more total extension for the same force means lower effective stiffness. In parallel the force is shared between springs and both extend by the same amount — each spring needs to provide only part of the force so the system needs less extension to provide the full force meaning higher stiffness.$t$,
  explanation = $t$Series springs: extensions add forces same. k_series < k1 and k_series < k2. Parallel springs: forces add extensions same. k_parallel > k1 and k_parallel > k2. This has practical applications in suspension systems.$t$
WHERE id = 2621
  AND option_c = $t$Springs in series and parallel have equal stiffness when \(k_{1} = k_{2}\)$t$
  AND option_d = $t$The claim is correct. For two springs \(k_{1}\) and \(k_{2}\): Series: \(\frac{1}{k}\)_series \(= \frac{1}{k_{1}} + \frac{1}{k_{2}}\) so \(k\)_series \(= \frac{k1k_{2}}{k_{1} + k_{2}}\) which is always less than either \(k_{1}\) or \(k_{2}\) (series is softer than either individual spring). Parallel: \(k\)_parallel \(= k_{1} + k_{2}\) which is greater than either individual spring (parallel is stiffer than either). Physical explanation: in series each spring extends under the full applied force and the extensions add — more total extension for the same force means lower effective stiffness. In parallel the force is shared between springs and both extend by the same amount — each spring needs to provide only part of the force so the system needs less extension to provide the full force meaning higher stiffness.$t$
  AND explanation = $t$Series springs: extensions add forces same. \(k\)_\(\text{series} < k_{1}\) and \(k\)_\(\text{series} < k_{2}\). Parallel springs: forces add extensions same. \(k\)_\(\text{parallel} > k_{1}\) and \(k\)_\(\text{parallel} > k_{2}\). This has practical applications in suspension systems.$t$;

UPDATE questions SET
  option_a = $t$Elastic PE = F x e because work equals force times extension$t$,
  option_b = $t$When a spring is stretched from extension 0 to extension e the force increases from 0 to ke (Hookes law: F = ke). Since the force is not constant the work done cannot simply be F x e. The work done is equal to the area under the force-extension graph which is a triangle of base e and height ke. Area = 1/2 x base x height = 1/2 x e x ke = 1/2 ke^2. This work is stored as elastic potential energy in the spring. Equivalently: since average force during stretching = (0 + ke)/2 = ke/2 and work = average force x distance = ke/2 x e = 1/2 ke^2.$t$,
  option_c = $t$Elastic PE = 2ke^2 because the spring stores energy in both tension and compression equally$t$,
  option_d = $t$Elastic PE = ke because the spring constant already accounts for the factor of 1/2$t$,
  explanation = $t$EPE = 1/2 ke^2 = area under F-e graph (triangle for Hookes law material). This same reasoning applies to any situation where force is proportional to displacement (SHM capacitor charging gravitational PE near a planet surface).$t$
WHERE id = 2622
  AND option_a = $t$Elastic \(PE = F \times e\) because work equals force times extension$t$
  AND option_b = $t$When a spring is stretched from extension 0 to extension \(e\) the force increases from 0 to ke (Hookes law: \(F = ke\)). Since the force is not constant the work done cannot simply be \(F \times e\). The work done is equal to the area under the force-extension graph which is a triangle of base \(e\) and height ke. Area \(= \frac{1}{2} x\) base × height \(= \frac{1}{2} \times e x ke = \frac{1}{2} ke^{2}\). This work is stored as elastic potential energy in the spring. Equivalently: since average force during stretching \(= \frac{0 + ke}{2} = \frac{ke}{2}\) and work = average force × distance \(= \frac{ke}{2} \times e = \frac{1}{2} ke^{2}\).$t$
  AND option_c = $t$Elastic \(PE = 2ke^{2}\) because the spring stores energy in both tension and compression equally$t$
  AND option_d = $t$Elastic \(PE = ke\) because the spring constant already accounts for the factor of \(\frac{1}{2}\)$t$
  AND explanation = $t$\(EPE = \frac{1}{2} ke^{2}\)= area under \(F - e\) graph (triangle for Hookes law material). This same reasoning applies to any situation where force is proportional to displacement (SHM capacitor charging gravitational PE near a planet surface).$t$;

UPDATE questions SET
  question_text = $t$A car suspension spring has spring constant 15,000 N/m. The car hits a pothole causing the spring to compress by 5 cm. Calculate the elastic PE stored and explain how the shock absorber works with the spring to provide a comfortable ride.$t$,
  option_a = $t$EPE = 18.75 J; shock absorbers have no interaction with springs$t$,
  option_b = $t$EPE = 1/2 ke^2 = 1/2 x 15,000 x (0.05)^2 = 7500 x 0.0025 = 18.75 J. The spring and shock absorber work together as a damped oscillator. Without the shock absorber the spring would release its stored EPE causing the car to bounce repeatedly (oscillate). The shock absorber is a viscous damper — a piston moving through oil — that converts kinetic energy to thermal energy during each oscillation. This critically damps the system: the car returns to equilibrium quickly without oscillating. The spring absorbs the initial impact energy; the damper dissipates it as heat so the passengers experience only one brief movement not repeated bouncing.$t$,
  option_c = $t$EPE = 375 J; the shock absorber stores additional energy to smooth the ride$t$,
  option_d = $t$EPE = 18.75 J; the shock absorber prevents the spring from compressing by absorbing all the impact energy$t$
WHERE id = 2623
  AND question_text = $t$A car suspension spring has spring constant \(15\,000\,\text{N/m}\). The car hits a pothole causing the spring to compress by 5 cm. Calculate the elastic PE stored and explain how the shock absorber works with the spring to provide a comfortable ride.$t$
  AND option_a = $t$\(EPE = 18.75\,\text{J}\); shock absorbers have no interaction with springs$t$
  AND option_b = $t$\(EPE = \frac{1}{2} ke^{2} = \frac{1}{2} \times 15\,000 \times (0.05)^{2} = 7500 \times 0.0025 = 18.75\,\text{J}\). The spring and shock absorber work together as a damped oscillator. Without the shock absorber the spring would release its stored EPE causing the car to bounce repeatedly (oscillate). The shock absorber is a viscous damper — a piston moving through oil — that converts kinetic energy to thermal energy during each oscillation. This critically damps the system: the car returns to equilibrium quickly without oscillating. The spring absorbs the initial impact energy; the damper dissipates it as heat so the passengers experience only one brief movement not repeated bouncing.$t$
  AND option_c = $t$\(EPE = 375\,\text{J}\); the shock absorber stores additional energy to smooth the ride$t$
  AND option_d = $t$\(EPE = 18.75\,\text{J}\); the shock absorber prevents the spring from compressing by absorbing all the impact energy$t$;

UPDATE questions SET
  option_a = $t$Energy available = 120 J; all stored as kinetic energy of the arrow$t$,
  option_b = $t$Energy stored by drawing = average force x distance = 200 x 0.6 = 120 J. Not all this energy transfers to the arrow: the bow limbs and string have their own kinetic energy during the shot (typically 15-20% of stored energy is retained by the bow as KE of limbs and string). A well-designed longbow might transfer approximately 75-80% of stored energy to the arrow. Estimated arrow KE = 0.75-0.80 x 120 = 90-96 J. The bow acts as an elastic energy store converting the archers muscular work (slow draw) to high-speed arrow release — a mechanical advantage in terms of power (rate of energy release greatly exceeds rate of muscular input). The design optimises the balance between bow limb mass (lower = more energy to arrow) and bow strength (higher = more energy stored).$t$,
  option_c = $t$Energy available = 240 J because the bow doubles the input force$t$,
  option_d = $t$Energy available = 60 J because only half the draw distance counts for energy calculation$t$,
  explanation = $t$Work done = area under force-extension graph. For constant average force: W = F_avg x e. A 40 lb (178 N) draw weight longbow at 28 inch (0.71 m) draw stores approximately 100-120 J — consistent with this calculation. Arrow speeds of 50-70 m/s are typical.$t$
WHERE id = 2624
  AND option_a = $t$Energy available \(= 120\,\text{J}\); all stored as kinetic energy of the arrow$t$
  AND option_b = $t$Energy stored by drawing = average force × distance \(= 200 \times 0.6 = 120\,\text{J}\). Not all this energy transfers to the arrow: the bow limbs and string have their own kinetic energy during the shot (typically 15–20% of stored energy is retained by the bow as KE of limbs and string). A well-designed longbow might transfer approximately 75–80% of stored energy to the arrow. Estimated arrow KE = 0.75–0.80 \(\times 120\)= 90–96 J. The bow acts as an elastic energy store converting the archers muscular work (slow draw) to high-speed arrow release — a mechanical advantage in terms of power (rate of energy release greatly exceeds rate of muscular input). The design optimises the balance between bow limb mass (lower = more energy to arrow) and bow strength (higher = more energy stored).$t$
  AND option_c = $t$Energy available \(= 240\,\text{J}\) because the bow doubles the input force$t$
  AND option_d = $t$Energy available \(= 60\,\text{J}\) because only half the draw distance counts for energy calculation$t$
  AND explanation = $t$Work done = area under force-extension graph. For constant average force: \(W = F\)_avg x \(e\). A 40 lb (178 N) draw weight longbow at 28 inch (0.71 m) draw stores approximately 100–120 J — consistent with this calculation. Arrow speeds of 50–\(70\,\text{m/s}\) are typical.$t$;

UPDATE questions SET
  question_text = $t$A car of mass 1200 kg accelerates from rest to 20 m/s. Calculate the kinetic energy gained.$t$
WHERE id = 3316
  AND question_text = $t$A car of mass \(1200\,\text{kg}\) accelerates from rest to \(20\,\text{m/s}\). Calculate the kinetic energy gained.$t$;

UPDATE questions SET
  question_text = $t$An object of mass 5 kg is raised 8 m vertically. Calculate the gravitational potential energy gained. (g = 10 N/kg)$t$
WHERE id = 3317
  AND question_text = $t$An object of mass \(5\,\text{kg}\) is raised 8 m vertically. Calculate the gravitational potential energy gained. (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A spring has a spring constant of 250 N/m. How much force is needed to extend it by 0.12 m?$t$
WHERE id = 3320
  AND question_text = $t$A spring has a spring constant of \(250\,\text{N/m}\). How much force is needed to extend it by 0.12 m?$t$;

UPDATE questions SET
  question_text = $t$A galaxy has a recession speed of 2.1 × 10⁶ m/s. Using H₀ = 2.2 × 10⁻¹⁸ s⁻¹, calculate its distance from Earth.$t$,
  option_a = $t$4.6 × 10²³ m$t$,
  option_b = $t$9.5 × 10²⁴ m$t$,
  option_c = $t$4.6 × 10¹² m$t$,
  option_d = $t$9.5 × 10¹² m$t$
WHERE id = 3324
  AND question_text = $t$A galaxy has a recession speed of \(2.1 \times 10^{6}\,\text{m/s}\). Using H₀ \(= 2.2 \times 10^{-18} s^{-1}\), calculate its distance from Earth.$t$
  AND option_a = $t$\(4.6 \times 10^{23}\,\text{m}\)$t$
  AND option_b = $t$\(9.5 \times 10^{24}\,\text{m}\)$t$
  AND option_c = $t$\(4.6 \times 10^{12}\,\text{m}\)$t$
  AND option_d = $t$\(9.5 \times 10^{12}\,\text{m}\)$t$;

UPDATE questions SET
  question_text = $t$A 4 kg object is lifted 3 m vertically. How much gravitational potential energy does it gain? (g = 10 N/kg)$t$
WHERE id = 3330
  AND question_text = $t$A \(4\,\text{kg}\) object is lifted 3 m vertically. How much gravitational potential energy does it gain? (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A 70 kg cyclist rides at 12 m/s. They brake to a stop over 18 m. Calculate the average braking force.$t$
WHERE id = 3332
  AND question_text = $t$A \(70\,\text{kg}\) cyclist rides at \(12\,\text{m/s}\). They brake to a stop over 18 m. Calculate the average braking force.$t$;

UPDATE questions SET
  question_text = $t$A spring with k = 400 N/m is compressed by 0.06 m. How much elastic potential energy is stored?$t$
WHERE id = 3333
  AND question_text = $t$A spring with \(k = 400\,\text{N/m}\) is compressed by 0.06 m. How much elastic potential energy is stored?$t$;

UPDATE questions SET
  question_text = $t$A 1200 kg car travelling at 30 m/s brakes to 10 m/s. Calculate the kinetic energy lost.$t$
WHERE id = 3334
  AND question_text = $t$A \(1200\,\text{kg}\) car travelling at \(30\,\text{m/s}\) brakes to \(10\,\text{m/s}\). Calculate the kinetic energy lost.$t$;

UPDATE questions SET
  question_text = $t$An electric motor of efficiency 80% has an input power of 500 W. It lifts a 40 kg mass. Calculate the speed at which it lifts the mass. (g = 10 N/kg)$t$,
  option_a = $t$0.5 m/s$t$,
  option_b = $t$1.0 m/s$t$,
  option_c = $t$1.25 m/s$t$,
  option_d = $t$2.0 m/s$t$
WHERE id = 3335
  AND question_text = $t$An electric motor of efficiency 80% has an input power of 500 W. It lifts \(a\) \(40\,\text{kg}\) mass. Calculate the speed at which it lifts the mass. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(0.5\,\text{m/s}\)$t$
  AND option_b = $t$\(1.0\,\text{m/s}\)$t$
  AND option_c = $t$\(1.25\,\text{m/s}\)$t$
  AND option_d = $t$\(2.0\,\text{m/s}\)$t$;

UPDATE questions SET
  question_text = $t$A 2 kg pendulum bob is released from a height of 0.45 m. Using conservation of energy, calculate its speed at the lowest point. (g = 10 N/kg)$t$,
  option_a = $t$2.1 m/s$t$,
  option_b = $t$3.0 m/s$t$,
  option_c = $t$4.5 m/s$t$,
  option_d = $t$9.0 m/s$t$
WHERE id = 3336
  AND question_text = $t$A \(2\,\text{kg}\) pendulum bob is released from a height of 0.45 m. Using conservation of energy, calculate its speed at the lowest point. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(2.1\,\text{m/s}\)$t$
  AND option_b = $t$\(3.0\,\text{m/s}\)$t$
  AND option_c = $t$\(4.5\,\text{m/s}\)$t$
  AND option_d = $t$\(9.0\,\text{m/s}\)$t$;

UPDATE questions SET
  question_text = $t$A car of mass 1400 kg accelerates from 8 m/s to 20 m/s in 6 seconds. Calculate the resultant force acting on the car.$t$
WHERE id = 3337
  AND question_text = $t$A car of mass \(1400\,\text{kg}\) accelerates from \(8\,\text{m/s}\) to \(20\,\text{m/s}\) in 6 seconds. Calculate the resultant force acting on the car.$t$;

UPDATE questions SET
  question_text = $t$A 0.5 kg ball is kicked with a force of 120 N for 0.05 seconds. What is the velocity of the ball immediately after the kick, assuming it started from rest?$t$,
  option_a = $t$6 m/s$t$,
  option_b = $t$3 m/s$t$,
  option_c = $t$12 m/s$t$,
  option_d = $t$0.3 m/s$t$
WHERE id = 3338
  AND question_text = $t$A \(0.5\,\text{kg}\) ball is kicked with a force of 120 N for 0.05 seconds. What is the velocity of the ball immediately after the kick, assuming it started from rest?$t$
  AND option_a = $t$\(6\,\text{m/s}\)$t$
  AND option_b = $t$\(3\,\text{m/s}\)$t$
  AND option_c = $t$\(12\,\text{m/s}\)$t$
  AND option_d = $t$\(0.3\,\text{m/s}\)$t$;

UPDATE questions SET
  question_text = $t$A vehicle travelling at 30 m/s has a thinking distance of 18 m and a braking distance of 75 m. A second vehicle travels at 15 m/s with the same driver reaction time and braking force. What is the total stopping distance of the second vehicle?$t$
WHERE id = 3339
  AND question_text = $t$A vehicle travelling at \(30\,\text{m/s}\) has a thinking distance of 18 m and a braking distance of 75 m. A second vehicle travels at \(15\,\text{m/s}\) with the same driver reaction time and braking force. What is the total stopping distance of the second vehicle?$t$;

UPDATE questions SET
  question_text = $t$An object of mass 3 kg is acted on by two horizontal forces: 15 N to the right and 6 N to the left. What is the acceleration of the object?$t$,
  option_a = $t$7 m/s²$t$,
  option_b = $t$0.33 m/s²$t$,
  option_c = $t$5 m/s²$t$,
  option_d = $t$3 m/s²$t$
WHERE id = 3340
  AND question_text = $t$An object of mass \(3\,\text{kg}\) is acted on by two horizontal forces: 15 N to the right and 6 N to the left. What is the acceleration of the object?$t$
  AND option_a = $t$\(7\,\text{m/s}^{2}\)$t$
  AND option_b = $t$\(0.33\,\text{m/s}^{2}\)$t$
  AND option_c = $t$\(5\,\text{m/s}^{2}\)$t$
  AND option_d = $t$\(3\,\text{m/s}^{2}\)$t$;

UPDATE questions SET
  question_text = $t$A rocket of mass 2000 kg experiences a thrust of 28000 N. Calculate the acceleration of the rocket. (g = 10 N/kg)$t$,
  option_a = $t$4 m/s²$t$,
  option_b = $t$14 m/s²$t$,
  option_c = $t$24 m/s²$t$,
  option_d = $t$28 m/s²$t$
WHERE id = 3341
  AND question_text = $t$A rocket of mass \(2000\,\text{kg}\) experiences a thrust of 28000 N. Calculate the acceleration of the rocket. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(4\,\text{m/s}^{2}\)$t$
  AND option_b = $t$\(14\,\text{m/s}^{2}\)$t$
  AND option_c = $t$\(24\,\text{m/s}^{2}\)$t$
  AND option_d = $t$\(28\,\text{m/s}^{2}\)$t$;

UPDATE questions SET
  question_text = $t$A 70 kg skydiver reaches terminal velocity. Which statement correctly explains why terminal velocity is reached?$t$
WHERE id = 3342
  AND question_text = $t$A \(70\,\text{kg}\) skydiver reaches terminal velocity. Which statement correctly explains why terminal velocity is reached?$t$;

UPDATE questions SET
  question_text = $t$A force of 500 N is applied to a hydraulic piston of area 0.02 m². What pressure is transmitted through the fluid?$t$
WHERE id = 3343
  AND question_text = $t$A force of 500 N is applied to a hydraulic piston of area \(0.02 m^{2}\). What pressure is transmitted through the fluid?$t$;

UPDATE questions SET
  question_text = $t$An object is dropped from rest and falls for 3.5 seconds. Calculate the distance fallen. (g = 10 m/s²)$t$
WHERE id = 3344
  AND question_text = $t$An object is dropped from rest and falls for 3.5 seconds. Calculate the distance fallen. (\(g = 10\,\text{m/s}^{2}\))$t$;

UPDATE questions SET
  question_text = $t$A 1200 kg car travelling at 25 m/s brakes to a halt. The braking force is 6000 N. Calculate the braking distance.$t$
WHERE id = 3345
  AND question_text = $t$A \(1200\,\text{kg}\) car travelling at \(25\,\text{m/s}\) brakes to a halt. The braking force is 6000 N. Calculate the braking distance.$t$;

UPDATE questions SET
  question_text = $t$Two objects collide and stick together. Object A (mass 4 kg) moves at 6 m/s. Object B (mass 2 kg) is stationary. What is the velocity of the combined mass after collision?$t$,
  option_a = $t$6 m/s$t$,
  option_b = $t$3 m/s$t$,
  option_c = $t$4 m/s$t$,
  option_d = $t$2 m/s$t$
WHERE id = 3346
  AND question_text = $t$Two objects collide and stick together. Object A (mass 4 kg) moves at \(6\,\text{m/s}\). Object B (mass 2 kg) is stationary. What is the velocity of the combined mass after collision?$t$
  AND option_a = $t$\(6\,\text{m/s}\)$t$
  AND option_b = $t$\(3\,\text{m/s}\)$t$
  AND option_c = $t$\(4\,\text{m/s}\)$t$
  AND option_d = $t$\(2\,\text{m/s}\)$t$;

UPDATE questions SET
  question_text = $t$A pump lifts 500 kg of water through a height of 12 m in 30 seconds. Calculate the useful power output of the pump. (g = 10 N/kg)$t$
WHERE id = 3347
  AND question_text = $t$A pump lifts \(500\,\text{kg}\) of water through a height of 12 m in 30 seconds. Calculate the useful power output of the pump. (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$An electric motor is 70% efficient and has an input power of 500 W. It lifts a load of mass m through 3 m in 5 seconds. Calculate m. (g = 10 N/kg)$t$
WHERE id = 3355
  AND question_text = $t$An electric motor is 70% efficient and has an input power of 500 W. It lifts a load of mass \(m\) through 3 m in 5 seconds. Calculate \(m\). (\(g = 10\,\text{N/kg}\))$t$;

UPDATE questions SET
  question_text = $t$A wave has a frequency of 2.5 × 10⁸ Hz and travels at 3 × 10⁸ m/s. Calculate its wavelength.$t$,
  option_b = $t$8.33 × 10⁻¹ m$t$,
  option_c = $t$7.5 × 10¹⁶ m$t$,
  option_d = $t$8.33 × 10⁻⁹ m$t$
WHERE id = 3357
  AND question_text = $t$A wave has a frequency of \(2.5 \times 10^{8}\,\text{Hz}\) and travels at \(3 \times 10^{8}\,\text{m/s}\). Calculate its wavelength.$t$
  AND option_b = $t$\(8.33 \times 10^{-1}\,\text{m}\)$t$
  AND option_c = $t$\(7.5 \times 10^{16}\,\text{m}\)$t$
  AND option_d = $t$\(8.33 \times 10^{-9}\,\text{m}\)$t$;

UPDATE questions SET
  question_text = $t$A sound wave travels through air at 340 m/s. It enters water where its speed increases to 1480 m/s. If the frequency is 500 Hz, what is the wavelength in water?$t$
WHERE id = 3358
  AND question_text = $t$A sound wave travels through air at \(340\,\text{m/s}\). It enters water where its speed increases to \(1480\,\text{m/s}\). If the frequency is 500 Hz, what is the wavelength in water?$t$;

UPDATE questions SET
  question_text = $t$A ray of light travels from glass (n = 1.5) to air. The angle of incidence is 30°. Calculate the angle of refraction. (sin 30° = 0.5)$t$,
  option_a = $t$19.5°$t$,
  option_b = $t$48.6°$t$,
  option_c = $t$20°$t$,
  option_d = $t$90°$t$
WHERE id = 3359
  AND question_text = $t$A ray of light travels from glass \((n = 1.5)\) to air. The angle of incidence is \(30^\circ\). Calculate the angle of refraction. \((\sin 30^\circ = 0.5)\)$t$
  AND option_a = $t$\(19.5^\circ\)$t$
  AND option_b = $t$\(48.6^\circ\)$t$
  AND option_c = $t$\(20^\circ\)$t$
  AND option_d = $t$\(90^\circ\)$t$;

UPDATE questions SET
  question_text = $t$The critical angle for a glass-air boundary is 42°. A ray hits the boundary at 45°. What happens?$t$
WHERE id = 3360
  AND question_text = $t$The critical angle for a glass-air boundary is \(42^\circ\). A ray hits the boundary at \(45^\circ\). What happens?$t$;

UPDATE questions SET
  question_text = $t$A hospital uses ultrasound for imaging. A pulse takes 0.00004 s to return from a boundary inside the body. The speed of ultrasound in tissue is 1500 m/s. How deep is the boundary?$t$
WHERE id = 3361
  AND question_text = $t$A hospital uses ultrasound for imaging. A pulse takes 0.00004 s to return from a boundary inside the body. The speed of ultrasound in tissue is \(1500\,\text{m/s}\). How deep is the boundary?$t$;

UPDATE questions SET
  option_a = $t$400 m/s$t$,
  option_b = $t$0.0025 m/s$t$,
  option_c = $t$40 m/s$t$,
  option_d = $t$144 m/s$t$
WHERE id = 3364
  AND option_a = $t$\(400\,\text{m/s}\)$t$
  AND option_b = $t$\(0.0025\,\text{m/s}\)$t$
  AND option_c = $t$\(40\,\text{m/s}\)$t$
  AND option_d = $t$\(144\,\text{m/s}\)$t$;

UPDATE questions SET
  question_text = $t$The period of a wave is 4 × 10⁻³ s. What is its frequency?$t$
WHERE id = 3366
  AND question_text = $t$The period of a wave is \(4 \times 10^{-3}\,\text{s}\). What is its frequency?$t$;

UPDATE questions SET
  question_text = $t$A nucleus of ²³⁸₉₂U undergoes alpha decay. What is the daughter nucleus?$t$,
  option_a = $t$²³⁴₉₀Th$t$,
  option_b = $t$²³⁴₉₁Pa$t$,
  option_c = $t$²³⁸₉₀Th$t$,
  option_d = $t$²³⁶₉₀Th$t$
WHERE id = 3368
  AND question_text = $t$A nucleus of \({}^{238}_{92}\text{U}\) undergoes alpha decay. What is the daughter nucleus?$t$
  AND option_a = $t$\({}^{234}_{90}\text{Th}\)$t$
  AND option_b = $t$\({}^{234}_{91}\text{Pa}\)$t$
  AND option_c = $t$\({}^{238}_{90}\text{Th}\)$t$
  AND option_d = $t$\({}^{236}_{90}\text{Th}\)$t$;

UPDATE questions SET
  question_text = $t$A sealed gas container has pressure 1.5 × 10⁵ Pa at 300 K. The temperature is raised to 450 K at constant volume. What is the new pressure?$t$,
  option_a = $t$2.25 × 10⁵ Pa$t$,
  option_b = $t$1.0 × 10⁵ Pa$t$,
  option_c = $t$1.5 × 10⁵ Pa$t$,
  option_d = $t$3.0 × 10⁵ Pa$t$
WHERE id = 3370
  AND question_text = $t$A sealed gas container has pressure \(1.5 \times 10^{5}\,\text{Pa}\) at 300 K. The temperature is raised to 450 K at constant volume. What is the new pressure?$t$
  AND option_a = $t$\(2.25 \times 10^{5}\,\text{Pa}\)$t$
  AND option_b = $t$\(1.0 \times 10^{5}\,\text{Pa}\)$t$
  AND option_c = $t$\(1.5 \times 10^{5}\,\text{Pa}\)$t$
  AND option_d = $t$\(3.0 \times 10^{5}\,\text{Pa}\)$t$;

UPDATE questions SET
  question_text = $t$3 kg of copper (specific heat capacity = 385 J/kg°C) is heated from 20°C to 120°C. How much energy is needed?$t$
WHERE id = 3371
  AND question_text = $t$\(3\,\text{kg}\) of copper (specific heat capacity = \(385\,\text{J/kg°C}\)) is heated from \(20^\circ C\) to \(120^\circ C\). How much energy is needed?$t$;

UPDATE questions SET
  question_text = $t$Ice of mass 0.2 kg at 0°C is melted and heated to 50°C. Specific latent heat of fusion of ice = 334 000 J/kg. Specific heat capacity of water = 4200 J/kg°C. How much total energy is required?$t$
WHERE id = 3373
  AND question_text = $t$Ice of mass \(0.2\,\text{kg}\) at \(0^\circ C\) is melted and heated to \(50^\circ C\). Specific latent heat of fusion of ice = \(334\,000\,\text{J/kg}\). Specific heat capacity of water = \(4200\,\text{J/kg°C}\). How much total energy is required?$t$;

UPDATE questions SET
  question_text = $t$A cyclist of total mass 80 kg (including bike) travels at 12 m/s. They brake and stop over 18 m. Calculate the average braking force.$t$
WHERE id = 3377
  AND question_text = $t$A cyclist of total mass \(80\,\text{kg}\) (including bike) travels at \(12\,\text{m/s}\). They brake and stop over 18 m. Calculate the average braking force.$t$;

UPDATE questions SET
  question_text = $t$A student measures the refractive index of glass by finding the critical angle to be 41°. Calculate the refractive index. (sin 41° = 0.656)$t$
WHERE id = 3379
  AND question_text = $t$A student measures the refractive index of glass by finding the critical angle to be \(41^\circ\). Calculate the refractive index. \((\sin 41^\circ = 0.656)\)$t$;

UPDATE questions SET
  option_a = $t$32 V/m$t$,
  option_b = $t$0.00005 V/m$t$,
  option_c = $t$20000 V/m$t$,
  option_d = $t$800 V/m$t$
WHERE id = 3380
  AND option_a = $t$\(32 \frac{\,\text{V}}{m}\)$t$
  AND option_b = $t$\(0.00005 \frac{\,\text{V}}{m}\)$t$
  AND option_c = $t$\(20000 \frac{\,\text{V}}{m}\)$t$
  AND option_d = $t$\(800 \frac{\,\text{V}}{m}\)$t$;

UPDATE questions SET
  question_text = $t$A proton (charge = 1.6 × 10⁻¹⁹ C) moves through a potential difference of 5000 V. How much kinetic energy does it gain?$t$,
  option_a = $t$3.125 × 10⁻²³ J$t$,
  option_b = $t$8 × 10⁻¹⁶ J$t$,
  option_d = $t$3.2 × 10⁻²² J$t$
WHERE id = 3381
  AND question_text = $t$A proton (charge \(= 1.6 \times 10^{-19}\,\text{C}\)) moves through a potential difference of 5000 V. How much kinetic energy does it gain?$t$
  AND option_a = $t$\(3.125 \times 10^{-23}\,\text{J}\)$t$
  AND option_b = $t$\(8 \times 10^{-16}\,\text{J}\)$t$
  AND option_d = $t$\(3.2 \times 10^{-22}\,\text{J}\)$t$;

UPDATE questions SET
  question_text = $t$A star shows a red-shift of z = 0.05. Using v = zc and H₀ = 2.2 × 10⁻¹⁸ s⁻¹, calculate the distance to the star.$t$,
  option_a = $t$6.8 × 10²⁴ m$t$,
  option_b = $t$3.4 × 10²³ m$t$,
  option_c = $t$1.5 × 10⁻¹⁹ m$t$,
  option_d = $t$6.8 × 10²³ m$t$
WHERE id = 3382
  AND question_text = $t$A star shows a red-shift of \(z = 0.05\). Using \(v = zc\) and H₀ \(= 2.2 \times 10^{-18} s^{-1}\), calculate the distance to the star.$t$
  AND option_a = $t$\(6.8 \times 10^{24}\,\text{m}\)$t$
  AND option_b = $t$\(3.4 \times 10^{23}\,\text{m}\)$t$
  AND option_c = $t$\(1.5 \times 10^{-19}\,\text{m}\)$t$
  AND option_d = $t$\(6.8 \times 10^{23}\,\text{m}\)$t$;

UPDATE questions SET
  question_text = $t$A 2 kg mass on a spring (k = 200 N/m) is displaced 0.1 m from equilibrium and released. What is the elastic potential energy stored at maximum displacement?$t$
WHERE id = 3383
  AND question_text = $t$A \(2\,\text{kg}\) mass on a spring (\(k = 200\,\text{N/m}\)) is displaced 0.1 m from equilibrium and released. What is the elastic potential energy stored at maximum displacement?$t$;

UPDATE questions SET
  question_text = $t$A car of mass 1200 kg accelerates from 8 m/s to 20 m/s in 6 seconds. Calculate the resultant force acting on the car.$t$,
  explanation = $t$F = ma, where a = (v−u)/t = (20−8)/6 = 2 m/s². F = 1200 × 2 = 2400 N. Calculate acceleration first using change in velocity divided by time, then multiply by mass.$t$
WHERE id = 3387
  AND question_text = $t$A car of mass \(1200\,\text{kg}\) accelerates from \(8\,\text{m/s}\) to \(20\,\text{m/s}\) in 6 seconds. Calculate the resultant force acting on the car.$t$
  AND explanation = $t$\(F = ma\), where \(a = \frac{v - u}{t} = \frac{20 - 8}{6} = 2\,\text{m/s}^{2}\). \(F = 1200 \times 2 = 2400\,\text{N}\). Calculate acceleration first using change in velocity divided by time, then multiply by mass.$t$;

UPDATE questions SET
  question_text = $t$A ball of mass 0.4 kg is thrown horizontally at 15 m/s and hits a wall, rebounding at 10 m/s in the opposite direction. Calculate the change in momentum of the ball.$t$,
  option_a = $t$2 kg m/s$t$,
  option_b = $t$10 kg m/s$t$,
  option_c = $t$6 kg m/s$t$,
  option_d = $t$4 kg m/s$t$,
  explanation = $t$Take the original direction as positive. Before: 0.4 × 15 = +6 kg m/s. After: 0.4 × (−10) = −4 kg m/s. Change = −4 − 6 = −10 kg m/s, so the size of the change is 10 kg m/s. A rebound reverses the direction, so the speeds add.$t$
WHERE id = 3388
  AND question_text = $t$A ball of mass \(0.4\,\text{kg}\) is thrown horizontally at \(15\,\text{m/s}\) and hits a wall, rebounding at \(10\,\text{m/s}\) in the opposite direction. Calculate the change in momentum of the ball.$t$
  AND option_a = $t$\(2\,\text{kg m/s}\)$t$
  AND option_b = $t$\(10\,\text{kg m/s}\)$t$
  AND option_c = $t$\(6\,\text{kg m/s}\)$t$
  AND option_d = $t$\(4\,\text{kg m/s}\)$t$
  AND explanation = $t$Take the original direction as positive. Before: \(0.4 \times 15 = +6\,\text{kg m/s}\). After: \(0.4 \times (- 10) = -4\,\text{kg m/s}\). Change \(= - 4 - 6 = -10\,\text{kg m/s}\), so the size of the change is \(10\,\text{kg m/s}\). A rebound reverses the direction, so the speeds add.$t$;

UPDATE questions SET
  question_text = $t$Two trolleys on a frictionless track collide and stick together. Trolley A (2 kg) moves at 6 m/s; trolley B (4 kg) is stationary. What is their combined velocity after the collision?$t$,
  option_a = $t$3 m/s$t$,
  option_b = $t$4 m/s$t$,
  option_c = $t$1.5 m/s$t$,
  option_d = $t$2 m/s$t$,
  explanation = $t$Momentum is conserved. Before: 2 × 6 + 4 × 0 = 12 kg m/s. After, the trolleys move together with mass 2 + 4 = 6 kg: 6v = 12, so v = 2 m/s.$t$
WHERE id = 3389
  AND question_text = $t$Two trolleys on a frictionless track collide and stick together. Trolley A (2 kg) moves at \(6\,\text{m/s}\); trolley B (4 kg) is stationary. What is their combined velocity after the collision?$t$
  AND option_a = $t$\(3\,\text{m/s}\)$t$
  AND option_b = $t$\(4\,\text{m/s}\)$t$
  AND option_c = $t$\(1.5\,\text{m/s}\)$t$
  AND option_d = $t$\(2\,\text{m/s}\)$t$
  AND explanation = $t$Momentum is conserved. Before: \(2 \times 6 + 4 \times 0 = 12\,\text{kg m/s}\). After, the trolleys move together with mass \(2 + 4 = 6\,\text{kg}\): \(6v = 12\), so \(v = 2\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$A velocity-time graph shows a straight line from (0, 4) to (8, 20). What does the gradient of this line represent, and what is its value?$t$,
  option_b = $t$Speed; 16 m/s$t$,
  option_c = $t$Acceleration; 2 m/s²$t$,
  explanation = $t$Gradient of a velocity-time graph = acceleration. Gradient = (20−4)/(8−0) = 16/8 = 2 m/s². The area under the graph gives displacement. Always calculate gradient as rise over run using two points on the line.$t$
WHERE id = 3390
  AND question_text = $t$A velocity-time graph shows a straight line from \((0,\ 4)\) to \((8,\ 20)\). What does the gradient of this line represent, and what is its value?$t$
  AND option_b = $t$Speed; \(16\,\text{m/s}\)$t$
  AND option_c = $t$Acceleration; \(2\,\text{m/s}^{2}\)$t$
  AND explanation = $t$Gradient of a velocity-time graph = acceleration. Gradient \(= \frac{20 - 4}{8 - 0} = \frac{16}{8} = 2\,\text{m/s}^{2}\). The area under the graph gives displacement. Always calculate gradient as rise over run using two points on the line.$t$;

UPDATE questions SET
  question_text = $t$A skydiver of mass 70 kg reaches terminal velocity. The air resistance force acting on the skydiver is closest to which value?$t$,
  explanation = $t$At terminal velocity, the driving force equals resistive forces so resultant force = 0 and acceleration = 0. Weight = 70 × 9.8 = 686 N ≈ 686 N. At terminal velocity, air resistance exactly equals weight — so air resistance = 686 N.$t$
WHERE id = 3391
  AND question_text = $t$A skydiver of mass \(70\,\text{kg}\) reaches terminal velocity. The air resistance force acting on the skydiver is closest to which value?$t$
  AND explanation = $t$At terminal velocity, the driving force equals resistive forces so resultant force \(= 0\) and acceleration \(= 0\). Weight \(= 70 \times 9.8 = 686\,\text{N} \approx 686\,\text{N}\). At terminal velocity, air resistance exactly equals weight — so air resistance \(= 686\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$A resultant force of 500 N acts on a 25 kg object for 4 seconds, starting from rest. Calculate the final velocity of the object.$t$,
  option_a = $t$50 m/s$t$,
  option_b = $t$80 m/s$t$,
  option_c = $t$20 m/s$t$,
  option_d = $t$400 m/s$t$,
  explanation = $t$a = F ÷ m = 500 ÷ 25 = 20 m/s². From rest, v = u + at = 0 + 20 × 4 = 80 m/s.$t$
WHERE id = 3392
  AND question_text = $t$A resultant force of 500 N acts on \(a\) \(25\,\text{kg}\) object for 4 seconds, starting from rest. Calculate the final velocity of the object.$t$
  AND option_a = $t$\(50\,\text{m/s}\)$t$
  AND option_b = $t$\(80\,\text{m/s}\)$t$
  AND option_c = $t$\(20\,\text{m/s}\)$t$
  AND option_d = $t$\(400\,\text{m/s}\)$t$
  AND explanation = $t$\(a = F \div m = 500 \div 25 = 20\,\text{m/s}^{2}\). From rest, \(v = u\)+ at \(= 0 + 20 \times 4 = 80\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$A 5 kg object is moving at 12 m/s. A braking force of 30 N is applied. How long does it take to stop?$t$,
  explanation = $t$Using F = ma to find deceleration: a = F/m = 30/5 = 6 m/s². Time to stop: v = u + at → 0 = 12 − 6t → t = 2 s. Always find acceleration first, then use a kinematics equation to find the required quantity.$t$
WHERE id = 3394
  AND question_text = $t$A \(5\,\text{kg}\) object is moving at \(12\,\text{m/s}\). A braking force of 30 N is applied. How long does it take to stop?$t$
  AND explanation = $t$Using \(F = ma\) to find deceleration: \(a = \frac{F}{m} = \frac{30}{5} = 6\,\text{m/s}^{2}\). Time to stop: \(v = u\)+ at →\(0 = 12 - 6t \to t = 2\,\text{s}\). Always find acceleration first, then use a kinematics equation to find the required quantity.$t$;

UPDATE questions SET
  option_a = $t$16000 kg m/s$t$,
  option_b = $t$16 N s$t$,
  option_c = $t$40 N s$t$,
  option_d = $t$0.4 N s$t$,
  explanation = $t$Impulse = force × time = change in momentum = m(v−u). Here F×t = 800 × 0.05 = 40 N s. Impulse equals the change in momentum — increasing the contact time reduces the force for the same impulse (the principle behind padding and crumple zones).$t$
WHERE id = 3395
  AND option_a = $t$\(16000\,\text{kg m/s}\)$t$
  AND option_b = $t$16 N \(s\)$t$
  AND option_c = $t$40 N \(s\)$t$
  AND option_d = $t$0.4 N \(s\)$t$
  AND explanation = $t$Impulse = force × time = change in momentum \(= m(v - u)\). Here \(F \times t = 800 \times 0.05 = 40\,\text{N}\ s\). Impulse equals the change in momentum — increasing the contact time reduces the force for the same impulse (the principle behind padding and crumple zones).$t$;

UPDATE questions SET
  question_text = $t$A car travelling at 30 m/s brakes to rest over 60 m. Calculate the deceleration of the car.$t$,
  option_a = $t$0.5 m/s²$t$,
  option_b = $t$7.5 m/s²$t$,
  option_c = $t$15 m/s²$t$,
  option_d = $t$2 m/s²$t$,
  explanation = $t$Using v² = u² + 2as: 0 = 30² + 2×a×60 → a = −900/120 = −7.5 m/s². The negative sign indicates deceleration. Always use v²=u²+2as when you have initial speed, final speed and distance but not time.$t$
WHERE id = 3396
  AND question_text = $t$A car travelling at \(30\,\text{m/s}\) brakes to rest over 60 m. Calculate the deceleration of the car.$t$
  AND option_a = $t$\(0.5\,\text{m/s}^{2}\)$t$
  AND option_b = $t$\(7.5\,\text{m/s}^{2}\)$t$
  AND option_c = $t$\(15\,\text{m/s}^{2}\)$t$
  AND option_d = $t$\(2\,\text{m/s}^{2}\)$t$
  AND explanation = $t$Using \(v^{2} = u^{2} + 2as\): \(0 = 30^{2} + 2 \times a \times 60 \to a = - \frac{900}{120} = -7.5\,\text{m/s}^{2}\). The negative sign indicates deceleration. Always use \(v^{2} = u^{2} + 2as\) when you have initial speed, final speed and distance but not time.$t$;

UPDATE questions SET
  explanation = $t$Alpha decay removes 2 protons and 2 neutrons. U-238 (Z=92, A=238): new Z = 92−2 = 90 (thorium), new A = 238−4 = 234. The daughter nucleus is Th-234: proton number 90, mass number 234.$t$
WHERE id = 3397
  AND explanation = $t$Alpha decay removes 2 protons and 2 neutrons. \(U - 238 (Z = 92,\ A = 238)\): new \(Z = 92 - 2 = 90\) (thorium), new \(A = 238 - 4 = 234\). The daughter nucleus is Th\(- 234\): proton number 90, mass number 234.$t$;

UPDATE questions SET
  explanation = $t$Half-life of 8 days. Count the number of half-lives elapsed: find from context. If initial activity = 640 Bq and answer is 40 Bq: 640 → 320 → 160 → 80 → 40 = 4 half-lives = 32 days. Apply repeated halving — one halving per half-life period.$t$
WHERE id = 3398
  AND explanation = $t$Half-life of 8 days. Count the number of half-lives elapsed: find from context. If initial activity \(= 640\) Bq and answer is 40 Bq: \(640 \to 320 \to 160 \to 80 \to 40 = 4\) half-lives \(= 32\) days. Apply repeated halving — one halving per half-life period.$t$;

UPDATE questions SET
  explanation = $t$Each fission of U-235 releases 2–3 neutrons. These neutrons trigger further fission events in neighbouring U-235 nuclei, each releasing more neutrons — an exponential chain reaction. A critical mass is needed to sustain the chain reaction; control rods absorb excess neutrons to regulate it.$t$
WHERE id = 3400
  AND explanation = $t$Each fission of \(U - 235\) releases 2–3 neutrons. These neutrons trigger further fission events in neighbouring \(U - 235\) nuclei, each releasing more neutrons — an exponential chain reaction. A critical mass is needed to sustain the chain reaction; control rods absorb excess neutrons to regulate it.$t$;

UPDATE questions SET
  explanation = $t$Corrected count rate = measured count rate − background count rate. Background = 40 counts/min (given). Measured = 360. Subtract background first, then apply half-life calculations to the corrected count rate only. Always subtract background before interpreting activity data.$t$
WHERE id = 3401
  AND explanation = $t$Corrected count rate = measured count rate − background count rate. Background \(= 40\) counts/min (given). Measured \(= 360\). Subtract background first, then apply half-life calculations to the corrected count rate only. Always subtract background before interpreting activity data.$t$;

UPDATE questions SET
  explanation = $t$Alpha particles are large (helium nuclei), positively charged and relatively slow-moving. They interact strongly with matter — knocking electrons from atoms (ionisation). This frequent interaction also means they lose energy quickly and cannot travel far through air or tissue. High ionising power = low penetrating power.$t$
WHERE id = 3402
  AND explanation = $t$Alpha particles are large (helium nuclei), positively charged and relatively slow-moving. They interact strongly with matter — knocking electrons from atoms (ionisation). This frequent interaction also means they lose energy quickly and cannot travel far through air or tissue. High ionising power \(= low\) penetrating power.$t$;

UPDATE questions SET
  explanation = $t$C-14 half-life = 5700 years. If a sample has 1/4 of its original C-14 remaining, it has gone through 2 half-lives: ½ → ¼. Time = 2 × 5700 = 11400 years. Count the number of halvings needed to reach the measured fraction, then multiply by the half-life.$t$
WHERE id = 3403
  AND explanation = $t$\(C - 14\) half-life \(= 5700\) years. If a sample has \(\frac{1}{4}\) of its original \(C - 14\) remaining, it has gone through 2 half-lives: \(\tfrac{1}{2} \to \tfrac{1}{4}\). Time \(= 2 \times 5700 = 11400\) years. Count the number of halvings needed to reach the measured fraction, then multiply by the half-life.$t$;

UPDATE questions SET
  explanation = $t$In nuclear fusion, the product (helium nucleus) has less mass than the combined mass of the two hydrogen isotopes. This mass deficit is converted directly to energy by E = mc². The enormous value of c² means even a tiny mass difference releases a huge amount of energy.$t$
WHERE id = 3404
  AND explanation = $t$In nuclear fusion, the product (helium nucleus) has less mass than the combined mass of the two hydrogen isotopes. This mass deficit is converted directly to energy by \(E = mc^{2}\). The enormous value of \(c^{2}\) means even a tiny mass difference releases a huge amount of energy.$t$;

UPDATE questions SET
  explanation = $t$Thorium-234 (Z=90, A=234) undergoes beta-minus decay: a neutron → proton + electron. Proton number increases by 1 (90+1=91), mass number unchanged (234). The daughter nucleus is protactinium-234: proton number 91, mass number 234.$t$
WHERE id = 3405
  AND explanation = $t$Thorium-234 \((Z = 90,\ A = 234)\) undergoes beta-minus decay: a neutron → proton + electron. Proton number increases by \(1 (90 + 1 = 91)\), mass number unchanged (234). The daughter nucleus is protactinium-234: proton number 91, mass number 234.$t$;

UPDATE questions SET
  explanation = $t$For a balanced beam: clockwise moment = anticlockwise moment. 600 × 1.0 = F × (2.0−?) ... Using the specific numbers: 600 N at 1.5 m from centre on left = 600×1.5=900 Nm. F × ? = 900. With the given answer of 90 N, the distance must be 10 m — or check: the beam is 4 m, pivot at centre (2 m from each end). 60 N at 1.5 m from pivot: 60×1.5=90 Nm. For balance: F × d = 90 Nm. If F = 90 N then d = 1 m. Apply principle of moments: clockwise = anticlockwise.$t$
WHERE id = 3417
  AND explanation = $t$For a balanced beam: clockwise moment = anticlockwise moment. \(600 \times 1.0 = F \times\) (2.0−?) ... Using the specific numbers: 600 N at 1.5 m from centre on left \(= 600 \times 1.5 = 900\) Nm. F × ? \(= 900\). With the given answer of 90 N, the distance must be 10 m — or check: the beam is 4 m, pivot at centre (2 m from each end). 60 N at 1.5 m from pivot: \(60 \times 1.5 = 90\) Nm. For balance: \(F \times d = 90\) Nm. If \(F = 90\,\text{N}\) then \(d = 1\,\text{m}\). Apply principle of moments: clockwise = anticlockwise.$t$;

UPDATE questions SET
  option_a = $t$k = 200 N/m, extension = 0.06 m$t$,
  option_b = $t$k = 200 N/m, extension = 0.12 m$t$,
  option_c = $t$k = 300 N/m, extension = 0.12 m$t$,
  option_d = $t$k = 300 N/m, extension = 0.18 m$t$,
  explanation = $t$k = F/x = 24/0.08 = 300 N/m. For the second part: x = F/k = 36/300 = 0.12 m. Use Hooke's Law F=kx to find k, then rearrange to find the new extension. Always convert cm to metres before applying the formula.$t$
WHERE id = 3418
  AND option_a = $t$\(k = 200\,\text{N/m}\), extension \(= 0.06\,\text{m}\)$t$
  AND option_b = $t$\(k = 200\,\text{N/m}\), extension \(= 0.12\,\text{m}\)$t$
  AND option_c = $t$\(k = 300\,\text{N/m}\), extension \(= 0.12\,\text{m}\)$t$
  AND option_d = $t$\(k = 300\,\text{N/m}\), extension \(= 0.18\,\text{m}\)$t$
  AND explanation = $t$\(k = \frac{F}{x} = \frac{24}{0.08} = 300\,\text{N/m}\). For the second part: \(x = \frac{F}{k} = \frac{36}{300} = 0.12\,\text{m}\). Use Hooke's Law \(F = kx\) to find \(k\), then rearrange to find the new extension. Always convert cm to metres before applying the formula.$t$;

UPDATE questions SET
  option_a = $t$1400 N m$t$,
  option_b = $t$350 N m$t$,
  option_c = $t$700 N m$t$,
  option_d = $t$3500 N m$t$,
  explanation = $t$Moment = force × perpendicular distance from pivot = 700 × 2 = 1400 N m. The diver's weight acts at the end of the board, 2 m from the pivot (edge of pool). Moment = force × distance — always use perpendicular distance.$t$
WHERE id = 3419
  AND option_a = $t$1400 N \(m\)$t$
  AND option_b = $t$350 N \(m\)$t$
  AND option_c = $t$700 N \(m\)$t$
  AND option_d = $t$3500 N \(m\)$t$
  AND explanation = $t$Moment = force × perpendicular distance from pivot \(= 700 \times 2 = 1400\,\text{N}\ m\). The diver's weight acts at the end of the board, 2 m from the pivot (edge of pool). Moment = force × distance — always use perpendicular distance.$t$;

UPDATE questions SET
  question_text = $t$A hydraulic system has a small piston of area 0.002 m² and a large piston of area 0.05 m². A force of 40 N is applied to the small piston. What is the force exerted by the large piston?$t$,
  explanation = $t$Hydraulic system: pressure is transmitted equally throughout the fluid. Pressure = F_in/A_in = 20/0.002 = 10 000 Pa. Force out = pressure × A_out = 10 000 × 0.1 = 1000 N. The output force is amplified because the output piston has a much larger area.$t$
WHERE id = 3420
  AND question_text = $t$A hydraulic system has a small piston of area \(0.002 m^{2}\) and a large piston of area \(0.05 m^{2}\). A force of 40 N is applied to the small piston. What is the force exerted by the large piston?$t$
  AND explanation = $t$Hydraulic system: pressure is transmitted equally throughout the fluid. Pressure \(= F\)_in/A_in \(= \frac{20}{0.002} = 10\,000\,\text{Pa}\). Force out = pressure × A_\(out = 10\,000 \times 0.1 = 1000\,\text{N}\). The output force is amplified because the output piston has a much larger area.$t$;

UPDATE questions SET
  question_text = $t$A steel spring has a spring constant of 400 N/m. It is compressed by 0.05 m. Calculate the elastic potential energy stored in the spring.$t$,
  explanation = $t$Elastic PE = ½kx² = ½ × 400 × 0.05² = ½ × 400 × 0.0025 = 0.5 J. Square the extension (0.05² = 0.0025) first, then multiply by ½k. Forgetting the ½ or using compression in cm are the most common errors.$t$
WHERE id = 3421
  AND question_text = $t$A steel spring has a spring constant of \(400\,\text{N/m}\). It is compressed by 0.05 m. Calculate the elastic potential energy stored in the spring.$t$
  AND explanation = $t$Elastic \(PE = \tfrac{1}{2}kx^{2} = \tfrac{1}{2} \times 400 \times 0.05^{2} = \tfrac{1}{2} \times 400 \times 0.0025 = 0.5\,\text{J}\). Square the extension \((0.05^{2} = 0.0025)\) first, then multiply by \(\tfrac{1}{2}k\). Forgetting the \(\tfrac{1}{2}\) or using compression in cm are the most common errors.$t$;

UPDATE questions SET
  option_b = $t$Weight × 2 = reaction × 5$t$,
  option_c = $t$Reaction × 2 = weight × 5$t$,
  option_d = $t$Weight × 5 = reaction × 2$t$
WHERE id = 3422
  AND option_b = $t$\(\text{Weight} \times 2\)= reaction \(\times 5\)$t$
  AND option_c = $t$\(\text{Reaction} \times 2\)= weight \(\times 5\)$t$
  AND option_d = $t$\(\text{Weight} \times 5\)= reaction \(\times 2\)$t$;

UPDATE questions SET
  question_text = $t$A pressure of 200 000 Pa acts on a surface of area 0.03 m². What is the force acting on this surface?$t$,
  explanation = $t$Force = pressure × area = 200 000 × 0.03 = 6000 N. Always multiply pressure (Pa) by area (m²) to get force in newtons. This is the rearrangement of P = F/A → F = PA.$t$
WHERE id = 3423
  AND question_text = $t$A pressure of 200 000 Pa acts on a surface of area \(0.03 m^{2}\). What is the force acting on this surface?$t$
  AND explanation = $t$Force = pressure × area \(= 200\,000 \times 0.03 = 6000\,\text{N}\). Always multiply pressure (Pa) by area \((m^{2})\) to get force in newtons. This is the rearrangement of \(P = \frac{F}{A} \to F = PA\).$t$;

UPDATE questions SET
  question_text = $t$A 5 kg object rests on a surface and experiences a pressure of 250 Pa from gravity. What is the area of contact between the object and the surface? (g = 10 N/kg)$t$,
  option_a = $t$5 m²$t$,
  option_b = $t$0.2 m²$t$,
  option_c = $t$2 m²$t$,
  option_d = $t$0.5 m²$t$,
  explanation = $t$Area = Force ÷ Pressure = (5×10) ÷ 250 = 50/250 = 0.2 m². Weight = mg = 5×10 = 50 N. Rearranging P = F/A gives A = F/P = 50/250 = 0.2 m². Always use weight (mg) as the force in pressure calculations involving objects resting on surfaces.$t$
WHERE id = 3425
  AND question_text = $t$A \(5\,\text{kg}\) object rests on a surface and experiences a pressure of 250 Pa from gravity. What is the area of contact between the object and the surface? (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(5 m^{2}\)$t$
  AND option_b = $t$\(0.2 m^{2}\)$t$
  AND option_c = $t$\(2 m^{2}\)$t$
  AND option_d = $t$\(0.5 m^{2}\)$t$
  AND explanation = $t$Area = Force ÷ Pressure \(= (5 \times 10) \div 250 = \frac{50}{250} = 0.2 m^{2}\). Weight \(= mg = 5 \times 10 = 50\,\text{N}\). Rearranging \(P = \frac{F}{A}\) gives \(A = \frac{F}{P} = \frac{50}{250} = 0.2 m^{2}\). Always use weight (mg) as the force in pressure calculations involving objects resting on surfaces.$t$;

UPDATE questions SET
  explanation = $t$For perpendicular forces, use Pythagoras: resultant = √(6² + 8²) = √(36+64) = √100 = 10 N. The direction: tan θ = 8/6, θ = 53° east of north. Simply adding the forces (14 N) is wrong — only valid when forces act in the same direction.$t$
WHERE id = 3426
  AND explanation = $t$For perpendicular forces, use Pythagoras: resultant \(= \sqrt{6^{2} + 8^{2}} = \sqrt{36 + 64} = \sqrt{100} = 10\,\text{N}\). The direction: \(\tan \theta = \frac{8}{6}\), \(\theta = 53^\circ\) east of north. Simply adding the forces (14 N) is wrong — only valid when forces act in the same direction.$t$;

UPDATE questions SET
  explanation = $t$Series circuit: total R = 6+12+4 = 22 Ω. Current = V/R = 44/22 = 2 A. In series, all components carry the same current and resistances add directly. Verify: V across each = 2×6=12, 2×12=24, 2×4=8; total = 12+24+8 = 44 V ✓.$t$
WHERE id = 3427
  AND explanation = $t$Series circuit: total \(R = 6 + 12 + 4 = 22\) Ω. Current \(= \frac{V}{R} = \frac{44}{22} = 2\,\text{A}\). In series, all components carry the same current and resistances add directly. Verify: V across each \(= 2 \times 6 = 12\), \(2 \times 12 = 24\), \(2 \times 4 = 8\); total \(= 12 + 24 + 8 = 44\,\text{V} \checkmark\).$t$;

UPDATE questions SET
  option_a = $t$I = 2.5 A, R = 960 Ω$t$,
  option_b = $t$I = 0.25 A, R = 960 Ω$t$,
  option_c = $t$I = 4 A, R = 60 Ω$t$,
  option_d = $t$I = 0.25 A, R = 240 Ω$t$,
  explanation = $t$I = P/V = 60/240 = 0.25 A. R = V/I = 240/0.25 = 960 Ω. Use P=IV to find current, then Ohm's law V=IR to find resistance. The filament lamp has a very high resistance when hot — much higher than when cold.$t$
WHERE id = 3428
  AND option_a = $t$\(I = 2.5\,\text{A}\), \(R = 960\) Ω$t$
  AND option_b = $t$\(I = 0.25\,\text{A}\), \(R = 960\) Ω$t$
  AND option_c = $t$\(I = 4\,\text{A}\), \(R = 60\) Ω$t$
  AND option_d = $t$\(I = 0.25\,\text{A}\), \(R = 240\) Ω$t$
  AND explanation = $t$\(I = \frac{P}{V} = \frac{60}{240} = 0.25\,\text{A}\). \(R = \frac{V}{I} = \frac{240}{0.25} = 960\) Ω. Use P=IV to find current, then Ohm's law \(V = IR\) to find resistance. The filament lamp has a very high resistance when hot — much higher than when cold.$t$;

UPDATE questions SET
  explanation = $t$Three identical 12 Ω resistors in parallel: 1/R_total = 1/12 + 1/12 + 1/12 = 3/12 → R_total = 4 Ω. Total current = V/R = 12/4 = 3 A. In parallel, each branch has the same voltage across it, and total current is the sum of branch currents: 1+1+1 = 3 A.$t$
WHERE id = 3430
  AND explanation = $t$Three identical 12 Ω resistors in parallel: \(\frac{1}{R}\)_total \(= \frac{1}{12} + \frac{1}{12} + \frac{1}{12} = \frac{3}{12} \to R\)_total \(= 4\) Ω. Total current \(= \frac{V}{R} = \frac{12}{4} = 3\,\text{A}\). In parallel, each branch has the same voltage across it, and total current is the sum of branch currents: \(1 + 1 + 1 = 3\,\text{A}\).$t$;

UPDATE questions SET
  explanation = $t$Current = Q/t = 180/60 = 3 A. Voltage = 10 V (given context). Power = IV = 3 × 10 = 30 W. Alternatively P = QV/t. Always find current first (I = Q/t), then power (P = IV).$t$
WHERE id = 3431
  AND explanation = $t$Current \(= \frac{Q}{t} = \frac{180}{60} = 3\,\text{A}\). Voltage \(= 10\,\text{V}\) (given context). Power \(= IV = 3 \times 10 = 30\,\text{W}\). Alternatively \(P = \frac{QV}{t}\). Always find current first \((I = \frac{Q}{t})\), then power \((P = IV)\).$t$;

UPDATE questions SET
  explanation = $t$Energy = Power × time = 2000 W × (3×3600 s) = 2000 × 10 800 = 21 600 000 J = 21.6 MJ. In kWh: 2 kW × 3 h = 6 kWh. Both units are valid — kWh is used on electricity bills; joules for calculations. 1 kWh = 3 600 000 J.$t$
WHERE id = 3433
  AND explanation = $t$Energy = Power × time \(= 2000\,\text{W} \times (3 \times 3600\,\text{s}) = 2000 \times 10\,800 = 21\,600\,000 J = 21.6\,\text{MJ}\). In kWh: \(2\,\text{kW} \times 3 h = 6\,\text{kWh}\). Both units are valid — kWh is used on electricity bills; joules for calculations. \(1\,\text{kWh} = 3\,600\,000 J\).$t$;

UPDATE questions SET
  question_text = $t$Two resistors, R1 = 8 Ω and R2 = 24 Ω, are connected in parallel. Calculate their combined resistance.$t$,
  explanation = $t$1/R_total = 1/R₁ + 1/R₂ = 1/8 + 1/24 = 3/24 + 1/24 = 4/24 → R_total = 6 Ω. In parallel, total resistance is always less than the smallest individual resistor (less than 8 Ω here). Check: 1/6 = 1/8 + 1/24 = 3/24 + 1/24 = 4/24 = 1/6 ✓.$t$
WHERE id = 3434
  AND question_text = $t$Two resistors, \(R_{1} = 8\) Ω and \(R_{2} = 24\) Ω, are connected in parallel. Calculate their combined resistance.$t$
  AND explanation = $t$\(\frac{1}{R}\)_total \(= 1\)/R₁ \(+ 1\)/R₂ \(= \frac{1}{8} + \frac{1}{24} = \frac{3}{24} + \frac{1}{24} = \frac{4}{24} \to R\)_total \(= 6\) Ω. In parallel, total resistance is always less than the smallest individual resistor (less than 8 Ω here). Check: \(\frac{1}{6} = \frac{1}{8} + \frac{1}{24} = \frac{3}{24} + \frac{1}{24} = \frac{4}{24} = \frac{1}{6} \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$Current = P/V = 2600/230 ≈ 11.3 A. A 13 A fuse would not blow at this current (11.3 < 13). However, a fault causing higher current should blow the fuse — check whether the question asks if it protects correctly. The 13 A fuse is the correct rating (next standard size above 11.3 A).$t$
WHERE id = 3435
  AND explanation = $t$Current \(= \frac{P}{V} = \frac{2600}{230} \approx 11.3\,\text{A}\). A 13 A fuse would not blow at this current \((11.3 < 13)\). However, a fault causing higher current should blow the fuse — check whether the question asks if it protects correctly. The 13 A fuse is the correct rating (next standard size above 11.3 A).$t$;

UPDATE questions SET
  explanation = $t$F = BIL = 0.4 × 5 × 0.3 = 0.6 N. All three factors — magnetic flux density (B), current (I) and length in field (L) — are multiplied. Check units: T × A × m = N.$t$
WHERE id = 3438
  AND explanation = $t$\(F = BIL = 0.4 \times 5 \times 0.3 = 0.6\,\text{N}\). All three factors — magnetic flux density (B), current (I) and length in field (L) — are multiplied. Check units: \(T \times A \times m = N\).$t$;

UPDATE questions SET
  question_text = $t$A rectangular coil with 50 turns carries a current of 2 A in a magnetic field of 0.3 T. The coil has dimensions 0.1 m × 0.2 m. Calculate the maximum torque on the coil.$t$,
  option_a = $t$0.12 N m$t$,
  option_b = $t$0.6 N m$t$,
  option_c = $t$3 N m$t$,
  option_d = $t$6 N m$t$,
  explanation = $t$Torque = F × d = BIL × (width/2) × 2 × N turns. With 50 turns and B=0.06T, I=2A, L=0.1m, width=0.1m: F on each side = BIL×N = 0.06×2×0.1×50 = 0.6 N. Torque = F × half-width × 2 = 0.6 × 0.05 × 2 = 0.06 Nm... the answer is 0.6 Nm so verify with the given values.$t$
WHERE id = 3440
  AND question_text = $t$A rectangular coil with 50 turns carries a current of 2 A in a magnetic field of 0.3 T. The coil has dimensions \(0.1\,\text{m} \times 0.2\,\text{m}\). Calculate the maximum torque on the coil.$t$
  AND option_a = $t$0.12 N \(m\)$t$
  AND option_b = $t$0.6 N \(m\)$t$
  AND option_c = $t$3 N \(m\)$t$
  AND option_d = $t$6 N \(m\)$t$
  AND explanation = $t$Torque \(= F \times d = BIL \times\) (width/2) \(\times 2 \times N\) turns. With 50 turns and \(B = 0.06T\), \(I = 2A\), \(L = 0.1m\), width\(= 0.1m\): F on each side \(= BIL \times N = 0.06 \times 2 \times 0.1 \times 50 = 0.6 N\). Torque \(= F\)× half-width \(\times 2 = 0.6 \times 0.05 \times 2 = 0.06\) Nm... the answer is 0.6 Nm so verify with the given values.$t$;

UPDATE questions SET
  explanation = $t$The force F = BIL: increasing B (field strength), I (current) or L (length in field) all increase the force. Increasing the strength of the magnetic field WOULD increase the force — so "would NOT increase" is the option that mentions something that doesn't affect it, like changing the material of the wire.$t$
WHERE id = 3441
  AND explanation = $t$The force \(F = BIL\): increasing B (field strength), I (current) or L (length in field) all increase the force. Increasing the strength of the magnetic field WOULD increase the force — so "would NOT increase" is the option that mentions something that doesn't affect it, like changing the material of the wire.$t$;

UPDATE questions SET
  explanation = $t$In a loudspeaker, alternating current reverses direction rapidly. Each reversal reverses the force on the coil (F=BIL, direction from Fleming's Left-Hand Rule). The coil oscillates back and forth, moving the cone and creating pressure variations in the air — sound waves matching the input signal frequency.$t$
WHERE id = 3443
  AND explanation = $t$In a loudspeaker, alternating current reverses direction rapidly. Each reversal reverses the force on the coil (\(F = BIL\), direction from Fleming's Left-Hand Rule). The coil oscillates back and forth, moving the cone and creating pressure variations in the air — sound waves matching the input signal frequency.$t$;

UPDATE questions SET
  explanation = $t$Magnetic flux density (B) describes the strength of a magnetic field at a point — it is measured in Tesla (T). It represents the force per unit length per unit current on a conductor perpendicular to the field (F=BIL). A stronger field has greater flux density.$t$
WHERE id = 3444
  AND explanation = $t$Magnetic flux density (B) describes the strength of a magnetic field at a point — it is measured in Tesla (T). It represents the force per unit length per unit current on a conductor perpendicular to the field \((F = BIL)\). A stronger field has greater flux density.$t$;

UPDATE questions SET
  explanation = $t$The induced EMF depends on the rate of change of magnetic flux (Faraday's Law: EMF = −dΦ/dt). Factors increasing EMF: moving faster, stronger magnet, more turns on coil. The direction of induced EMF is given by Lenz's Law — it opposes the change causing it.$t$
WHERE id = 3447
  AND explanation = $t$The induced EMF depends on the rate of change of magnetic flux (Faraday's Law: \(EMF = - d\)Φ/dt). Factors increasing EMF: moving faster, stronger magnet, more turns on coil. The direction of induced EMF is given by Lenz's Law — it opposes the change causing it.$t$;

UPDATE questions SET
  explanation = $t$Using Vs/Vp = Ns/Np: Vs = 230 × (80/1600) = 230 × 0.05 = 11.5 V. This is a step-down transformer — fewer secondary turns means lower secondary voltage. Always check whether it is step-up or step-down by comparing turn numbers.$t$
WHERE id = 3448
  AND explanation = $t$Using Vs/Vp = Ns/Np: Vs \(= 230 \times (\frac{80}{1600}) = 230 \times 0.05 = 11.5\,\text{V}\). This is a step-down transformer — fewer secondary turns means lower secondary voltage. Always check whether it is step-up or step-down by comparing turn numbers.$t$;

UPDATE questions SET
  explanation = $t$Faraday's Law: the induced EMF in a conductor is directly proportional to the rate of change of magnetic flux linkage through it. EMF = −N × dΦ/dt. Greater rate of change (faster movement or stronger field) produces a larger induced EMF.$t$
WHERE id = 3449
  AND explanation = $t$Faraday's Law: the induced EMF in a conductor is directly proportional to the rate of change of magnetic flux linkage through it. \(EMF = - N \times d\)Φ/dt. Greater rate of change (faster movement or stronger field) produces a larger induced EMF.$t$;

UPDATE questions SET
  explanation = $t$For a 100% efficient transformer, power in = power out: Vp × Ip = Vs × Is. 25 × 4 = 250 × Is, so Is = 100 ÷ 250 = 0.4 A. Stepping the voltage up by 10 times steps the current down by 10 times.$t$
WHERE id = 3450
  AND explanation = $t$For a 100% efficient transformer, power in = power out: Vp × Ip = Vs × Is. \(25 \times 4 = 250\)× Is, so Is \(= 100 \div 250 = 0.4\,\text{A}\). Stepping the voltage up by 10 times steps the current down by 10 times.$t$;

UPDATE questions SET
  option_b = $t$Power loss in cables is proportional to I²R; reducing current dramatically reduces heat loss in the transmission cables$t$,
  explanation = $t$Power loss = I²R. For the same power transmitted (P=IV), higher voltage means lower current. Lower current reduces I²R losses dramatically — power loss is proportional to I². Doubling voltage halves current and reduces power loss to one quarter.$t$
WHERE id = 3451
  AND option_b = $t$Power loss in cables is proportional to \(I^{2}R\); reducing current dramatically reduces heat loss in the transmission cables$t$
  AND explanation = $t$Power loss \(= I^{2}R\). For the same power transmitted (P=IV), higher voltage means lower current. Lower current reduces \(I^{2}R\) losses dramatically — power loss is proportional to \(I^{2}\). Doubling voltage halves current and reduces power loss to one quarter.$t$;

UPDATE questions SET
  explanation = $t$For 95% efficient transformer: output power = 0.95 × input power = 0.95 × 240 = 228 W. Or: input power = VpIp = 240 × 1 = 240 W (using given primary values). Output = 0.95 × 240 = 228 W. Efficiency = output/input × 100; rearrange to find output power.$t$
WHERE id = 3454
  AND explanation = $t$For 95% efficient transformer: output power \(= 0.95\)× input power \(= 0.95 \times 240 = 228\,\text{W}\). Or: input power = VpIp \(= 240 \times 1 = 240\,\text{W}\) (using given primary values). Output \(= 0.95 \times 240 = 228\,\text{W}\). Efficiency = output/input \(\times 100\); rearrange to find output power.$t$;

UPDATE questions SET
  question_text = $t$Calculate the energy needed to heat 2.5 kg of water from 20°C to 100°C. (Specific heat capacity of water = 4200 J/kg°C)$t$,
  explanation = $t$E = mcΔT = 2.5 × 4200 × (100−20) = 2.5 × 4200 × 80 = 840 000 J. Three quantities multiplied: mass (kg), specific heat capacity (J/kg°C) and temperature change (ΔT in °C). Using final temperature (100) instead of change (80) is the most common error.$t$
WHERE id = 3457
  AND question_text = $t$Calculate the energy needed to heat \(2.5\,\text{kg}\) of water from \(20^\circ C\) to \(100^\circ C\). (Specific heat capacity of water = \(4200\,\text{J/kg°C}\))$t$
  AND explanation = $t$\(E = mc\)Δ\(T = 2.5 \times 4200 \times (100 - 20) = 2.5 \times 4200 \times 80 = 840\,000\,\text{J}\). Three quantities multiplied: mass (kg), specific heat capacity (J/kg°C) and temperature change (ΔT in °C). Using final temperature (100) instead of change (80) is the most common error.$t$;

UPDATE questions SET
  question_text = $t$A 500 g block of ice at 0°C melts completely to water at 0°C. Calculate the energy needed. (Specific latent heat of fusion of water = 334 000 J/kg)$t$,
  explanation = $t$Energy = mass × specific latent heat of fusion = 0.5 × 334 000 = 167 000 J. The specific latent heat of fusion of ice is 334 000 J/kg (given or recalled). During melting, temperature stays at 0°C — all energy goes into breaking hydrogen bonds between water molecules.$t$
WHERE id = 3458
  AND question_text = $t$A \(500\,\text{g}\) block of ice at \(0^\circ C\) melts completely to water at \(0^\circ C\). Calculate the energy needed. (Specific latent heat of fusion of water = \(334\,000\,\text{J/kg}\))$t$
  AND explanation = $t$Energy = mass × specific latent heat of fusion \(= 0.5 \times 334\,000 = 167\,000\,\text{J}\). The specific latent heat of fusion of ice is \(334\,000\,\text{J/kg}\) (given or recalled). During melting, temperature stays at \(0^\circ C\) — all energy goes into breaking hydrogen bonds between water molecules.$t$;

UPDATE questions SET
  question_text = $t$A sealed container holds an ideal gas at a pressure of 100 000 Pa and volume of 0.02 m³. The gas is compressed at constant temperature to a volume of 0.008 m³. Calculate the new pressure.$t$,
  explanation = $t$At constant volume: P/T = constant (temperatures in Kelvin). P₂ = P₁ × T₂/T₁. T₁ = 300 K, P₁ = 100 000 Pa. If T₂ = 750 K: P₂ = 100 000 × 750/300 = 250 000 Pa. Always convert Celsius to Kelvin before applying gas laws.$t$
WHERE id = 3459
  AND question_text = $t$A sealed container holds an ideal gas at a pressure of 100 000 Pa and volume of \(0.02 m^{3}\). The gas is compressed at constant temperature to a volume of \(0.008 m^{3}\). Calculate the new pressure.$t$
  AND explanation = $t$At constant volume: \(\frac{P}{T}\)= constant (temperatures in Kelvin). P₂ = P₁ × T₂/T₁. T₁ \(= 300\,\text{K}\), P₁ \(= 100\,000\,\text{Pa}\). If T₂ \(= 750\,\text{K}\): P₂ \(= 100\,000 \times \frac{750}{300} = 250\,000\,\text{Pa}\). Always convert Celsius to Kelvin before applying gas laws.$t$;

UPDATE questions SET
  question_text = $t$A gas in a cylinder has a volume of 3 × 10⁻³ m³ at a pressure of 2 × 10⁵ Pa and temperature of 300 K. The temperature is raised to 450 K at constant pressure. Calculate the new volume.$t$,
  option_a = $t$4.5 × 10⁻³ m³$t$,
  option_b = $t$2 × 10⁻³ m³$t$,
  option_c = $t$6 × 10⁻³ m³$t$,
  option_d = $t$1.5 × 10⁻³ m³$t$,
  explanation = $t$Boyle's Law (constant temperature): P₁V₁ = P₂V₂. V₂ = P₁V₁/P₂ = (2×10⁵ × 3×10⁻³)/(2×10⁵ × 2/3)... Check: P₁=2×10⁵, V₁=3×10⁻³. If P₂=(4/3)×10⁵: V₂ = 2×10⁵ × 3×10⁻³ / (4/3)×10⁵ = 6×10⁻² / (4/3)×10⁵... use P₁V₁=P₂V₂ to find the new volume.$t$
WHERE id = 3461
  AND question_text = $t$A gas in a cylinder has a volume of \(3 \times 10^{-3} m^{3}\) at a pressure of \(2 \times 10^{5}\,\text{Pa}\) and temperature of 300 K. The temperature is raised to 450 K at constant pressure. Calculate the new volume.$t$
  AND option_a = $t$\(4.5 \times 10^{-3} m^{3}\)$t$
  AND option_b = $t$\(2 \times 10^{-3} m^{3}\)$t$
  AND option_c = $t$\(6 \times 10^{-3} m^{3}\)$t$
  AND option_d = $t$\(1.5 \times 10^{-3} m^{3}\)$t$
  AND explanation = $t$Boyle's Law (constant temperature): P₁V₁ = P₂V₂. V₂ = P₁V₁/P₂ \(= \frac{2 \times 10^{5} \times 3 \times 10^{-3}}{(2 \times 10^{5} \times \frac{2}{3})\ldots}\) Check: P₁\(= 2 \times 10^{5}\), V₁\(= 3 \times 10^{-3}\). If P₂\(= (\frac{4}{3}) \times 10^{5}\): V₂ \(= 2 \times 10^{5} \times 3 \times \frac{10^{-3}}{\frac{4}{3}} \times 10^{5} = 6 \times \frac{10^{-2}}{\frac{4}{3}} \times 10^{5}\ldots\) use P₁V₁=P₂V₂ to find the new volume.$t$;

UPDATE questions SET
  explanation = $t$P/T = constant at constant volume (pressures in Pa, temperatures in Kelvin). P₂ = P₁ × T₂/T₁. T₁ = 300 K (27°C + 273), P₁ = 120 000 Pa. T₂ = 400 K (127°C + 273). P₂ = 120 000 × 400/300 = 160 000 Pa.$t$
WHERE id = 3462
  AND explanation = $t$\(\frac{P}{T}\)= constant at constant volume (pressures in Pa, temperatures in Kelvin). P₂ = P₁ × T₂/T₁. T₁ \(= 300\,\text{K}\ (27^\circ C + 273)\), P₁ \(= 120\,000\,\text{Pa}\). T₂ \(= 400\,\text{K}\ (127^\circ C + 273)\). P₂ \(= 120\,000 \times \frac{400}{300} = 160\,000\,\text{Pa}\).$t$;

UPDATE questions SET
  question_text = $t$How much thermal energy is released when 0.2 kg of steam at 100°C condenses to water at 100°C? (Specific latent heat of vaporisation of water = 2 260 000 J/kg)$t$,
  explanation = $t$Condensation releases latent heat: E = mL. L_vaporisation of water ≈ 2 260 000 J/kg. E = 0.2 × 2 260 000 = 452 000 J. The same energy is released during condensation as is absorbed during evaporation. Steam condensing releases much more energy than hot water cooling.$t$
WHERE id = 3464
  AND question_text = $t$How much thermal energy is released when \(0.2\,\text{kg}\) of steam at \(100^\circ C\) condenses to water at \(100^\circ C\)? (Specific latent heat of vaporisation of water = \(2\,260\,000\,\text{J/kg}\))$t$
  AND explanation = $t$Condensation releases latent heat: E = mL. L_vaporisation of water ≈ \(2\,260\,000\,\text{J/kg}\). \(E = 0.2 \times 2\,260\,000 = 452\,000\,\text{J}\). The same energy is released during condensation as is absorbed during evaporation. Steam condensing releases much more energy than hot water cooling.$t$;

UPDATE questions SET
  question_text = $t$A student heats 1 kg of a liquid using a 50 W heater for 200 s and measures a temperature rise of 10°C. Calculate the specific heat capacity of the liquid.$t$,
  option_a = $t$1000 J/kg°C$t$,
  option_b = $t$500 J/kg°C$t$,
  option_c = $t$2000 J/kg°C$t$,
  option_d = $t$100 J/kg°C$t$,
  explanation = $t$Specific heat capacity c = Q/(mΔT) = (50×200)/(1×ΔT). The temperature rise must be given to solve this — from context ΔT = 10°C: c = 10000/10 = 1000 J/kg°C. Rearrange E = mcΔT to c = E/(mΔT). Always divide by both mass and temperature change.$t$
WHERE id = 3465
  AND question_text = $t$A student heats \(1\,\text{kg}\) of a liquid using a 50 W heater for 200 s and measures a temperature rise of \(10^\circ C\). Calculate the specific heat capacity of the liquid.$t$
  AND option_a = $t$\(1000\,\text{J/kg°C}\)$t$
  AND option_b = $t$\(500\,\text{J/kg°C}\)$t$
  AND option_c = $t$\(2000\,\text{J/kg°C}\)$t$
  AND option_d = $t$\(100\,\text{J/kg°C}\)$t$
  AND explanation = $t$Specific heat capacity \(c = Q /\)(\(m\)ΔT) \(= (50 \times 200) /\)(1×ΔT). The temperature rise must be given to solve this — from context Δ\(T = 10^\circ C\): \(c = \frac{10000}{10} = 1000\,\text{J/kg°C}\). Rearrange \(E = mc\)ΔT to \(c = E /\)(\(m\)ΔT). Always divide by both mass and temperature change.$t$;

UPDATE questions SET
  option_a = $t$15 m/s$t$,
  option_b = $t$960 m/s$t$,
  option_c = $t$0.07 m/s$t$,
  option_d = $t$128 m/s$t$,
  explanation = $t$Speed = distance ÷ time = 120 ÷ 8 = 15 m/s. Always divide distance by time to find speed. The most common error is multiplying instead of dividing. Check: 15 × 8 = 120 m ✓.$t$
WHERE id = 3577
  AND option_a = $t$\(15\,\text{m/s}\)$t$
  AND option_b = $t$\(960\,\text{m/s}\)$t$
  AND option_c = $t$\(0.07\,\text{m/s}\)$t$
  AND option_d = $t$\(128\,\text{m/s}\)$t$
  AND explanation = $t$Speed = distance ÷ time \(= 120 \div 8 = 15\,\text{m/s}\). Always divide distance by time to find speed. The most common error is multiplying instead of dividing. Check: \(15 \times 8 = 120\,\text{m} \checkmark\).$t$;

UPDATE questions SET
  option_a = $t$180 m/s²$t$,
  option_b = $t$0.2 m/s²$t$,
  option_c = $t$36 m/s²$t$,
  option_d = $t$5 m/s²$t$,
  explanation = $t$a = F/m = 30/6 = 5 m/s². Using Newton's Second Law: F = ma, rearranged to a = F/m. Divide the resultant force by the mass. Check: 6 × 5 = 30 N ✓. The unit of acceleration is m/s².$t$
WHERE id = 3580
  AND option_a = $t$\(180\,\text{m/s}^{2}\)$t$
  AND option_b = $t$\(0.2\,\text{m/s}^{2}\)$t$
  AND option_c = $t$\(36\,\text{m/s}^{2}\)$t$
  AND option_d = $t$\(5\,\text{m/s}^{2}\)$t$
  AND explanation = $t$\(a = \frac{F}{m} = \frac{30}{6} = 5\,\text{m/s}^{2}\). Using Newton's Second Law: \(F = ma\), rearranged to \(a = \frac{F}{m}\). Divide the resultant force by the mass. Check: \(6 \times 5 = 30\,\text{N} \checkmark\). The unit of acceleration is m/\(s^{2}\).$t$;

UPDATE questions SET
  explanation = $t$A horizontal straight line on a distance-time graph means distance is not changing — the object is stationary. A sloped line means the object is moving (steeper = faster). Never confuse distance-time and velocity-time graphs: horizontal line on d-t = stationary; horizontal line on v-t = constant speed.$t$
WHERE id = 3581
  AND explanation = $t$A horizontal straight line on a distance-time graph means distance is not changing — the object is stationary. A sloped line means the object is moving (steeper = faster). Never confuse distance-time and velocity-time graphs: horizontal line on \(d - t\)= stationary; horizontal line on \(v - t\)= constant speed.$t$;

UPDATE questions SET
  explanation = $t$The unit of force is the Newton (N). One Newton is the force needed to accelerate a 1 kg mass at 1 m/s². Other units: speed in m/s, energy in Joules (J), power in Watts (W), pressure in Pascals (Pa). Learning the correct unit for each quantity is essential.$t$
WHERE id = 3582
  AND explanation = $t$The unit of force is the Newton (N). One Newton is the force needed to accelerate \(a\) \(1\,\text{kg}\) mass at \(1\,\text{m/s}^{2}\). Other units: speed in m/s, energy in Joules (J), power in Watts (W), pressure in Pascals (Pa). Learning the correct unit for each quantity is essential.$t$;

UPDATE questions SET
  question_text = $t$A 500 g object (0.5 kg) is dropped from rest. What force does gravity exert on it? (g = 10 N/kg)$t$,
  explanation = $t$Weight = mass × g = 0.5 × 10 = 5 N. Weight is a force (measured in Newtons), not the same as mass (measured in kg). On Earth, g = 10 N/kg (approximately). Always multiply mass by g to get weight. Do not confuse mass (how much matter) with weight (gravitational force).$t$
WHERE id = 3583
  AND question_text = $t$A \(500\,\text{g}\) object (0.5 kg) is dropped from rest. What force does gravity exert on it? (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Weight = mass ×\(g = 0.5 \times 10 = 5\,\text{N}\). Weight is a force (measured in Newtons), not the same as mass (measured in kg). On Earth, \(g = 10\,\text{N/kg}\) (approximately). Always multiply mass by \(g\) to get weight. Do not confuse mass (how much matter) with weight (gravitational force).$t$;

UPDATE questions SET
  explanation = $t$Braking distance is proportional to speed squared (kinetic energy = ½mv²). Doubling speed quadruples braking distance. Thinking distance (proportional to speed) also doubles. So total stopping distance more than doubles when speed doubles. This is why speed limits significantly reduce accident severity.$t$
WHERE id = 3584
  AND explanation = $t$Braking distance is proportional to speed squared (kinetic energy \(= \tfrac{1}{2}mv^{2}\)). Doubling speed quadruples braking distance. Thinking distance (proportional to speed) also doubles. So total stopping distance more than doubles when speed doubles. This is why speed limits significantly reduce accident severity.$t$;

UPDATE questions SET
  explanation = $t$Mass is the amount of matter in an object — measured in kilograms (kg). Weight is the gravitational force acting on an object — measured in Newtons (N). Weight = mass × g. Mass is constant; weight depends on gravitational field strength (varies on different planets).$t$
WHERE id = 3585
  AND explanation = $t$Mass is the amount of matter in an object — measured in kilograms (kg). Weight is the gravitational force acting on an object — measured in Newtons (N). Weight = mass ×\(g\). Mass is constant; weight depends on gravitational field strength (varies on different planets).$t$;

UPDATE questions SET
  option_a = $t$1/2$t$,
  option_b = $t$1/4$t$,
  option_c = $t$1/6$t$,
  option_d = $t$1/8$t$,
  explanation = $t$After each half-life the amount halves. 60 years ÷ 20 years = 3 half-lives. Apply halving 3 times: 1 → ½ → ¼ → ⅛. So ⅛ of the original remains. Do not divide the fraction by the number of half-lives — apply repeated halving, one step at a time.$t$
WHERE id = 3590
  AND option_a = $t$\(\frac{1}{2}\)$t$
  AND option_b = $t$\(\frac{1}{4}\)$t$
  AND option_c = $t$\(\frac{1}{6}\)$t$
  AND option_d = $t$\(\frac{1}{8}\)$t$
  AND explanation = $t$After each half-life the amount halves. 60 years \(\div 20\) years \(= 3\) half-lives. Apply halving 3 times: \(1 \to \tfrac{1}{2} \to \tfrac{1}{4}\)→ ⅛. So ⅛ of the original remains. Do not divide the fraction by the number of half-lives — apply repeated halving, one step at a time.$t$;

UPDATE questions SET
  option_c = $t$The distance light travels in one year, approximately 9.5 × 10¹⁵ m$t$,
  explanation = $t$A light-year is the distance light travels in one year — approximately 9.5 × 10¹⁵ m (about 9.5 trillion km). It is a unit of distance, not time. Because distances in space are so vast, using kilometres would give unmanageably large numbers — light-years are more practical.$t$
WHERE id = 3605
  AND option_c = $t$The distance light travels in one year, approximately \(9.5 \times 10^{15}\,\text{m}\)$t$
  AND explanation = $t$A light-year is the distance light travels in one year — approximately \(9.5 \times 10^{15}\,\text{m}\) (about 9.5 trillion km). It is a unit of distance, not time. Because distances in space are so vast, using kilometres would give unmanageably large numbers — light-years are more practical.$t$;

UPDATE questions SET
  explanation = $t$Hooke's Law states that the extension of a spring is directly proportional to the applied force — provided the elastic limit is not exceeded. This means doubling the force doubles the extension. The gradient of a force-extension graph equals the spring constant k.$t$
WHERE id = 3608
  AND explanation = $t$Hooke's Law states that the extension of a spring is directly proportional to the applied force — provided the elastic limit is not exceeded. This means doubling the force doubles the extension. The gradient of a force-extension graph equals the spring constant \(k\).$t$;

UPDATE questions SET
  explanation = $t$Pressure is measured in Pascals (Pa), where 1 Pa = 1 N/m². Pressure = force ÷ area. Newton measures force, Joule measures energy, Watt measures power — do not confuse these units.$t$
WHERE id = 3609
  AND explanation = $t$Pressure is measured in Pascals (Pa), where 1 Pa = \(1\,\text{N/m}^{2}\). Pressure = force ÷ area. Newton measures force, Joule measures energy, Watt measures power — do not confuse these units.$t$;

UPDATE questions SET
  explanation = $t$For a balanced see-saw, clockwise moment = anticlockwise moment. 300 N × 2 m = 600 N m. The 150 N child must produce the same moment: 150 × d = 600, so d = 4 m from the pivot. A lighter child must sit further from the pivot to balance a heavier child sitting closer.$t$
WHERE id = 3610
  AND explanation = $t$For a balanced see-saw, clockwise moment = anticlockwise moment. \(300\,\text{N} \times 2 m = 600\,\text{N}\ m\). The 150 N child must produce the same moment: \(150 \times d = 600\), so \(d = 4 m\) from the pivot. A lighter child must sit further from the pivot to balance a heavier child sitting closer.$t$;

UPDATE questions SET
  question_text = $t$Calculate the pressure if a force of 60 N acts over an area of 0.3 m².$t$,
  explanation = $t$Pressure = force ÷ area = 60 ÷ 0.3 = 200 Pa. Divide force (N) by area (m²) to get pressure (Pa). Never multiply force by area — that gives N·m² which has no physical meaning in this context.$t$
WHERE id = 3612
  AND question_text = $t$Calculate the pressure if a force of 60 N acts over an area of \(0.3 m^{2}\).$t$
  AND explanation = $t$Pressure = force ÷ area \(= 60 \div 0.3 = 200\,\text{Pa}\). Divide force (N) by area \((m^{2})\) to get pressure (Pa). Never multiply force by area — that gives \(N \cdot m^{2}\) which has no physical meaning in this context.$t$;

UPDATE questions SET
  explanation = $t$Elastic potential energy stored in a spring = ½kx², where k is the spring constant and x is the extension. It depends on both k and the square of the extension. Doubling the extension quadruples the elastic PE. The ½ factor is essential.$t$
WHERE id = 3614
  AND explanation = $t$Elastic potential energy stored in a spring \(= \tfrac{1}{2}kx^{2}\), where \(k\) is the spring constant and \(x\) is the extension. It depends on both \(k\) and the square of the extension. Doubling the extension quadruples the elastic PE. The \(\tfrac{1}{2}\) factor is essential.$t$;

UPDATE questions SET
  option_a = $t$V = I + R$t$,
  option_b = $t$V = I ÷ R$t$,
  option_c = $t$V = I × R$t$,
  option_d = $t$V = R ÷ I$t$,
  explanation = $t$Ohm's Law: V = I × R (voltage = current × resistance). This is the fundamental equation linking the three main circuit quantities. Rearranged: I = V/R and R = V/I. Always identify which two quantities you know and solve for the third.$t$
WHERE id = 3617
  AND option_a = $t$\(V = I + R\)$t$
  AND option_b = $t$\(V = I \div R\)$t$
  AND option_c = $t$\(V = I \times R\)$t$
  AND option_d = $t$\(V = R \div I\)$t$
  AND explanation = $t$Ohm's Law: \(V = I \times R\) (voltage = current × resistance). This is the fundamental equation linking the three main circuit quantities. Rearranged: \(I = \frac{V}{R}\) and \(R = \frac{V}{I}\). Always identify which two quantities you know and solve for the third.$t$;

UPDATE questions SET
  explanation = $t$Resistors in series simply add: total R = 4 + 6 = 10 Ω. In series, there is only one current path — resistances add directly. In parallel, resistances combine differently (1/R_total = 1/R₁ + 1/R₂) and total resistance is always less than either individual resistor.$t$
WHERE id = 3620
  AND explanation = $t$Resistors in series simply add: total \(R = 4 + 6 = 10\) Ω. In series, there is only one current path — resistances add directly. In parallel, resistances combine differently (\(\frac{1}{R}\)_total \(= 1\)/R₁ \(+ 1\)/R₂) and total resistance is always less than either individual resistor.$t$;

UPDATE questions SET
  explanation = $t$R = V/I = 12/3 = 4 Ω. Using Ohm's Law: R = V ÷ I. Divide the voltage by the current. Check: 12 V ÷ 3 A = 4 Ω ✓. Verify: 4 Ω × 3 A = 12 V ✓.$t$
WHERE id = 3623
  AND explanation = $t$\(R = \frac{V}{I} = \frac{12}{3} = 4\) Ω. Using Ohm's Law: \(R = V \div I\). Divide the voltage by the current. Check: \(12\,\text{V} \div 3 A = 4\) Ω ✓. Verify: 4 Ω \(\times 3 A = 12\,\text{V} \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$P = IV = 4 × 230 = 920 W. Power = current × voltage. Check units: A × V = W ✓. Alternatively P = I²R or P = V²/R — all give the same result when applied correctly. 920 W ≈ 1 kW is a reasonable power for a household appliance.$t$
WHERE id = 3626
  AND explanation = $t$\(P = IV = 4 \times 230 = 920\,\text{W}\). Power = current × voltage. Check units: \(A \times V = W \checkmark\). Alternatively \(P = I^{2}R\) or \(P = \frac{V^{2}}{R}\) — all give the same result when applied correctly. \(920\,\text{W} \approx 1\,\text{kW}\) is a reasonable power for a household appliance.$t$;

UPDATE questions SET
  explanation = $t$When a current-carrying conductor is placed in a magnetic field, it experiences a force — this is the motor effect (F = BIL). The force is perpendicular to both the current and the field. This is the principle behind electric motors, loudspeakers and galvanometers.$t$
WHERE id = 3629
  AND explanation = $t$When a current-carrying conductor is placed in a magnetic field, it experiences a force — this is the motor effect \((F = BIL)\). The force is perpendicular to both the current and the field. This is the principle behind electric motors, loudspeakers and galvanometers.$t$;

UPDATE questions SET
  explanation = $t$F = BIL — force is directly proportional to current. Doubling the current doubles the force. The force direction remains the same (determined by field and current directions via Fleming's Left-Hand Rule). Reversing the current would reverse the force direction.$t$
WHERE id = 3632
  AND explanation = $t$\(F = BIL\) — force is directly proportional to current. Doubling the current doubles the force. The force direction remains the same (determined by field and current directions via Fleming's Left-Hand Rule). Reversing the current would reverse the force direction.$t$;

UPDATE questions SET
  explanation = $t$Vs ÷ Vp = Ns ÷ Np, so Vs = 20 × 500 ÷ 100 = 100 V. More turns on the secondary coil means a higher output voltage (a step-up transformer).$t$
WHERE id = 3640
  AND explanation = $t$Vs ÷ Vp = Ns ÷ Np, so Vs \(= 20 \times 500 \div 100 = 100\,\text{V}\). More turns on the secondary coil means a higher output voltage (a step-up transformer).$t$;

UPDATE questions SET
  explanation = $t$Transmitting at high voltage means low current (P=IV, same power). Power lost as heat in cables = I²R. Lower current dramatically reduces cable losses — reducing current by 10× reduces heating losses by 100×. This makes the National Grid far more efficient.$t$
WHERE id = 3641
  AND explanation = $t$Transmitting at high voltage means low current (P=IV, same power). Power lost as heat in cables \(= I^{2}R\). Lower current dramatically reduces cable losses — reducing current by 10× reduces heating losses by 100×. This makes the National Grid far more efficient.$t$;

UPDATE questions SET
  explanation = $t$A step-up transformer is used to increase the voltage to a very high value (e.g. 400 000 V) before transmission across the National Grid. This reduces the current in the cables, dramatically reducing energy wasted as heat (P_loss = I²R).$t$
WHERE id = 3645
  AND explanation = $t$A step-up transformer is used to increase the voltage to a very high value (e.g. 400 000 V) before transmission across the National Grid. This reduces the current in the cables, dramatically reducing energy wasted as heat (P_loss \(= I^{2}R\)).$t$;

UPDATE questions SET
  explanation = $t$Density = mass ÷ volume. This is the fundamental definition — density tells you how much mass is packed into a unit volume. Rearrangements: mass = density × volume; volume = mass ÷ density. Units: kg/m³ or g/cm³.$t$
WHERE id = 3649
  AND explanation = $t$Density = mass ÷ volume. This is the fundamental definition — density tells you how much mass is packed into a unit volume. Rearrangements: mass = density × volume; volume = mass ÷ density. Units: \(\text{kg/m}^{3}\) or \(\text{g/cm}^{3}\).$t$;

UPDATE questions SET
  question_text = $t$How much energy is needed to heat 2 kg of water by 10°C? (Specific heat capacity of water = 4200 J/kg°C)$t$,
  explanation = $t$E = mcΔT = 2 × 4200 × 10 = 84 000 J. Multiply mass (kg) × specific heat capacity (J/kg°C) × temperature change (°C). Do not use the final temperature — always use the CHANGE in temperature (ΔT = 10°C here).$t$
WHERE id = 3650
  AND question_text = $t$How much energy is needed to heat \(2\,\text{kg}\) of water by \(10^\circ C\)? (Specific heat capacity of water = \(4200\,\text{J/kg°C}\))$t$
  AND explanation = $t$\(E = mc\)Δ\(T = 2 \times 4200 \times 10 = 84\,000\,\text{J}\). Multiply mass (kg) × specific heat capacity (J/kg°C) × temperature change \((° C)\). Do not use the final temperature — always use the CHANGE in temperature (Δ\(T = 10^\circ C\) here).$t$;

UPDATE questions SET
  explanation = $t$When a gas is compressed (volume decreases) at constant temperature, gas molecules collide with the container walls more frequently (same number of molecules in smaller space). More frequent collisions per unit area means greater pressure. This is Boyle's Law: P ∝ 1/V at constant temperature.$t$
WHERE id = 3652
  AND explanation = $t$When a gas is compressed (volume decreases) at constant temperature, gas molecules collide with the container walls more frequently (same number of molecules in smaller space). More frequent collisions per unit area means greater pressure. This is Boyle's Law: \(P \propto \frac{1}{V}\) at constant temperature.$t$;

UPDATE questions SET
  question_text = $t$An object has a mass of 200 g and a volume of 40 cm³. Calculate its density.$t$,
  option_a = $t$8000 kg/m³$t$,
  option_b = $t$5 g/cm³$t$,
  option_c = $t$0.2 g/cm³$t$,
  option_d = $t$240 g/cm³$t$,
  explanation = $t$Density = mass/volume = 200/40 = 5 g/cm³. Divide mass by volume. Check: 5 × 40 = 200 g ✓. Ensure units are consistent — if mass is in grams and volume in cm³, density is in g/cm³.$t$
WHERE id = 3654
  AND question_text = $t$An object has a mass of \(200\,\text{g}\) and a volume of \(40\,\text{cm}^{3}\). Calculate its density.$t$
  AND option_a = $t$\(8000\,\text{kg/m}^{3}\)$t$
  AND option_b = $t$\(5\,\text{g/cm}^{3}\)$t$
  AND option_c = $t$\(0.2\,\text{g/cm}^{3}\)$t$
  AND option_d = $t$\(240\,\text{g/cm}^{3}\)$t$
  AND explanation = $t$Density = mass/volume \(= \frac{200}{40} = 5\,\text{g/cm}^{3}\). Divide mass by volume. Check: \(5 \times 40 = 200\,\text{g} \checkmark\). Ensure units are consistent — if mass is in grams and volume in \(cm^{3}\), density is in \(\text{g/cm}^{3}\).$t$;

UPDATE questions SET
  question_text = $t$A 1500 kg car at 24 m/s collides with a stationary 1000 kg car and they stick together. Calculate their combined velocity and the percentage of kinetic energy lost.$t$,
  option_a = $t$v = 14.4 m/s; 40% KE lost$t$,
  option_b = $t$v = 12 m/s; 20% KE lost$t$,
  option_c = $t$v = 14.4 m/s; 28% KE lost$t$,
  option_d = $t$v = 12 m/s; 40% KE lost$t$,
  explanation = $t$Conservation of momentum: 1500×24 + 1000×0 = 2500×v → v = 36000/2500 = 14.4 m/s. KE before = ½×1500×24² = 432 000 J. KE after = ½×2500×14.4² = 259 200 J. KE lost = 172 800 J = 40%. In inelastic collisions, momentum is always conserved but KE is not.$t$
WHERE id = 3769
  AND question_text = $t$A \(1500\,\text{kg}\) car at \(24\,\text{m/s}\) collides with a stationary \(1000\,\text{kg}\) car and they stick together. Calculate their combined velocity and the percentage of kinetic energy lost.$t$
  AND option_a = $t$\(v = 14.4\,\text{m/s}\); 40% KE lost$t$
  AND option_b = $t$\(v = 12\,\text{m/s}\); 20% KE lost$t$
  AND option_c = $t$\(v = 14.4\,\text{m/s}\); 28% KE lost$t$
  AND option_d = $t$\(v = 12\,\text{m/s}\); 40% KE lost$t$
  AND explanation = $t$Conservation of momentum: \(1500 \times 24 + 1000 \times 0 = 2500 \times v \to v = \frac{36000}{2500} = 14.4\,\text{m/s}\). KE before \(= \tfrac{1}{2} \times 1500 \times 24^{2} = 432\,000 J\). KE after \(= \tfrac{1}{2} \times 2500 \times 14.4^{2} = 259\,200 J\). KE lost \(= 172\,800 J = 40\%\). In inelastic collisions, momentum is always conserved but KE is not.$t$;

UPDATE questions SET
  question_text = $t$A ball is thrown horizontally at 12 m/s from a cliff. It hits the ground 3 s later. Calculate horizontal distance travelled and vertical velocity at impact. (g = 10 m/s²)$t$,
  option_a = $t$Horizontal = 36 m; vertical = 30 m/s$t$,
  option_b = $t$Horizontal = 12 m; vertical = 10 m/s$t$,
  option_c = $t$Horizontal = 36 m; vertical = 10 m/s$t$,
  option_d = $t$Horizontal = 4 m; vertical = 30 m/s$t$,
  explanation = $t$Horizontal distance = horizontal speed × time = 12 × 3 = 36 m. Vertical speed at landing: v = u + at = 0 + 10×3 = 30 m/s. In projectile motion, horizontal and vertical components are independent. The horizontal velocity (12 m/s) remains constant throughout (no horizontal force).$t$
WHERE id = 3770
  AND question_text = $t$A ball is thrown horizontally at \(12\,\text{m/s}\) from a cliff. It hits the ground 3 s later. Calculate horizontal distance travelled and vertical velocity at impact. (\(g = 10\,\text{m/s}^{2}\))$t$
  AND option_a = $t$Horizontal \(= 36\,\text{m}\); vertical = \(30\,\text{m/s}\)$t$
  AND option_b = $t$Horizontal \(= 12\,\text{m}\); vertical = \(10\,\text{m/s}\)$t$
  AND option_c = $t$Horizontal \(= 36\,\text{m}\); vertical = \(10\,\text{m/s}\)$t$
  AND option_d = $t$Horizontal \(= 4\,\text{m}\); vertical = \(30\,\text{m/s}\)$t$
  AND explanation = $t$Horizontal distance = horizontal speed × time \(= 12 \times 3 = 36\,\text{m}\). Vertical speed at landing: \(v = u\)+ at \(= 0 + 10 \times 3 = 30\,\text{m/s}\). In projectile motion, horizontal and vertical components are independent. The horizontal velocity (\(12\,\text{m/s}\)) remains constant throughout (no horizontal force).$t$;

UPDATE questions SET
  option_a = $t$14 m/s²$t$,
  option_b = $t$4.9 m/s²$t$,
  option_c = $t$2.2 m/s²$t$,
  option_d = $t$9.8 m/s²$t$,
  explanation = $t$Resultant force = thrust − weight − air resistance = 28 000 − 19 600 − 4000 = 4400 N upwards. a = F ÷ m = 4400 ÷ 2000 = 2.2 m/s².$t$
WHERE id = 3771
  AND option_a = $t$\(14\,\text{m/s}^{2}\)$t$
  AND option_b = $t$\(4.9\,\text{m/s}^{2}\)$t$
  AND option_c = $t$\(2.2\,\text{m/s}^{2}\)$t$
  AND option_d = $t$\(9.8\,\text{m/s}^{2}\)$t$
  AND explanation = $t$Resultant force = thrust − weight − air resistance \(= 28\,000 - 19\,600 - 4000 = 4400\,\text{N}\) upwards. \(a = F \div m = 4400 \div 2000 = 2.2\,\text{m/s}^{2}\).$t$;

UPDATE questions SET
  question_text = $t$A 900 kg car brakes from 30 m/s to rest in 4.5 s. Calculate the braking force and stopping distance.$t$,
  option_a = $t$F = 6000 N; d = 67.5 m$t$,
  option_b = $t$F = 3000 N; d = 135 m$t$,
  option_c = $t$F = 6000 N; d = 135 m$t$,
  option_d = $t$F = 3000 N; d = 67.5 m$t$,
  explanation = $t$Deceleration = 30 ÷ 4.5 = 6.67 m/s², so F = ma = 900 × 6.67 = 6000 N. Distance = average speed × time = (30 + 0) ÷ 2 × 4.5 = 67.5 m.$t$
WHERE id = 3773
  AND question_text = $t$A \(900\,\text{kg}\) car brakes from \(30\,\text{m/s}\) to rest in 4.5 s. Calculate the braking force and stopping distance.$t$
  AND option_a = $t$\(F = 6000\,\text{N}\); \(d = 67.5\,\text{m}\)$t$
  AND option_b = $t$\(F = 3000\,\text{N}\); \(d = 135\,\text{m}\)$t$
  AND option_c = $t$\(F = 6000\,\text{N}\); \(d = 135\,\text{m}\)$t$
  AND option_d = $t$\(F = 3000\,\text{N}\); \(d = 67.5\,\text{m}\)$t$
  AND explanation = $t$Deceleration \(= 30 \div 4.5 = 6.67\,\text{m/s}^{2}\), so \(F = ma = 900 \times 6.67 = 6000\,\text{N}\). Distance = average speed × time \(= (30 + 0) \div 2 \times 4.5 = 67.5\,\text{m}\).$t$;

UPDATE questions SET
  question_text = $t$Two skaters push off from rest. Skater A (60 kg) moves at 4 m/s. What is skater B's velocity? (mass 80 kg)$t$,
  option_a = $t$3 m/s same direction as A$t$,
  option_d = $t$3 m/s opposite direction to A$t$,
  explanation = $t$Conservation of momentum in an isolated system: total momentum before = total momentum after = 0 (both at rest). 60×4 + mB×(-vB) = 0 → mB×vB = 240. If mB = 80 kg: vB = 240/80 = 3 m/s in the opposite direction. Action-reaction forces during the push are equal and opposite — skaters gain equal and opposite momenta.$t$
WHERE id = 3774
  AND question_text = $t$Two skaters push off from rest. Skater A (60 kg) moves at \(4\,\text{m/s}\). What is skater B's velocity? (mass 80 kg)$t$
  AND option_a = $t$\(3\,\text{m/s}\) same direction as A$t$
  AND option_d = $t$\(3\,\text{m/s}\) opposite direction to A$t$
  AND explanation = $t$Conservation of momentum in an isolated system: total momentum before = total momentum after \(= 0\) (both at rest). \(60 \times 4\)+ mB×(-vB) \(= 0\)→ mB×vB \(= 240\). If mB \(= 80\,\text{kg}\): vB \(= \frac{240}{80} = 3\,\text{m/s}\) in the opposite direction. Action-reaction forces during the push are equal and opposite — skaters gain equal and opposite momenta.$t$;

UPDATE questions SET
  question_text = $t$An object dropped from rest falls for 4 s. Calculate the height fallen and speed at impact. (g = 10 m/s²)$t$,
  option_a = $t$Height = 80 m; speed = 40 m/s$t$,
  option_b = $t$Height = 40 m; speed = 20 m/s$t$,
  option_c = $t$Height = 160 m; speed = 40 m/s$t$,
  option_d = $t$Height = 80 m; speed = 20 m/s$t$,
  explanation = $t$Using h = ½gt²: h = ½×10×4² = ½×10×16 = 80 m. Final speed v = gt = 10×4 = 40 m/s. Free-fall under gravity with initial velocity = 0. Both height and final speed are independent of mass. Check energy: ½mv² = mgh → ½×40² = 10×80 → 800 = 800 ✓.$t$
WHERE id = 3775
  AND question_text = $t$An object dropped from rest falls for 4 s. Calculate the height fallen and speed at impact. (\(g = 10\,\text{m/s}^{2}\))$t$
  AND option_a = $t$Height \(= 80\,\text{m}\); speed = \(40\,\text{m/s}\)$t$
  AND option_b = $t$Height \(= 40\,\text{m}\); speed = \(20\,\text{m/s}\)$t$
  AND option_c = $t$Height \(= 160\,\text{m}\); speed = \(40\,\text{m/s}\)$t$
  AND option_d = $t$Height \(= 80\,\text{m}\); speed = \(20\,\text{m/s}\)$t$
  AND explanation = $t$Using \(h = \tfrac{1}{2}gt^{2}\): \(h = \tfrac{1}{2} \times 10 \times 4^{2} = \tfrac{1}{2} \times 10 \times 16 = 80\,\text{m}\). Final speed \(v = gt = 10 \times 4 = 40\,\text{m/s}\). Free-fall under gravity with initial velocity \(= 0\). Both height and final speed are independent of mass. Check energy: \(\tfrac{1}{2}mv^{2} = mgh \to \tfrac{1}{2} \times 40^{2} = 10 \times 80 \to 800 = 800 \checkmark\).$t$;

UPDATE questions SET
  question_text = $t$Two force-time graphs have the same area: one rectangle (500 N × 0.04 s), one triangle (same area). A 2 kg object starts from rest. Compare the impulse and velocity change for both.$t$,
  option_b = $t$Impulse = 20 N s for both; velocity change = 10 m/s for both regardless of pulse shape$t$,
  explanation = $t$Impulse = force × time = area of the force-time graph. Rectangle: 500 × 0.04 = 20 N s. The area under any force-time graph gives impulse regardless of shape. Impulse = change in momentum. Velocity change = impulse/mass = 20/m. For a 2 kg object: Δv = 10 m/s.$t$
WHERE id = 3776
  AND question_text = $t$Two force-time graphs have the same area: one rectangle \((500\,\text{N} \times 0.04\,\text{s})\), one triangle (same area). A \(2\,\text{kg}\) object starts from rest. Compare the impulse and velocity change for both.$t$
  AND option_b = $t$Impulse \(= 20\,\text{N}\ s\) for both; velocity change = \(10\,\text{m/s}\) for both regardless of pulse shape$t$
  AND explanation = $t$Impulse = force × time = area of the force-time graph. Rectangle: \(500 \times 0.04 = 20\,\text{N}\ s\). The area under any force-time graph gives impulse regardless of shape. Impulse = change in momentum. Velocity change = impulse/mass \(= \frac{20}{m}\). For \(a\) \(2\,\text{kg}\) object: Δ\(v = 10\,\text{m/s}\).$t$;

UPDATE questions SET
  question_text = $t$A 1200 kg vehicle accelerates at 3 m/s² on a level road. Driving force = 5400 N. Calculate the total resistive force.$t$,
  explanation = $t$Resultant force = ma = 1200 × 3 = 3600 N. Driving force − resistive force = resultant, so resistive force = 5400 − 3600 = 1800 N.$t$
WHERE id = 3777
  AND question_text = $t$A \(1200\,\text{kg}\) vehicle accelerates at \(3\,\text{m/s}^{2}\) on a level road. Driving force \(= 5400\,\text{N}\). Calculate the total resistive force.$t$
  AND explanation = $t$Resultant force \(= ma = 1200 \times 3 = 3600\,\text{N}\). Driving force − resistive force = resultant, so resistive force \(= 5400 - 3600 = 1800\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$A 60 g tennis ball hits a wall at 20 m/s and rebounds at 15 m/s. Contact time = 0.005 s. Calculate the average force the wall exerts.$t$,
  explanation = $t$Impulse = change in momentum = m(v−u) = 0.06×(15−(−20)) = 0.06×35 = 2.1 N s. Force = impulse/time = 2.1/0.005 = 420 N. The ball reverses direction — take careful account of signs: initial momentum is +ve (toward wall), final is −ve (away), or vice versa. The sign convention must be consistent.$t$
WHERE id = 3778
  AND question_text = $t$A \(60\,\text{g}\) tennis ball hits a wall at \(20\,\text{m/s}\) and rebounds at \(15\,\text{m/s}\). Contact time \(= 0.005\,\text{s}\). Calculate the average force the wall exerts.$t$
  AND explanation = $t$Impulse = change in momentum \(= m(v - u) = 0.06 \times (15 - (- 20)) = 0.06 \times 35 = 2.1\,\text{N}\ s\). Force = impulse/time \(= \frac{2.1}{0.005} = 420\,\text{N}\). The ball reverses direction — take careful account of signs: initial momentum is +ve (toward wall), final is −ve (away), or vice versa. The sign convention must be consistent.$t$;

UPDATE questions SET
  question_text = $t$Radium-226 (Z=88) undergoes alpha decay to radon, then beta-minus decay. What is the proton number of the final nucleus?$t$,
  option_a = $t$Z = 86$t$,
  option_b = $t$Z = 87$t$,
  option_c = $t$Z = 84$t$,
  option_d = $t$Z = 88$t$,
  explanation = $t$Ra-226 (Z=88) → alpha decay → Rn-222 (Z=86) → beta-minus decay → Z=86+1=87. After alpha then beta-minus, Z = 88−2+1 = 87 (francium). Mass number after alpha = 222; after beta-minus = 222 (unchanged). Track each decay step: alpha reduces Z by 2, beta-minus increases Z by 1.$t$
WHERE id = 3779
  AND question_text = $t$Radium-226 \((Z = 88)\) undergoes alpha decay to radon, then beta-minus decay. What is the proton number of the final nucleus?$t$
  AND option_a = $t$\(Z = 86\)$t$
  AND option_b = $t$\(Z = 87\)$t$
  AND option_c = $t$\(Z = 84\)$t$
  AND option_d = $t$\(Z = 88\)$t$
  AND explanation = $t$Ra\(- 226 (Z = 88)\)→ alpha decay → Rn\(- 222 (Z = 86)\)→ beta-minus decay →\(Z = 86 + 1 = 87\). After alpha then beta-minus, \(Z = 88 - 2 + 1 = 87\) (francium). Mass number after alpha \(= 222\); after beta-minus \(= 222\) (unchanged). Track each decay step: alpha reduces Z by 2, beta-minus increases Z by 1.$t$;

UPDATE questions SET
  question_text = $t$A sample has 6.4 × 10¹⁶ undecayed nuclei and half-life 5 hours. How many nuclei remain after 20 hours?$t$,
  option_a = $t$8 × 10¹⁵$t$,
  option_b = $t$2 × 10¹⁵$t$,
  option_c = $t$3.2 × 10¹⁵$t$,
  option_d = $t$4 × 10¹⁵$t$,
  explanation = $t$N after 5 half-lives = 6.4×10¹⁶ × (1/2)⁵ = 6.4×10¹⁶/32 = 2×10¹⁵. Each half-life halves the number of undecayed nuclei: 6.4→3.2→1.6→0.8→0.4→0.2 (×10¹⁶) = 2×10¹⁵. Apply repeated halving five times.$t$
WHERE id = 3780
  AND question_text = $t$A sample has \(6.4 \times 10^{16}\) undecayed nuclei and half-life 5 hours. How many nuclei remain after 20 hours?$t$
  AND option_a = $t$\(8 \times 10^{15}\)$t$
  AND option_b = $t$\(2 \times 10^{15}\)$t$
  AND option_c = $t$\(3.2 \times 10^{15}\)$t$
  AND option_d = $t$\(4 \times 10^{15}\)$t$
  AND explanation = $t$N after 5 half-lives \(= 6.4 \times 10^{16} \times (\frac{1}{2})^{5} = 6.4 \times \frac{10^{16}}{32} = 2 \times 10^{15}\). Each half-life halves the number of undecayed nuclei: \(6.4 \to 3.2 \to 1.6 \to 0.8 \to 0.4 \to 0.2 (\times 10^{16}) = 2 \times 10^{15}\). Apply repeated halving five times.$t$;

UPDATE questions SET
  question_text = $t$In the fission reaction U-235 + n → Ba-141 + Kr-92 + 3n, show the equation balances in terms of nucleon number and proton number.$t$,
  option_a = $t$Nucleon: 235+1=236; 141+92+3=236 ✓. Proton: 92=56+36=92 ✓. The equation is balanced.$t$,
  explanation = $t$Conservation of nucleon number (mass number): 235+1 = 141+92+3 = 236 ✓. Conservation of proton number: 92 = 56+36 = 92 ✓. In all nuclear equations, both mass number (top) and proton number (bottom) must balance on each side. Always check both conserved quantities.$t$
WHERE id = 3781
  AND question_text = $t$In the fission reaction \(U - 235 + n\)→ Ba\(- 141\)+ Kr\(- 92 + 3n\), show the equation balances in terms of nucleon number and proton number.$t$
  AND option_a = $t$Nucleon: \(235 + 1 = 236\); \(141 + 92 + 3 = 236 \checkmark\). Proton: \(92 = 56 + 36 = 92 \checkmark\). The equation is balanced.$t$
  AND explanation = $t$Conservation of nucleon number (mass number): \(235 + 1 = 141 + 92 + 3 = 236 \checkmark\). Conservation of proton number: \(92 = 56 + 36 = 92 \checkmark\). In all nuclear equations, both mass number (top) and proton number (bottom) must balance on each side. Always check both conserved quantities.$t$;

UPDATE questions SET
  explanation = $t$Activity must fall from 4000 Bq to treatment threshold. Half-lives needed: 4000→2000→1000→500→250→125 Bq = 5 half-lives. At 8 days per half-life: 5×8 = 40 days. Count the number of halvings needed from start to target, then multiply by the half-life period.$t$
WHERE id = 3782
  AND explanation = $t$Activity must fall from 4000 Bq to treatment threshold. Half-lives needed: \(4000 \to 2000 \to 1000 \to 500 \to 250 \to 125\) Bq \(= 5\) half-lives. At 8 days per half-life: \(5 \times 8 = 40\) days. Count the number of halvings needed from start to target, then multiply by the half-life period.$t$;

UPDATE questions SET
  explanation = $t$Plot corrected count rates vs time. The count rate approximately halves every ~20 minutes: 760→400 (not exactly half), 400→220 (≈half), 220→130 (≈half), 130→85 (≈half in 20 min). Estimate half-life by finding the time for count rate to halve from any starting value — use a smooth decay curve if available.$t$
WHERE id = 3784
  AND explanation = $t$Plot corrected count rates vs time. The count rate approximately halves every ~20 minutes: \(760 \to 400\) (not exactly half), \(400 \to 220\) (≈half), \(220 \to 130\) (≈half), \(130 \to 85\) (≈half in 20 min). Estimate half-life by finding the time for count rate to halve from any starting value — use a smooth decay curve if available.$t$;

UPDATE questions SET
  question_text = $t$Ancient timber has 12.5% of the C-14 activity of living wood. Half-life of C-14 = 5730 years. Calculate the age of the timber.$t$,
  explanation = $t$12.5% = 1/8 remaining = 3 half-lives elapsed. 3 × 5730 = 17 190 years. 1 → ½ → ¼ → ⅛ = 3 half-lives. Always count the number of halvings needed to get from 100% to the measured fraction, then multiply by the half-life.$t$
WHERE id = 3787
  AND question_text = $t$Ancient timber has 12.5% of the \(C - 14\) activity of living wood. Half-life of \(C - 14 = 5730\) years. Calculate the age of the timber.$t$
  AND explanation = $t$\(12.5\% = \frac{1}{8}\) remaining \(= 3\) half-lives elapsed. \(3 \times 5730 = 17\,190\) years. \(1 \to \tfrac{1}{2} \to \tfrac{1}{4}\)→ ⅛ \(= 3\) half-lives. Always count the number of halvings needed to get from 100% to the measured fraction, then multiply by the half-life.$t$;

UPDATE questions SET
  question_text = $t$A galaxy recedes at 2.1 × 10⁷ m/s. H₀ = 2.2 × 10⁻¹⁸ s⁻¹. Calculate the distance in metres and convert to light-years. (1 light-year ≈ 9.5 × 10¹⁵ m)$t$,
  option_a = $t$Distance ≈ 9.5 × 10²⁴ m ≈ 1 × 10⁹ light-years$t$,
  option_b = $t$Distance ≈ 4.6 × 10²⁵ m ≈ 5 × 10⁹ light-years$t$,
  option_c = $t$Distance ≈ 9.5 × 10²³ m ≈ 1 × 10⁸ light-years$t$,
  option_d = $t$Distance ≈ 4.6 × 10²⁴ m ≈ 5 × 10⁸ light-years$t$,
  explanation = $t$Distance = recession velocity / H₀ = (2.1×10⁷)/(2.2×10⁻¹⁸) = 9.55×10²⁴ m ≈ 10⁹ light-years. Hubble's Law: v = H₀d, rearranged to d = v/H₀. Convert to light-years: divide by 9.46×10¹⁵ m/light-year.$t$
WHERE id = 3789
  AND question_text = $t$A galaxy recedes at \(2.1 \times 10^{7}\,\text{m/s}\). H₀ \(= 2.2 \times 10^{-18} s^{-1}\). Calculate the distance in metres and convert to light-years. (1 light-year \(\approx 9.5 \times 10^{15}\,\text{m}\))$t$
  AND option_a = $t$Distance \(\approx 9.5 \times 10^{24}\,\text{m} \approx 1 \times 10^{9}\) light-years$t$
  AND option_b = $t$Distance \(\approx 4.6 \times 10^{25}\,\text{m} \approx 5 \times 10^{9}\) light-years$t$
  AND option_c = $t$Distance \(\approx 9.5 \times 10^{23}\,\text{m} \approx 1 \times 10^{8}\) light-years$t$
  AND option_d = $t$Distance \(\approx 4.6 \times 10^{24}\,\text{m} \approx 5 \times 10^{8}\) light-years$t$
  AND explanation = $t$Distance = recession velocity / H₀ \(= \frac{2.1 \times 10^{7}}{2.2 \times 10^{-18}} = 9.55 \times 10^{24}\,\text{m} \approx 10^{9}\) light-years. Hubble's Law: \(v\)= H₀\(d\), rearranged to \(d = v\)/H₀. Convert to light-years: divide by \(9.46 \times 10^{15}\,\text{m}\text{/light}\)-year.$t$;

UPDATE questions SET
  question_text = $t$A quasar spectral line at 656 nm is observed at 820 nm. Calculate the fractional red-shift z = Δλ/λ and estimate recession velocity as a fraction of c.$t$,
  option_a = $t$z = 0.25; recession ≈ 0.25c$t$,
  option_b = $t$z = 0.2; recession ≈ 0.2c$t$,
  option_c = $t$z = 0.25; recession = c exactly$t$,
  option_d = $t$z = 0.164; recession ≈ 0.164c$t$,
  explanation = $t$Redshift z = (observed − emitted)/emitted = (820−656)/656 = 164/656 = 0.25. Recession velocity = z×c = 0.25×3×10⁸ = 7.5×10⁷ m/s (not exactly c — the answer claiming "recession = c exactly" is incorrect for z=0.25 in classical approximation). z = Δλ/λ₀.$t$
WHERE id = 3790
  AND question_text = $t$A quasar spectral line at 656 nm is observed at 820 nm. Calculate the fractional red-shift \(z\)= Δλ/λ and estimate recession velocity as a fraction of \(c\).$t$
  AND option_a = $t$\(z = 0.25\); recession \(\approx 0.25c\)$t$
  AND option_b = $t$\(z = 0.2\); recession \(\approx 0.2c\)$t$
  AND option_c = $t$\(z = 0.25\); recession \(= c\) exactly$t$
  AND option_d = $t$\(z = 0.164\); recession \(\approx 0.164c\)$t$
  AND explanation = $t$Redshift \(z =\) (observed − emitted)/emitted \(= \frac{820 - 656}{656} = \frac{164}{656} = 0.25\). Recession velocity \(= z \times c = 0.25 \times 3 \times 10^{8} = 7.5 \times 10^{7}\,\text{m/s}\) (not exactly \(c\) — the answer claiming "recession \(= c\) exactly" is incorrect for \(z = 0.25\) in classical approximation). \(z\)= Δλ/λ\({}_{0}\).$t$;

UPDATE questions SET
  question_text = $t$Star X has absolute magnitude −5 and Star Y has absolute magnitude +5. Which statement is correct?$t$,
  explanation = $t$In the absolute magnitude scale, lower (more negative) numbers indicate greater luminosity. Star X (magnitude −5) is intrinsically far more luminous than Star Y (magnitude +5). A difference of 10 magnitudes corresponds to a factor of 100 000 in brightness. X is 100 000 times more luminous than Y.$t$
WHERE id = 3793
  AND question_text = $t$Star X has absolute magnitude - 5 and Star Y has absolute magnitude \(+ 5\). Which statement is correct?$t$
  AND explanation = $t$In the absolute magnitude scale, lower (more negative) numbers indicate greater luminosity. Star X (magnitude \(- 5\)) is intrinsically far more luminous than Star Y (magnitude \(+ 5\)). A difference of 10 magnitudes corresponds to a factor of 100 000 in brightness. X is 100 000 times more luminous than Y.$t$;

UPDATE questions SET
  question_text = $t$A neutron star has mass 2 × 10³⁰ kg and radius 10 km. Calculate its average density and comment on what this implies about matter inside it.$t$,
  option_a = $t$Density ≈ 4.8 × 10¹⁴ kg/m³ — comparable to atomic nuclei$t$,
  option_b = $t$Density ≈ 2 × 10²⁰ kg/m³ — denser than any known element$t$,
  option_c = $t$Density ≈ 4.8 × 10¹⁷ kg/m³ — comparable to a white dwarf$t$,
  option_d = $t$Density ≈ 4.8 × 10¹⁷ kg/m³ — approximately 5 × 10¹⁴ times denser than water, implying matter is compressed to nuclear density where protons and electrons have merged to form neutrons packed together with no empty space$t$,
  explanation = $t$Density = mass/volume = 2×10³⁰ / (4/3×π×(10⁴)³) = 2×10³⁰ / (4.19×10¹²) ≈ 4.8×10¹⁷ kg/m³. A neutron star is about 5×10¹⁴ times denser than water — the density of atomic nuclei. A teaspoon of neutron star material would weigh about a billion tonnes.$t$
WHERE id = 3794
  AND question_text = $t$A neutron star has mass \(2 \times 10^{30}\,\text{kg}\) and radius 10 km. Calculate its average density and comment on what this implies about matter inside it.$t$
  AND option_a = $t$Density \(\approx 4.8 \times 10^{14}\,\text{kg/m}^{3}\) — comparable to atomic nuclei$t$
  AND option_b = $t$Density \(\approx 2 \times 10^{20}\,\text{kg/m}^{3}\) — denser than any known element$t$
  AND option_c = $t$Density \(\approx 4.8 \times 10^{17}\,\text{kg/m}^{3}\) — comparable to a white dwarf$t$
  AND option_d = $t$Density \(\approx 4.8 \times 10^{17}\,\text{kg/m}^{3}\) — approximately \(5 \times 10^{14}\) times denser than water, implying matter is compressed to nuclear density where protons and electrons have merged to form neutrons packed together with no empty space$t$
  AND explanation = $t$Density = mass/volume \(= 2 \times \frac{10^{30}}{\frac{4}{3} \times \pi \times (10^{4})^{3}} = 2 \times \frac{10^{30}}{4.19 \times 10^{12}} \approx 4.8 \times 10^{17}\,\text{kg/m}^{3}\). A neutron star is about \(5 \times 10^{14}\) times denser than water — the density of atomic nuclei. A teaspoon of neutron star material would weigh about a billion tonnes.$t$;

UPDATE questions SET
  explanation = $t$Before the Big Bang (t=0), our current understanding of physics breaks down — the laws of physics as we know them did not yet apply. There is no "before" the Big Bang in the same way there is no "north of the North Pole." We cannot observe what happened before the Big Bang because all information from that epoch is inaccessible.$t$
WHERE id = 3796
  AND explanation = $t$Before the Big Bang \((t = 0)\), our current understanding of physics breaks down — the laws of physics as we know them did not yet apply. There is no "before" the Big Bang in the same way there is no "north of the North Pole." We cannot observe what happened before the Big Bang because all information from that epoch is inaccessible.$t$;

UPDATE questions SET
  question_text = $t$A uniform beam (mass 8 kg, length 6 m) is supported at both ends. A 50 N load hangs 2 m from the left end. Calculate the reaction forces at each support. (g = 10 N/kg)$t$,
  option_a = $t$Left = 73.3 N; Right = 56.7 N$t$,
  option_b = $t$Left = 36.7 N; Right = 43.3 N$t$,
  option_c = $t$Left = 50 N; Right = 30 N$t$,
  option_d = $t$Left = 43.3 N; Right = 36.7 N$t$,
  explanation = $t$Beam weight = 8 × 10 = 80 N, acting at the centre (3 m). Moments about the left support: R_right × 6 = 80 × 3 + 50 × 2 = 340, so R_right = 56.7 N. Upward forces = downward forces: R_left = 80 + 50 − 56.7 = 73.3 N.$t$
WHERE id = 3799
  AND question_text = $t$A uniform beam (mass 8 kg, length 6 m) is supported at both ends. A 50 N load hangs 2 m from the left end. Calculate the reaction forces at each support. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$Left \(= 73.3\,\text{N}\); Right \(= 56.7\,\text{N}\)$t$
  AND option_b = $t$Left \(= 36.7\,\text{N}\); Right \(= 43.3\,\text{N}\)$t$
  AND option_c = $t$Left \(= 50\,\text{N}\); Right \(= 30\,\text{N}\)$t$
  AND option_d = $t$Left \(= 43.3\,\text{N}\); Right \(= 36.7\,\text{N}\)$t$
  AND explanation = $t$Beam weight \(= 8 \times 10 = 80\,\text{N}\), acting at the centre (3 m). Moments about the left support: R_right \(\times 6 = 80 \times 3 + 50 \times 2 = 340\), so R_right \(= 56.7\,\text{N}\). Upward forces = downward forces: R_left \(= 80 + 50 - 56.7 = 73.3\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$A spring (k = 250 N/m) is compressed 0.06 m and launches a 0.05 kg ball vertically. Calculate the maximum height. (g = 10 N/kg)$t$,
  explanation = $t$EPE = ½kx² = ½×250×0.06² = ½×250×0.0036 = 0.45 J. By conservation of energy, EPE = KE + GPE at max height. At max height, KE=0. 0.45 = mgh = 0.05×10×h → h = 0.45/0.5 = 0.9 m. Spring PE converts entirely to gravitational PE at the peak.$t$
WHERE id = 3800
  AND question_text = $t$A spring (\(k = 250\,\text{N/m}\)) is compressed 0.06 m and launches \(a\) \(0.05\,\text{kg}\) ball vertically. Calculate the maximum height. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$\(EPE = \tfrac{1}{2}kx^{2} = \tfrac{1}{2} \times 250 \times 0.06^{2} = \tfrac{1}{2} \times 250 \times 0.0036 = 0.45\,\text{J}\). By conservation of energy, \(EPE = KE + GPE\) at max height. At max height, \(KE = 0\). \(0.45 = mgh = 0.05 \times 10 \times h \to h = \frac{0.45}{0.5} = 0.9\,\text{m}\). Spring PE converts entirely to gravitational PE at the peak.$t$;

UPDATE questions SET
  explanation = $t$Pressure = F_small/A_small = 60/(π×0.01²) = 60/(3.14×10⁻⁴) ≈ 191 000 Pa. Force_large = pressure × A_large = 191 000 × π×0.05² = 191 000 × 7.85×10⁻³ ≈ 1500 N. Area ratio = (5/1)² = 25; force amplification = 25; output = 60×25 = 1500 N.$t$
WHERE id = 3801
  AND explanation = $t$Pressure \(= F\)_small/A_small \(= \frac{60}{\pi \times 0.01^{2}} = \frac{60}{3.14 \times 10^{-4}} \approx 191\,000\,\text{Pa}\). Force_large = pressure × A_large \(= 191\,000 \times \pi \times 0.05^{2} = 191\,000 \times 7.85 \times 10^{-3} \approx 1500\,\text{N}\). Area ratio \(= (\frac{5}{1})^{2} = 25\); force amplification \(= 25\); output \(= 60 \times 25 = 1500\,\text{N}\).$t$;

UPDATE questions SET
  option_a = $t$Spring obeys Hooke's Law to 3 cm extension; k = 200 N/m. Above 6 N the spring exceeds its elastic limit and no longer obeys Hooke's Law$t$,
  option_c = $t$Spring becomes stiffer above 6 N; k increases above the elastic limit$t$,
  explanation = $t$The linear section (0–6 N, 0–3 cm) gives k = F/x = 6/0.03 = 200 N/m. Beyond 6 N the graph curves — the spring has passed its elastic limit. The gradient increases above 6 N suggesting the spring becomes stiffer (coils closing up) or the measurement setup changes. The spring does NOT simply "get stiffer" normally beyond elastic limit — it deforms plastically.$t$
WHERE id = 3802
  AND option_a = $t$Spring obeys Hooke's Law to 3 cm extension; \(k = 200\,\text{N/m}\). Above 6 N the spring exceeds its elastic limit and no longer obeys Hooke's Law$t$
  AND option_c = $t$Spring becomes stiffer above 6 N; \(k\) increases above the elastic limit$t$
  AND explanation = $t$The linear section (0–6 N, 0–3 cm) gives \(k = \frac{F}{x} = \frac{6}{0.03} = 200\,\text{N/m}\). Beyond 6 N the graph curves — the spring has passed its elastic limit. The gradient increases above 6 N suggesting the spring becomes stiffer (coils closing up) or the measurement setup changes. The spring does NOT simply "get stiffer" normally beyond elastic limit — it deforms plastically.$t$;

UPDATE questions SET
  question_text = $t$A lever lifts a 600 N boulder. Load arm = 0.5 m; effort arm = 3 m. Calculate the effort needed and the mechanical advantage.$t$,
  option_a = $t$Effort = 3600 N; MA = 0.17$t$,
  option_b = $t$Effort = 600 N; MA = 1$t$,
  option_c = $t$Effort = 200 N; MA = 4$t$,
  option_d = $t$Effort = 100 N; MA = 6$t$,
  explanation = $t$Principle of moments: effort × effort arm = load × load arm. Effort × 3 = 600 × 0.5 → effort = 300/3 = 100 N. Mechanical advantage (MA) = load/effort = 600/100 = 6. The lever multiplies force by the ratio of effort arm to load arm. A longer effort arm gives greater MA.$t$
WHERE id = 3803
  AND question_text = $t$A lever lifts a 600 N boulder. Load \(arm = 0.5\,\text{m}\); effort \(arm = 3\,\text{m}\). Calculate the effort needed and the mechanical advantage.$t$
  AND option_a = $t$Effort \(= 3600\,\text{N}\); \(MA = 0.17\)$t$
  AND option_b = $t$Effort \(= 600\,\text{N}\); \(MA = 1\)$t$
  AND option_c = $t$Effort \(= 200\,\text{N}\); \(MA = 4\)$t$
  AND option_d = $t$Effort \(= 100\,\text{N}\); \(MA = 6\)$t$
  AND explanation = $t$Principle of moments: effort × effort arm = load × load arm. Effort \(\times 3 = 600 \times 0.5\)→ effort \(= \frac{300}{3} = 100\,\text{N}\). Mechanical advantage (MA) = load/effort \(= \frac{600}{100} = 6\). The lever multiplies force by the ratio of effort arm to load arm. A longer effort arm gives greater MA.$t$;

UPDATE questions SET
  option_a = $t$Support = 2333 N upward; fixed end = 1633 N downward$t$,
  option_b = $t$Support = 700 N; fixed end = 0 N$t$,
  option_c = $t$Support = 933 N; fixed end = 233 N$t$,
  option_d = $t$Support = 1633 N; fixed end = 700 N$t$,
  explanation = $t$Moments about the fixed end: support force × 3 = 700 × 10, so support force = 2333 N upward. Vertical forces balance: fixed-end force = 2333 − 700 = 1633 N downward.$t$
WHERE id = 3804
  AND option_a = $t$Support \(= 2333\,\text{N}\) upward; fixed end \(= 1633\,\text{N}\) downward$t$
  AND option_b = $t$Support \(= 700\,\text{N}\); fixed end \(= 0\,\text{N}\)$t$
  AND option_c = $t$Support \(= 933\,\text{N}\); fixed end \(= 233\,\text{N}\)$t$
  AND option_d = $t$Support \(= 1633\,\text{N}\); fixed end \(= 700\,\text{N}\)$t$
  AND explanation = $t$Moments about the fixed end: support force \(\times 3 = 700 \times 10\), so support force \(= 2333\,\text{N}\) upward. Vertical forces balance: fixed-end force \(= 2333 - 700 = 1633\,\text{N}\) downward.$t$;

UPDATE questions SET
  question_text = $t$A 70 kg person stands on one foot (area 0.015 m²). Calculate the pressure. They then stand on tiptoe (area 0.003 m²). Calculate the new pressure and comment. (g = 10 N/kg)$t$,
  explanation = $t$Pressure = F/A. Weight = 70×10 = 700 N. Area of one foot = 0.015 m². On one foot: P = 700/0.015 = 46 667 Pa. On tiptoe (same one foot, same weight, same area): P = 46 667 Pa. Pressure depends only on total force and contact area — rising onto tiptoe does not change contact area if still one foot.$t$
WHERE id = 3805
  AND question_text = $t$A \(70\,\text{kg}\) person stands on one foot (area \(0.015 m^{2}\)). Calculate the pressure. They then stand on tiptoe (area \(0.003 m^{2}\)). Calculate the new pressure and comment. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Pressure \(= \frac{F}{A}\). Weight \(= 70 \times 10 = 700\,\text{N}\). Area of one foot \(= 0.015 m^{2}\). On one foot: \(P = \frac{700}{0.015} = 46\,667\,\text{Pa}\). On tiptoe (same one foot, same weight, same area): \(P = 46\,667\,\text{Pa}\). Pressure depends only on total force and contact area — rising onto tiptoe does not change contact area if still one foot.$t$;

UPDATE questions SET
  question_text = $t$Two forces act on a point: 9 N at 0° and 12 N at 90°. Calculate the magnitude and direction of the resultant.$t$,
  option_a = $t$Resultant = 21 N at 53°$t$,
  option_b = $t$Resultant = 15 N at 53°$t$,
  option_c = $t$Resultant = 15 N at 37°$t$,
  option_d = $t$Resultant = 108 N at 45°$t$,
  explanation = $t$Resultant = √(9²+12²) = √(81+144) = √225 = 15 N. Direction: tan θ = 12/9 = 1.33, θ = 53° from the 9 N force. The 9-12-15 triple is a Pythagorean triple (3-4-5 scaled by 3). Use Pythagoras for the magnitude and trigonometry for the direction.$t$
WHERE id = 3806
  AND question_text = $t$Two forces act on a point: 9 N at \(0^\circ\) and 12 N at \(90^\circ\). Calculate the magnitude and direction of the resultant.$t$
  AND option_a = $t$Resultant \(= 21\,\text{N}\) at \(53^\circ\)$t$
  AND option_b = $t$Resultant \(= 15\,\text{N}\) at \(53^\circ\)$t$
  AND option_c = $t$Resultant \(= 15\,\text{N}\) at \(37^\circ\)$t$
  AND option_d = $t$Resultant \(= 108\,\text{N}\) at \(45^\circ\)$t$
  AND explanation = $t$Resultant \(= \sqrt{9^{2} + 12^{2}} = \sqrt{81 + 144} = \sqrt{225} = 15\,\text{N}\). Direction: \(\tan \theta = \frac{12}{9} = 1.33\), \(\theta = 53^\circ\) from the 9 N force. The \(9 - 12 - 15\) triple is a Pythagorean triple (\(3 - 4 - 5\) scaled by 3). Use Pythagoras for the magnitude and trigonometry for the direction.$t$;

UPDATE questions SET
  question_text = $t$A car (1200 kg, 4 tyres) has contact patch area 0.02 m² per tyre. Calculate the pressure in each tyre contact patch. (g = 10 N/kg)$t$,
  explanation = $t$Total weight = 1200×10 = 12 000 N spread over 4 tyres = 3000 N per tyre. Pressure per tyre = 3000/0.02 = 150 000 Pa. The contact patch area per tyre (0.02 m²) supports one quarter of the car's weight. Tyre pressure must equal this for the tyre to be in equilibrium.$t$
WHERE id = 3807
  AND question_text = $t$A car (1200 kg, 4 tyres) has contact patch area \(0.02 m^{2}\) per tyre. Calculate the pressure in each tyre contact patch. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Total weight \(= 1200 \times 10 = 12\,000\,\text{N}\) spread over 4 tyres \(= 3000\,\text{N}\) per tyre. Pressure per tyre \(= \frac{3000}{0.02} = 150\,000\,\text{Pa}\). The contact patch area per tyre \((0.02 m^{2})\) supports one quarter of the car's weight. Tyre pressure must equal this for the tyre to be in equilibrium.$t$;

UPDATE questions SET
  question_text = $t$A crane jib is 8 m long at 60° to the vertical, lifting a 2000 kg load. Calculate the moment about the base. (g = 10 N/kg; sin60° = 0.87, cos60° = 0.5)$t$,
  option_a = $t$80 000 N m$t$,
  option_b = $t$139 200 N m$t$,
  option_c = $t$69 600 N m$t$,
  option_d = $t$160 000 N m$t$,
  explanation = $t$Moment = force × perpendicular distance from pivot. The horizontal distance of the load from the base = 8 sin60° = 6.93 m. Moment = load × horizontal distance = (2000×10) × 6.93 = 138 600 N m ≈ 139 200 N m (using g=10 or 9.8). The perpendicular distance is the horizontal component of the jib length.$t$
WHERE id = 3808
  AND question_text = $t$A crane jib is 8 m long at \(60^\circ\) to the vertical, lifting \(a\) \(2000\,\text{kg}\) load. Calculate the moment about the base. (\(g = 10\,\text{N/kg}\); \(\sin 60^\circ = 0.87\), \(\cos 60^\circ = 0.5\))$t$
  AND option_a = $t$80 000 N \(m\)$t$
  AND option_b = $t$139 200 N \(m\)$t$
  AND option_c = $t$69 600 N \(m\)$t$
  AND option_d = $t$160 000 N \(m\)$t$
  AND explanation = $t$Moment = force × perpendicular distance from pivot. The horizontal distance of the load from the base \(= 8 \sin 60^\circ = 6.93\,\text{m}\). Moment = load × horizontal distance \(= (2000 \times 10) \times 6.93 = 138\,600\,\text{N}\ m \approx 139\,200\,\text{N}\ m\) (using \(g = 10\) or 9.8). The perpendicular distance is the horizontal component of the jib length.$t$;

UPDATE questions SET
  option_a = $t$I = 2 A; terminal V = 11 V; internal power = 1 W$t$,
  option_b = $t$I = 2.18 A; terminal V = 10 V; internal power = 2.4 W$t$,
  option_c = $t$I = 2 A; terminal V = 11 V; internal power = 2 W$t$,
  option_d = $t$I = 2.4 A; terminal V = 10.8 V; internal power = 2.88 W$t$,
  explanation = $t$Total EMF = 12 V, total resistance = 0.5 + 5.5 = 6 Ω. I = 12/6 = 2 A. Terminal voltage = EMF − Ir = 12 − 2×0.5 = 11 V. Internal resistance power = I²r = 4×0.5 = 2 W. The terminal voltage is always less than EMF when current flows due to the internal voltage drop.$t$
WHERE id = 3809
  AND option_a = $t$\(I = 2\,\text{A}\); terminal \(V = 11 V\); internal power \(= 1\,\text{W}\)$t$
  AND option_b = $t$\(I = 2.18\,\text{A}\); terminal \(V = 10 V\); internal power \(= 2.4\,\text{W}\)$t$
  AND option_c = $t$\(I = 2\,\text{A}\); terminal \(V = 11 V\); internal power \(= 2\,\text{W}\)$t$
  AND option_d = $t$\(I = 2.4\,\text{A}\); terminal \(V = 10.8 V\); internal power \(= 2.88\,\text{W}\)$t$
  AND explanation = $t$Total \(EMF = 12\,\text{V}\), total resistance \(= 0.5 + 5.5 = 6\) Ω. \(I = \frac{12}{6} = 2\,\text{A}\). Terminal voltage \(= EMF\)− Ir \(= 12 - 2 \times 0.5 = 11\,\text{V}\). Internal resistance power \(= I^{2}r = 4 \times 0.5 = 2\,\text{W}\). The terminal voltage is always less than EMF when current flows due to the internal voltage drop.$t$;

UPDATE questions SET
  option_a = $t$Resistance increases because atoms vibrate more at higher temperature, increasing electron collisions; current = 0.5 A$t$,
  option_b = $t$Resistance decreases because hot metal conducts better; current = 3 A$t$,
  option_c = $t$Resistance increases because the lamp gets heavier when hot; current = 0.5 A$t$,
  option_d = $t$Resistance stays constant; current = 3 A$t$
WHERE id = 3810
  AND option_a = $t$Resistance increases because atoms vibrate more at higher temperature, increasing electron collisions; current \(= 0.5\,\text{A}\)$t$
  AND option_b = $t$Resistance decreases because hot metal conducts better; current \(= 3\,\text{A}\)$t$
  AND option_c = $t$Resistance increases because the lamp gets heavier when hot; current \(= 0.5\,\text{A}\)$t$
  AND option_d = $t$Resistance stays constant; current \(= 3\,\text{A}\)$t$;

UPDATE questions SET
  question_text = $t$R1 = 6 Ω and R2 = 12 Ω in parallel, in series with R3 = 2 Ω, connected to 9 V. Calculate the current through R1.$t$,
  explanation = $t$Parallel part: 1/R = 1/6 + 1/12 = 3/12, so R = 4 Ω. Total resistance = 4 + 2 = 6 Ω, so total current = 9 ÷ 6 = 1.5 A. Voltage across R3 = 1.5 × 2 = 3 V, leaving 6 V across the parallel part. Current through R1 = 6 ÷ 6 = 1 A (and through R2 = 6 ÷ 12 = 0.5 A).$t$
WHERE id = 3811
  AND question_text = $t$\(R_{1} = 6\) Ω and \(R_{2} = 12\) Ω in parallel, in series with \(R_{3} = 2\) Ω, connected to 9 V. Calculate the current through \(R_{1}\).$t$
  AND explanation = $t$Parallel part: \(\frac{1}{R} = \frac{1}{6} + \frac{1}{12} = \frac{3}{12}\), so \(R = 4\) Ω. Total resistance \(= 4 + 2 = 6\) Ω, so total current \(= 9 \div 6 = 1.5\,\text{A}\). Voltage across \(R_{3} = 1.5 \times 2 = 3\,\text{V}\), leaving 6 V across the parallel part. Current through \(R_{1} = 6 \div 6 = 1\,\text{A}\) (and through \(R_{2} = 6 \div 12 = 0.5\,\text{A}\)).$t$;

UPDATE questions SET
  explanation = $t$In series, both lamps carry the same current. Power = I²R, so the lamp with higher resistance dissipates more power and is brighter. The 40 W lamp (rated at lower power at 240 V) has higher resistance (R = V²/P = 240²/40 = 1440 Ω) than the 80 W lamp (R = 720 Ω). Higher resistance → more power dissipated in series → 40 W lamp is brighter.$t$
WHERE id = 3813
  AND explanation = $t$In series, both lamps carry the same current. Power \(= I^{2}R\), so the lamp with higher resistance dissipates more power and is brighter. The 40 W lamp (rated at lower power at 240 V) has higher resistance (\(R = \frac{V^{2}}{P} = \frac{240^{2}}{40} = 1440\) Ω) than the 80 W lamp (\(R = 720\) Ω). Higher resistance → more power dissipated in series → 40 W lamp is brighter.$t$;

UPDATE questions SET
  option_a = $t$Max power at R = 0 Ω; power = 81 W$t$,
  option_b = $t$Max power at R = 9 Ω; power = 9 W$t$,
  option_c = $t$Max power at R = 3 Ω; power = 9 W$t$,
  option_d = $t$Max power at R = 1 Ω; power = 20.25 W$t$,
  explanation = $t$Maximum power transfer to external resistance R occurs when R equals internal resistance r. With r=1 Ω, maximum power when R=1 Ω. Total resistance = 2 Ω. I = EMF/(R+r) = 9/2 = 4.5 A. P_external = I²R = 4.5²×1 = 20.25 W. This is the maximum power transfer theorem.$t$
WHERE id = 3814
  AND option_a = $t$Max power at \(R = 0\) Ω; power \(= 81\,\text{W}\)$t$
  AND option_b = $t$Max power at \(R = 9\) Ω; power \(= 9\,\text{W}\)$t$
  AND option_c = $t$Max power at \(R = 3\) Ω; power \(= 9\,\text{W}\)$t$
  AND option_d = $t$Max power at \(R = 1\) Ω; power \(= 20.25\,\text{W}\)$t$
  AND explanation = $t$Maximum power transfer to external resistance R occurs when R equals internal resistance \(r\). With \(r = 1\) Ω, maximum power when \(R = 1\) Ω. Total resistance \(= 2\) Ω. \(I = \frac{EMF}{R + r} = \frac{9}{2} = 4.5\,\text{A}\). P_external \(= I^{2}R = 4.5^{2} \times 1 = 20.25\,\text{W}\). This is the maximum power transfer theorem.$t$;

UPDATE questions SET
  option_a = $t$I = 2 A; V = 16 V; E = 9600 J$t$,
  option_b = $t$I = 2 A; V = 16 V; E = 28 800 J$t$,
  option_c = $t$I = 120 A; V = 960 V; E = 2 880 000 J$t$,
  option_d = $t$I = 2 A; V = 16 V; E = 4800 J$t$,
  explanation = $t$I = Q/t = 600/(5×60) = 600/300 = 2 A. V = IR = 2×8 = 16 V. E = QV = 600×16 = 9600 J (or E = I²Rt = 4×8×300 = 9600 J). Always convert time to seconds. The three formulas for energy (E=QV, E=I²Rt, E=V²t/R) all give the same answer.$t$
WHERE id = 3815
  AND option_a = $t$\(I = 2\,\text{A}\); \(V = 16 V\); \(E = 9600\,\text{J}\)$t$
  AND option_b = $t$\(I = 2\,\text{A}\); \(V = 16 V\); \(E = 28\,800\,\text{J}\)$t$
  AND option_c = $t$\(I = 120\,\text{A}\); \(V = 960 V\); \(E = 2\,880\,000\,\text{J}\)$t$
  AND option_d = $t$\(I = 2\,\text{A}\); \(V = 16 V\); \(E = 4800\,\text{J}\)$t$
  AND explanation = $t$\(I = \frac{Q}{t} = \frac{600}{5 \times 60} = \frac{600}{300} = 2\,\text{A}\). \(V = IR = 2 \times 8 = 16 V\). \(E = QV = 600 \times 16 = 9600\,\text{J}\) (or \(E = I^{2}\)Rt \(= 4 \times 8 \times 300 = 9600\,\text{J}\)). Always convert time to seconds. The three formulas for energy (\(E = QV,\ E = I^{2}\)Rt, \(E = \frac{V^{2}t}{R}\)) all give the same answer.$t$;

UPDATE questions SET
  question_text = $t$An LDR (1 kΩ in bright light, 100 kΩ in darkness) in series with fixed 10 kΩ and 5 V supply. Calculate voltage across the fixed resistor in each condition.$t$,
  explanation = $t$LDR and fixed resistor form a potential divider. V_LDR = V_supply × R_LDR/(R_LDR + R_fixed). In bright light: R_LDR=1kΩ; V_LDR = 5×1/(1+10) = 5/11 ≈ 0.45 V. In darkness: R_LDR=100kΩ; V_LDR = 5×100/(100+10) = 500/110 ≈ 4.55 V. Greater LDR resistance = greater voltage across it.$t$
WHERE id = 3816
  AND question_text = $t$An LDR (1 \(k\)Ω in bright light, 100 \(k\)Ω in darkness) in series with fixed 10 \(k\)Ω and 5 V supply. Calculate voltage across the fixed resistor in each condition.$t$
  AND explanation = $t$LDR and fixed resistor form a potential divider. V_\(LDR = V\)_supply × R_LDR/(R_\(LDR + R\)_fixed). In bright light: R_\(LDR = 1k\)Ω; V_\(LDR = 5 \times \frac{1}{1 + 10} = \frac{5}{11} \approx 0.45\,\text{V}\). In darkness: R_\(LDR = 100k\)Ω; V_\(LDR = 5 \times \frac{100}{100 + 10} = \frac{500}{110} \approx 4.55\,\text{V}\). Greater LDR resistance = greater voltage across it.$t$;

UPDATE questions SET
  option_a = $t$Series: I = 1 A; terminal V = 2.5 V. Single cell: I = 1 A; terminal V = 1 V. Series combination delivers higher voltage and same current$t$,
  option_b = $t$Series: I = 0.75 A; terminal V = 1.875 V. Single cell: I = 0.5 A; terminal V = 1.25 V$t$,
  option_c = $t$Series: I = 2 A; terminal V = 2 V. Single cell: I = 0.5 A; terminal V = 1.25 V$t$,
  option_d = $t$Series: I = 1 A; terminal V = 3 V. Single cell: I = 0.5 A; terminal V = 1.25 V$t$,
  explanation = $t$Two cells in series: total EMF = 3 V, total internal resistance = 1 Ω. I = 3/(2+1) = 1 A. Terminal V = 3 − 1×1 = 2.5 V (but 2 cells so terminal V per cell... use total: 3−1 = 2 V across external). Single cell: I = 1.5/(2+0.5) = 0.6 A. Series cells give more current than single cell into same load.$t$
WHERE id = 3818
  AND option_a = $t$Series: \(I = 1\,\text{A}\); terminal \(V = 2.5 V\). Single cell: \(I = 1\,\text{A}\); terminal \(V = 1 V\). Series combination delivers higher voltage and same current$t$
  AND option_b = $t$Series: \(I = 0.75\,\text{A}\); terminal \(V = 1.875 V\). Single cell: \(I = 0.5\,\text{A}\); terminal \(V = 1.25 V\)$t$
  AND option_c = $t$Series: \(I = 2\,\text{A}\); terminal \(V = 2 V\). Single cell: \(I = 0.5\,\text{A}\); terminal \(V = 1.25 V\)$t$
  AND option_d = $t$Series: \(I = 1\,\text{A}\); terminal \(V = 3 V\). Single cell: \(I = 0.5\,\text{A}\); terminal \(V = 1.25 V\)$t$
  AND explanation = $t$Two cells in series: total \(EMF = 3 V\), total internal resistance \(= 1\) Ω. \(I = \frac{3}{2 + 1} = 1\,\text{A}\). Terminal \(V = 3 - 1 \times 1 = 2.5 V\) (but 2 cells so terminal V per cell... use total: \(3 - 1 = 2 V\) across external). Single cell: \(I = \frac{1.5}{2 + 0.5} = 0.6\,\text{A}\). Series cells give more current than single cell into same load.$t$;

UPDATE questions SET
  option_a = $t$F = 0 N because field and wire are parallel$t$,
  option_b = $t$F = 1.2 N directed east (field up, current north → force east by Fleming's LHR)$t$,
  option_c = $t$F = 1.2 N directed north$t$,
  option_d = $t$F = 4.8 N directed east$t$,
  explanation = $t$F = BIL sinθ. Wire is horizontal carrying current north; field is vertical (up). θ = 90°. F = 0.6×8×0.25×sin90° = 1.2 N. Direction: use Fleming's Left-Hand Rule — field up, current north, force is east. F = BIL = 0.6×8×0.25 = 1.2 N directed east.$t$
WHERE id = 3819
  AND option_a = $t$\(F = 0\,\text{N}\) because field and wire are parallel$t$
  AND option_b = $t$\(F = 1.2\,\text{N}\) directed east (field up, current north → force east by Fleming's LHR)$t$
  AND option_c = $t$\(F = 1.2\,\text{N}\) directed north$t$
  AND option_d = $t$\(F = 4.8\,\text{N}\) directed east$t$
  AND explanation = $t$\(F = BIL \sin \theta\). Wire is horizontal carrying current north; field is vertical (up). \(\theta = 90^\circ\). \(F = 0.6 \times 8 \times 0.25 \times \sin 90^\circ = 1.2\,\text{N}\). Direction: use Fleming's Left-Hand Rule — field up, current north, force is east. \(F = BIL = 0.6 \times 8 \times 0.25 = 1.2\,\text{N}\) directed east.$t$;

UPDATE questions SET
  question_text = $t$A DC motor lifts 5 kg through 2 m in 4 s. Supply: 24 V, 2 A. Calculate efficiency. (g = 10 N/kg)$t$,
  option_a = $t$Efficiency = 52%$t$,
  option_b = $t$Efficiency = 100%$t$,
  option_c = $t$Efficiency = 26%$t$,
  option_d = $t$Efficiency = 52.1%$t$,
  explanation = $t$Useful power output = mgh/t = 5×10×2/4 = 25 W. Input power = IV = 24×2 = 48 W. Efficiency = 25/48 × 100 = 52.1%. Efficiency = useful output/total input × 100. The wasted 47.9% is lost as heat in the motor windings and due to friction.$t$
WHERE id = 3820
  AND question_text = $t$A DC motor lifts \(5\,\text{kg}\) through 2 m in 4 s. Supply: 24 V, 2 A. Calculate efficiency. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$Efficiency \(= 52\%\)$t$
  AND option_b = $t$Efficiency \(= 100\%\)$t$
  AND option_c = $t$Efficiency \(= 26\%\)$t$
  AND option_d = $t$Efficiency \(= 52.1\%\)$t$
  AND explanation = $t$Useful power output \(= \frac{mgh}{t} = 5 \times 10 \times \frac{2}{4} = 25\,\text{W}\). Input power \(= IV = 24 \times 2 = 48\,\text{W}\). Efficiency \(= \frac{25}{48} \times 100 = 52.1\%\). Efficiency = useful output/total input \(\times 100\). The wasted 47.9% is lost as heat in the motor windings and due to friction.$t$;

UPDATE questions SET
  question_text = $t$An 80-turn rectangular coil (4 cm × 6 cm) carries 3 A in a 0.5 T field. Calculate the maximum torque.$t$,
  option_a = $t$2.88 N m$t$,
  option_b = $t$0.288 N m$t$,
  option_c = $t$28.8 N m$t$,
  option_d = $t$0.0288 N m$t$,
  explanation = $t$Maximum torque = NIAB = 80 × 3 × (0.04 × 0.06) × 0.5 = 80 × 3 × 0.0024 × 0.5 = 0.288 N m. Convert the side lengths to metres before multiplying.$t$
WHERE id = 3821
  AND question_text = $t$An 80-turn rectangular coil \((4\,\text{cm} \times 6\,\text{cm})\) carries 3 A in a 0.5 T field. Calculate the maximum torque.$t$
  AND option_a = $t$2.88 N \(m\)$t$
  AND option_b = $t$0.288 N \(m\)$t$
  AND option_c = $t$28.8 N \(m\)$t$
  AND option_d = $t$0.0288 N \(m\)$t$
  AND explanation = $t$Maximum torque \(= NIAB = 80 \times 3 \times (0.04 \times 0.06) \times 0.5 = 80 \times 3 \times 0.0024 \times 0.5 = 0.288\,\text{N}\ m\). Convert the side lengths to metres before multiplying.$t$;

UPDATE questions SET
  question_text = $t$An electron enters a 0.2 T field (into the page), moving right at 5 × 10⁶ m/s. Calculate the radius of its circular path. (mₑ = 9.1 × 10⁻³¹ kg, e = 1.6 × 10⁻¹⁹ C)$t$,
  option_a = $t$r = 1.42 × 10⁻⁴ m (0.142 mm) in the plane of the page$t$,
  option_d = $t$r = 0.0142 m in the plane of the page$t$,
  explanation = $t$The magnetic force provides the centripetal force: qvB = mv²/r, so r = mv ÷ qB = (9.1 × 10⁻³¹ × 5 × 10⁶) ÷ (1.6 × 10⁻¹⁹ × 0.2) = 1.42 × 10⁻⁴ m, about 0.142 mm.$t$
WHERE id = 3822
  AND question_text = $t$An electron enters a 0.2 T field (into the page), moving right at \(5 \times 10^{6}\,\text{m/s}\). Calculate the radius of its circular path. (\(m\)ₑ \(= 9.1 \times 10^{-31}\,\text{kg}\), \(e = 1.6 \times 10^{-19}\,\text{C}\))$t$
  AND option_a = $t$\(r = 1.42 \times 10^{-4}\,\text{m}\ (0.142\,\text{mm})\) in the plane of the page$t$
  AND option_d = $t$\(r = 0.0142\,\text{m}\) in the plane of the page$t$
  AND explanation = $t$The magnetic force provides the centripetal force: qvB \(= \frac{mv^{2}}{r}\), so \(r = mv\)÷ qB \(= (9.1 \times 10^{-31} \times 5 \times 10^{6}) \div (1.6 \times 10^{-19} \times 0.2) = 1.42 \times 10^{-4}\,\text{m}\), about 0.142 mm.$t$;

UPDATE questions SET
  explanation = $t$Two parallel wires with current in the same direction attract each other. The magnetic field from wire 1 at wire 2's location is perpendicular to wire 2's current (by the right-hand rule), creating a force toward wire 1 (by Fleming's Left-Hand Rule). This mutual attraction is the basis for the definition of the ampere.$t$
WHERE id = 3824
  AND explanation = $t$Two parallel wires with current in the same direction attract each other. The magnetic field from wire 1 at wire 2'\(s\) location is perpendicular to wire 2'\(s\) current (by the right-hand rule), creating a force toward wire 1 (by Fleming's Left-Hand Rule). This mutual attraction is the basis for the definition of the ampere.$t$;

UPDATE questions SET
  explanation = $t$The Hall effect: when a current-carrying conductor is in a perpendicular magnetic field, charge carriers are deflected sideways, building up a transverse potential difference (Hall voltage). Hall voltage ∝ magnetic flux density and ∝ 1/charge carrier density. Used to measure magnetic field strength and identify charge carrier type and density.$t$
WHERE id = 3825
  AND explanation = $t$The Hall effect: when a current-carrying conductor is in a perpendicular magnetic field, charge carriers are deflected sideways, building up a transverse potential difference (Hall voltage). Hall voltage ∝ magnetic flux density and \(\propto 1\)/charge carrier density. Used to measure magnetic field strength and identify charge carrier type and density.$t$;

UPDATE questions SET
  explanation = $t$F = BIL → B = F/(IL) = 0.15/(5×L). Need wire length from context. If L=0.1 m: B = 0.15/(5×0.1) = 0.15/0.5 = 0.3 T. Using F=BIL rearranged: B = F/(IL). Always identify what quantities are given and rearrange the formula accordingly.$t$
WHERE id = 3826
  AND explanation = $t$\(F = BIL \to B = \frac{F}{IL} = \frac{0.15}{5 \times L}\). Need wire length from context. If \(L = 0.1\,\text{m}\): \(B = \frac{0.15}{5 \times 0.1} = \frac{0.15}{0.5} = 0.3\,\text{T}\). Using \(F = BIL\) rearranged: \(B = \frac{F}{IL}\). Always identify what quantities are given and rearrange the formula accordingly.$t$;

UPDATE questions SET
  question_text = $t$In a mass spectrometer, a singly charged ion (mass 6.4 × 10⁻²⁶ kg) is accelerated through 2000 V into a 0.5 T field. Calculate the radius of its circular path. (e = 1.6 × 10⁻¹⁹ C)$t$,
  option_a = $t$r = 0.2 m$t$,
  option_b = $t$r = 0.1 m$t$,
  option_c = $t$r = 0.4 m$t$,
  option_d = $t$r = 0.02 m$t$,
  explanation = $t$In a mass spectrometer: qvB = mv²/r → r = mv/(qB). v from accelerator: ½mv² = qV → v = √(2qV/m). Then r = m√(2qV/m)/(qB) = √(2mV/q)/B. With given values: r ≈ 0.1 m. The radius of curvature depends on mass-to-charge ratio — the basis for mass spectrometry.$t$
WHERE id = 3827
  AND question_text = $t$In a mass spectrometer, a singly charged ion (mass \(6.4 \times 10^{-26}\,\text{kg}\)) is accelerated through 2000 V into a 0.5 T field. Calculate the radius of its circular path. \((e = 1.6 \times 10^{-19}\,\text{C})\)$t$
  AND option_a = $t$\(r = 0.2\,\text{m}\)$t$
  AND option_b = $t$\(r = 0.1\,\text{m}\)$t$
  AND option_c = $t$\(r = 0.4\,\text{m}\)$t$
  AND option_d = $t$\(r = 0.02\,\text{m}\)$t$
  AND explanation = $t$In a mass spectrometer: qvB \(= \frac{mv^{2}}{r} \to r = mv /\)(qB). \(v\) from accelerator: \(\tfrac{1}{2}mv^{2}\)= qV → \(v = \sqrt{}\)(2qV/\(m\)). Then \(r = m\sqrt{}\)(2qV/\(m\))/(qB) \(= \sqrt{}\)(2mV/\(q\))/B. With given values: \(r \approx 0.1\,\text{m}\). The radius of curvature depends on mass-to-charge ratio — the basis for mass spectrometry.$t$;

UPDATE questions SET
  explanation = $t$Back-EMF increases as motor speed increases (more rapid flux change). Back-EMF opposes supply voltage → net voltage = supply − back-EMF decreases → current decreases. At no-load top speed, back-EMF ≈ supply voltage and current is minimal. If the motor is stalled (back-EMF=0), maximum current flows — can damage the motor.$t$
WHERE id = 3828
  AND explanation = $t$Back-EMF increases as motor speed increases (more rapid flux change). Back-EMF opposes supply voltage → net voltage = supply − back-EMF decreases → current decreases. At no-load top speed, back-EMF ≈ supply voltage and current is minimal. If the motor is stalled (back\(- EMF = 0\)), maximum current flows — can damage the motor.$t$;

UPDATE questions SET
  option_a = $t$Secondary V = 12 V; theoretical max current = 60 A; actual current = 51 A$t$,
  option_b = $t$Secondary V = 4800 V; theoretical max = 0.15 A; actual = 0.128 A$t$,
  option_c = $t$Secondary V = 12 V; max = 40 A; actual = 40 A$t$,
  option_d = $t$Secondary V = 12 V; max = 51 A; actual = 60 A$t$,
  explanation = $t$Vs = Vp × Ns ÷ Np = 240 × 60 ÷ 1200 = 12 V. At 100% efficiency, Is = Vp × Ip ÷ Vs = 240 × 3 ÷ 12 = 60 A. At 85% efficiency the output power is 85% of the input, so the actual current = 0.85 × 60 = 51 A.$t$
WHERE id = 3829
  AND option_a = $t$Secondary \(V = 12 V\); theoretical max current \(= 60\,\text{A}\); actual current \(= 51\,\text{A}\)$t$
  AND option_b = $t$Secondary \(V = 4800 V\); theoretical \(max = 0.15\,\text{A}\); actual \(= 0.128\,\text{A}\)$t$
  AND option_c = $t$Secondary \(V = 12 V\); \(max = 40\,\text{A}\); actual \(= 40\,\text{A}\)$t$
  AND option_d = $t$Secondary \(V = 12 V\); \(max = 51\,\text{A}\); actual \(= 60\,\text{A}\)$t$
  AND explanation = $t$Vs = Vp × Ns ÷ Np \(= 240 \times 60 \div 1200 = 12\,\text{V}\). At 100% efficiency, Is = Vp × Ip ÷ Vs \(= 240 \times 3 \div 12 = 60\,\text{A}\). At 85% efficiency the output power is 85% of the input, so the actual current \(= 0.85 \times 60 = 51\,\text{A}\).$t$;

UPDATE questions SET
  question_text = $t$A search coil (500 turns, area 2 cm²) inside a solenoid. Flux density changes from 0.1 T to 0.4 T in 0.05 s. Calculate the induced EMF.$t$,
  explanation = $t$Induced EMF = −N × ΔΦ/Δt = 500 × (0.002 × 0.0002)/0.001 ... need flux density change and time from question. E = N×A×ΔB/Δt. With 500 turns, area 2 cm² = 2×10⁻⁴ m², ΔB/Δt = 6 T/s: E = 500 × 2×10⁻⁴ × 6 = 0.6 V. Faraday's Law: EMF = N×A×rate of flux density change.$t$
WHERE id = 3830
  AND question_text = $t$A search coil (500 turns, area \(2\,\text{cm}^{2}\)) inside a solenoid. Flux density changes from 0.1 T to 0.4 T in 0.05 s. Calculate the induced EMF.$t$
  AND explanation = $t$Induced \(EMF = - N\)× ΔΦ/Δ\(t = 500 \times \frac{0.002 \times 0.0002}{0.001} \ldots\) need flux density change and time from question. \(E = N \times A\)×ΔB/Δ\(t\). With 500 turns, area \(2\,\text{cm}^{2} = 2 \times 10^{-4} m^{2}\), ΔB/Δ\(t = 6 \frac{\,\text{T}}{s}\): \(E = 500 \times 2 \times 10^{-4} \times 6 = 0.6\,\text{V}\). Faraday's Law: \(EMF = N \times A\)×rate of flux density change.$t$;

UPDATE questions SET
  question_text = $t$National Grid transmits 500 MW at 400 000 V. Cable resistance = 0.5 Ω. Compare power lost at transmission voltage versus at generation voltage (25 000 V).$t$,
  option_a = $t$Transmission current = 1250 A; loss at 400 kV = 781 250 W; loss at 25 kV = 200 MW — high voltage transmission reduces losses by a factor of 256$t$,
  option_b = $t$Transmission current = 20 000 A; loss at 400 kV = 200 MW; loss at 25 kV = only 781 kW$t$,
  option_c = $t$Transmission current = 1250 A; loss at 400 kV = 781 kW; loss at 25 kV = 200 MW — this is why high voltage is used$t$,
  option_d = $t$Transmission current = 12 500 A; loss at 400 kV = 78 MW; loss at 25 kV = 2 GW$t$,
  explanation = $t$At 400 kV: I = P/V = 500×10⁶/400×10³ = 1250 A. Power loss = I²R = 1250²×0.5 = 781 250 W ≈ 0.78 MW. At lower voltage (e.g. 25 kV): I = 20 000 A. Loss = 20000²×0.5 = 200 MW — catastrophically more. This demonstrates why high-voltage transmission is essential: loss ∝ I² ∝ 1/V².$t$
WHERE id = 3831
  AND question_text = $t$National Grid transmits 500 MW at 400 000 V. Cable resistance \(= 0.5\) Ω. Compare power lost at transmission voltage versus at generation voltage (25 000 V).$t$
  AND option_a = $t$Transmission current \(= 1250\,\text{A}\); loss at \(400\,\text{kV} = 781\,250\,\text{W}\); loss at \(25\,\text{kV} = 200\,\text{MW}\) — high voltage transmission reduces losses by a factor of 256$t$
  AND option_b = $t$Transmission current \(= 20\,000\,\text{A}\); loss at \(400\,\text{kV} = 200\,\text{MW}\); loss at 25 kV = only 781 kW$t$
  AND option_c = $t$Transmission current \(= 1250\,\text{A}\); loss at \(400\,\text{kV} = 781\,\text{kW}\); loss at \(25\,\text{kV} = 200\,\text{MW}\) — this is why high voltage is used$t$
  AND option_d = $t$Transmission current \(= 12\,500\,\text{A}\); loss at \(400\,\text{kV} = 78\,\text{MW}\); loss at \(25\,\text{kV} = 2 GW\)$t$
  AND explanation = $t$At 400 kV: \(I = \frac{P}{V} = 500 \times \frac{10^{6}}{400} \times 10^{3} = 1250\,\text{A}\). Power loss \(= I^{2}R = 1250^{2} \times 0.5 = 781\,250\,\text{W} \approx 0.78\,\text{MW}\). At lower voltage (e.g. 25 kV): \(I = 20\,000\,\text{A}\). Loss \(= 20000^{2} \times 0.5 = 200\,\text{MW}\) — catastrophically more. This demonstrates why high-voltage transmission is essential: loss \(\propto I^{2} \propto \frac{1}{V^{2}}\).$t$;

UPDATE questions SET
  option_a = $t$Peak current = 5 A; r.m.s. = 3.54 A$t$,
  option_b = $t$Peak current = 5 A; r.m.s. = 5 A$t$,
  option_c = $t$Peak current = 2.5 A; r.m.s. = 1.77 A$t$,
  option_d = $t$Peak current = 10 A; r.m.s. = 7.07 A$t$,
  explanation = $t$Peak EMF = 340 V. Peak current = 340/68 = 5 A. RMS current = peak/√2 = 5/1.414 ≈ 3.54 A. RMS values are used for power calculations (equivalent DC values). RMS = peak/√2 for sinusoidal AC. Check: RMS power = I_rms² × R = 3.54² × 68 ≈ 852 W = V_rms²/R = (340/√2)²/68.$t$
WHERE id = 3833
  AND option_a = $t$Peak current \(= 5\,\text{A}\); r.m.s. \(= 3.54\,\text{A}\)$t$
  AND option_b = $t$Peak current \(= 5\,\text{A}\); r.m.s. \(= 5\,\text{A}\)$t$
  AND option_c = $t$Peak current \(= 2.5\,\text{A}\); r.m.s. \(= 1.77\,\text{A}\)$t$
  AND option_d = $t$Peak current \(= 10\,\text{A}\); r.m.s. \(= 7.07\,\text{A}\)$t$
  AND explanation = $t$Peak \(EMF = 340\,\text{V}\). Peak current \(= \frac{340}{68} = 5\,\text{A}\). RMS current = peak/\(\sqrt{2} = \frac{5}{1.414} \approx 3.54\,\text{A}\). RMS values are used for power calculations (equivalent DC values). RMS = peak/\(\sqrt{2}\) for sinusoidal AC. Check: RMS power \(= I\)_\(rms^{2} \times R = 3.54^{2} \times 68 \approx 852 W = V\)_\(\frac{rms^{2}}{R} = \frac{(\frac{340}{\sqrt{2}})^{2}}{68}\).$t$;

UPDATE questions SET
  question_text = $t$Transformer: N₁ = 400, N₂ = 50, secondary resistance 12 Ω, primary voltage 240 V, ideal transformer. Calculate secondary and primary current.$t$,
  option_a = $t$Secondary = 2.5 A; primary = 20 A$t$,
  option_b = $t$Secondary = 20 A; primary = 2.5 A$t$,
  option_c = $t$Secondary = 2.5 A; primary = 2.5 A$t$,
  option_d = $t$Secondary = 0.31 A; primary = 2.5 A$t$,
  explanation = $t$Vs/Vp = Ns/Np: Vs = 240×(50/400) = 30 V. Is = Vs/R = 30/12 = 2.5 A. For ideal transformer: Ip = IsVs/Vp = 2.5×30/240 = 0.3125 A. But answer shows primary current = 2.5 A — check if question asks for secondary current only. Apply transformer equations step by step.$t$
WHERE id = 3835
  AND question_text = $t$Transformer: N₁ \(= 400\), N₂ \(= 50\), secondary resistance 12 Ω, primary voltage 240 V, ideal transformer. Calculate secondary and primary current.$t$
  AND option_a = $t$Secondary \(= 2.5\,\text{A}\); primary \(= 20\,\text{A}\)$t$
  AND option_b = $t$Secondary \(= 20\,\text{A}\); primary \(= 2.5\,\text{A}\)$t$
  AND option_c = $t$Secondary \(= 2.5\,\text{A}\); primary \(= 2.5\,\text{A}\)$t$
  AND option_d = $t$Secondary \(= 0.31\,\text{A}\); primary \(= 2.5\,\text{A}\)$t$
  AND explanation = $t$Vs/Vp = Ns/Np: Vs \(= 240 \times (\frac{50}{400}) = 30\,\text{V}\). Is = Vs/\(R = \frac{30}{12} = 2.5\,\text{A}\). For ideal transformer: Ip = IsVs/Vp \(= 2.5 \times \frac{30}{240} = 0.3125\,\text{A}\). But answer shows primary current \(= 2.5\,\text{A}\) — check if question asks for secondary current only. Apply transformer equations step by step.$t$;

UPDATE questions SET
  question_text = $t$A solenoid (1000 turns, current 2 A, flux per turn 4 × 10⁻⁴ Wb) is switched off in 0.01 s. Calculate the induced back-EMF.$t$,
  explanation = $t$Induced EMF = −N×ΔΦ/Δt. When current is switched off, flux drops from NΦ = 1000×4×10⁻⁴ = 0.4 Wb to 0. If switching time = 0.05 s: EMF = 1000×4×10⁻⁴/0.05 = 8 V. The self-induced EMF opposes the change in current (Lenz's Law) — this is why inductors resist rapid current changes.$t$
WHERE id = 3836
  AND question_text = $t$A solenoid (1000 turns, current 2 A, flux per turn \(4 \times 10^{-4}\) Wb) is switched off in 0.01 s. Calculate the induced back-EMF.$t$
  AND explanation = $t$Induced \(EMF = - N\)×ΔΦ/Δ\(t\). When current is switched off, flux drops from NΦ \(= 1000 \times 4 \times 10^{-4} = 0.4\) Wb to 0. If switching time \(= 0.05\,\text{s}\): \(EMF = 1000 \times 4 \times \frac{10^{-4}}{0.05} = 8\,\text{V}\). The self-induced EMF opposes the change in current (Lenz's Law) — this is why inductors resist rapid current changes.$t$;

UPDATE questions SET
  question_text = $t$A gas at 27°C and 1.5 × 10⁵ Pa occupies 4 × 10⁻³ m³. Heated at constant pressure to 127°C. Calculate the new volume.$t$,
  option_a = $t$6 × 10⁻³ m³$t$,
  option_b = $t$3 × 10⁻³ m³$t$,
  option_c = $t$1 × 10⁻³ m³$t$,
  option_d = $t$5.33 × 10⁻³ m³$t$,
  explanation = $t$At constant pressure (isobaric): V₁/T₁ = V₂/T₂ (Charles's Law). T₁=300K, V₁=4×10⁻³m³. T₂=400K. V₂ = V₁×T₂/T₁ = 4×10⁻³×400/300 = 5.33×10⁻³ m³. Always use Kelvin. T₂=127°C+273=400K.$t$
WHERE id = 3839
  AND question_text = $t$A gas at \(27^\circ C\) and \(1.5 \times 10^{5}\,\text{Pa}\) occupies \(4 \times 10^{-3} m^{3}\). Heated at constant pressure to \(127^\circ C\). Calculate the new volume.$t$
  AND option_a = $t$\(6 \times 10^{-3} m^{3}\)$t$
  AND option_b = $t$\(3 \times 10^{-3} m^{3}\)$t$
  AND option_c = $t$\(1 \times 10^{-3} m^{3}\)$t$
  AND option_d = $t$\(5.33 \times 10^{-3} m^{3}\)$t$
  AND explanation = $t$At constant pressure (isobaric): V₁/T₁ = V₂/T₂ (Charles's Law). T₁\(= 300K\), V₁\(= 4 \times 10^{-3}m^{3}\). T₂\(= 400K\). V₂ = V₁×T₂/T₁ \(= 4 \times 10^{-3} \times \frac{400}{300} = 5.33 \times 10^{-3} m^{3}\). Always use Kelvin. T₂\(= 127^\circ C + 273 = 400K\).$t$;

UPDATE questions SET
  question_text = $t$A 2 kg aluminium block at 200°C is placed in 1 kg water at 20°C. Calculate the final temperature. (c_Al = 900 J/kg°C; c_water = 4200 J/kg°C)$t$,
  option_a = $t$200°C$t$,
  option_b = $t$66.7°C$t$,
  option_c = $t$50°C$t$,
  option_d = $t$120°C$t$,
  explanation = $t$Conservation of energy: heat lost by Al = heat gained by water. mAl×cAl×ΔTAl = mwater×cwater×ΔTwater. 2×900×(200−T) = 1×4200×(T−20). Solving: 1800(200−T) = 4200(T−20) → 360000−1800T = 4200T−84000 → 444000 = 6000T → T = 74°C (not 66.7°C — verify c values). Always set heat lost = heat gained.$t$
WHERE id = 3840
  AND question_text = $t$A \(2\,\text{kg}\) aluminium block at \(200^\circ C\) is placed in \(1\,\text{kg}\) water at \(20^\circ C\). Calculate the final temperature. (\(c\)_Al = \(900\,\text{J/kg°C}\); \(c\)_water = \(4200\,\text{J/kg°C}\))$t$
  AND option_a = $t$\(200^\circ C\)$t$
  AND option_b = $t$\(66.7^\circ C\)$t$
  AND option_c = $t$\(50^\circ C\)$t$
  AND option_d = $t$\(120^\circ C\)$t$
  AND explanation = $t$Conservation of energy: heat lost by Al = heat gained by water. mAl×cAl×ΔTAl = mwater×cwater×ΔTwater. \(2 \times 900 \times (200 - T) = 1 \times 4200 \times (T - 20)\). Solving: \(1800(200 - T) = 4200(T - 20) \to 360000 - 1800T = 4200T - 84000 \to 444000 = 6000T \to T = 74^\circ C\) (not \(66.7^\circ C\) — verify \(c\) values). Always set heat lost = heat gained.$t$;

UPDATE questions SET
  question_text = $t$A gas has density 1.2 kg/m³ at 1 × 10⁵ Pa. Show that density is proportional to pressure at constant temperature and calculate the density at 3 × 10⁵ Pa.$t$,
  option_a = $t$3.6 kg/m³ — at constant temperature, pressure is inversely proportional to volume; for fixed mass, density = mass/volume, so density is proportional to pressure$t$,
  option_b = $t$0.4 kg/m³ — pressure and density are inversely proportional$t$,
  option_c = $t$1.2 kg/m³ — density does not depend on pressure for an ideal gas$t$,
  option_d = $t$2.4 kg/m³ — pressure is proportional to the square root of density$t$,
  explanation = $t$At constant temperature, PV = nRT = constant. P ∝ 1/V. If pressure triples (1→3 bar), volume = 1/3. Density = mass/volume. Since mass is fixed and volume ∝ 1/P, density ∝ P. Tripling pressure triples density: 1.2 × 3 = 3.6 kg/m³. This confirms density ∝ pressure at constant T.$t$
WHERE id = 3841
  AND question_text = $t$A gas has density \(1.2\,\text{kg/m}^{3}\) at \(1 \times 10^{5}\,\text{Pa}\). Show that density is proportional to pressure at constant temperature and calculate the density at \(3 \times 10^{5}\,\text{Pa}\).$t$
  AND option_a = $t$\(3.6\,\text{kg/m}^{3}\) — at constant temperature, pressure is inversely proportional to volume; for fixed mass, density = mass/volume, so density is proportional to pressure$t$
  AND option_b = $t$\(0.4\,\text{kg/m}^{3}\) — pressure and density are inversely proportional$t$
  AND option_c = $t$\(1.2\,\text{kg/m}^{3}\) — density does not depend on pressure for an ideal gas$t$
  AND option_d = $t$\(2.4\,\text{kg/m}^{3}\) — pressure is proportional to the square root of density$t$
  AND explanation = $t$At constant temperature, PV = nRT = constant. \(P \propto \frac{1}{V}\). If pressure triples (\(1 \to 3\) bar), volume \(= \frac{1}{3}\). Density = mass/volume. Since mass is fixed and volume \(\propto \frac{1}{P}\), density \(\propto P\). Tripling pressure triples density: \(1.2 \times 3 = 3.6\,\text{kg/m}^{3}\). This confirms density ∝ pressure at constant T.$t$;

UPDATE questions SET
  question_text = $t$A sealed gas syringe: 20°C, 100 kPa. Heated to 80°C while volume doubles. Calculate the new pressure.$t$,
  explanation = $t$Use kelvin: 20 °C = 293 K and 80 °C = 353 K. p₁V₁/T₁ = p₂V₂/T₂, so p₂ = 100 × V × 353 ÷ (293 × 2V) ≈ 60.2 kPa. Doubling the volume halves the pressure; the temperature rise raises it a little.$t$
WHERE id = 3842
  AND question_text = $t$A sealed gas syringe: \(20^\circ C\), 100 kPa. Heated to \(80^\circ C\) while volume doubles. Calculate the new pressure.$t$
  AND explanation = $t$Use kelvin: \(20 ° C = 293\,\text{K}\) and \(80 ° C = 353\,\text{K}\). \(p_{1}\)V₁/T₁ \(= p_{2}\)V₂/T₂, so \(p_{2} = 100 \times V \times 353 \div (293 \times 2V) \approx 60.2\,\text{kPa}\). Doubling the volume halves the pressure; the temperature rise raises it a little.$t$;

UPDATE questions SET
  question_text = $t$A 100 W heater heats 0.5 kg of a substance for 3 minutes; temperature rises 18°C. Calculate specific heat capacity and identify a source of error.$t$,
  option_a = $t$c = 1000 J/kg°C; error: heat loss to surroundings means energy absorbed is less than supplied, so calculated c is too low$t$,
  option_b = $t$c = 2000 J/kg°C; error: heater may not be 100% efficient$t$,
  option_c = $t$c = 1000 J/kg°C; error: temperature should be in Kelvin$t$,
  option_d = $t$c = 500 J/kg°C; error: mass should include the heater$t$,
  explanation = $t$c = Q/(mΔT) = (100×180)/(0.5×ΔT). If ΔT = 36°C: c = 18000/(0.5×36) = 1000 J/kg°C. The systematic error is that the heater has its own heat capacity — some energy heats the heater itself rather than the substance. The calculated c is therefore higher than the true value.$t$
WHERE id = 3843
  AND question_text = $t$A 100 W heater heats \(0.5\,\text{kg}\) of a substance for 3 minutes; temperature rises \(18^\circ C\). Calculate specific heat capacity and identify a source of error.$t$
  AND option_a = $t$\(c = 1000\,\text{J/kg°C}\); error: heat loss to surroundings means energy absorbed is less than supplied, so calculated \(c\) is too low$t$
  AND option_b = $t$\(c = 2000\,\text{J/kg°C}\); error: heater may not be 100% efficient$t$
  AND option_c = $t$\(c = 1000\,\text{J/kg°C}\); error: temperature should be in Kelvin$t$
  AND option_d = $t$\(c = 500\,\text{J/kg°C}\); error: mass should include the heater$t$
  AND explanation = $t$\(c = Q /\)(\(m\)ΔT) \(= (100 \times 180) /\)(0.5×ΔT). If Δ\(T = 36^\circ C\): \(c = \frac{18000}{0.5 \times 36} = 1000\,\text{J/kg°C}\). The systematic error is that the heater has its own heat capacity — some energy heats the heater itself rather than the substance. The calculated \(c\) is therefore higher than the true value.$t$;

UPDATE questions SET
  question_text = $t$Ice at 0°C is continuously heated. Describe the temperature-time graph and explain each stage in terms of particle behaviour.$t$,
  explanation = $t$Temperature-time graph for ice being heated: temperature rises as solid ice warms → flat region at 0°C (melting — latent heat absorbed, temperature constant) → temperature rises again as liquid water warms → flat region at 100°C (boiling — latent heat absorbed) → temperature rises as steam heats. Two horizontal plateaus.$t$
WHERE id = 3844
  AND question_text = $t$Ice at \(0^\circ C\) is continuously heated. Describe the temperature-time graph and explain each stage in terms of particle behaviour.$t$
  AND explanation = $t$Temperature-time graph for ice being heated: temperature rises as solid ice warms → flat region at \(0^\circ C\) (melting — latent heat absorbed, temperature constant) → temperature rises again as liquid water warms → flat region at \(100^\circ C\) (boiling — latent heat absorbed) → temperature rises as steam heats. Two horizontal plateaus.$t$;

UPDATE questions SET
  option_a = $t$Doubling absolute temperature doubles average kinetic energy of molecules (KE ∝ T). Faster molecules collide with walls more frequently and with greater force. Both effects increase pressure, and at constant volume the pressure doubles$t$,
  explanation = $t$Kinetic theory: temperature is proportional to average kinetic energy of molecules. Doubling absolute temperature (in Kelvin) doubles average KE. Since KE = ½mv², average v² doubles, so average speed increases by √2 ≈ 1.41 times (not doubles). The pressure also doubles (from both increased speed and frequency of collisions).$t$
WHERE id = 3845
  AND option_a = $t$Doubling absolute temperature doubles average kinetic energy of molecules \((KE \propto T)\). Faster molecules collide with walls more frequently and with greater force. Both effects increase pressure, and at constant volume the pressure doubles$t$
  AND explanation = $t$Kinetic theory: temperature is proportional to average kinetic energy of molecules. Doubling absolute temperature (in Kelvin) doubles average KE. Since \(KE = \tfrac{1}{2}mv^{2}\), average \(v^{2}\) doubles, so average speed increases by \(\sqrt{2} \approx 1.41\) times (not doubles). The pressure also doubles (from both increased speed and frequency of collisions).$t$;

UPDATE questions SET
  question_text = $t$A material has specific latent heat of vaporisation 2.26 × 10⁶ J/kg. Calculate the energy to vaporise 0.3 kg at its boiling point and explain why vaporisation requires more energy than melting.$t$,
  option_a = $t$Energy = 678 000 J. Vaporisation requires more energy than melting because molecules must be completely separated, fully breaking all intermolecular forces; in melting only the regular lattice is disrupted and molecules remain in contact$t$,
  option_b = $t$Energy = 678 000 J. Vaporisation requires less energy because the substance is already liquid$t$,
  option_c = $t$Energy = 6 780 000 J. Vaporisation requires more energy because the substance gets hotter$t$,
  option_d = $t$Energy = 678 000 J. Vaporisation and melting require the same energy for the same mass$t$,
  explanation = $t$Energy = mL = 0.3 × 2.26×10⁶ = 678 000 J. The specific latent heat of vaporisation is much larger than that of fusion (334 000 J/kg for ice) because vaporisation requires breaking all intermolecular bonds completely, while fusion only partially disrupts the structure.$t$
WHERE id = 3846
  AND question_text = $t$A material has specific latent heat of vaporisation \(2.26 \times 10^{6}\,\text{J}\text{/kg}\). Calculate the energy to vaporise \(0.3\,\text{kg}\) at its boiling point and explain why vaporisation requires more energy than melting.$t$
  AND option_a = $t$Energy \(= 678\,000\,\text{J}\). Vaporisation requires more energy than melting because molecules must be completely separated, fully breaking all intermolecular forces; in melting only the regular lattice is disrupted and molecules remain in contact$t$
  AND option_b = $t$Energy \(= 678\,000\,\text{J}\). Vaporisation requires less energy because the substance is already liquid$t$
  AND option_c = $t$Energy \(= 6\,780\,000\,\text{J}\). Vaporisation requires more energy because the substance gets hotter$t$
  AND option_d = $t$Energy \(= 678\,000\,\text{J}\). Vaporisation and melting require the same energy for the same mass$t$
  AND explanation = $t$Energy = mL \(= 0.3 \times 2.26 \times 10^{6} = 678\,000\,\text{J}\). The specific latent heat of vaporisation is much larger than that of fusion (\(334\,000\,\text{J/kg}\) for ice) because vaporisation requires breaking all intermolecular bonds completely, while fusion only partially disrupts the structure.$t$;

UPDATE questions SET
  question_text = $t$A gas is compressed isothermally from 0.01 m³ at 200 kPa to 0.004 m³. Calculate the new pressure and explain why real gases deviate from ideal behaviour at very high pressures.$t$,
  option_a = $t$New pressure = 500 kPa. Real gases deviate at high pressures because molecular volume and attractive forces between molecules become significant, so pressure is lower than the ideal prediction$t$,
  option_b = $t$New pressure = 80 kPa. Real gases deviate because molecules travel faster at high pressure$t$,
  option_c = $t$New pressure = 500 kPa. Real gases deviate because temperature changes during real compressions$t$,
  option_d = $t$New pressure = 5000 kPa. Real gases deviate because more molecules are created at high pressure$t$,
  explanation = $t$At constant temperature p₁V₁ = p₂V₂, so p₂ = 200 × 0.01 ÷ 0.004 = 500 kPa. Real gases deviate at very high pressure because the molecules' own volume and the attractive forces between them are no longer negligible.$t$
WHERE id = 3847
  AND question_text = $t$A gas is compressed isothermally from \(0.01 m^{3}\) at 200 kPa to \(0.004 m^{3}\). Calculate the new pressure and explain why real gases deviate from ideal behaviour at very high pressures.$t$
  AND option_a = $t$New pressure \(= 500\,\text{kPa}\). Real gases deviate at high pressures because molecular volume and attractive forces between molecules become significant, so pressure is lower than the ideal prediction$t$
  AND option_b = $t$New pressure \(= 80\,\text{kPa}\). Real gases deviate because molecules travel faster at high pressure$t$
  AND option_c = $t$New pressure \(= 500\,\text{kPa}\). Real gases deviate because temperature changes during real compressions$t$
  AND option_d = $t$New pressure \(= 5000\,\text{kPa}\). Real gases deviate because more molecules are created at high pressure$t$
  AND explanation = $t$At constant temperature \(p_{1}\)V₁ \(= p_{2}\)V₂, so \(p_{2} = 200 \times 0.01 \div 0.004 = 500\,\text{kPa}\). Real gases deviate at very high pressure because the molecules' own volume and the attractive forces between them are no longer negligible.$t$;

UPDATE questions SET
  question_text = $t$An athlete breathes out 0.5 L per breath at 37°C (310 K) and 101 kPa. The air expands in cold air at 5°C (278 K). Calculate the new pressure if volume becomes 0.55 L.$t$,
  explanation = $t$Using ideal gas law: P₁V₁/T₁ = P₂V₂/T₂. V is constant (breath volume). T₁=310K, T₂ = alveolar temperature (also ~310K in lungs). If atmospheric pressure P₁=101 kPa: at body temperature T same, so P₂=P₁×T₂/T₁ — but the atmospheric measurement converts to alveolar conditions. P₂ = 101×300/333 ≈ 91 kPa.$t$
WHERE id = 3848
  AND question_text = $t$An athlete breathes out 0.5 L per breath at \(37^\circ C (310\,\text{K})\) and 101 kPa. The air expands in cold air at \(5^\circ C (278\,\text{K})\). Calculate the new pressure if volume becomes 0.55 L.$t$
  AND explanation = $t$Using ideal gas law: P₁V₁/T₁ = P₂V₂/T₂. V is constant (breath volume). T₁\(= 310K\), T₂ = alveolar temperature (also ~\(310K\) in lungs). If atmospheric pressure P₁\(= 101\,\text{kPa}\): at body temperature T same, so P₂=P₁×T₂/T₁ — but the atmospheric measurement converts to alveolar conditions. P₂ \(= 101 \times \frac{300}{333} \approx 91\,\text{kPa}\).$t$;

UPDATE questions SET
  option_a = $t$13 500 m/s$t$,
  option_b = $t$15 m/s$t$,
  option_c = $t$30 m/s$t$,
  option_d = $t$0.07 m/s$t$,
  explanation = $t$Speed = distance ÷ time = 450 ÷ 30 = 15 m/s. A common mistake is to multiply distance by time — always divide distance by time to find speed.$t$
WHERE id = 4130
  AND option_a = $t$\(13\,500\,\text{m/s}\)$t$
  AND option_b = $t$\(15\,\text{m/s}\)$t$
  AND option_c = $t$\(30\,\text{m/s}\)$t$
  AND option_d = $t$\(0.07\,\text{m/s}\)$t$
  AND explanation = $t$Speed = distance ÷ time \(= 450 \div 30 = 15\,\text{m/s}\). A common mistake is to multiply distance by time — always divide distance by time to find speed.$t$;

UPDATE questions SET
  question_text = $t$A 4 kg object accelerates at 3 m/s². What is the resultant force acting on it?$t$,
  explanation = $t$Using F = ma: F = 4 × 3 = 12 N. Students often confuse mass and weight, or divide instead of multiply — the resultant force equals mass multiplied by acceleration.$t$
WHERE id = 4132
  AND question_text = $t$A \(4\,\text{kg}\) object accelerates at \(3\,\text{m/s}^{2}\). What is the resultant force acting on it?$t$
  AND explanation = $t$Using \(F = ma\): \(F = 4 \times 3 = 12\,\text{N}\). Students often confuse mass and weight, or divide instead of multiply — the resultant force equals mass multiplied by acceleration.$t$;

UPDATE questions SET
  question_text = $t$A 1000 kg car changes velocity from 10 m/s to 25 m/s in 5 seconds. Calculate the resultant force.$t$,
  explanation = $t$F = ma, where a = (v−u)/t = (25−10)/5 = 3 m/s². So F = 1000 × 3 = 3000 N. A common error is forgetting to calculate the change in velocity first before applying F = ma.$t$
WHERE id = 4134
  AND question_text = $t$A \(1000\,\text{kg}\) car changes velocity from \(10\,\text{m/s}\) to \(25\,\text{m/s}\) in 5 seconds. Calculate the resultant force.$t$
  AND explanation = $t$\(F = ma\), where \(a = \frac{v - u}{t} = \frac{25 - 10}{5} = 3\,\text{m/s}^{2}\). So \(F = 1000 \times 3 = 3000\,\text{N}\). A common error is forgetting to calculate the change in velocity first before applying \(F = ma\).$t$;

UPDATE questions SET
  question_text = $t$A ball of mass 0.5 kg moves at 8 m/s. Calculate its momentum.$t$,
  option_a = $t$16 kg m/s$t$,
  option_b = $t$8 kg m/s$t$,
  option_c = $t$0.0625 kg m/s$t$,
  option_d = $t$4 kg m/s$t$,
  explanation = $t$Momentum = mass × velocity = 0.5 × 8 = 4 kg m/s. Students often confuse momentum with kinetic energy — momentum uses velocity directly (not squared) and is measured in kg m/s, not joules.$t$
WHERE id = 4136
  AND question_text = $t$A ball of mass \(0.5\,\text{kg}\) moves at \(8\,\text{m/s}\). Calculate its momentum.$t$
  AND option_a = $t$\(16\,\text{kg m/s}\)$t$
  AND option_b = $t$\(8\,\text{kg m/s}\)$t$
  AND option_c = $t$\(0.0625\,\text{kg m/s}\)$t$
  AND option_d = $t$\(4\,\text{kg m/s}\)$t$
  AND explanation = $t$Momentum = mass × velocity \(= 0.5 \times 8 = 4\,\text{kg m/s}\). Students often confuse momentum with kinetic energy — momentum uses velocity directly (not squared) and is measured in kg m/s, not joules.$t$;

UPDATE questions SET
  explanation = $t$The area under a velocity-time graph equals the distance travelled. The gradient gives acceleration — do not confuse area with gradient. Area = base × height for rectangles, or ½ × base × height for triangles.$t$
WHERE id = 4137
  AND explanation = $t$The area under a velocity-time graph equals the distance travelled. The gradient gives acceleration — do not confuse area with gradient. Area = base × height for rectangles, or \(\tfrac{1}{2}\)× base × height for triangles.$t$;

UPDATE questions SET
  question_text = $t$A car of mass 800 kg travels at 20 m/s. The brakes apply a force of 4000 N. How long does the car take to stop?$t$,
  explanation = $t$First find deceleration: a = F/m = 4000/800 = 5 m/s². Then using v = u + at: 0 = 20 − 5t, so t = 4 s. Always find acceleration first, then use it to find time.$t$
WHERE id = 4138
  AND question_text = $t$A car of mass \(800\,\text{kg}\) travels at \(20\,\text{m/s}\). The brakes apply a force of 4000 N. How long does the car take to stop?$t$
  AND explanation = $t$First find deceleration: \(a = \frac{F}{m} = \frac{4000}{800} = 5\,\text{m/s}^{2}\). Then using \(v = u\)+ at: \(0 = 20 - 5t\), so \(t = 4\,\text{s}\). Always find acceleration first, then use it to find time.$t$;

UPDATE questions SET
  explanation = $t$Alpha radiation consists of a helium nucleus: 2 protons and 2 neutrons (mass number 4, charge +2). Beta particles are fast electrons; gamma is electromagnetic radiation with no mass or charge — all three are very different.$t$
WHERE id = 4140
  AND explanation = $t$Alpha radiation consists of a helium nucleus: 2 protons and 2 neutrons (mass number 4, charge \(+ 2\)). Beta particles are fast electrons; gamma is electromagnetic radiation with no mass or charge — all three are very different.$t$;

UPDATE questions SET
  option_a = $t$1/2$t$,
  option_b = $t$1/4$t$,
  option_c = $t$1/6$t$,
  option_d = $t$1/8$t$,
  explanation = $t$After each half-life the amount halves. 12 hours ÷ 4 hours = 3 half-lives: ½ → ¼ → ⅛ remains. Students often divide incorrectly — apply repeated halving, one step per half-life.$t$
WHERE id = 4142
  AND option_a = $t$\(\frac{1}{2}\)$t$
  AND option_b = $t$\(\frac{1}{4}\)$t$
  AND option_c = $t$\(\frac{1}{6}\)$t$
  AND option_d = $t$\(\frac{1}{8}\)$t$
  AND explanation = $t$After each half-life the amount halves. 12 hours \(\div 4\) hours \(= 3\) half-lives: \(\tfrac{1}{2} \to \tfrac{1}{4}\)→ ⅛ remains. Students often divide incorrectly — apply repeated halving, one step per half-life.$t$;

UPDATE questions SET
  explanation = $t$Mass number = protons + neutrons = 17 + 18 = 35. The mass number is always the larger number; the proton number (17) identifies the element (chlorine). Never add them when finding one of them — check which is given.$t$
WHERE id = 4144
  AND explanation = $t$Mass number = protons + neutrons \(= 17 + 18 = 35\). The mass number is always the larger number; the proton number (17) identifies the element (chlorine). Never add them when finding one of them — check which is given.$t$;

UPDATE questions SET
  explanation = $t$After one half-life: 800 ÷ 2 = 400 Bq. After two half-lives: 400 ÷ 2 = 200 Bq. Each half-life halves the activity — apply the halving twice, not once, and do not subtract the half-life from the activity.$t$
WHERE id = 4147
  AND explanation = $t$After one half-life: \(800 \div 2 = 400\) Bq. After two half-lives: \(400 \div 2 = 200\) Bq. Each half-life halves the activity — apply the halving twice, not once, and do not subtract the half-life from the activity.$t$;

UPDATE questions SET
  option_a = $t$20 N m$t$,
  option_b = $t$80 N m$t$,
  option_c = $t$0.0125 N m$t$,
  option_d = $t$40.5 N m$t$,
  explanation = $t$Moment = force × perpendicular distance = 40 × 0.5 = 20 N m. Always multiply the force by the perpendicular distance from the pivot — do not add them or use the angled distance.$t$
WHERE id = 4160
  AND option_a = $t$20 N \(m\)$t$
  AND option_b = $t$80 N \(m\)$t$
  AND option_c = $t$0.0125 N \(m\)$t$
  AND option_d = $t$40.5 N \(m\)$t$
  AND explanation = $t$Moment = force × perpendicular distance \(= 40 \times 0.5 = 20\,\text{N}\ m\). Always multiply the force by the perpendicular distance from the pivot — do not add them or use the angled distance.$t$;

UPDATE questions SET
  option_a = $t$80 N/m$t$,
  option_b = $t$5 N/m$t$,
  option_c = $t$500 N/m$t$,
  option_d = $t$0.002 N/m$t$,
  explanation = $t$k = F ÷ x. Convert 4 cm to 0.04 m first. k = 20 ÷ 0.04 = 500 N/m. Always convert centimetres to metres before calculating the spring constant, otherwise the answer is 100 times too large.$t$
WHERE id = 4161
  AND option_a = $t$\(80\,\text{N/m}\)$t$
  AND option_b = $t$\(5\,\text{N/m}\)$t$
  AND option_c = $t$\(500\,\text{N/m}\)$t$
  AND option_d = $t$\(0.002\,\text{N/m}\)$t$
  AND explanation = $t$\(k = F \div x\). Convert 4 cm to 0.04 m first. \(k = 20 \div 0.04 = 500\,\text{N/m}\). Always convert centimetres to metres before calculating the spring constant, otherwise the answer is 100 times too large.$t$;

UPDATE questions SET
  explanation = $t$Pressure is measured in Pascals (Pa), where 1 Pa = 1 N/m². It is force divided by area. Newtons measure force, Joules measure energy, and Watts measure power — do not confuse these units.$t$
WHERE id = 4162
  AND explanation = $t$Pressure is measured in Pascals (Pa), where 1 Pa = \(1\,\text{N/m}^{2}\). It is force divided by area. Newtons measure force, Joules measure energy, and Watts measure power — do not confuse these units.$t$;

UPDATE questions SET
  explanation = $t$For a balanced see-saw, clockwise moment = anticlockwise moment. 400 × 1.5 = 600 N m. So 600 N × d = 600 N m, giving d = 1 m. A heavier child sits closer to the pivot to produce the same moment.$t$
WHERE id = 4163
  AND explanation = $t$For a balanced see-saw, clockwise moment = anticlockwise moment. \(400 \times 1.5 = 600\,\text{N}\ m\). So \(600\,\text{N} \times d = 600\,\text{N}\ m\), giving \(d = 1\,\text{m}\). A heavier child sits closer to the pivot to produce the same moment.$t$;

UPDATE questions SET
  question_text = $t$What is the elastic potential energy stored in a spring with spring constant 200 N/m stretched by 0.1 m?$t$,
  explanation = $t$Elastic PE = ½kx² = ½ × 200 × 0.1² = ½ × 200 × 0.01 = 1 J. Students often forget the ½ or fail to square the extension — both errors are very common in exams.$t$
WHERE id = 4164
  AND question_text = $t$What is the elastic potential energy stored in a spring with spring constant \(200\,\text{N/m}\) stretched by 0.1 m?$t$
  AND explanation = $t$Elastic \(PE = \tfrac{1}{2}kx^{2} = \tfrac{1}{2} \times 200 \times 0.1^{2} = \tfrac{1}{2} \times 200 \times 0.01 = 1\,\text{J}\). Students often forget the \(\tfrac{1}{2}\) or fail to square the extension — both errors are very common in exams.$t$;

UPDATE questions SET
  question_text = $t$A force of 300 N acts on an area of 0.05 m². Calculate the pressure.$t$,
  explanation = $t$Pressure = force ÷ area = 300 ÷ 0.05 = 6000 Pa. Always divide force by area — never multiply. The units work out: N ÷ m² = Pa.$t$
WHERE id = 4165
  AND question_text = $t$A force of 300 N acts on an area of \(0.05 m^{2}\). Calculate the pressure.$t$
  AND explanation = $t$Pressure = force ÷ area \(= 300 \div 0.05 = 6000\,\text{Pa}\). Always divide force by area — never multiply. The units work out: \(N \div m^{2}\)= Pa.$t$;

UPDATE questions SET
  question_text = $t$In a hydraulic system, a small piston of area 0.01 m² has a force of 50 N applied to it. What pressure is transmitted through the fluid?$t$,
  explanation = $t$Pressure = F ÷ A = 50 ÷ 0.01 = 5000 Pa. In a hydraulic system this same pressure is transmitted throughout the fluid to the large piston. The large piston produces a greater force because it has a greater area (F = P × A).$t$
WHERE id = 4167
  AND question_text = $t$In a hydraulic system, a small piston of area \(0.01 m^{2}\) has a force of 50 N applied to it. What pressure is transmitted through the fluid?$t$
  AND explanation = $t$Pressure \(= F \div A = 50 \div 0.01 = 5000\,\text{Pa}\). In a hydraulic system this same pressure is transmitted throughout the fluid to the large piston. The large piston produces a greater force because it has a greater area \((F = P \times A)\).$t$;

UPDATE questions SET
  explanation = $t$Taking moments about the pivot: 40 N × 1 m = 40 N m anticlockwise. For balance: 50 × d = 40, so d = 0.8 m. The 100 N beam weight acts at the pivot so creates no moment.$t$
WHERE id = 4168
  AND explanation = $t$Taking moments about the pivot: \(40\,\text{N} \times 1 m = 40\,\text{N}\ m\) anticlockwise. For balance: \(50 \times d = 40\), so \(d = 0.8 m\). The 100 N beam weight acts at the pivot so creates no moment.$t$;

UPDATE questions SET
  explanation = $t$For perpendicular forces use Pythagoras: resultant = √(6² + 8²) = √(36 + 64) = √100 = 10 N. Simply adding (6+8=14) only works when forces act in the same direction — always use Pythagoras for perpendicular forces.$t$
WHERE id = 4169
  AND explanation = $t$For perpendicular forces use Pythagoras: resultant \(= \sqrt{6^{2} + 8^{2}} = \sqrt{36 + 64} = \sqrt{100} = 10\,\text{N}\). Simply adding \((6 + 8 = 14)\) only works when forces act in the same direction — always use Pythagoras for perpendicular forces.$t$;

UPDATE questions SET
  explanation = $t$Using Ohm's Law: I = V ÷ R = 9 ÷ 18 = 0.5 A. Always remember I = V/R. The most common error is inverting the formula — if resistance is large, current is small, not large.$t$
WHERE id = 4170
  AND explanation = $t$Using Ohm's Law: \(I = V \div R = 9 \div 18 = 0.5\,\text{A}\). Always remember \(I = \frac{V}{R}\). The most common error is inverting the formula — if resistance is large, current is small, not large.$t$;

UPDATE questions SET
  explanation = $t$In a series circuit, total resistance = 4 + 6 = 10 Ω. Current = V ÷ R = 20 ÷ 10 = 2 A. In series, resistances add directly. Do not use the parallel formula (1/R = 1/R₁ + 1/R₂) for series circuits.$t$
WHERE id = 4171
  AND explanation = $t$In a series circuit, total resistance \(= 4 + 6 = 10\) Ω. Current \(= V \div R = 20 \div 10 = 2\,\text{A}\). In series, resistances add directly. Do not use the parallel formula (\(\frac{1}{R} = 1\)/R₁ \(+ 1\)/R₂) for series circuits.$t$;

UPDATE questions SET
  explanation = $t$Current = power ÷ voltage = 800 ÷ 230 ≈ 3.48 A. This determines the fuse rating needed. Do not multiply — power is V × I, so I = P/V.$t$
WHERE id = 4173
  AND explanation = $t$Current = power ÷ voltage \(= 800 \div 230 \approx 3.48\,\text{A}\). This determines the fuse rating needed. Do not multiply — power is \(V \times I\), so \(I = \frac{P}{V}\).$t$;

UPDATE questions SET
  explanation = $t$For two equal resistors in parallel: total resistance = R ÷ 2 = 12 ÷ 2 = 6 Ω. In parallel, resistance always decreases below the smallest individual resistor. Adding them (12+12=24) is the series formula — wrong here.$t$
WHERE id = 4174
  AND explanation = $t$For two equal resistors in parallel: total resistance \(= R \div 2 = 12 \div 2 = 6\) Ω. In parallel, resistance always decreases below the smallest individual resistor. Adding them \((12 + 12 = 24)\) is the series formula — wrong here.$t$;

UPDATE questions SET
  explanation = $t$Energy = power × time = 60 × (5 × 60) = 60 × 300 = 18 000 J. Always convert minutes to seconds before calculating energy. Power in watts × time in seconds = energy in joules.$t$
WHERE id = 4175
  AND explanation = $t$Energy = power × time \(= 60 \times (5 \times 60) = 60 \times 300 = 18\,000\,\text{J}\). Always convert minutes to seconds before calculating energy. Power in watts × time in seconds = energy in joules.$t$;

UPDATE questions SET
  explanation = $t$Current = P ÷ V = 1200 ÷ 230 ≈ 5.2 A. The fuse must be rated above the working current — the next standard size above 5.2 A is 13 A. A 3 A fuse would blow immediately; a 30 A fuse provides no protection.$t$
WHERE id = 4178
  AND explanation = $t$Current \(= P \div V = 1200 \div 230 \approx 5.2\,\text{A}\). The fuse must be rated above the working current — the next standard size above 5.2 A is 13 A. A 3 A fuse would blow immediately; a 30 A fuse provides no protection.$t$;

UPDATE questions SET
  explanation = $t$Current = charge ÷ time = 60 ÷ 20 = 3 A. Using Q = It rearranged: I = Q/t. Do not multiply charge by time — that gives coulombs squared. Check: 3 A × 20 s = 60 C ✓.$t$
WHERE id = 4179
  AND explanation = $t$Current = charge ÷ time \(= 60 \div 20 = 3\,\text{A}\). Using Q = It rearranged: \(I = \frac{Q}{t}\). Do not multiply charge by time — that gives coulombs squared. Check: \(3\,\text{A} \times 20 s = 60\,\text{C} \checkmark\).$t$;

UPDATE questions SET
  option_a = $t$90° (perpendicular)$t$,
  option_b = $t$45°$t$,
  option_c = $t$0° (parallel)$t$,
  option_d = $t$180°$t$,
  explanation = $t$The force F = BIL is maximum when the conductor is perpendicular (90°) to the magnetic field. When parallel (0°), the force is zero. The full formula is F = BIL sin θ, which is maximum when θ = 90°.$t$
WHERE id = 4186
  AND option_a = $t$\(90^\circ\) (perpendicular)$t$
  AND option_b = $t$\(45^\circ\)$t$
  AND option_c = $t$\(0^\circ\) (parallel)$t$
  AND option_d = $t$\(180^\circ\)$t$
  AND explanation = $t$The force \(F = BIL\) is maximum when the conductor is perpendicular \((90^\circ)\) to the magnetic field. When parallel \((0^\circ)\), the force is zero. The full formula is \(F = BIL \sin \theta\), which is maximum when \(\theta = 90^\circ\).$t$;

UPDATE questions SET
  explanation = $t$F = BIL = 0.5 × 3 × 0.4 = 0.6 N. All three factors — flux density (B), current (I) and length (L) — are multiplied together. Forgetting any one factor will give the wrong answer.$t$
WHERE id = 4187
  AND explanation = $t$\(F = BIL = 0.5 \times 3 \times 0.4 = 0.6\,\text{N}\). All three factors — flux density (B), current (I) and length (L) — are multiplied together. Forgetting any one factor will give the wrong answer.$t$;

UPDATE questions SET
  explanation = $t$Using Vs/Vp = Ns/Np: Vs = 240 × (50/200) = 60 V. Fewer secondary turns means lower secondary voltage — this is a step-down transformer. Check: 50/200 = 0.25, and 240 × 0.25 = 60 V ✓.$t$
WHERE id = 4191
  AND explanation = $t$Using Vs/Vp = Ns/Np: Vs \(= 240 \times (\frac{50}{200}) = 60\,\text{V}\). Fewer secondary turns means lower secondary voltage — this is a step-down transformer. Check: \(\frac{50}{200} = 0.25\), and \(240 \times 0.25 = 60\,\text{V} \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$High voltage means low current (P = IV). Power lost as heat = I²R — so lower current means dramatically less power lost in cables. This is why the National Grid transmits at 400 000 V, not at the generation voltage.$t$
WHERE id = 4192
  AND explanation = $t$High voltage means low current \((P = IV)\). Power lost as heat \(= I^{2}R\) — so lower current means dramatically less power lost in cables. This is why the National Grid transmits at 400 000 V, not at the generation voltage.$t$;

UPDATE questions SET
  explanation = $t$Using Ns/Np = Vs/Vp: Ns = 4000 × (230/11000) ≈ 84 turns. The large step-down ratio (11000:230) means very few secondary turns compared to primary turns.$t$
WHERE id = 4195
  AND explanation = $t$Using Ns/Np = Vs/Vp: Ns \(= 4000 \times (\frac{230}{11000}) \approx 84\) turns. The large step-down ratio (\(11000 : 230\)) means very few secondary turns compared to primary turns.$t$;

UPDATE questions SET
  explanation = $t$Using power conservation (100% efficient): Ip × Vp = Is × Vs. Secondary voltage = 250 × (100/500) = 50 V. Is = (0.4 × 250) ÷ 50 = 2 A. Check: 0.4 × 250 = 100 W = 2 × 50 W ✓.$t$
WHERE id = 4199
  AND explanation = $t$Using power conservation (100% efficient): Ip × Vp = Is × Vs. Secondary voltage \(= 250 \times (\frac{100}{500}) = 50\,\text{V}\). Is \(= (0.4 \times 250) \div 50 = 2\,\text{A}\). Check: \(0.4 \times 250 = 100 W = 2 \times 50 W \checkmark\).$t$;

UPDATE questions SET
  question_text = $t$Calculate the density of an object with mass 500 g and volume 250 cm³.$t$,
  option_a = $t$2 g/cm³$t$,
  option_b = $t$125 000 g/cm³$t$,
  option_c = $t$0.5 g/cm³$t$,
  option_d = $t$750 g/cm³$t$,
  explanation = $t$Density = mass ÷ volume = 500 ÷ 250 = 2 g/cm³. Always divide mass by volume — a very common error is to multiply, or to invert the division and get 0.5 instead of 2.$t$
WHERE id = 4201
  AND question_text = $t$Calculate the density of an object with mass \(500\,\text{g}\) and volume \(250\,\text{cm}^{3}\).$t$
  AND option_a = $t$\(2\,\text{g/cm}^{3}\)$t$
  AND option_b = $t$\(125\,000\,\text{g/cm}^{3}\)$t$
  AND option_c = $t$\(0.5\,\text{g/cm}^{3}\)$t$
  AND option_d = $t$\(750\,\text{g/cm}^{3}\)$t$
  AND explanation = $t$Density = mass ÷ volume \(= 500 \div 250 = 2\,\text{g/cm}^{3}\). Always divide mass by volume — a very common error is to multiply, or to invert the division and get 0.5 instead of 2.$t$;

UPDATE questions SET
  explanation = $t$At constant volume, P ∝ T (in Kelvin). P₁/T₁ = P₂/T₂. Doubling the absolute temperature (300 K → 600 K) doubles the pressure. Crucially, you must use Kelvin — doubling Celsius temperature does not double the pressure.$t$
WHERE id = 4202
  AND explanation = $t$At constant volume, \(P \propto T\) (in Kelvin). P₁/T₁ = P₂/T₂. Doubling the absolute temperature \((300\,\text{K} \to 600\,\text{K})\) doubles the pressure. Crucially, you must use Kelvin — doubling Celsius temperature does not double the pressure.$t$;

UPDATE questions SET
  option_a = $t$The energy needed to melt 1 kg of a substance$t$,
  option_b = $t$The energy needed to raise the temperature of 1 kg of a substance by 1°C$t$,
  option_c = $t$The energy released when 1 kg of a substance cools by 1°C$t$,
  option_d = $t$The energy needed to vaporise 1 kg of a substance$t$,
  explanation = $t$Specific heat capacity is the energy needed to raise 1 kg of a substance by 1°C. It is not related to melting or vaporising — those involve latent heat, which is the energy for a change of state at constant temperature.$t$
WHERE id = 4203
  AND option_a = $t$The energy needed to melt \(1\,\text{kg}\) of a substance$t$
  AND option_b = $t$The energy needed to raise the temperature of \(1\,\text{kg}\) of a substance by \(1^\circ C\)$t$
  AND option_c = $t$The energy released when \(1\,\text{kg}\) of a substance cools by \(1^\circ C\)$t$
  AND option_d = $t$The energy needed to vaporise \(1\,\text{kg}\) of a substance$t$
  AND explanation = $t$Specific heat capacity is the energy needed to raise \(1\,\text{kg}\) of a substance by \(1^\circ C\). It is not related to melting or vaporising — those involve latent heat, which is the energy for a change of state at constant temperature.$t$;

UPDATE questions SET
  question_text = $t$Calculate the energy needed to heat 3 kg of water from 20°C to 80°C. (Specific heat capacity of water = 4200 J/kg°C)$t$,
  explanation = $t$E = mcΔT = 3 × 4200 × 60 = 756 000 J. The three factors are mass, specific heat capacity and temperature change (ΔT = 80−20 = 60°C). Using the final temperature (80) instead of the change (60) is the most common error.$t$
WHERE id = 4204
  AND question_text = $t$Calculate the energy needed to heat \(3\,\text{kg}\) of water from \(20^\circ C\) to \(80^\circ C\). (Specific heat capacity of water = \(4200\,\text{J/kg°C}\))$t$
  AND explanation = $t$\(E = mc\)Δ\(T = 3 \times 4200 \times 60 = 756\,000\,\text{J}\). The three factors are mass, specific heat capacity and temperature change (Δ\(T = 80 - 20 = 60^\circ C\)). Using the final temperature (80) instead of the change (60) is the most common error.$t$;

UPDATE questions SET
  option_a = $t$The energy needed to raise the temperature of a liquid by 1°C$t$
WHERE id = 4205
  AND option_a = $t$The energy needed to raise the temperature of a liquid by \(1^\circ C\)$t$;

UPDATE questions SET
  question_text = $t$A gas at pressure 100 000 Pa occupies volume 0.5 m³. At constant temperature, what is the new pressure when the volume is reduced to 0.25 m³?$t$,
  explanation = $t$Using Boyle's Law: P₁V₁ = P₂V₂ → 100 000 × 0.5 = P₂ × 0.25 → P₂ = 200 000 Pa. Halving the volume doubles the pressure at constant temperature. Always check units are consistent.$t$
WHERE id = 4206
  AND question_text = $t$A gas at pressure 100 000 Pa occupies volume \(0.5 m^{3}\). At constant temperature, what is the new pressure when the volume is reduced to \(0.25 m^{3}\)?$t$
  AND explanation = $t$Using Boyle's Law: P₁V₁ = P₂V₂ →\(100\,000 \times 0.5\)= P₂ \(\times 0.25\)→ P₂ \(= 200\,000\,\text{Pa}\). Halving the volume doubles the pressure at constant temperature. Always check units are consistent.$t$;

UPDATE questions SET
  question_text = $t$An object has volume 40 cm³ and density 8 g/cm³. Calculate its mass.$t$,
  explanation = $t$Mass = density × volume = 8 × 40 = 320 g. Rearrange density = mass/volume to get mass = density × volume. A common error is to divide density by volume instead of multiplying.$t$
WHERE id = 4209
  AND question_text = $t$An object has volume \(40\,\text{cm}^{3}\) and density \(8\,\text{g/cm}^{3}\). Calculate its mass.$t$
  AND explanation = $t$Mass = density × volume \(= 8 \times 40 = 320\,\text{g}\). Rearrange density = mass/volume to get mass = density × volume. A common error is to divide density by volume instead of multiplying.$t$;

UPDATE questions SET
  explanation = $t$Work done = force × distance = 50 × 8 = 400 J. This formula applies when force and displacement are parallel (same direction). Work done equals energy transferred. If the force is at an angle θ to displacement: W = Fd cos θ.$t$
WHERE id = 4490
  AND explanation = $t$Work done = force × distance \(= 50 \times 8 = 400\,\text{J}\). This formula applies when force and displacement are parallel (same direction). Work done equals energy transferred. If the force is at an angle \(\theta\) to displacement: W = Fd \(\cos \theta\).$t$;

UPDATE questions SET
  question_text = $t$What is the gravitational potential energy of a 5 kg object raised 4 m? (g = 10 N/kg)$t$,
  explanation = $t$GPE = mgh = 5 × 10 × 4 = 200 J. All three quantities must be multiplied. A common error is using weight (50 N) without then multiplying by g again — weight = mg, so GPE = weight × height = 50 × 4 = 200 J also gives the same answer here.$t$
WHERE id = 4491
  AND question_text = $t$What is the gravitational potential energy of \(a\) \(5\,\text{kg}\) object raised 4 m? (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$\(GPE = mgh = 5 \times 10 \times 4 = 200\,\text{J}\). All three quantities must be multiplied. A common error is using weight (50 N) without then multiplying by \(g\) again — weight \(= mg\), so GPE = weight × height \(= 50 \times 4 = 200\,\text{J}\) also gives the same answer here.$t$;

UPDATE questions SET
  question_text = $t$Calculate the kinetic energy of a 2 kg ball moving at 6 m/s.$t$,
  explanation = $t$KE = ½mv² = ½ × 2 × 6² = ½ × 2 × 36 = 36 J. Square the velocity first, then multiply by ½m. A very common error is to square ½m or to forget squaring v altogether. The unit is joules (J).$t$
WHERE id = 4492
  AND question_text = $t$Calculate the kinetic energy of \(a\) \(2\,\text{kg}\) ball moving at \(6\,\text{m/s}\).$t$
  AND explanation = $t$\(KE = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 2 \times 6^{2} = \tfrac{1}{2} \times 2 \times 36 = 36\,\text{J}\). Square the velocity first, then multiply by \(\tfrac{1}{2}m\). A very common error is to square \(\tfrac{1}{2}m\) or to forget squaring \(v\) altogether. The unit is joules (J).$t$;

UPDATE questions SET
  explanation = $t$Power = energy (work done) ÷ time = 600 ÷ 20 = 30 W. Power is the rate of energy transfer — how much energy per second. One watt = one joule per second. Divide work done (J) by time (s) to get power (W).$t$
WHERE id = 4493
  AND explanation = $t$Power = energy (work done) ÷ time \(= 600 \div 20 = 30\,\text{W}\). Power is the rate of energy transfer — how much energy per second. One watt = one joule per second. Divide work done (J) by time (\(s\)) to get power (W).$t$;

UPDATE questions SET
  question_text = $t$A 4 kg ball is dropped from a height of 5 m. Using conservation of energy, calculate its speed just before hitting the ground. (g = 10 N/kg)$t$,
  option_a = $t$20 m/s$t$,
  option_b = $t$10 m/s$t$,
  option_c = $t$5 m/s$t$,
  option_d = $t$√200 ≈ 14.1 m/s$t$,
  explanation = $t$Conservation of energy: GPE at top = KE at bottom (frictionless). mgh = ½mv² → mass cancels → v² = 2gh = 2×10×5 = 100 → v = 10 m/s. The mass cancels, so the speed is independent of mass. Check: ½×4×100 = 200 J = 4×10×5 = 200 J ✓.$t$
WHERE id = 4494
  AND question_text = $t$A \(4\,\text{kg}\) ball is dropped from a height of 5 m. Using conservation of energy, calculate its speed just before hitting the ground. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(20\,\text{m/s}\)$t$
  AND option_b = $t$\(10\,\text{m/s}\)$t$
  AND option_c = $t$\(5\,\text{m/s}\)$t$
  AND option_d = $t$\(\sqrt{200}\)≈ \(14.1\,\text{m/s}\)$t$
  AND explanation = $t$Conservation of energy: GPE at \(top = KE\) at bottom (frictionless). \(mgh = \tfrac{1}{2}mv^{2}\)→ mass cancels →\(v^{2} = 2gh = 2 \times 10 \times 5 = 100 \to v = 10\,\text{m/s}\). The mass cancels, so the speed is independent of mass. Check: \(\tfrac{1}{2} \times 4 \times 100 = 200 J = 4 \times 10 \times 5 = 200 J \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$Efficiency = (useful output ÷ total input) × 100% = (300 ÷ 500) × 100% = 60%. Always express as a decimal first (0.6) then multiply by 100 for a percentage. Efficiency can never exceed 100% — energy cannot be created from nothing.$t$
WHERE id = 4495
  AND explanation = $t$Efficiency \(= \dfrac{\text{useful output}}{\text{total input}} \times 100\% = (300 \div 500) \times 100\% = 60\%\). Always express as a decimal first (0.6) then multiply by 100 for a percentage. Efficiency can never exceed 100% — energy cannot be created from nothing.$t$;

UPDATE questions SET
  explanation = $t$Work done is measured in joules (J = N m). Power is in watts (W = J/s). Force is in newtons (N). Energy is also in joules — work done equals energy transferred, so they share the same unit. Confusing J and W is a common error.$t$
WHERE id = 4496
  AND explanation = $t$Work done is measured in joules \((J = N m)\). Power is in watts \((W = \frac{J}{s})\). Force is in newtons (N). Energy is also in joules — work done equals energy transferred, so they share the same unit. Confusing J and W is a common error.$t$;

UPDATE questions SET
  question_text = $t$A spring (k = 100 N/m) is extended by 0.3 m. Calculate the elastic potential energy stored.$t$,
  explanation = $t$EPE = ½kx² = ½ × 100 × (0.3)² = ½ × 100 × 0.09 = 4.5 J. Square the extension first (0.09), then multiply by ½k (50). Common errors: forgetting the ½, or not squaring the extension. Check: ½ × 100 × 0.09 = 4.5 J ✓.$t$
WHERE id = 4497
  AND question_text = $t$A spring (\(k = 100\,\text{N/m}\)) is extended by 0.3 m. Calculate the elastic potential energy stored.$t$
  AND explanation = $t$\(EPE = \tfrac{1}{2}kx^{2} = \tfrac{1}{2} \times 100 \times (0.3)^{2} = \tfrac{1}{2} \times 100 \times 0.09 = 4.5\,\text{J}\). Square the extension first (0.09), then multiply by \(\tfrac{1}{2}k (50)\). Common errors: forgetting the \(\tfrac{1}{2}\), or not squaring the extension. Check: \(\tfrac{1}{2} \times 100 \times 0.09 = 4.5\,\text{J} \checkmark\).$t$;

UPDATE questions SET
  question_text = $t$A 60 kg person runs up a flight of stairs 3 m high in 6 seconds. Calculate the power developed. (g = 10 N/kg)$t$,
  explanation = $t$Work done against gravity = mgh = 60 × 10 × 3 = 1800 J. Power = work ÷ time = 1800 ÷ 6 = 300 W. Calculate work done first (using mgh), then divide by time. Do not multiply by time — that gives energy squared, not power.$t$
WHERE id = 4498
  AND question_text = $t$A \(60\,\text{kg}\) person runs up a flight of stairs 3 m high in 6 seconds. Calculate the power developed. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Work done against gravity \(= mgh = 60 \times 10 \times 3 = 1800\,\text{J}\). Power = work ÷ time \(= 1800 \div 6 = 300\,\text{W}\). Calculate work done first (using mgh), then divide by time. Do not multiply by time — that gives energy squared, not power.$t$;

UPDATE questions SET
  question_text = $t$An engine exerts a driving force of 2000 N on a car moving at 15 m/s. Calculate the power output of the engine.$t$,
  explanation = $t$Power = force × velocity: P = Fv = 2000 × 15 = 30 000 W. This is derived from P = W/t = Fd/t = F(d/t) = Fv. It gives power directly when a constant force acts on an object moving at constant velocity without needing to know time or distance separately.$t$
WHERE id = 4499
  AND question_text = $t$An engine exerts a driving force of 2000 N on a car moving at \(15\,\text{m/s}\). Calculate the power output of the engine.$t$
  AND explanation = $t$Power = force × velocity: P = Fv \(= 2000 \times 15 = 30\,000\,\text{W}\). This is derived from \(P = \frac{W}{t}\)= Fd/\(t = F(\frac{d}{t})\)= Fv. It gives power directly when a constant force acts on an object moving at constant velocity without needing to know time or distance separately.$t$;

UPDATE questions SET
  explanation = $t$Two positive charges repel each other with a force directed away from each charge, along the line joining them. The force magnitude is given by Coulomb's Law: F ∝ Q₁Q₂/d². Both charges experience equal but opposite forces (Newton's Third Law).$t$
WHERE id = 4504
  AND explanation = $t$Two positive charges repel each other with a force directed away from each charge, along the line joining them. The force magnitude is given by Coulomb's Law: F ∝ Q₁Q₂/\(d^{2}\). Both charges experience equal but opposite forces (Newton's Third Law).$t$;

UPDATE questions SET
  explanation = $t$The electrostatic force depends on the magnitudes of both charges and the distance between them (Coulomb's Law: F = kQ₁Q₂/d²). Larger charges and smaller distances give stronger forces. Temperature has no effect on electrostatic forces between static charges.$t$
WHERE id = 4509
  AND explanation = $t$The electrostatic force depends on the magnitudes of both charges and the distance between them (Coulomb's Law: \(F = k\)Q₁Q₂/\(d^{2}\)). Larger charges and smaller distances give stronger forces. Temperature has no effect on electrostatic forces between static charges.$t$;

UPDATE questions SET
  question_text = $t$A spring has spring constant 300 N/m. It is stretched by 0.04 m. Calculate the force applied.$t$,
  option_d = $t$12 N — F = kx = 300 × 0.04 = 12 N$t$,
  explanation = $t$Hooke's Law: F = kx = 300 × 0.04 = 12 N. Multiply the spring constant by the extension (in metres). Do not divide or add. Check: F = kx = 300 N/m × 0.04 m = 12 N ✓. Units: N/m × m = N.$t$
WHERE id = 4510
  AND question_text = $t$A spring has spring constant \(300\,\text{N/m}\). It is stretched by 0.04 m. Calculate the force applied.$t$
  AND option_d = $t$12 N — \(F = kx = 300 \times 0.04 = 12\,\text{N}\)$t$
  AND explanation = $t$Hooke's Law: \(F = kx = 300 \times 0.04 = 12\,\text{N}\). Multiply the spring constant by the extension (in metres). Do not divide or add. Check: \(F = kx = 300\,\text{N/m}\) \(\times 0.04 m = 12\,\text{N} \checkmark\). Units: N/m ×\(m = N\).$t$;

UPDATE questions SET
  question_text = $t$What is the elastic potential energy stored in a spring with k = 400 N/m and extension 0.05 m?$t$,
  explanation = $t$EPE = ½kx² = ½ × 400 × (0.05)² = ½ × 400 × 0.0025 = 0.5 J. Square the extension first: 0.05² = 0.0025 (not 0.25). Then multiply by ½ × 400 = 200. Answer: 200 × 0.0025 = 0.5 J.$t$
WHERE id = 4512
  AND question_text = $t$What is the elastic potential energy stored in a spring with \(k = 400\,\text{N/m}\) and extension 0.05 m?$t$
  AND explanation = $t$\(EPE = \tfrac{1}{2}kx^{2} = \tfrac{1}{2} \times 400 \times (0.05)^{2} = \tfrac{1}{2} \times 400 \times 0.0025 = 0.5\,\text{J}\). Square the extension first: \(0.05^{2} = 0.0025\) (not 0.25). Then multiply by \(\tfrac{1}{2} \times 400 = 200\). Answer: \(200 \times 0.0025 = 0.5\,\text{J}\).$t$;

UPDATE questions SET
  explanation = $t$Hooke's Law: extension ∝ applied force (F = kx), up to the elastic limit. This means the force-extension graph is a straight line through the origin with gradient = k. Beyond the elastic limit, the relationship is no longer proportional and the graph curves.$t$
WHERE id = 4513
  AND explanation = $t$Hooke's Law: extension ∝ applied force \((F = kx)\), up to the elastic limit. This means the force-extension graph is a straight line through the origin with gradient \(= k\). Beyond the elastic limit, the relationship is no longer proportional and the graph curves.$t$;

UPDATE questions SET
  explanation = $t$The straight section (below 6 N) represents Hooke's Law behaviour — gradient = spring constant k = F/x. The curve above 6 N indicates the elastic limit has been passed and the spring deforms permanently. The spring constant is only valid for the linear (straight) section.$t$
WHERE id = 4515
  AND explanation = $t$The straight section (below 6 N) represents Hooke's Law behaviour — gradient = spring constant \(k = \frac{F}{x}\). The curve above 6 N indicates the elastic limit has been passed and the spring deforms permanently. The spring constant is only valid for the linear (straight) section.$t$;

UPDATE questions SET
  option_c = $t$Metres (m)$t$,
  explanation = $t$The spring constant k is measured in newtons per metre (N/m). It represents the force needed to extend or compress the spring by 1 metre. A high k (e.g. 10 000 N/m) means a stiff spring; a low k (e.g. 10 N/m) means a soft spring.$t$
WHERE id = 4516
  AND option_c = $t$Metres (\(m\))$t$
  AND explanation = $t$The spring constant \(k\) is measured in newtons per metre (N/m). It represents the force needed to extend or compress the spring by 1 metre. A high \(k\) (e.g. \(10\,000\,\text{N/m}\)) means a stiff spring; a low \(k\) (e.g. \(10\,\text{N/m}\)) means a soft spring.$t$;

UPDATE questions SET
  question_text = $t$Two identical springs are connected in series. Each has spring constant 100 N/m. What is the combined spring constant?$t$,
  option_a = $t$200 N/m$t$,
  option_b = $t$50 N/m$t$,
  option_c = $t$100 N/m$t$,
  option_d = $t$25 N/m$t$,
  explanation = $t$Two springs in series: each carries the full load but extends more. Combined spring constant k_eff = k/2 = 100/2 = 50 N/m. In series, springs are effectively weaker (lower k). In parallel, springs share the load: k_eff = 2k = 200 N/m (effectively stiffer).$t$
WHERE id = 4517
  AND question_text = $t$Two identical springs are connected in series. Each has spring constant \(100\,\text{N/m}\). What is the combined spring constant?$t$
  AND option_a = $t$\(200\,\text{N/m}\)$t$
  AND option_b = $t$\(50\,\text{N/m}\)$t$
  AND option_c = $t$\(100\,\text{N/m}\)$t$
  AND option_d = $t$\(25\,\text{N/m}\)$t$
  AND explanation = $t$Two springs in series: each carries the full load but extends more. Combined spring constant \(k\)_\(eff = \frac{k}{2} = \frac{100}{2} = 50\,\text{N/m}\). In series, springs are effectively weaker (lower \(k\)). In parallel, springs share the load: \(k\)_\(eff = 2k = 200\,\text{N/m}\) (effectively stiffer).$t$;

UPDATE questions SET
  question_text = $t$A 0.5 kg mass is attached to a spring (k = 200 N/m) and hangs at rest. Calculate the extension of the spring. (g = 10 N/kg)$t$,
  explanation = $t$At equilibrium: spring force = weight. Weight = mg = 0.5 × 10 = 5 N. Extension = F/k = 5/200 = 0.025 m. The spring stretches until its restoring force equals the hanging weight. Check: kx = 200 × 0.025 = 5 N = weight ✓.$t$
WHERE id = 4518
  AND question_text = $t$A \(0.5\,\text{kg}\) mass is attached to a spring (\(k = 200\,\text{N/m}\)) and hangs at rest. Calculate the extension of the spring. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$At equilibrium: spring force = weight. Weight \(= mg = 0.5 \times 10 = 5 N\). Extension \(= \frac{F}{k} = \frac{5}{200} = 0.025\,\text{m}\). The spring stretches until its restoring force equals the hanging weight. Check: \(kx = 200 \times 0.025 = 5 N\)= weight ✓.$t$;

UPDATE questions SET
  question_text = $t$A 3 kg object is raised 5 m. Calculate the gravitational potential energy gained. (g = 10 N/kg)$t$,
  explanation = $t$GPE = mgh = 3 × 10 × 5 = 150 J. All three factors must be multiplied: mass (kg), gravitational field strength (10 N/kg) and height (m). A common error is forgetting g or using the wrong value. Check units: kg × N/kg × m = N m = J ✓.$t$
WHERE id = 4530
  AND question_text = $t$A \(3\,\text{kg}\) object is raised 5 m. Calculate the gravitational potential energy gained. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$\(GPE = mgh = 3 \times 10 \times 5 = 150\,\text{J}\). All three factors must be multiplied: mass (kg), gravitational field strength (\(10\,\text{N/kg}\)) and height (\(m\)). A common error is forgetting \(g\) or using the wrong value. Check units: kg ×\(\text{N/kg} \times m = N m = J \checkmark\).$t$;

UPDATE questions SET
  option_a = $t$Useful = 500 J; wasted = 0 J$t$,
  option_b = $t$Useful = 350 J; wasted = 150 J$t$,
  option_c = $t$Useful = 150 J; wasted = 350 J$t$,
  option_d = $t$Useful = 350 J; wasted = 150 J — efficiency = useful output / total input × 100$t$,
  explanation = $t$Efficiency = useful output / total input. Useful output = 0.70 × 500 = 350 J. Wasted = 500 − 350 = 150 J. Efficiency of 70% means 70% of input energy does useful work; the remaining 30% (150 J) is wasted, usually as heat due to friction or resistance.$t$
WHERE id = 4531
  AND option_a = $t$Useful \(= 500\,\text{J}\); wasted \(= 0\,\text{J}\)$t$
  AND option_b = $t$Useful \(= 350\,\text{J}\); wasted \(= 150\,\text{J}\)$t$
  AND option_c = $t$Useful \(= 150\,\text{J}\); wasted \(= 350\,\text{J}\)$t$
  AND option_d = $t$Useful \(= 350\,\text{J}\); wasted \(= 150\,\text{J}\) — efficiency = useful output / total input \(\times 100\)$t$
  AND explanation = $t$Efficiency = useful output / total input. Useful output \(= 0.70 \times 500 = 350\,\text{J}\). Wasted \(= 500 - 350 = 150\,\text{J}\). Efficiency of 70% means 70% of input energy does useful work; the remaining 30% (150 J) is wasted, usually as heat due to friction or resistance.$t$;

UPDATE questions SET
  question_text = $t$Calculate the specific heat capacity of a 2 kg metal block heated from 20°C to 70°C using 18 000 J.$t$,
  option_a = $t$180 J/kg°C$t$,
  option_b = $t$900 J/kg°C$t$,
  option_c = $t$36 000 J/kg°C$t$,
  option_d = $t$1800 J/kg°C$t$,
  explanation = $t$c = E/(mΔT) = 18 000/(2 × 50) = 180 J/kg°C. ΔT = 70−20 = 50°C. Always use the temperature CHANGE, not the final temperature. Rearrange E = mcΔT to c = E/(mΔT). Check: 2 × 180 × 50 = 18 000 J ✓.$t$
WHERE id = 4532
  AND question_text = $t$Calculate the specific heat capacity of \(a\) \(2\,\text{kg}\) metal block heated from \(20^\circ C\) to \(70^\circ C\) using 18 000 J.$t$
  AND option_a = $t$\(180\,\text{J/kg°C}\)$t$
  AND option_b = $t$\(900\,\text{J/kg°C}\)$t$
  AND option_c = $t$\(36\,000\,\text{J/kg°C}\)$t$
  AND option_d = $t$\(1800\,\text{J/kg°C}\)$t$
  AND explanation = $t$\(c = E /\)(\(m\)ΔT) \(= \frac{18\,000}{2 \times 50} = 180\,\text{J/kg°C}\). Δ\(T = 70 - 20 = 50^\circ C\). Always use the temperature CHANGE, not the final temperature. Rearrange \(E = mc\)ΔT to \(c = E /\)(\(m\)ΔT). Check: \(2 \times 180 \times 50 = 18\,000\,\text{J} \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$E = Pt = 1500 × (3 × 60) = 1500 × 180 = 270 000 J. Always convert minutes to seconds (×60) before multiplying by power. Power in watts × time in seconds = energy in joules. Check: 1500 W × 180 s = 270 000 J ✓.$t$
WHERE id = 4533
  AND explanation = $t$E = Pt \(= 1500 \times (3 \times 60) = 1500 \times 180 = 270\,000\,\text{J}\). Always convert minutes to seconds \((\times 60)\) before multiplying by power. Power in watts × time in seconds = energy in joules. Check: \(1500\,\text{W} \times 180 s = 270\,000\,\text{J} \checkmark\).$t$;

UPDATE questions SET
  question_text = $t$A ball of mass 0.4 kg is dropped from rest at a height of 10 m. Using conservation of energy, calculate its speed just before impact. (g = 10 N/kg)$t$,
  option_a = $t$100 m/s$t$,
  option_b = $t$√200 ≈ 14.1 m/s$t$,
  option_c = $t$40 m/s$t$,
  option_d = $t$4 m/s$t$,
  explanation = $t$Using conservation of energy: GPE = KE → mgh = ½mv² → mass cancels → v = √(2gh) = √(2×10×10) = √200 ≈ 14.1 m/s. The mass cancels so speed at the bottom is independent of mass. Check: ½ × 0.4 × 200 = 40 J = 0.4 × 10 × 10 = 40 J ✓.$t$
WHERE id = 4534
  AND question_text = $t$A ball of mass \(0.4\,\text{kg}\) is dropped from rest at a height of 10 m. Using conservation of energy, calculate its speed just before impact. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(100\,\text{m/s}\)$t$
  AND option_b = $t$\(\sqrt{200}\)≈ \(14.1\,\text{m/s}\)$t$
  AND option_c = $t$\(40\,\text{m/s}\)$t$
  AND option_d = $t$\(4\,\text{m/s}\)$t$
  AND explanation = $t$Using conservation of energy: \(GPE = KE \to mgh = \tfrac{1}{2}mv^{2}\)→ mass cancels →\(v = \sqrt{2gh} = \sqrt{2 \times 10 \times 10} = \sqrt{200}\)≈ \(14.1\,\text{m/s}\). The mass cancels so speed at the bottom is independent of mass. Check: \(\tfrac{1}{2} \times 0.4 \times 200 = 40 J = 0.4 \times 10 \times 10 = 40 J \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$Power wasted as heat = total power − useful light power = 60 − (5% of 60) = 60 − 3 = 57 W. Only 5% of 60 W = 3 W is emitted as light; the remaining 57 W is wasted as heat. This shows why incandescent bulbs are so inefficient — 95% of energy becomes heat.$t$
WHERE id = 4536
  AND explanation = $t$Power wasted as heat = total power − useful light power \(= 60 -\) (5% of 60) \(= 60 - 3 = 57 W\). Only 5% of \(60 W = 3 W\) is emitted as light; the remaining 57 W is wasted as heat. This shows why incandescent bulbs are so inefficient — 95% of energy becomes heat.$t$;

UPDATE questions SET
  question_text = $t$An object with mass 5 kg and velocity 6 m/s has kinetic energy. Calculate its KE.$t$,
  explanation = $t$KE = ½mv² = ½ × 5 × 6² = ½ × 5 × 36 = 90 J. Square the velocity first (6²=36), then multiply by ½m. The most common error is forgetting to square v, giving ½×5×6 = 15 J — always check you have squared the speed.$t$
WHERE id = 4537
  AND question_text = $t$An object with mass \(5\,\text{kg}\) and velocity \(6\,\text{m/s}\) has kinetic energy. Calculate its KE.$t$
  AND explanation = $t$\(KE = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 5 \times 6^{2} = \tfrac{1}{2} \times 5 \times 36 = 90\,\text{J}\). Square the velocity first \((6^{2} = 36)\), then multiply by \(\tfrac{1}{2}m\). The most common error is forgetting to square \(v\), giving \(\tfrac{1}{2} \times 5 \times 6 = 15\,\text{J}\) — always check you have squared the speed.$t$;

UPDATE questions SET
  question_text = $t$A crane lifts a 200 kg load 8 m in 10 seconds. Calculate the useful power output of the crane. (g = 10 N/kg)$t$,
  explanation = $t$Power = work done/time = mgh/t = 200×10×8/10 = 16000/10 = 1600 W. Work done = mgh (lifting against gravity). Power = work done ÷ time. Always calculate the work done (mgh) first, then divide by time to get power in watts.$t$
WHERE id = 4538
  AND question_text = $t$A crane lifts \(a\) \(200\,\text{kg}\) load 8 m in 10 seconds. Calculate the useful power output of the crane. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Power = work done/time \(= \frac{mgh}{t} = 200 \times 10 \times \frac{8}{10} = \frac{16000}{10} = 1600\,\text{W}\). Work done \(= mgh\) (lifting against gravity). Power = work done ÷ time. Always calculate the work done (mgh) first, then divide by time to get power in watts.$t$;

UPDATE questions SET
  option_a = $t$178.6 m/s$t$,
  option_b = $t$251.4 m/s$t$,
  option_c = $t$350 m/s$t$,
  option_d = $t$35 m/s$t$,
  explanation = $t$v = fλ = 250 × 1.4 = 350 m/s. The wave equation links speed, frequency and wavelength. Multiply frequency (Hz) by wavelength (m) to get speed (m/s). Check units: Hz × m = s⁻¹ × m = m/s ✓.$t$
WHERE id = 4540
  AND option_a = $t$\(178.6\,\text{m/s}\)$t$
  AND option_b = $t$\(251.4\,\text{m/s}\)$t$
  AND option_c = $t$\(350\,\text{m/s}\)$t$
  AND option_d = $t$\(35\,\text{m/s}\)$t$
  AND explanation = $t$\(v = f\)λ \(= 250 \times 1.4 = 350\,\text{m/s}\). The wave equation links speed, frequency and wavelength. Multiply frequency (Hz) by wavelength (\(m\)) to get speed (m/s). Check units: Hz ×\(m = s^{-1} \times m =\,\text{m/s} \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$When a wave passes from air into glass (denser medium), it slows down. Since v = fλ and frequency cannot change (it is set by the source), wavelength must decrease proportionally. Speed decreases, wavelength decreases, frequency stays the same. This is the definition of refraction.$t$
WHERE id = 4542
  AND explanation = $t$When a wave passes from air into glass (denser medium), it slows down. Since \(v = f\)λ and frequency cannot change (it is set by the source), wavelength must decrease proportionally. Speed decreases, wavelength decreases, frequency stays the same. This is the definition of refraction.$t$;

UPDATE questions SET
  explanation = $t$f = 1/T = 1/8 = 0.125 Hz. Frequency and period are reciprocals of each other: f = 1/T. A period of 8 seconds means the wave completes one full cycle every 8 seconds — 0.125 cycles per second = 0.125 Hz.$t$
WHERE id = 4543
  AND explanation = $t$\(f = \frac{1}{T} = \frac{1}{8} = 0.125\,\text{Hz}\). Frequency and period are reciprocals of each other: \(f = \frac{1}{T}\). A period of 8 seconds means the wave completes one full cycle every 8 seconds — 0.125 cycles per second \(= 0.125\,\text{Hz}\).$t$;

UPDATE questions SET
  question_text = $t$A ray of light hits a mirror at an angle of incidence of 35°. What is the angle of reflection?$t$,
  option_a = $t$55°$t$,
  option_b = $t$70°$t$,
  option_c = $t$35°$t$,
  option_d = $t$90°$t$,
  explanation = $t$The angle of reflection equals the angle of incidence (law of reflection). Both angles are measured from the normal to the surface, not from the surface itself. Angle of incidence = 35°, so angle of reflection = 35°. This law applies to all types of waves, not just light.$t$
WHERE id = 4544
  AND question_text = $t$A ray of light hits a mirror at an angle of incidence of \(35^\circ\). What is the angle of reflection?$t$
  AND option_a = $t$\(55^\circ\)$t$
  AND option_b = $t$\(70^\circ\)$t$
  AND option_c = $t$\(35^\circ\)$t$
  AND option_d = $t$\(90^\circ\)$t$
  AND explanation = $t$The angle of reflection equals the angle of incidence (law of reflection). Both angles are measured from the normal to the surface, not from the surface itself. Angle of incidence \(= 35^\circ\), so angle of reflection \(= 35^\circ\). This law applies to all types of waves, not just light.$t$;

UPDATE questions SET
  question_text = $t$A sound wave has speed 340 m/s and frequency 680 Hz. Calculate its wavelength.$t$,
  explanation = $t$λ = v/f = 340/680 = 0.5 m. Rearrange v = fλ to λ = v/f. Divide speed by frequency. Check: 680 × 0.5 = 340 m/s ✓. Sound wavelengths in air are typically a few centimetres to several metres.$t$
WHERE id = 4549
  AND question_text = $t$A sound wave has speed \(340\,\text{m/s}\) and frequency 680 Hz. Calculate its wavelength.$t$
  AND explanation = $t$λ \(= \frac{v}{f} = \frac{340}{680} = 0.5\,\text{m}\). Rearrange \(v = f\)λ to λ \(= \frac{v}{f}\). Divide speed by frequency. Check: \(680 \times 0.5 = 340\,\text{m/s}\) ✓. Sound wavelengths in air are typically a few centimetres to several metres.$t$;

UPDATE questions SET
  option_c = $t$Visible → IR → radio → microwave → UV → X-rays → gamma$t$,
  option_d = $t$Radio → microwave → IR → visible → UV → X-rays → gamma$t$
WHERE id = 4550
  AND option_c = $t$Visible → IR → radio → microwave →\(UV \to X\)-rays → gamma$t$
  AND option_d = $t$Radio → microwave → IR → visible →\(UV \to X\)-rays → gamma$t$;

UPDATE questions SET
  option_a = $t$The critical angle is 90° for all materials$t$,
  option_d = $t$The critical angle is the minimum angle of incidence inside a denser medium beyond which total internal reflection occurs; sin(critical angle) = 1/n where n is the refractive index$t$,
  explanation = $t$The critical angle (c) is the minimum angle of incidence inside the denser medium beyond which total internal reflection occurs. It is related to the refractive index n by: sin(c) = 1/n (when going from medium to air). Greater n means smaller critical angle — more easily achieved TIR.$t$
WHERE id = 4554
  AND option_a = $t$The critical angle is \(90^\circ\) for all materials$t$
  AND option_d = $t$The critical angle is the minimum angle of incidence inside a denser medium beyond which total internal reflection occurs; sin(critical angle) \(= \frac{1}{n}\) where \(n\) is the refractive index$t$
  AND explanation = $t$The critical angle (\(c\)) is the minimum angle of incidence inside the denser medium beyond which total internal reflection occurs. It is related to the refractive index \(n\) by: \(\sin(c) = \frac{1}{n}\) (when going from medium to air). Greater \(n\) means smaller critical angle — more easily achieved TIR.$t$;

UPDATE questions SET
  question_text = $t$A ray of light passes from glass (n = 1.5) into air. The angle of incidence is 25°. Calculate the angle of refraction.$t$,
  option_a = $t$16.2°$t$,
  option_b = $t$39.3°$t$,
  option_c = $t$25°$t$,
  option_d = $t$90°$t$,
  explanation = $t$n₁ sin θ₁ = n₂ sin θ₂: 1.5 × sin 25° = 1.0 × sin θ₂, so sin θ₂ = 0.634 and θ₂ ≈ 39.3°. Light speeds up leaving the glass, so it bends away from the normal.$t$
WHERE id = 4557
  AND question_text = $t$A ray of light passes from glass \((n = 1.5)\) into air. The angle of incidence is \(25^\circ\). Calculate the angle of refraction.$t$
  AND option_a = $t$\(16.2^\circ\)$t$
  AND option_b = $t$\(39.3^\circ\)$t$
  AND option_c = $t$\(25^\circ\)$t$
  AND option_d = $t$\(90^\circ\)$t$
  AND explanation = $t$\(n_{1} \sin \theta_{1} = n_{2} \sin \theta_{2}\): \(1.5 \times \sin 25^\circ = 1.0 \times \sin \theta_{2}\), so \(\sin \theta_{2} = 0.634\) and \(\theta_{2} \approx 39.3^\circ\). Light speeds up leaving the glass, so it bends away from the normal.$t$;

UPDATE questions SET
  explanation = $t$Work done = force × distance = 80 × 12 = 960 J. This formula applies when force and displacement are in the same direction. Work done equals energy transferred to the object. Check units: N × m = J ✓.$t$
WHERE id = 4560
  AND explanation = $t$Work done = force × distance \(= 80 \times 12 = 960\,\text{J}\). This formula applies when force and displacement are in the same direction. Work done equals energy transferred to the object. Check units: \(N \times m = J \checkmark\).$t$;

UPDATE questions SET
  question_text = $t$A 70 kg runner accelerates from 2 m/s to 8 m/s. Calculate the change in kinetic energy.$t$,
  explanation = $t$ΔKE = ½m(v²−u²) = ½ × 70 × (8²−2²) = ½ × 70 × (64−4) = ½ × 70 × 60 = 2100 J. Always calculate the change in KE using both initial and final velocities. ½mv² − ½mu² = ½m(v²−u²). Do not subtract speeds before squaring.$t$
WHERE id = 4561
  AND question_text = $t$A \(70\,\text{kg}\) runner accelerates from \(2\,\text{m/s}\) to \(8\,\text{m/s}\). Calculate the change in kinetic energy.$t$
  AND explanation = $t$Δ\(KE = \tfrac{1}{2}m(v^{2} - u^{2}) = \tfrac{1}{2} \times 70 \times (8^{2} - 2^{2}) = \tfrac{1}{2} \times 70 \times (64 - 4) = \tfrac{1}{2} \times 70 \times 60 = 2100\,\text{J}\). Always calculate the change in KE using both initial and final velocities. \(\tfrac{1}{2}mv^{2} - \tfrac{1}{2}mu^{2} = \tfrac{1}{2}m(v^{2} - u^{2})\). Do not subtract speeds before squaring.$t$;

UPDATE questions SET
  question_text = $t$A 500 kg car is lifted 3 m by a crane in 15 seconds. Calculate the useful power output of the crane. (g = 10 N/kg)$t$,
  explanation = $t$Power = work done/time = mgh/t = 500×10×3/15 = 15000/15 = 1000 W. Work done lifting = mgh = 500×10×3 = 15 000 J. Divide by time (15 s) to get power. Check: 1000 W × 15 s = 15 000 J = mgh ✓.$t$
WHERE id = 4562
  AND question_text = $t$A \(500\,\text{kg}\) car is lifted 3 m by a crane in 15 seconds. Calculate the useful power output of the crane. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Power = work done/time \(= \frac{mgh}{t} = 500 \times 10 \times \frac{3}{15} = \frac{15000}{15} = 1000\,\text{W}\). Work done lifting \(= mgh = 500 \times 10 \times 3 = 15\,000 J\). Divide by time (15 \(s\)) to get power. Check: \(1000\,\text{W} \times 15 s = 15\,000 J = mgh \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$Efficiency = useful output / total input × 100 = 4500/6000 × 100 = 75%. The remaining 25% (1500 J) is wasted, usually as heat due to friction. Efficiency can never exceed 100% — energy cannot be created. Always express as a percentage by multiplying by 100.$t$
WHERE id = 4563
  AND explanation = $t$Efficiency = useful output / total input \(\times 100 = \frac{4500}{6000} \times 100 = 75\%\). The remaining 25% (1500 J) is wasted, usually as heat due to friction. Efficiency can never exceed 100% — energy cannot be created. Always express as a percentage by multiplying by 100.$t$;

UPDATE questions SET
  question_text = $t$A spring (k = 250 N/m) is compressed by 0.08 m. Calculate the elastic potential energy stored.$t$,
  explanation = $t$EPE = ½kx² = ½ × 250 × 0.08² = ½ × 250 × 0.0064 = 0.8 J. Always square the compression/extension (0.08²=0.0064) before multiplying by ½k. The ½ is essential — omitting it gives double the correct answer.$t$
WHERE id = 4564
  AND question_text = $t$A spring (\(k = 250\,\text{N/m}\)) is compressed by 0.08 m. Calculate the elastic potential energy stored.$t$
  AND explanation = $t$\(EPE = \tfrac{1}{2}kx^{2} = \tfrac{1}{2} \times 250 \times 0.08^{2} = \tfrac{1}{2} \times 250 \times 0.0064 = 0.8\,\text{J}\). Always square the compression/extension \((0.08^{2} = 0.0064)\) before multiplying by \(\tfrac{1}{2}k\). The \(\tfrac{1}{2}\) is essential — omitting it gives double the correct answer.$t$;

UPDATE questions SET
  explanation = $t$Work done = force × displacement × cosθ. When carrying a box horizontally at constant speed, the applied force is vertical (upward, supporting the weight) but the displacement is horizontal — the angle between them is 90°. cos90° = 0, so work done = 0. The vertical force does no work against horizontal displacement.$t$
WHERE id = 4565
  AND explanation = $t$Work done = force × displacement ×\(\cos \theta\). When carrying a box horizontally at constant speed, the applied force is vertical (upward, supporting the weight) but the displacement is horizontal — the angle between them is \(90^\circ\). \(\cos 90^\circ = 0\), so work done \(= 0\). The vertical force does no work against horizontal displacement.$t$;

UPDATE questions SET
  question_text = $t$A 2 kg ball rolls down a frictionless ramp of height 4 m. Calculate its speed at the bottom. (g = 10 N/kg)$t$,
  option_a = $t$8 m/s$t$,
  option_b = $t$40 m/s$t$,
  option_c = $t$√80 ≈ 8.9 m/s$t$,
  option_d = $t$4 m/s$t$,
  explanation = $t$Conservation of energy (frictionless): GPE lost = KE gained. mgh = ½mv² → v = √(2gh) = √(2×10×4) = √80 ≈ 8.9 m/s. Mass cancels out. On a frictionless ramp, all gravitational potential energy converts to kinetic energy at the bottom.$t$
WHERE id = 4566
  AND question_text = $t$A \(2\,\text{kg}\) ball rolls down a frictionless ramp of height 4 m. Calculate its speed at the bottom. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(8\,\text{m/s}\)$t$
  AND option_b = $t$\(40\,\text{m/s}\)$t$
  AND option_c = $t$\(\sqrt{80}\)≈ \(8.9\,\text{m/s}\)$t$
  AND option_d = $t$\(4\,\text{m/s}\)$t$
  AND explanation = $t$Conservation of energy (frictionless): GPE lost \(= KE\) gained. \(mgh = \tfrac{1}{2}mv^{2} \to v = \sqrt{2gh} = \sqrt{2 \times 10 \times 4} = \sqrt{80}\)≈ \(8.9\,\text{m/s}\). Mass cancels out. On a frictionless ramp, all gravitational potential energy converts to kinetic energy at the bottom.$t$;

UPDATE questions SET
  question_text = $t$A 1200 W motor lifts a 60 kg load. How high can it lift the load in 10 seconds, assuming 100% efficiency? (g = 10 N/kg)$t$,
  explanation = $t$Energy available in 10 s = Power × time = 1200 × 10 = 12 000 J. Work done lifting = mgh. So 12 000 = 60 × 10 × h → h = 12 000/600 = 20 m. With 100% efficiency all electrical energy converts to gravitational potential energy. Check: 600 × 20 = 12 000 J ✓.$t$
WHERE id = 4568
  AND question_text = $t$A 1200 W motor lifts \(a\) \(60\,\text{kg}\) load. How high can it lift the load in 10 seconds, assuming 100% efficiency? (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Energy available in 10 \(s\)= Power × time \(= 1200 \times 10 = 12\,000\,\text{J}\). Work done lifting \(= mgh\). So \(12\,000 = 60 \times 10 \times h \to h = \frac{12\,000}{600} = 20\,\text{m}\). With 100% efficiency all electrical energy converts to gravitational potential energy. Check: \(600 \times 20 = 12\,000\,\text{J} \checkmark\).$t$;

UPDATE questions SET
  question_text = $t$A person pushes a box 5 m along the floor with a force of 30 N at an angle of 0° to the floor. They then push another box 5 m with 30 N at 60° to the floor. Compare the work done.$t$,
  option_c = $t$The horizontal push does more work (150 J) than the angled push (75 J) because only the horizontal component of force (30 × cos60° = 15 N) does work against displacement$t$,
  explanation = $t$Work done = force × displacement × cosθ. Horizontal push (θ=0°): W = 30×5×cos0° = 150 J. Angled push (θ=60°): W = 30×5×cos60° = 30×5×0.5 = 75 J. Only the horizontal component of force (Fcosθ) does work against horizontal displacement. The horizontal push does more useful work.$t$
WHERE id = 4569
  AND question_text = $t$A person pushes a box 5 m along the floor with a force of 30 N at an angle of \(0^\circ\) to the floor. They then push another box 5 m with 30 N at \(60^\circ\) to the floor. Compare the work done.$t$
  AND option_c = $t$The horizontal push does more work (150 J) than the angled push (75 J) because only the horizontal component of force \((30 \times \cos 60^\circ = 15\,\text{N})\) does work against displacement$t$
  AND explanation = $t$Work done = force × displacement ×\(\cos \theta\). Horizontal push \((\theta = 0^\circ)\): \(W = 30 \times 5 \times \cos 0^\circ = 150\,\text{J}\). Angled push \((\theta = 60^\circ)\): \(W = 30 \times 5 \times \cos 60^\circ = 30 \times 5 \times 0.5 = 75\,\text{J}\). Only the horizontal component of force (Fcos\(\theta\)) does work against horizontal displacement. The horizontal push does more useful work.$t$;

UPDATE questions SET
  question_text = $t$A spring has spring constant 450 N/m. Calculate the extension when a 27 N force is applied.$t$,
  explanation = $t$Using Hooke's Law: x = F/k = 27/450 = 0.06 m. Divide force by spring constant. Always check units: N ÷ (N/m) = m ✓. Convert to cm if required: 0.06 m = 6 cm.$t$
WHERE id = 4580
  AND question_text = $t$A spring has spring constant \(450\,\text{N/m}\). Calculate the extension when a 27 N force is applied.$t$
  AND explanation = $t$Using Hooke's Law: \(x = \frac{F}{k} = \frac{27}{450} = 0.06 m\). Divide force by spring constant. Always check units: \(N \div (\text{N/m}) = m \checkmark\). Convert to cm if required: \(0.06 m = 6\,\text{cm}\).$t$;

UPDATE questions SET
  question_text = $t$Calculate the elastic potential energy stored in a spring (k = 600 N/m) when stretched by 0.05 m.$t$,
  explanation = $t$EPE = ½kx² = ½ × 600 × 0.05² = ½ × 600 × 0.0025 = 0.75 J. Square the extension first (0.05² = 0.0025), then multiply by ½k = 300. Check: 300 × 0.0025 = 0.75 J ✓. Always square the extension — not doing so gives 1.5 J, exactly double the correct answer.$t$
WHERE id = 4581
  AND question_text = $t$Calculate the elastic potential energy stored in a spring (\(k = 600\,\text{N/m}\)) when stretched by 0.05 m.$t$
  AND explanation = $t$\(EPE = \tfrac{1}{2}kx^{2} = \tfrac{1}{2} \times 600 \times 0.05^{2} = \tfrac{1}{2} \times 600 \times 0.0025 = 0.75\,\text{J}\). Square the extension first \((0.05^{2} = 0.0025)\), then multiply by \(\tfrac{1}{2}k = 300\). Check: \(300 \times 0.0025 = 0.75\,\text{J} \checkmark\). Always square the extension — not doing so gives 1.5 J, exactly double the correct answer.$t$;

UPDATE questions SET
  question_text = $t$A 70 kg student stands on a plank of wood (area of contact 0.002 m²). Calculate the pressure exerted on the ground. (g = 10 N/kg)$t$,
  explanation = $t$Pressure = F/A. Weight = mg = 70 × 10 = 700 N. Area = 0.002 m². Pressure = 700/0.002 = 350 000 Pa. Always use weight (mg) as the force, not mass. Check: N ÷ m² = Pa ✓.$t$
WHERE id = 4582
  AND question_text = $t$A \(70\,\text{kg}\) student stands on a plank of wood (area of contact \(0.002 m^{2}\)). Calculate the pressure exerted on the ground. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Pressure \(= \frac{F}{A}\). Weight \(= mg = 70 \times 10 = 700\,\text{N}\). Area \(= 0.002 m^{2}\). Pressure \(= \frac{700}{0.002} = 350\,000\,\text{Pa}\). Always use weight (mg) as the force, not mass. Check: \(N \div m^{2}\)= Pa ✓.$t$;

UPDATE questions SET
  question_text = $t$The pressure at a depth h in a fluid of density ρ is given by P = ρgh. Calculate the pressure at 4 m depth in water. (ρ = 1000 kg/m³; g = 10 N/kg)$t$,
  option_d = $t$40 000 Pa — P = 1000 × 10 × 4 = 40 000 Pa$t$,
  explanation = $t$P = ρgh = 1000 × 10 × 4 = 40 000 Pa. All three factors — fluid density (kg/m³), g (N/kg) and depth (m) — must be multiplied. This gives the pressure due to the fluid column above that point. At greater depth, the weight of fluid above increases, increasing pressure.$t$
WHERE id = 4583
  AND question_text = $t$The pressure at a depth \(h\) in a fluid of density ρ is given by P = ρgh. Calculate the pressure at 4 m depth in water. (ρ = \(1000\,\text{kg/m}^{3}\); \(g = 10\,\text{N/kg}\))$t$
  AND option_d = $t$40 000 Pa — \(P = 1000 \times 10 \times 4 = 40\,000\,\text{Pa}\)$t$
  AND explanation = $t$P = ρ\(gh = 1000 \times 10 \times 4 = 40\,000\,\text{Pa}\). All three factors — fluid density \((\text{kg/m}^{3})\), g (N/kg) and depth (\(m\)) — must be multiplied. This gives the pressure due to the fluid column above that point. At greater depth, the weight of fluid above increases, increasing pressure.$t$;

UPDATE questions SET
  option_a = $t$k = 300 N/m; extension = 0.20 m$t$,
  option_b = $t$k = 0.003 N/m; extension = 200 m$t$,
  option_c = $t$k = 300 N/m; extension = 0.20 m — F = kx; k = 36/0.12 = 300 N/m; x = 60/300 = 0.2 m$t$,
  option_d = $t$k = 432 N/m; extension = 0.14 m$t$,
  explanation = $t$k = F/x = 36/0.12 = 300 N/m. New extension = F/k = 60/300 = 0.20 m. Use Hooke's Law F=kx: first find k from the given data, then apply it to find the new extension. Check: 300 × 0.20 = 60 N ✓. This assumes the elastic limit has not been exceeded.$t$
WHERE id = 4584
  AND option_a = $t$\(k = 300\,\text{N/m}\); extension \(= 0.20\,\text{m}\)$t$
  AND option_b = $t$\(k = 0.003\,\text{N/m}\); extension \(= 200\,\text{m}\)$t$
  AND option_c = $t$\(k = 300\,\text{N/m}\); extension \(= 0.20\,\text{m}\) — \(F = kx\); \(k = \frac{36}{0.12} = 300\,\text{N/m}\); \(x = \frac{60}{300} = 0.2\,\text{m}\)$t$
  AND option_d = $t$\(k = 432\,\text{N/m}\); extension \(= 0.14\,\text{m}\)$t$
  AND explanation = $t$\(k = \frac{F}{x} = \frac{36}{0.12} = 300\,\text{N/m}\). New extension \(= \frac{F}{k} = \frac{60}{300} = 0.20\,\text{m}\). Use Hooke's Law \(F = kx\): first find \(k\) from the given data, then apply it to find the new extension. Check: \(300 \times 0.20 = 60\,\text{N} \checkmark\). This assumes the elastic limit has not been exceeded.$t$;

UPDATE questions SET
  explanation = $t$Pressure increases with depth because the weight of fluid above increases — each layer supports all the fluid above it. P = ρgh shows pressure is directly proportional to depth (h). Doubling depth doubles pressure. This is why deep-sea creatures need special adaptations to withstand high pressure.$t$
WHERE id = 4585
  AND explanation = $t$Pressure increases with depth because the weight of fluid above increases — each layer supports all the fluid above it. P = ρgh shows pressure is directly proportional to depth (\(h\)). Doubling depth doubles pressure. This is why deep-sea creatures need special adaptations to withstand high pressure.$t$;

UPDATE questions SET
  question_text = $t$A hydraulic press has a small piston of area 0.005 m² and a large piston of area 0.1 m². A force of 200 N is applied to the small piston. Calculate the force exerted by the large piston.$t$,
  explanation = $t$In a hydraulic system, pressure is transmitted equally throughout the fluid. Pressure = F_in/A_in = 200/0.005 = 40 000 Pa. Force out = pressure × A_out = 40 000 × 0.1 = 4000 N. The force is amplified by the ratio of areas (0.1/0.005 = 20), so output force = 200 × 20 = 4000 N.$t$
WHERE id = 4587
  AND question_text = $t$A hydraulic press has a small piston of area \(0.005 m^{2}\) and a large piston of area \(0.1 m^{2}\). A force of 200 N is applied to the small piston. Calculate the force exerted by the large piston.$t$
  AND explanation = $t$In a hydraulic system, pressure is transmitted equally throughout the fluid. Pressure \(= F\)_in/A_in \(= \frac{200}{0.005} = 40\,000\,\text{Pa}\). Force out = pressure × A_\(out = 40\,000 \times 0.1 = 4000\,\text{N}\). The force is amplified by the ratio of areas \((\frac{0.1}{0.005} = 20)\), so output force \(= 200 \times 20 = 4000\,\text{N}\).$t$;

UPDATE questions SET
  option_c = $t$Spring A has a larger spring constant — a steeper gradient means more force is needed per unit extension, indicating a stiffer spring with higher k$t$,
  explanation = $t$The gradient of a force-extension graph equals the spring constant (k = F/x). A steeper gradient means more force per unit extension — the spring is stiffer and has a larger spring constant. Spring A (steeper) has a larger k than Spring B (less steep). Compare gradients directly from the graph.$t$
WHERE id = 4588
  AND option_c = $t$Spring A has a larger spring constant — a steeper gradient means more force is needed per unit extension, indicating a stiffer spring with higher \(k\)$t$
  AND explanation = $t$The gradient of a force-extension graph equals the spring constant \((k = \frac{F}{x})\). A steeper gradient means more force per unit extension — the spring is stiffer and has a larger spring constant. Spring A (steeper) has a larger \(k\) than Spring B (less steep). Compare gradients directly from the graph.$t$;

UPDATE questions SET
  question_text = $t$Calculate the gravitational potential energy of a 2 kg object raised 5 m (g = 10 N/kg).$t$,
  explanation = $t$GPE = mgh = 2 × 10 × 5 = 100 J. Multiply mass (kg) × g (10 N/kg) × height (m). A common error is forgetting to include g, or adding the numbers instead of multiplying. Check: 2 × 10 × 5 = 100 J ✓.$t$
WHERE id = 4592
  AND question_text = $t$Calculate the gravitational potential energy of \(a\) \(2\,\text{kg}\) object raised 5 m (\(g = 10\,\text{N/kg}\)).$t$
  AND explanation = $t$\(GPE = mgh = 2 \times 10 \times 5 = 100\,\text{J}\). Multiply mass (kg) × \(g\) (\(10\,\text{N/kg}\)) × height (\(m\)). A common error is forgetting to include \(g\), or adding the numbers instead of multiplying. Check: \(2 \times 10 \times 5 = 100\,\text{J} \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$Useful output = efficiency × input = 0.80 × 500 = 400 J. An 80% efficient machine transfers 80% of input energy as useful work; the remaining 20% (100 J) is wasted as heat. Always multiply input by the efficiency fraction (0.80, not 80).$t$
WHERE id = 4593
  AND explanation = $t$Useful output = efficiency × input \(= 0.80 \times 500 = 400\,\text{J}\). An 80% efficient machine transfers 80% of input energy as useful work; the remaining 20% (100 J) is wasted as heat. Always multiply input by the efficiency fraction (0.80, not 80).$t$;

UPDATE questions SET
  question_text = $t$A 4 kg ball moves at 5 m/s. Calculate its kinetic energy.$t$,
  explanation = $t$KE = ½mv² = ½ × 4 × 5² = ½ × 4 × 25 = 50 J. Always square the velocity first (5² = 25), then multiply by ½m. A common error is forgetting to square v, giving ½ × 4 × 5 = 10 J — always check you have squared the speed.$t$
WHERE id = 4595
  AND question_text = $t$A \(4\,\text{kg}\) ball moves at \(5\,\text{m/s}\). Calculate its kinetic energy.$t$
  AND explanation = $t$\(KE = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 4 \times 5^{2} = \tfrac{1}{2} \times 4 \times 25 = 50\,\text{J}\). Always square the velocity first \((5^{2} = 25)\), then multiply by \(\tfrac{1}{2}m\). A common error is forgetting to square \(v\), giving \(\tfrac{1}{2} \times 4 \times 5 = 10\,\text{J}\) — always check you have squared the speed.$t$;

UPDATE questions SET
  explanation = $t$Efficiency = useful output ÷ total input × 100 = 9 ÷ 60 × 100 = 15%. Only 15% of the electrical energy becomes useful light; the remaining 85% becomes heat. This is why incandescent bulbs are being replaced by LED bulbs (which are ~80–90% efficient at producing light).$t$
WHERE id = 4597
  AND explanation = $t$Efficiency = useful output ÷ total input \(\times 100 = 9 \div 60 \times 100 = 15\%\). Only 15% of the electrical energy becomes useful light; the remaining 85% becomes heat. This is why incandescent bulbs are being replaced by LED bulbs (which are ~80–90% efficient at producing light).$t$;

UPDATE questions SET
  question_text = $t$A 1 kg object falls from 20 m. Using conservation of energy, what is its speed just before hitting the ground (g = 10 N/kg)?$t$,
  option_a = $t$200 m/s$t$,
  option_b = $t$20 m/s$t$,
  option_c = $t$40 m/s$t$,
  option_d = $t$10 m/s$t$,
  explanation = $t$Conservation of energy: GPE at top = KE at bottom. mgh = ½mv² → mass cancels → v = √(2gh) = √(2 × 10 × 20) = √400 = 20 m/s. The mass cancels so speed is independent of mass — all objects fall at the same speed from the same height (ignoring air resistance).$t$
WHERE id = 4598
  AND question_text = $t$A \(1\,\text{kg}\) object falls from 20 m. Using conservation of energy, what is its speed just before hitting the ground (\(g = 10\,\text{N/kg}\))?$t$
  AND option_a = $t$\(200\,\text{m/s}\)$t$
  AND option_b = $t$\(20\,\text{m/s}\)$t$
  AND option_c = $t$\(40\,\text{m/s}\)$t$
  AND option_d = $t$\(10\,\text{m/s}\)$t$
  AND explanation = $t$Conservation of energy: GPE at \(top = KE\) at bottom. \(mgh = \tfrac{1}{2}mv^{2}\)→ mass cancels →\(v = \sqrt{2gh} = \sqrt{2 \times 10 \times 20} = \sqrt{400} = 20\,\text{m/s}\). The mass cancels so speed is independent of mass — all objects fall at the same speed from the same height (ignoring air resistance).$t$;

UPDATE questions SET
  explanation = $t$Frequency is measured in Hertz (Hz). One hertz means one complete wave cycle per second. It is related to the time period by f = 1/T. Do not confuse Hz (frequency) with m (wavelength) or m/s (wave speed).$t$
WHERE id = 4600
  AND explanation = $t$Frequency is measured in Hertz (Hz). One hertz means one complete wave cycle per second. It is related to the time period by \(f = \frac{1}{T}\). Do not confuse Hz (frequency) with \(m\) (wavelength) or m/s (wave speed).$t$;

UPDATE questions SET
  option_a = $t$100 m/s$t$,
  option_b = $t$202 m/s$t$,
  option_c = $t$198 m/s$t$,
  option_d = $t$400 m/s$t$,
  explanation = $t$v = fλ = 200 × 2 = 400 m/s. Multiply frequency (Hz) by wavelength (m) to get wave speed (m/s). The wave equation v = fλ links all three quantities — rearrange to find whichever is unknown.$t$
WHERE id = 4602
  AND option_a = $t$\(100\,\text{m/s}\)$t$
  AND option_b = $t$\(202\,\text{m/s}\)$t$
  AND option_c = $t$\(198\,\text{m/s}\)$t$
  AND option_d = $t$\(400\,\text{m/s}\)$t$
  AND explanation = $t$\(v = f\)λ \(= 200 \times 2 = 400\,\text{m/s}\). Multiply frequency (Hz) by wavelength (\(m\)) to get wave speed (m/s). The wave equation \(v = f\)λ links all three quantities — rearrange to find whichever is unknown.$t$;

UPDATE questions SET
  explanation = $t$T = 1/f = 1/50 = 0.02 s. Period and frequency are reciprocals of each other: T = 1/f and f = 1/T. A frequency of 50 Hz means 50 complete cycles per second, so each cycle takes 1/50 = 0.02 seconds.$t$
WHERE id = 4604
  AND explanation = $t$\(T = \frac{1}{f} = \frac{1}{50} = 0.02\,\text{s}\). Period and frequency are reciprocals of each other: \(T = \frac{1}{f}\) and \(f = \frac{1}{T}\). A frequency of 50 Hz means 50 complete cycles per second, so each cycle takes \(\frac{1}{50} = 0.02\) seconds.$t$;

UPDATE questions SET
  explanation = $t$When a wave passes from a less dense medium (air) into a denser medium (glass), it slows down. Since f stays the same and v = fλ, the wavelength also decreases. This speed change causes the wave to change direction — this is refraction.$t$
WHERE id = 4605
  AND explanation = $t$When a wave passes from a less dense medium (air) into a denser medium (glass), it slows down. Since \(f\) stays the same and \(v = f\)λ, the wavelength also decreases. This speed change causes the wave to change direction — this is refraction.$t$;

UPDATE questions SET
  explanation = $t$f = 1/T = 1/4 = 0.25 Hz. The period T is the time for one complete wave cycle (4 seconds). Frequency = 1 ÷ period. A period of 4 s means only one quarter of a wave is completed per second = 0.25 Hz.$t$
WHERE id = 4606
  AND explanation = $t$\(f = \frac{1}{T} = \frac{1}{4} = 0.25\,\text{Hz}\). The period T is the time for one complete wave cycle (4 seconds). Frequency \(= 1\)÷ period. A period of 4 s means only one quarter of a wave is completed per second \(= 0.25\,\text{Hz}\).$t$;

UPDATE questions SET
  option_a = $t$340 m/s$t$,
  option_b = $t$3 × 10⁶ m/s$t$,
  option_c = $t$3 × 10⁸ m/s$t$,
  option_d = $t$3 × 10¹⁰ m/s$t$,
  explanation = $t$All electromagnetic waves travel at 3 × 10⁸ m/s in a vacuum (the speed of light). This is approximately 300 million metres per second. They slow down when passing through materials such as glass or water, but in a vacuum the speed is always the same regardless of frequency.$t$
WHERE id = 4610
  AND option_a = $t$\(340\,\text{m/s}\)$t$
  AND option_b = $t$\(3 \times 10^{6}\,\text{m/s}\)$t$
  AND option_c = $t$\(3 \times 10^{8}\,\text{m/s}\)$t$
  AND option_d = $t$\(3 \times 10^{10}\,\text{m/s}\)$t$
  AND explanation = $t$All electromagnetic waves travel at \(3 \times 10^{8}\,\text{m/s}\) in a vacuum (the speed of light). This is approximately 300 million metres per second. They slow down when passing through materials such as glass or water, but in a vacuum the speed is always the same regardless of frequency.$t$;

UPDATE questions SET
  option_b = $t$The angle of incidence is always 90°$t$,
  option_d = $t$Light always reflects at 45°$t$
WHERE id = 4613
  AND option_b = $t$The angle of incidence is always \(90^\circ\)$t$
  AND option_d = $t$Light always reflects at \(45^\circ\)$t$;

UPDATE questions SET
  explanation = $t$Gamma rays have the highest frequency in the EM spectrum — and therefore carry the most energy per photon. High-energy photons are the most ionising and most penetrating. The order from lowest to highest frequency is: radio → microwave → infrared → visible → UV → X-rays → gamma.$t$
WHERE id = 4617
  AND explanation = $t$Gamma rays have the highest frequency in the EM spectrum — and therefore carry the most energy per photon. High-energy photons are the most ionising and most penetrating. The order from lowest to highest frequency is: radio → microwave → infrared → visible →\(UV \to X\)-rays → gamma.$t$;

UPDATE questions SET
  explanation = $t$Work done = force × distance = 50 × 4 = 200 J. Multiply force (N) by distance (m) to get work done (J). A common error is dividing instead of multiplying: 50/4 = 12.5 J is wrong. Check units: N × m = J ✓.$t$
WHERE id = 4621
  AND explanation = $t$Work done = force × distance \(= 50 \times 4 = 200\,\text{J}\). Multiply force (N) by distance (\(m\)) to get work done (J). A common error is dividing instead of multiplying: \(\frac{50}{4} = 12.5\,\text{J}\) is wrong. Check units: \(N \times m = J \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$Work done is measured in joules (J). This is the same unit as energy — because work done equals energy transferred. One joule = one newton times one metre (J = N m). Do not confuse joules (energy/work) with watts (power) or newtons (force).$t$
WHERE id = 4622
  AND explanation = $t$Work done is measured in joules (J). This is the same unit as energy — because work done equals energy transferred. One joule = one newton times one metre \((J = N m)\). Do not confuse joules (energy/work) with watts (power) or newtons (force).$t$;

UPDATE questions SET
  explanation = $t$Power = work done ÷ time = 300 ÷ 10 = 30 W. Divide work (J) by time (s) to get power (W). Power is the rate of doing work — how much energy is transferred per second. Check: 30 W × 10 s = 300 J ✓.$t$
WHERE id = 4623
  AND explanation = $t$Power = work done ÷ time \(= 300 \div 10 = 30\,\text{W}\). Divide work (J) by time (\(s\)) to get power (W). Power is the rate of doing work — how much energy is transferred per second. Check: \(30\,\text{W} \times 10 s = 300\,\text{J} \checkmark\).$t$;

UPDATE questions SET
  question_text = $t$A person lifts a 10 kg box 2 m above the floor (g = 10 N/kg). How much work do they do against gravity?$t$,
  explanation = $t$Work done = force × distance = weight × height = mgh = 10 × 10 × 2 = 200 J. The force needed to lift the box equals its weight (mg = 10 × 10 = 100 N). Multiply by the height moved (2 m). This work done equals the gravitational potential energy gained.$t$
WHERE id = 4625
  AND question_text = $t$A person lifts \(a\) \(10\,\text{kg}\) box 2 m above the floor (\(g = 10\,\text{N/kg}\)). How much work do they do against gravity?$t$
  AND explanation = $t$Work done = force × distance = weight × height \(= mgh = 10 \times 10 \times 2 = 200\,\text{J}\). The force needed to lift the box equals its weight \((mg = 10 \times 10 = 100\,\text{N})\). Multiply by the height moved (2 m). This work done equals the gravitational potential energy gained.$t$;

UPDATE questions SET
  explanation = $t$Energy = power × time = 500 × 60 = 30 000 J. Multiply power (W) by time (s) to get energy (J). Always ensure time is in seconds. Check: 500 W × 60 s = 30 000 J. In kWh: 0.5 kW × (1/60) h = 0.0083 kWh.$t$
WHERE id = 4626
  AND explanation = $t$Energy = power × time \(= 500 \times 60 = 30\,000\,\text{J}\). Multiply power (W) by time (\(s\)) to get energy (J). Always ensure time is in seconds. Check: \(500\,\text{W} \times 60 s = 30\,000\,\text{J}\). In kWh: \(0.5\,\text{kW} \times (\frac{1}{60}) h = 0.0083\,\text{kWh}\).$t$;

UPDATE questions SET
  explanation = $t$Work done = force × distance × cos θ. When carrying a box horizontally, the supporting upward force is perpendicular to the horizontal displacement (θ = 90°). cos 90° = 0, so work done = 0. The upward force does no work on horizontal displacement — only forces in the direction of movement do work.$t$
WHERE id = 4627
  AND explanation = $t$Work done = force × distance ×\(\cos \theta\). When carrying a box horizontally, the supporting upward force is perpendicular to the horizontal displacement \((\theta = 90^\circ)\). \(\cos 90^\circ = 0\), so work done \(= 0\). The upward force does no work on horizontal displacement — only forces in the direction of movement do work.$t$;

UPDATE questions SET
  explanation = $t$Work done = force × distance = 1500 × 200 = 300 000 J. This is 300 kJ. The engine converts chemical energy (fuel) into kinetic energy of the car and heat (from friction and air resistance). All of this 300 000 J came from burning fuel.$t$
WHERE id = 4628
  AND explanation = $t$Work done = force × distance \(= 1500 \times 200 = 300\,000\,\text{J}\). This is 300 kJ. The engine converts chemical energy (fuel) into kinetic energy of the car and heat (from friction and air resistance). All of this 300 000 J came from burning fuel.$t$;

UPDATE questions SET
  explanation = $t$The unit of power is the watt (W). One watt = one joule per second (1 W = 1 J/s). A 100 W light bulb transfers 100 J of energy every second. Do not confuse watts (power) with joules (energy), newtons (force) or pascals (pressure).$t$
WHERE id = 4629
  AND explanation = $t$The unit of power is the watt (W). One watt = one joule per second (1 \(W = 1\,\text{J/s}\)). A 100 W light bulb transfers 100 J of energy every second. Do not confuse watts (power) with joules (energy), newtons (force) or pascals (pressure).$t$;

UPDATE questions SET
  explanation = $t$Hooke's Law: extension ∝ force (F = kx), provided the elastic limit is not exceeded. The force-extension graph is a straight line through the origin in the Hooke's Law region. The gradient equals the spring constant k. Beyond the elastic limit, the spring is permanently deformed.$t$
WHERE id = 4640
  AND explanation = $t$Hooke's Law: extension ∝ force \((F = kx)\), provided the elastic limit is not exceeded. The force-extension graph is a straight line through the origin in the Hooke's Law region. The gradient equals the spring constant \(k\). Beyond the elastic limit, the spring is permanently deformed.$t$;

UPDATE questions SET
  question_text = $t$A spring has spring constant 200 N/m. Calculate the force needed to extend it by 0.05 m.$t$,
  explanation = $t$F = kx = 200 × 0.05 = 10 N. Multiply the spring constant by the extension (in metres). Do not divide. Check: F/k = 10/200 = 0.05 m ✓. Using 5 cm instead of 0.05 m gives k × 5 = 1000 N — always convert to SI units first.$t$
WHERE id = 4641
  AND question_text = $t$A spring has spring constant \(200\,\text{N/m}\). Calculate the force needed to extend it by 0.05 m.$t$
  AND explanation = $t$\(F = kx = 200 \times 0.05 = 10\,\text{N}\). Multiply the spring constant by the extension (in metres). Do not divide. Check: \(\frac{F}{k} = \frac{10}{200} = 0.05\,\text{m} \checkmark\). Using 5 cm instead of 0.05 m gives \(k \times 5 = 1000\,\text{N}\) — always convert to SI units first.$t$;

UPDATE questions SET
  question_text = $t$Calculate the pressure when a force of 400 N acts on an area of 2 m².$t$,
  explanation = $t$Pressure = force ÷ area = 400 ÷ 2 = 200 Pa. Always divide force by area — never multiply. Check units: N ÷ m² = Pa ✓. Verify: 200 Pa × 2 m² = 400 N ✓.$t$
WHERE id = 4643
  AND question_text = $t$Calculate the pressure when a force of 400 N acts on an area of \(2 m^{2}\).$t$
  AND explanation = $t$Pressure = force ÷ area \(= 400 \div 2 = 200\,\text{Pa}\). Always divide force by area — never multiply. Check units: \(N \div m^{2}\)= Pa ✓. Verify: \(200\,\text{Pa} \times 2 m^{2} = 400\,\text{N} \checkmark\).$t$;

UPDATE questions SET
  explanation = $t$The spring constant k is measured in newtons per metre (N/m). It tells you how many newtons of force are needed to extend or compress the spring by one metre. A higher k means a stiffer spring — more force needed for the same extension.$t$
WHERE id = 4644
  AND explanation = $t$The spring constant \(k\) is measured in newtons per metre (N/m). It tells you how many newtons of force are needed to extend or compress the spring by one metre. A higher \(k\) means a stiffer spring — more force needed for the same extension.$t$;

UPDATE questions SET
  option_a = $t$18 N/m$t$,
  option_b = $t$0.005 N/m$t$,
  option_c = $t$200 N/m$t$,
  option_d = $t$180 N/m$t$,
  explanation = $t$k = F ÷ x = 60 ÷ 0.3 = 200 N/m. Rearrange Hooke's Law F = kx to get k = F/x. Divide force by extension. A common error is inverting: 0.3/60 = 0.005 N/m — always divide the larger number (force) by the smaller (extension in metres).$t$
WHERE id = 4645
  AND option_a = $t$\(18\,\text{N/m}\)$t$
  AND option_b = $t$\(0.005\,\text{N/m}\)$t$
  AND option_c = $t$\(200\,\text{N/m}\)$t$
  AND option_d = $t$\(180\,\text{N/m}\)$t$
  AND explanation = $t$\(k = F \div x = 60 \div 0.3 = 200\,\text{N/m}\). Rearrange Hooke's Law \(F = kx\) to get \(k = \frac{F}{x}\). Divide force by extension. A common error is inverting: \(\frac{0.3}{60} = 0.005\,\text{N/m}\) — always divide the larger number (force) by the smaller (extension in metres).$t$;

UPDATE questions SET
  explanation = $t$Pressure increases with depth because the weight of fluid above that point increases — more fluid above means a greater downward force per unit area. P = ρgh: pressure depends on fluid density (ρ), gravitational field strength (g) and depth (h). Doubling depth doubles the pressure.$t$
WHERE id = 4647
  AND explanation = $t$Pressure increases with depth because the weight of fluid above that point increases — more fluid above means a greater downward force per unit area. P = ρgh: pressure depends on fluid density (ρ), gravitational field strength (\(g\)) and depth (\(h\)). Doubling depth doubles the pressure.$t$;

UPDATE questions SET
  question_text = $t$A hydraulic system has a small piston of area 0.01 m² with a force of 100 N applied. What pressure is transmitted through the fluid?$t$,
  explanation = $t$Pressure = F ÷ A = 100 ÷ 0.01 = 10 000 Pa. In a hydraulic system this pressure is transmitted equally throughout the fluid to all surfaces. The large piston (bigger area) therefore produces a larger output force: F = P × A.$t$
WHERE id = 4648
  AND question_text = $t$A hydraulic system has a small piston of area \(0.01 m^{2}\) with a force of 100 N applied. What pressure is transmitted through the fluid?$t$
  AND explanation = $t$Pressure \(= F \div A = 100 \div 0.01 = 10\,000\,\text{Pa}\). In a hydraulic system this pressure is transmitted equally throughout the fluid to all surfaces. The large piston (bigger area) therefore produces a larger output force: \(F = P \times A\).$t$;

UPDATE questions SET
  explanation = $t$The gradient of the straight (linear) section of a force-extension graph = F/x = spring constant k. A steeper gradient means a stiffer spring with a larger k. The elastic limit is the point where the graph stops being a straight line — not the gradient itself.$t$
WHERE id = 4649
  AND explanation = $t$The gradient of the straight (linear) section of a force-extension graph \(= \frac{F}{x}\)= spring constant \(k\). A steeper gradient means a stiffer spring with a larger \(k\). The elastic limit is the point where the graph stops being a straight line — not the gradient itself.$t$;

UPDATE questions SET
  question_text = $t$A 3 kg ball is dropped from 20 m. Air resistance does 80 J of work on the way down. What is the ball's kinetic energy just before it hits the ground? (g = 10 N/kg)$t$,
  option_b = $t$600 J — minus 80 J wasted = 520 J$t$,
  option_c = $t$Exactly 600 J because mass × g × h$t$,
  explanation = $t$GPE = mgh = 3×10×20 = 600 J. Air resistance does 80 J of work against the ball, removing 80 J from the kinetic energy. By conservation of energy: KE = GPE − work done by air resistance = 600 − 80 = 520 J. Energy is conserved overall — the 80 J goes to thermal energy of the air.$t$
WHERE id = 4650
  AND question_text = $t$A \(3\,\text{kg}\) ball is dropped from 20 m. Air resistance does 80 J of work on the way down. What is the ball's kinetic energy just before it hits the ground? (\(g = 10\,\text{N/kg}\))$t$
  AND option_b = $t$600 J — minus 80 J wasted \(= 520\,\text{J}\)$t$
  AND option_c = $t$Exactly 600 J because mass ×\(g \times h\)$t$
  AND explanation = $t$\(GPE = mgh = 3 \times 10 \times 20 = 600\,\text{J}\). Air resistance does 80 J of work against the ball, removing 80 J from the kinetic energy. By conservation of energy: \(KE = GPE\)− work done by air resistance \(= 600 - 80 = 520\,\text{J}\). Energy is conserved overall — the 80 J goes to thermal energy of the air.$t$;

UPDATE questions SET
  explanation = $t$COP = useful energy output / energy input = 3000 / 1000 = 3. A heat pump delivers more thermal energy than the electrical energy it consumes by extracting heat from the environment. COP > 1 is possible and does not violate energy conservation — the extra energy comes from the surroundings.$t$
WHERE id = 4651
  AND explanation = $t$COP = useful energy output / energy input \(= \frac{3000}{1000} = 3\). A heat pump delivers more thermal energy than the electrical energy it consumes by extracting heat from the environment. \(COP > 1\) is possible and does not violate energy conservation — the extra energy comes from the surroundings.$t$;

UPDATE questions SET
  question_text = $t$E = mcΔT. A 500 g aluminium block (c = 900 J/kg°C) absorbs 4050 J. Calculate the temperature rise.$t$,
  option_a = $t$9°C$t$,
  option_b = $t$4.5°C$t$,
  option_c = $t$18°C$t$,
  option_d = $t$900°C$t$,
  explanation = $t$c = E/(mΔT) = 4050/(0.5×ΔT). ΔT = 4050/(0.5×900) = 4050/450 = 9°C. Convert 500 g to 0.5 kg first. Rearrange E = mcΔT to ΔT = E/(mc). Check: 0.5×900×9 = 4050 J ✓.$t$
WHERE id = 4652
  AND question_text = $t$\(E = mc\)ΔT. A \(500\,\text{g}\) aluminium block (\(c = 900\,\text{J/kg°C}\)) absorbs 4050 J. Calculate the temperature rise.$t$
  AND option_a = $t$\(9^\circ C\)$t$
  AND option_b = $t$\(4.5^\circ C\)$t$
  AND option_c = $t$\(18^\circ C\)$t$
  AND option_d = $t$\(900^\circ C\)$t$
  AND explanation = $t$\(c = E /\)(\(m\)ΔT) \(= 4050 /\)(0.5×ΔT). Δ\(T = \frac{4050}{0.5 \times 900} = \frac{4050}{450} = 9^\circ C\). Convert \(500\,\text{g}\) to \(0.5\,\text{kg}\) first. Rearrange \(E = mc\)ΔT to Δ\(T = E /\)(mc). Check: \(0.5 \times 900 \times 9 = 4050\,\text{J} \checkmark\).$t$;

UPDATE questions SET
  question_text = $t$A spring (k = 400 N/m) is compressed by 0.15 m and launches a 0.3 kg ball vertically. Assuming all EPE converts to GPE, how high does the ball rise? (g = 10 N/kg)$t$,
  explanation = $t$Elastic potential energy = ½ke² = ½ × 400 × 0.15² = 4.5 J. All of it becomes gravitational potential energy: mgh = 4.5, so h = 4.5 ÷ (0.3 × 10) = 1.5 m.$t$
WHERE id = 4653
  AND question_text = $t$A spring (\(k = 400\,\text{N/m}\)) is compressed by 0.15 m and launches \(a\) \(0.3\,\text{kg}\) ball vertically. Assuming all EPE converts to GPE, how high does the ball rise? (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Elastic potential energy \(= \tfrac{1}{2}ke^{2} = \tfrac{1}{2} \times 400 \times 0.15^{2} = 4.5\,\text{J}\). All of it becomes gravitational potential energy: \(mgh = 4.5\), so \(h = 4.5 \div (0.3 \times 10) = 1.5\,\text{m}\).$t$;

UPDATE questions SET
  explanation = $t$Input energy = useful output / efficiency = 3900 / 0.65 = 6000 J. Always divide useful output by the efficiency fraction (not percentage). Check: 0.65 × 6000 = 3900 J ✓. A common error is multiplying: 3900 × 0.65 = 2535 J (this would be the output if 2535 J were the input).$t$
WHERE id = 4654
  AND explanation = $t$Input energy = useful output / efficiency \(= \frac{3900}{0.65} = 6000\,\text{J}\). Always divide useful output by the efficiency fraction (not percentage). Check: \(0.65 \times 6000 = 3900\,\text{J} \checkmark\). A common error is multiplying: \(3900 \times 0.65 = 2535\,\text{J}\) (this would be the output if 2535 J were the input).$t$;

UPDATE questions SET
  question_text = $t$A rollercoaster car (mass 500 kg) starts from rest at 30 m height. Ignoring friction, what is its speed at a point 10 m above the ground? (g = 10 N/kg)$t$,
  option_a = $t$10 m/s$t$,
  option_b = $t$20 m/s$t$,
  option_c = $t$14 m/s$t$,
  option_d = $t$400 m/s$t$,
  explanation = $t$Conservation of energy: KE gained = GPE lost = mg(30−10) = 500×10×20 = 100 000 J. v = √(2KE/m) = √(2×100 000/500) = √400 = 20 m/s. The car loses 20 m of height (from 30 m to 10 m). All lost GPE becomes KE (frictionless).$t$
WHERE id = 4655
  AND question_text = $t$A rollercoaster car (mass 500 kg) starts from rest at 30 m height. Ignoring friction, what is its speed at a point 10 m above the ground? (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(10\,\text{m/s}\)$t$
  AND option_b = $t$\(20\,\text{m/s}\)$t$
  AND option_c = $t$\(14\,\text{m/s}\)$t$
  AND option_d = $t$\(400\,\text{m/s}\)$t$
  AND explanation = $t$Conservation of energy: KE gained \(= GPE\) lost \(= mg(30 - 10) = 500 \times 10 \times 20 = 100\,000\,\text{J}\). \(v = \sqrt{\frac{2KE}{m}} = \sqrt{2 \times \frac{100\,000}{500}} = \sqrt{400} = 20\,\text{m/s}\). The car loses 20 m of height (from 30 m to 10 m). All lost GPE becomes KE (frictionless).$t$;

UPDATE questions SET
  question_text = $t$Power = Fv. A car drives at constant 30 m/s against a resistive force of 800 N. What power does the engine develop?$t$,
  explanation = $t$P = Fv = 800 × 30 = 24 000 W. At constant speed, driving force = resistive force = 800 N. Power = force × velocity. This is derived from P = W/t = Fd/t = F×(d/t) = Fv. Check: 24 000 W = 24 kW, a reasonable car engine power.$t$
WHERE id = 4656
  AND question_text = $t$Power = Fv. A car drives at constant \(30\,\text{m/s}\) against a resistive force of 800 N. What power does the engine develop?$t$
  AND explanation = $t$P = Fv \(= 800 \times 30 = 24\,000 W\). At constant speed, driving force = resistive force \(= 800\,\text{N}\). Power = force × velocity. This is derived from \(P = \frac{W}{t}\)= Fd/\(t = F \times (\frac{d}{t})\)= Fv. Check: \(24\,000 W = 24\,\text{kW}\), a reasonable car engine power.$t$;

UPDATE questions SET
  question_text = $t$A 2 kg object falls from rest through air. After falling 10 m its speed is 12 m/s. How much energy was lost to air resistance? (g = 10 N/kg)$t$,
  explanation = $t$Expected KE without air resistance = mgh = 2×10×10 = 200 J. Actual KE = ½mv² = ½×2×12² = ½×2×144 = 144 J. Energy lost to air resistance = 200 − 144 = 56 J. The difference between the theoretical maximum KE and the actual KE equals the work done by air resistance.$t$
WHERE id = 4657
  AND question_text = $t$A \(2\,\text{kg}\) object falls from rest through air. After falling 10 m its speed is \(12\,\text{m/s}\). How much energy was lost to air resistance? (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Expected KE without air resistance \(= mgh = 2 \times 10 \times 10 = 200\,\text{J}\). Actual \(KE = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 2 \times 12^{2} = \tfrac{1}{2} \times 2 \times 144 = 144\,\text{J}\). Energy lost to air resistance \(= 200 - 144 = 56\,\text{J}\). The difference between the theoretical maximum KE and the actual KE equals the work done by air resistance.$t$;

UPDATE questions SET
  question_text = $t$Two identical springs in series (each k = 200 N/m) are compressed 0.1 m. Calculate the total EPE stored.$t$,
  explanation = $t$The springs are in series, so each takes the same force and compresses half the total: 0.05 m. Each stores ½ × 200 × 0.05² = 0.25 J, so the total is 0.5 J.$t$
WHERE id = 4658
  AND question_text = $t$Two identical springs in series (each \(k = 200\,\text{N/m}\)) are compressed 0.1 m. Calculate the total EPE stored.$t$
  AND explanation = $t$The springs are in series, so each takes the same force and compresses half the total: 0.05 m. Each stores \(\tfrac{1}{2} \times 200 \times 0.05^{2} = 0.25\,\text{J}\), so the total is 0.5 J.$t$;

UPDATE questions SET
  question_text = $t$A pumped storage power station raises 5 × 10⁶ kg of water by 100 m. How much GPE is stored? (g = 10 N/kg)$t$,
  option_a = $t$5 × 10⁸ J$t$,
  option_b = $t$5 × 10⁹ J$t$,
  option_c = $t$5 × 10⁷ J$t$,
  option_d = $t$5 × 10¹⁰ J$t$,
  explanation = $t$GPE = mgh = 5×10⁶ × 10 × 100 = 5×10⁹ J. Multiply all three: mass (kg) × g (N/kg) × height (m) = GPE (J). This is a pumped storage hydroelectric system — the stored GPE can be released by letting water fall back through turbines to generate electricity on demand.$t$
WHERE id = 4659
  AND question_text = $t$A pumped storage power station raises \(5 \times 10^{6}\,\text{kg}\) of water by 100 m. How much GPE is stored? (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$\(5 \times 10^{8}\,\text{J}\)$t$
  AND option_b = $t$\(5 \times 10^{9}\,\text{J}\)$t$
  AND option_c = $t$\(5 \times 10^{7}\,\text{J}\)$t$
  AND option_d = $t$\(5 \times 10^{10}\,\text{J}\)$t$
  AND explanation = $t$\(GPE = mgh = 5 \times 10^{6} \times 10 \times 100 = 5 \times 10^{9}\,\text{J}\). Multiply all three: mass (kg) × g (N/kg) × height \((m) = GPE (J)\). This is a pumped storage hydroelectric system — the stored GPE can be released by letting water fall back through turbines to generate electricity on demand.$t$;

UPDATE questions SET
  question_text = $t$A wave travels from deep water (speed 6 m/s) into shallow water (speed 2 m/s). The frequency is 3 Hz. What is the wavelength in shallow water?$t$,
  explanation = $t$Wavelength = v/f = 2/3 = 0.667 m ≈ 0.67 m. When a wave slows down (entering shallower water), wavelength decreases proportionally since frequency is unchanged (set by the source). v = fλ → λ = v/f = 2/3 m. The frequency stays at 3 Hz throughout.$t$
WHERE id = 4660
  AND question_text = $t$A wave travels from deep water (speed \(6\,\text{m/s}\)) into shallow water (speed \(2\,\text{m/s}\)). The frequency is 3 Hz. What is the wavelength in shallow water?$t$
  AND explanation = $t$Wavelength \(= \frac{v}{f} = \frac{2}{3} = 0.667\,\text{m} \approx 0.67\,\text{m}\). When a wave slows down (entering shallower water), wavelength decreases proportionally since frequency is unchanged (set by the source). \(v = f\)λ → λ \(= \frac{v}{f} = \frac{2}{3}\,\text{m}\). The frequency stays at 3 Hz throughout.$t$;

UPDATE questions SET
  question_text = $t$A sound wave in air (v = 340 m/s) hits a boundary with water (v = 1500 m/s). The frequency is 500 Hz. What is the wavelength in water?$t$,
  explanation = $t$λ = v/f = 1500/500 = 3 m. The frequency does not change when the wave crosses the boundary — it is determined by the source. Only speed and wavelength change. In water, sound travels ~4× faster than in air, so the wavelength is ~4× longer.$t$
WHERE id = 4662
  AND question_text = $t$A sound wave in air (\(v = 340\,\text{m/s}\)) hits a boundary with water (\(v = 1500\,\text{m/s}\)). The frequency is 500 Hz. What is the wavelength in water?$t$
  AND explanation = $t$λ \(= \frac{v}{f} = \frac{1500}{500} = 3\,\text{m}\). The frequency does not change when the wave crosses the boundary — it is determined by the source. Only speed and wavelength change. In water, sound travels ~4× faster than in air, so the wavelength is ~4× longer.$t$;

UPDATE questions SET
  question_text = $t$Two waves of equal amplitude interfere. At a point of constructive interference the amplitude is 2A. At a point of destructive interference the amplitude is:$t$,
  option_a = $t$2A$t$,
  option_d = $t$4A$t$,
  explanation = $t$At a point of destructive interference, the two waves are exactly out of phase (180° phase difference). The crests of one coincide with the troughs of the other — they cancel completely, giving amplitude = 0. This is the principle behind noise-cancelling headphones.$t$
WHERE id = 4663
  AND question_text = $t$Two waves of equal amplitude interfere. At a point of constructive interference the amplitude is \(2A\). At a point of destructive interference the amplitude is:$t$
  AND option_a = $t$\(2A\)$t$
  AND option_d = $t$\(4A\)$t$
  AND explanation = $t$At a point of destructive interference, the two waves are exactly out of phase (\(180^\circ\) phase difference). The crests of one coincide with the troughs of the other — they cancel completely, giving amplitude \(= 0\). This is the principle behind noise-cancelling headphones.$t$;

UPDATE questions SET
  explanation = $t$For the fundamental mode, the string has one antinode in the middle and nodes at both fixed ends — this is a half wavelength. So λ = 2L = 2×0.65 = 1.3 m. The fundamental frequency f = v/λ. Higher harmonics have λ = 2L/n for the nth harmonic.$t$
WHERE id = 4664
  AND explanation = $t$For the fundamental mode, the string has one antinode in the middle and nodes at both fixed ends — this is a half wavelength. So λ \(= 2L = 2 \times 0.65 = 1.3\,\text{m}\). The fundamental frequency \(f = v\)/λ. Higher harmonics have λ \(= \frac{2L}{n}\) for the nth harmonic.$t$;

UPDATE questions SET
  option_a = $t$0.8 m/s$t$,
  option_b = $t$0.4 m/s$t$,
  option_c = $t$0.1 m/s$t$,
  option_d = $t$0.2 m/s$t$,
  explanation = $t$Distance between 5 consecutive crests = 4 wavelengths (5 crests have 4 gaps between them). λ = 8/4 = 2 cm = 0.02 m. Speed = fλ = 10 × 0.02 = 0.2 m/s. The common error is dividing by 5 instead of 4 — always count the gaps between crests, not the crests themselves.$t$
WHERE id = 4665
  AND option_a = $t$\(0.8\,\text{m/s}\)$t$
  AND option_b = $t$\(0.4\,\text{m/s}\)$t$
  AND option_c = $t$\(0.1\,\text{m/s}\)$t$
  AND option_d = $t$\(0.2\,\text{m/s}\)$t$
  AND explanation = $t$Distance between 5 consecutive crests \(= 4\) wavelengths (5 crests have 4 gaps between them). λ \(= \frac{8}{4} = 2\,\text{cm} = 0.02\,\text{m}\). Speed \(= f\)λ \(= 10 \times 0.02 = 0.2\,\text{m/s}\). The common error is dividing by 5 instead of 4 — always count the gaps between crests, not the crests themselves.$t$;

UPDATE questions SET
  question_text = $t$The refractive index of glass is 1.5. What is the speed of light in glass? (c = 3 × 10⁸ m/s)$t$,
  option_a = $t$4.5 × 10⁸ m/s$t$,
  option_b = $t$1.5 × 10⁸ m/s$t$,
  option_c = $t$2.0 × 10⁸ m/s$t$,
  option_d = $t$3.0 × 10⁸ m/s$t$,
  explanation = $t$v = c/n = (3×10⁸)/1.5 = 2.0×10⁸ m/s. The refractive index n = c/v, so v = c/n. Light slows down when entering a denser medium. The higher the refractive index, the slower the speed of light in that medium.$t$
WHERE id = 4666
  AND question_text = $t$The refractive index of glass is 1.5. What is the speed of light in glass? \((c = 3 \times 10^{8}\,\text{m/s})\)$t$
  AND option_a = $t$\(4.5 \times 10^{8}\,\text{m/s}\)$t$
  AND option_b = $t$\(1.5 \times 10^{8}\,\text{m/s}\)$t$
  AND option_c = $t$\(2.0 \times 10^{8}\,\text{m/s}\)$t$
  AND option_d = $t$\(3.0 \times 10^{8}\,\text{m/s}\)$t$
  AND explanation = $t$\(v = \frac{c}{n} = \frac{3 \times 10^{8}}{1.5} = 2.0 \times 10^{8}\,\text{m/s}\). The refractive index \(n = \frac{c}{v}\), so \(v = \frac{c}{n}\). Light slows down when entering a denser medium. The higher the refractive index, the slower the speed of light in that medium.$t$;

UPDATE questions SET
  question_text = $t$Seismic P-waves travel at 6000 m/s. An earthquake produces waves of frequency 0.5 Hz. What is the wavelength?$t$,
  explanation = $t$λ = v/f = 6000/0.5 = 12 000 m. Seismic waves have very long wavelengths because they travel fast but at low frequencies. The wave equation v = fλ always applies — rearrange to λ = v/f.$t$
WHERE id = 4667
  AND question_text = $t$Seismic P-waves travel at \(6000\,\text{m/s}\). An earthquake produces waves of frequency 0.5 Hz. What is the wavelength?$t$
  AND explanation = $t$λ \(= \frac{v}{f} = \frac{6000}{0.5} = 12\,000\,\text{m}\). Seismic waves have very long wavelengths because they travel fast but at low frequencies. The wave equation \(v = f\)λ always applies — rearrange to λ \(= \frac{v}{f}\).$t$;

UPDATE questions SET
  question_text = $t$A microwave oven uses waves of wavelength 12 cm. The speed of microwaves is 3 × 10⁸ m/s. What is their frequency?$t$,
  option_a = $t$3.6 × 10⁸ Hz$t$,
  option_b = $t$2.5 × 10⁹ Hz$t$,
  option_d = $t$2.5 × 10¹⁰ Hz$t$,
  explanation = $t$f = v/λ = (3×10⁸)/(0.12) = 2.5×10⁹ Hz. Convert wavelength to metres: 12 cm = 0.12 m. Rearrange v = fλ to f = v/λ. 2.5×10⁹ Hz = 2.5 GHz — this is the frequency used by standard microwave ovens and 2.4 GHz WiFi.$t$
WHERE id = 4668
  AND question_text = $t$A microwave oven uses waves of wavelength 12 cm. The speed of microwaves is \(3 \times 10^{8}\,\text{m/s}\). What is their frequency?$t$
  AND option_a = $t$\(3.6 \times 10^{8}\,\text{Hz}\)$t$
  AND option_b = $t$\(2.5 \times 10^{9}\,\text{Hz}\)$t$
  AND option_d = $t$\(2.5 \times 10^{10}\,\text{Hz}\)$t$
  AND explanation = $t$\(f = v\)/λ \(= \frac{3 \times 10^{8}}{0.12} = 2.5 \times 10^{9}\,\text{Hz}\). Convert wavelength to metres: \(12\,\text{cm} = 0.12\,\text{m}\). Rearrange \(v = f\)λ to \(f = v\)/λ. \(2.5 \times 10^{9}\,\text{Hz} = 2.5\) GHz — this is the frequency used by standard microwave ovens and 2.4 GHz WiFi.$t$;

UPDATE questions SET
  option_a = $t$24.4°$t$,
  option_b = $t$41.2°$t$,
  option_c = $t$48.8°$t$,
  option_d = $t$67.4°$t$,
  explanation = $t$Critical angle c: sin(c) = 1/n = 1/2.42 = 0.413. c = sin⁻¹(0.413) = 24.4°. The critical angle is the minimum angle of incidence (inside the denser medium) beyond which total internal reflection occurs. Diamond's very high refractive index means a small critical angle — most light is totally internally reflected, producing brilliance.$t$
WHERE id = 4670
  AND option_a = $t$\(24.4^\circ\)$t$
  AND option_b = $t$\(41.2^\circ\)$t$
  AND option_c = $t$\(48.8^\circ\)$t$
  AND option_d = $t$\(67.4^\circ\)$t$
  AND explanation = $t$Critical angle \(c\): \(\sin(c) = \frac{1}{n} = \frac{1}{2.42} = 0.413\). \(c = \sin^{-1}(0.413) = 24.4^\circ\). The critical angle is the minimum angle of incidence (inside the denser medium) beyond which total internal reflection occurs. Diamond's very high refractive index means a small critical angle — most light is totally internally reflected, producing brilliance.$t$;

UPDATE questions SET
  question_text = $t$A ray of light strikes a glass surface at 30° to the normal. The refractive index of glass is 1.5. What is the angle of refraction? (sin 30° = 0.5)$t$,
  option_a = $t$20°$t$,
  option_b = $t$30°$t$,
  option_c = $t$45°$t$,
  option_d = $t$19.5°$t$,
  explanation = $t$The ray goes from air into glass: 1.0 × sin 30° = 1.5 × sin θ, so sin θ = 0.5 ÷ 1.5 = 0.333 and θ ≈ 19.5°. Light slows down entering the glass, so it bends towards the normal.$t$
WHERE id = 4671
  AND question_text = $t$A ray of light strikes a glass surface at \(30^\circ\) to the normal. The refractive index of glass is 1.5. What is the angle of refraction? \((\sin 30^\circ = 0.5)\)$t$
  AND option_a = $t$\(20^\circ\)$t$
  AND option_b = $t$\(30^\circ\)$t$
  AND option_c = $t$\(45^\circ\)$t$
  AND option_d = $t$\(19.5^\circ\)$t$
  AND explanation = $t$The ray goes from air into glass: \(1.0 \times \sin 30^\circ = 1.5 \times \sin \theta\), so \(\sin \theta = 0.5 \div 1.5 = 0.333\) and \(\theta \approx 19.5^\circ\). Light slows down entering the glass, so it bends towards the normal.$t$;

UPDATE questions SET
  explanation = $t$30% signal loss means 70% remains. If the original power is P, the remaining power is 0.70P. The answer is 70%. Note this is a linear (not logarithmic) loss — in real optical fibre systems, loss is expressed in dB/km and is logarithmic, but this question uses a simple percentage.$t$
WHERE id = 4672
  AND explanation = $t$30% signal loss means 70% remains. If the original power is P, the remaining power is \(0.70P\). The answer is 70%. Note this is a linear (not logarithmic) loss — in real optical fibre systems, loss is expressed in dB/km and is logarithmic, but this question uses a simple percentage.$t$;

UPDATE questions SET
  question_text = $t$Gamma rays from a source have frequency 3 × 10²⁰ Hz. Calculate their wavelength. (c = 3 × 10⁸ m/s)$t$,
  option_a = $t$9 × 10²⁸ m$t$,
  option_b = $t$10⁻¹² m$t$,
  option_c = $t$3 × 10¹² m$t$,
  option_d = $t$1 × 10⁻¹² m$t$,
  explanation = $t$λ = c/f = (3×10⁸)/(3×10²⁰) = 1×10⁻¹² m = 1 pm (picometre). Gamma ray wavelengths are of the order of picometres — comparable to or smaller than atomic nuclei. This is why gamma rays can interact directly with atomic nuclei.$t$
WHERE id = 4673
  AND question_text = $t$Gamma rays from a source have frequency \(3 \times 10^{20}\,\text{Hz}\). Calculate their wavelength. \((c = 3 \times 10^{8}\,\text{m/s})\)$t$
  AND option_a = $t$\(9 \times 10^{28}\,\text{m}\)$t$
  AND option_b = $t$\(10^{-12}\,\text{m}\)$t$
  AND option_c = $t$\(3 \times 10^{12}\,\text{m}\)$t$
  AND option_d = $t$\(1 \times 10^{-12}\,\text{m}\)$t$
  AND explanation = $t$λ \(= \frac{c}{f} = \frac{3 \times 10^{8}}{3 \times 10^{20}} = 1 \times 10^{-12} m = 1\) pm (picometre). Gamma ray wavelengths are of the order of picometres — comparable to or smaller than atomic nuclei. This is why gamma rays can interact directly with atomic nuclei.$t$;

UPDATE questions SET
  question_text = $t$A converging lens has focal length 10 cm. An object is placed 30 cm from the lens. Using 1/f = 1/v − 1/u, where is the image formed?$t$,
  explanation = $t$Using 1/f = 1/v − 1/u with u = −30 cm (object distance, negative by convention): 1/10 = 1/v − 1/(−30) → 1/v = 1/10 − 1/30 = 3/30 − 1/30 = 2/30 → v = 15 cm. The image forms 15 cm on the other side of the lens. Since v is positive, it is a real image.$t$
WHERE id = 4674
  AND question_text = $t$A converging lens has focal length 10 cm. An object is placed 30 cm from the lens. Using \(\frac{1}{f} = \frac{1}{v} - \frac{1}{u}\), where is the image formed?$t$
  AND explanation = $t$Using \(\frac{1}{f} = \frac{1}{v} - \frac{1}{u}\) with \(u = - 30\,\text{cm}\) (object distance, negative by convention): \(\frac{1}{10} = \frac{1}{v} - \frac{1}{- 30} \to \frac{1}{v} = \frac{1}{10} - \frac{1}{30} = \frac{3}{30} - \frac{1}{30} = \frac{2}{30} \to v = 15\,\text{cm}\). The image forms 15 cm on the other side of the lens. Since \(v\) is positive, it is a real image.$t$;

UPDATE questions SET
  question_text = $t$The intensity of radiation from a point source obeys the inverse square law. If intensity is 100 W/m² at 2 m, what is it at 6 m?$t$,
  option_a = $t$33.3 W/m²$t$,
  option_b = $t$11.1 W/m²$t$,
  option_c = $t$300 W/m²$t$,
  option_d = $t$12.5 W/m²$t$,
  explanation = $t$Inverse square law: I ∝ 1/d². I₂/I₁ = (d₁/d₂)² = (2/6)² = (1/3)² = 1/9. I₂ = 100/9 ≈ 11.1 W/m². When distance triples, intensity falls by a factor of 9. This law applies to all point sources radiating uniformly in all directions (sound, light, radiation).$t$
WHERE id = 4675
  AND question_text = $t$The intensity of radiation from a point source obeys the inverse square law. If intensity is \(100\,\text{W/m}^{2}\) at 2 m, what is it at 6 m?$t$
  AND option_a = $t$\(33.3\,\text{W/m}^{2}\)$t$
  AND option_b = $t$\(11.1\,\text{W/m}^{2}\)$t$
  AND option_c = $t$\(300\,\text{W/m}^{2}\)$t$
  AND option_d = $t$\(12.5\,\text{W/m}^{2}\)$t$
  AND explanation = $t$Inverse square law: \(I \propto \frac{1}{d^{2}}\). I₂/I₁ \(= (\frac{d_{1}}{d_{2}})^{2} = (\frac{2}{6})^{2} = (\frac{1}{3})^{2} = \frac{1}{9}\). I₂ \(= \frac{100}{9}\)≈ \(11.1\,\text{W/m}^{2}\). When distance triples, intensity falls by a factor of 9. This law applies to all point sources radiating uniformly in all directions (sound, light, radiation).$t$;

UPDATE questions SET
  question_text = $t$A mobile phone signal uses microwaves of frequency 1.8 GHz. Calculate the wavelength. (c = 3 × 10⁸ m/s)$t$,
  option_a = $t$5.4 × 10¹⁷ m$t$,
  option_d = $t$6 × 10⁻³ m$t$,
  explanation = $t$λ = c/f = (3×10⁸)/(1.8×10⁹) = 3/18 = 0.167 m = 16.7 cm. Convert 1.8 GHz = 1.8×10⁹ Hz. Divide speed of light by frequency. Mobile phone wavelengths (~17 cm) are in the microwave range — longer than visible light but shorter than typical radio waves.$t$
WHERE id = 4676
  AND question_text = $t$A mobile phone signal uses microwaves of frequency 1.8 GHz. Calculate the wavelength. \((c = 3 \times 10^{8}\,\text{m/s})\)$t$
  AND option_a = $t$\(5.4 \times 10^{17}\,\text{m}\)$t$
  AND option_d = $t$\(6 \times 10^{-3}\,\text{m}\)$t$
  AND explanation = $t$λ \(= \frac{c}{f} = \frac{3 \times 10^{8}}{1.8 \times 10^{9}} = \frac{3}{18} = 0.167 m = 16.7\,\text{cm}\). Convert 1.8 GHz \(= 1.8 \times 10^{9}\,\text{Hz}\). Divide speed of light by frequency. Mobile phone wavelengths (~17 cm) are in the microwave range — longer than visible light but shorter than typical radio waves.$t$;

UPDATE questions SET
  explanation = $t$X-ray photons have much higher frequency than UV (E = hf), so each photon carries far more energy. Higher energy photons penetrate more deeply into tissue and cause more severe DNA damage (double-strand breaks) when absorbed. UV mainly causes surface skin damage; X-rays can damage internal organs.$t$
WHERE id = 4677
  AND explanation = $t$X-ray photons have much higher frequency than \(UV (E = hf)\), so each photon carries far more energy. Higher energy photons penetrate more deeply into tissue and cause more severe DNA damage (double-strand breaks) when absorbed. UV mainly causes surface skin damage; X-rays can damage internal organs.$t$;

UPDATE questions SET
  question_text = $t$A glass block has refractive index 1.6. The critical angle is approximately 38.7°. A ray inside the block hits the surface at 45°. What happens?$t$,
  option_a = $t$The ray refracts out at 45°$t$,
  explanation = $t$The ray hits the surface at 45°, which is greater than the critical angle of 38.7°. Therefore total internal reflection occurs — the ray does not refract out of the glass. All the light energy is reflected back into the glass. This is the basis for optical fibres.$t$
WHERE id = 4678
  AND question_text = $t$A glass block has refractive index 1.6. The critical angle is approximately \(38.7^\circ\). A ray inside the block hits the surface at \(45^\circ\). What happens?$t$
  AND option_a = $t$The ray refracts out at \(45^\circ\)$t$
  AND explanation = $t$The ray hits the surface at \(45^\circ\), which is greater than the critical angle of \(38.7^\circ\). Therefore total internal reflection occurs — the ray does not refract out of the glass. All the light energy is reflected back into the glass. This is the basis for optical fibres.$t$;

UPDATE questions SET
  explanation = $t$SPF 30 means 30 times less UV reaches the skin — a 30-fold reduction in UV dose. It does not block 30% — it reduces the dose to 1/30 (about 3.3%). So 96.7% of UV is blocked. A higher SPF gives greater protection but even SPF 50 only blocks about 98% of UV.$t$
WHERE id = 4679
  AND explanation = $t$SPF 30 means 30 times less UV reaches the skin — a 30-fold reduction in UV dose. It does not block 30% — it reduces the dose to \(\frac{1}{30}\) (about 3.3%). So 96.7% of UV is blocked. A higher SPF gives greater protection but even SPF 50 only blocks about 98% of UV.$t$;

UPDATE questions SET
  question_text = $t$A 70 kg sprinter accelerates from rest to 10 m/s over 5 s. The resistive force is 60 N. What is the average driving force?$t$,
  explanation = $t$F = ma + F_resistance. a = (10−0)/5 = 2 m/s². F_net = ma = 70×2 = 140 N. Total driving force = F_net + F_resistance = 140 + 60 = 200 N. The driving force must overcome both the resistive force AND provide the net force needed for acceleration.$t$
WHERE id = 4680
  AND question_text = $t$A \(70\,\text{kg}\) sprinter accelerates from rest to \(10\,\text{m/s}\) over 5 s. The resistive force is 60 N. What is the average driving force?$t$
  AND explanation = $t$\(F = ma + F\)_resistance. \(a = \frac{10 - 0}{5} = 2\,\text{m/s}^{2}\). F_\(net = ma = 70 \times 2 = 140\,\text{N}\). Total driving force \(= F\)_\(net + F\)_resistance \(= 140 + 60 = 200\,\text{N}\). The driving force must overcome both the resistive force AND provide the net force needed for acceleration.$t$;

UPDATE questions SET
  question_text = $t$A crane lifts a 2000 kg load at constant speed of 0.5 m/s. What power does the crane develop? (g = 10 N/kg)$t$,
  explanation = $t$P = Fv. At constant speed, F = weight = mg = 2000×10 = 20 000 N. P = 20 000 × 0.5 = 10 000 W = 10 kW. At constant speed, the crane's force equals the weight of the load (no acceleration). Power = force × velocity.$t$
WHERE id = 4681
  AND question_text = $t$A crane lifts \(a\) \(2000\,\text{kg}\) load at constant speed of \(0.5\,\text{m/s}\). What power does the crane develop? (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$P = Fv. At constant speed, F = weight \(= mg = 2000 \times 10 = 20\,000\,\text{N}\). \(P = 20\,000 \times 0.5 = 10\,000 W = 10\,\text{kW}\). At constant speed, the crane's force equals the weight of the load (no acceleration). Power = force × velocity.$t$;

UPDATE questions SET
  question_text = $t$Work done against friction = 500 J over 20 m. Calculate the frictional force.$t$,
  explanation = $t$Work done = force × distance → friction force = work ÷ distance = 500 ÷ 20 = 25 N. This is simply rearranging W = Fd. The friction force acts opposite to the direction of motion, converting kinetic energy to thermal energy.$t$
WHERE id = 4682
  AND question_text = $t$Work done against friction \(= 500\,\text{J}\) over 20 m. Calculate the frictional force.$t$
  AND explanation = $t$Work done = force × distance → friction force = work ÷ distance \(= 500 \div 20 = 25\,\text{N}\). This is simply rearranging W = Fd. The friction force acts opposite to the direction of motion, converting kinetic energy to thermal energy.$t$;

UPDATE questions SET
  question_text = $t$A car (mass 1200 kg) brakes from 30 m/s to 10 m/s. Calculate the work done by the brakes (assume level road).$t$,
  explanation = $t$Work done by brakes = change in KE = ½m(v₁²−v₂²) = ½×1200×(30²−10²) = 600×(900−100) = 600×800 = 480 000 J. The brakes convert kinetic energy to thermal energy. Always calculate the change in KE (not just the final KE).$t$
WHERE id = 4683
  AND question_text = $t$A car (mass 1200 kg) brakes from \(30\,\text{m/s}\) to \(10\,\text{m/s}\). Calculate the work done by the brakes (assume level road).$t$
  AND explanation = $t$Work done by brakes = change in \(KE = \tfrac{1}{2}m(v_{1}^{2} - v_{2}^{2}) = \tfrac{1}{2} \times 1200 \times (30^{2} - 10^{2}) = 600 \times (900 - 100) = 600 \times 800 = 480\,000\,\text{J}\). The brakes convert kinetic energy to thermal energy. Always calculate the change in KE (not just the final KE).$t$;

UPDATE questions SET
  question_text = $t$A 0.5 kg ball is thrown vertically upward at 14 m/s. Using energy methods, calculate the maximum height reached. (g = 10 N/kg)$t$,
  explanation = $t$KE = ½mv² = ½×0.5×14² = ½×0.5×196 = 49 J = mgh. h = 49/(0.5×10) = 9.8 m. Using conservation of energy: all KE converts to GPE at maximum height. Note this assumes no air resistance. 14 m/s is an initial speed giving approximately 10 m height — a reasonable result.$t$
WHERE id = 4684
  AND question_text = $t$A \(0.5\,\text{kg}\) ball is thrown vertically upward at \(14\,\text{m/s}\). Using energy methods, calculate the maximum height reached. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$\(KE = \tfrac{1}{2}mv^{2} = \tfrac{1}{2} \times 0.5 \times 14^{2} = \tfrac{1}{2} \times 0.5 \times 196 = 49 J = mgh\). \(h = \frac{49}{0.5 \times 10} = 9.8\,\text{m}\). Using conservation of energy: all KE converts to GPE at maximum height. Note this assumes no air resistance. \(14\,\text{m/s}\) is an initial speed giving approximately 10 m height — a reasonable result.$t$;

UPDATE questions SET
  question_text = $t$A conveyor belt moves at 2 m/s and exerts a force of 300 N on boxes. What power does the motor driving the belt deliver?$t$,
  explanation = $t$P = Fv = 300 × 2 = 600 W. The belt exerts a constant 300 N force and moves at 2 m/s. Power = force × velocity. This 600 W goes into moving the boxes (useful) and overcoming any friction in the belt mechanism.$t$
WHERE id = 4685
  AND question_text = $t$A conveyor belt moves at \(2\,\text{m/s}\) and exerts a force of 300 N on boxes. What power does the motor driving the belt deliver?$t$
  AND explanation = $t$P = Fv \(= 300 \times 2 = 600\,\text{W}\). The belt exerts a constant 300 N force and moves at \(2\,\text{m/s}\). Power = force × velocity. This 600 W goes into moving the boxes (useful) and overcoming any friction in the belt mechanism.$t$;

UPDATE questions SET
  question_text = $t$A 60 kg person runs up a 5 m staircase in 4 s. Calculate the useful power output. (g = 10 N/kg)$t$,
  explanation = $t$Work done = mgh = 60×10×5 = 3000 J. Power = W/t = 3000/4 = 750 W. Calculate work done against gravity first (mgh), then divide by the time taken. This is the useful (mechanical) power output — the person's actual power output would be higher due to metabolic inefficiency.$t$
WHERE id = 4686
  AND question_text = $t$A \(60\,\text{kg}\) person runs up a 5 m staircase in 4 s. Calculate the useful power output. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Work done \(= mgh = 60 \times 10 \times 5 = 3000\,\text{J}\). Power \(= \frac{W}{t} = \frac{3000}{4} = 750\,\text{W}\). Calculate work done against gravity first (mgh), then divide by the time taken. This is the useful (mechanical) power output — the person's actual power output would be higher due to metabolic inefficiency.$t$;

UPDATE questions SET
  question_text = $t$A 0.2 kg ball moving at 6 m/s is stopped by a net in 0.04 s. What average force does the net exert?$t$,
  explanation = $t$Change in momentum = 0.2 × 6 = 1.2 kg m/s. Force = change in momentum ÷ time = 1.2 ÷ 0.04 = 30 N. A longer stopping time would mean a smaller force — that is why nets and padding work.$t$
WHERE id = 4687
  AND question_text = $t$A \(0.2\,\text{kg}\) ball moving at \(6\,\text{m/s}\) is stopped by a net in 0.04 s. What average force does the net exert?$t$
  AND explanation = $t$Change in momentum \(= 0.2 \times 6 = 1.2\,\text{kg m/s}\). Force = change in momentum ÷ time \(= 1.2 \div 0.04 = 30\,\text{N}\). A longer stopping time would mean a smaller force — that is why nets and padding work.$t$;

UPDATE questions SET
  option_a = $t$Efficiency = 70%, wasted = 150 W$t$,
  option_b = $t$Efficiency = 30%, wasted = 350 W$t$,
  option_c = $t$Efficiency = 70%, wasted = 500 W$t$,
  option_d = $t$Efficiency = 70%, wasted = 1500 W$t$,
  explanation = $t$Efficiency = 3500/5000 = 0.70 = 70%. Wasted energy = 5000−3500 = 1500 J in 10 s. Wasted power = 1500/10 = 150 W. The answer D states "wasted = 1500 W" — that would be per second for 1 second of operation. Wasted power = wasted energy per second = 150 W.$t$
WHERE id = 4688
  AND option_a = $t$Efficiency \(= 70\%\), wasted \(= 150\,\text{W}\)$t$
  AND option_b = $t$Efficiency \(= 30\%\), wasted \(= 350\,\text{W}\)$t$
  AND option_c = $t$Efficiency \(= 70\%\), wasted \(= 500\,\text{W}\)$t$
  AND option_d = $t$Efficiency \(= 70\%\), wasted \(= 1500\,\text{W}\)$t$
  AND explanation = $t$Efficiency \(= \frac{3500}{5000} = 0.70 = 70\%\). Wasted energy \(= 5000 - 3500 = 1500\,\text{J}\) in 10 s. Wasted power \(= \frac{1500}{10} = 150\,\text{W}\). The answer D states "wasted \(= 1500\,\text{W}\)" — that would be per second for 1 second of operation. Wasted power = wasted energy per second \(= 150\,\text{W}\).$t$;

UPDATE questions SET
  question_text = $t$Using v² = u² + 2as, a 0.1 kg ball decelerates from 20 m/s to rest over 0.5 m. What is the average braking force?$t$,
  explanation = $t$v² = u² + 2as: 0 = 20² + 2 × a × 0.5, so a = −400 m/s². Force = ma = 0.1 × 400 = 40 N.$t$
WHERE id = 4689
  AND question_text = $t$Using \(v^{2} = u^{2} + 2as\), \(a\) \(0.1\,\text{kg}\) ball decelerates from \(20\,\text{m/s}\) to rest over 0.5 m. What is the average braking force?$t$
  AND explanation = $t$\(v^{2} = u^{2} + 2as\): \(0 = 20^{2} + 2 \times a \times 0.5\), so \(a = -400\,\text{m/s}^{2}\). Force \(= ma = 0.1 \times 400 = 40\,\text{N}\).$t$;

UPDATE questions SET
  question_text = $t$A Van de Graaff generator charges a metal sphere to 50 000 V. An electron (charge 1.6 × 10⁻¹⁹ C) is moved from earth to the sphere. What work is done?$t$,
  option_a = $t$3.2 × 10⁻²³ J$t$,
  option_b = $t$8 × 10⁻¹⁵ J$t$,
  option_c = $t$8 × 10⁻¹⁵ J$t$,
  explanation = $t$Work done = charge × voltage = qV = 1.6×10⁻¹⁹ × 50 000 = 8×10⁻¹⁵ J. W = qV is the fundamental relationship between work, charge and potential difference. Moving a charge through a potential difference requires (or releases) this amount of energy.$t$
WHERE id = 4690
  AND question_text = $t$A Van de Graaff generator charges a metal sphere to 50 000 V. An electron (charge \(1.6 \times 10^{-19}\,\text{C}\)) is moved from earth to the sphere. What work is done?$t$
  AND option_a = $t$\(3.2 \times 10^{-23}\,\text{J}\)$t$
  AND option_b = $t$\(8 \times 10^{-15}\,\text{J}\)$t$
  AND option_c = $t$\(8 \times 10^{-15}\,\text{J}\)$t$
  AND explanation = $t$Work done = charge × voltage = qV \(= 1.6 \times 10^{-19} \times 50\,000 = 8 \times 10^{-15}\,\text{J}\). W = qV is the fundamental relationship between work, charge and potential difference. Moving a charge through a potential difference requires (or releases) this amount of energy.$t$;

UPDATE questions SET
  option_a = $t$100 000 V/m$t$,
  option_b = $t$1600 V/m$t$,
  option_c = $t$0.01 V/m$t$,
  option_d = $t$400 V/m$t$,
  explanation = $t$E = V/d = 400/(4×10⁻³) = 100 000 V/m. Convert 4 mm to metres: 4×10⁻³ m. Electric field strength between parallel plates = voltage ÷ separation. The field is uniform between the plates (parallel, equally spaced field lines).$t$
WHERE id = 4691
  AND option_a = $t$\(100\,000 \frac{\,\text{V}}{m}\)$t$
  AND option_b = $t$\(1600 \frac{\,\text{V}}{m}\)$t$
  AND option_c = $t$\(0.01 \frac{\,\text{V}}{m}\)$t$
  AND option_d = $t$\(400 \frac{\,\text{V}}{m}\)$t$
  AND explanation = $t$\(E = \frac{V}{d} = \frac{400}{4 \times 10^{-3}} = 100\,000 \frac{\,\text{V}}{m}\). Convert 4 mm to metres: \(4 \times 10^{-3}\,\text{m}\). Electric field strength between parallel plates = voltage ÷ separation. The field is uniform between the plates (parallel, equally spaced field lines).$t$;

UPDATE questions SET
  question_text = $t$A charge of +3 μC and −3 μC are separated by 0.3 m. Compared to the same charges at 0.6 m, the electrostatic force between them is:$t$,
  option_d = $t$4 times larger — Coulomb's law: F ∝ 1/r²$t$,
  explanation = $t$Coulomb's Law: F ∝ 1/r². When distance halves (0.6→0.3 m), force increases by (0.6/0.3)² = 4 times. So at 0.3 m the force is 4 times larger than at 0.6 m. Halving the distance quadruples the force — the inverse square relationship is fundamental to electrostatic (and gravitational) forces.$t$
WHERE id = 4692
  AND question_text = $t$\(\text{A charge of} + 3\) μC and \(- 3\) μC are separated by 0.3 m. Compared to the same charges at 0.6 m, the electrostatic force between them is:$t$
  AND option_d = $t$4 times larger — Coulomb's law: \(F \propto \frac{1}{r^{2}}\)$t$
  AND explanation = $t$Coulomb's Law: \(F \propto \frac{1}{r^{2}}\). When distance halves \((0.6 \to 0.3\,\text{m})\), force increases by \((\frac{0.6}{0.3})^{2} = 4\) times. So at 0.3 m the force is 4 times larger than at 0.6 m. Halving the distance quadruples the force — the inverse square relationship is fundamental to electrostatic (and gravitational) forces.$t$;

UPDATE questions SET
  question_text = $t$An inkjet printer deflects charged ink droplets using electric fields. A droplet carries charge 2 × 10⁻¹³ C in a field of 5 × 10⁵ V/m. Calculate the force on the droplet.$t$,
  option_a = $t$2.5 × 10⁻¹⁸ N$t$,
  option_b = $t$1 × 10⁻⁷ N$t$,
  option_c = $t$2.5 × 10⁻⁸ N$t$,
  option_d = $t$1 × 10⁻⁷ N$t$,
  explanation = $t$F = qE = 2×10⁻¹³ × 5×10⁵ = 1×10⁻⁷ N. The force on a charged particle in an electric field = charge × field strength. This is directly analogous to F = ma but for electric forces. In an inkjet printer this force deflects the droplet to the correct position on the paper.$t$
WHERE id = 4693
  AND question_text = $t$An inkjet printer deflects charged ink droplets using electric fields. A droplet carries charge \(2 \times 10^{-13}\,\text{C}\) in a field of \(5 \times 10^{5} \frac{\,\text{V}}{m}\). Calculate the force on the droplet.$t$
  AND option_a = $t$\(2.5 \times 10^{-18}\,\text{N}\)$t$
  AND option_b = $t$\(1 \times 10^{-7}\,\text{N}\)$t$
  AND option_c = $t$\(2.5 \times 10^{-8}\,\text{N}\)$t$
  AND option_d = $t$\(1 \times 10^{-7}\,\text{N}\)$t$
  AND explanation = $t$F = qE \(= 2 \times 10^{-13} \times 5 \times 10^{5} = 1 \times 10^{-7}\,\text{N}\). The force on a charged particle in an electric field = charge × field strength. This is directly analogous to \(F = ma\) but for electric forces. In an inkjet printer this force deflects the droplet to the correct position on the paper.$t$;

UPDATE questions SET
  explanation = $t$A sharp point concentrates electric field lines — the field strength at the tip is extremely high (E ∝ 1/r², curvature effect). This intense field ionises the surrounding air, allowing charge to leak away continuously as a corona discharge. The lightning rod provides a preferred low-resistance path to earth, preventing a destructive spark elsewhere.$t$
WHERE id = 4694
  AND explanation = $t$A sharp point concentrates electric field lines — the field strength at the tip is extremely high (\(E \propto \frac{1}{r^{2}}\), curvature effect). This intense field ionises the surrounding air, allowing charge to leak away continuously as a corona discharge. The lightning rod provides a preferred low-resistance path to earth, preventing a destructive spark elsewhere.$t$;

UPDATE questions SET
  question_text = $t$An isolated conducting sphere of radius 0.1 m carries charge 4 μC. At the surface, what is the approximate electric field strength? (k = 9 × 10⁹ N m²/C²)$t$,
  option_a = $t$360 000 V/m$t$,
  option_b = $t$40 000 V/m$t$,
  option_c = $t$4 000 000 V/m$t$,
  option_d = $t$3.6 × 10⁶ V/m$t$,
  explanation = $t$E = kQ/r² = (9×10⁹×4×10⁻⁶)/(0.1²) = 36 000/0.01 = 3.6×10⁶ V/m. Using Coulomb's law for the field of a point (spherical) charge. The surface of the sphere is at 0.1 m from the centre. Check: 9×10⁹×4×10⁻⁶ = 36 000; 36 000/0.01 = 3 600 000 = 3.6×10⁶ V/m ✓.$t$
WHERE id = 4695
  AND question_text = $t$An isolated conducting sphere of radius 0.1 \(m\) carries charge 4 μC. At the surface, what is the approximate electric field strength? \((k = 9 \times 10^{9}\,\text{N}\ \frac{m^{2}}{C^{2}})\)$t$
  AND option_a = $t$\(360\,000 \frac{\,\text{V}}{m}\)$t$
  AND option_b = $t$\(40\,000 \frac{\,\text{V}}{m}\)$t$
  AND option_c = $t$\(4\,000\,000 \frac{\,\text{V}}{m}\)$t$
  AND option_d = $t$\(3.6 \times 10^{6} \frac{\,\text{V}}{m}\)$t$
  AND explanation = $t$E = kQ/\(r^{2} = \frac{9 \times 10^{9} \times 4 \times 10^{-6}}{0.1^{2}} = \frac{36\,000}{0.01} = 3.6 \times 10^{6} \frac{\,\text{V}}{m}\). Using Coulomb's law for the field of a point (spherical) charge. The surface of the sphere is at 0.1 m from the centre. Check: \(9 \times 10^{9} \times 4 \times 10^{-6} = 36\,000\); \(\frac{36\,000}{0.01} = 3\,600\,000 = 3.6 \times 10^{6} \frac{\,\text{V}}{m} \checkmark\).$t$;

UPDATE questions SET
  question_text = $t$A student rubs a polythene rod with a woollen cloth. The rod gains 5 × 10¹⁰ electrons. What is the charge on the rod?$t$,
  option_a = $t$−8 × 10⁻⁹ C$t$,
  option_b = $t$+8 × 10⁻⁹ C$t$,
  option_c = $t$+5 × 10¹⁰ C$t$,
  option_d = $t$−5 × 10¹⁰ C$t$,
  explanation = $t$Charge = number of electrons × electron charge = 5×10¹⁰ × 1.6×10⁻¹⁹ = 8×10⁻⁹ C. Since the rod GAINS electrons it becomes negatively charged: −8×10⁻⁹ C = −8 nC. The sign matters — the rod gained electrons so it is negative.$t$
WHERE id = 4696
  AND question_text = $t$A student rubs a polythene rod with a woollen cloth. The rod gains \(5 \times 10^{10}\) electrons. What is the charge on the rod?$t$
  AND option_a = $t$\(- 8 \times 10^{-9}\,\text{C}\)$t$
  AND option_b = $t$\(+ 8 \times 10^{-9}\,\text{C}\)$t$
  AND option_c = $t$\(+ 5 \times 10^{10}\,\text{C}\)$t$
  AND option_d = $t$\(- 5 \times 10^{10}\,\text{C}\)$t$
  AND explanation = $t$Charge = number of electrons × electron charge \(= 5 \times 10^{10} \times 1.6 \times 10^{-19} = 8 \times 10^{-9} C\). Since the rod GAINS electrons it becomes negatively charged: \(- 8 \times 10^{-9} C = - 8\) nC. The sign matters — the rod gained electrons so it is negative.$t$;

UPDATE questions SET
  question_text = $t$A capacitor stores charge Q = CV. If C = 100 μF and V = 200 V, calculate the charge stored and the energy stored (E = ½CV²).$t$,
  option_a = $t$Q = 200 C, E = 200 J$t$,
  option_b = $t$Q = 0.02 C, E = 2 J$t$,
  option_c = $t$Q = 2 C, E = 20 J$t$,
  option_d = $t$Q = 0.002 C, E = 0.2 J$t$,
  explanation = $t$Q = CV = 100×10⁻⁶ × 200 = 0.02 C. E = ½CV² = ½×100×10⁻⁶×200² = ½×100×10⁻⁶×40000 = 2 J. Check: Q = 100 μF × 200 V = 0.02 C ✓; E = ½×0.02×200 = 2 J ✓. Or E = ½QV = ½×0.02×200 = 2 J.$t$
WHERE id = 4697
  AND question_text = $t$A capacitor stores charge \(Q = CV\). If \(C = 100\) μF and \(V = 200 V\), calculate the charge stored and the energy stored \((E = \tfrac{1}{2}CV^{2})\).$t$
  AND option_a = $t$\(Q = 200\,\text{C}\), \(E = 200\,\text{J}\)$t$
  AND option_b = $t$\(Q = 0.02\,\text{C}\), \(E = 2\,\text{J}\)$t$
  AND option_c = $t$\(Q = 2\,\text{C}\), \(E = 20\,\text{J}\)$t$
  AND option_d = $t$\(Q = 0.002\,\text{C}\), \(E = 0.2\,\text{J}\)$t$
  AND explanation = $t$\(Q = CV = 100 \times 10^{-6} \times 200 = 0.02\,\text{C}\). \(E = \tfrac{1}{2}CV^{2} = \tfrac{1}{2} \times 100 \times 10^{-6} \times 200^{2} = \tfrac{1}{2} \times 100 \times 10^{-6} \times 40000 = 2\,\text{J}\). Check: \(Q = 100\) μ\(F \times 200 V = 0.02\,\text{C} \checkmark\); \(E = \tfrac{1}{2} \times 0.02 \times 200 = 2\,\text{J} \checkmark\). Or \(E = \tfrac{1}{2}QV = \tfrac{1}{2} \times 0.02 \times 200 = 2\,\text{J}\).$t$;

UPDATE questions SET
  question_text = $t$A person walking on a nylon carpet in dry air builds up a charge of −4 × 10⁻⁶ C. Their capacitance to earth is 200 pF. What voltage are they at?$t$,
  option_b = $t$−20 000 V$t$,
  option_d = $t$4 × 10⁻⁶ V$t$,
  explanation = $t$V = Q/C = −4×10⁻⁶ / (200×10⁻¹²) = −4×10⁻⁶ / 2×10⁻¹⁰ = −20 000 V. The magnitude is 20 000 V (20 kV). This is why touching a metal doorknob after walking on carpet gives a painful spark — a 20 kV discharge across a few millimetres of air.$t$
WHERE id = 4699
  AND question_text = $t$A person walking on a nylon carpet in dry air builds up a charge of \(- 4 \times 10^{-6}\,\text{C}\). Their capacitance to earth is 200 pF. What voltage are they at?$t$
  AND option_b = $t$\(- 20\,000\,\text{V}\)$t$
  AND option_d = $t$\(4 \times 10^{-6}\,\text{V}\)$t$
  AND explanation = $t$\(V = \frac{Q}{C} = - 4 \times \frac{10^{-6}}{200 \times 10^{-12}} = - 4 \times \frac{10^{-6}}{2} \times 10^{-10} = - 20\,000 V\). The magnitude is 20 000 V (20 kV). This is why touching a metal doorknob after walking on carpet gives a painful spark — a 20 kV discharge across a few millimetres of air.$t$;

UPDATE questions SET
  question_text = $t$A spring (k = 500 N/m) is extended 0.08 m. It launches a 0.2 kg ball horizontally from a table 1.25 m high. How far horizontally does the ball travel? (g = 10 N/kg)$t$,
  explanation = $t$Elastic potential energy = ½ × 500 × 0.08² = 1.6 J = kinetic energy, so v = √(2 × 1.6 ÷ 0.2) = 4 m/s. Time to fall 1.25 m: t = √(2 × 1.25 ÷ 10) = 0.5 s. Horizontal distance = 4 × 0.5 = 2.0 m.$t$
WHERE id = 4700
  AND question_text = $t$A spring (\(k = 500\,\text{N/m}\)) is extended 0.08 m. It launches \(a\) \(0.2\,\text{kg}\) ball horizontally from a table 1.25 m high. How far horizontally does the ball travel? (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Elastic potential energy \(= \tfrac{1}{2} \times 500 \times 0.08^{2} = 1.6 J\)= kinetic energy, so \(v = \sqrt{2 \times 1.6 \div 0.2} = 4\,\text{m/s}\). Time to fall 1.25 m: \(t = \sqrt{2 \times 1.25 \div 10} = 0.5\,\text{s}\). Horizontal distance \(= 4 \times 0.5 = 2.0\,\text{m}\).$t$;

UPDATE questions SET
  question_text = $t$Two springs in parallel (each k = 300 N/m) support a 12 kg load. Calculate the extension. (g = 10 N/kg)$t$,
  explanation = $t$Two springs in parallel each carry half the load. Weight = mg = 12×10 = 120 N. Each spring carries 60 N. But the effective k in parallel = 2×300 = 600 N/m. Extension = F/k_eff = 120/600 = 0.2 m. Alternatively: extension = (half load)/(individual k) = 60/300 = 0.2 m. Parallel springs give half the extension of a single spring under the same total load.$t$
WHERE id = 4701
  AND question_text = $t$Two springs in parallel (each \(k = 300\,\text{N/m}\)) support \(a\) \(12\,\text{kg}\) load. Calculate the extension. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$Two springs in parallel each carry half the load. Weight \(= mg = 12 \times 10 = 120\,\text{N}\). Each spring carries 60 N. But the effective \(k\) in parallel \(= 2 \times 300 = 600\,\text{N/m}\). Extension \(= \frac{F}{k}\)_\(eff = \frac{120}{600} = 0.2\,\text{m}\). Alternatively: extension \(=\) (half load)/(individual \(k\)) \(= \frac{60}{300} = 0.2\,\text{m}\). Parallel springs give half the extension of a single spring under the same total load.$t$;

UPDATE questions SET
  question_text = $t$A diver of mass 60 kg stands on the end of a 3 m diving board. The board deflects 15 cm. Assuming Hooke's Law, calculate the effective spring constant of the board.$t$,
  option_a = $t$4000 N/m$t$,
  option_b = $t$400 N/m$t$,
  option_c = $t$3600 N/m$t$,
  option_d = $t$6000 N/m$t$,
  explanation = $t$Force = weight = 60 × 10 = 600 N. Deflection = 15 cm = 0.15 m. k = F ÷ e = 600 ÷ 0.15 = 4000 N/m.$t$
WHERE id = 4702
  AND question_text = $t$A diver of mass \(60\,\text{kg}\) stands on the end of a 3 m diving board. The board deflects 15 cm. Assuming Hooke's Law, calculate the effective spring constant of the board.$t$
  AND option_a = $t$\(4000\,\text{N/m}\)$t$
  AND option_b = $t$\(400\,\text{N/m}\)$t$
  AND option_c = $t$\(3600\,\text{N/m}\)$t$
  AND option_d = $t$\(6000\,\text{N/m}\)$t$
  AND explanation = $t$Force = weight \(= 60 \times 10 = 600\,\text{N}\). Deflection \(= 15\,\text{cm} = 0.15\,\text{m}\). \(k = F \div e = 600 \div 0.15 = 4000\,\text{N/m}\).$t$;

UPDATE questions SET
  question_text = $t$A hydraulic brake: master cylinder area 2 cm², force 40 N; slave cylinder area 20 cm². Calculate the braking force.$t$,
  explanation = $t$Pressure = F_in/A_in = 40/(2×10⁻⁴) = 200 000 Pa. Force_out = P × A_out = 200 000 × (20×10⁻⁴) = 400 N. Area ratio = 20/2 = 10. Output force = input force × (A_out/A_in) = 40 × 10 = 400 N. Hydraulic systems multiply force by the ratio of piston areas.$t$
WHERE id = 4703
  AND question_text = $t$A hydraulic brake: master cylinder area \(2\,\text{cm}^{2}\), force 40 N; slave cylinder area \(20\,\text{cm}^{2}\). Calculate the braking force.$t$
  AND explanation = $t$Pressure \(= F\)_in/A_in \(= \frac{40}{2 \times 10^{-4}} = 200\,000\,\text{Pa}\). Force_\(out = P \times A\)_\(out = 200\,000 \times (20 \times 10^{-4}) = 400\,\text{N}\). Area ratio \(= \frac{20}{2} = 10\). Output force = input force × (A_out/A_in) \(= 40 \times 10 = 400\,\text{N}\). Hydraulic systems multiply force by the ratio of piston areas.$t$;

UPDATE questions SET
  question_text = $t$The pressure at the bottom of a dam is 5 × 10⁵ Pa. The water density is 1000 kg/m³. Calculate the depth of water. (g = 10 N/kg)$t$,
  explanation = $t$P = ρgh → h = P/(ρg) = 5×10⁵/(1000×10) = 5×10⁵/10⁴ = 50 m. Rearrange pressure formula: h = P/(ρg). A pressure of 5×10⁵ Pa (5 bar) corresponds to 50 m of water depth — a standard SCUBA diving depth for recreational diving.$t$
WHERE id = 4704
  AND question_text = $t$The pressure at the bottom of a dam is \(5 \times 10^{5}\,\text{Pa}\). The water density is \(1000\,\text{kg/m}^{3}\). Calculate the depth of water. (\(g = 10\,\text{N/kg}\))$t$
  AND explanation = $t$P = ρgh → \(h = P /\)(ρ\(g\)) \(= 5 \times \frac{10^{5}}{1000 \times 10} = 5 \times \frac{10^{5}}{10^{4}} = 50\,\text{m}\). Rearrange pressure formula: \(h = P /\)(ρ\(g\)). A pressure of \(5 \times 10^{5}\,\text{Pa}\) (5 bar) corresponds to 50 m of water depth — a standard SCUBA diving depth for recreational diving.$t$;

UPDATE questions SET
  explanation = $t$Beyond 3 cm, the graph curves steeply upward — for a given increase in extension, more force is needed than before. This means the spring constant (gradient = F/x) increases — the rubber becomes stiffer. This is strain stiffening, common in rubber and biological materials like tendons.$t$
WHERE id = 4705
  AND explanation = $t$Beyond 3 cm, the graph curves steeply upward — for a given increase in extension, more force is needed than before. This means the spring constant (gradient \(= \frac{F}{x}\)) increases — the rubber becomes stiffer. This is strain stiffening, common in rubber and biological materials like tendons.$t$;

UPDATE questions SET
  question_text = $t$Upthrust = weight of fluid displaced. A 0.5 kg object (volume 200 cm³) is fully submerged in water (density 1000 kg/m³). Calculate the upthrust and state whether it sinks or floats. (g = 10 N/kg)$t$,
  option_a = $t$Upthrust = 2 N; object sinks (weight 5 N > upthrust)$t$,
  option_b = $t$Upthrust = 5 N; object floats$t$,
  option_c = $t$Upthrust = 2 N; object floats$t$,
  option_d = $t$Upthrust = 5 N; object sinks$t$,
  explanation = $t$Upthrust = ρ_fluid × V × g = 1000 × 200×10⁻⁶ × 10 = 2 N. Weight = 0.5×10 = 5 N. Since weight (5 N) > upthrust (2 N), the object sinks. The net downward force = 5−2 = 3 N. An object sinks when its density exceeds the fluid density — here ρ_object = 0.5/200×10⁻⁶ = 2500 kg/m³ > 1000 kg/m³.$t$
WHERE id = 4706
  AND question_text = $t$Upthrust = weight of fluid displaced. A \(0.5\,\text{kg}\) object (volume \(200\,\text{cm}^{3}\)) is fully submerged in water (density \(1000\,\text{kg/m}^{3}\)). Calculate the upthrust and state whether it sinks or floats. (\(g = 10\,\text{N/kg}\))$t$
  AND option_a = $t$Upthrust \(= 2 N\); object sinks (weight 5 N > upthrust)$t$
  AND option_b = $t$Upthrust \(= 5\,\text{N}\); object floats$t$
  AND option_c = $t$Upthrust \(= 2\,\text{N}\); object floats$t$
  AND option_d = $t$Upthrust \(= 5\,\text{N}\); object sinks$t$
  AND explanation = $t$Upthrust = ρ_fluid ×\(V \times g = 1000 \times 200 \times 10^{-6} \times 10 = 2\,\text{N}\). Weight \(= 0.5 \times 10 = 5\,\text{N}\). Since weight (5 N) > upthrust (2 N), the object sinks. The net downward force \(= 5 - 2 = 3\,\text{N}\). An object sinks when its density exceeds the fluid density — here ρ_object \(= \frac{0.5}{200} \times 10^{-6} = 2500\,\text{kg/m}^{3}\) > \(1000\,\text{kg/m}^{3}\).$t$;

UPDATE questions SET
  question_text = $t$A steel cable (cross-section 4 cm²) supports a 8000 N load. Calculate the stress in the cable.$t$,
  option_b = $t$2 × 10⁷ Pa$t$,
  option_c = $t$2 × 10⁶ Pa$t$,
  explanation = $t$Stress = Force/Area = 8000/(4×10⁻⁴) = 2×10⁷ Pa. Convert 4 cm² to m²: 4×10⁻⁴ m². Stress = F/A in Pa (N/m²). This is the tensile stress in the cable — at very high values the material yields or fractures.$t$
WHERE id = 4707
  AND question_text = $t$A steel cable (cross-section \(4\,\text{cm}^{2}\)) supports a 8000 N load. Calculate the stress in the cable.$t$
  AND option_b = $t$\(2 \times 10^{7}\,\text{Pa}\)$t$
  AND option_c = $t$\(2 \times 10^{6}\,\text{Pa}\)$t$
  AND explanation = $t$Stress = Force/Area \(= \frac{8000}{4 \times 10^{-4}} = 2 \times 10^{7}\,\text{Pa}\). Convert \(4\,\text{cm}^{2}\) to \(m^{2}\): \(4 \times 10^{-4} m^{2}\). Stress \(= \frac{F}{A}\) in Pa \((\text{N/m}^{2})\). This is the tensile stress in the cable — at very high values the material yields or fractures.$t$;

UPDATE questions SET
  question_text = $t$A spring stores 0.9 J when extended 6 cm. Calculate k.$t$,
  option_a = $t$500 N/m$t$,
  option_b = $t$15 N/m$t$,
  option_c = $t$30 N/m$t$,
  option_d = $t$300 N/m$t$,
  explanation = $t$EPE = ½kx² = 0.9 J; x = 6 cm = 0.06 m. k = 2×EPE/x² = 2×0.9/(0.06²) = 1.8/0.0036 = 500 N/m. Rearrange EPE = ½kx² → k = 2×EPE/x². Always convert extension to metres before calculating.$t$
WHERE id = 4708
  AND question_text = $t$A spring stores 0.9 J when extended 6 cm. Calculate \(k\).$t$
  AND option_a = $t$\(500\,\text{N/m}\)$t$
  AND option_b = $t$\(15\,\text{N/m}\)$t$
  AND option_c = $t$\(30\,\text{N/m}\)$t$
  AND option_d = $t$\(300\,\text{N/m}\)$t$
  AND explanation = $t$\(EPE = \tfrac{1}{2}kx^{2} = 0.9\,\text{J}\); \(x = 6\,\text{cm} = 0.06\,\text{m}\). \(k = 2 \times \frac{EPE}{x^{2}} = 2 \times \frac{0.9}{0.06^{2}} = \frac{1.8}{0.0036} = 500\,\text{N/m}\). Rearrange \(EPE = \tfrac{1}{2}kx^{2} \to k = 2 \times \frac{EPE}{x^{2}}\). Always convert extension to metres before calculating.$t$;

UPDATE questions SET
  question_text = $t$A submarine descends from 0 to 300 m. The water density is 1025 kg/m³ and g = 10 N/kg. What is the increase in pressure on the hull?$t$,
  option_a = $t$3.075 × 10⁶ Pa$t$,
  option_b = $t$3.075 × 10⁵ Pa$t$,
  option_c = $t$1.025 × 10³ Pa$t$,
  option_d = $t$3.075 × 10⁷ Pa$t$,
  explanation = $t$ΔP = ρgΔh = 1025×10×300 = 3.075×10⁶ Pa. The pressure increase from 0 to 300 m depth. P = ρgh gives the gauge pressure (above atmospheric). At 300 m, the water pressure increase alone is ~30 bar — submarine hulls must be extremely strong to withstand this.$t$
WHERE id = 4709
  AND question_text = $t$A submarine descends from 0 to 300 m. The water density is \(1025\,\text{kg/m}^{3}\) and \(g = 10\,\text{N/kg}\). What is the increase in pressure on the hull?$t$
  AND option_a = $t$\(3.075 \times 10^{6}\,\text{Pa}\)$t$
  AND option_b = $t$\(3.075 \times 10^{5}\,\text{Pa}\)$t$
  AND option_c = $t$\(1.025 \times 10^{3}\,\text{Pa}\)$t$
  AND option_d = $t$\(3.075 \times 10^{7}\,\text{Pa}\)$t$
  AND explanation = $t$ΔP = ρ\(g\)Δ\(h = 1025 \times 10 \times 300 = 3.075 \times 10^{6}\,\text{Pa}\). The pressure increase from 0 to 300 m depth. P = ρgh gives the gauge pressure (above atmospheric). At 300 m, the water pressure increase alone is ~30 bar — submarine hulls must be extremely strong to withstand this.$t$;

COMMIT;

-- Check: expect 0.
SELECT count(*) AS typeset_rows FROM questions
 WHERE id IN (11,12,14,16,17,18,19,81,83,84,85,88,89,90,91,92,93,94,95,97,99,100,101,103,104,105,108,109,110,112,116,118,121,123,125,129,132,134,135,137,148,411,412,414,415,416,417,419,421,425,429,431,432,435,436,438,440,441,447,448,449,451,452,455,456,465,466,468,471,472,473,475,476,477,478,479,484,486,491,492,493,494,495,496,497,498,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,520,521,522,523,524,525,526,527,529,530,832,833,835,836,837,839,840,841,842,844,845,846,849,850,853,854,855,860,861,864,866,868,871,872,875,878,880,881,882,883,887,889,890,891,892,893,895,899,903,904,910,911,912,914,915,916,917,919,920,922,923,924,925,927,928,929,930,940,944,945,948,955,957,959,962,963,964,965,966,968,969,970,2174,2176,2177,2179,2180,2182,2183,2184,2185,2186,2188,2189,2190,2191,2192,2193,2194,2195,2196,2198,2200,2201,2202,2204,2205,2206,2207,2208,2209,2213,2214,2215,2216,2217,2218,2219,2220,2221,2224,2225,2226,2227,2228,2229,2230,2231,2232,2235,2236,2237,2239,2243,2244,2246,2247,2248,2250,2252,2254,2255,2256,2258,2261,2263,2266,2267,2269,2270,2272,2273,2278,2279,2280,2281,2282,2306,2307,2312,2314,2315,2316,2317,2318,2322,2323,2324,2326,2327,2328,2329,2331,2332,2333,2334,2337,2338,2339,2340,2342,2343,2347,2348,2349,2350,2354,2355,2356,2357,2358,2359,2361,2362,2363,2364,2365,2368,2369,2370,2372,2400,2401,2403,2408,2411,2412,2413,2414,2415,2416,2417,2418,2419,2420,2421,2422,2425,2426,2427,2428,2429,2431,2433,2434,2435,2436,2437,2438,2439,2440,2441,2443,2444,2445,2446,2447,2448,2450,2451,2452,2455,2456,2457,2458,2460,2461,2462,2464,2465,2466,2467,2468,2469,2471,2472,2481,2485,2486,2488,2491,2492,2493,2496,2497,2498,2499,2500,2502,2503,2504,2506,2507,2509,2511,2513,2514,2516,2517,2519,2520,2521,2522,2523,2525,2526,2527,2528,2529,2530,2531,2532,2533,2534,2537,2541,2542,2543,2544,2545,2546,2547,2549,2550,2552,2553,2554,2555,2556,2557,2558,2560,2561,2564,2566,2567,2568,2570,2571,2572,2573,2574,2576,2577,2579,2580,2581,2582,2583,2585,2586,2587,2588,2589,2590,2592,2593,2594,2595,2596,2599,2600,2601,2602,2604,2605,2606,2607,2608,2609,2610,2612,2614,2615,2617,2619,2620,2621,2622,2623,2624,3316,3317,3320,3324,3330,3332,3333,3334,3335,3336,3337,3338,3339,3340,3341,3342,3343,3344,3345,3346,3347,3355,3357,3358,3359,3360,3361,3364,3366,3368,3370,3371,3373,3377,3379,3380,3381,3382,3383,3387,3388,3389,3390,3391,3392,3394,3395,3396,3397,3398,3400,3401,3402,3403,3404,3405,3417,3418,3419,3420,3421,3422,3423,3425,3426,3427,3428,3430,3431,3433,3434,3435,3438,3440,3441,3443,3444,3447,3448,3449,3450,3451,3454,3457,3458,3459,3461,3462,3464,3465,3577,3580,3581,3582,3583,3584,3585,3590,3605,3608,3609,3610,3612,3614,3617,3620,3623,3626,3629,3632,3640,3641,3645,3649,3650,3652,3654,3769,3770,3771,3773,3774,3775,3776,3777,3778,3779,3780,3781,3782,3784,3787,3789,3790,3793,3794,3796,3799,3800,3801,3802,3803,3804,3805,3806,3807,3808,3809,3810,3811,3813,3814,3815,3816,3818,3819,3820,3821,3822,3824,3825,3826,3827,3828,3829,3830,3831,3833,3835,3836,3839,3840,3841,3842,3843,3844,3845,3846,3847,3848,4130,4132,4134,4136,4137,4138,4140,4142,4144,4147,4160,4161,4162,4163,4164,4165,4167,4168,4169,4170,4171,4173,4174,4175,4178,4179,4186,4187,4191,4192,4195,4199,4201,4202,4203,4204,4205,4206,4209,4490,4491,4492,4493,4494,4495,4496,4497,4498,4499,4504,4509,4510,4512,4513,4515,4516,4517,4518,4530,4531,4532,4533,4534,4536,4537,4538,4540,4542,4543,4544,4549,4550,4554,4557,4560,4561,4562,4563,4564,4565,4566,4568,4569,4580,4581,4582,4583,4584,4585,4587,4588,4592,4593,4595,4597,4598,4600,4602,4604,4605,4606,4610,4613,4617,4621,4622,4623,4625,4626,4627,4628,4629,4640,4641,4643,4644,4645,4647,4648,4649,4650,4651,4652,4653,4654,4655,4656,4657,4658,4659,4660,4662,4663,4664,4665,4666,4667,4668,4670,4671,4672,4673,4674,4675,4676,4677,4678,4679,4680,4681,4682,4683,4684,4685,4686,4687,4688,4689,4690,4691,4692,4693,4694,4695,4696,4697,4699,4700,4701,4702,4703,4704,4705,4706,4707,4708,4709)
   AND strpos(concat_ws(' ', question_text, option_a, option_b, option_c, option_d, explanation), chr(92) || '(') > 0;
