-- Rollback for quiz_typeset_biology.sql: restores the plain-text maths exactly as it
-- was on 2026-09-27. Each UPDATE applies only to a row still holding the typeset text.

BEGIN;

UPDATE questions SET
  question_text = $t$A cell image is 30 mm wide at magnification ×500. What is the actual cell size?$t$,
  explanation = $t$Actual size = Image size ÷ Magnification = 30 ÷ 500 = 0.06 mm.$t$
WHERE id = 23
  AND question_text = $t$A cell image is 30 mm wide at magnification \(\times 500\). What is the actual cell size?$t$
  AND explanation = $t$Actual size = Image size ÷ Magnification \(= 30 \div 500 = 0.06\,\text{mm}\).$t$;

UPDATE questions SET
  option_a = $t$×3000$t$,
  option_b = $t$×30$t$,
  option_c = $t$×300$t$,
  option_d = $t$×30000$t$,
  explanation = $t$Magnification = Image ÷ Actual = 45 ÷ 0.015 = 3000. Magnification is ×3000.$t$
WHERE id = 30
  AND option_a = $t$\(\times 3000\)$t$
  AND option_b = $t$\(\times 30\)$t$
  AND option_c = $t$\(\times 300\)$t$
  AND option_d = $t$\(\times 30000\)$t$
  AND explanation = $t$Magnification = Image ÷ Actual \(= 45 \div 0.015 = 3000\). Magnification is \(\times 3000\).$t$;

UPDATE questions SET
  explanation = $t$Punnett square: BB, Bb, Bb, bb. One in four = 25% chance of BB (homozygous dominant).$t$
WHERE id = 51
  AND explanation = $t$Punnett square: BB, Bb, Bb, bb. One in four \(= 25\%\) chance of BB (homozygous dominant).$t$;

UPDATE questions SET
  question_text = $t$Cystic fibrosis is caused by a recessive allele (f). Two carriers (Ff) have children. What fraction are expected to have cystic fibrosis?$t$,
  explanation = $t$Ff × Ff gives FF, Ff, Ff, ff. Only ff individuals have cystic fibrosis = 1 in 4 (25%).$t$
WHERE id = 52
  AND question_text = $t$Cystic fibrosis is caused by a recessive allele (\(f\)). Two carriers (Ff) have children. What fraction are expected to have cystic fibrosis?$t$
  AND explanation = $t$Ff × Ff gives FF, Ff, Ff, ff. Only ff individuals have cystic fibrosis \(= 1\) in 4 (25%).$t$;

UPDATE questions SET
  explanation = $t$Dd × dd gives Dd, Dd, dd, dd. Two out of four = 50% chance of having polydactyly.$t$
WHERE id = 60
  AND explanation = $t$\(\text{Dd} \times dd\) gives Dd, Dd, dd, dd. Two out of four \(= 50\%\) chance of having polydactyly.$t$;

UPDATE questions SET
  explanation = $t$Magnification = image / actual = 5 / 0.05 = 100. So the magnification is ×100.$t$
WHERE id = 252
  AND explanation = $t$Magnification = image / actual \(= \frac{5}{0.05} = 100\). So the magnification is \(\times 100\).$t$;

UPDATE questions SET
  question_text = $t$A student views a cell under a microscope. The eyepiece is ×10 and the objective lens is ×40. What is the total magnification?$t$,
  option_a = $t$×40$t$,
  option_b = $t$×50$t$,
  option_c = $t$×4000$t$,
  option_d = $t$×400$t$,
  explanation = $t$Total magnification = eyepiece × objective = 10 × 40 = ×400.$t$
WHERE id = 256
  AND question_text = $t$A student views a cell under a microscope. The eyepiece is \(\times 10\) and the objective lens is \(\times 40\). What is the total magnification?$t$
  AND option_a = $t$\(\times 40\)$t$
  AND option_b = $t$\(\times 50\)$t$
  AND option_c = $t$\(\times 4000\)$t$
  AND option_d = $t$\(\times 400\)$t$
  AND explanation = $t$Total magnification = eyepiece × objective \(= 10 \times 40 = \times 400\).$t$;

UPDATE questions SET
  option_a = $t$Micrometres (µm)$t$,
  option_b = $t$Metres (m)$t$,
  explanation = $t$Most cells are 10–100 µm in diameter. 1 µm = 0.000001 m = 10⁻⁶ m. Always convert units before calculating magnification.$t$
WHERE id = 257
  AND option_a = $t$Micrometres (µ\(m\))$t$
  AND option_b = $t$Metres (\(m\))$t$
  AND explanation = $t$Most cells are 10–\(100\,\mu\text{m}\) in diameter. \(1\,\mu\text{m} = 0.000001 m = 10^{-6} m\). Always convert units before calculating magnification.$t$;

UPDATE questions SET
  question_text = $t$An electron microscope image shows a cell organelle at 50 mm wide. The actual size is 0.5 µm. What is the magnification?$t$,
  option_a = $t$×1000$t$,
  option_b = $t$×100$t$,
  option_c = $t$×10 000$t$,
  option_d = $t$×100 000$t$,
  explanation = $t$Convert: 50 mm = 50 000 µm. Magnification = 50 000 / 0.5 = 100 000. So ×100 000.$t$
WHERE id = 258
  AND question_text = $t$An electron microscope image shows a cell organelle at 50 mm wide. The actual size is \(0.5\,\mu\text{m}\). What is the magnification?$t$
  AND option_a = $t$\(\times 1000\)$t$
  AND option_b = $t$\(\times 100\)$t$
  AND option_c = $t$\(\times 10\,000\)$t$
  AND option_d = $t$\(\times 100\,000\)$t$
  AND explanation = $t$Convert: 50 mm = \(50\,000\,\mu\text{m}\). Magnification \(= \frac{50\,000}{0.5} = 100\,000\). So \(\times 100\,000\).$t$;

UPDATE questions SET
  option_a = $t$It produces 3D images$t$,
  explanation = $t$TEM fires electrons through a thin slice of specimen — showing internal ultrastructure in great detail. SEM scans the surface to produce a 3D image but does not show internal detail.$t$
WHERE id = 259
  AND option_a = $t$It produces \(3D\) images$t$
  AND explanation = $t$TEM fires electrons through a thin slice of specimen — showing internal ultrastructure in great detail. SEM scans the surface to produce \(a 3D\) image but does not show internal detail.$t$;

UPDATE questions SET
  question_text = $t$A scale bar on a microscope image is 10 µm and measures 20 mm on the image. What is the magnification?$t$,
  option_a = $t$×0.5$t$,
  option_b = $t$×2000$t$,
  option_c = $t$×0.002$t$,
  option_d = $t$×200$t$,
  explanation = $t$Convert scale bar: 10 µm = 0.01 mm. Magnification = image length / actual length = 20 / 0.01 = 2000. So ×2000.$t$
WHERE id = 260
  AND question_text = $t$A scale bar on a microscope image is \(10\,\mu\text{m}\) and measures 20 mm on the image. What is the magnification?$t$
  AND option_a = $t$\(\times 0.5\)$t$
  AND option_b = $t$\(\times 2000\)$t$
  AND option_c = $t$\(\times 0.002\)$t$
  AND option_d = $t$\(\times 200\)$t$
  AND explanation = $t$Convert scale bar: \(10\,\mu\text{m} = 0.01\,\text{mm}\). Magnification = image length / actual length \(= \frac{20}{0.01} = 2000\). So \(\times 2000\).$t$;

UPDATE questions SET
  explanation = $t$The stomach produces HCl (pH 1-2), which kills bacteria in food and provides the acidic conditions needed for pepsin (stomach protease) to work effectively.$t$
WHERE id = 285
  AND explanation = $t$The stomach produces HCl (pH \(1 - 2\)), which kills bacteria in food and provides the acidic conditions needed for pepsin (stomach protease) to work effectively.$t$;

UPDATE questions SET
  explanation = $t$Above the optimum temperature, bonds holding the enzyme's 3D shape break. The active site changes shape — the enzyme is denatured and can no longer bind its substrate.$t$
WHERE id = 288
  AND explanation = $t$Above the optimum temperature, bonds holding the enzyme's \(3D\) shape break. The active site changes shape — the enzyme is denatured and can no longer bind its substrate.$t$;

UPDATE questions SET
  explanation = $t$Capillaries are tiny vessels with walls one cell thick. Substances like glucose, oxygen and CO2 diffuse between blood and cells across the thin capillary walls.$t$
WHERE id = 296
  AND explanation = $t$Capillaries are tiny vessels with walls one cell thick. Substances like glucose, oxygen and CO₂ diffuse between blood and cells across the thin capillary walls.$t$;

UPDATE questions SET
  explanation = $t$During intense exercise, lactic acid builds up. After exercise, extra oxygen is used to oxidise lactic acid to CO2 and water — this extra oxygen requirement is the oxygen debt.$t$
WHERE id = 305
  AND explanation = $t$During intense exercise, lactic acid builds up. After exercise, extra oxygen is used to oxidise lactic acid to CO₂ and water — this extra oxygen requirement is the oxygen debt.$t$;

UPDATE questions SET
  option_d = $t$Aerobic respiration producing CO2 and water$t$
WHERE id = 306
  AND option_d = $t$Aerobic respiration producing CO₂ and water$t$;

UPDATE questions SET
  option_a = $t$Aerobic fully oxidises glucose to CO2 and water, releasing all available energy; anaerobic only partially breaks down glucose$t$
WHERE id = 307
  AND option_a = $t$Aerobic fully oxidises glucose to CO₂ and water, releasing all available energy; anaerobic only partially breaks down glucose$t$;

UPDATE questions SET
  option_a = $t$C6H12O6 + O2 → CO2 + H2O$t$,
  option_b = $t$C6H12O6 + 6O2 → 6CO2 + 6H2O$t$,
  option_c = $t$C6H12O6 + 3O2 → 3CO2 + 3H2O$t$,
  option_d = $t$C6H12O6 → 2C3H6O3$t$,
  explanation = $t$Aerobic respiration: C6H12O6 + 6O2 → 6CO2 + 6H2O. One molecule of glucose reacts with 6 oxygen molecules, producing 6 CO2 and 6 water molecules.$t$
WHERE id = 310
  AND option_a = $t$C₆H₁₂O₆ + O₂ → CO₂ + H₂O$t$
  AND option_b = $t$C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O$t$
  AND option_c = $t$C₆H₁₂O₆ + 3O₂ → 3CO₂ + 3H₂O$t$
  AND option_d = $t$C₆H₁₂O₆ → 2C\(3H6O3\)$t$
  AND explanation = $t$Aerobic respiration: C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O. One molecule of glucose reacts with 6 oxygen molecules, producing 6 CO₂ and 6 water molecules.$t$;

UPDATE questions SET
  explanation = $t$Egg cells are haploid — produced by meiosis. They contain 23 chromosomes (one from each homologous pair). At fertilisation, sperm (23) + egg (23) = zygote (46).$t$
WHERE id = 387
  AND explanation = $t$Egg cells are haploid — produced by meiosis. They contain 23 chromosomes (one from each homologous pair). At fertilisation, sperm \((23) + egg (23)\)= zygote (46).$t$;

UPDATE questions SET
  option_d = $t$By photosynthesis — plants absorb CO2 and convert it to glucose$t$,
  explanation = $t$Plants (and other photosynthesisers) absorb CO2 from the atmosphere and convert it to organic carbon compounds (glucose) using light energy. This is the entry point of carbon into food chains.$t$
WHERE id = 401
  AND option_d = $t$By photosynthesis — plants absorb CO₂ and convert it to glucose$t$
  AND explanation = $t$Plants (and other photosynthesisers) absorb CO₂ from the atmosphere and convert it to organic carbon compounds (glucose) using light energy. This is the entry point of carbon into food chains.$t$;

UPDATE questions SET
  option_a = $t$Respiration — all living organisms release CO2 when they break down glucose for energy$t$,
  explanation = $t$All organisms respire: glucose + oxygen → CO2 + water + energy. CO2 is released back to the atmosphere. This is true for plants, animals, fungi and bacteria.$t$
WHERE id = 402
  AND option_a = $t$Respiration — all living organisms release CO₂ when they break down glucose for energy$t$
  AND explanation = $t$All organisms respire: glucose + oxygen → CO₂ + water + energy. CO₂ is released back to the atmosphere. This is true for plants, animals, fungi and bacteria.$t$;

UPDATE questions SET
  option_c = $t$They break down dead organic matter, releasing CO2 back to the atmosphere through respiration$t$,
  explanation = $t$Decomposers (bacteria and fungi) break down dead organisms and waste. They respire, releasing CO2 to the atmosphere. Without decomposers, nutrients would remain locked in dead matter.$t$
WHERE id = 403
  AND option_c = $t$They break down dead organic matter, releasing CO₂ back to the atmosphere through respiration$t$
  AND explanation = $t$Decomposers (bacteria and fungi) break down dead organisms and waste. They respire, releasing CO₂ to the atmosphere. Without decomposers, nutrients would remain locked in dead matter.$t$;

UPDATE questions SET
  option_a = $t$It has no effect on atmospheric CO2$t$,
  option_c = $t$It releases carbon that was locked underground for millions of years as CO2, increasing atmospheric CO2 levels$t$,
  explanation = $t$Combustion of fossil fuels rapidly releases stored carbon as CO2. This is increasing atmospheric CO2 levels far faster than natural processes can reabsorb it, contributing to climate change.$t$
WHERE id = 405
  AND option_a = $t$It has no effect on atmospheric CO₂$t$
  AND option_c = $t$It releases carbon that was locked underground for millions of years as CO₂, increasing atmospheric CO₂ levels$t$
  AND explanation = $t$Combustion of fossil fuels rapidly releases stored carbon as CO₂. This is increasing atmospheric CO₂ levels far faster than natural processes can reabsorb it, contributing to climate change.$t$;

UPDATE questions SET
  option_d = $t$Decomposition of dead organic matter releases carbon compounds into the soil, some of which become CO2 through respiration$t$,
  explanation = $t$Decomposers break down complex organic molecules in dead material. Some carbon goes into the soil; the rest is released as CO2 through the decomposers' own respiration.$t$
WHERE id = 406
  AND option_d = $t$Decomposition of dead organic matter releases carbon compounds into the soil, some of which become CO₂ through respiration$t$
  AND explanation = $t$Decomposers break down complex organic molecules in dead material. Some carbon goes into the soil; the rest is released as CO₂ through the decomposers' own respiration.$t$;

UPDATE questions SET
  option_c = $t$Cutting down trees reduces photosynthesis (less CO2 absorbed) and burning them releases stored CO2 — increasing net atmospheric CO2$t$,
  explanation = $t$Forests are major carbon sinks. Deforestation reduces CO2 absorption (fewer trees photosynthesising) and releases stored carbon (burning/decomposition). This accelerates CO2 build-up.$t$
WHERE id = 407
  AND option_c = $t$Cutting down trees reduces photosynthesis (less CO₂ absorbed) and burning them releases stored CO₂ — increasing net atmospheric CO₂$t$
  AND explanation = $t$Forests are major carbon sinks. Deforestation reduces CO₂ absorption (fewer trees photosynthesising) and releases stored carbon (burning/decomposition). This accelerates CO₂ build-up.$t$;

UPDATE questions SET
  option_b = $t$As CO2 via respiration, and in faeces and urine$t$,
  explanation = $t$Animals gain carbon by eating. They release it as CO2 (respiration), in waste products (faeces, urine) and when they die and decompose. Very little stays locked in their bodies long-term.$t$
WHERE id = 409
  AND option_b = $t$As CO₂ via respiration, and in faeces and urine$t$
  AND explanation = $t$Animals gain carbon by eating. They release it as CO₂ (respiration), in waste products (faeces, urine) and when they die and decompose. Very little stays locked in their bodies long-term.$t$;

UPDATE questions SET
  option_b = $t$Oceans release CO2 into the atmosphere$t$,
  option_c = $t$Oceans reflect sunlight preventing CO2 from reaching water$t$,
  option_d = $t$CO2 dissolves in seawater and marine organisms use it for photosynthesis and to build shells — storing large amounts of carbon$t$,
  explanation = $t$Oceans absorb about 25% of human CO2 emissions. Marine plants photosynthesise; shellfish and corals incorporate carbon into calcium carbonate shells. Dead organisms sink and are buried — locking away carbon.$t$
WHERE id = 410
  AND option_b = $t$Oceans release CO₂ into the atmosphere$t$
  AND option_c = $t$Oceans reflect sunlight preventing CO₂ from reaching water$t$
  AND option_d = $t$CO₂ dissolves in seawater and marine organisms use it for photosynthesis and to build shells — storing large amounts of carbon$t$
  AND explanation = $t$Oceans absorb about 25% of human CO₂ emissions. Marine plants photosynthesise; shellfish and corals incorporate carbon into calcium carbonate shells. Dead organisms sink and are buried — locking away carbon.$t$;

UPDATE questions SET
  option_a = $t$×100$t$,
  option_b = $t$×0.001$t$,
  option_c = $t$×1000$t$,
  explanation = $t$Magnification = image size ÷ actual size = 30 ÷ 0.03 = 1000. So the magnification is ×1000.$t$
WHERE id = 974
  AND option_a = $t$\(\times 100\)$t$
  AND option_b = $t$\(\times 0.001\)$t$
  AND option_c = $t$\(\times 1000\)$t$
  AND explanation = $t$Magnification = image size ÷ actual size \(= 30 \div 0.03 = 1000\). So the magnification is \(\times 1000\).$t$;

UPDATE questions SET
  explanation = $t$Above optimum temperature, bonds holding the enzyme's 3D shape break. The active site changes shape — the substrate no longer fits. This is irreversible denaturation.$t$
WHERE id = 975
  AND explanation = $t$Above optimum temperature, bonds holding the enzyme's \(3D\) shape break. The active site changes shape — the substrate no longer fits. This is irreversible denaturation.$t$;

UPDATE questions SET
  explanation = $t$Rate of diffusion ∝ (surface area × concentration difference) ÷ membrane thickness. A steeper gradient means a bigger difference — more net movement per unit time.$t$
WHERE id = 980
  AND explanation = $t$Rate of diffusion \(\propto\) (surface area × concentration difference) ÷ membrane thickness. A steeper gradient means a bigger difference — more net movement per unit time.$t$;

UPDATE questions SET
  question_text = $t$Cystic fibrosis is caused by a recessive allele (f). Two carrier parents (Ff × Ff) have children. What is the probability of a child having cystic fibrosis?$t$
WHERE id = 994
  AND question_text = $t$Cystic fibrosis is caused by a recessive allele (\(f\)). Two carrier parents (Ff × Ff) have children. What is the probability of a child having cystic fibrosis?$t$;

UPDATE questions SET
  explanation = $t$Hh × hh: offspring are Hh (affected) and hh (unaffected) in 1:1 ratio = 50% chance affected. Only one copy of the dominant H allele is needed to cause Huntington's disease.$t$
WHERE id = 996
  AND explanation = $t$\(\text{Hh} \times hh\): offspring are Hh (affected) and hh (unaffected) in \(1 : 1\) ratio \(= 50\%\) chance affected. Only one copy of the dominant H allele is needed to cause Huntington's disease.$t$;

UPDATE questions SET
  option_c = $t$Glucose + oxygen to CO2 + water$t$
WHERE id = 1021
  AND option_c = $t$Glucose + oxygen to CO₂ + water$t$;

UPDATE questions SET
  question_text = $t$The inverse square law states that light intensity ∝ 1/d². A lamp is moved from 10 cm to 20 cm from a plant. What happens to light intensity?$t$,
  explanation = $t$Light intensity ∝ 1/d². Distance doubles (×2), so d² increases by ×4, so intensity decreases to 1/4 (a quarter). Rate of photosynthesis will also approximately quarter (if light is limiting).$t$
WHERE id = 1030
  AND question_text = $t$The inverse square law states that light intensity \(\propto \frac{1}{d^{2}}\). A lamp is moved from 10 cm to 20 cm from a plant. What happens to light intensity?$t$
  AND explanation = $t$Light intensity \(\propto \frac{1}{d^{2}}\). Distance doubles \((\times 2)\), so \(d^{2}\) increases by \(\times 4\), so intensity decreases to \(\frac{1}{4}\) (a quarter). Rate of photosynthesis will also approximately quarter (if light is limiting).$t$;

UPDATE questions SET
  explanation = $t$IVF: FSH (and sometimes LH) stimulates superovulation → eggs collected → fertilised by sperm → embryos checked → 1-2 implanted → progesterone supports uterine lining.$t$
WHERE id = 1040
  AND explanation = $t$IVF: FSH (and sometimes LH) stimulates superovulation → eggs collected → fertilised by sperm → embryos checked → 1–2 implanted → progesterone supports uterine lining.$t$;

UPDATE questions SET
  explanation = $t$Alveoli adaptations: huge SA (700 m² total), walls one cell thick (short diffusion distance), dense capillary network (maintains gradient), moist lining (gases dissolve to diffuse).$t$
WHERE id = 1042
  AND explanation = $t$Alveoli adaptations: huge SA (\(700 m^{2}\) total), walls one cell thick (short diffusion distance), dense capillary network (maintains gradient), moist lining (gases dissolve to diffuse).$t$;

UPDATE questions SET
  option_a = $t$1:6$t$,
  option_b = $t$6:1$t$,
  option_c = $t$12:1$t$,
  option_d = $t$3:1$t$,
  explanation = $t$SA = 6 × 2² = 24 cm². Volume = 2³ = 8 cm³. SA:V = 24:8 = 3:1. Smaller organisms have larger SA:V ratios — more efficient for diffusion.$t$
WHERE id = 1049
  AND option_a = $t$\(1 : 6\)$t$
  AND option_b = $t$\(6 : 1\)$t$
  AND option_c = $t$\(12 : 1\)$t$
  AND option_d = $t$\(3 : 1\)$t$
  AND explanation = $t$\(SA = 6 \times 2^{2} = 24\,\text{cm}^{2}\). Volume \(= 2^{3} = 8\,\text{cm}^{3}\). SA:V \(= 24 : 8 = 3 : 1\). Smaller organisms have larger SA:V ratios — more efficient for diffusion.$t$;

UPDATE questions SET
  question_text = $t$A quadrat study finds 12 dandelions in a 0.5 m² quadrat. Estimate the number in a field of 200 m².$t$,
  explanation = $t$Density = 12/0.5 = 24 per m². Total = 24 × 200 = 4800 dandelions.$t$
WHERE id = 1058
  AND question_text = $t$A quadrat study finds 12 dandelions in \(a 0.5 m^{2}\) quadrat. Estimate the number in a field of \(200 m^{2}\).$t$
  AND explanation = $t$Density \(= \frac{12}{0.5} = 24\) per \(m^{2}\). Total \(= 24 \times 200 = 4800\) dandelions.$t$;

UPDATE questions SET
  question_text = $t$A cell has a water potential of −400 kPa. It is placed in a solution with water potential −200 kPa. What happens?$t$,
  explanation = $t$Water moves from higher water potential (less negative) to lower water potential (more negative). The solution (−200 kPa) has higher water potential than the cell (−400 kPa), so water enters the cell.$t$
WHERE id = 1214
  AND question_text = $t$A cell has a water potential of \(- 400\,\text{kPa}\). It is placed in a solution with water potential \(- 200\,\text{kPa}\). What happens?$t$
  AND explanation = $t$Water moves from higher water potential (less negative) to lower water potential (more negative). The solution \((- 200\,\text{kPa})\) has higher water potential than the cell \((- 400\,\text{kPa})\), so water enters the cell.$t$;

UPDATE questions SET
  option_a = $t$−100 kPa$t$,
  option_c = $t$+100 kPa$t$
WHERE id = 1215
  AND option_a = $t$\(- 100\,\text{kPa}\)$t$
  AND option_c = $t$\(+ 100\,\text{kPa}\)$t$;

UPDATE questions SET
  question_text = $t$A student finds that the mass of a potato cylinder increases by 12% when placed in a 0.1 mol/dm³ sucrose solution. What can be concluded?$t$,
  option_a = $t$The water potential of the potato is higher than that of the 0.1 mol/dm³ solution$t$,
  option_b = $t$The water potential of the potato equals that of the 0.1 mol/dm³ solution$t$,
  option_c = $t$The water potential of the potato is lower than that of the 0.1 mol/dm³ solution$t$,
  explanation = $t$Mass increased means water entered the potato. Water moves from higher to lower water potential, so the external solution (0.1 mol/dm³) has higher water potential than the potato cells.$t$
WHERE id = 1222
  AND question_text = $t$A student finds that the mass of a potato cylinder increases by 12% when placed in \(a\) \(0.1\,\text{mol/dm}^{3}\) sucrose solution. What can be concluded?$t$
  AND option_a = $t$The water potential of the potato is higher than that of the \(0.1\,\text{mol/dm}^{3}\) solution$t$
  AND option_b = $t$The water potential of the potato equals that of the \(0.1\,\text{mol/dm}^{3}\) solution$t$
  AND option_c = $t$The water potential of the potato is lower than that of the \(0.1\,\text{mol/dm}^{3}\) solution$t$
  AND explanation = $t$Mass increased means water entered the potato. Water moves from higher to lower water potential, so the external solution (\(0.1\,\text{mol/dm}^{3}\)) has higher water potential than the potato cells.$t$;

UPDATE questions SET
  question_text = $t$A student investigates osmosis using visking tubing filled with 1 mol/dm³ sucrose solution, placed in distilled water. After 30 minutes the tubing has swollen. Which explanation is correct?$t$
WHERE id = 1233
  AND question_text = $t$A student investigates osmosis using visking tubing filled with \(1\,\text{mol/dm}^{3}\) sucrose solution, placed in distilled water. After 30 minutes the tubing has swollen. Which explanation is correct?$t$;

UPDATE questions SET
  question_text = $t$A student measures the length of potato chips in sucrose solutions from 0 to 1.0 mol/dm³. The chips in 0.4 mol/dm³ show no change. What can be concluded about the potato cells?$t$,
  option_a = $t$The potato cells are impermeable to water at 0.4 mol/dm³$t$,
  option_b = $t$0.4 mol/dm³ sucrose is the maximum concentration for osmosis$t$,
  option_c = $t$The water potential of potato cells equals the water potential of 0.4 mol/dm³ sucrose$t$,
  explanation = $t$No change in length means no net osmosis — the external solution is isotonic with the potato cell contents. Therefore the water potential of the potato cells equals that of 0.4 mol/dm³ sucrose solution.$t$
WHERE id = 1237
  AND question_text = $t$A student measures the length of potato chips in sucrose solutions from 0 to \(1.0\,\text{mol/dm}^{3}\). The chips in \(0.4\,\text{mol/dm}^{3}\) show no change. What can be concluded about the potato cells?$t$
  AND option_a = $t$The potato cells are impermeable to water at \(0.4\,\text{mol/dm}^{3}\)$t$
  AND option_b = $t$\(0.4\,\text{mol/dm}^{3}\) sucrose is the maximum concentration for osmosis$t$
  AND option_c = $t$The water potential of potato cells equals the water potential of \(0.4\,\text{mol/dm}^{3}\) sucrose$t$
  AND explanation = $t$No change in length means no net osmosis — the external solution is isotonic with the potato cell contents. Therefore the water potential of the potato cells equals that of \(0.4\,\text{mol/dm}^{3}\) sucrose solution.$t$;

UPDATE questions SET
  question_text = $t$A student cuts potato cylinders of equal size. Group A is placed in distilled water and Group B in 1.0 mol/dm³ sucrose. After 1 hour, Group A increased in mass by 8% and Group B decreased in mass by 15%. Which conclusion is valid?$t$,
  option_a = $t$The potato cells have a water potential between that of distilled water and 1.0 mol/dm³ sucrose$t$,
  option_d = $t$The potato cells have a lower water potential than 1.0 mol/dm³ sucrose$t$,
  explanation = $t$Group A gaining mass means water potential of potato > water potential of distilled water is false (water entered from distilled water so potato WP < 0). Group B losing mass means potato WP > that of 1.0 mol/dm³. So potato WP lies between them. Both A and C are correct.$t$
WHERE id = 1241
  AND question_text = $t$A student cuts potato cylinders of equal size. Group A is placed in distilled water and Group B in \(1.0\,\text{mol/dm}^{3}\) sucrose. After 1 hour, Group A increased in mass by 8% and Group B decreased in mass by 15%. Which conclusion is valid?$t$
  AND option_a = $t$The potato cells have a water potential between that of distilled water and \(1.0\,\text{mol/dm}^{3}\) sucrose$t$
  AND option_d = $t$The potato cells have a lower water potential than \(1.0\,\text{mol/dm}^{3}\) sucrose$t$
  AND explanation = $t$Group A gaining mass means water potential of potato > water potential of distilled water is false (water entered from distilled water so potato \(WP < 0\)). Group B losing mass means potato WP > that of \(1.0\,\text{mol/dm}^{3}\). So potato WP lies between them. Both A and C are correct.$t$;

UPDATE questions SET
  question_text = $t$A student investigates active transport in yeast cells at different temperatures (10°C, 20°C, 30°C, 40°C, 50°C). Predict the pattern of results and explain.$t$,
  option_c = $t$Rate increases from 10–40°C as enzymes in respiration work faster; rate drops sharply above 40°C as respiratory enzymes denature, reducing ATP for active transport$t$,
  explanation = $t$Active transport depends on ATP from aerobic respiration, which is enzyme-catalysed. Higher temperatures increase enzyme activity up to the optimum (~40°C for most). Above this, respiratory enzymes denature, ATP production falls, and active transport rate decreases sharply.$t$
WHERE id = 1279
  AND question_text = $t$A student investigates active transport in yeast cells at different temperatures \((10^\circ C,\ 20^\circ C,\ 30^\circ C,\ 40^\circ C,\ 50^\circ C)\). Predict the pattern of results and explain.$t$
  AND option_c = $t$Rate increases from 10–40°C as enzymes in respiration work faster; rate drops sharply above \(40^\circ C\) as respiratory enzymes denature, reducing ATP for active transport$t$
  AND explanation = $t$Active transport depends on ATP from aerobic respiration, which is enzyme-catalysed. Higher temperatures increase enzyme activity up to the optimum (~\(40^\circ C\) for most). Above this, respiratory enzymes denature, ATP production falls, and active transport rate decreases sharply.$t$;

UPDATE questions SET
  option_a = $t$Cell > organ > tissue > organ system > organism$t$,
  option_b = $t$Organism > organ system > organ > tissue > cell$t$,
  option_c = $t$Tissue > organ > cell > organ system > organism$t$,
  option_d = $t$Organ > organ system > tissue > cell > organism$t$
WHERE id = 1292
  AND option_a = $t$Cell \(> \text{organ} > \text{tissue}\)> organ system \(> \text{organism}\)$t$
  AND option_b = $t$Organism > organ system \(> \text{organ} > \text{tissue} > \text{cell}\)$t$
  AND option_c = $t$Tissue \(> \text{organ} > \text{cell}\)> organ system \(> \text{organism}\)$t$
  AND option_d = $t$Organ > organ system \(> \text{tissue} > \text{cell} > \text{organism}\)$t$;

UPDATE questions SET
  explanation = $t$This is a genuine scientific and ethical debate. Scientific arguments for extension include accessing later developmental stages crucial for understanding congenital conditions. Counter-arguments include the increasing moral status of the developing embryo and the risk of a "slippery slope" eroding ethical boundaries in embryo research.$t$
WHERE id = 1358
  AND explanation = $t$This is a genuine scientific and ethical debate. Scientific arguments for extension include accessing later developmental stages crucial for understanding congenital conditions. Counter-arguments include the increasing moral status of the developing embryo and the risk of \(a\) "slippery slope" eroding ethical boundaries in embryo research.$t$;

UPDATE questions SET
  explanation = $t$Renin from the kidneys converts angiotensinogen to angiotensin I → ACE converts it to angiotensin II → powerful vasoconstrictor, also stimulates aldosterone (Na⁺ and water retention). This raises blood pressure. Chronic activation contributes to hypertension, which damages artery walls, accelerating atherosclerosis and CHD.$t$
WHERE id = 1420
  AND explanation = $t$Renin from the kidneys converts angiotensinogen to angiotensin \(I \to ACE\) converts it to angiotensin II → powerful vasoconstrictor, also stimulates aldosterone (Na⁺ and water retention). This raises blood pressure. Chronic activation contributes to hypertension, which damages artery walls, accelerating atherosclerosis and CHD.$t$;

UPDATE questions SET
  option_c = $t$6 times higher risk (2 + 2 + 2)$t$,
  option_d = $t$8 times higher risk (2 × 2 × 2)$t$,
  explanation = $t$Risk factors multiply (not add) in their effect. Each factor doubles the risk: 1 factor = 2× risk; 2 factors = 2×2 = 4× risk; 3 factors = 2×2×2 = 8× risk. This multiplicative effect explains why people with multiple risk factors have dramatically elevated CHD risk.$t$
WHERE id = 1432
  AND option_c = $t$6 times higher risk \((2 + 2 + 2)\)$t$
  AND option_d = $t$8 times higher risk \((2 \times 2 \times 2)\)$t$
  AND explanation = $t$Risk factors multiply (not add) in their effect. Each factor doubles the risk: 1 factor \(= 2\)× risk; 2 factors \(= 2 \times 2 = 4\)× risk; 3 factors \(= 2 \times 2 \times 2 = 8\)× risk. This multiplicative effect explains why people with multiple risk factors have dramatically elevated CHD risk.$t$;

UPDATE questions SET
  explanation = $t$Vulnerable (unstable) plaques have a large lipid core and a thin fibrous cap. They can rupture with little warning (even in arteries with <50% narrowing), exposing the lipid core to blood and triggering rapid thrombus formation. This can completely occlude the artery, causing sudden myocardial infarction in people who had no prior symptoms — explaining why sudden cardiac death can occur without apparent warning.$t$
WHERE id = 1435
  AND explanation = $t$Vulnerable (unstable) plaques have a large lipid core and a thin fibrous cap. They can rupture with little warning (even in arteries with \(< 50\%\) narrowing), exposing the lipid core to blood and triggering rapid thrombus formation. This can completely occlude the artery, causing sudden myocardial infarction in people who had no prior symptoms — explaining why sudden cardiac death can occur without apparent warning.$t$;

UPDATE questions SET
  option_a = $t$Relative risk reduction (30%) expresses reduction as a proportion of the baseline risk; absolute risk reduction (1%) is the actual difference in event rates. If baseline risk is low (e.g. 3% vs 2%), a large relative reduction = small absolute benefit. Number needed to treat (NNT = 100) helps assess real-world benefit vs side effect risk$t$,
  explanation = $t$Relative risk reduction can overstate benefit. If untreated group has 3% event rate and treated has 2%, RRR = 33% (impressive-sounding) but ARR = 1% (1 in 100 patients benefits). NNT = 1/ARR = 100 (must treat 100 patients to prevent 1 event). This is crucial for weighing treatment benefits against side effects and costs. Both statistics are needed for informed decision-making.$t$
WHERE id = 1437
  AND option_a = $t$Relative risk reduction (30%) expresses reduction as a proportion of the baseline risk; absolute risk reduction (1%) is the actual difference in event rates. If baseline risk is low (e.g. 3% vs 2%), a large relative reduction = small absolute benefit. Number needed to treat \((NNT = 100)\) helps assess real-world benefit vs side effect risk$t$
  AND explanation = $t$Relative risk reduction can overstate benefit. If untreated group has 3% event rate and treated has 2%, \(RRR = 33\%\) (impressive-sounding) but \(ARR = 1\%\) (1 in 100 patients benefits). \(NNT = \frac{1}{ARR} = 100\) (must treat 100 patients to prevent 1 event). This is crucial for weighing treatment benefits against side effects and costs. Both statistics are needed for informed decision-making.$t$;

UPDATE questions SET
  explanation = $t$Autoclaving uses pressurised steam at 121 degrees C for 15-20 minutes. This temperature is high enough to kill all microorganisms including heat-resistant bacterial endospores, which cannot be killed by boiling at 100 degrees C.$t$
WHERE id = 1452
  AND explanation = $t$Autoclaving uses pressurised steam at 121 degrees C for 15–20 minutes. This temperature is high enough to kill all microorganisms including heat-resistant bacterial endospores, which cannot be killed by boiling at 100 degrees C.$t$;

UPDATE questions SET
  explanation = $t$After 1 hour (60 minutes) with a doubling time of 20 minutes, the bacteria will have undergone 3 doublings (60/20 = 3). Starting with 100 cells: 100 x 2 x 2 x 2 = 800 cells.$t$
WHERE id = 1454
  AND explanation = $t$After 1 hour (60 minutes) with a doubling time of 20 minutes, the bacteria will have undergone 3 doublings \((\frac{60}{20} = 3)\). Starting with 100 cells: \(100 \times 2 \times 2 \times 2 = 800\) cells.$t$;

UPDATE questions SET
  option_a = $t$N = N0 + (number of doublings)$t$,
  option_b = $t$N = N0 x 2^n$t$,
  option_c = $t$N = N0 / 2^n$t$,
  option_d = $t$N = 2 x N0 x n$t$,
  explanation = $t$The formula for bacterial growth is N = N0 x 2^n, where N is the final number, N0 is the starting number, and n is the number of doublings. This represents exponential (geometric) growth.$t$
WHERE id = 1455
  AND option_a = $t$\(N = N0 +\) (number of doublings)$t$
  AND option_b = $t$\(N = N0 \times 2^{n}\)$t$
  AND option_c = $t$\(N = \frac{N0}{2^{n}}\)$t$
  AND option_d = $t$\(N = 2 x N0 \times n\)$t$
  AND explanation = $t$The formula for bacterial growth is \(N = N0 \times 2^{n}\), where N is the final number, N0 is the starting number, and \(n\) is the number of doublings. This represents exponential (geometric) growth.$t$;

UPDATE questions SET
  option_b = $t$Surface area = pi x diameter$t$,
  option_c = $t$Surface area = diameter^2$t$,
  option_d = $t$Surface area = pi x (diameter/2)^2$t$,
  explanation = $t$The inhibition zone is circular. The area of a circle = pi x r^2, where r is the radius. Since radius = diameter/2, the formula is pi x (diameter/2)^2. This gives the actual area of inhibition, which is more informative than diameter alone.$t$
WHERE id = 1459
  AND option_b = $t$Surface area \(= \pi x\) diameter$t$
  AND option_c = $t$Surface area = diameter\({}^{2}\)$t$
  AND option_d = $t$Surface area \(= \pi \times\) (diameter/2)\({}^{2}\)$t$
  AND explanation = $t$The inhibition zone is circular. The area of a circle \(= \pi \times r^{2}\), where \(r\) is the radius. Since radius = diameter/2, the formula is \(\pi \times\) (diameter/2)\({}^{2}\). This gives the actual area of inhibition, which is more informative than diameter alone.$t$;

UPDATE questions SET
  option_c = $t$1 in 1,000,000 dilution$t$,
  option_d = $t$1 in 100,000 dilution$t$,
  explanation = $t$To count individual colonies, plates should ideally have between 30 and 300 colonies. Undiluted cultures produce confluent (merged) growth that cannot be counted. A 1 in 100,000 (10^-5) dilution is typically appropriate for dense cultures, giving countable, well-separated colonies.$t$
WHERE id = 1462
  AND option_c = $t$1 in 1 000 000 dilution$t$
  AND option_d = $t$1 in 100 000 dilution$t$
  AND explanation = $t$To count individual colonies, plates should ideally have between 30 and 300 colonies. Undiluted cultures produce confluent (merged) growth that cannot be counted. A 1 in \(100\,000 (10^{-5})\) dilution is typically appropriate for dense cultures, giving countable, well-separated colonies.$t$;

UPDATE questions SET
  option_a = $t$6,400$t$,
  option_b = $t$25,600$t$,
  option_c = $t$51,200$t$,
  option_d = $t$3,200$t$,
  explanation = $t$In 3 hours (180 minutes) with a doubling time of 30 minutes, the bacteria undergo 180/30 = 6 doublings. N = 50 x 2^6 = 50 x 64 = 3,200 cells.$t$
WHERE id = 1473
  AND option_a = $t$6 400$t$
  AND option_b = $t$25 600$t$
  AND option_c = $t$51 200$t$
  AND option_d = $t$3 200$t$
  AND explanation = $t$In 3 hours (180 minutes) with a doubling time of 30 minutes, the bacteria undergo \(\frac{180}{30} = 6\) doublings. \(N = 50 \times 2^{6} = 50 \times 64 = 3\,200\) cells.$t$;

UPDATE questions SET
  question_text = $t$A person has a BRCA1 gene mutation. Explain what this means for their cancer risk and what preventive options exist.$t$
WHERE id = 1501
  AND question_text = $t$A person has \(a\) BRCA1 gene mutation. Explain what this means for their cancer risk and what preventive options exist.$t$;

UPDATE questions SET
  explanation = $t$Gene-environment interaction is central to cancer risk. Someone with a BRCA1 mutation who also smokes and has high UV exposure faces compounding risks from both genetic and environmental sources. Conversely, lifestyle modifications can significantly reduce cancer risk even in genetically predisposed individuals.$t$
WHERE id = 1510
  AND explanation = $t$Gene-environment interaction is central to cancer risk. Someone with \(a\) BRCA1 mutation who also smokes and has high UV exposure faces compounding risks from both genetic and environmental sources. Conversely, lifestyle modifications can significantly reduce cancer risk even in genetically predisposed individuals.$t$;

UPDATE questions SET
  question_text = $t$Immune checkpoint inhibitors (e.g. anti-PD-1 antibodies) are a new class of cancer immunotherapy. Explain the mechanism by which cancer cells evade the immune system, and how checkpoint inhibitors restore immune function.$t$,
  option_b = $t$Cancer cells overexpress PD-L1, which binds to PD-1 receptors on T cells, switching off their cytotoxic activity (immune checkpoint). Anti-PD-1 antibodies block this interaction, preventing T cell suppression and restoring cytotoxic T cell activity against the tumour$t$,
  explanation = $t$Cancer cells exploit physiological immune tolerance mechanisms. PD-L1 expression sends an inhibitory signal to T cells (a normal mechanism to prevent autoimmunity). Anti-PD-1/PD-L1 antibodies block this checkpoint, re-activating cytotoxic T cells that can then recognise and kill cancer cells. This approach has transformed treatment of melanoma, lung cancer and others.$t$
WHERE id = 1515
  AND question_text = $t$Immune checkpoint inhibitors (e.g. anti\(- PD - 1\) antibodies) are a new class of cancer immunotherapy. Explain the mechanism by which cancer cells evade the immune system, and how checkpoint inhibitors restore immune function.$t$
  AND option_b = $t$Cancer cells overexpress \(PD - L1\), which binds to \(PD - 1\) receptors on T cells, switching off their cytotoxic activity (immune checkpoint). Anti\(- PD - 1\) antibodies block this interaction, preventing T cell suppression and restoring cytotoxic T cell activity against the tumour$t$
  AND explanation = $t$Cancer cells exploit physiological immune tolerance mechanisms. \(PD - L1\) expression sends an inhibitory signal to T cells (a normal mechanism to prevent autoimmunity). Anti\(- PD - \frac{1}{PD} - L1\) antibodies block this checkpoint, re-activating cytotoxic T cells that can then recognise and kill cancer cells. This approach has transformed treatment of melanoma, lung cancer and others.$t$;

UPDATE questions SET
  option_b = $t$Increased recreational sun exposure and sunbed use (particularly in the 1970s-1990s before risks were well understood) accumulated UV-induced DNA damage that is now manifesting as cancer after a long latency period; and improved diagnostic sensitivity and increased biopsy rates mean more lesions are being classified as melanoma that might previously have been missed or classified differently$t$
WHERE id = 1522
  AND option_b = $t$Increased recreational sun exposure and sunbed use (particularly in the \(1970s - 1990s\) before risks were well understood) accumulated UV-induced DNA damage that is now manifesting as cancer after a long latency period; and improved diagnostic sensitivity and increased biopsy rates mean more lesions are being classified as melanoma that might previously have been missed or classified differently$t$;

UPDATE questions SET
  option_c = $t$Humidity, CO2 concentration, gravity and root depth$t$
WHERE id = 1546
  AND option_c = $t$Humidity, CO₂ concentration, gravity and root depth$t$;

UPDATE questions SET
  option_b = $t$To maximise the area for gas exchange (CO2 in for photosynthesis; O2 and water vapour out) between mesophyll cells and the atmosphere$t$,
  explanation = $t$The spongy mesophyll layer has large air spaces between cells that allow efficient diffusion of CO2 from stomata to photosynthesising cells, and diffusion of O2 and water vapour in the opposite direction. The large surface area of cells exposed to air spaces maximises gas exchange efficiency.$t$
WHERE id = 1550
  AND option_b = $t$To maximise the area for gas exchange (CO₂ in for photosynthesis; O₂ and water vapour out) between mesophyll cells and the atmosphere$t$
  AND explanation = $t$The spongy mesophyll layer has large air spaces between cells that allow efficient diffusion of CO₂ from stomata to photosynthesising cells, and diffusion of O₂ and water vapour in the opposite direction. The large surface area of cells exposed to air spaces maximises gas exchange efficiency.$t$;

UPDATE questions SET
  question_text = $t$A scientist uses radioactively labelled CO2 in an experiment and detects radioactivity in the phloem shortly after. What can be concluded from this experiment?$t$,
  option_a = $t$CO2 is transported in the phloem$t$,
  option_b = $t$Phloem transports CO2 from leaves to roots$t$,
  option_c = $t$The radioactive CO2 was incorporated into sugars during photosynthesis, and these labelled sugars were then loaded into the phloem and translocated — confirming that photosynthate (products of photosynthesis) are transported in phloem$t$,
  option_d = $t$The experiment shows that CO2 enters the plant through the phloem$t$,
  explanation = $t$This classic experiment traces the pathway of carbon from CO2 fixation (photosynthesis) into organic molecules. Radioactive 14CO2 is fixed into 14C-labelled sugars by photosynthesis. When radioactivity is detected in phloem, it confirms that photosynthetically produced sugars are loaded into and transported via phloem — providing direct evidence for phloem as a pathway for photosynthate transport.$t$
WHERE id = 1554
  AND question_text = $t$A scientist uses radioactively labelled CO₂ in an experiment and detects radioactivity in the phloem shortly after. What can be concluded from this experiment?$t$
  AND option_a = $t$CO₂ is transported in the phloem$t$
  AND option_b = $t$Phloem transports CO₂ from leaves to roots$t$
  AND option_c = $t$The radioactive CO₂ was incorporated into sugars during photosynthesis, and these labelled sugars were then loaded into the phloem and translocated — confirming that photosynthate (products of photosynthesis) are transported in phloem$t$
  AND option_d = $t$The experiment shows that CO₂ enters the plant through the phloem$t$
  AND explanation = $t$This classic experiment traces the pathway of carbon from CO₂ fixation (photosynthesis) into organic molecules. Radioactive 14CO₂ is fixed into \(14C\)-labelled sugars by photosynthesis. When radioactivity is detected in phloem, it confirms that photosynthetically produced sugars are loaded into and transported via phloem — providing direct evidence for phloem as a pathway for photosynthate transport.$t$;

UPDATE questions SET
  option_d = $t$Wilting occurs because stomata close, preventing CO2 uptake$t$
WHERE id = 1558
  AND option_d = $t$Wilting occurs because stomata close, preventing CO₂ uptake$t$;

UPDATE questions SET
  option_b = $t$C4 plants spatially separate initial CO2 fixation (in mesophyll cells) from the Calvin cycle (in bundle sheath cells), concentrating CO2 around RuBisCO. This suppresses photorespiration and allows stomata to be partially closed (reducing water loss) while maintaining CO2 supply for photosynthesis — giving a competitive advantage in hot, bright, dry environments$t$,
  option_d = $t$C4 plants have larger stomata that absorb more CO2 even when partially closed$t$,
  explanation = $t$In hot conditions, C3 plants must keep stomata open for CO2, causing high water loss, while RuBisCO also fixes O2 wastefully (photorespiration). C4 plants use a carbon-concentrating mechanism: PEP carboxylase in mesophyll cells fixes CO2 into 4-carbon acids even at low CO2 concentrations; these are transported to bundle sheath cells where CO2 is released at high concentration around RuBisCO. This allows partial stomatal closure (water conservation) without limiting photosynthesis.$t$
WHERE id = 1559
  AND option_b = $t$C4 plants spatially separate initial CO₂ fixation (in mesophyll cells) from the Calvin cycle (in bundle sheath cells), concentrating CO₂ around RuBisCO. This suppresses photorespiration and allows stomata to be partially closed (reducing water loss) while maintaining CO₂ supply for photosynthesis — giving a competitive advantage in hot, bright, dry environments$t$
  AND option_d = $t$C4 plants have larger stomata that absorb more CO₂ even when partially closed$t$
  AND explanation = $t$In hot conditions, C3 plants must keep stomata open for CO₂, causing high water loss, while RuBisCO also fixes O₂ wastefully (photorespiration). C4 plants use a carbon-concentrating mechanism: PEP carboxylase in mesophyll cells fixes CO₂ into 4-carbon acids even at low CO₂ concentrations; these are transported to bundle sheath cells where CO₂ is released at high concentration around RuBisCO. This allows partial stomatal closure (water conservation) without limiting photosynthesis.$t$;

UPDATE questions SET
  explanation = $t$The cohesion-tension theory is well-supported: tension in xylem has been directly measured; water uptake matches transpiration; vessel anatomy is consistent with tension. The main challenge comes from the heights involved — theoretical calculations suggest the tensions needed for very tall trees (>100m) would exceed the cavitation threshold. Plants appear to manage this through embolism repair mechanisms and vessel redundancy, though the exact mechanisms remain areas of active research.$t$
WHERE id = 1560
  AND explanation = $t$The cohesion-tension theory is well-supported: tension in xylem has been directly measured; water uptake matches transpiration; vessel anatomy is consistent with tension. The main challenge comes from the heights involved — theoretical calculations suggest the tensions needed for very tall trees \((> 100m)\) would exceed the cavitation threshold. Plants appear to manage this through embolism repair mechanisms and vessel redundancy, though the exact mechanisms remain areas of active research.$t$;

UPDATE questions SET
  option_a = $t$ABA stimulates guard cells to actively pump K+ ions in, causing water entry and stomata to open$t$,
  option_d = $t$ABA triggers efflux of K+ ions from guard cells (via ion channels), reducing solute concentration inside guard cells, raising their water potential. Water exits guard cells by osmosis; guard cells become flaccid; stomata close. This reduces transpiration and conserves water during drought$t$,
  explanation = $t$ABA is the primary drought stress signal. It activates anion channels and K+ efflux channels in the guard cell plasma membrane. Solute loss raises guard cell water potential above that of surrounding cells. Water exits guard cells by osmosis down the water potential gradient. Guard cells shrink and become flaccid, causing stomata to close. This is adaptive because it reduces transpiration water loss when soil water is limiting.$t$
WHERE id = 1561
  AND option_a = $t$ABA stimulates guard cells to actively pump K⁺ ions in, causing water entry and stomata to open$t$
  AND option_d = $t$ABA triggers efflux of K⁺ ions from guard cells (via ion channels), reducing solute concentration inside guard cells, raising their water potential. Water exits guard cells by osmosis; guard cells become flaccid; stomata close. This reduces transpiration and conserves water during drought$t$
  AND explanation = $t$ABA is the primary drought stress signal. It activates anion channels and K⁺ efflux channels in the guard cell plasma membrane. Solute loss raises guard cell water potential above that of surrounding cells. Water exits guard cells by osmosis down the water potential gradient. Guard cells shrink and become flaccid, causing stomata to close. This is adaptive because it reduces transpiration water loss when soil water is limiting.$t$;

UPDATE questions SET
  explanation = $t$The development of resistance by bacteria to existing antibiotics is an ongoing evolutionary process. As each antibiotic is introduced, selective pressure drives the emergence and spread of resistant strains. Developing new antibiotics replenishes the arsenal of effective treatments, though the rate of antibiotic discovery has slowed dramatically since the 1980s.$t$
WHERE id = 1569
  AND explanation = $t$The development of resistance by bacteria to existing antibiotics is an ongoing evolutionary process. As each antibiotic is introduced, selective pressure drives the emergence and spread of resistant strains. Developing new antibiotics replenishes the arsenal of effective treatments, though the rate of antibiotic discovery has slowed dramatically since the \(1980s\).$t$;

UPDATE questions SET
  explanation = $t$Phase I (typically 20-80 healthy volunteers): first in human, tests safety, tolerability, and pharmacokinetics (how the body processes the drug). Phase II (typically hundreds of patients): tests preliminary efficacy, optimal dose, and side effect profile. Phase III (typically thousands of patients): large-scale randomised controlled trial comparing new drug to standard treatment or placebo, establishing efficacy and safety.$t$
WHERE id = 1575
  AND explanation = $t$Phase I (typically 20–80 healthy volunteers): first in human, tests safety, tolerability, and pharmacokinetics (how the body processes the drug). Phase II (typically hundreds of patients): tests preliminary efficacy, optimal dose, and side effect profile. Phase III (typically thousands of patients): large-scale randomised controlled trial comparing new drug to standard treatment or placebo, establishing efficacy and safety.$t$;

UPDATE questions SET
  explanation = $t$The antibiotic pipeline suffers from market failure. High development costs (~$1-2 billion per drug) combined with low returns (short treatment courses, stewardship restrictions reducing prescribing, rapid resistance rendering drugs obsolete) make antibiotic R&D unattractive for private companies. Public goods arguments (societal benefit exceeds private return) justify government intervention through grants, prizes, and guaranteed purchase agreements.$t$
WHERE id = 1578
  AND explanation = $t$The antibiotic pipeline suffers from market failure. High development costs (~$1–2 billion per drug) combined with low returns (short treatment courses, stewardship restrictions reducing prescribing, rapid resistance rendering drugs obsolete) make antibiotic R&D unattractive for private companies. Public goods arguments (societal benefit exceeds private return) justify government intervention through grants, prizes, and guaranteed purchase agreements.$t$;

UPDATE questions SET
  option_a = $t$ARR = 85%, NNT = 1$t$,
  option_b = $t$ARR = 70% (85 - 15), NNT = approximately 1.4 (1/0.7), meaning treating about 1-2 patients results in one extra cure attributable to the antibiotic$t$,
  option_c = $t$ARR = 15%, NNT = 7$t$,
  option_d = $t$ARR = 100%, NNT = 10$t$,
  explanation = $t$ARR = event rate in treatment group minus event rate in control group. Here: 85% - 15% = 70% (0.70). NNT = 1/ARR = 1/0.70 = approximately 1.43. This means treating approximately 1.4 patients results in one extra cure attributable to the antibiotic over placebo. A low NNT indicates a very effective treatment.$t$
WHERE id = 1581
  AND option_a = $t$\(ARR = 85\%\), \(NNT = 1\)$t$
  AND option_b = $t$\(ARR = 70\% (85 - 15)\), NNT = approximately \(1.4 (\frac{1}{0.7})\), meaning treating about 1–2 patients results in one extra cure attributable to the antibiotic$t$
  AND option_c = $t$\(ARR = 15\%\), \(NNT = 7\)$t$
  AND option_d = $t$\(ARR = 100\%\), \(NNT = 10\)$t$
  AND explanation = $t$ARR = event rate in treatment group minus event rate in control group. Here: \(85\% - 15\% = 70\% (0.70)\). \(NNT = \frac{1}{ARR} = \frac{1}{0.70}\)= approximately 1.43. This means treating approximately 1.4 patients results in one extra cure attributable to the antibiotic over placebo. A low NNT indicates a very effective treatment.$t$;

UPDATE questions SET
  explanation = $t$The key challenge is selectivity. Bacteria have distinct structures (cell wall, 70S ribosomes, unique metabolic pathways) that differ from human cells and can be targeted. Viruses hijack host cell ribosomes, polymerases and metabolic machinery for replication. Finding biochemical differences between the virus and host cell that can be exploited as drug targets (as with HIV reverse transcriptase, influenza neuraminidase) is far more technically challenging.$t$
WHERE id = 1582
  AND explanation = $t$The key challenge is selectivity. Bacteria have distinct structures (cell wall, \(70S\) ribosomes, unique metabolic pathways) that differ from human cells and can be targeted. Viruses hijack host cell ribosomes, polymerases and metabolic machinery for replication. Finding biochemical differences between the virus and host cell that can be exploited as drug targets (as with HIV reverse transcriptase, influenza neuraminidase) is far more technically challenging.$t$;

UPDATE questions SET
  explanation = $t$Phase II trials are too small to detect rare adverse effects (e.g. 1 in 1,000 patients). Phase III trials with thousands of patients can detect these. Additionally, Phase II often uses highly selected patients (few comorbidities), whereas Phase III includes more typical patients. The broader population may show lower efficacy or higher adverse effect rates than the selected Phase II cohort.$t$
WHERE id = 1591
  AND explanation = $t$Phase II trials are too small to detect rare adverse effects (e.g. 1 in 1 000 patients). Phase III trials with thousands of patients can detect these. Additionally, Phase II often uses highly selected patients (few comorbidities), whereas Phase III includes more typical patients. The broader population may show lower efficacy or higher adverse effect rates than the selected Phase II cohort.$t$;

UPDATE questions SET
  question_text = $t$Explain why there has been a dramatic decrease in the discovery of new classes of antibiotics since the 1980s (the antibiotic discovery void).$t$,
  explanation = $t$The antibiotic discovery void reflects multiple converging factors: the golden age of antibiotic discovery (1940s-1970s) systematically screened the most accessible natural sources; truly novel chemical scaffolds are increasingly rare; pharmaceutical R&D investment shifted to more profitable chronic disease drugs; and regulatory hurdles for antibiotic approval became more demanding. This has created a dangerous gap between the pipeline of new antibiotics and the emergence of resistance.$t$
WHERE id = 1593
  AND question_text = $t$Explain why there has been a dramatic decrease in the discovery of new classes of antibiotics since the \(1980s\) (the antibiotic discovery void).$t$
  AND explanation = $t$The antibiotic discovery void reflects multiple converging factors: the golden age of antibiotic discovery \((1940s - 1970s)\) systematically screened the most accessible natural sources; truly novel chemical scaffolds are increasingly rare; pharmaceutical R&D investment shifted to more profitable chronic disease drugs; and regulatory hurdles for antibiotic approval became more demanding. This has created a dangerous gap between the pipeline of new antibiotics and the emergence of resistance.$t$;

UPDATE questions SET
  question_text = $t$Biofilms (communities of bacteria enclosed in a protective matrix) are up to 1,000 times more resistant to antibiotics than free-living bacteria. Explain the mechanisms that confer this enhanced resistance.$t$
WHERE id = 1594
  AND question_text = $t$Biofilms (communities of bacteria enclosed in a protective matrix) are up to 1 000 times more resistant to antibiotics than free-living bacteria. Explain the mechanisms that confer this enhanced resistance.$t$;

UPDATE questions SET
  option_c = $t$Stages: hit identification (confirm in vitro activity); lead optimisation (chemical modification to improve potency, selectivity, pharmacokinetics); pre-clinical testing (cell cultures and animals — safety, toxicology, ADME); Phase I-III clinical trials (safety, dosage, efficacy in humans); regulatory review and approval. Challenges at each stage include: structure-activity relationships (lead optimisation); animal-to-human translation; patient recruitment; regulatory requirements; and the high financial investment required (approx $1-2 billion over 10-15 years)$t$,
  explanation = $t$Drug development is a multi-stage process spanning 10-15 years and costing ~$1-2 billion. Key challenges include: chemical optimisation to improve druglikeness (solubility, stability, absorption); pre-clinical safety studies that may not predict human toxicity; recruiting sufficient patients for trials; meeting increasingly stringent regulatory evidence requirements; and demonstrating superiority to existing treatments. For antibiotics, these challenges are compounded by the economics problem.$t$
WHERE id = 1595
  AND option_c = $t$Stages: hit identification (confirm in vitro activity); lead optimisation (chemical modification to improve potency, selectivity, pharmacokinetics); pre-clinical testing (cell cultures and animals — safety, toxicology, ADME); Phase I-III clinical trials (safety, dosage, efficacy in humans); regulatory review and approval. Challenges at each stage include: structure-activity relationships (lead optimisation); animal-to-human translation; patient recruitment; regulatory requirements; and the high financial investment required (approx $1–2 billion over 10–15 years)$t$
  AND explanation = $t$Drug development is a multi-stage process spanning 10–15 years and costing ~$1–2 billion. Key challenges include: chemical optimisation to improve druglikeness (solubility, stability, absorption); pre-clinical safety studies that may not predict human toxicity; recruiting sufficient patients for trials; meeting increasingly stringent regulatory evidence requirements; and demonstrating superiority to existing treatments. For antibiotics, these challenges are compounded by the economics problem.$t$;

UPDATE questions SET
  option_a = $t$Simply test more soil samples using the same methods as the 1950s$t$
WHERE id = 1602
  AND option_a = $t$Simply test more soil samples using the same methods as the \(1950s\)$t$;

UPDATE questions SET
  question_text = $t$Explain how immune checkpoint inhibitors (monoclonal antibodies against PD-1 or PD-L1) differ mechanistically from conventional monoclonal antibody cancer therapies.$t$,
  option_d = $t$Conventional cancer mAbs directly target tumour antigens (blocking receptors or delivering payloads). Checkpoint inhibitors instead target components of the immune regulatory system — blocking the PD-1/PD-L1 interaction that cancer cells use to suppress T cell activity. This releases the brakes on cytotoxic T cells, allowing them to attack the tumour. The drug does not directly bind the cancer cell but instead enhances the patient immune response$t$,
  explanation = $t$The mechanistic distinction is important: direct-targeting mAbs (e.g. trastuzumab, cetuximab) bind to antigens on tumour cells themselves, blocking survival signals or marking cells for immune destruction. Checkpoint inhibitors (e.g. pembrolizumab against PD-1, atezolizumab against PD-L1) do not bind tumour cells directly but instead neutralise immune inhibitory signals, unleashing the patient endogenous T cell response against the tumour. This is a fundamentally different approach to cancer immunotherapy.$t$
WHERE id = 1616
  AND question_text = $t$Explain how immune checkpoint inhibitors (monoclonal antibodies against \(PD - 1\) or \(PD - L1\)) differ mechanistically from conventional monoclonal antibody cancer therapies.$t$
  AND option_d = $t$Conventional cancer mAbs directly target tumour antigens (blocking receptors or delivering payloads). Checkpoint inhibitors instead target components of the immune regulatory system — blocking the \(PD - \frac{1}{PD} - L1\) interaction that cancer cells use to suppress T cell activity. This releases the brakes on cytotoxic T cells, allowing them to attack the tumour. The drug does not directly bind the cancer cell but instead enhances the patient immune response$t$
  AND explanation = $t$The mechanistic distinction is important: direct-targeting mAbs (e.g. trastuzumab, cetuximab) bind to antigens on tumour cells themselves, blocking survival signals or marking cells for immune destruction. Checkpoint inhibitors (e.g. pembrolizumab against \(PD - 1\), atezolizumab against \(PD - L1\)) do not bind tumour cells directly but instead neutralise immune inhibitory signals, unleashing the patient endogenous T cell response against the tumour. This is a fundamentally different approach to cancer immunotherapy.$t$;

UPDATE questions SET
  question_text = $t$CAR-T cell therapy involves engineering a patient own T cells to express a chimeric antigen receptor (CAR) that recognises cancer cell antigens. How does this relate to monoclonal antibody technology?$t$,
  option_a = $t$CAR-T therapy has no relationship to monoclonal antibody technology$t$,
  option_b = $t$CAR-T therapy uses monoclonal antibodies to destroy T cells$t$,
  option_c = $t$The antigen-binding domain of the CAR is typically derived from a monoclonal antibody (specifically the single-chain variable fragment, scFv, consisting of the antibody variable regions). This domain is fused to T cell signalling domains, creating a receptor that combines antibody-like specificity with T cell killing machinery. CAR-T therapy therefore directly builds upon monoclonal antibody technology$t$,
  option_d = $t$CAR-T therapy replaces monoclonal antibodies with conventional vaccines$t$,
  explanation = $t$CAR-T cell therapy elegantly combines mAb specificity with T cell effector function. The extracellular antigen-binding domain is derived from a mAb (as scFv), providing the tumour-targeting specificity. This is fused to transmembrane and intracellular T cell activation domains (CD3 zeta, CD28, or 4-1BB). When the scFv binds its tumour antigen, the T cell is activated and kills the target cell. This represents the convergence of antibody engineering and cellular immunotherapy.$t$
WHERE id = 1619
  AND question_text = $t$\(CAR - T\) cell therapy involves engineering a patient own T cells to express a chimeric antigen receptor (CAR) that recognises cancer cell antigens. How does this relate to monoclonal antibody technology?$t$
  AND option_a = $t$\(CAR - T\) therapy has no relationship to monoclonal antibody technology$t$
  AND option_b = $t$\(CAR - T\) therapy uses monoclonal antibodies to destroy T cells$t$
  AND option_c = $t$The antigen-binding domain of the CAR is typically derived from a monoclonal antibody (specifically the single-chain variable fragment, scFv, consisting of the antibody variable regions). This domain is fused to T cell signalling domains, creating a receptor that combines antibody-like specificity with T cell killing machinery. \(CAR - T\) therapy therefore directly builds upon monoclonal antibody technology$t$
  AND option_d = $t$\(CAR - T\) therapy replaces monoclonal antibodies with conventional vaccines$t$
  AND explanation = $t$\(CAR - T\) cell therapy elegantly combines mAb specificity with T cell effector function. The extracellular antigen-binding domain is derived from a mAb (as scFv), providing the tumour-targeting specificity. This is fused to transmembrane and intracellular T cell activation domains (CD3 zeta, CD28, or 4–1BB). When the scFv binds its tumour antigen, the T cell is activated and kills the target cell. This represents the convergence of antibody engineering and cellular immunotherapy.$t$;

UPDATE questions SET
  explanation = $t$Despite revolutionary impact on some cancers, mAb therapy faces genuine challenges: target antigen expression is required (not universal); tumour heterogeneity means subclones lacking the antigen survive; antigens can be shed or downregulated under selection pressure; solid tumours create immunosuppressive microenvironments and physical barriers to antibody penetration; and the cost (~$100,000+ per year) limits access globally. Research into bispecific antibodies, ADCs, and combination strategies aims to address these limitations.$t$
WHERE id = 1620
  AND explanation = $t$Despite revolutionary impact on some cancers, mAb therapy faces genuine challenges: target antigen expression is required (not universal); tumour heterogeneity means subclones lacking the antigen survive; antigens can be shed or downregulated under selection pressure; solid tumours create immunosuppressive microenvironments and physical barriers to antibody penetration; and the cost (~$\(100\,000 + per\) year) limits access globally. Research into bispecific antibodies, ADCs, and combination strategies aims to address these limitations.$t$;

UPDATE questions SET
  option_d = $t$Phage display technology was replaced by hybridoma technology in the 1990s$t$
WHERE id = 1621
  AND option_d = $t$Phage display technology was replaced by hybridoma technology in the \(1990s\)$t$;

UPDATE questions SET
  option_d = $t$Bispecific antibodies can simultaneously bind a cancer cell antigen and a T cell activating receptor (e.g. CD3), physically bringing cytotoxic T cells into direct contact with cancer cells regardless of T cell receptor specificity — bypassing the need for tumour-specific T cells. Alternatively, they can block two different signalling pathways simultaneously (e.g. two growth factor receptors) overcoming single-target resistance. Examples include blinatumomab (CD19 x CD3) for B cell leukaemia$t$
WHERE id = 1622
  AND option_d = $t$Bispecific antibodies can simultaneously bind a cancer cell antigen and a T cell activating receptor (e.g. CD3), physically bringing cytotoxic T cells into direct contact with cancer cells regardless of T cell receptor specificity — bypassing the need for tumour-specific T cells. Alternatively, they can block two different signalling pathways simultaneously (e.g. two growth factor receptors) overcoming single-target resistance. Examples include blinatumomab (CD19 \(x\) CD3) for B cell leukaemia$t$;

UPDATE questions SET
  explanation = $t$Several mechanisms cause side effects from mAb therapy: cytokine release syndrome (CRS) occurs when many cancer cells are killed simultaneously, releasing DAMPs and triggering immune activation. Immune effector functions (ADCC, CDC) activated by some mAbs also cause inflammatory mediator release. In severe cases (especially with CAR-T therapy), CRS can be life-threatening, requiring treatment with tocilizumab (an anti-IL-6 mAb — ironically also a mAb).$t$
WHERE id = 1627
  AND explanation = $t$Several mechanisms cause side effects from mAb therapy: cytokine release syndrome (CRS) occurs when many cancer cells are killed simultaneously, releasing DAMPs and triggering immune activation. Immune effector functions (ADCC, CDC) activated by some mAbs also cause inflammatory mediator release. In severe cases (especially with \(CAR - T\) therapy), CRS can be life-threatening, requiring treatment with tocilizumab (an anti\(- IL - 6\) mAb — ironically also a mAb).$t$;

UPDATE questions SET
  option_b = $t$The suffix -mab identifies the drug as a monoclonal antibody. Additional syllables indicate the source (o = mouse, xi = chimaeric, zu = humanised, u = fully human) and the target category (li = immunological, tu = tumour, ci = circulatory). For example, trastuzumab: tras = brand syllable, tu = tumour, zu = humanised, mab = monoclonal antibody$t$,
  explanation = $t$WHO international nonproprietary names (INNs) for mAbs follow a structured convention. The -mab suffix identifies the drug class. Preceding syllables encode: substem -o- (murine), -xi- (chimaeric), -zu- (humanised), -u- (human); and target: -li- (immune system), -tu- (tumour), -ci- (cardiovascular), -os- (bone). This allows healthcare professionals to quickly identify the nature and origin of a biologic drug from its name alone.$t$
WHERE id = 1628
  AND option_b = $t$The suffix -mab identifies the drug as a monoclonal antibody. Additional syllables indicate the source (\(o\) = mouse, xi = chimaeric, zu = humanised, \(u\)= fully human) and the target category (li = immunological, tu = tumour, ci = circulatory). For example, trastuzumab: tras = brand syllable, tu = tumour, zu = humanised, mab = monoclonal antibody$t$
  AND explanation = $t$WHO international nonproprietary names (INNs) for mAbs follow a structured convention. The -mab suffix identifies the drug class. Preceding syllables encode: substem \(- o -\) (murine), -xi- (chimaeric), -zu- (humanised), \(- u -\) (human); and target: -li- (immune system), -tu- (tumour), -ci- (cardiovascular), -os- (bone). This allows healthcare professionals to quickly identify the nature and origin of a biologic drug from its name alone.$t$;

UPDATE questions SET
  option_a = $t$By targeting and neutralising specific inflammatory mediators (e.g. TNF-alpha, IL-6) or immune cell surface proteins that drive the damaging immune response, reducing inflammation without broadly suppressing the entire immune system$t$,
  explanation = $t$In rheumatoid arthritis, TNF-alpha is a key cytokine driving chronic synovial inflammation. Anti-TNF mAbs (e.g. adalimumab, infliximab) neutralise TNF-alpha, blocking downstream inflammatory cascades. This targeted approach reduces joint inflammation and damage with fewer systemic side effects than conventional immunosuppressants. Similar targeted approaches exist for IL-6 (tocilizumab), IL-17 (secukinumab) and others.$t$
WHERE id = 1629
  AND option_a = $t$By targeting and neutralising specific inflammatory mediators (e.g. TNF-alpha, \(IL - 6\)) or immune cell surface proteins that drive the damaging immune response, reducing inflammation without broadly suppressing the entire immune system$t$
  AND explanation = $t$In rheumatoid arthritis, TNF-alpha is a key cytokine driving chronic synovial inflammation. Anti-TNF mAbs (e.g. adalimumab, infliximab) neutralise TNF-alpha, blocking downstream inflammatory cascades. This targeted approach reduces joint inflammation and damage with fewer systemic side effects than conventional immunosuppressants. Similar targeted approaches exist for \(IL - 6\) (tocilizumab), \(IL - 17\) (secukinumab) and others.$t$;

UPDATE questions SET
  explanation = $t$The Fc region of IgG antibodies engages multiple immune effector mechanisms via Fc receptors: ADCC (NK cells kill antibody-coated targets via Fc-gamma-RIII/CD16); ADCP (macrophages phagocytose Fc-coated targets); and complement activation (via C1q binding to Fc). Many therapeutic cancer mAbs rely heavily on these Fc-mediated mechanisms for efficacy. Therapeutic antibodies are often engineered to enhance Fc-FcR interactions, improving anti-tumour activity.$t$
WHERE id = 1631
  AND explanation = $t$The Fc region of IgG antibodies engages multiple immune effector mechanisms via Fc receptors: ADCC (NK cells kill antibody-coated targets via Fc-gamma-RIII/CD16); ADCP (macrophages phagocytose Fc-coated targets); and complement activation (via C\(1q\) binding to Fc). Many therapeutic cancer mAbs rely heavily on these Fc-mediated mechanisms for efficacy. Therapeutic antibodies are often engineered to enhance Fc-FcR interactions, improving anti-tumour activity.$t$;

UPDATE questions SET
  question_text = $t$The TGN1412 trial in 2006 involved six healthy volunteers who suffered life-threatening cytokine release syndrome after receiving a monoclonal antibody that was a CD28 superagonist. Explain why this occurred and what this taught us about first-in-human trials.$t$,
  explanation = $t$TGN1412 was a CD28 superagonist designed to stimulate Tregs. In preclinical tests (rats, cynomolgus monkeys) at 500x the human dose, no cytokine storm occurred — because monkey CD28 expression on effector T cells differs from humans. At 1/500th the no-effect animal dose in humans, all six volunteers developed catastrophic cytokine storms requiring ITU admission. This tragedy demonstrated the species-specificity problem and led to MABEL (Minimum Anticipated Biological Effect Level) dosing and sequential rather than simultaneous dosing of volunteers.$t$
WHERE id = 1633
  AND question_text = $t$The TGN1412 trial in 2006 involved six healthy volunteers who suffered life-threatening cytokine release syndrome after receiving a monoclonal antibody that was \(a\) CD28 superagonist. Explain why this occurred and what this taught us about first-in-human trials.$t$
  AND explanation = $t$TGN1412 was \(a\) CD28 superagonist designed to stimulate Tregs. In preclinical tests (rats, cynomolgus monkeys) at 500× the human dose, no cytokine storm occurred — because monkey CD28 expression on effector T cells differs from humans. At 1/500th the no-effect animal dose in humans, all six volunteers developed catastrophic cytokine storms requiring ITU admission. This tragedy demonstrated the species-specificity problem and led to MABEL (Minimum Anticipated Biological Effect Level) dosing and sequential rather than simultaneous dosing of volunteers.$t$;

UPDATE questions SET
  question_text = $t$Describe how CRISPR-Cas9 technology could be used to improve the efficacy of CAR-T cell therapy.$t$,
  option_a = $t$CRISPR could be used to: knock out endogenous T cell receptors (preventing GvHD in allogeneic CAR-T); knock out PD-1 and other checkpoint molecules (preventing T cell exhaustion in the immunosuppressive tumour microenvironment); integrate the CAR construct into a specific safe-harbour locus; knock out MHC class I expression (reducing rejection of allogeneic cells); and delete TET2 (enhancing T cell persistence)$t$,
  option_c = $t$CRISPR would destroy the CAR-T cells completely$t$,
  explanation = $t$CRISPR has transformed CAR-T engineering possibilities: 1) TRAC locus integration of CAR improves expression and reduces variability; 2) PDCD1 (PD-1) knockout prevents tumour microenvironment-mediated T cell exhaustion; 3) TCR alpha/beta knockout enables allogeneic (off-the-shelf) CAR-T by preventing GvHD; 4) B2M knockout reduces alloreactive rejection. The Milone, June and other groups have demonstrated combinations of these edits producing CAR-T cells with dramatically enhanced in vivo performance.$t$
WHERE id = 1635
  AND question_text = $t$Describe how CRISPR-Cas9 technology could be used to improve the efficacy of \(CAR - T\) cell therapy.$t$
  AND option_a = $t$CRISPR could be used to: knock out endogenous T cell receptors (preventing GvHD in allogeneic \(CAR - T\)); knock out \(PD - 1\) and other checkpoint molecules (preventing T cell exhaustion in the immunosuppressive tumour microenvironment); integrate the CAR construct into a specific safe-harbour locus; knock out MHC class I expression (reducing rejection of allogeneic cells); and delete TET2 (enhancing T cell persistence)$t$
  AND option_c = $t$CRISPR would destroy the \(CAR - T\) cells completely$t$
  AND explanation = $t$CRISPR has transformed \(CAR - T\) engineering possibilities: 1) TRAC locus integration of CAR improves expression and reduces variability; 2) PDCD1 \((PD - 1)\) knockout prevents tumour microenvironment-mediated T cell exhaustion; 3) TCR alpha/beta knockout enables allogeneic (off-the-shelf) \(CAR - T\) by preventing GvHD; 4) B\(2M\) knockout reduces alloreactive rejection. The Milone, June and other groups have demonstrated combinations of these edits producing \(CAR - T\) cells with dramatically enhanced in vivo performance.$t$;

UPDATE questions SET
  option_b = $t$Initial response occurs because blocking PD-1/PD-L1 releases suppressed T cells to attack the tumour. Resistance can develop through: tumour mutation burden decreasing (fewer neoantigens to target); loss of MHC class I expression (T cells cannot recognise tumour cells without MHC); upregulation of alternative immune checkpoints (LAG-3, TIM-3, TIGIT); exclusion of T cells from the tumour microenvironment; and tumour immunoediting (selection of poorly immunogenic clones)$t$,
  explanation = $t$Checkpoint inhibitor resistance is an active research area. Primary resistance (no initial response) reflects immunological desert tumours (insufficient T cells or antigens). Acquired resistance (initial response then relapse) involves multiple mechanisms: MHC loss (tumour becomes invisible to T cells); alternative checkpoint upregulation (tumour adapts to PD-1 blockade by using other inhibitory signals); and immunoediting (T cell selection pressure removes immunogenic tumour clones, leaving immunologically invisible cells). Combination checkpoint blockade (anti-PD-1 + anti-CTLA-4) and bispecific antibodies address some resistance mechanisms.$t$
WHERE id = 1637
  AND option_b = $t$Initial response occurs because blocking \(PD - \frac{1}{PD} - L1\) releases suppressed T cells to attack the tumour. Resistance can develop through: tumour mutation burden decreasing (fewer neoantigens to target); loss of MHC class I expression (T cells cannot recognise tumour cells without MHC); upregulation of alternative immune checkpoints (LAG-3, TIM-3, TIGIT); exclusion of T cells from the tumour microenvironment; and tumour immunoediting (selection of poorly immunogenic clones)$t$
  AND explanation = $t$Checkpoint inhibitor resistance is an active research area. Primary resistance (no initial response) reflects immunological desert tumours (insufficient T cells or antigens). Acquired resistance (initial response then relapse) involves multiple mechanisms: MHC loss (tumour becomes invisible to T cells); alternative checkpoint upregulation (tumour adapts to \(PD - 1\) blockade by using other inhibitory signals); and immunoediting (T cell selection pressure removes immunogenic tumour clones, leaving immunologically invisible cells). Combination checkpoint blockade (anti\(- PD - 1\)+ anti-CTLA-4) and bispecific antibodies address some resistance mechanisms.$t$;

UPDATE questions SET
  option_c = $t$Biological production (cell culture, purification, cold chain) makes mAbs inherently expensive (~$10,000-300,000 per year). LMICs face additional barriers: healthcare infrastructure costs for administration and monitoring; lack of cold chain logistics; patent protection preventing biosimilar production; regulatory capacity limitations; and currency/economic barriers. Biosimilar mAbs, technology transfer partnerships, and differential pricing could improve access, but fundamental production cost remains a barrier$t$,
  explanation = $t$The cost of mAb therapy reflects genuine production complexity (mammalian cell expression, extensive purification, quality control) plus R&D recovery and profit margins. In LMICs, treatment costs often exceed annual per capita GDP. Solutions require: biosimilar development (which reduces costs by 20-50% at best); technology transfer and local manufacturing capacity; tiered pricing (companies charging less in LMICs); and pooled procurement. Even with these measures, some mAbs remain unaffordable for most LMIC health systems, representing a significant equity challenge.$t$
WHERE id = 1639
  AND option_c = $t$Biological production (cell culture, purification, cold chain) makes mAbs inherently expensive (~$\(10\,000 - 300\,000\) per year). LMICs face additional barriers: healthcare infrastructure costs for administration and monitoring; lack of cold chain logistics; patent protection preventing biosimilar production; regulatory capacity limitations; and currency/economic barriers. Biosimilar mAbs, technology transfer partnerships, and differential pricing could improve access, but fundamental production cost remains a barrier$t$
  AND explanation = $t$The cost of mAb therapy reflects genuine production complexity (mammalian cell expression, extensive purification, quality control) plus R&D recovery and profit margins. In LMICs, treatment costs often exceed annual per capita GDP. Solutions require: biosimilar development (which reduces costs by 20–50% at best); technology transfer and local manufacturing capacity; tiered pricing (companies charging less in LMICs); and pooled procurement. Even with these measures, some mAbs remain unaffordable for most LMIC health systems, representing a significant equity challenge.$t$;

UPDATE questions SET
  option_b = $t$Possible combinations include: using mAbs to deliver CRISPR-Cas9 components specifically to target cells (antibody-directed CRISPR delivery, avoiding off-target editing in non-target tissues); using CRISPR to knock out immune checkpoints in T cells that have been engineered to express CARs derived from mAb variable regions (improving CAR-T persistence); and using CRISPR to insert mAb-encoding genes into specific chromosomal loci for stable, high-level antibody production in bioreactor cell lines$t$,
  explanation = $t$The convergence of CRISPR and mAb technologies creates exciting possibilities: site-specific delivery of CRISPR using antibody targeting could reduce off-target gene editing; CRISPR-engineering of CAR-T cells improves their function using mAb-derived targeting; CRISPR-mediated knock-in of mAb genes into safe harbour loci creates stable cell lines for biomanufacturing. In vivo delivery of CRISPR using antibody-targeted nanoparticles is an emerging frontier for tissue-specific gene correction.$t$
WHERE id = 1641
  AND option_b = $t$Possible combinations include: using mAbs to deliver CRISPR-Cas9 components specifically to target cells (antibody-directed CRISPR delivery, avoiding off-target editing in non-target tissues); using CRISPR to knock out immune checkpoints in T cells that have been engineered to express CARs derived from mAb variable regions (improving \(CAR - T\) persistence); and using CRISPR to insert mAb-encoding genes into specific chromosomal loci for stable, high-level antibody production in bioreactor cell lines$t$
  AND explanation = $t$The convergence of CRISPR and mAb technologies creates exciting possibilities: site-specific delivery of CRISPR using antibody targeting could reduce off-target gene editing; CRISPR-engineering of \(CAR - T\) cells improves their function using mAb-derived targeting; CRISPR-mediated knock-in of mAb genes into safe harbour loci creates stable cell lines for biomanufacturing. In vivo delivery of CRISPR using antibody-targeted nanoparticles is an emerging frontier for tissue-specific gene correction.$t$;

UPDATE questions SET
  option_c = $t$In a genetically uniform monoculture, if one plant is susceptible to a pathogen, all plants are equally susceptible — there is no genetic diversity to limit spread. Pathogens can spread rapidly through the uniform population. This is in contrast to genetically diverse populations where some individuals may be resistant. The Irish Potato Famine (1845-49) is a historical example: the uniform Lumper variety was devastated by the oomycete Phytophthora infestans$t$
WHERE id = 1656
  AND option_c = $t$In a genetically uniform monoculture, if one plant is susceptible to a pathogen, all plants are equally susceptible — there is no genetic diversity to limit spread. Pathogens can spread rapidly through the uniform population. This is in contrast to genetically diverse populations where some individuals may be resistant. The Irish Potato Famine \((1845 - 49)\) is a historical example: the uniform Lumper variety was devastated by the oomycete Phytophthora infestans$t$;

UPDATE questions SET
  explanation = $t$Chitinase (pathogenesis-related protein PR-3) is produced by plants in response to fungal attack. Chitin is a major structural component of fungal (and insect) cell walls but is absent from plant cells. Chitinase therefore cleaves fungal cell walls without harming the plant. Additionally, the chitin oligomers released by chitinase digestion are recognised by plant PRRs (CERK1), amplifying and prolonging the immune response.$t$
WHERE id = 1657
  AND explanation = $t$Chitinase (pathogenesis-related protein \(PR - 3\)) is produced by plants in response to fungal attack. Chitin is a major structural component of fungal (and insect) cell walls but is absent from plant cells. Chitinase therefore cleaves fungal cell walls without harming the plant. Additionally, the chitin oligomers released by chitinase digestion are recognised by plant PRRs (CERK1), amplifying and prolonging the immune response.$t$;

UPDATE questions SET
  explanation = $t$The economic impact of plant disease extends well beyond lost yield. Additional costs: chemical control (fungicides, bactericides, pesticides); labour and monitoring; regulatory compliance (quarantine, testing for export markets); mycotoxin contamination can render entire crops unsaleable even if yield loss is modest; emergency variety replacement programmes; and downstream effects on food processors and traders. FAO estimates that plant diseases cause 10-40% of global crop losses annually, with disproportionate impacts on food security in developing countries.$t$
WHERE id = 1672
  AND explanation = $t$The economic impact of plant disease extends well beyond lost yield. Additional costs: chemical control (fungicides, bactericides, pesticides); labour and monitoring; regulatory compliance (quarantine, testing for export markets); mycotoxin contamination can render entire crops unsaleable even if yield loss is modest; emergency variety replacement programmes; and downstream effects on food processors and traders. FAO estimates that plant diseases cause 10–40% of global crop losses annually, with disproportionate impacts on food security in developing countries.$t$;

UPDATE questions SET
  explanation = $t$Gene-for-gene coevolution creates a continuous arms race. The deployment of a resistant crop variety (boom) applies intense directional selection on the pathogen population to evolve virulence (ability to overcome R gene resistance). When a resistance-breaking strain arises (bust), it rapidly sweeps through the uniform crop population. Major examples: wheat rust races overcoming successive resistance genes within 5-15 years. Solutions involve stacking multiple R genes (pyramiding), deploying gene diversity (multiline varieties), and identifying durable resistance (partial resistance controlled by many QTLs is harder to overcome than single R gene resistance).$t$
WHERE id = 1673
  AND explanation = $t$Gene-for-gene coevolution creates a continuous arms race. The deployment of a resistant crop variety (boom) applies intense directional selection on the pathogen population to evolve virulence (ability to overcome R gene resistance). When a resistance-breaking strain arises (bust), it rapidly sweeps through the uniform crop population. Major examples: wheat rust races overcoming successive resistance genes within 5–15 years. Solutions involve stacking multiple R genes (pyramiding), deploying gene diversity (multiline varieties), and identifying durable resistance (partial resistance controlled by many QTLs is harder to overcome than single R gene resistance).$t$;

UPDATE questions SET
  explanation = $t$The emergence of new pathogen strains (or the arrival of existing strains in new territories) creates asymmetric vulnerabilities: local crop germplasm has co-evolved resistance to local pathogen strains but is naive to new strains. Wheat blast emerged from a host jump of rice blast Magnaporthe to wheat in Brazil in the 1980s, spread to South Asia in 2016, and Africa in 2018. Each appearance required emergency response — rapid pathotype characterisation, screening of resistance sources, and emergency variety deployment. Climate change is facilitating range expansion of many plant pathogens.$t$
WHERE id = 1675
  AND explanation = $t$The emergence of new pathogen strains (or the arrival of existing strains in new territories) creates asymmetric vulnerabilities: local crop germplasm has co-evolved resistance to local pathogen strains but is naive to new strains. Wheat blast emerged from a host jump of rice blast Magnaporthe to wheat in Brazil in the \(1980s\), spread to South Asia in 2016, and Africa in 2018. Each appearance required emergency response — rapid pathotype characterisation, screening of resistance sources, and emergency variety deployment. Climate change is facilitating range expansion of many plant pathogens.$t$;

UPDATE questions SET
  question_text = $t$Fusarium wilt (caused by Fusarium oxysporum) destroyed the commercial Gros Michel banana variety in the 1950s-60s, leading to its replacement by the Cavendish banana. The same disease (Tropical Race 4, a new Fusarium strain) now threatens the Cavendish. Evaluate what this case study teaches us about sustainable crop protection strategy.$t$
WHERE id = 1682
  AND question_text = $t$Fusarium wilt (caused by Fusarium oxysporum) destroyed the commercial Gros Michel banana variety in the \(1950s - 60s\), leading to its replacement by the Cavendish banana. The same disease (Tropical Race 4, a new Fusarium strain) now threatens the Cavendish. Evaluate what this case study teaches us about sustainable crop protection strategy.$t$;

UPDATE questions SET
  explanation = $t$During exercise muscles respire more rapidly and need more oxygen. They also produce more carbon dioxide. Increased breathing rate supplies extra oxygen and removes extra CO2 more rapidly.$t$
WHERE id = 1683
  AND explanation = $t$During exercise muscles respire more rapidly and need more oxygen. They also produce more carbon dioxide. Increased breathing rate supplies extra oxygen and removes extra CO₂ more rapidly.$t$;

UPDATE questions SET
  explanation = $t$Anaerobic respiration in muscle cells: glucose produces lactic acid. No oxygen is used. This yields approximately 2 ATP per glucose compared to approximately 36-38 ATP from aerobic respiration because glucose is only partially broken down.$t$
WHERE id = 1694
  AND explanation = $t$Anaerobic respiration in muscle cells: glucose produces lactic acid. No oxygen is used. This yields approximately 2 ATP per glucose compared to approximately 36–38 ATP from aerobic respiration because glucose is only partially broken down.$t$;

UPDATE questions SET
  explanation = $t$Aerobic training adaptations in muscle: increased mitochondrial number and size, increased capillary density improving O2 extraction, increased myoglobin, and increased oxidative enzyme activity. Together these allow higher oxygen utilisation delaying lactic acid accumulation.$t$
WHERE id = 1695
  AND explanation = $t$Aerobic training adaptations in muscle: increased mitochondrial number and size, increased capillary density improving O₂ extraction, increased myoglobin, and increased oxidative enzyme activity. Together these allow higher oxygen utilisation delaying lactic acid accumulation.$t$;

UPDATE questions SET
  option_b = $t$Creatine phosphate rapidly donates its phosphate group to ADP to regenerate ATP providing immediate energy for muscle contraction in the first 8-10 seconds before aerobic or anaerobic respiration can meet demand. It is then replenished during recovery$t$,
  explanation = $t$The phosphocreatine system is the fastest ATP regeneration pathway: creatine phosphate plus ADP produces creatine plus ATP. Stores are depleted in roughly 8-10 seconds of maximal effort but allow immediate rapid ATP regeneration before glycolysis can fully respond.$t$
WHERE id = 1696
  AND option_b = $t$Creatine phosphate rapidly donates its phosphate group to ADP to regenerate ATP providing immediate energy for muscle contraction in the first 8–10 seconds before aerobic or anaerobic respiration can meet demand. It is then replenished during recovery$t$
  AND explanation = $t$The phosphocreatine system is the fastest ATP regeneration pathway: creatine phosphate plus ADP produces creatine plus ATP. Stores are depleted in roughly 8–10 seconds of maximal effort but allow immediate rapid ATP regeneration before glycolysis can fully respond.$t$;

UPDATE questions SET
  question_text = $t$How does the body detect increased blood CO2 during exercise and trigger increased breathing?$t$,
  option_a = $t$Chemoreceptors in the medulla oblongata and carotid and aortic bodies detect the fall in blood pH caused by increased dissolved CO2. They send signals to the respiratory centre in the medulla which increases rate and depth of breathing to expel excess CO2 and restore blood pH$t$,
  option_c = $t$The lungs directly detect CO2 and expand automatically$t$,
  option_d = $t$Oxygen receptors in blood detect low O2 and trigger faster breathing$t$,
  explanation = $t$Blood CO2 dissolves to form carbonic acid which dissociates to H+ and bicarbonate lowering blood pH. Central and peripheral chemoreceptors detect this pH fall. They stimulate the respiratory centre to increase breathing rate and depth increasing CO2 expiration and restoring blood pH.$t$
WHERE id = 1697
  AND question_text = $t$How does the body detect increased blood CO₂ during exercise and trigger increased breathing?$t$
  AND option_a = $t$Chemoreceptors in the medulla oblongata and carotid and aortic bodies detect the fall in blood pH caused by increased dissolved CO₂. They send signals to the respiratory centre in the medulla which increases rate and depth of breathing to expel excess CO₂ and restore blood pH$t$
  AND option_c = $t$The lungs directly detect CO₂ and expand automatically$t$
  AND option_d = $t$Oxygen receptors in blood detect low O₂ and trigger faster breathing$t$
  AND explanation = $t$Blood CO₂ dissolves to form carbonic acid which dissociates to H⁺ and bicarbonate lowering blood pH. Central and peripheral chemoreceptors detect this pH fall. They stimulate the respiratory centre to increase breathing rate and depth increasing CO₂ expiration and restoring blood pH.$t$;

UPDATE questions SET
  option_a = $t$Myoglobin transports CO2 out of muscle cells$t$,
  explanation = $t$Myoglobin has higher oxygen affinity than haemoglobin and functions as a short-term oxygen store in muscle. During intense contractions when local O2 falls sharply myoglobin releases its oxygen to mitochondria buffering the transition between aerobic and anaerobic respiration.$t$
WHERE id = 1700
  AND option_a = $t$Myoglobin transports CO₂ out of muscle cells$t$
  AND explanation = $t$Myoglobin has higher oxygen affinity than haemoglobin and functions as a short-term oxygen store in muscle. During intense contractions when local O₂ falls sharply myoglobin releases its oxygen to mitochondria buffering the transition between aerobic and anaerobic respiration.$t$;

UPDATE questions SET
  option_d = $t$Phosphocreatine: fastest ATP production but very limited capacity around 8-10 seconds. Anaerobic glycolysis: rapid around 2 ATP per glucose but causes lactic acid and limited to around 60-90 seconds of maximal effort. Aerobic respiration: slowest to fully activate but highest yield around 36-38 ATP per glucose and can be sustained for hours if fuel is available$t$
WHERE id = 1701
  AND option_d = $t$Phosphocreatine: fastest ATP production but very limited capacity around 8–10 seconds. Anaerobic glycolysis: rapid around 2 ATP per glucose but causes lactic acid and limited to around 60–90 seconds of maximal effort. Aerobic respiration: slowest to fully activate but highest yield around 36–38 ATP per glucose and can be sustained for hours if fuel is available$t$;

UPDATE questions SET
  explanation = $t$Athletic bradycardia: endurance training increases left ventricular size and contractility increasing stroke volume. At rest cardiac output requirements are similar regardless of fitness (around 5L per minute). If stroke volume increases heart rate must decrease proportionally to maintain the same output. Elite endurance athletes can have resting heart rates of 28-40 bpm.$t$
WHERE id = 1702
  AND explanation = $t$Athletic bradycardia: endurance training increases left ventricular size and contractility increasing stroke volume. At rest cardiac output requirements are similar regardless of fitness (around \(5L\) per minute). If stroke volume increases heart rate must decrease proportionally to maintain the same output. Elite endurance athletes can have resting heart rates of 28–40 bpm.$t$;

UPDATE questions SET
  explanation = $t$Muscles can use aerobic respiration (glucose plus oxygen produces CO2 plus water plus energy) when oxygen supply is sufficient or anaerobic respiration (glucose produces lactic acid plus small amount of energy) when oxygen supply is insufficient for the exercise intensity.$t$
WHERE id = 1703
  AND explanation = $t$Muscles can use aerobic respiration (glucose plus oxygen produces CO₂ plus water plus energy) when oxygen supply is sufficient or anaerobic respiration (glucose produces lactic acid plus small amount of energy) when oxygen supply is insufficient for the exercise intensity.$t$;

UPDATE questions SET
  question_text = $t$What happens to CO2 concentration in the blood during intense exercise?$t$,
  option_a = $t$CO2 concentration decreases because muscles stop producing it$t$,
  option_b = $t$CO2 concentration increases because muscles produce more CO2 as they respire more rapidly to meet energy demands$t$,
  option_c = $t$CO2 concentration stays exactly the same throughout exercise$t$,
  option_d = $t$CO2 concentration first increases then returns to zero$t$,
  explanation = $t$Aerobic respiration produces CO2 as a waste product. During intense exercise respiration rates increase dramatically. CO2 production exceeds the rate at which it can be expelled temporarily raising blood CO2 concentration. This is detected by chemoreceptors and drives increased breathing rate.$t$
WHERE id = 1704
  AND question_text = $t$What happens to CO₂ concentration in the blood during intense exercise?$t$
  AND option_a = $t$CO₂ concentration decreases because muscles stop producing it$t$
  AND option_b = $t$CO₂ concentration increases because muscles produce more CO₂ as they respire more rapidly to meet energy demands$t$
  AND option_c = $t$CO₂ concentration stays exactly the same throughout exercise$t$
  AND option_d = $t$CO₂ concentration first increases then returns to zero$t$
  AND explanation = $t$Aerobic respiration produces CO₂ as a waste product. During intense exercise respiration rates increase dramatically. CO₂ production exceeds the rate at which it can be expelled temporarily raising blood CO₂ concentration. This is detected by chemoreceptors and drives increased breathing rate.$t$;

UPDATE questions SET
  question_text = $t$Why does a sprinter breathe heavily for several minutes after completing a 100m race?$t$,
  explanation = $t$The 100m sprint is almost entirely anaerobic. Large amounts of lactic acid accumulate. After finishing elevated breathing rate maintains elevated oxygen delivery to repay this oxygen debt by oxidising lactic acid and restoring energy stores.$t$
WHERE id = 1707
  AND question_text = $t$Why does a sprinter breathe heavily for several minutes after completing \(a 100m\) race?$t$
  AND explanation = $t$The \(100m\) sprint is almost entirely anaerobic. Large amounts of lactic acid accumulate. After finishing elevated breathing rate maintains elevated oxygen delivery to repay this oxygen debt by oxidising lactic acid and restoring energy stores.$t$;

UPDATE questions SET
  option_d = $t$A 400m race$t$,
  explanation = $t$Fat (triglycerides from adipose tissue) is the primary fuel for low to moderate intensity exercise lasting more than 20-30 minutes. Fat oxidation yields large amounts of ATP but is slower than carbohydrate metabolism and requires more oxygen per ATP produced.$t$
WHERE id = 1709
  AND option_d = $t$\(A 400m\) race$t$
  AND explanation = $t$Fat (triglycerides from adipose tissue) is the primary fuel for low to moderate intensity exercise lasting more than 20–30 minutes. Fat oxidation yields large amounts of ATP but is slower than carbohydrate metabolism and requires more oxygen per ATP produced.$t$;

UPDATE questions SET
  option_c = $t$Lactate accumulation is accompanied by H+ ion accumulation lowering intracellular pH. This inhibits key glycolytic enzymes such as phosphofructokinase and interferes with calcium release from the sarcoplasmic reticulum and calcium binding to troponin — impairing excitation-contraction coupling. Inorganic phosphate from ATP hydrolysis further inhibits myosin-actin cross-bridge formation. Together these reduce force production$t$,
  explanation = $t$Current understanding of fatigue is more nuanced than simply lactic acid causing pain. Low pH inhibits rate-limiting enzymes and disrupts Ca2+ handling. Inorganic phosphate accumulation reduces cross-bridge force. Reactive oxygen species and potassium ion imbalances also contribute. The popular narrative of lactic acid causing burning pain is an oversimplification.$t$
WHERE id = 1713
  AND option_c = $t$Lactate accumulation is accompanied by H⁺ ion accumulation lowering intracellular pH. This inhibits key glycolytic enzymes such as phosphofructokinase and interferes with calcium release from the sarcoplasmic reticulum and calcium binding to troponin — impairing excitation-contraction coupling. Inorganic phosphate from ATP hydrolysis further inhibits myosin-actin cross-bridge formation. Together these reduce force production$t$
  AND explanation = $t$Current understanding of fatigue is more nuanced than simply lactic acid causing pain. Low pH inhibits rate-limiting enzymes and disrupts Ca²⁺ handling. Inorganic phosphate accumulation reduces cross-bridge force. Reactive oxygen species and potassium ion imbalances also contribute. The popular narrative of lactic acid causing burning pain is an oversimplification.$t$;

UPDATE questions SET
  question_text = $t$Elite cyclists have VO2max values of around 80-90 ml/kg/min while sedentary individuals average around 35 ml/kg/min. Explain the physiological differences responsible.$t$,
  explanation = $t$VO2max is determined by the Fick equation: VO2max equals cardiac output multiplied by the arteriovenous oxygen difference. Cardiac adaptations (increased stroke volume) are the dominant training-induced improvement. Peripheral adaptations (capillarisation mitochondrial density) increase oxygen extraction. Genetic factors explain much of the elite-sedentary difference but training can improve VO2max by 15-25% in untrained individuals.$t$
WHERE id = 1714
  AND question_text = $t$Elite cyclists have VO2max values of around 80–90 ml/kg/min while sedentary individuals average around \(35 \frac{\,\text{ml}}{\,\text{kg/min}}\). Explain the physiological differences responsible.$t$
  AND explanation = $t$VO2max is determined by the Fick equation: VO2max equals cardiac output multiplied by the arteriovenous oxygen difference. Cardiac adaptations (increased stroke volume) are the dominant training-induced improvement. Peripheral adaptations (capillarisation mitochondrial density) increase oxygen extraction. Genetic factors explain much of the elite-sedentary difference but training can improve VO2max by 15–25% in untrained individuals.$t$;

UPDATE questions SET
  option_b = $t$At altitude lower partial pressure of O2 reduces haemoglobin saturation stimulating erythropoietin (EPO) release from the kidneys. EPO increases red blood cell production raising haemoglobin concentration and oxygen-carrying capacity. When the athlete returns to sea level the elevated haemoglobin means more oxygen can be delivered per unit of blood improving aerobic performance before haemoglobin normalises over several weeks$t$,
  explanation = $t$The live high train low model exploits altitude acclimatisation. Hypoxia stimulates HIF-1alpha which upregulates EPO. EPO stimulates erythropoiesis increasing red cell mass and haemoglobin. This haematological advantage persists for 3-4 weeks after return to sea level.$t$
WHERE id = 1715
  AND option_b = $t$At altitude lower partial pressure of O₂ reduces haemoglobin saturation stimulating erythropoietin (EPO) release from the kidneys. EPO increases red blood cell production raising haemoglobin concentration and oxygen-carrying capacity. When the athlete returns to sea level the elevated haemoglobin means more oxygen can be delivered per unit of blood improving aerobic performance before haemoglobin normalises over several weeks$t$
  AND explanation = $t$The live high train low model exploits altitude acclimatisation. Hypoxia stimulates \(HIF - 1\)alpha which upregulates EPO. EPO stimulates erythropoiesis increasing red cell mass and haemoglobin. This haematological advantage persists for 3–4 weeks after return to sea level.$t$;

UPDATE questions SET
  explanation = $t$EPO doping was widespread in cycling in the 1990s and contributed to numerous athlete deaths from thromboembolic events during sleep when resting heart rate allows blood to become very viscous. Raising haematocrit above 50-55% dramatically increases blood viscosity risking clot formation.$t$
WHERE id = 1717
  AND explanation = $t$EPO doping was widespread in cycling in the \(1990s\) and contributed to numerous athlete deaths from thromboembolic events during sleep when resting heart rate allows blood to become very viscous. Raising haematocrit above 50–55% dramatically increases blood viscosity risking clot formation.$t$;

UPDATE questions SET
  option_c = $t$High-intensity intervals stress the anaerobic systems and exceed the lactate threshold stimulating greater mitochondrial biogenesis via PGC-1alpha and EPOC improvements than steady-state training of similar duration. Recovery periods allow partial creatine phosphate restoration. The repeated lactate surges upregulate lactate transport and clearance enzymes. This produces both aerobic and anaerobic adaptations more time-efficiently than steady-state training alone$t$,
  explanation = $t$HIIT activates multiple physiological pathways simultaneously. The metabolic stress of intervals (elevated lactate AMP/ATP ratio) activates AMPK which triggers PGC-1alpha — the master regulator of mitochondrial biogenesis. Greater muscle recruitment during intervals stimulates more motor units. EPOC after intervals is larger than after steady-state exercise of the same duration.$t$
WHERE id = 1718
  AND option_c = $t$High-intensity intervals stress the anaerobic systems and exceed the lactate threshold stimulating greater mitochondrial biogenesis via \(PGC - 1\)alpha and EPOC improvements than steady-state training of similar duration. Recovery periods allow partial creatine phosphate restoration. The repeated lactate surges upregulate lactate transport and clearance enzymes. This produces both aerobic and anaerobic adaptations more time-efficiently than steady-state training alone$t$
  AND explanation = $t$HIIT activates multiple physiological pathways simultaneously. The metabolic stress of intervals (elevated lactate AMP/ATP ratio) activates AMPK which triggers \(PGC - 1\)alpha — the master regulator of mitochondrial biogenesis. Greater muscle recruitment during intervals stimulates more motor units. EPOC after intervals is larger than after steady-state exercise of the same duration.$t$;

UPDATE questions SET
  option_b = $t$During eccentric contractions active muscle fibres are forcibly lengthened generating high tensile forces that exceed sarcomere structural capacity. This causes micro-tears in sarcomeres and surrounding connective tissue releasing inflammatory mediators that sensitise nociceptors 24-72 hours later. Concentric contractions at equivalent loads generate lower peak tensile stress and less structural damage$t$,
  explanation = $t$DOMS is an inflammatory response to exercise-induced muscle damage not lactic acid (which clears within 1-2 hours). Eccentric contractions produce extremely high tensile forces in individual sarcomeres as they are stretched particularly at the Z-disc. This disrupts sarcomere structure and triggers an acute inflammatory response peaking 24-72 hours post-exercise.$t$
WHERE id = 1721
  AND option_b = $t$During eccentric contractions active muscle fibres are forcibly lengthened generating high tensile forces that exceed sarcomere structural capacity. This causes micro-tears in sarcomeres and surrounding connective tissue releasing inflammatory mediators that sensitise nociceptors 24–72 hours later. Concentric contractions at equivalent loads generate lower peak tensile stress and less structural damage$t$
  AND explanation = $t$DOMS is an inflammatory response to exercise-induced muscle damage not lactic acid (which clears within 1–2 hours). Eccentric contractions produce extremely high tensile forces in individual sarcomeres as they are stretched particularly at the Z-disc. This disrupts sarcomere structure and triggers an acute inflammatory response peaking 24–72 hours post-exercise.$t$;

UPDATE questions SET
  option_a = $t$The marathon runner would show: higher mitochondrial density (supporting sustained aerobic ATP production), higher capillary density (improving O2 delivery), predominantly Type I slow-twitch fibres (fatigue-resistant oxidative). The sprinter would show: lower mitochondrial density but higher glycolytic enzyme activity, relatively lower capillary density, predominantly Type IIx fast-twitch fibres (rapid force production via anaerobic metabolism). These differences reflect both genetic selection and training adaptations specific to each disciplines metabolic demands$t$
WHERE id = 1722
  AND option_a = $t$The marathon runner would show: higher mitochondrial density (supporting sustained aerobic ATP production), higher capillary density (improving O₂ delivery), predominantly Type I slow-twitch fibres (fatigue-resistant oxidative). The sprinter would show: lower mitochondrial density but higher glycolytic enzyme activity, relatively lower capillary density, predominantly Type IIx fast-twitch fibres (rapid force production via anaerobic metabolism). These differences reflect both genetic selection and training adaptations specific to each disciplines metabolic demands$t$;

UPDATE questions SET
  explanation = $t$Fever is a regulated raising of the thermoregulatory set point. Endogenous pyrogens act on the preoptic area of the hypothalamus. The raised set point means the body initiates warming responses. At moderate levels (38-39 degrees C) fever inhibits microbial growth and enhances immune responses. High fever above 41 degrees C is dangerous.$t$
WHERE id = 1735
  AND explanation = $t$Fever is a regulated raising of the thermoregulatory set point. Endogenous pyrogens act on the preoptic area of the hypothalamus. The raised set point means the body initiates warming responses. At moderate levels (38–39 degrees C) fever inhibits microbial growth and enhances immune responses. High fever above 41 degrees C is dangerous.$t$;

UPDATE questions SET
  option_c = $t$Heat exhaustion involves excessive sweating dizziness nausea pale skin and normal to slightly elevated core temperature caused by dehydration and cardiovascular strain. Heat stroke is defined by core temperature above 40 degrees C AND central nervous system dysfunction such as confusion seizures and unconsciousness. Heat stroke is a medical emergency because at temperatures above 40-41 degrees C proteins begin to denature cells die and multi-organ failure can rapidly occur without immediate cooling$t$,
  explanation = $t$Heat exhaustion represents cardiovascular compensation failure for heat stress. Heat stroke represents failure of thermoregulation itself — core temperature rises uncontrollably. Above 40 degrees C protein denaturation begins. Above 41-42 degrees C brain damage and multi-organ failure can develop within minutes. Immediate whole-body cooling is the priority treatment.$t$
WHERE id = 1737
  AND option_c = $t$Heat exhaustion involves excessive sweating dizziness nausea pale skin and normal to slightly elevated core temperature caused by dehydration and cardiovascular strain. Heat stroke is defined by core temperature above 40 degrees C AND central nervous system dysfunction such as confusion seizures and unconsciousness. Heat stroke is a medical emergency because at temperatures above 40–41 degrees C proteins begin to denature cells die and multi-organ failure can rapidly occur without immediate cooling$t$
  AND explanation = $t$Heat exhaustion represents cardiovascular compensation failure for heat stress. Heat stroke represents failure of thermoregulation itself — core temperature rises uncontrollably. Above 40 degrees C protein denaturation begins. Above 41–42 degrees C brain damage and multi-organ failure can develop within minutes. Immediate whole-body cooling is the priority treatment.$t$;

UPDATE questions SET
  option_a = $t$Endothermy advantages: activity independent of environmental temperature can inhabit cold environments stable enzyme activity year-round. Disadvantages: very high metabolic cost (70-80% of energy intake used for thermogenesis in cold conditions) requires continuous food intake. Ectothermy advantages: low metabolic cost can survive long periods without food. Disadvantages: activity limited by environmental temperature vulnerable to temperature extremes$t$,
  explanation = $t$This is a fundamental trade-off in vertebrate physiology. Endothermy allows year-round activity and colonisation of cold environments but requires 5-10 times more food intake than an ectotherm of equivalent size. Ectothermy is energetically extremely efficient but ectotherms are largely excluded from cold environments. Both strategies are highly successful in appropriate ecological contexts.$t$
WHERE id = 1742
  AND option_a = $t$Endothermy advantages: activity independent of environmental temperature can inhabit cold environments stable enzyme activity year-round. Disadvantages: very high metabolic cost (70–80% of energy intake used for thermogenesis in cold conditions) requires continuous food intake. Ectothermy advantages: low metabolic cost can survive long periods without food. Disadvantages: activity limited by environmental temperature vulnerable to temperature extremes$t$
  AND explanation = $t$This is a fundamental trade-off in vertebrate physiology. Endothermy allows year-round activity and colonisation of cold environments but requires 5–10 times more food intake than an ectotherm of equivalent size. Ectothermy is energetically extremely efficient but ectotherms are largely excluded from cold environments. Both strategies are highly successful in appropriate ecological contexts.$t$;

UPDATE questions SET
  option_c = $t$Fever involves raising the hypothalamic set point via pyrogens. When the set point rises to for example 39 degrees C the current body temperature of 37-38 degrees C is below the new set point. The hypothalamus responds as if the body is cold triggering vasoconstriction and shivering to generate and retain heat until the new higher set point is reached$t$
WHERE id = 1747
  AND option_c = $t$Fever involves raising the hypothalamic set point via pyrogens. When the set point rises to for example 39 degrees C the current body temperature of 37–38 degrees C is below the new set point. The hypothalamus responds as if the body is cold triggering vasoconstriction and shivering to generate and retain heat until the new higher set point is reached$t$;

UPDATE questions SET
  explanation = $t$The fundamental trade-off: endothermy allows year-round activity and colonisation of cold environments but requires 5-10 times more food than an equivalent ectotherm. Ectothermy is energetically extremely efficient but ectotherms are largely excluded from cold environments and are inactive at low temperatures.$t$
WHERE id = 1752
  AND explanation = $t$The fundamental trade-off: endothermy allows year-round activity and colonisation of cold environments but requires 5–10 times more food than an equivalent ectotherm. Ectothermy is energetically extremely efficient but ectotherms are largely excluded from cold environments and are inactive at low temperatures.$t$;

UPDATE questions SET
  option_a = $t$Uncontrolled muscle contraction dramatically increases metabolic rate consuming ATP rapidly and generating enormous quantities of heat. Core temperature can rise by 1 degree C every 5 minutes rapidly exceeding the threshold for protein denaturation. Above 41-42 degrees C enzyme denaturation causes metabolic collapse and multi-organ failure can occur within minutes. Acidosis from lactate accumulation compounds the crisis$t$,
  explanation = $t$Malignant hyperthermia is triggered in genetically susceptible individuals (mutations in RYR1 the ryanodine receptor) by volatile anaesthetics. The mutant receptor causes uncontrolled Ca2+ release from the sarcoplasmic reticulum triggering sustained muscle contraction. The metabolic heat produced is so great that standard cooling measures cannot keep pace. Treatment requires dantrolene plus aggressive cooling. Untreated mortality approaches 70%.$t$
WHERE id = 1753
  AND option_a = $t$Uncontrolled muscle contraction dramatically increases metabolic rate consuming ATP rapidly and generating enormous quantities of heat. Core temperature can rise by 1 degree C every 5 minutes rapidly exceeding the threshold for protein denaturation. Above 41–42 degrees C enzyme denaturation causes metabolic collapse and multi-organ failure can occur within minutes. Acidosis from lactate accumulation compounds the crisis$t$
  AND explanation = $t$Malignant hyperthermia is triggered in genetically susceptible individuals (mutations in RYR1 the ryanodine receptor) by volatile anaesthetics. The mutant receptor causes uncontrolled Ca²⁺ release from the sarcoplasmic reticulum triggering sustained muscle contraction. The metabolic heat produced is so great that standard cooling measures cannot keep pace. Treatment requires dantrolene plus aggressive cooling. Untreated mortality approaches 70%.$t$;

UPDATE questions SET
  explanation = $t$Heat acclimatisation is a well-documented physiological response. Plasma volume expansion is the dominant early adaptation within 3-5 days reducing cardiovascular strain. Improved sweating dramatically improves evaporative cooling. Reduced cardiovascular strain and better thermoregulation allow higher exercise intensity in hot conditions. Full acclimatisation takes 10-14 days.$t$
WHERE id = 1754
  AND explanation = $t$Heat acclimatisation is a well-documented physiological response. Plasma volume expansion is the dominant early adaptation within 3–5 days reducing cardiovascular strain. Improved sweating dramatically improves evaporative cooling. Reduced cardiovascular strain and better thermoregulation allow higher exercise intensity in hot conditions. Full acclimatisation takes 10–14 days.$t$;

UPDATE questions SET
  option_d = $t$All metabolic reactions generate heat as a by-product of ATP synthesis inefficiency. Endotherms exploit this to maintain body temperature. In cold environments additional heat must be generated through shivering non-shivering thermogenesis and increased metabolic rate in organs especially the liver. This represents a major metabolic cost — endotherms may use 10-15 times more food than equivalent ectotherms simply to maintain body temperature. This cost is partially offset by the metabolic efficiency benefits of a stable warm body temperature$t$,
  explanation = $t$Basal metabolic rate in endotherms is 5-10 times higher than in ectotherms of similar body size. A significant fraction of this BMR represents obligatory thermogenesis — heat generated as a by-product of ATP synthesis inefficiency used for temperature maintenance. In cold environments additional facultative thermogenesis substantially increases total energy requirements.$t$
WHERE id = 1755
  AND option_d = $t$All metabolic reactions generate heat as a by-product of ATP synthesis inefficiency. Endotherms exploit this to maintain body temperature. In cold environments additional heat must be generated through shivering non-shivering thermogenesis and increased metabolic rate in organs especially the liver. This represents a major metabolic cost — endotherms may use 10–15 times more food than equivalent ectotherms simply to maintain body temperature. This cost is partially offset by the metabolic efficiency benefits of a stable warm body temperature$t$
  AND explanation = $t$Basal metabolic rate in endotherms is 5–10 times higher than in ectotherms of similar body size. A significant fraction of this BMR represents obligatory thermogenesis — heat generated as a by-product of ATP synthesis inefficiency used for temperature maintenance. In cold environments additional facultative thermogenesis substantially increases total energy requirements.$t$;

UPDATE questions SET
  explanation = $t$Dehydration progressively impairs thermoregulation and exercise performance. At 2% body weight loss performance decreases by 5-10%. Plasma volume contraction reduces cardiac preload and stroke volume. Cardiovascular drift (rising HR falling SV over time) represents progressive cardiovascular compromise. ADH and aldosterone provide renal compensation but cannot fully replace sweat fluid loss during intense exercise.$t$
WHERE id = 1757
  AND explanation = $t$Dehydration progressively impairs thermoregulation and exercise performance. At 2% body weight loss performance decreases by 5–10%. Plasma volume contraction reduces cardiac preload and stroke volume. Cardiovascular drift (rising HR falling SV over time) represents progressive cardiovascular compromise. ADH and aldosterone provide renal compensation but cannot fully replace sweat fluid loss during intense exercise.$t$;

UPDATE questions SET
  explanation = $t$The mammalian diving reflex demonstrates the competition between different homeostatic systems. Normal thermoregulatory responses are completely overridden by oxygen conservation responses during apnoea. The vagal bradycardia can reduce heart rate to 10-25% of resting values in trained divers. Peripheral vasoconstriction creates a core-sparing circulation.$t$
WHERE id = 1760
  AND explanation = $t$The mammalian diving reflex demonstrates the competition between different homeostatic systems. Normal thermoregulatory responses are completely overridden by oxygen conservation responses during apnoea. The vagal bradycardia can reduce heart rate to 10–25% of resting values in trained divers. Peripheral vasoconstriction creates a core-sparing circulation.$t$;

UPDATE questions SET
  explanation = $t$The skin manages approximately 95% of heat loss from the body through radiation conduction convection and evaporation. Blood flow through skin capillaries and arteriovenous anastomoses can vary from 0.2 to 8 L/min. Sweat glands (2-4 million) can produce up to 2L/hour of sweat. Subcutaneous fat insulates the core. Thermoreceptors provide real-time feedback.$t$
WHERE id = 1761
  AND explanation = $t$The skin manages approximately 95% of heat loss from the body through radiation conduction convection and evaporation. Blood flow through skin capillaries and arteriovenous anastomoses can vary from 0.2 to \(8\,\text{L/min}\). Sweat glands (2–4 million) can produce up to \(2L\)/hour of sweat. Subcutaneous fat insulates the core. Thermoreceptors provide real-time feedback.$t$;

UPDATE questions SET
  option_d = $t$The set point varies substantially: circadian variation of 0.5-1.0 degrees C (lowest at 4-6am highest at 4-6pm driven by the suprachiasmatic nucleus and melatonin) menstrual cycle variation of 0.3-0.5 degrees C rise post-ovulation due to progesterone raising the set point heat acclimatisation lowers the set point for sweating onset and exercise raises set point slightly. This demonstrates that 37 degrees C is a population mean rather than a universal individual constant$t$
WHERE id = 1762
  AND option_d = $t$The set point varies substantially: circadian variation of 0.5–1.0 degrees C (lowest at 4–6am highest at 4–6pm driven by the suprachiasmatic nucleus and melatonin) menstrual cycle variation of 0.3–0.5 degrees C rise post-ovulation due to progesterone raising the set point heat acclimatisation lowers the set point for sweating onset and exercise raises set point slightly. This demonstrates that 37 degrees C is a population mean rather than a universal individual constant$t$;

UPDATE questions SET
  explanation = $t$Ovulation is the release of a mature egg from the ovarian follicle into the fallopian tube. It is triggered by a surge in luteinising hormone (LH) and occurs approximately on day 14 of a 28-day cycle. The egg can be fertilised for approximately 12-24 hours after release.$t$
WHERE id = 1765
  AND explanation = $t$Ovulation is the release of a mature egg from the ovarian follicle into the fallopian tube. It is triggered by a surge in luteinising hormone (LH) and occurs approximately on day 14 of a 28-day cycle. The egg can be fertilised for approximately 12–24 hours after release.$t$;

UPDATE questions SET
  explanation = $t$If no fertilisation occurs the corpus luteum degenerates after approximately 12-14 days. As it degenerates progesterone and oestrogen levels fall. This withdrawal of hormonal support causes the uterine lining to break down and be shed as menstruation. Falling oestrogen and progesterone release the negative feedback inhibition on the hypothalamus and pituitary allowing FSH to rise and begin a new cycle.$t$
WHERE id = 1767
  AND explanation = $t$If no fertilisation occurs the corpus luteum degenerates after approximately 12–14 days. As it degenerates progesterone and oestrogen levels fall. This withdrawal of hormonal support causes the uterine lining to break down and be shed as menstruation. Falling oestrogen and progesterone release the negative feedback inhibition on the hypothalamus and pituitary allowing FSH to rise and begin a new cycle.$t$;

UPDATE questions SET
  explanation = $t$The LH surge is a dramatic rise in LH over 24-36 hours triggered when oestrogen levels from the maturing follicle reach a threshold that switches from negative to positive feedback on the pituitary. The LH surge triggers final egg maturation and ovulation approximately 36 hours after the surge begins.$t$
WHERE id = 1770
  AND explanation = $t$The LH surge is a dramatic rise in LH over 24–36 hours triggered when oestrogen levels from the maturing follicle reach a threshold that switches from negative to positive feedback on the pituitary. The LH surge triggers final egg maturation and ovulation approximately 36 hours after the surge begins.$t$;

UPDATE questions SET
  explanation = $t$Fertility treatment encompasses a range of interventions. Ovulation induction with FSH injections or clomiphene stimulates follicular development in women who do not ovulate. IVF was first successful in 1978. IVF success rates are approximately 35-40% per cycle in women under 35 falling significantly with age.$t$
WHERE id = 1771
  AND explanation = $t$Fertility treatment encompasses a range of interventions. Ovulation induction with FSH injections or clomiphene stimulates follicular development in women who do not ovulate. IVF was first successful in 1978. IVF success rates are approximately 35–40% per cycle in women under 35 falling significantly with age.$t$;

UPDATE questions SET
  explanation = $t$The sequence: FSH promotes folliculogenesis and oestrogen synthesis. Early rising oestrogen gives negative feedback. When oestrogen reaches threshold on approximately day 12-13 it switches to positive feedback on the pituitary causing the preovulatory LH surge. Post-ovulation: LH drives corpus luteum formation and progesterone secretion. Progesterone dominates the luteal phase maintaining the endometrium and inhibiting new follicle development.$t$
WHERE id = 1773
  AND explanation = $t$The sequence: FSH promotes folliculogenesis and oestrogen synthesis. Early rising oestrogen gives negative feedback. When oestrogen reaches threshold on approximately day 12–13 it switches to positive feedback on the pituitary causing the preovulatory LH surge. Post-ovulation: LH drives corpus luteum formation and progesterone secretion. Progesterone dominates the luteal phase maintaining the endometrium and inhibiting new follicle development.$t$;

UPDATE questions SET
  explanation = $t$Controlled ovarian stimulation with FSH is central to IVF. Monitoring with transvaginal ultrasound and oestrogen levels guides dosing. OHSS occurs in 1-2% of IVF cycles in severe form and can cause massive fluid shifts blood clots and kidney failure. Multiple pregnancy risk is managed by limiting embryo transfer to 1-2 embryos.$t$
WHERE id = 1774
  AND explanation = $t$Controlled ovarian stimulation with FSH is central to IVF. Monitoring with transvaginal ultrasound and oestrogen levels guides dosing. OHSS occurs in 1–2% of IVF cycles in severe form and can cause massive fluid shifts blood clots and kidney failure. Multiple pregnancy risk is managed by limiting embryo transfer to 1–2 embryos.$t$;

UPDATE questions SET
  explanation = $t$Without hCG the corpus luteum degenerates at 12-14 days post-ovulation progesterone falls and menstruation occurs. The early embryo rescues the corpus luteum by producing hCG which binds the same receptor as LH maintaining progesterone production. hCG levels double every 48-72 hours in early normal pregnancy peaking at 10-12 weeks then falling as the placenta takes over progesterone production.$t$
WHERE id = 1775
  AND explanation = $t$Without hCG the corpus luteum degenerates at 12–14 days post-ovulation progesterone falls and menstruation occurs. The early embryo rescues the corpus luteum by producing hCG which binds the same receptor as LH maintaining progesterone production. hCG levels double every 48–72 hours in early normal pregnancy peaking at 10–12 weeks then falling as the placenta takes over progesterone production.$t$;

UPDATE questions SET
  explanation = $t$Luteal phase deficiency is characterised by insufficient progesterone production by the corpus luteum. Progesterone is required for endometrial secretory transformation making the endometrium receptive to implantation (the implantation window days 20-24 of a 28-day cycle). Without adequate progesterone this transformation is incomplete reducing implantation success. Treatment is progesterone supplementation during the luteal phase.$t$
WHERE id = 1779
  AND explanation = $t$Luteal phase deficiency is characterised by insufficient progesterone production by the corpus luteum. Progesterone is required for endometrial secretory transformation making the endometrium receptive to implantation (the implantation window days 20–24 of a 28-day cycle). Without adequate progesterone this transformation is incomplete reducing implantation success. Treatment is progesterone supplementation during the luteal phase.$t$;

UPDATE questions SET
  option_b = $t$Levonorgestrel emergency contraception works primarily by delaying or inhibiting ovulation — preventing the release of an egg. If taken before the LH surge it effectively prevents ovulation. It may also impair sperm migration. It does not terminate an established pregnancy — it is contraceptive not abortifacient. It is most effective when taken as soon as possible (over 95% effective if taken within 24 hours declining to around 58% at 48-72 hours)$t$
WHERE id = 1781
  AND option_b = $t$Levonorgestrel emergency contraception works primarily by delaying or inhibiting ovulation — preventing the release of an egg. If taken before the LH surge it effectively prevents ovulation. It may also impair sperm migration. It does not terminate an established pregnancy — it is contraceptive not abortifacient. It is most effective when taken as soon as possible (over 95% effective if taken within 24 hours declining to around 58% at 48–72 hours)$t$;

UPDATE questions SET
  option_b = $t$IVF procedure: superovulation with FSH injections; egg retrieval under ultrasound guidance; fertilisation in laboratory; embryo culture for 3-5 days; embryo transfer (1-2 embryos placed in uterus); remaining viable embryos frozen. Ethical issues include: creation and potential destruction of surplus embryos; pre-implantation genetic diagnosis (selecting embryos); use of donor eggs and sperm; access equity (high cost); commercial surrogacy; and the psychological burden of multiple failed cycles$t$
WHERE id = 1782
  AND option_b = $t$IVF procedure: superovulation with FSH injections; egg retrieval under ultrasound guidance; fertilisation in laboratory; embryo culture for 3–5 days; embryo transfer (1–2 embryos placed in uterus); remaining viable embryos frozen. Ethical issues include: creation and potential destruction of surplus embryos; pre-implantation genetic diagnosis (selecting embryos); use of donor eggs and sperm; access equity (high cost); commercial surrogacy; and the psychological burden of multiple failed cycles$t$;

UPDATE questions SET
  explanation = $t$In a 28-day menstrual cycle ovulation typically occurs around day 14. This is triggered by the LH surge approximately 36 hours earlier around day 12-13. Day 1 is the first day of menstruation.$t$
WHERE id = 1784
  AND explanation = $t$In a 28-day menstrual cycle ovulation typically occurs around day 14. This is triggered by the LH surge approximately 36 hours earlier around day \(12 - 13\). Day 1 is the first day of menstruation.$t$;

UPDATE questions SET
  explanation = $t$After ovulation the granulosa and theca cells of the ruptured follicle undergo luteinisation (driven by LH) forming the corpus luteum. The corpus luteum secretes progesterone and oestrogen for approximately 12-14 days. If pregnancy occurs hCG rescues the corpus luteum; if not it degenerates.$t$
WHERE id = 1785
  AND explanation = $t$After ovulation the granulosa and theca cells of the ruptured follicle undergo luteinisation (driven by LH) forming the corpus luteum. The corpus luteum secretes progesterone and oestrogen for approximately 12–14 days. If pregnancy occurs hCG rescues the corpus luteum; if not it degenerates.$t$;

UPDATE questions SET
  option_c = $t$The follicular phase (days 1-14 dominated by oestrogen and follicle development) and the luteal phase (days 15-28 dominated by progesterone from the corpus luteum)$t$
WHERE id = 1786
  AND option_c = $t$The follicular phase (days 1–14 dominated by oestrogen and follicle development) and the luteal phase (days 15–28 dominated by progesterone from the corpus luteum)$t$;

UPDATE questions SET
  explanation = $t$Menstruation is triggered by progesterone withdrawal. In the absence of pregnancy the corpus luteum degenerates approximately 12-14 days after ovulation. Falling progesterone removes the support for the endometrium causing vasoconstriction of spiral arteries endometrial ischaemia and shedding. Prostaglandins drive uterine contractions that expel the shed tissue.$t$
WHERE id = 1787
  AND explanation = $t$Menstruation is triggered by progesterone withdrawal. In the absence of pregnancy the corpus luteum degenerates approximately 12–14 days after ovulation. Falling progesterone removes the support for the endometrium causing vasoconstriction of spiral arteries endometrial ischaemia and shedding. Prostaglandins drive uterine contractions that expel the shed tissue.$t$;

UPDATE questions SET
  explanation = $t$Clomiphene (Clomid) is a selective oestrogen receptor modulator. By blocking oestrogen receptors in the hypothalamus and pituitary it prevents oestrogen negative feedback causing increased FSH and LH secretion. This stimulates follicular development and ovulation in women with anovulation such as PCOS. Success rates are approximately 30-40% per cycle.$t$
WHERE id = 1789
  AND explanation = $t$Clomiphene (Clomid) is a selective oestrogen receptor modulator. By blocking oestrogen receptors in the hypothalamus and pituitary it prevents oestrogen negative feedback causing increased FSH and LH secretion. This stimulates follicular development and ovulation in women with anovulation such as PCOS. Success rates are approximately 30–40% per cycle.$t$;

UPDATE questions SET
  option_b = $t$Hormonal methods (pill implant injection): very high effectiveness (91-99%+) systemic action preventing ovulation or altering cervical mucus; advantages: convenience menstrual benefits; disadvantages: side effects (mood headache) health risks (clotting) no STI protection. Barrier methods (condom diaphragm): moderate effectiveness (85-98% with perfect use) physical barrier; advantages: no hormones or side effects condoms protect against STIs; disadvantages: require correct use at every intercourse$t$
WHERE id = 1790
  AND option_b = $t$Hormonal methods (pill implant injection): very high effectiveness (91–99%+) systemic action preventing ovulation or altering cervical mucus; advantages: convenience menstrual benefits; disadvantages: side effects (mood headache) health risks (clotting) no STI protection. Barrier methods (condom diaphragm): moderate effectiveness (85–98% with perfect use) physical barrier; advantages: no hormones or side effects condoms protect against STIs; disadvantages: require correct use at every intercourse$t$;

UPDATE questions SET
  explanation = $t$IVF protocols that use GnRH agonists or antagonists to prevent premature ovulation also suppress LH needed for corpus luteum function. The trigger shot (hCG or GnRH agonist) replaces the LH surge for ovulation induction but subsequent corpus luteum support is inadequate. Progesterone supplementation bridges this gap until the placenta takes over progesterone production at approximately 7-10 weeks gestation.$t$
WHERE id = 1791
  AND explanation = $t$IVF protocols that use GnRH agonists or antagonists to prevent premature ovulation also suppress LH needed for corpus luteum function. The trigger shot (hCG or GnRH agonist) replaces the LH surge for ovulation induction but subsequent corpus luteum support is inadequate. Progesterone supplementation bridges this gap until the placenta takes over progesterone production at approximately 7–10 weeks gestation.$t$;

UPDATE questions SET
  option_d = $t$At menopause ovarian follicle reserves are depleted. Oestrogen and progesterone production falls dramatically. Without negative feedback FSH and LH rise significantly (diagnostic: FSH over 30-40 IU/L). The oestrogen deficiency causes: hot flushes (disrupted thermoregulation) bone loss (osteoporosis — oestrogen normally inhibits osteoclast activity) vaginal atrophy cardiovascular risk increase and mood and cognitive changes$t$,
  explanation = $t$The hormonal dynamics of menopause illustrate the HPG axis clearly. In premenopausal women oestrogen and progesterone provide negative feedback keeping FSH and LH at cyclically low levels. When ovarian function ceases this negative feedback is removed causing very high FSH (up to 10x premenopausal levels) and LH. Hot flushes involve altered GnRH pulse frequency interacting with thermoregulatory neurons in the preoptic area.$t$
WHERE id = 1792
  AND option_d = $t$At menopause ovarian follicle reserves are depleted. Oestrogen and progesterone production falls dramatically. Without negative feedback FSH and LH rise significantly (diagnostic: FSH over 30–40 \(\frac{IU}{L}\)). The oestrogen deficiency causes: hot flushes (disrupted thermoregulation) bone loss (osteoporosis — oestrogen normally inhibits osteoclast activity) vaginal atrophy cardiovascular risk increase and mood and cognitive changes$t$
  AND explanation = $t$The hormonal dynamics of menopause illustrate the HPG axis clearly. In premenopausal women oestrogen and progesterone provide negative feedback keeping FSH and LH at cyclically low levels. When ovarian function ceases this negative feedback is removed causing very high FSH (up to 10× premenopausal levels) and LH. Hot flushes involve altered GnRH pulse frequency interacting with thermoregulatory neurons in the preoptic area.$t$;

UPDATE questions SET
  explanation = $t$The hormonal dynamics of menopause: in premenopausal women oestrogen and progesterone provide negative feedback keeping FSH and LH cyclically low. When ovarian function ceases this negative feedback is removed causing very high FSH (up to 10x premenopausal levels). The hot flush mechanism involves altered GnRH pulse frequency post-menopause interacting with the thermoregulatory neurons in the preoptic area.$t$
WHERE id = 1793
  AND explanation = $t$The hormonal dynamics of menopause: in premenopausal women oestrogen and progesterone provide negative feedback keeping FSH and LH cyclically low. When ovarian function ceases this negative feedback is removed causing very high FSH (up to 10× premenopausal levels). The hot flush mechanism involves altered GnRH pulse frequency post-menopause interacting with the thermoregulatory neurons in the preoptic area.$t$;

UPDATE questions SET
  explanation = $t$Endometriosis is a leading cause of infertility affecting approximately 30-50% of infertile women. Mechanisms are multiple: mechanical (distorted anatomy prevents egg pickup by fimbriae) reduced ovarian reserve (endometriomas damage ovarian cortex) inflammatory (peritoneal fluid rich in macrophages and cytokines impairs gametes) and possibly impaired endometrial receptivity. Treatment ranges from medical (progestins GnRH agonists) to surgical (laparoscopic excision).$t$
WHERE id = 1795
  AND explanation = $t$Endometriosis is a leading cause of infertility affecting approximately 30–50% of infertile women. Mechanisms are multiple: mechanical (distorted anatomy prevents egg pickup by fimbriae) reduced ovarian reserve (endometriomas damage ovarian cortex) inflammatory (peritoneal fluid rich in macrophages and cytokines impairs gametes) and possibly impaired endometrial receptivity. Treatment ranges from medical (progestins GnRH agonists) to surgical (laparoscopic excision).$t$;

UPDATE questions SET
  option_c = $t$Risks: small increased risk of venous thromboembolism (3-4 per 10,000 woman-years vs 2 in non-users) increased risk of cervical cancer (HPV co-factor) very small increase in breast cancer risk. Benefits: significantly reduced risk of ovarian cancer (50% reduction with 5+ years use persistent for 30+ years) reduced endometrial cancer risk reduced risk of benign ovarian cysts endometriosis PID and improvement of dysmenorrhoea PCOS symptoms and acne. Risk-benefit analysis must be individualised to each patients cardiovascular oncological and personal risk factors$t$,
  explanation = $t$The pill risk-benefit analysis is complex. The VTE risk while real is small in absolute terms and far lower than the VTE risk of pregnancy (20-30 per 10,000 per year). The ovarian and endometrial cancer protection is substantial and enduring. The small breast cancer risk appears to resolve after pill cessation. Overall for healthy non-smoking women without VTE risk factors the pill has a favourable risk-benefit profile.$t$
WHERE id = 1796
  AND option_c = $t$Risks: small increased risk of venous thromboembolism (3–4 per 10 000 woman-years vs 2 in non-users) increased risk of cervical cancer (HPV co-factor) very small increase in breast cancer risk. Benefits: significantly reduced risk of ovarian cancer (50% reduction with 5+ years use persistent for 30+ years) reduced endometrial cancer risk reduced risk of benign ovarian cysts endometriosis PID and improvement of dysmenorrhoea PCOS symptoms and acne. Risk-benefit analysis must be individualised to each patients cardiovascular oncological and personal risk factors$t$
  AND explanation = $t$The pill risk-benefit analysis is complex. The VTE risk while real is small in absolute terms and far lower than the VTE risk of pregnancy (20–30 per 10 000 per year). The ovarian and endometrial cancer protection is substantial and enduring. The small breast cancer risk appears to resolve after pill cessation. Overall for healthy non-smoking women without VTE risk factors the pill has a favourable risk-benefit profile.$t$;

UPDATE questions SET
  option_b = $t$Each hormone provides specific diagnostic information: Day 2-3 FSH elevated above 10-12 IU/L indicates reduced ovarian reserve. LH:FSH ratio over 2 suggests PCOS. Day 2-3 oestradiol elevated alongside elevated FSH confirms poor reserve. AMH (anti-Mullerian hormone) secreted by small antral follicles provides ovarian reserve assessment independent of cycle day — low AMH confirms reduced reserve. Day 21 progesterone confirms ovulation occurred (over 30 nmol/L in natural cycle) and corpus luteum adequacy. Together these tests map the entire HPG axis function$t$,
  explanation = $t$The hormonal assessment of the menstrual cycle requires sequential testing. Day 2-3: basal FSH LH oestradiol assess pituitary-ovarian communication and ovarian reserve. AMH can be measured any cycle day. Day 21 progesterone confirms whether ovulation occurred. This systematic approach identifies anovulation poor ovarian reserve HPG axis dysfunction and luteal phase deficiency.$t$
WHERE id = 1797
  AND option_b = $t$Each hormone provides specific diagnostic information: Day 2–3 FSH elevated above 10–12 \(\frac{IU}{L}\) indicates reduced ovarian reserve. LH:FSH ratio over 2 suggests PCOS. Day 2–3 oestradiol elevated alongside elevated FSH confirms poor reserve. AMH (anti-Mullerian hormone) secreted by small antral follicles provides ovarian reserve assessment independent of cycle day — low AMH confirms reduced reserve. Day 21 progesterone confirms ovulation occurred (over 30 nmol/L in natural cycle) and corpus luteum adequacy. Together these tests map the entire HPG axis function$t$
  AND explanation = $t$The hormonal assessment of the menstrual cycle requires sequential testing. Day \(2 - 3\): basal FSH LH oestradiol assess pituitary-ovarian communication and ovarian reserve. AMH can be measured any cycle day. Day 21 progesterone confirms whether ovulation occurred. This systematic approach identifies anovulation poor ovarian reserve HPG axis dysfunction and luteal phase deficiency.$t$;

UPDATE questions SET
  option_a = $t$PMS symptoms (mood changes irritability bloating breast tenderness fatigue — occurring in the luteal phase and resolving with menstruation) correlate with falling oestrogen and progesterone as the corpus luteum degenerates. Proposed mechanisms: progesterone metabolite (allopregnanolone) acts on GABA-A receptors — women with PMDD may have abnormal sensitivity to normal hormonal fluctuations; serotonin dysregulation (oestrogen modulates serotonin — SSRI antidepressants are effective treatments); and inflammatory mediator changes. The fact that symptoms resolve with menstruation and are abolished by GnRH agonist treatment strongly supports a hormonal trigger$t$,
  explanation = $t$PMS/PMDD has well-established hormonal triggering but the downstream mechanism is neurobiological. Key evidence: PMDD is abolished by GnRH agonists and restored by adding back cyclical sex steroids confirming the hormonal trigger. Women with PMDD have normal hormone levels but abnormal CNS sensitivity to normal fluctuations. The allopregnanolone-GABA hypothesis: paradoxically allopregnanolone (normally anxiolytic) causes anxiety in PMDD brains possibly due to altered GABA-A receptor subunit composition.$t$
WHERE id = 1798
  AND option_a = $t$PMS symptoms (mood changes irritability bloating breast tenderness fatigue — occurring in the luteal phase and resolving with menstruation) correlate with falling oestrogen and progesterone as the corpus luteum degenerates. Proposed mechanisms: progesterone metabolite (allopregnanolone) acts on \(GABA - A\) receptors — women with PMDD may have abnormal sensitivity to normal hormonal fluctuations; serotonin dysregulation (oestrogen modulates serotonin — SSRI antidepressants are effective treatments); and inflammatory mediator changes. The fact that symptoms resolve with menstruation and are abolished by GnRH agonist treatment strongly supports a hormonal trigger$t$
  AND explanation = $t$PMS/PMDD has well-established hormonal triggering but the downstream mechanism is neurobiological. Key evidence: PMDD is abolished by GnRH agonists and restored by adding back cyclical sex steroids confirming the hormonal trigger. Women with PMDD have normal hormone levels but abnormal CNS sensitivity to normal fluctuations. The allopregnanolone-GABA hypothesis: paradoxically allopregnanolone (normally anxiolytic) causes anxiety in PMDD brains possibly due to altered \(GABA - A\) receptor subunit composition.$t$;

UPDATE questions SET
  option_c = $t$Like natural menopause POI causes low oestrogen and elevated FSH/LH due to loss of negative feedback. Key differences: it occurs before age 40 affecting women who may strongly desire pregnancy carries greater lifetime health risks from longer oestrogen deficiency and the cause may sometimes be auto-immune (potentially partially reversible). Fertility options: egg donation IVF using donor eggs from young donors inseminated with the partners sperm transferred to the HRT-primed recipients uterus achieves success rates of 40-50% per cycle. Own-egg IVF has very poor outcomes due to depleted poor quality remaining follicles$t$
WHERE id = 1799
  AND option_c = $t$Like natural menopause POI causes low oestrogen and elevated FSH/LH due to loss of negative feedback. Key differences: it occurs before age 40 affecting women who may strongly desire pregnancy carries greater lifetime health risks from longer oestrogen deficiency and the cause may sometimes be auto-immune (potentially partially reversible). Fertility options: egg donation IVF using donor eggs from young donors inseminated with the partners sperm transferred to the HRT-primed recipients uterus achieves success rates of 40–50% per cycle. Own-egg IVF has very poor outcomes due to depleted poor quality remaining follicles$t$;

UPDATE questions SET
  option_b = $t$PGT for aneuploidy (PGT-A) selects chromosomally normal embryos improving IVF success rates — but some scientists argue mosaic embryos may be viable and are incorrectly discarded. PGT for single gene disorders (PGT-M) allows selection of unaffected embryos for serious genetic diseases — raising disability rights questions about devaluing lives of people with those conditions. PGT-HLA (saviour sibling) involves selecting embryos matching an existing sick sibling — raising questions about creating children instrumentally. Eugenics concerns underlie all PGT applications$t$,
  explanation = $t$PGT sits at the intersection of reproductive medicine genetics and bioethics. PGT-A may discard viable mosaic embryos. PGT-M for severe childhood diseases is widely accepted but PGT for adult-onset conditions or deafness is more contested. Saviour siblings raise questions about instrumentalising children. All PGT raises the spectre of eugenic selection though current regulation restricts these applications.$t$
WHERE id = 1801
  AND option_b = $t$PGT for aneuploidy \((PGT - A)\) selects chromosomally normal embryos improving IVF success rates — but some scientists argue mosaic embryos may be viable and are incorrectly discarded. PGT for single gene disorders \((PGT - M)\) allows selection of unaffected embryos for serious genetic diseases — raising disability rights questions about devaluing lives of people with those conditions. PGT-HLA (saviour sibling) involves selecting embryos matching an existing sick sibling — raising questions about creating children instrumentally. Eugenics concerns underlie all PGT applications$t$
  AND explanation = $t$PGT sits at the intersection of reproductive medicine genetics and bioethics. \(PGT - A\) may discard viable mosaic embryos. \(PGT - M\) for severe childhood diseases is widely accepted but PGT for adult-onset conditions or deafness is more contested. Saviour siblings raise questions about instrumentalising children. All PGT raises the spectre of eugenic selection though current regulation restricts these applications.$t$;

UPDATE questions SET
  question_text = $t$Explain how hormonal contraceptive research has evolved to address side effects and improve safety since the first oral contraceptive pill in the 1960s.$t$,
  option_a = $t$The oral contraceptive pill has not changed since it was first introduced in the 1960s$t$,
  option_c = $t$The first oral contraceptive pills (1960s) contained very high doses of both oestrogen (150 micrograms ethinylestradiol) and progesterone. Over decades: oestrogen doses were dramatically reduced (to 20-35 micrograms) reducing VTE cardiovascular and cancer risks; newer progestogens with different receptor profiles (e.g. drospirenone with anti-androgenic activity improving acne and mood) were developed; the progesterone-only pill (avoiding oestrogen risks entirely) was developed; long-acting reversible contraceptives (IUS implant injection) providing years of protection with minimal systemic exposure were developed; and emergency contraception was refined. Research continues into male hormonal contraception and non-hormonal options$t$,
  option_d = $t$Research into contraception has focused entirely on barrier methods since the 1970s$t$,
  explanation = $t$The evolution of hormonal contraception illustrates drug development principles. Dose reduction of oestrogen: the Nottingham studies (1970s-80s) established that lower doses maintained efficacy while substantially reducing VTE risk. The development of fourth-generation progestogens with anti-androgenic activity addressed non-contraceptive benefits for acne and PCOS. LARCs represent the most significant recent advance achieving the highest real-world effectiveness of any reversible method. Male hormonal contraception trials continue but side effects and delivery challenges have prevented approval to date.$t$
WHERE id = 1802
  AND question_text = $t$Explain how hormonal contraceptive research has evolved to address side effects and improve safety since the first oral contraceptive pill in the \(1960s\).$t$
  AND option_a = $t$The oral contraceptive pill has not changed since it was first introduced in the \(1960s\)$t$
  AND option_c = $t$The first oral contraceptive pills \((1960s)\) contained very high doses of both oestrogen (150 micrograms ethinylestradiol) and progesterone. Over decades: oestrogen doses were dramatically reduced (to 20–35 micrograms) reducing VTE cardiovascular and cancer risks; newer progestogens with different receptor profiles (e.g. drospirenone with anti-androgenic activity improving acne and mood) were developed; the progesterone-only pill (avoiding oestrogen risks entirely) was developed; long-acting reversible contraceptives (IUS implant injection) providing years of protection with minimal systemic exposure were developed; and emergency contraception was refined. Research continues into male hormonal contraception and non-hormonal options$t$
  AND option_d = $t$Research into contraception has focused entirely on barrier methods since the \(1970s\)$t$
  AND explanation = $t$The evolution of hormonal contraception illustrates drug development principles. Dose reduction of oestrogen: the Nottingham studies \((1970s - 80s)\) established that lower doses maintained efficacy while substantially reducing VTE risk. The development of fourth-generation progestogens with anti-androgenic activity addressed non-contraceptive benefits for acne and PCOS. LARCs represent the most significant recent advance achieving the highest real-world effectiveness of any reversible method. Male hormonal contraception trials continue but side effects and delivery challenges have prevented approval to date.$t$;

UPDATE questions SET
  explanation = $t$Rods (120 million per eye): contain rhodopsin maximum absorbance at approximately 498nm converge many rods onto single ganglion cells (high sensitivity low acuity). Cones (6 million per eye): L-cones M-cones and S-cones converge minimally in fovea (1:1 ratio — high acuity). Colour perception arises from comparing the relative stimulation of the three cone types.$t$
WHERE id = 1814
  AND explanation = $t$Rods (120 million per eye): contain rhodopsin maximum absorbance at approximately 498nm converge many rods onto single ganglion cells (high sensitivity low acuity). Cones (6 million per eye): L-cones M-cones and S-cones converge minimally in fovea (\(1 : 1\) ratio — high acuity). Colour perception arises from comparing the relative stimulation of the three cone types.$t$;

UPDATE questions SET
  option_b = $t$The fovea contains only cone cells at extremely high density (approximately 200,000 per mm squared — highest in the body). Crucially the convergence ratio of cones to ganglion cells in the fovea approaches 1:1 (each cone connects to a single midget bipolar cell to a single midget ganglion cell) — this private line wiring preserves spatial detail. The fovea also contains no blood vessels or inner retinal layers that would scatter light before reaching photoreceptors$t$,
  explanation = $t$Foveal specialisations: 1) Cone-only composition enabling colour and high-acuity vision in daylight 2) Extreme cone packing density 3) 1:1 midget pathway wiring — each foveal cone has a dedicated retinal processing chain avoiding spatial averaging that reduces acuity in the periphery 4) Foveal pit (avascular zone inner retinal layers displaced to sides) allowing light to reach photoreceptors without scattering.$t$
WHERE id = 1821
  AND option_b = $t$The fovea contains only cone cells at extremely high density (approximately 200 000 per mm squared — highest in the body). Crucially the convergence ratio of cones to ganglion cells in the fovea approaches \(1 : 1\) (each cone connects to a single midget bipolar cell to a single midget ganglion cell) — this private line wiring preserves spatial detail. The fovea also contains no blood vessels or inner retinal layers that would scatter light before reaching photoreceptors$t$
  AND explanation = $t$Foveal specialisations: 1) Cone-only composition enabling colour and high-acuity vision in daylight 2) Extreme cone packing density 3) \(1 : 1\) midget pathway wiring — each foveal cone has a dedicated retinal processing chain avoiding spatial averaging that reduces acuity in the periphery 4) Foveal pit (avascular zone inner retinal layers displaced to sides) allowing light to reach photoreceptors without scattering.$t$;

UPDATE questions SET
  explanation = $t$Sperry and Gazzaniga split-brain experiments (1960s-70s) used tachistoscopic presentation to deliver stimuli to one hemisphere at a time. A split-brain patient shown a snow scene in the left visual field cannot say what they saw but their left hand points correctly at a shovel. This revealed left hemisphere language lateralisation right hemisphere spatial specialisation and the role of the corpus callosum in inter-hemispheric integration.$t$
WHERE id = 1833
  AND explanation = $t$Sperry and Gazzaniga split-brain experiments \((1960s - 70s)\) used tachistoscopic presentation to deliver stimuli to one hemisphere at a time. A split-brain patient shown a snow scene in the left visual field cannot say what they saw but their left hand points correctly at a shovel. This revealed left hemisphere language lateralisation right hemisphere spatial specialisation and the role of the corpus callosum in inter-hemispheric integration.$t$;

UPDATE questions SET
  explanation = $t$LASIK optical principle: corneal curvature determines refractive power. Reducing corneal curvature reduces optical power. A -4D myope needs -4 dioptres less convergence. The excimer laser ablates approximately 0.25 microns of corneal stroma per pulse with submicron precision reshaping the central cornea to a flatter profile. Results are permanent but presbyopia still develops with age.$t$
WHERE id = 1837
  AND explanation = $t$LASIK optical principle: corneal curvature determines refractive power. Reducing corneal curvature reduces optical power. \(A - 4D\) myope needs - 4 dioptres less convergence. The excimer laser ablates approximately 0.25 microns of corneal stroma per pulse with submicron precision reshaping the central cornea to a flatter profile. Results are permanent but presbyopia still develops with age.$t$;

UPDATE questions SET
  explanation = $t$Wet AMD accounts for approximately 10% of AMD cases but over 90% of severe visual loss. VEGF drives pathological choroidal neovascularisation. Monthly intravitreal anti-VEGF injections (ranibizumab bevacizumab aflibercept) revolutionised treatment from 2006. In 30-40% of patients visual improvement is achieved. This is a direct clinical application of monoclonal antibody technology to ophthalmology using the same anti-VEGF principle as in cancer treatment.$t$
WHERE id = 1838
  AND explanation = $t$Wet AMD accounts for approximately 10% of AMD cases but over 90% of severe visual loss. VEGF drives pathological choroidal neovascularisation. Monthly intravitreal anti-VEGF injections (ranibizumab bevacizumab aflibercept) revolutionised treatment from 2006. In 30–40% of patients visual improvement is achieved. This is a direct clinical application of monoclonal antibody technology to ophthalmology using the same anti-VEGF principle as in cancer treatment.$t$;

UPDATE questions SET
  option_d = $t$The skull is a rigid container. Normal ICP is 5-15 mmHg. Increases can be caused by brain oedema (swelling) haematoma (blood collection) tumour or CSF obstruction. As pressure rises the brain is compressed: cerebral perfusion pressure falls reducing oxygen and glucose delivery; brain tissue herniates through natural openings (uncal herniation compresses cranial nerve III causing blown pupil; tonsillar herniation into foramen magnum compresses the medulla stopping breathing and heart rate). Raised ICP is life-threatening without urgent decompression (surgery osmotic therapy with mannitol positioning sedation)$t$
WHERE id = 1839
  AND option_d = $t$The skull is a rigid container. Normal ICP is 5–15 mmHg. Increases can be caused by brain oedema (swelling) haematoma (blood collection) tumour or CSF obstruction. As pressure rises the brain is compressed: cerebral perfusion pressure falls reducing oxygen and glucose delivery; brain tissue herniates through natural openings (uncal herniation compresses cranial nerve III causing blown pupil; tonsillar herniation into foramen magnum compresses the medulla stopping breathing and heart rate). Raised ICP is life-threatening without urgent decompression (surgery osmotic therapy with mannitol positioning sedation)$t$;

UPDATE questions SET
  option_c = $t$Visual signals from both eyes arrive at the primary visual cortex (V1). V1 neurons are tuned to basic features (orientation spatial frequency colour motion). These features are processed simultaneously in parallel streams (dorsal and ventral) with higher areas integrating information: V4 for colour and form V5/MT for motion and IT cortex for object recognition. Conscious perception involves: feature binding (gamma oscillations synchronising widely distributed neural populations) top-down attention from frontal cortex and prediction error signals (predictive coding). The time from retinal activation to conscious percept is approximately 100-200ms$t$
WHERE id = 1842
  AND option_c = $t$Visual signals from both eyes arrive at the primary visual cortex (V1). V1 neurons are tuned to basic features (orientation spatial frequency colour motion). These features are processed simultaneously in parallel streams (dorsal and ventral) with higher areas integrating information: V4 for colour and form \(\frac{V5}{MT}\) for motion and IT cortex for object recognition. Conscious perception involves: feature binding (gamma oscillations synchronising widely distributed neural populations) top-down attention from frontal cortex and prediction error signals (predictive coding). The time from retinal activation to conscious percept is approximately 100–200ms$t$;

UPDATE questions SET
  option_a = $t$Synthetic auxins (e.g. 2,4-D MCPA) applied to broad-leaved weeds cause uncontrolled abnormal growth at high concentrations that disrupts normal development and kills the plant. Narrow-leaved plants (e.g. grasses cereals) are much less affected due to differences in auxin receptor sensitivity making these herbicides selective for broad-leaved weeds in lawns and cereal crops$t$,
  explanation = $t$Selective herbicides based on synthetic auxins (phenoxyacetic acids like 2,4-D) are widely used. At high concentrations they cause unregulated growth that kills dicotyledonous (broad-leaved) plants. Monocotyledons (grasses cereals) have lower sensitivity — possibly due to faster auxin metabolism and differences in receptor distribution. This selectivity makes them safe for use in cereal fields and lawns.$t$
WHERE id = 1852
  AND option_a = $t$Synthetic auxins (e.g. 2,\(4 - D MCPA\)) applied to broad-leaved weeds cause uncontrolled abnormal growth at high concentrations that disrupts normal development and kills the plant. Narrow-leaved plants (e.g. grasses cereals) are much less affected due to differences in auxin receptor sensitivity making these herbicides selective for broad-leaved weeds in lawns and cereal crops$t$
  AND explanation = $t$Selective herbicides based on synthetic auxins (phenoxyacetic acids like 2,\(4 - D\)) are widely used. At high concentrations they cause unregulated growth that kills dicotyledonous (broad-leaved) plants. Monocotyledons (grasses cereals) have lower sensitivity — possibly due to faster auxin metabolism and differences in receptor distribution. This selectivity makes them safe for use in cereal fields and lawns.$t$;

UPDATE questions SET
  explanation = $t$The acid growth hypothesis (Hager 1971): auxin-activated H+-ATPases pump H+ into the cell wall lowering wall pH. Acidification activates expansins (pH-sensitive proteins) that disrupt non-covalent bonds between cellulose microfibrils and matrix polysaccharides making the wall extensible. Cell turgor pressure then drives cell expansion. The nuclear TIR1/Aux-IAA/ARF signalling cascade is the molecular basis of auxin-regulated gene expression.$t$
WHERE id = 1853
  AND explanation = $t$The acid growth hypothesis (Hager 1971): auxin-activated H+-ATPases pump H⁺ into the cell wall lowering wall pH. Acidification activates expansins (pH-sensitive proteins) that disrupt non-covalent bonds between cellulose microfibrils and matrix polysaccharides making the wall extensible. Cell turgor pressure then drives cell expansion. The nuclear TIR1/Aux-IAA/ARF signalling cascade is the molecular basis of auxin-regulated gene expression.$t$;

UPDATE questions SET
  option_c = $t$Ethylene stimulates its own biosynthesis: ethylene activates ACC synthase (which converts SAM to ACC) and ACC oxidase (which converts ACC to ethylene) creating a positive feedback loop. Once ripening begins ethylene production accelerates. In food technology this is exploited: unripe fruit is transported in low-oxygen CO2-enriched atmosphere (inhibiting ethylene activity) then exposed to ethylene gas to initiate synchronised ripening at the destination$t$
WHERE id = 1854
  AND option_c = $t$Ethylene stimulates its own biosynthesis: ethylene activates ACC synthase (which converts SAM to ACC) and ACC oxidase (which converts ACC to ethylene) creating a positive feedback loop. Once ripening begins ethylene production accelerates. In food technology this is exploited: unripe fruit is transported in low-oxygen CO₂-enriched atmosphere (inhibiting ethylene activity) then exposed to ethylene gas to initiate synchronised ripening at the destination$t$;

UPDATE questions SET
  explanation = $t$The phytochrome system is one of the most elegant plant signalling discoveries. Red light drives Pr to Pfr (daylight has more red than far-red). At night Pfr reverts to Pr (half-life approximately 1-2 hours). A single brief red light pulse in the middle of a long night (night interruption) converts enough Pr to Pfr to prevent flowering in short-day plants — proving it is night length not day length that is measured.$t$
WHERE id = 1858
  AND explanation = $t$The phytochrome system is one of the most elegant plant signalling discoveries. Red light drives Pr to Pfr (daylight has more red than far-red). At night Pfr reverts to Pr (half-life approximately 1–2 hours). A single brief red light pulse in the middle of a long night (night interruption) converts enough Pr to Pfr to prevent flowering in short-day plants — proving it is night length not day length that is measured.$t$;

UPDATE questions SET
  option_b = $t$ABA accumulates when a plant is water-stressed. It is transported to guard cells where it causes K+ ions to leave the guard cells reducing their water potential above that of surrounding cells. Water leaves by osmosis guard cells become flaccid and stomata close. This reduces transpiration and conserves water during drought$t$,
  explanation = $t$ABA is the primary stress hormone in plants. Under drought ABA is synthesised in roots and leaves. It travels to guard cells activating outward K+ channels and anion channels causing K+ efflux. Reduced cellular K+ raises guard cell water potential. Water leaves by osmosis. Guard cells lose turgor (become flaccid) and stomata close. This is an adaptive response reducing water loss while sacrificing some CO2 uptake for photosynthesis.$t$
WHERE id = 1860
  AND option_b = $t$ABA accumulates when a plant is water-stressed. It is transported to guard cells where it causes K⁺ ions to leave the guard cells reducing their water potential above that of surrounding cells. Water leaves by osmosis guard cells become flaccid and stomata close. This reduces transpiration and conserves water during drought$t$
  AND explanation = $t$ABA is the primary stress hormone in plants. Under drought ABA is synthesised in roots and leaves. It travels to guard cells activating outward K⁺ channels and anion channels causing K⁺ efflux. Reduced cellular K⁺ raises guard cell water potential. Water leaves by osmosis. Guard cells lose turgor (become flaccid) and stomata close. This is an adaptive response reducing water loss while sacrificing some CO₂ uptake for photosynthesis.$t$;

UPDATE questions SET
  option_c = $t$The Cholodny-Went theory was disproved in the 1950s and is no longer accepted$t$
WHERE id = 1861
  AND option_c = $t$The Cholodny-Went theory was disproved in the \(1950s\) and is no longer accepted$t$;

UPDATE questions SET
  explanation = $t$The commercial use of ethylene in ripening is widespread. Bananas tomatoes avocados and other climacteric fruits are harvested before full ripeness and ripened with ethylene gas at destination. This allows efficient transport of firm undamaged fruit and synchronised delivery of ripe fruit to retail. Ethylene gas rooms typically use 100-150 ppm ethylene at 15-18 degrees C for 24-48 hours.$t$
WHERE id = 1867
  AND explanation = $t$The commercial use of ethylene in ripening is widespread. Bananas tomatoes avocados and other climacteric fruits are harvested before full ripeness and ripened with ethylene gas at destination. This allows efficient transport of firm undamaged fruit and synchronised delivery of ripe fruit to retail. Ethylene gas rooms typically use 100–150 ppm ethylene at 15–18 degrees C for 24–48 hours.$t$;

UPDATE questions SET
  option_d = $t$ABA accumulates when a plant is water-stressed. It is transported to guard cells where it causes K+ ions to leave the guard cells. Water then leaves guard cells by osmosis guard cells become flaccid and stomata close. This reduces transpiration and conserves water during drought$t$,
  explanation = $t$ABA is the primary drought stress signal in plants. Under drought ABA is synthesised in roots and leaves. It travels to guard cells activating outward K+ channels and anion channels causing K+ efflux. Reduced cellular K+ raises guard cell water potential. Water exits guard cells by osmosis. Guard cells shrink and become flaccid causing stomata to close.$t$
WHERE id = 1871
  AND option_d = $t$ABA accumulates when a plant is water-stressed. It is transported to guard cells where it causes K⁺ ions to leave the guard cells. Water then leaves guard cells by osmosis guard cells become flaccid and stomata close. This reduces transpiration and conserves water during drought$t$
  AND explanation = $t$ABA is the primary drought stress signal in plants. Under drought ABA is synthesised in roots and leaves. It travels to guard cells activating outward K⁺ channels and anion channels causing K⁺ efflux. Reduced cellular K⁺ raises guard cell water potential. Water exits guard cells by osmosis. Guard cells shrink and become flaccid causing stomata to close.$t$;

UPDATE questions SET
  option_b = $t$Higher CO2 will increase auxin production making all plants grow taller indefinitely$t$,
  option_c = $t$Rising temperatures alter the vernalisation requirements of some species potentially causing premature flowering. Altered precipitation patterns change ABA levels in roots (drought stress responses). Elevated CO2 reduces stomatal aperture through reduced ABA requirement (higher internal CO2 means stomata can be more closed while still photosynthesising). Altered temperature regimes change the speed of phytochrome dark-reversion potentially misaligning flowering time with pollinator emergence. These disruptions could decouple plant phenology from historical synchrony with pollinators and seed dispersers$t$,
  explanation = $t$The intersection of climate change and plant hormone signalling is an active research area. Examples: earlier spring temperatures reduce the cold requirement for vernalisation causing early flowering in wheat (affecting grain set if frost follows); altered photoperiod and temperature balance disrupts phytochrome-based flowering timing; drought stress ABA responses interact with rising atmospheric CO2 in complex ways as shown by free-air CO2 enrichment (FACE) experiments.$t$
WHERE id = 1874
  AND option_b = $t$Higher CO₂ will increase auxin production making all plants grow taller indefinitely$t$
  AND option_c = $t$Rising temperatures alter the vernalisation requirements of some species potentially causing premature flowering. Altered precipitation patterns change ABA levels in roots (drought stress responses). Elevated CO₂ reduces stomatal aperture through reduced ABA requirement (higher internal CO₂ means stomata can be more closed while still photosynthesising). Altered temperature regimes change the speed of phytochrome dark-reversion potentially misaligning flowering time with pollinator emergence. These disruptions could decouple plant phenology from historical synchrony with pollinators and seed dispersers$t$
  AND explanation = $t$The intersection of climate change and plant hormone signalling is an active research area. Examples: earlier spring temperatures reduce the cold requirement for vernalisation causing early flowering in wheat (affecting grain set if frost follows); altered photoperiod and temperature balance disrupts phytochrome-based flowering timing; drought stress ABA responses interact with rising atmospheric CO₂ in complex ways as shown by free-air CO₂ enrichment (FACE) experiments.$t$;

UPDATE questions SET
  option_b = $t$Synthetic auxin herbicides (2,4-D MCPA mecoprop) are absorbed by leaves and translocated to growing tissues where high concentrations cause abnormal uncontrolled growth (epinasty abnormal cell division disrupted vascular tissue) followed by plant death. Selectivity between dicots and monocots arises from differences in auxin receptor sensitivity metabolism rates (monocots degrade synthetic auxins faster) and transport properties. Environmental concerns include: water contamination (2,4-D is relatively water-soluble) effects on non-target broadleaved plants in adjacent habitats and concerns about dicamba drift damaging neighbouring crop fields$t$
WHERE id = 1875
  AND option_b = $t$Synthetic auxin herbicides (\(2,\ 4 - D MCPA\) mecoprop) are absorbed by leaves and translocated to growing tissues where high concentrations cause abnormal uncontrolled growth (epinasty abnormal cell division disrupted vascular tissue) followed by plant death. Selectivity between dicots and monocots arises from differences in auxin receptor sensitivity metabolism rates (monocots degrade synthetic auxins faster) and transport properties. Environmental concerns include: water contamination (\(2,\ 4 - D\) is relatively water-soluble) effects on non-target broadleaved plants in adjacent habitats and concerns about dicamba drift damaging neighbouring crop fields$t$;

UPDATE questions SET
  explanation = $t$Selective breeding has been practised for 10,000+ years (domestication of wheat cattle dogs). It can only utilise alleles present in the breeding population and requires many generations to achieve significant change. Genetic engineering bypasses species barriers allows specific single-gene changes and can be accomplished in one generation — but produces changes that would not occur naturally.$t$
WHERE id = 1891
  AND explanation = $t$Selective breeding has been practised for 10 000+ years (domestication of wheat cattle dogs). It can only utilise alleles present in the breeding population and requires many generations to achieve significant change. Genetic engineering bypasses species barriers allows specific single-gene changes and can be accomplished in one generation — but produces changes that would not occur naturally.$t$;

UPDATE questions SET
  option_a = $t$iPSCs are adult somatic cells (e.g. skin fibroblasts) that have been reprogrammed to a pluripotent state by introducing four transcription factors (Yamanaka factors: Oct4 Sox2 Klf4 c-Myc). They can differentiate into virtually any cell type. Compared to ESCs: iPSCs avoid embryo destruction (less ethical concern) and can be patient-specific (avoiding immune rejection). However they may have: residual epigenetic memory of the donor cell type potentially higher mutation rate (due to reprogramming) and small risk of tumour formation (c-Myc is an oncogene). ESCs are considered the gold standard for pluripotency but require embryo destruction$t$
WHERE id = 1895
  AND option_a = $t$iPSCs are adult somatic cells (e.g. skin fibroblasts) that have been reprogrammed to a pluripotent state by introducing four transcription factors (Yamanaka factors: Oct4 Sox2 Klf4 \(c\)-Myc). They can differentiate into virtually any cell type. Compared to ESCs: iPSCs avoid embryo destruction (less ethical concern) and can be patient-specific (avoiding immune rejection). However they may have: residual epigenetic memory of the donor cell type potentially higher mutation rate (due to reprogramming) and small risk of tumour formation (\(c\)-Myc is an oncogene). ESCs are considered the gold standard for pluripotency but require embryo destruction$t$;

UPDATE questions SET
  option_c = $t$Restriction enzymes are bacterial endonucleases that cut double-stranded DNA at specific recognition sequences (4-8 bp palindromes) often producing complementary sticky ends. DNA ligase joins compatible sticky ends by forming phosphodiester bonds. Plasmid vectors are small circular DNA molecules from bacteria that can: be cut with the same restriction enzyme (to receive the insert) be introduced into bacteria replicate autonomously and express the inserted gene. Together: target gene is cut with restriction enzyme producing sticky ends matching the plasmid cut site; insert is ligated into the opened plasmid; recombinant plasmid is transformed into bacteria; bacteria containing the recombinant plasmid are selected using the antibiotic resistance gene on the plasmid$t$,
  explanation = $t$The central tool kit of recombinant DNA technology: restriction enzymes (Nobel Prize 1978) cut at specific palindromic sequences. Type II restriction enzymes produce defined reproducible cuts. Ligase from T4 phage joins compatible ends. Plasmid vectors provide autonomously replicating DNA vehicles with selectable markers (antibiotic resistance) and multiple cloning sites (polylinker). These tools developed in the 1970s enabled the entire recombinant DNA revolution.$t$
WHERE id = 1896
  AND option_c = $t$Restriction enzymes are bacterial endonucleases that cut double-stranded DNA at specific recognition sequences (4–8 bp palindromes) often producing complementary sticky ends. DNA ligase joins compatible sticky ends by forming phosphodiester bonds. Plasmid vectors are small circular DNA molecules from bacteria that can: be cut with the same restriction enzyme (to receive the insert) be introduced into bacteria replicate autonomously and express the inserted gene. Together: target gene is cut with restriction enzyme producing sticky ends matching the plasmid cut site; insert is ligated into the opened plasmid; recombinant plasmid is transformed into bacteria; bacteria containing the recombinant plasmid are selected using the antibiotic resistance gene on the plasmid$t$
  AND explanation = $t$The central tool kit of recombinant DNA technology: restriction enzymes (Nobel Prize 1978) cut at specific palindromic sequences. Type II restriction enzymes produce defined reproducible cuts. Ligase from T4 phage joins compatible ends. Plasmid vectors provide autonomously replicating DNA vehicles with selectable markers (antibiotic resistance) and multiple cloning sites (polylinker). These tools developed in the \(1970s\) enabled the entire recombinant DNA revolution.$t$;

UPDATE questions SET
  option_a = $t$PCR amplifies specific DNA sequences in vitro. Process: denaturation (94 degrees C — separates double-stranded DNA into single strands); annealing (50-65 degrees C — primers bind to complementary sequences flanking the target); extension (72 degrees C — Taq polymerase extends new DNA strands from primers). Each cycle doubles the target sequence — 30 cycles produce approximately 1 billion copies. Applications: forensic DNA profiling; medical diagnosis (detecting viral or bacterial DNA in clinical samples); ancient DNA studies; paternity testing; and cloning genes for genetic engineering$t$,
  explanation = $t$PCR (Kary Mullis Nobel Prize 1993) revolutionised molecular biology by allowing amplification of specific DNA sequences from vanishingly small amounts. Key components: thermostable Taq polymerase (from Thermus aquaticus a hot spring bacterium); specific primers (20-25 bp oligonucleotides flanking the target); dNTPs (the building blocks); and buffer. Real-time PCR (qPCR) allows quantification of starting template essential for gene expression analysis and viral load measurement.$t$
WHERE id = 1897
  AND option_a = $t$PCR amplifies specific DNA sequences in vitro. Process: denaturation (94 degrees C — separates double-stranded DNA into single strands); annealing (50–65 degrees C — primers bind to complementary sequences flanking the target); extension (72 degrees C — Taq polymerase extends new DNA strands from primers). Each cycle doubles the target sequence — 30 cycles produce approximately 1 billion copies. Applications: forensic DNA profiling; medical diagnosis (detecting viral or bacterial DNA in clinical samples); ancient DNA studies; paternity testing; and cloning genes for genetic engineering$t$
  AND explanation = $t$PCR (Kary Mullis Nobel Prize 1993) revolutionised molecular biology by allowing amplification of specific DNA sequences from vanishingly small amounts. Key components: thermostable Taq polymerase (from Thermus aquaticus a hot spring bacterium); specific primers (20–25 bp oligonucleotides flanking the target); dNTPs (the building blocks); and buffer. Real-time PCR (qPCR) allows quantification of starting template essential for gene expression analysis and viral load measurement.$t$;

UPDATE questions SET
  explanation = $t$Forensic DNA profiling uses PCR to amplify short tandem repeat (STR) regions — areas where a short DNA sequence is repeated a variable number of times. Different individuals have different numbers of repeats at multiple STR loci. PCR amplifies these specific regions from trace evidence. The resulting amplified products are separated by capillary electrophoresis and produce a profile. The probability of two unrelated individuals having identical profiles at 10+ STR loci is less than 1 in a billion.$t$
WHERE id = 1899
  AND explanation = $t$Forensic DNA profiling uses PCR to amplify short tandem repeat (STR) regions — areas where a short DNA sequence is repeated a variable number of times. Different individuals have different numbers of repeats at multiple STR loci. PCR amplifies these specific regions from trace evidence. The resulting amplified products are separated by capillary electrophoresis and produce a profile. The probability of two unrelated individuals having identical profiles at \(10 + STR\) loci is less than 1 in a billion.$t$;

UPDATE questions SET
  option_a = $t$The main ethical concern is that producing embryonic stem cells requires the destruction of a human embryo (typically at the blastocyst stage 5-7 days after fertilisation). Those who believe that human life begins at fertilisation consider this morally equivalent to killing a human being. Those who believe early embryos have different moral status to born humans consider the potential medical benefits to patients with debilitating diseases to outweigh this concern. Regulation varies by country$t$
WHERE id = 1905
  AND option_a = $t$The main ethical concern is that producing embryonic stem cells requires the destruction of a human embryo (typically at the blastocyst stage 5–7 days after fertilisation). Those who believe that human life begins at fertilisation consider this morally equivalent to killing a human being. Those who believe early embryos have different moral status to born humans consider the potential medical benefits to patients with debilitating diseases to outweigh this concern. Regulation varies by country$t$;

UPDATE questions SET
  explanation = $t$Embryo transplantation maximises the reproductive output of genetically superior animals. A prized dairy cow might have exceptional milk production genetics; normally she could produce 1 calf per year. With superovulation and embryo transfer 10-20 embryos can be harvested per cycle all with her superior genetics gestated by commercial surrogate cows. This accelerates the introduction of superior genetics into a herd.$t$
WHERE id = 1906
  AND explanation = $t$Embryo transplantation maximises the reproductive output of genetically superior animals. A prized dairy cow might have exceptional milk production genetics; normally she could produce 1 calf per year. With superovulation and embryo transfer 10–20 embryos can be harvested per cycle all with her superior genetics gestated by commercial surrogate cows. This accelerates the introduction of superior genetics into a herd.$t$;

UPDATE questions SET
  option_d = $t$An autoclave uses pressurised steam at 121 degrees C for 15-20 minutes to kill all microorganisms including heat-resistant bacterial spores. In biotechnology sterilisation of fermenters growth media and equipment before use prevents contamination of cultures. If contaminating organisms enter a fermenter producing a valuable protein they could: outcompete the engineered bacteria; break down the product; or introduce pathogens. Sterilisation ensures pure cultures and consistent reliable production$t$
WHERE id = 1912
  AND option_d = $t$An autoclave uses pressurised steam at 121 degrees C for 15–20 minutes to kill all microorganisms including heat-resistant bacterial spores. In biotechnology sterilisation of fermenters growth media and equipment before use prevents contamination of cultures. If contaminating organisms enter a fermenter producing a valuable protein they could: outcompete the engineered bacteria; break down the product; or introduce pathogens. Sterilisation ensures pure cultures and consistent reliable production$t$;

UPDATE questions SET
  option_d = $t$Scientific approach: genes from daffodil and a bacterium were inserted to provide the beta-carotene biosynthesis pathway in the endosperm. Golden Rice 2 produces 23-fold more beta-carotene than the original. Benefits: vitamin A deficiency affects 190 million children globally and causes approximately 670,000 deaths annually; Golden Rice could provide 50-60% of daily recommended intake in a portion. Limitations: bioavailability depends on fat intake (beta-carotene is fat-soluble); dietary diversification may be more comprehensive; anti-nutritional factors in rice may limit absorption. Ethical debate: corporate involvement; opposition from Greenpeace (as anti-GM symbol); regulatory delays costing lives; and questions about addressing poverty vs. nutrition alone$t$
WHERE id = 1915
  AND option_d = $t$Scientific approach: genes from daffodil and a bacterium were inserted to provide the beta-carotene biosynthesis pathway in the endosperm. Golden Rice 2 produces 23-fold more beta-carotene than the original. Benefits: vitamin A deficiency affects 190 million children globally and causes approximately 670 000 deaths annually; Golden Rice could provide 50–60% of daily recommended intake in a portion. Limitations: bioavailability depends on fat intake (beta-carotene is fat-soluble); dietary diversification may be more comprehensive; anti-nutritional factors in rice may limit absorption. Ethical debate: corporate involvement; opposition from Greenpeace (as anti-GM symbol); regulatory delays costing lives; and questions about addressing poverty vs. nutrition alone$t$;

UPDATE questions SET
  option_a = $t$GM crop patents allow companies to control the use of patented genetics preventing farmers from saving and replanting seeds (seed saving has been practiced for 10,000 years). This creates dependency on corporate seed supply and royalty payments. In developing countries this may undermine food sovereignty (the right of peoples to define their own food systems). On the other hand patents incentivise investment in GM crop development that might not otherwise occur given the high development costs. Agricultural biodiversity concerns: widespread adoption of patented varieties may displace traditional landraces reducing genetic diversity and making crops more vulnerable to future pests and diseases. The Convention on Biological Diversity (CBD) and International Treaty on Plant Genetic Resources attempt to balance these concerns$t$,
  explanation = $t$The IP dimensions of GM crops are as contested as the safety dimensions. The Monsanto Canada v Schmeiser case (2004) found that Schmeiser (who used wind-pollinated Roundup Ready canola without payment) infringed Monsanto patents — raising questions about liability when GM genes spread through natural processes. The Terminator technology controversy (sterile seed technology preventing replanting) was shelved after public opposition but illustrates the commercial incentives. The tension between innovation incentives (patents) and food sovereignty continues to shape international agricultural policy.$t$
WHERE id = 1917
  AND option_a = $t$GM crop patents allow companies to control the use of patented genetics preventing farmers from saving and replanting seeds (seed saving has been practiced for 10 000 years). This creates dependency on corporate seed supply and royalty payments. In developing countries this may undermine food sovereignty (the right of peoples to define their own food systems). On the other hand patents incentivise investment in GM crop development that might not otherwise occur given the high development costs. Agricultural biodiversity concerns: widespread adoption of patented varieties may displace traditional landraces reducing genetic diversity and making crops more vulnerable to future pests and diseases. The Convention on Biological Diversity (CBD) and International Treaty on Plant Genetic Resources attempt to balance these concerns$t$
  AND explanation = $t$The IP dimensions of GM crops are as contested as the safety dimensions. The Monsanto Canada \(v\) Schmeiser case (2004) found that Schmeiser (who used wind-pollinated Roundup Ready canola without payment) infringed Monsanto patents — raising questions about liability when GM genes spread through natural processes. The Terminator technology controversy (sterile seed technology preventing replanting) was shelved after public opposition but illustrates the commercial incentives. The tension between innovation incentives (patents) and food sovereignty continues to shape international agricultural policy.$t$;

UPDATE questions SET
  option_c = $t$The HGP (completed 2003) provided the complete reference human DNA sequence enabling: identification of all approximately 20,000-25,000 human protein-coding genes; discovery that only approximately 1.5% of the genome codes for proteins (the rest includes regulatory sequences non-coding RNAs repetitive elements etc.); development of genome-wide association studies (GWAS) identifying genetic variants associated with complex diseases; enabling whole-genome sequencing (WGS) in clinical practice for rare disease diagnosis; development of gene therapy targets; and providing the framework for pharmacogenomics (personalised medicine based on genetic variation in drug metabolism). CRISPR gene editing depends entirely on genomic sequence knowledge to design guide RNAs$t$,
  option_d = $t$The HGP showed that humans have approximately 100,000 genes confirming earlier estimates$t$,
  explanation = $t$The HGP was transformative beyond even what was anticipated. The unexpected finding that humans have only 20,000-25,000 genes (similar to a nematode worm) redirected attention to regulatory networks and non-coding RNA. GWAS has identified thousands of genetic variants associated with common diseases. Clinical WGS now diagnoses approximately 35-40% of patients with rare undiagnosed diseases. The genomic revolution has fundamentally changed medicine from reactive to predictive and personalised.$t$
WHERE id = 1918
  AND option_c = $t$The HGP (completed 2003) provided the complete reference human DNA sequence enabling: identification of all approximately \(20\,000 - 25\,000\) human protein-coding genes; discovery that only approximately 1.5% of the genome codes for proteins (the rest includes regulatory sequences non-coding RNAs repetitive elements etc.); development of genome-wide association studies (GWAS) identifying genetic variants associated with complex diseases; enabling whole-genome sequencing (WGS) in clinical practice for rare disease diagnosis; development of gene therapy targets; and providing the framework for pharmacogenomics (personalised medicine based on genetic variation in drug metabolism). CRISPR gene editing depends entirely on genomic sequence knowledge to design guide RNAs$t$
  AND option_d = $t$The HGP showed that humans have approximately 100 000 genes confirming earlier estimates$t$
  AND explanation = $t$The HGP was transformative beyond even what was anticipated. The unexpected finding that humans have only \(20\,000 - 25\,000\) genes (similar to a nematode worm) redirected attention to regulatory networks and non-coding RNA. GWAS has identified thousands of genetic variants associated with common diseases. Clinical WGS now diagnoses approximately 35–40% of patients with rare undiagnosed diseases. The genomic revolution has fundamentally changed medicine from reactive to predictive and personalised.$t$;

UPDATE questions SET
  option_c = $t$Sickle cell disease results from a single point mutation in the HBB gene (E6V). CRISPR approaches include: 1) Ex vivo approach (approved 2023 — Casgevy): haematopoietic stem cells (HSCs) are harvested from the patient edited in the laboratory (activating foetal haemoglobin by disrupting BCL11A enhancer) and reinfused after myeloablative conditioning. This avoids immune rejection and off-target editing in non-target tissues. 2) In vivo approach: CRISPR-Cas9 delivered via lipid nanoparticles or viral vectors directly into HSCs in the bone marrow — technically challenging and raises greater concerns about off-target editing throughout the body. Ex vivo is currently safer and proven; in vivo represents the future aspiration for simpler delivery. Both approaches have transformed the outlook for sickle cell disease patients$t$
WHERE id = 1921
  AND option_c = $t$Sickle cell disease results from a single point mutation in the HBB gene (E\(6V\)). CRISPR approaches include: 1) Ex vivo approach (approved 2023 — Casgevy): haematopoietic stem cells (HSCs) are harvested from the patient edited in the laboratory (activating foetal haemoglobin by disrupting BCL11A enhancer) and reinfused after myeloablative conditioning. This avoids immune rejection and off-target editing in non-target tissues. 2) In vivo approach: CRISPR-Cas9 delivered via lipid nanoparticles or viral vectors directly into HSCs in the bone marrow — technically challenging and raises greater concerns about off-target editing throughout the body. Ex vivo is currently safer and proven; in vivo represents the future aspiration for simpler delivery. Both approaches have transformed the outlook for sickle cell disease patients$t$;

UPDATE questions SET
  option_b = $t$High-income countries: established regulatory frameworks for advanced therapies; specialist treatment centres with requisite expertise; national health systems or insurance funding mechanisms (though gene therapy costs of $1-3 million per treatment are straining these); and research infrastructure to generate clinical trial data. Low-income countries face: absence of national regulatory pathways for advanced therapies; lack of specialist clinical infrastructure; prohibitive costs (Zolgensma at $2.8 million exceeds GDP per capita by orders of magnitude in most LMICs); limited clinical trial representation (most trials conducted in high-income countries leading to less evidence for safety and efficacy in genetically diverse populations); and regulatory timelines lagging decades behind. The inequality has profound equity implications: gene therapy could theoretically cure conditions (sickle cell disease) that disproportionately affect LMIC populations but is inaccessible where burden is greatest$t$,
  explanation = $t$The global equity dimension of advanced therapy medicinal products (ATMPs) is a critical emerging issue. Sickle cell disease affects approximately 300,000 births annually — predominantly in sub-Saharan Africa and India — yet Casgevy is priced and available only in high-income settings. Differential pricing charitable access programmes and technology transfer partnerships (as with COVID vaccines) may improve access but structural inequities in regulatory capacity clinical infrastructure and healthcare financing present systemic barriers. The contrast between the diseases curable by gene therapy and the populations bearing those disease burdens represents one of the most acute equity challenges in modern medicine.$t$
WHERE id = 1922
  AND option_b = $t$High-income countries: established regulatory frameworks for advanced therapies; specialist treatment centres with requisite expertise; national health systems or insurance funding mechanisms (though gene therapy costs of $1–3 million per treatment are straining these); and research infrastructure to generate clinical trial data. Low-income countries face: absence of national regulatory pathways for advanced therapies; lack of specialist clinical infrastructure; prohibitive costs (Zolgensma at $2.8 million exceeds GDP per capita by orders of magnitude in most LMICs); limited clinical trial representation (most trials conducted in high-income countries leading to less evidence for safety and efficacy in genetically diverse populations); and regulatory timelines lagging decades behind. The inequality has profound equity implications: gene therapy could theoretically cure conditions (sickle cell disease) that disproportionately affect LMIC populations but is inaccessible where burden is greatest$t$
  AND explanation = $t$The global equity dimension of advanced therapy medicinal products (ATMPs) is a critical emerging issue. Sickle cell disease affects approximately 300 000 births annually — predominantly in sub-Saharan Africa and India — yet Casgevy is priced and available only in high-income settings. Differential pricing charitable access programmes and technology transfer partnerships (as with COVID vaccines) may improve access but structural inequities in regulatory capacity clinical infrastructure and healthcare financing present systemic barriers. The contrast between the diseases curable by gene therapy and the populations bearing those disease burdens represents one of the most acute equity challenges in modern medicine.$t$;

UPDATE questions SET
  explanation = $t$Selective breeding of wheat has produced varieties with: higher grain yield; disease resistance (e.g. to rust fungi); improved grain quality (protein content baking properties); and adaptation to different climates. The Green Revolution in the 1960s used selective breeding of semi-dwarf wheat varieties that redirected energy from tall stems to grain production dramatically increasing yields.$t$
WHERE id = 1929
  AND explanation = $t$Selective breeding of wheat has produced varieties with: higher grain yield; disease resistance (e.g. to rust fungi); improved grain quality (protein content baking properties); and adaptation to different climates. The Green Revolution in the \(1960s\) used selective breeding of semi-dwarf wheat varieties that redirected energy from tall stems to grain production dramatically increasing yields.$t$;

UPDATE questions SET
  explanation = $t$All domestic dog breeds (Canis lupus familiaris) descended from the grey wolf. Over approximately 15,000 years humans selectively bred dogs for specific tasks: greyhounds for speed; border collies for herding; bloodhounds for tracking; retrievers for retrieving game. This has produced extraordinary phenotypic diversity from a single ancestral species entirely through artificial selection.$t$
WHERE id = 1931
  AND explanation = $t$All domestic dog breeds (Canis lupus familiaris) descended from the grey wolf. Over approximately 15 000 years humans selectively bred dogs for specific tasks: greyhounds for speed; border collies for herding; bloodhounds for tracking; retrievers for retrieving game. This has produced extraordinary phenotypic diversity from a single ancestral species entirely through artificial selection.$t$;

UPDATE questions SET
  explanation = $t$The standard genetic engineering toolkit: type II restriction enzymes cut at palindromic recognition sequences producing 4- or 5-nucleotide single-stranded sticky ends. Ligase joins compatible sticky ends by forming 3-5 phosphodiester bonds after hydrogen bonding between complementary sticky ends. Vectors replicate autonomously and deliver DNA into cells. Each tool plays a distinct irreplaceable role in the process.$t$
WHERE id = 1934
  AND explanation = $t$The standard genetic engineering toolkit: type II restriction enzymes cut at palindromic recognition sequences producing 4- or 5-nucleotide single-stranded sticky ends. Ligase joins compatible sticky ends by forming 3–5 phosphodiester bonds after hydrogen bonding between complementary sticky ends. Vectors replicate autonomously and deliver DNA into cells. Each tool plays a distinct irreplaceable role in the process.$t$;

UPDATE questions SET
  option_d = $t$Two genes (psy from daffodil and crtI from Erwinia bacteria) were inserted into the rice genome under the control of an endosperm-specific promoter. These genes encode enzymes in the beta-carotene biosynthesis pathway that are not normally expressed in rice endosperm. The resulting grain has a golden colour due to beta-carotene accumulation. Health benefit: beta-carotene is converted to vitamin A in the body. Vitamin A deficiency affects approximately 190 million children globally and is the leading cause of preventable blindness potentially causing 670,000 child deaths annually$t$,
  explanation = $t$Golden Rice development: Ingo Potrykus and Peter Beyer (1999-2000) inserted two genes from the carotenoid pathway into the rice endosperm under the control of the endosperm-specific glutelin promoter. Beta-carotene (provitamin A) accumulates giving the golden colour. Golden Rice 2 (2005 with maize psy) produces 23x more beta-carotene. A portion of 150g cooked Golden Rice 2 could provide approximately 60% of a childs daily vitamin A requirement.$t$
WHERE id = 1935
  AND option_d = $t$Two genes (psy from daffodil and crtI from Erwinia bacteria) were inserted into the rice genome under the control of an endosperm-specific promoter. These genes encode enzymes in the beta-carotene biosynthesis pathway that are not normally expressed in rice endosperm. The resulting grain has a golden colour due to beta-carotene accumulation. Health benefit: beta-carotene is converted to vitamin A in the body. Vitamin A deficiency affects approximately 190 million children globally and is the leading cause of preventable blindness potentially causing 670 000 child deaths annually$t$
  AND explanation = $t$Golden Rice development: Ingo Potrykus and Peter Beyer \((1999 - 2000)\) inserted two genes from the carotenoid pathway into the rice endosperm under the control of the endosperm-specific glutelin promoter. Beta-carotene (provitamin A) accumulates giving the golden colour. Golden Rice 2 (2005 with maize psy) produces 23× more beta-carotene. A portion of \(150g\) cooked Golden Rice 2 could provide approximately 60% of a childs daily vitamin A requirement.$t$;

UPDATE questions SET
  option_b = $t$Crop diseases cause 10-40% of global harvest losses annually. Chemical disease management is expensive environmentally harmful and increasingly ineffective due to pathogen resistance. Breeding disease-resistant varieties provides durable cost-effective and environmentally benign protection. Example: wheat rust resistance — fungal rust diseases (Puccinia species) threaten global wheat production. Breeders introgress resistance genes (R genes) from wild wheat relatives (Aegilops species) into commercial varieties. The challenge is that new rust races continuously overcome single R gene resistance (boom and bust cycles) requiring ongoing breeding effort$t$
WHERE id = 1937
  AND option_b = $t$Crop diseases cause 10–40% of global harvest losses annually. Chemical disease management is expensive environmentally harmful and increasingly ineffective due to pathogen resistance. Breeding disease-resistant varieties provides durable cost-effective and environmentally benign protection. Example: wheat rust resistance — fungal rust diseases (Puccinia species) threaten global wheat production. Breeders introgress resistance genes (R genes) from wild wheat relatives (Aegilops species) into commercial varieties. The challenge is that new rust races continuously overcome single R gene resistance (boom and bust cycles) requiring ongoing breeding effort$t$;

UPDATE questions SET
  option_a = $t$The case for GM crops: global population may reach 10 billion by 2050 requiring 50-70% more food; climate change will reduce yields in some regions; conventional breeding may not be fast enough to develop needed traits; GM can provide drought tolerance pest resistance and nutritional enhancement. The case against necessity: much current food is wasted (30-40%); many regions have food surpluses not shortages suggesting distribution and poverty are primary problems; agroecological approaches and conventional breeding have also achieved significant yield increases; and yield potential of existing varieties is often not achieved due to resource constraints rather than genetic limitations$t$
WHERE id = 1938
  AND option_a = $t$The case for GM crops: global population may reach 10 billion by 2050 requiring 50–70% more food; climate change will reduce yields in some regions; conventional breeding may not be fast enough to develop needed traits; GM can provide drought tolerance pest resistance and nutritional enhancement. The case against necessity: much current food is wasted (30–40%); many regions have food surpluses not shortages suggesting distribution and poverty are primary problems; agroecological approaches and conventional breeding have also achieved significant yield increases; and yield potential of existing varieties is often not achieved due to resource constraints rather than genetic limitations$t$;

UPDATE questions SET
  option_a = $t$Both traditional plant breeding and genetic engineering aim to introduce and maintain beneficial alleles or traits in crop populations — they differ in mechanism not in underlying goal. Traditional breeding: crosses between varieties or species are made beneficial recombinants are identified and selected over many generations. The process is slow (10-20 years per variety) and limited to genes within the sexual compatibility range of the species. Genetic engineering: specific genes (from any organism) are directly inserted allowing targeted trait introduction in a single step. Both approaches then require selection of successfully modified lines and rigorous field testing before release$t$
WHERE id = 1941
  AND option_a = $t$Both traditional plant breeding and genetic engineering aim to introduce and maintain beneficial alleles or traits in crop populations — they differ in mechanism not in underlying goal. Traditional breeding: crosses between varieties or species are made beneficial recombinants are identified and selected over many generations. The process is slow (10–20 years per variety) and limited to genes within the sexual compatibility range of the species. Genetic engineering: specific genes (from any organism) are directly inserted allowing targeted trait introduction in a single step. Both approaches then require selection of successfully modified lines and rigorous field testing before release$t$;

UPDATE questions SET
  explanation = $t$This question tests understanding of the complete genetic engineering pipeline. Pathogen-derived resistance (PDR) using coat protein transgenes was demonstrated by Beachy in the 1980s and used to create virus-resistant papaya (saving the Hawaiian papaya industry from ringspot virus). Each step presents real challenges: transgene silencing is a major problem (solved by optimising codon usage and expression constructs); regulatory approval in the EU can take >10 years; and public opposition can prevent deployment even after approval.$t$
WHERE id = 1942
  AND explanation = $t$This question tests understanding of the complete genetic engineering pipeline. Pathogen-derived resistance (PDR) using coat protein transgenes was demonstrated by Beachy in the \(1980s\) and used to create virus-resistant papaya (saving the Hawaiian papaya industry from ringspot virus). Each step presents real challenges: transgene silencing is a major problem (solved by optimising codon usage and expression constructs); regulatory approval in the EU can take \(> 10\) years; and public opposition can prevent deployment even after approval.$t$;

UPDATE questions SET
  option_d = $t$A restriction enzyme is a bacterial enzyme that cuts DNA at specific recognition sequences (short palindromic sequences of 4-8 base pairs) often producing single-stranded sticky ends that can pair with complementary sequences on other DNA fragments. They are used in genetic engineering to cut out a gene of interest and to cut a vector at the same recognition sequence so that the gene and vector can be joined$t$,
  explanation = $t$Restriction enzymes were discovered in bacteria where they defend against bacteriophage DNA. Type II restriction enzymes cut at specific palindromic sequences producing blunt ends or 4-5 nucleotide single-stranded overhangs (sticky ends). Sticky ends from the same enzyme are complementary and can be joined by DNA ligase. This sticky end ligation is the basis of recombinant DNA technology.$t$
WHERE id = 1945
  AND option_d = $t$A restriction enzyme is a bacterial enzyme that cuts DNA at specific recognition sequences (short palindromic sequences of 4–8 base pairs) often producing single-stranded sticky ends that can pair with complementary sequences on other DNA fragments. They are used in genetic engineering to cut out a gene of interest and to cut a vector at the same recognition sequence so that the gene and vector can be joined$t$
  AND explanation = $t$Restriction enzymes were discovered in bacteria where they defend against bacteriophage DNA. Type II restriction enzymes cut at specific palindromic sequences producing blunt ends or 4–5 nucleotide single-stranded overhangs (sticky ends). Sticky ends from the same enzyme are complementary and can be joined by DNA ligase. This sticky end ligation is the basis of recombinant DNA technology.$t$;

UPDATE questions SET
  explanation = $t$Selective breeding of livestock has been practised for millennia. Examples beyond milk: beef cattle (Angus Hereford) selected for muscle development efficient feed conversion and docile temperament; Merino sheep for fine wool diameter (15-20 microns); modern broiler chickens reach slaughter weight (2.2kg) in 35 days (compared to approximately 120 days for unimproved breeds); and racing horses selected for speed stride length and competitive temperament.$t$
WHERE id = 1948
  AND explanation = $t$Selective breeding of livestock has been practised for millennia. Examples beyond milk: beef cattle (Angus Hereford) selected for muscle development efficient feed conversion and docile temperament; Merino sheep for fine wool diameter (15–20 microns); modern broiler chickens reach slaughter weight (2.2kg) in 35 days (compared to approximately 120 days for unimproved breeds); and racing horses selected for speed stride length and competitive temperament.$t$;

UPDATE questions SET
  explanation = $t$Transformation describes the uptake of exogenous DNA by a cell. Bacterial transformation occurs naturally (Griffiths experiment 1928) and artificially (chemical or electroporation). Chemically competent cells are treated with calcium chloride and heat shock (42 degrees C brief) or ice alternation which temporarily disrupts the cell membrane allowing plasmid DNA to enter. Electroporation uses a brief high-voltage pulse to create temporary pores. Only approximately 1 in 10,000 bacteria successfully take up the plasmid — hence the need for selectable markers.$t$
WHERE id = 1950
  AND explanation = $t$Transformation describes the uptake of exogenous DNA by a cell. Bacterial transformation occurs naturally (Griffiths experiment 1928) and artificially (chemical or electroporation). Chemically competent cells are treated with calcium chloride and heat shock (42 degrees C brief) or ice alternation which temporarily disrupts the cell membrane allowing plasmid DNA to enter. Electroporation uses a brief high-voltage pulse to create temporary pores. Only approximately 1 in 10 000 bacteria successfully take up the plasmid — hence the need for selectable markers.$t$;

UPDATE questions SET
  explanation = $t$Public risk perception is a complex socio-cultural phenomenon. The Europe vs USA contrast is striking: approximately 60-70% of Europeans are concerned about GM foods while surveys consistently show lower concern in the USA where GM crops have been commercially grown since 1996. This difference reflects regulatory culture (EU precautionary) historical food safety crises trust in regulatory bodies and the influence of environmental NGOs which are more powerful in European political culture.$t$
WHERE id = 1952
  AND explanation = $t$Public risk perception is a complex socio-cultural phenomenon. The Europe vs USA contrast is striking: approximately 60–70% of Europeans are concerned about GM foods while surveys consistently show lower concern in the USA where GM crops have been commercially grown since 1996. This difference reflects regulatory culture (EU precautionary) historical food safety crises trust in regulatory bodies and the influence of environmental NGOs which are more powerful in European political culture.$t$;

UPDATE questions SET
  question_text = $t$Analyse the argument that genetic engineering is simply an extension of the selective breeding that humans have practised for 10,000 years and evaluate whether this justifies the same level of regulatory oversight.$t$,
  explanation = $t$The continuity/discontinuity debate is central to GM regulation philosophy. Arguments for continuity: all food plants are products of massive genetic manipulation through 10,000 years of breeding; conventional mutagenesis breeding (using radiation or chemicals to induce random mutations) is less precise than genetic engineering but not specially regulated. Arguments for discontinuity: deliberate crossing of species barriers is genuinely novel; insertion at random genomic locations may disrupt existing genes; and novel proteins may have unintended consequences. The scientific consensus (as expressed by NAS EFSA WHO) supports product-based rather than process-based risk assessment.$t$
WHERE id = 1953
  AND question_text = $t$Analyse the argument that genetic engineering is simply an extension of the selective breeding that humans have practised for 10 000 years and evaluate whether this justifies the same level of regulatory oversight.$t$
  AND explanation = $t$The continuity/discontinuity debate is central to GM regulation philosophy. Arguments for continuity: all food plants are products of massive genetic manipulation through 10 000 years of breeding; conventional mutagenesis breeding (using radiation or chemicals to induce random mutations) is less precise than genetic engineering but not specially regulated. Arguments for discontinuity: deliberate crossing of species barriers is genuinely novel; insertion at random genomic locations may disrupt existing genes; and novel proteins may have unintended consequences. The scientific consensus (as expressed by NAS EFSA WHO) supports product-based rather than process-based risk assessment.$t$;

UPDATE questions SET
  explanation = $t$MAS revolutionised plant breeding from the 1990s onwards. Previously introgressing a single resistance gene from a wild relative required 6-8 backcrossing generations (approximately 12-16 years) to remove the surrounding wild genome (linkage drag) with no tools other than phenotypic selection. MAS allows background selection (selecting against wild genome while selecting for the target gene) reducing this to 2-3 backcross generations and dramatically reducing linkage drag. High-throughput genotyping chips can assess 600,000+ SNPs simultaneously in hundreds of breeding lines.$t$
WHERE id = 1954
  AND explanation = $t$MAS revolutionised plant breeding from the \(1990s\) onwards. Previously introgressing a single resistance gene from a wild relative required 6–8 backcrossing generations (approximately 12–16 years) to remove the surrounding wild genome (linkage drag) with no tools other than phenotypic selection. MAS allows background selection (selecting against wild genome while selecting for the target gene) reducing this to 2–3 backcross generations and dramatically reducing linkage drag. High-throughput genotyping chips can assess 600 000+ SNPs simultaneously in hundreds of breeding lines.$t$;

UPDATE questions SET
  question_text = $t$The Green Revolution of the 1960s involved the development and deployment of semi-dwarf high-yielding varieties (HYVs) of wheat and rice. Analyse its success and its limitations.$t$,
  option_c = $t$Success: HYVs responded to fertiliser inputs with dramatically higher grain yields (2-3x previous yields). Combined with irrigation expansion and fertiliser use the Green Revolution increased wheat production in India from 12 million tonnes (1965) to 23 million tonnes (1972). It prevented predicted famines and saved hundreds of millions from starvation. Limitations: HYVs required high fertiliser and water inputs (benefiting wealthier farmers with access to resources); increased monoculture of HYVs reduced diversity and increased vulnerability to pests; inequitable distribution of benefits (landless poor did not benefit); environmental costs (water table depletion in Punjab; fertiliser runoff; loss of traditional varieties); and yields have plateaued since the 1990s (yield ceiling effect)$t$
WHERE id = 1956
  AND question_text = $t$The Green Revolution of the \(1960s\) involved the development and deployment of semi-dwarf high-yielding varieties (HYVs) of wheat and rice. Analyse its success and its limitations.$t$
  AND option_c = $t$Success: HYVs responded to fertiliser inputs with dramatically higher grain yields (2–3× previous yields). Combined with irrigation expansion and fertiliser use the Green Revolution increased wheat production in India from 12 million tonnes (1965) to 23 million tonnes (1972). It prevented predicted famines and saved hundreds of millions from starvation. Limitations: HYVs required high fertiliser and water inputs (benefiting wealthier farmers with access to resources); increased monoculture of HYVs reduced diversity and increased vulnerability to pests; inequitable distribution of benefits (landless poor did not benefit); environmental costs (water table depletion in Punjab; fertiliser runoff; loss of traditional varieties); and yields have plateaued since the \(1990s\) (yield ceiling effect)$t$;

UPDATE questions SET
  explanation = $t$Genomic selection (Meuwissen Hayes Goddard 2001) has transformed dairy cattle breeding. Traditional BLUP (Best Linear Unbiased Prediction) estimated breeding values from phenotype and pedigree. Genomic BLUP uses 50,000-800,000 SNP genotypes to estimate breeding values with greater accuracy at younger ages. Genomic evaluation accuracy for young bulls without daughters reached 0.7 (vs 0.3 for pedigree alone). This allows selection of bulls at 2 years of age (vs 7 years previously) halving generation interval and doubling genetic gain per year. Equivalent approaches are now used in wheat maize soybean and other crops.$t$
WHERE id = 1959
  AND explanation = $t$Genomic selection (Meuwissen Hayes Goddard 2001) has transformed dairy cattle breeding. Traditional BLUP (Best Linear Unbiased Prediction) estimated breeding values from phenotype and pedigree. Genomic BLUP uses \(50\,000 - 800\,000 SNP\) genotypes to estimate breeding values with greater accuracy at younger ages. Genomic evaluation accuracy for young bulls without daughters reached 0.7 (vs 0.3 for pedigree alone). This allows selection of bulls at 2 years of age (vs 7 years previously) halving generation interval and doubling genetic gain per year. Equivalent approaches are now used in wheat maize soybean and other crops.$t$;

UPDATE questions SET
  option_a = $t$Evidence of benefits: Bt cotton adoption in India reduced insecticide costs by approximately $50 per hectare and increased yields by approximately 24% (Qaim and Zilberman 2003); Bt cotton adoption in China reduced insecticide use by 70% and increased farmer income. Disease-resistant cassava could protect the staple crop of 700 million Africans from viruses causing 30-40% yield losses. Evidence of challenges: trait licensing fees may make GM seeds more expensive than conventional varieties; dependency on seed companies reduces farmer autonomy; benefits depend on local pest pressure (minimal benefit in low-pest environments); and access to credit training and markets is needed for smallholders to capture the full benefit of improved varieties$t$
WHERE id = 1960
  AND option_a = $t$Evidence of benefits: Bt cotton adoption in India reduced insecticide costs by approximately $50 per hectare and increased yields by approximately 24% (Qaim and Zilberman 2003); Bt cotton adoption in China reduced insecticide use by 70% and increased farmer income. Disease-resistant cassava could protect the staple crop of 700 million Africans from viruses causing 30–40% yield losses. Evidence of challenges: trait licensing fees may make GM seeds more expensive than conventional varieties; dependency on seed companies reduces farmer autonomy; benefits depend on local pest pressure (minimal benefit in low-pest environments); and access to credit training and markets is needed for smallholders to capture the full benefit of improved varieties$t$;

UPDATE questions SET
  option_d = $t$Scientific rationale for: climate change projections indicate 20-40% yield losses in major crop regions by 2080 due to drought; conventional breeding for complex quantitative traits like drought tolerance is slow and limited; genetic engineering or gene editing can introduce specific drought-tolerance genes (e.g. DREB transcription factors that upregulate stress response genes; aquaporins improving water use efficiency) more rapidly; examples include DroughtGard maize (expressing the cspB gene from Bacillus subtilis improving stress tolerance approved in USA). Scientific rationale against: drought tolerance is a highly complex quantitative trait involving hundreds of genes; single gene modifications have generally shown modest effects in field conditions (often less impressive than laboratory results); off-target effects of stress-response transcription factors are common; and conventional and marker-assisted breeding of deeply rooted varieties and osmotic adjustment have achieved comparable improvements$t$,
  explanation = $t$Drought tolerance engineering illustrates the gap between simple traits (single enzyme deficiency — easily corrected) and complex quantitative traits. DREB (Dehydration-Responsive Element Binding) transcription factor approaches activate multiple drought response genes but constitutive expression causes growth penalties. Stress-inducible promoters reduce this problem. Field performance of DroughtGard maize shows 5-10% yield advantage under moderate drought — modest but commercially significant. The complexity challenge means drought tolerance engineering must be combined with conventional breeding of root architecture and osmotic adjustment traits.$t$
WHERE id = 1961
  AND option_d = $t$Scientific rationale for: climate change projections indicate 20–40% yield losses in major crop regions by 2080 due to drought; conventional breeding for complex quantitative traits like drought tolerance is slow and limited; genetic engineering or gene editing can introduce specific drought-tolerance genes (e.g. DREB transcription factors that upregulate stress response genes; aquaporins improving water use efficiency) more rapidly; examples include DroughtGard maize (expressing the cspB gene from Bacillus subtilis improving stress tolerance approved in USA). Scientific rationale against: drought tolerance is a highly complex quantitative trait involving hundreds of genes; single gene modifications have generally shown modest effects in field conditions (often less impressive than laboratory results); off-target effects of stress-response transcription factors are common; and conventional and marker-assisted breeding of deeply rooted varieties and osmotic adjustment have achieved comparable improvements$t$
  AND explanation = $t$Drought tolerance engineering illustrates the gap between simple traits (single enzyme deficiency — easily corrected) and complex quantitative traits. DREB (Dehydration-Responsive Element Binding) transcription factor approaches activate multiple drought response genes but constitutive expression causes growth penalties. Stress-inducible promoters reduce this problem. Field performance of DroughtGard maize shows 5–10% yield advantage under moderate drought — modest but commercially significant. The complexity challenge means drought tolerance engineering must be combined with conventional breeding of root architecture and osmotic adjustment traits.$t$;

UPDATE questions SET
  option_d = $t$Selective breeding: slow (10-20 years per variety); low precision (whole genome shuffled); scope limited to variation available within sexually compatible species — but proven safe and acceptable. Marker-assisted selection: moderate speed (5-10 years); improved precision (can select specific genomic regions); scope still limited to existing variation in crossing pool — but uses no foreign DNA. CRISPR gene editing: fast (1-2 years to create edited lines plus regulatory time); high precision (single nucleotide changes); scope can modify any endogenous sequence and with base editing introduce specific substitutions — depending on regulation may not require GMO approval if no foreign DNA is inserted. Together the three approaches form a spectrum of increasing speed and precision each suited to different breeding contexts$t$
WHERE id = 1962
  AND option_d = $t$Selective breeding: slow (10–20 years per variety); low precision (whole genome shuffled); scope limited to variation available within sexually compatible species — but proven safe and acceptable. Marker-assisted selection: moderate speed (5–10 years); improved precision (can select specific genomic regions); scope still limited to existing variation in crossing pool — but uses no foreign DNA. CRISPR gene editing: fast (1–2 years to create edited lines plus regulatory time); high precision (single nucleotide changes); scope can modify any endogenous sequence and with base editing introduce specific substitutions — depending on regulation may not require GMO approval if no foreign DNA is inserted. Together the three approaches form a spectrum of increasing speed and precision each suited to different breeding contexts$t$;

UPDATE questions SET
  explanation = $t$Humans have 23 pairs of chromosomes: 22 pairs of autosomes (non-sex chromosomes numbered 1-22) which are the same in both males and females and 1 pair of sex chromosomes (XX in females XY in males). Autosomes carry genes controlling most body characteristics.$t$
WHERE id = 1964
  AND explanation = $t$Humans have 23 pairs of chromosomes: 22 pairs of autosomes (non-sex chromosomes numbered \(1 - 22\)) which are the same in both males and females and 1 pair of sex chromosomes (XX in females XY in males). Autosomes carry genes controlling most body characteristics.$t$;

UPDATE questions SET
  explanation = $t$Cystic fibrosis (CF) is caused by mutations in the CFTR gene which encodes a chloride ion channel protein. The most common mutation (delta-F508) disrupts ion transport across cell membranes. This causes abnormally thick sticky mucus in the lungs digestive system and other organs. CF is inherited as an autosomal recessive condition — both parents must carry a faulty allele.$t$
WHERE id = 1966
  AND explanation = $t$Cystic fibrosis (CF) is caused by mutations in the CFTR gene which encodes a chloride ion channel protein. The most common mutation (delta\(- F508\)) disrupts ion transport across cell membranes. This causes abnormally thick sticky mucus in the lungs digestive system and other organs. CF is inherited as an autosomal recessive condition — both parents must carry a faulty allele.$t$;

UPDATE questions SET
  explanation = $t$Using a Punnett square with both parents as carriers (Cc x Cc): CC (normal 25%) Cc (carrier 25%) Cc (carrier 25%) cc (affected 25%). The probability of being homozygous recessive (cc) and therefore having cystic fibrosis is 25% or 1 in 4.$t$
WHERE id = 1968
  AND explanation = $t$Using a Punnett square with both parents as carriers (Cc × Cc): CC (normal 25%) Cc (carrier 25%) Cc (carrier 25%) cc (affected 25%). The probability of being homozygous recessive (cc) and therefore having cystic fibrosis is 25% or 1 in 4.$t$;

UPDATE questions SET
  explanation = $t$Huntington disease (HD) is caused by a CAG trinucleotide repeat expansion in the HTT gene producing a toxic gain-of-function mutant huntingtin protein. It is autosomal dominant — only one copy of the mutant allele is needed to cause the disease. Symptoms (progressive neurological decline: chorea personality changes cognitive impairment) typically begin at 30-50 years of age.$t$
WHERE id = 1969
  AND explanation = $t$Huntington disease (HD) is caused by a CAG trinucleotide repeat expansion in the HTT gene producing a toxic gain-of-function mutant huntingtin protein. It is autosomal dominant — only one copy of the mutant allele is needed to cause the disease. Symptoms (progressive neurological decline: chorea personality changes cognitive impairment) typically begin at 30–50 years of age.$t$;

UPDATE questions SET
  explanation = $t$A Punnett square (genetic diagram) is a tool for calculating the probability of offspring genotypes and phenotypes. For a monohybrid cross between two heterozygotes (Aa x Aa): alleles of parent 1 along the top (A and a) alleles of parent 2 down the side (A and a) giving four squares: AA Aa Aa aa. Genotype ratio 1:2:1. Phenotype ratio 3 dominant: 1 recessive.$t$
WHERE id = 1971
  AND explanation = $t$A Punnett square (genetic diagram) is a tool for calculating the probability of offspring genotypes and phenotypes. For a monohybrid cross between two heterozygotes (Aa × Aa): alleles of parent 1 along the top (A and \(a\)) alleles of parent 2 down the side (A and \(a\)) giving four squares: AA Aa Aa aa. Genotype ratio \(1 : 2 : 1\). Phenotype ratio 3 dominant: 1 recessive.$t$;

UPDATE questions SET
  option_a = $t$Because the dominant allele means that if a parent has one copy of the Huntington allele there is a 50% chance each child will inherit it; and because symptoms do not appear until 30-50 years of age meaning affected individuals may have had children (and passed the allele on) before they knew they were affected. There is currently no cure$t$
WHERE id = 1972
  AND option_a = $t$Because the dominant allele means that if a parent has one copy of the Huntington allele there is a 50% chance each child will inherit it; and because symptoms do not appear until 30–50 years of age meaning affected individuals may have had children (and passed the allele on) before they knew they were affected. There is currently no cure$t$;

UPDATE questions SET
  explanation = $t$X-linked recessive inheritance pattern: affected males have the allele on their only X chromosome (X^a Y). Carrier females have one affected and one normal allele (X^A X^a) and do not show the condition. Affected females (X^a X^a) require two copies — much less common. This explains why X-linked conditions are far more common in males. Examples: red-green colour blindness (affects approximately 8% of males 0.5% of females); haemophilia A (Factor VIII deficiency); and Duchenne muscular dystrophy.$t$
WHERE id = 1973
  AND explanation = $t$X-linked recessive inheritance pattern: affected males have the allele on their only X chromosome \((X^{a} Y)\). Carrier females have one affected and one normal allele \((X^{A} X^{a})\) and do not show the condition. Affected females \((X^{a} X^{a})\) require two copies — much less common. This explains why X-linked conditions are far more common in males. Examples: red-green colour blindness (affects approximately 8% of males 0.5% of females); haemophilia A (Factor VIII deficiency); and Duchenne muscular dystrophy.$t$;

UPDATE questions SET
  question_text = $t$A woman who is a carrier for haemophilia (X^H X^h) has children with a man who does not have haemophilia (X^H Y). What is the probability of their son having haemophilia?$t$,
  option_b = $t$50% — each son has a 50% chance of receiving the X^h chromosome from the carrier mother$t$,
  explanation = $t$Punnett square: mother X^H X^h x father X^H Y. Possible offspring: X^H X^H (unaffected girl) X^H X^h (carrier girl) X^H Y (unaffected boy) X^h Y (affected boy). Each son either inherits X^H (50% — unaffected) or X^h (50% — haemophilia). So 50% of sons will have haemophilia and 50% will be unaffected. Overall only 25% of all children will have haemophilia.$t$
WHERE id = 1974
  AND question_text = $t$A woman who is a carrier for haemophilia \((X^{H} X^{h})\) has children with a man who does not have haemophilia \((X^{H} Y)\). What is the probability of their son having haemophilia?$t$
  AND option_b = $t$50% — each son has a 50% chance of receiving the \(X^{h}\) chromosome from the carrier mother$t$
  AND explanation = $t$Punnett square: mother \(X^{H} X^{h} x\) father \(X^{H} Y\). Possible offspring: \(X^{H} X^{H}\) (unaffected girl) \(X^{H} X^{h}\) (carrier girl) \(X^{H} Y\) (unaffected boy) \(X^{h} Y\) (affected boy). Each son either inherits \(X^{H}\) (50% — unaffected) or \(X^{h}\) (50% — haemophilia). So 50% of sons will have haemophilia and 50% will be unaffected. Overall only 25% of all children will have haemophilia.$t$;

UPDATE questions SET
  explanation = $t$The probability argument: for haemophilia (frequency approximately 1 in 5000 males) to occur in a female she must receive the allele from a carrier or affected mother AND from an affected father. This is approximately (1/5000) x (1/100 females are carriers) = approximately 1 in 500,000 — much rarer. This explains the dramatic sex ratio in X-linked recessive conditions. X-inactivation in females (Lyon hypothesis) means each cell randomly inactivates one X making heterozygous females a mosaic of cells expressing either allele.$t$
WHERE id = 1975
  AND explanation = $t$The probability argument: for haemophilia (frequency approximately 1 in 5000 males) to occur in a female she must receive the allele from a carrier or affected mother AND from an affected father. This is approximately \((\frac{1}{5000}) \times\) (\(\frac{1}{100}\) females are carriers) = approximately 1 in 500 000 — much rarer. This explains the dramatic sex ratio in X-linked recessive conditions. X-inactivation in females (Lyon hypothesis) means each cell randomly inactivates one X making heterozygous females a mosaic of cells expressing either allele.$t$;

UPDATE questions SET
  explanation = $t$Punnett square (Aa x Aa): AA (25%) Aa (25%) Aa (25%) aa (25%). Therefore: (i) affected (aa) = 25%; (ii) carrier (Aa) = 50%; (iii) homozygous dominant (AA) — not a carrier and unaffected = 25%. Note that in reality a carrier cannot be distinguished from an unaffected non-carrier without genetic testing (both show the dominant phenotype).$t$
WHERE id = 1976
  AND explanation = $t$Punnett square (Aa × Aa): AA (25%) Aa (25%) Aa (25%) aa (25%). Therefore: (i) affected (aa) \(= 25\%\); (ii) carrier (Aa) \(= 50\%\); (iii) homozygous dominant (AA) — not a carrier and unaffected \(= 25\%\). Note that in reality a carrier cannot be distinguished from an unaffected non-carrier without genetic testing (both show the dominant phenotype).$t$;

UPDATE questions SET
  option_b = $t$Cystic fibrosis is caused by mutations in the CFTR gene encoding the cystic fibrosis transmembrane conductance regulator — a chloride ion channel in epithelial cell membranes. The most common mutation (delta-F508) causes the CFTR protein to misfold and be degraded by the cell (class II mutation — processing defect). Loss of functional CFTR reduces chloride (and therefore water) secretion into the airway surface liquid causing thick dehydrated mucus. Targeted drug treatments (CFTR modulators): Ivacaftor (potentiates residual CFTR function for gating mutations — class III); Tezacaftor/Elexacaftor correct the folding defect of delta-F508 (class II) allowing normal trafficking to the membrane. Trikafta (triple combination) reduces lung decline by approximately 63% in patients with at least one delta-F508 allele$t$,
  explanation = $t$Understanding the molecular pathology of CF has enabled precision medicine. Different CFTR mutations cause different molecular defects: class I (no protein produced) class II (processing/folding defect — most common delta-F508) class III (gating defect — protein reaches membrane but does not open properly) class IV (reduced conductance) class V (reduced amount). CFTR modulators target specific molecular defects: potentiators (Ivacaftor) open the channel; correctors (Lumacaftor Tezacaftor Elexacaftor) improve folding and trafficking. Trikafta (Elexacaftor + Tezacaftor + Ivacaftor) is transformative for approximately 90% of CF patients with at least one delta-F508 allele.$t$
WHERE id = 1981
  AND option_b = $t$Cystic fibrosis is caused by mutations in the CFTR gene encoding the cystic fibrosis transmembrane conductance regulator — a chloride ion channel in epithelial cell membranes. The most common mutation (delta\(- F508\)) causes the CFTR protein to misfold and be degraded by the cell (class II mutation — processing defect). Loss of functional CFTR reduces chloride (and therefore water) secretion into the airway surface liquid causing thick dehydrated mucus. Targeted drug treatments (CFTR modulators): Ivacaftor (potentiates residual CFTR function for gating mutations — class III); Tezacaftor/Elexacaftor correct the folding defect of delta\(- F508\) (class II) allowing normal trafficking to the membrane. Trikafta (triple combination) reduces lung decline by approximately 63% in patients with at least one delta\(- F508\) allele$t$
  AND explanation = $t$Understanding the molecular pathology of CF has enabled precision medicine. Different CFTR mutations cause different molecular defects: class I (no protein produced) class II (processing/folding defect — most common delta\(- F508\)) class III (gating defect — protein reaches membrane but does not open properly) class IV (reduced conductance) class V (reduced amount). CFTR modulators target specific molecular defects: potentiators (Ivacaftor) open the channel; correctors (Lumacaftor Tezacaftor Elexacaftor) improve folding and trafficking. Trikafta (Elexacaftor + Tezacaftor + Ivacaftor) is transformative for approximately 90% of CF patients with at least one delta\(- F508\) allele.$t$;

UPDATE questions SET
  option_a = $t$Options include: 1) Natural pregnancy with prenatal diagnosis (amniocentesis or chorionic villus sampling at 10-16 weeks to determine fetal sex and genotype — termination offered if affected male is identified); 2) Pre-implantation genetic diagnosis (PGD) combined with IVF — embryos are created in vitro and one or two cells are removed and tested at day 5; only unaffected embryos are transferred eliminating the need for termination; 3) Using donor eggs from a non-carrier; 4) Adoption. Each option has ethical considerations: prenatal diagnosis involves the possibility of termination; PGD raises questions about embryo selection and the moral status of embryos; and all options involve significant medical intervention and cost$t$,
  explanation = $t$PGD (pre-implantation genetic diagnosis) has transformed reproductive options for couples at risk of serious genetic conditions. PGD involves IVF superovulation embryo biopsy (1-2 cells at day 3 or trophectoderm biopsy at day 5) genetic testing (PCR or whole genome amplification + next-generation sequencing) and transfer of only unaffected embryos. For X-linked conditions PGD allows selection of female embryos (who will be at most carriers) or selection of unaffected males. The procedure has over 95% diagnostic accuracy and avoids the need for termination of naturally conceived pregnancies.$t$
WHERE id = 1982
  AND option_a = $t$Options include: 1) Natural pregnancy with prenatal diagnosis (amniocentesis or chorionic villus sampling at 10–16 weeks to determine fetal sex and genotype — termination offered if affected male is identified); 2) Pre-implantation genetic diagnosis (PGD) combined with IVF — embryos are created in vitro and one or two cells are removed and tested at day 5; only unaffected embryos are transferred eliminating the need for termination; 3) Using donor eggs from a non-carrier; 4) Adoption. Each option has ethical considerations: prenatal diagnosis involves the possibility of termination; PGD raises questions about embryo selection and the moral status of embryos; and all options involve significant medical intervention and cost$t$
  AND explanation = $t$PGD (pre-implantation genetic diagnosis) has transformed reproductive options for couples at risk of serious genetic conditions. PGD involves IVF superovulation embryo biopsy (1–2 cells at day 3 or trophectoderm biopsy at day 5) genetic testing (PCR or whole genome amplification + next-generation sequencing) and transfer of only unaffected embryos. For X-linked conditions PGD allows selection of female embryos (who will be at most carriers) or selection of unaffected males. The procedure has over 95% diagnostic accuracy and avoids the need for termination of naturally conceived pregnancies.$t$;

UPDATE questions SET
  explanation = $t$When both parents are carriers (Cc x Cc): genotype probabilities are CC (25%) Cc (50%) cc (25%). Only cc individuals have cystic fibrosis. Therefore the probability of having an affected child is 25% (1 in 4) for each pregnancy.$t$
WHERE id = 1986
  AND explanation = $t$When both parents are carriers (Cc × Cc): genotype probabilities are CC (25%) Cc (50%) cc (25%). Only cc individuals have cystic fibrosis. Therefore the probability of having an affected child is 25% (1 in 4) for each pregnancy.$t$;

UPDATE questions SET
  option_b = $t$Pre-natal genetic testing involves testing fetal DNA during pregnancy to detect chromosomal abnormalities (e.g. Down syndrome trisomy 21) or specific genetic mutations. Methods include: amniocentesis (amniotic fluid sampled at 15+ weeks carries small miscarriage risk) and chorionic villus sampling (CVS at 10-14 weeks also carries a small miscarriage risk) and non-invasive prenatal testing (NIPT using fetal DNA in maternal blood). Offered when: advanced maternal age (increased chromosomal abnormality risk) family history of genetic conditions abnormal ultrasound findings or carrier screening of parents identifies a risk$t$,
  explanation = $t$Pre-natal genetic testing has transformed obstetric practice. NIPT (non-invasive prenatal testing) analyses fetal DNA fragments in maternal blood to detect chromosomal aneuploidies (trisomy 21 18 13) with approximately 99% sensitivity and specificity for Down syndrome. It carries no miscarriage risk. Diagnostic amniocentesis or CVS (with approximately 0.5-1% miscarriage risk) provides definitive cytogenetic or molecular diagnosis. Ethical issues: the results may prompt a decision about pregnancy termination which raises significant ethical questions for many families.$t$
WHERE id = 1988
  AND option_b = $t$Pre-natal genetic testing involves testing fetal DNA during pregnancy to detect chromosomal abnormalities (e.g. Down syndrome trisomy 21) or specific genetic mutations. Methods include: amniocentesis (amniotic fluid sampled at 15+ weeks carries small miscarriage risk) and chorionic villus sampling (CVS at 10–14 weeks also carries a small miscarriage risk) and non-invasive prenatal testing (NIPT using fetal DNA in maternal blood). Offered when: advanced maternal age (increased chromosomal abnormality risk) family history of genetic conditions abnormal ultrasound findings or carrier screening of parents identifies a risk$t$
  AND explanation = $t$Pre-natal genetic testing has transformed obstetric practice. NIPT (non-invasive prenatal testing) analyses fetal DNA fragments in maternal blood to detect chromosomal aneuploidies (trisomy 21 18 13) with approximately 99% sensitivity and specificity for Down syndrome. It carries no miscarriage risk. Diagnostic amniocentesis or CVS (with approximately 0.5–1% miscarriage risk) provides definitive cytogenetic or molecular diagnosis. Ethical issues: the results may prompt a decision about pregnancy termination which raises significant ethical questions for many families.$t$;

UPDATE questions SET
  explanation = $t$Father Hh (affected heterozygous) x Mother hh (unaffected): gametes from father are H (50%) or h (50%). Each child has a 50% chance of inheriting the H allele and being affected (Hh) and a 50% chance of inheriting the h allele and being unaffected (hh). Since Huntington disease is dominant one copy is enough to cause disease.$t$
WHERE id = 1989
  AND explanation = $t$Father Hh (affected heterozygous) \(x\) Mother hh (unaffected): gametes from father are H (50%) or h (50%). Each child has a 50% chance of inheriting the H allele and being affected (Hh) and a 50% chance of inheriting the \(h\) allele and being unaffected (hh). Since Huntington disease is dominant one copy is enough to cause disease.$t$;

UPDATE questions SET
  question_text = $t$A red-green colour blind man (X^c Y) has children with a woman who has normal colour vision and whose father was colour blind. What proportion of their children would be expected to be colour blind?$t$,
  explanation = $t$The womans father was colour blind (X^c Y) so she inherited his X^c chromosome. Her genotype is X^C X^c (carrier). Cross: X^C X^c x X^c Y. Offspring: X^C X^c (carrier daughter) X^c X^c (colour blind daughter) X^C Y (normal son) X^c Y (colour blind son) — 25% each. So 25% of all children will be colour blind sons and an additional 25% will be colour blind daughters. Total colour blind = 50% but only 25% of all children are colour blind sons from this specific cross.$t$
WHERE id = 1991
  AND question_text = $t$A red-green colour blind man \((X^{c} Y)\) has children with a woman who has normal colour vision and whose father was colour blind. What proportion of their children would be expected to be colour blind?$t$
  AND explanation = $t$The womans father was colour blind \((X^{c} Y)\) so she inherited his \(X^{c}\) chromosome. Her genotype is \(X^{C} X^{c}\) (carrier). Cross: \(X^{C} X^{c} \times X^{c} Y\). Offspring: \(X^{C} X^{c}\) (carrier daughter) \(X^{c} X^{c}\) (colour blind daughter) \(X^{C} Y\) (normal son) \(X^{c} Y\) (colour blind son) — 25% each. So 25% of all children will be colour blind sons and an additional 25% will be colour blind daughters. Total colour blind \(= 50\%\) but only 25% of all children are colour blind sons from this specific cross.$t$;

UPDATE questions SET
  explanation = $t$IVF with PGD is a genuine reproductive option for couples at high genetic risk (25% or 50% per pregnancy). For cystic fibrosis (25% risk) PGD reduces the risk of having an affected child to approximately 0% (with very high diagnostic accuracy). The process involves controlled ovarian stimulation egg retrieval fertilisation embryo culture to day 5 biopsy of 5-6 trophectoderm cells genetic analysis and transfer of unaffected embryos. The main disadvantages are cost (typically £8,000-12,000 per cycle in the UK) lower success rates than natural conception and the ethical questions around embryo selection.$t$
WHERE id = 1992
  AND explanation = $t$IVF with PGD is a genuine reproductive option for couples at high genetic risk (25% or 50% per pregnancy). For cystic fibrosis (25% risk) PGD reduces the risk of having an affected child to approximately 0% (with very high diagnostic accuracy). The process involves controlled ovarian stimulation egg retrieval fertilisation embryo culture to day 5 biopsy of 5–6 trophectoderm cells genetic analysis and transfer of unaffected embryos. The main disadvantages are cost (typically \(\text{£}8\,000 - 12\,000\) per cycle in the UK) lower success rates than natural conception and the ethical questions around embryo selection.$t$;

UPDATE questions SET
  option_d = $t$Hardy-Weinberg principle: in a large randomly mating population where no mutation migration selection or genetic drift occurs allele frequencies remain constant from generation to generation. If allele p has frequency p and allele q has frequency q (where p+q=1) then genotype frequencies are p^2 (homozygous dominant) 2pq (heterozygous) q^2 (homozygous recessive). Conditions: no mutation; random mating; no selection; no migration; and infinite population size. Departures indicate: selection against a genotype; non-random mating (inbreeding reduces heterozygotes); genetic drift in small populations; or migration changing allele frequencies$t$,
  explanation = $t$Hardy-Weinberg is a mathematical null model for population genetics. Its power is in detecting departures: if observed genotype frequencies differ from expected (p^2 2pq q^2) one of the conditions is violated. Medical application: Hardy-Weinberg can estimate carrier frequency from disease incidence. If CF affects q^2 = 1/2500 then q = 1/50 and carrier frequency = 2pq approximately 2 x 1/50 = 1/25. Non-random mating (consanguinity) increases q^2 above Hardy-Weinberg prediction — relevant in populations where cousin marriage is common.$t$
WHERE id = 1994
  AND option_d = $t$Hardy-Weinberg principle: in a large randomly mating population where no mutation migration selection or genetic drift occurs allele frequencies remain constant from generation to generation. If allele \(p\) has frequency \(p\) and allele \(q\) has frequency \(q\) (where \(p + q = 1\)) then genotype frequencies are \(p^{2}\) (homozygous dominant) 2pq (heterozygous) \(q^{2}\) (homozygous recessive). Conditions: no mutation; random mating; no selection; no migration; and infinite population size. Departures indicate: selection against a genotype; non-random mating (inbreeding reduces heterozygotes); genetic drift in small populations; or migration changing allele frequencies$t$
  AND explanation = $t$Hardy-Weinberg is a mathematical null model for population genetics. Its power is in detecting departures: if observed genotype frequencies differ from expected \((p^{2} 2pq q^{2})\) one of the conditions is violated. Medical application: Hardy-Weinberg can estimate carrier frequency from disease incidence. If CF affects \(q^{2} = \frac{1}{2500}\) then \(q = \frac{1}{50}\) and carrier frequency \(= 2pq\) approximately \(2 \times \frac{1}{50} = \frac{1}{25}\). Non-random mating (consanguinity) increases \(q^{2}\) above Hardy-Weinberg prediction — relevant in populations where cousin marriage is common.$t$;

UPDATE questions SET
  explanation = $t$Epigenetics is particularly important for understanding exceptions to Mendelian genetics. Genomic imprinting: both Prader-Willi (maternal disomy or paternal deletion of 15q11-q13) and Angelman syndrome (paternal disomy or maternal deletion of the same region) result from the same chromosomal change — but which parent contributes the abnormal chromosome determines the condition because different genes in the region are imprinted (maternally or paternally expressed). This parent-of-origin effect cannot be explained by sequence genetics alone.$t$
WHERE id = 1995
  AND explanation = $t$Epigenetics is particularly important for understanding exceptions to Mendelian genetics. Genomic imprinting: both Prader-Willi (maternal disomy or paternal deletion of \(15q11 - q13\)) and Angelman syndrome (paternal disomy or maternal deletion of the same region) result from the same chromosomal change — but which parent contributes the abnormal chromosome determines the condition because different genes in the region are imprinted (maternally or paternally expressed). This parent-of-origin effect cannot be explained by sequence genetics alone.$t$;

UPDATE questions SET
  explanation = $t$GWAS since 2007 (first large GWAS — Wellcome Trust Case Control Consortium 2007 testing 7 diseases) have profoundly changed disease biology. Key discoveries: over 1000 loci associated with type 2 diabetes; approximately 200+ loci for schizophrenia; FTO locus as the first robust obesity GWAS finding. Most GWAS hits are common variants with small effects (OR 1.05-1.30). The missing heritability problem (identified variants explain far less heritability than twin studies suggest) remains active research: explanations include rare variants (not tagged by GWAS) gene-gene interactions and copy number variants.$t$
WHERE id = 2000
  AND explanation = $t$GWAS since 2007 (first large GWAS — Wellcome Trust Case Control Consortium 2007 testing 7 diseases) have profoundly changed disease biology. Key discoveries: over 1000 loci associated with type 2 diabetes; approximately 200+ loci for schizophrenia; FTO locus as the first robust obesity GWAS finding. Most GWAS hits are common variants with small effects (OR \(1.05 - 1.30\)). The missing heritability problem (identified variants explain far less heritability than twin studies suggest) remains active research: explanations include rare variants (not tagged by GWAS) gene-gene interactions and copy number variants.$t$;

UPDATE questions SET
  option_d = $t$NIPT: analyses cell-free fetal DNA in maternal blood (approximately 10% of total cell-free DNA is fetal by 10 weeks). No miscarriage risk. Highly accurate for common trisomies (T21 T18 T13) — sensitivity approximately 99% specificity approximately 99.9%. Limitations: does not diagnose all chromosomal abnormalities; false positives occur from confined placental mosaicism or maternal chromosomal abnormalities; does not detect single gene disorders unless specifically designed to. Amniocentesis: samples amniotic fluid containing fetal cells at 15-20 weeks. Provides full karyotype and can detect any chromosomal abnormality. Miscarriage risk approximately 0.5-1%. Can also test for specific gene mutations. Ethical implications: both can lead to pregnancy termination decisions; NIPT as a screening test requires clear counselling about its limitations; the ease of NIPT may normalise prenatal testing without adequate counselling$t$,
  explanation = $t$NIPT has transformed prenatal screening since its clinical introduction around 2011-2012. Its near-universal adoption in high-income countries as a first-line screening test has dramatically reduced the number of amniocenteses performed (reducing procedure-related miscarriages). However NIPT is a screening test not a diagnostic test — positive NIPT results require confirmation by amniocentesis or CVS before clinical decisions are made. The ease and perceived accuracy of NIPT raises concerns about inadequate pre- and post-test counselling particularly regarding the implications of results for pregnancy decision-making.$t$
WHERE id = 2001
  AND option_d = $t$NIPT: analyses cell-free fetal DNA in maternal blood (approximately 10% of total cell-free DNA is fetal by 10 weeks). No miscarriage risk. Highly accurate for common trisomies (T21 T18 T13) — sensitivity approximately 99% specificity approximately 99.9%. Limitations: does not diagnose all chromosomal abnormalities; false positives occur from confined placental mosaicism or maternal chromosomal abnormalities; does not detect single gene disorders unless specifically designed to. Amniocentesis: samples amniotic fluid containing fetal cells at 15–20 weeks. Provides full karyotype and can detect any chromosomal abnormality. Miscarriage risk approximately 0.5–1%. Can also test for specific gene mutations. Ethical implications: both can lead to pregnancy termination decisions; NIPT as a screening test requires clear counselling about its limitations; the ease of NIPT may normalise prenatal testing without adequate counselling$t$
  AND explanation = $t$NIPT has transformed prenatal screening since its clinical introduction around \(2011 - 2012\). Its near-universal adoption in high-income countries as a first-line screening test has dramatically reduced the number of amniocenteses performed (reducing procedure-related miscarriages). However NIPT is a screening test not a diagnostic test — positive NIPT results require confirmation by amniocentesis or CVS before clinical decisions are made. The ease and perceived accuracy of NIPT raises concerns about inadequate pre- and post-test counselling particularly regarding the implications of results for pregnancy decision-making.$t$;

UPDATE questions SET
  option_a = $t$Genetic data is uniquely sensitive because: it is immutable (cannot be changed unlike a password); it is shared with biological relatives (a persons genome reveals information about siblings parents and children who may not have consented); it can potentially identify individuals even from supposedly anonymous datasets (genomic re-identification); it may reveal unexpected family relationships (non-paternity previously unknown donor conception); and it has potential uses in insurance employment and legal contexts. Large genomic databases (UK Biobank: 500,000 participants; deCODE genetics: almost entire Icelandic population) provide enormous scientific value but raise concerns: data security and breach risk; secondary use of data beyond original consent; commercial access to genetic data by pharmaceutical companies; and the possibility of law enforcement use without consent (as demonstrated by forensic genetic genealogy solving cold cases using public databases like GEDmatch)$t$
WHERE id = 2002
  AND option_a = $t$Genetic data is uniquely sensitive because: it is immutable (cannot be changed unlike a password); it is shared with biological relatives (a persons genome reveals information about siblings parents and children who may not have consented); it can potentially identify individuals even from supposedly anonymous datasets (genomic re-identification); it may reveal unexpected family relationships (non-paternity previously unknown donor conception); and it has potential uses in insurance employment and legal contexts. Large genomic databases (UK Biobank: 500 000 participants; deCODE genetics: almost entire Icelandic population) provide enormous scientific value but raise concerns: data security and breach risk; secondary use of data beyond original consent; commercial access to genetic data by pharmaceutical companies; and the possibility of law enforcement use without consent (as demonstrated by forensic genetic genealogy solving cold cases using public databases like GEDmatch)$t$;

UPDATE questions SET
  explanation = $t$Gregor Mendel (1822-1884) was an Augustinian friar who conducted systematic breeding experiments with pea plants (Pisum sativum) from 1856 to 1863. He identified the principles of segregation and independent assortment which form the foundation of modern genetics. His work was largely ignored during his lifetime and was rediscovered in 1900.$t$
WHERE id = 2003
  AND explanation = $t$Gregor Mendel \((1822 - 1884)\) was an Augustinian friar who conducted systematic breeding experiments with pea plants (Pisum sativum) from 1856 to 1863. He identified the principles of segregation and independent assortment which form the foundation of modern genetics. His work was largely ignored during his lifetime and was rediscovered in 1900.$t$;

UPDATE questions SET
  explanation = $t$Carolus Linnaeus (1707-1778) developed the hierarchical classification system with the binomial nomenclature we still use today. The hierarchy from most to least inclusive: Kingdom Phylum Class Order Family Genus Species. Mnemonic: King Philip Came Over For Good Soup. The scientific name uses the genus (capitalised) and species (lowercase) in italic.$t$
WHERE id = 2008
  AND explanation = $t$Carolus Linnaeus \((1707 - 1778)\) developed the hierarchical classification system with the binomial nomenclature we still use today. The hierarchy from most to least inclusive: Kingdom Phylum Class Order Family Genus Species. Mnemonic: King Philip Came Over For Good Soup. The scientific name uses the genus (capitalised) and species (lowercase) in italic.$t$;

UPDATE questions SET
  explanation = $t$Binomial nomenclature (Linnaeus 1753-1758) provides a unique standardised two-part name for each species. Format: Genus species (e.g. Panthera leo for the lion; Mus musculus for the house mouse). The genus name is shared by closely related species (Panthera also includes P. tigris tiger P. pardus leopard). Scientific names are universally recognised across languages resolving the ambiguity of common names (e.g. the word robin refers to different birds in the UK and USA).$t$
WHERE id = 2011
  AND explanation = $t$Binomial nomenclature (Linnaeus \(1753 - 1758\)) provides a unique standardised two-part name for each species. Format: Genus species (e.g. Panthera leo for the lion; Mus musculus for the house mouse). The genus name is shared by closely related species (Panthera also includes P. tigris tiger P. pardus leopard). Scientific names are universally recognised across languages resolving the ambiguity of common names (e.g. the word robin refers to different birds in the UK and USA).$t$;

UPDATE questions SET
  explanation = $t$Mendels delayed recognition is a classic story in the sociology of science. The timing was unfortunate: published 7 years after Darwins Origin of Species when biologists were focused on continuous variation and Darwinian gradual change. Mendels discontinuous traits (wrinkled vs smooth peas) seemed irrelevant to Darwinian evolution. The statistical analysis was genuinely unusual for biology in 1866. The chromosome theory of inheritance (Boveri and Sutton 1902-1904) provided the physical mechanism that made Mendels abstract factors comprehensible to cell biologists.$t$
WHERE id = 2013
  AND explanation = $t$Mendels delayed recognition is a classic story in the sociology of science. The timing was unfortunate: published 7 years after Darwins Origin of Species when biologists were focused on continuous variation and Darwinian gradual change. Mendels discontinuous traits (wrinkled vs smooth peas) seemed irrelevant to Darwinian evolution. The statistical analysis was genuinely unusual for biology in 1866. The chromosome theory of inheritance (Boveri and Sutton \(1902 - 1904\)) provided the physical mechanism that made Mendels abstract factors comprehensible to cell biologists.$t$;

UPDATE questions SET
  option_d = $t$Molecular evidence for evolution: 1) DNA sequence similarity — closely related species share more similar DNA sequences (humans and chimpanzees share approximately 98.8% of DNA sequence); 2) Universal genetic code — all life uses essentially the same codons confirming common ancestry; 3) Cytochrome c sequence similarity closely matches the phylogenetic tree derived from morphological evidence; 4) Endogenous retroviruses — same viral DNA inserts found at identical chromosomal positions in humans and chimps confirming common ancestry; 5) Comparative genomics reveals HOX gene conservation across hugely diverse animal phyla confirming deep common ancestry; 6) Direct observation of evolution in antibiotic-resistant bacteria HIV drug resistance and laboratory evolution experiments (Lenski E. coli long-term evolution experiment)$t$,
  explanation = $t$Molecular phylogenetics has revolutionised evolutionary biology. The molecular clock (Zuckerkandl and Pauling 1965) uses the rate of accumulation of neutral mutations to date divergence times. Endogenous retroviral insertions are particularly powerful evidence: a retrovirus integrated at a specific genomic location in a common ancestor would be inherited by all descendants at the same chromosomal position — humans and all great apes share hundreds of identical ERV insertions confirming common descent. The Lenski experiment (1988-present in E. coli over 75,000+ generations) has directly observed evolutionary changes including the evolution of citrate utilisation — a new metabolic capability.$t$
WHERE id = 2014
  AND option_d = $t$Molecular evidence for evolution: 1) DNA sequence similarity — closely related species share more similar DNA sequences (humans and chimpanzees share approximately 98.8% of DNA sequence); 2) Universal genetic code — all life uses essentially the same codons confirming common ancestry; 3) Cytochrome \(c\) sequence similarity closely matches the phylogenetic tree derived from morphological evidence; 4) Endogenous retroviruses — same viral DNA inserts found at identical chromosomal positions in humans and chimps confirming common ancestry; 5) Comparative genomics reveals HOX gene conservation across hugely diverse animal phyla confirming deep common ancestry; 6) Direct observation of evolution in antibiotic-resistant bacteria HIV drug resistance and laboratory evolution experiments (Lenski E. coli long-term evolution experiment)$t$
  AND explanation = $t$Molecular phylogenetics has revolutionised evolutionary biology. The molecular clock (Zuckerkandl and Pauling 1965) uses the rate of accumulation of neutral mutations to date divergence times. Endogenous retroviral insertions are particularly powerful evidence: a retrovirus integrated at a specific genomic location in a common ancestor would be inherited by all descendants at the same chromosomal position — humans and all great apes share hundreds of identical ERV insertions confirming common descent. The Lenski experiment (1988-present in E. coli over 75 000+ generations) has directly observed evolutionary changes including the evolution of citrate utilisation — a new metabolic capability.$t$;

UPDATE questions SET
  explanation = $t$Carl Woese analysis of 16S and 18S ribosomal RNA sequences (1977) revealed that the archaea (initially called archaebacteria) were not closely related to bacteria despite sharing the prokaryotic cell plan. Comparison of rRNA sequences showed archaea were more closely related to eukaryotes than to bacteria — a completely unexpected finding that revolutionised our understanding of the tree of life. The discovery of a third domain required reorganising all of biology. Modern molecular phylogenetics (using whole genome data) continues to refine the tree of life revealing unexpected evolutionary relationships.$t$
WHERE id = 2015
  AND explanation = $t$Carl Woese analysis of \(16S\) and \(18S\) ribosomal RNA sequences (1977) revealed that the archaea (initially called archaebacteria) were not closely related to bacteria despite sharing the prokaryotic cell plan. Comparison of rRNA sequences showed archaea were more closely related to eukaryotes than to bacteria — a completely unexpected finding that revolutionised our understanding of the tree of life. The discovery of a third domain required reorganising all of biology. Modern molecular phylogenetics (using whole genome data) continues to refine the tree of life revealing unexpected evolutionary relationships.$t$;

UPDATE questions SET
  explanation = $t$The definition of life and the status of viruses is a genuine philosophical and biological question. The hallmarks of life typically cited (cellular organisation metabolism reproduction response to environment) are not all met by viruses. The discovery of giant viruses (mimiviruses megaviruses) blurs the boundary further — some giant viruses have genes encoding translation components (though not functional ribosomes) and are parasitised by smaller viruses (virophages). The virosphere (approximately 10^31 virus particles on Earth) participates in evolutionary processes and likely influenced the evolution of cellular life.$t$
WHERE id = 2020
  AND explanation = $t$The definition of life and the status of viruses is a genuine philosophical and biological question. The hallmarks of life typically cited (cellular organisation metabolism reproduction response to environment) are not all met by viruses. The discovery of giant viruses (mimiviruses megaviruses) blurs the boundary further — some giant viruses have genes encoding translation components (though not functional ribosomes) and are parasitised by smaller viruses (virophages). The virosphere (approximately \(10^{31}\) virus particles on Earth) participates in evolutionary processes and likely influenced the evolution of cellular life.$t$;

UPDATE questions SET
  option_c = $t$The F1 generation is the first filial generation — the offspring of the parental (P) generation cross. Mendel observed that when he crossed two true-breeding plants with contrasting traits (e.g. tall x short) all F1 offspring showed only one of the two parental traits (the dominant trait). The other trait (recessive) appeared to disappear$t$,
  explanation = $t$Mendels key observation from the F1 generation: when he crossed tall (TT) x short (tt) pea plants all F1 offspring were tall (Tt). This disproved blending inheritance (which would predict intermediate height). The observation that one trait completely masked the other led to the concepts of dominant and recessive alleles. The disappearing trait (recessive) was not destroyed — it reappeared in the F2 generation.$t$
WHERE id = 2025
  AND option_c = $t$The F1 generation is the first filial generation — the offspring of the parental (P) generation cross. Mendel observed that when he crossed two true-breeding plants with contrasting traits (e.g. tall × short) all F1 offspring showed only one of the two parental traits (the dominant trait). The other trait (recessive) appeared to disappear$t$
  AND explanation = $t$Mendels key observation from the F1 generation: when he crossed tall (TT) \(x\) short (tt) pea plants all F1 offspring were tall (Tt). This disproved blending inheritance (which would predict intermediate height). The observation that one trait completely masked the other led to the concepts of dominant and recessive alleles. The disappearing trait (recessive) was not destroyed — it reappeared in the F2 generation.$t$;

UPDATE questions SET
  option_a = $t$A 1:1 ratio showing that half the offspring are dominant and half recessive$t$,
  option_b = $t$A 3:1 ratio (3 showing the dominant trait: 1 showing the recessive trait) showing that the recessive trait was not lost in F1 but was present in a masked form. This ratio revealed that the hereditary units (alleles) separated into gametes and recombined in the offspring$t$,
  option_c = $t$A 2:1 ratio showing that the dominant allele is twice as common as the recessive$t$,
  option_d = $t$A 4:0 ratio showing that the dominant trait always wins$t$,
  explanation = $t$The 3:1 F2 ratio (from F1 x F1 = Aa x Aa): AA (25%) Aa (50%) aa (25%) phenotype ratio 3 dominant : 1 recessive. This ratio is remarkable because it reveals that the F1 plants were heterozygous (carrying both alleles) but only expressing one. The alleles must have remained separate (particulate not blended) to be available for independent transmission to F2 offspring. This was Mendels crucial insight: hereditary factors are discrete particles not blended fluids.$t$
WHERE id = 2026
  AND option_a = $t$A \(1 : 1\) ratio showing that half the offspring are dominant and half recessive$t$
  AND option_b = $t$A \(3 : 1\) ratio (3 showing the dominant trait: 1 showing the recessive trait) showing that the recessive trait was not lost in F1 but was present in a masked form. This ratio revealed that the hereditary units (alleles) separated into gametes and recombined in the offspring$t$
  AND option_c = $t$A \(2 : 1\) ratio showing that the dominant allele is twice as common as the recessive$t$
  AND option_d = $t$A \(4 : 0\) ratio showing that the dominant trait always wins$t$
  AND explanation = $t$The \(3 : 1\) F2 ratio (from F1 x F1 = Aa \(x\) Aa): AA (25%) Aa (50%) aa (25%) phenotype ratio 3 dominant : 1 recessive. This ratio is remarkable because it reveals that the F1 plants were heterozygous (carrying both alleles) but only expressing one. The alleles must have remained separate (particulate not blended) to be available for independent transmission to F2 offspring. This was Mendels crucial insight: hereditary factors are discrete particles not blended fluids.$t$;

UPDATE questions SET
  explanation = $t$The Watson-Crick-Franklin discovery is arguably the most important in 20th century biology. Franklin X-ray crystallography photograph 51 provided critical data (the B form DNA molecule dimensions). Watson and Crick used this data with Chargaffs rules (A=T G=C in DNA) and model building to determine the double helix structure. The structure immediately suggested the replication mechanism (Crick and Watson noted this in their 1953 paper with characteristic British understatement). The Nobel Prize was awarded to Watson Crick and Wilkins in 1962 — Franklin had died in 1958.$t$
WHERE id = 2031
  AND explanation = $t$The Watson-Crick-Franklin discovery is arguably the most important in 20th century biology. Franklin X-ray crystallography photograph 51 provided critical data (the B form DNA molecule dimensions). Watson and Crick used this data with Chargaffs rules (\(A = T G = C\) in DNA) and model building to determine the double helix structure. The structure immediately suggested the replication mechanism (Crick and Watson noted this in their 1953 paper with characteristic British understatement). The Nobel Prize was awarded to Watson Crick and Wilkins in 1962 — Franklin had died in 1958.$t$;

UPDATE questions SET
  option_d = $t$The modern evolutionary synthesis (1930s-1950s) integrated: Mendelian genetics (discrete hereditary units allele frequencies); Darwinian natural selection; population genetics (mathematical modelling of allele frequency change); palaeontology; and comparative morphology. Key contributors: R.A. Fisher (mathematical demonstration that Mendelian genetics was compatible with the continuous variation Darwin observed); J.B.S. Haldane (mathematical population genetics); Sewall Wright (genetic drift small populations); Theodosius Dobzhansky (genetics of natural populations Drosophila); Ernst Mayr (biological species concept geographic speciation); George Gaylord Simpson (palaeontological evidence); and Julian Huxley (coined the term evolutionary synthesis). The synthesis resolved the apparent conflict between Mendelian discrete inheritance and Darwinian gradualism by showing that many Mendelian genes could produce continuous variation$t$
WHERE id = 2033
  AND option_d = $t$The modern evolutionary synthesis \((1930s - 1950s)\) integrated: Mendelian genetics (discrete hereditary units allele frequencies); Darwinian natural selection; population genetics (mathematical modelling of allele frequency change); palaeontology; and comparative morphology. Key contributors: R.A. Fisher (mathematical demonstration that Mendelian genetics was compatible with the continuous variation Darwin observed); J.B.S. Haldane (mathematical population genetics); Sewall Wright (genetic drift small populations); Theodosius Dobzhansky (genetics of natural populations Drosophila); Ernst Mayr (biological species concept geographic speciation); George Gaylord Simpson (palaeontological evidence); and Julian Huxley (coined the term evolutionary synthesis). The synthesis resolved the apparent conflict between Mendelian discrete inheritance and Darwinian gradualism by showing that many Mendelian genes could produce continuous variation$t$;

UPDATE questions SET
  option_a = $t$Genetic drift is the random change in allele frequency in a population due to chance events in reproduction rather than differential fitness. It is most important when: 1) Population size is small — the smaller the population the greater the effect of random sampling on allele frequencies; 2) Founder effect — a small group of individuals colonises a new area taking only a subset of the original populations genetic variation (e.g. genetic diseases prevalent in Amish and Old Order Mennonite communities due to founder effect); 3) Bottleneck effect — a population is dramatically reduced (e.g. cheetah near-extinction approximately 10,000 years ago produced extreme genetic uniformity); 4) In neutral alleles — alleles with no fitness effect are not subject to selection and their frequency changes are entirely due to drift. Selection is more powerful than drift when: selection coefficients are large relative to 1/N (N = population size)$t$,
  explanation = $t$The relative importance of drift vs selection is captured by the inequality: if selection coefficient s >> 1/N then selection dominates; if s << 1/N then drift dominates. For humans (N effectively approximately 10,000 in evolutionary past) alleles with selection coefficients below approximately 0.0001 would be subject to drift. Kimuras neutral theory of molecular evolution (1968) proposed that most molecular variation (DNA sequence polymorphism) is selectively neutral and fixed or lost by drift — explaining why molecular evolution rates are approximately constant (the molecular clock) while morphological evolution rates vary.$t$
WHERE id = 2035
  AND option_a = $t$Genetic drift is the random change in allele frequency in a population due to chance events in reproduction rather than differential fitness. It is most important when: 1) Population size is small — the smaller the population the greater the effect of random sampling on allele frequencies; 2) Founder effect — a small group of individuals colonises a new area taking only a subset of the original populations genetic variation (e.g. genetic diseases prevalent in Amish and Old Order Mennonite communities due to founder effect); 3) Bottleneck effect — a population is dramatically reduced (e.g. cheetah near-extinction approximately 10 000 years ago produced extreme genetic uniformity); 4) In neutral alleles — alleles with no fitness effect are not subject to selection and their frequency changes are entirely due to drift. Selection is more powerful than drift when: selection coefficients are large relative to \(\frac{1}{N}\) (N = population size)$t$
  AND explanation = $t$The relative importance of drift vs selection is captured by the inequality: if selection coefficient \(s > > \frac{1}{N}\) then selection dominates; if \(s < < \frac{1}{N}\) then drift dominates. For humans (N effectively approximately 10 000 in evolutionary past) alleles with selection coefficients below approximately 0.0001 would be subject to drift. Kimuras neutral theory of molecular evolution (1968) proposed that most molecular variation (DNA sequence polymorphism) is selectively neutral and fixed or lost by drift — explaining why molecular evolution rates are approximately constant (the molecular clock) while morphological evolution rates vary.$t$;

UPDATE questions SET
  explanation = $t$HGT has profoundly altered our view of prokaryotic evolution. Genome sequencing studies show that 5-20% of E. coli genes were acquired by HGT from other bacteria. Pathogenicity islands (clusters of virulence genes) are frequently transferred between bacteria by HGT explaining the rapid emergence of new pathogens. The endosymbiotic theory (Lynn Margulis 1967) — that mitochondria and chloroplasts evolved from endosymbiotic bacteria — is the most dramatic example of HGT in eukaryotic evolution representing an entire bacterial genome being incorporated. Traditional bifurcating trees fail to represent these network-like relationships in microbial evolution.$t$
WHERE id = 2036
  AND explanation = $t$HGT has profoundly altered our view of prokaryotic evolution. Genome sequencing studies show that 5–20% of E. coli genes were acquired by HGT from other bacteria. Pathogenicity islands (clusters of virulence genes) are frequently transferred between bacteria by HGT explaining the rapid emergence of new pathogens. The endosymbiotic theory (Lynn Margulis 1967) — that mitochondria and chloroplasts evolved from endosymbiotic bacteria — is the most dramatic example of HGT in eukaryotic evolution representing an entire bacterial genome being incorporated. Traditional bifurcating trees fail to represent these network-like relationships in microbial evolution.$t$;

UPDATE questions SET
  explanation = $t$The debate between allopatric and sympatric speciation dominated evolutionary biology for decades. Mayr argued strongly that allopatric speciation was the dominant mode and that sympatric speciation was theoretically impossible. The discovery of multiple independent cichlid radiations within single lake basins (requiring sympatric speciation since the lakes are single bodies of water) provided strong evidence for sympatric speciation. The Lake Victoria cichlids (approximately 500 species evolved in less than 15,000 years) represent perhaps the fastest known vertebrate speciation event. Polyploidy in plants (allopolyploidy — hybridisation between species followed by chromosome doubling) produces instant reproductive isolation and is an unequivocal case of sympatric speciation.$t$
WHERE id = 2037
  AND explanation = $t$The debate between allopatric and sympatric speciation dominated evolutionary biology for decades. Mayr argued strongly that allopatric speciation was the dominant mode and that sympatric speciation was theoretically impossible. The discovery of multiple independent cichlid radiations within single lake basins (requiring sympatric speciation since the lakes are single bodies of water) provided strong evidence for sympatric speciation. The Lake Victoria cichlids (approximately 500 species evolved in less than 15 000 years) represent perhaps the fastest known vertebrate speciation event. Polyploidy in plants (allopolyploidy — hybridisation between species followed by chromosome doubling) produces instant reproductive isolation and is an unequivocal case of sympatric speciation.$t$;

UPDATE questions SET
  option_a = $t$Evidence for endosymbiotic origin of mitochondria and chloroplasts: 1) Both organelles have their own DNA (circular like bacteria); 2) Both have 70S ribosomes (like bacteria not eukaryotic 80S); 3) Both replicate by binary fission independent of cell division; 4) Both have double membranes (the inner membrane is bacterial in origin the outer is derived from the engulfing cell); 5) Phylogenetic analysis of mitochondrial DNA shows it is most closely related to alpha-proteobacteria (specifically Rickettsiales); 6) Chloroplast DNA is most closely related to cyanobacteria. Evidence against or complicating: massive gene transfer from the organelle to the nucleus (most genes originally in the bacterial endosymbiont have moved to the nuclear genome — gene transfer scale required was enormous); and no free-living intermediates are known showing the transition stages$t$
WHERE id = 2038
  AND option_a = $t$Evidence for endosymbiotic origin of mitochondria and chloroplasts: 1) Both organelles have their own DNA (circular like bacteria); 2) Both have \(70S\) ribosomes (like bacteria not eukaryotic \(80S\)); 3) Both replicate by binary fission independent of cell division; 4) Both have double membranes (the inner membrane is bacterial in origin the outer is derived from the engulfing cell); 5) Phylogenetic analysis of mitochondrial DNA shows it is most closely related to alpha-proteobacteria (specifically Rickettsiales); 6) Chloroplast DNA is most closely related to cyanobacteria. Evidence against or complicating: massive gene transfer from the organelle to the nucleus (most genes originally in the bacterial endosymbiont have moved to the nuclear genome — gene transfer scale required was enormous); and no free-living intermediates are known showing the transition stages$t$;

UPDATE questions SET
  explanation = $t$Kimuras neutral theory was controversial when proposed because it seemed to downplay the role of natural selection. The debate between selectionists and neutralists shaped molecular evolution throughout the 1970s-1990s. Current consensus (nearly neutral theory of Ohta): most molecular variation is neutral or slightly deleterious (not strictly neutral); slightly deleterious mutations behave neutrally in large populations but are eliminated in small populations. The neutral theory is valuable as a null model: departures from neutral expectation (detected by tests like Tajimas D Mcdonald-Kreitman test) identify genes under positive selection.$t$
WHERE id = 2040
  AND explanation = $t$Kimuras neutral theory was controversial when proposed because it seemed to downplay the role of natural selection. The debate between selectionists and neutralists shaped molecular evolution throughout the \(1970s - 1990s\). Current consensus (nearly neutral theory of Ohta): most molecular variation is neutral or slightly deleterious (not strictly neutral); slightly deleterious mutations behave neutrally in large populations but are eliminated in small populations. The neutral theory is valuable as a null model: departures from neutral expectation (detected by tests like Tajimas D Mcdonald-Kreitman test) identify genes under positive selection.$t$;

UPDATE questions SET
  explanation = $t$Biomass is the total dry mass of organic material in organisms. Dry mass is used (rather than wet mass) because water content varies and does not represent the actual organic material. Biomass is typically measured in grams or kilograms per unit area (g/m2 or kg/m2) or per unit volume.$t$
WHERE id = 2047
  AND explanation = $t$Biomass is the total dry mass of organic material in organisms. Dry mass is used (rather than wet mass) because water content varies and does not represent the actual organic material. Biomass is typically measured in grams or kilograms per unit area (\(\text{g/m}^{2}\) or \(\text{kg/m}^{2}\)) or per unit volume.$t$;

UPDATE questions SET
  explanation = $t$Energy loss between trophic levels limits food chain length. If approximately 10% of energy is transferred at each step: starting with 10,000 units at the producer level: primary consumer = 1000 units; secondary consumer = 100 units; tertiary = 10 units; quaternary = 1 unit. By the fifth or sixth level there is simply not enough energy to support a breeding population of organisms.$t$
WHERE id = 2052
  AND explanation = $t$Energy loss between trophic levels limits food chain length. If approximately 10% of energy is transferred at each step: starting with 10 000 units at the producer level: primary consumer \(= 1000\) units; secondary consumer \(= 100\) units; tertiary \(= 10\) units; quaternary \(= 1\) unit. By the fifth or sixth level there is simply not enough energy to support a breeding population of organisms.$t$;

UPDATE questions SET
  question_text = $t$Calculate the efficiency of energy transfer between two trophic levels if producers contain 40,000 kJ/m2/year and primary consumers contain 4,000 kJ/m2/year.$t$,
  explanation = $t$Efficiency = (energy at next trophic level / energy at previous trophic level) x 100. Here: (4000/40000) x 100 = 10%. This is a typical energy transfer efficiency between trophic levels. The remaining 90% is lost mainly as heat from respiration indigestible material in faeces and unconsumed organisms.$t$
WHERE id = 2053
  AND question_text = $t$Calculate the efficiency of energy transfer between two trophic levels if producers contain \(40\,000\,\text{kJ/m}^{2}\text{/year}\) and primary consumers contain \(4\,000\,\text{kJ/m}^{2}\text{/year}\).$t$
  AND explanation = $t$Efficiency \(= \dfrac{\text{energy at next trophic level}}{\text{energy at previous trophic level}} \times 100\). Here: \((\frac{4000}{40000}) \times 100 = 10\%\). This is a typical energy transfer efficiency between trophic levels. The remaining 90% is lost mainly as heat from respiration indigestible material in faeces and unconsumed organisms.$t$;

UPDATE questions SET
  option_c = $t$GPP is the total amount of energy fixed by producers through photosynthesis per unit area per unit time. NPP is the energy available to consumers — it equals GPP minus the energy used by the producers own respiration (R). Formula: NPP = GPP - R. NPP represents the organic matter actually available for growth and consumption by higher trophic levels$t$
WHERE id = 2054
  AND option_c = $t$GPP is the total amount of energy fixed by producers through photosynthesis per unit area per unit time. NPP is the energy available to consumers — it equals GPP minus the energy used by the producers own respiration (R). Formula: \(NPP = GPP - R\). NPP represents the organic matter actually available for growth and consumption by higher trophic levels$t$;

UPDATE questions SET
  option_c = $t$Carbon moves through the environment via: photosynthesis (CO2 absorbed from atmosphere fixed into organic molecules in producers); respiration (all organisms release CO2 back to atmosphere by breaking down organic molecules); feeding (carbon in organic molecules passes from producers to consumers along food chains); decomposition (decomposers break down dead organic matter releasing CO2 through their respiration); combustion (burning of fossil fuels and biomass releases CO2 stored over millions of years); and ocean absorption (CO2 dissolves in seawater forming carbonic acid and carbonate ions)$t$
WHERE id = 2056
  AND option_c = $t$Carbon moves through the environment via: photosynthesis (CO₂ absorbed from atmosphere fixed into organic molecules in producers); respiration (all organisms release CO₂ back to atmosphere by breaking down organic molecules); feeding (carbon in organic molecules passes from producers to consumers along food chains); decomposition (decomposers break down dead organic matter releasing CO₂ through their respiration); combustion (burning of fossil fuels and biomass releases CO₂ stored over millions of years); and ocean absorption (CO₂ dissolves in seawater forming carbonic acid and carbonate ions)$t$;

UPDATE questions SET
  option_a = $t$The nitrogen cycle: nitrogen-fixing bacteria (Rhizobium in root nodules and free-living Azotobacter) convert atmospheric N2 into ammonia (NH3) — making nitrogen available to plants. Decomposers break down proteins and nucleic acids in dead organisms releasing ammonia (ammonification). Nitrifying bacteria convert ammonia to nitrites then to nitrates (Nitrosomonas Nitrobacter) — the form plants absorb. Plants absorb nitrates through roots and use them to synthesise proteins. Animals obtain nitrogen by eating plants or other animals. Denitrifying bacteria (Pseudomonas) convert nitrates back to N2 returning nitrogen to the atmosphere and completing the cycle$t$,
  explanation = $t$The nitrogen cycle is crucial because nitrogen is essential for protein and DNA synthesis. Most organisms cannot use atmospheric N2 directly — it must first be fixed. The key microbial processes: nitrogen fixation (N2 to NH3 using nitrogenase enzyme — requires anaerobic conditions and ATP); nitrification (NH3 to NO2- to NO3- — aerobic process providing nitrates for plant uptake); ammonification (organic N to NH3 — the decomposition of proteins); and denitrification (NO3- to N2 — anaerobic process in waterlogged soils).$t$
WHERE id = 2057
  AND option_a = $t$The nitrogen cycle: nitrogen-fixing bacteria (Rhizobium in root nodules and free-living Azotobacter) convert atmospheric N₂ into ammonia (NH₃) — making nitrogen available to plants. Decomposers break down proteins and nucleic acids in dead organisms releasing ammonia (ammonification). Nitrifying bacteria convert ammonia to nitrites then to nitrates (Nitrosomonas Nitrobacter) — the form plants absorb. Plants absorb nitrates through roots and use them to synthesise proteins. Animals obtain nitrogen by eating plants or other animals. Denitrifying bacteria (Pseudomonas) convert nitrates back to N₂ returning nitrogen to the atmosphere and completing the cycle$t$
  AND explanation = $t$The nitrogen cycle is crucial because nitrogen is essential for protein and DNA synthesis. Most organisms cannot use atmospheric N₂ directly — it must first be fixed. The key microbial processes: nitrogen fixation (N₂ to NH₃ using nitrogenase enzyme — requires anaerobic conditions and ATP); nitrification (NH₃ to NO₂⁻ to NO₃⁻ — aerobic process providing nitrates for plant uptake); ammonification (organic N to NH₃ — the decomposition of proteins); and denitrification (NO₃⁻ to N₂ — anaerobic process in waterlogged soils).$t$;

UPDATE questions SET
  option_c = $t$In food chains approximately 90% of energy is lost at each trophic level. When humans eat crops they consume at the primary consumer level. When humans eat livestock (cattle pigs poultry) the animals must first eat crops (primary consumer level) then humans eat the animals (secondary consumer level). The additional trophic level means far more energy (and therefore agricultural land water and inputs) is required to produce the same amount of human nutrition from meat compared to crops. Approximately 10 kg of plant protein is needed to produce 1 kg of beef protein$t$,
  explanation = $t$This is a direct application of energy transfer efficiency to food production. If 10% efficiency at each trophic level: to produce 100 kJ of human energy from crops requires 1000 kJ of solar energy fixed by producers. To produce 100 kJ from beef requires: 100 kJ / 0.1 (cattle efficiency) = 1000 kJ of plant energy / 0.1 (plant efficiency) = 10,000 kJ of solar energy. Livestock farming uses approximately 10x more land and energy resources per unit of human nutrition than equivalent plant-based production.$t$
WHERE id = 2058
  AND option_c = $t$In food chains approximately 90% of energy is lost at each trophic level. When humans eat crops they consume at the primary consumer level. When humans eat livestock (cattle pigs poultry) the animals must first eat crops (primary consumer level) then humans eat the animals (secondary consumer level). The additional trophic level means far more energy (and therefore agricultural land water and inputs) is required to produce the same amount of human nutrition from meat compared to crops. Approximately \(10\,\text{kg}\) of plant protein is needed to produce \(1\,\text{kg}\) of beef protein$t$
  AND explanation = $t$This is a direct application of energy transfer efficiency to food production. If 10% efficiency at each trophic level: to produce 100 kJ of human energy from crops requires 1000 kJ of solar energy fixed by producers. To produce 100 kJ from beef requires: \(100 \frac{\,\text{kJ}}{0.1}\) (cattle efficiency) \(= 1000\,\text{kJ}\) of plant energy / 0.1 (plant efficiency) \(= 10\,000\,\text{kJ}\) of solar energy. Livestock farming uses approximately 10× more land and energy resources per unit of human nutrition than equivalent plant-based production.$t$;

UPDATE questions SET
  explanation = $t$The connection between energy transfer efficiency and environmental impact is direct and quantifiable. Life cycle assessments consistently show beef production requires approximately 20x more land and emits approximately 20x more greenhouse gases per gram of protein than plant-based protein sources. This is a consequence of the inefficiency of the cattle-as-intermediary in the food chain. Water use for beef is approximately 10-20x higher per gram of protein than for legumes. These differences are grounded in fundamental thermodynamics of energy transfer.$t$
WHERE id = 2060
  AND explanation = $t$The connection between energy transfer efficiency and environmental impact is direct and quantifiable. Life cycle assessments consistently show beef production requires approximately 20× more land and emits approximately 20× more greenhouse gases per gram of protein than plant-based protein sources. This is a consequence of the inefficiency of the cattle-as-intermediary in the food chain. Water use for beef is approximately 10–20× higher per gram of protein than for legumes. These differences are grounded in fundamental thermodynamics of energy transfer.$t$;

UPDATE questions SET
  option_c = $t$The water cycle influences nutrient availability in multiple ways: precipitation dissolves atmospheric gases (CO2 O2 N compounds) delivering them to soils; water movement through soil (leaching) moves dissolved nutrients — both delivering them to roots and potentially washing them below the root zone (nutrient loss); transpiration drives the mass flow of water and dissolved minerals from roots to all plant tissues; evapotranspiration returns water vapour to the atmosphere maintaining the cycle. Drought conditions limit nutrient uptake even when soil nutrients are abundant because nutrients are dissolved in soil water and absorbed by roots in solution. Waterlogging creates anaerobic conditions favoring denitrifying bacteria reducing soil nitrate availability$t$
WHERE id = 2062
  AND option_c = $t$The water cycle influences nutrient availability in multiple ways: precipitation dissolves atmospheric gases (CO₂ O₂ N compounds) delivering them to soils; water movement through soil (leaching) moves dissolved nutrients — both delivering them to roots and potentially washing them below the root zone (nutrient loss); transpiration drives the mass flow of water and dissolved minerals from roots to all plant tissues; evapotranspiration returns water vapour to the atmosphere maintaining the cycle. Drought conditions limit nutrient uptake even when soil nutrients are abundant because nutrients are dissolved in soil water and absorbed by roots in solution. Waterlogging creates anaerobic conditions favoring denitrifying bacteria reducing soil nitrate availability$t$;

UPDATE questions SET
  question_text = $t$A food chain has these energy values: producers = 100,000 kJ, primary consumers = 10,000 kJ, secondary consumers = 1,000 kJ, tertiary consumers = 100 kJ. How much energy is lost between producers and secondary consumers?$t$,
  option_a = $t$10,000 kJ$t$,
  option_b = $t$99,000 kJ$t$,
  option_c = $t$90,000 kJ$t$,
  option_d = $t$89,000 kJ$t$,
  explanation = $t$Energy at producers = 100,000 kJ. Energy at secondary consumers = 1,000 kJ. Energy transferred = 1,000 kJ. Energy lost = 100,000 - 1,000 = 99,000 kJ. However the question asks between producers and secondary consumers (not producers alone). Energy at producers = 100,000. Energy reaching secondary consumers = 1,000. Lost between these two levels = 99,000 kJ. Actually let us re-read: lost between producers and secondary consumers = 100,000 - 1,000 = 99,000 kJ. Option B (89,000) represents loss between primary and secondary consumers only. The correct reading gives 99,000 kJ total loss (answer C).$t$
WHERE id = 2065
  AND question_text = $t$A food chain has these energy values: producers \(= 100\,000\,\text{kJ}\), primary consumers \(= 10\,000\,\text{kJ}\), secondary consumers \(= 1\,000\,\text{kJ}\), tertiary consumers \(= 100\,\text{kJ}\). How much energy is lost between producers and secondary consumers?$t$
  AND option_a = $t$10 000 kJ$t$
  AND option_b = $t$99 000 kJ$t$
  AND option_c = $t$90 000 kJ$t$
  AND option_d = $t$89 000 kJ$t$
  AND explanation = $t$Energy at producers \(= 100\,000\,\text{kJ}\). Energy at secondary consumers \(= 1\,000\,\text{kJ}\). Energy transferred \(= 1\,000\,\text{kJ}\). Energy lost \(= 100\,000 - 1\,000 = 99\,000\,\text{kJ}\). However the question asks between producers and secondary consumers (not producers alone). Energy at producers \(= 100\,000\). Energy reaching secondary consumers \(= 1\,000\). Lost between these two levels \(= 99\,000\,\text{kJ}\). Actually let us re-read: lost between producers and secondary consumers \(= 100\,000 - 1\,000 = 99\,000\,\text{kJ}\). Option B (89 000) represents loss between primary and secondary consumers only. The correct reading gives 99 000 kJ total loss (answer C).$t$;

UPDATE questions SET
  explanation = $t$The sustainability argument for plant-based diets is fundamentally about energy efficiency. Producing 1 kg of beef protein requires approximately 6-8 kg of feed protein (and the associated land water energy). Eating the feed crops directly provides the same nutrition with approximately 6-8x fewer resources. At a global scale a shift to lower trophic level consumption could free up vast areas of land currently used for animal feed production.$t$
WHERE id = 2067
  AND explanation = $t$The sustainability argument for plant-based diets is fundamentally about energy efficiency. Producing \(1\,\text{kg}\) of beef protein requires approximately 6–8 kg of feed protein (and the associated land water energy). Eating the feed crops directly provides the same nutrition with approximately 6–8× fewer resources. At a global scale a shift to lower trophic level consumption could free up vast areas of land currently used for animal feed production.$t$;

UPDATE questions SET
  explanation = $t$Decomposers play a critical role in carbon cycling by mineralising organic carbon. They break chemical bonds in complex organic molecules (proteins fats carbohydrates) releasing the constituent elements including carbon as CO2. Without decomposers there would be a net accumulation of dead organic matter (similar to what happened in the Carboniferous period when dead plant matter was buried before decomposers could break it down — forming the coal deposits we now burn as fossil fuels).$t$
WHERE id = 2068
  AND explanation = $t$Decomposers play a critical role in carbon cycling by mineralising organic carbon. They break chemical bonds in complex organic molecules (proteins fats carbohydrates) releasing the constituent elements including carbon as CO₂. Without decomposers there would be a net accumulation of dead organic matter (similar to what happened in the Carboniferous period when dead plant matter was buried before decomposers could break it down — forming the coal deposits we now burn as fossil fuels).$t$;

UPDATE questions SET
  option_a = $t$Nitrogen-fixing bacteria (convert atmospheric N2 to ammonia — adding nitrogen to the cycle); nitrifying bacteria (convert ammonia to nitrites then nitrates — making nitrogen available for plant uptake); and denitrifying bacteria (convert nitrates back to N2 — returning nitrogen to the atmosphere and completing the cycle)$t$,
  explanation = $t$The three key bacterial groups: nitrogen fixers (Rhizobium symbiotic in legume root nodules; Azotobacter free-living): N2 + 8H+ + 8e- + 16ATP → 2NH3 + H2 + 16ADP + 16Pi (catalysed by nitrogenase); nitrifiers (Nitrosomonas: NH3 to NO2-; Nitrobacter: NO2- to NO3-) — chemolithotrophs obtaining energy from these oxidations; denitrifiers (Pseudomonas) anaerobic reduction of NO3- to N2 in waterlogged soils.$t$
WHERE id = 2070
  AND option_a = $t$Nitrogen-fixing bacteria (convert atmospheric N₂ to ammonia — adding nitrogen to the cycle); nitrifying bacteria (convert ammonia to nitrites then nitrates — making nitrogen available for plant uptake); and denitrifying bacteria (convert nitrates back to N₂ — returning nitrogen to the atmosphere and completing the cycle)$t$
  AND explanation = $t$The three key bacterial groups: nitrogen fixers (Rhizobium symbiotic in legume root nodules; Azotobacter free-living): N₂ + 8H⁺ + 8e⁻ \(+ 16ATP\)→ 2NH₃ + H₂ \(+ 16ADP + 16\)Pi (catalysed by nitrogenase); nitrifiers (Nitrosomonas: NH₃ to NO₂⁻; Nitrobacter: NO₂⁻ to NO₃⁻) — chemolithotrophs obtaining energy from these oxidations; denitrifiers (Pseudomonas) anaerobic reduction of NO₃⁻ to N₂ in waterlogged soils.$t$;

UPDATE questions SET
  option_d = $t$The 10% rule is an approximation with significant variation: actual efficiencies range from 5-20% and vary because of: 1) Assimilation efficiency (proportion of food ingested that is actually absorbed — higher in carnivores than herbivores as animal tissue is more digestible than plant cellulose); 2) Production efficiency (proportion of assimilated energy converted to biomass rather than lost in respiration — higher in ectotherms which do not use energy for thermoregulation than in endotherms); 3) Consumption efficiency (proportion of available prey biomass actually eaten); 4) Ecosystem type (pelagic marine ecosystems tend to have higher efficiencies than terrestrial systems because phytoplankton is highly digestible). Endotherm (bird mammal) production efficiency is particularly low (typically 1-3%) because most assimilated energy maintains body temperature$t$,
  explanation = $t$The breakdown of efficiency components is important for understanding why the rule is approximate. Assimilation efficiency: carnivores approximately 80% herbivores approximately 20-50% (plant material is harder to digest). Production efficiency: ectotherms approximately 40-50% (no thermoregulation cost); endotherms approximately 1-3% (high thermoregulation cost). Consumption efficiency: varies widely (1-100%) depending on predator-prey relationships. The product of these three efficiencies gives overall trophic transfer efficiency. The dominance of low-efficiency endotherms in terrestrial food chains explains why terrestrial efficiency tends to be lower than marine efficiency.$t$
WHERE id = 2073
  AND option_d = $t$The 10% rule is an approximation with significant variation: actual efficiencies range from 5–20% and vary because of: 1) Assimilation efficiency (proportion of food ingested that is actually absorbed — higher in carnivores than herbivores as animal tissue is more digestible than plant cellulose); 2) Production efficiency (proportion of assimilated energy converted to biomass rather than lost in respiration — higher in ectotherms which do not use energy for thermoregulation than in endotherms); 3) Consumption efficiency (proportion of available prey biomass actually eaten); 4) Ecosystem type (pelagic marine ecosystems tend to have higher efficiencies than terrestrial systems because phytoplankton is highly digestible). Endotherm (bird mammal) production efficiency is particularly low (typically 1–3%) because most assimilated energy maintains body temperature$t$
  AND explanation = $t$The breakdown of efficiency components is important for understanding why the rule is approximate. Assimilation efficiency: carnivores approximately 80% herbivores approximately 20–50% (plant material is harder to digest). Production efficiency: ectotherms approximately 40–50% (no thermoregulation cost); endotherms approximately 1–3% (high thermoregulation cost). Consumption efficiency: varies widely (1–100%) depending on predator-prey relationships. The product of these three efficiencies gives overall trophic transfer efficiency. The dominance of low-efficiency endotherms in terrestrial food chains explains why terrestrial efficiency tends to be lower than marine efficiency.$t$;

UPDATE questions SET
  option_d = $t$The Redfield ratio (C:N:P = 106:16:1 by atoms in marine phytoplankton) describes the characteristic stoichiometry of marine primary producers. Whichever nutrient deviates most from the ratio required limits growth (Liebigs law of the minimum). In the open ocean nitrogen is typically limiting (the Atlantic) while phosphorus is limiting in some regions. Iron is co-limiting in high-nutrient-low-chlorophyll (HNLC) regions (Southern Ocean North Pacific). When nutrient ratios in upwelling water match Redfield ratios primary production is maximised. Human disruption of Redfield balance (loading N without P or vice versa from agriculture) shifts which nutrient limits algal growth in coastal waters affecting bloom species composition and ecosystem function$t$,
  explanation = $t$The Redfield ratio discovery (1934) was one of the most important contributions to biological oceanography. The convergence of ocean nutrient ratios toward 16:1 N:P (matching phytoplankton composition) suggested that biological processes actively regulate ocean chemistry. In practice HNLC regions (approximately 30% of the ocean) have abundant N and P but are iron-limited — iron fertilisation experiments (IronEx SOIREE) demonstrated that adding iron to these regions triggers phytoplankton blooms — temporarily increasing carbon drawdown.$t$
WHERE id = 2074
  AND option_d = $t$The Redfield ratio (C:N:P \(= 106 : 16 : 1\) by atoms in marine phytoplankton) describes the characteristic stoichiometry of marine primary producers. Whichever nutrient deviates most from the ratio required limits growth (Liebigs law of the minimum). In the open ocean nitrogen is typically limiting (the Atlantic) while phosphorus is limiting in some regions. Iron is co-limiting in high-nutrient-low-chlorophyll (HNLC) regions (Southern Ocean North Pacific). When nutrient ratios in upwelling water match Redfield ratios primary production is maximised. Human disruption of Redfield balance (loading N without P or vice versa from agriculture) shifts which nutrient limits algal growth in coastal waters affecting bloom species composition and ecosystem function$t$
  AND explanation = $t$The Redfield ratio discovery (1934) was one of the most important contributions to biological oceanography. The convergence of ocean nutrient ratios toward \(16 : 1\) N:P (matching phytoplankton composition) suggested that biological processes actively regulate ocean chemistry. In practice HNLC regions (approximately 30% of the ocean) have abundant N and P but are iron-limited — iron fertilisation experiments (IronEx SOIREE) demonstrated that adding iron to these regions triggers phytoplankton blooms — temporarily increasing carbon drawdown.$t$;

UPDATE questions SET
  option_b = $t$A trophic cascade occurs when changes at one trophic level propagate through the food web to cause changes at other levels often with large ecosystem-level consequences. Classic example: wolves in Yellowstone — wolves were extirpated in the 1920s. Without wolf predation elk populations increased and overgrazing of riparian vegetation (willows aspens) occurred reducing tree cover along streams. This caused stream bank erosion changed river morphology and reduced habitat for beavers and songbirds. Wolves were reintroduced in 1995 and elk behaviour changed (avoiding riparian areas under predation pressure) allowing vegetation recovery — a behavioural cascade. Sea otters in Pacific kelp forests: otters eat sea urchins; when otters were hunted to near extinction urchin populations exploded overgrazing kelp forests creating urchin barrens losing habitat for hundreds of species$t$
WHERE id = 2075
  AND option_b = $t$A trophic cascade occurs when changes at one trophic level propagate through the food web to cause changes at other levels often with large ecosystem-level consequences. Classic example: wolves in Yellowstone — wolves were extirpated in the \(1920s\). Without wolf predation elk populations increased and overgrazing of riparian vegetation (willows aspens) occurred reducing tree cover along streams. This caused stream bank erosion changed river morphology and reduced habitat for beavers and songbirds. Wolves were reintroduced in 1995 and elk behaviour changed (avoiding riparian areas under predation pressure) allowing vegetation recovery — a behavioural cascade. Sea otters in Pacific kelp forests: otters eat sea urchins; when otters were hunted to near extinction urchin populations exploded overgrazing kelp forests creating urchin barrens losing habitat for hundreds of species$t$;

UPDATE questions SET
  option_b = $t$Burning fossil fuels and burning wood have identical effects on atmospheric CO2 because both release carbon$t$,
  option_d = $t$Fossil fuels contain no carbon and their combustion does not affect atmospheric CO2$t$,
  explanation = $t$The geological timescale perspective is essential for understanding why fossil fuel combustion is qualitatively different from biomass combustion. The approximately 300 million years of carbon burial in the Carboniferous and subsequent periods created a geological carbon store. Burning fossil fuels releases this sequestered carbon in a timeframe of decades to centuries — approximately 1 million times faster than the geological processes that buried it. Natural carbon sinks (forests oceans) cannot absorb this release rate which is why atmospheric CO2 is rising.$t$
WHERE id = 2076
  AND option_b = $t$Burning fossil fuels and burning wood have identical effects on atmospheric CO₂ because both release carbon$t$
  AND option_d = $t$Fossil fuels contain no carbon and their combustion does not affect atmospheric CO₂$t$
  AND explanation = $t$The geological timescale perspective is essential for understanding why fossil fuel combustion is qualitatively different from biomass combustion. The approximately 300 million years of carbon burial in the Carboniferous and subsequent periods created a geological carbon store. Burning fossil fuels releases this sequestered carbon in a timeframe of decades to centuries — approximately 1 million times faster than the geological processes that buried it. Natural carbon sinks (forests oceans) cannot absorb this release rate which is why atmospheric CO₂ is rising.$t$;

UPDATE questions SET
  explanation = $t$Critical loads (the threshold deposition rate below which significant ecological damage does not occur) have been established for different ecosystem types. Heathlands and bogs are particularly sensitive (critical load approximately 5-10 kg N/ha/year) while forests are more tolerant. Much of northern and central Europe already exceeds critical loads for sensitive habitats. The UK has approximately 75% of European lowland heathland and this habitat has declined by approximately 80% in the 20th century — nitrogen deposition (alongside direct habitat loss) is a major driver.$t$
WHERE id = 2077
  AND explanation = $t$Critical loads (the threshold deposition rate below which significant ecological damage does not occur) have been established for different ecosystem types. Heathlands and bogs are particularly sensitive (critical load approximately 5–10 kg N/ha/year) while forests are more tolerant. Much of northern and central Europe already exceeds critical loads for sensitive habitats. The UK has approximately 75% of European lowland heathland and this habitat has declined by approximately 80% in the 20th century — nitrogen deposition (alongside direct habitat loss) is a major driver.$t$;

UPDATE questions SET
  question_text = $t$A student sets up an experiment using sealed bottles containing pond water and aquatic organisms. After two weeks some bottles (with light) show increased dissolved oxygen while others (dark bottles) show decreased dissolved oxygen. Explain these results and calculate the gross primary productivity if the light bottle shows +3 mg O2/L and the dark bottle shows -1 mg O2/L.$t$,
  option_c = $t$In light bottles: photosynthesis produces O2 (uses CO2); respiration consumes O2. Net change = photosynthesis - respiration = +3 mg O2/L. In dark bottles: only respiration occurs consuming O2. Net change = -respiration = -1 mg O2/L. Therefore respiration rate = 1 mg O2/L. GPP (gross primary productivity) = NPP + respiration = +3 + 1 = 4 mg O2/L. This is the light and dark bottle method for measuring aquatic primary productivity.$t$,
  option_d = $t$GPP = NPP - respiration = 3 - 1 = 2 mg O2/L$t$,
  explanation = $t$The light-dark bottle method directly measures GPP NPP and respiration. Dark bottle: measures respiration alone (R) as O2 consumption. Light bottle: measures net production (NPP) = GPP - R. Therefore GPP = NPP + R = (+3) + (1) = 4 mg O2/L. This technique is used to measure primary productivity in aquatic ecosystems worldwide and underpins our understanding of ocean carbon uptake. Oxygen is used as a proxy for carbon fixation since photosynthesis produces O2 and CO2 fixation in the same stoichiometric ratio.$t$
WHERE id = 2078
  AND question_text = $t$A student sets up an experiment using sealed bottles containing pond water and aquatic organisms. After two weeks some bottles (with light) show increased dissolved oxygen while others (dark bottles) show decreased dissolved oxygen. Explain these results and calculate the gross primary productivity if the light bottle shows +\(3\,\text{mg}\) O₂/L and the dark bottle shows -\(1\,\text{mg}\) O₂/L.$t$
  AND option_c = $t$In light bottles: photosynthesis produces O₂ (uses CO₂); respiration consumes O₂. Net change = photosynthesis - respiration \(=\)+\(3\,\text{mg}\) O₂/L. In dark bottles: only respiration occurs consuming O₂. Net change \(=\)-respiration \(= -1\,\text{mg}\) O₂/L. Therefore respiration rate = \(1\,\text{mg}\) O₂/L. GPP (gross primary productivity) \(= NPP\)+ respiration \(= + 3 + 1 = 4\,\text{mg}\) O₂/L. This is the light and dark bottle method for measuring aquatic primary productivity.$t$
  AND option_d = $t$\(GPP = NPP\)- respiration \(= 3 - 1 = 2\,\text{mg}\) O₂/L$t$
  AND explanation = $t$The light-dark bottle method directly measures GPP NPP and respiration. Dark bottle: measures respiration alone (R) as O₂ consumption. Light bottle: measures net production \((NPP) = GPP - R\). Therefore \(GPP = NPP + R = (+ 3) + (1) = 4\,\text{mg}\) O₂/L. This technique is used to measure primary productivity in aquatic ecosystems worldwide and underpins our understanding of ocean carbon uptake. Oxygen is used as a proxy for carbon fixation since photosynthesis produces O₂ and CO₂ fixation in the same stoichiometric ratio.$t$;

UPDATE questions SET
  explanation = $t$The absence of a gaseous phase in the phosphorus cycle has major ecological and agricultural implications. Unlike nitrogen (which can be biologically fixed from the atmosphere) there is no mechanism to replenish phosphorus from a gaseous reserve when it is depleted. Phosphate rock (the primary agricultural phosphorus source) is a non-renewable resource currently being mined at rates that may exhaust accessible reserves within 50-100 years. This peak phosphorus problem has major implications for food security. In freshwater ecosystems phosphorus is typically limiting (unlike coastal marine systems where nitrogen is more often limiting) making it the key driver of freshwater eutrophication.$t$
WHERE id = 2079
  AND explanation = $t$The absence of a gaseous phase in the phosphorus cycle has major ecological and agricultural implications. Unlike nitrogen (which can be biologically fixed from the atmosphere) there is no mechanism to replenish phosphorus from a gaseous reserve when it is depleted. Phosphate rock (the primary agricultural phosphorus source) is a non-renewable resource currently being mined at rates that may exhaust accessible reserves within 50–100 years. This peak phosphorus problem has major implications for food security. In freshwater ecosystems phosphorus is typically limiting (unlike coastal marine systems where nitrogen is more often limiting) making it the key driver of freshwater eutrophication.$t$;

UPDATE questions SET
  option_a = $t$All ecosystems will absorb more carbon as CO2 rises because plants will grow faster$t$,
  option_c = $t$Ocean carbon uptake will increase indefinitely regardless of CO2 concentration$t$,
  option_d = $t$Current carbon sinks: forests currently absorb approximately 2.6 GtC/year (approximately 30% of anthropogenic emissions); oceans absorb approximately 2.5 GtC/year. Risks that sinks become sources: permafrost thaw (releases ancient methane and CO2 as previously frozen organic matter decomposes — estimated 1500 GtC stored globally); Amazon dieback (deforestation plus drought may push the Amazon from carbon sink to source — tipping point possibly at 20-25% deforestation); boreal forest fires releasing stored carbon; and ocean acidification reducing the biological pump efficiency. Potential sink enhancement: afforestation/reforestation; soil carbon sequestration (regenerative agriculture); blue carbon (mangroves seagrasses saltmarshes). Climate-carbon feedback creates a positive feedback risk: warming reduces sink efficiency which allows more warming which further reduces sinks$t$,
  explanation = $t$The carbon sink-source transition is one of the most critical uncertainties in climate projections. IPCC models include climate-carbon feedbacks (how warming affects ecosystem carbon uptake) as a major source of uncertainty. The permafrost carbon pool (approximately 1500 GtC — comparable to total anthropogenic emissions since industrialisation) represents a potential tipping element: if permafrost thaw accelerates it could release a carbon pulse that makes 2 degrees C targets unachievable regardless of emissions reductions. Amazon dieback research (Lovejoy and Nobre) estimates the critical deforestation threshold at approximately 20-25% — currently at approximately 17%.$t$
WHERE id = 2081
  AND option_a = $t$All ecosystems will absorb more carbon as CO₂ rises because plants will grow faster$t$
  AND option_c = $t$Ocean carbon uptake will increase indefinitely regardless of CO₂ concentration$t$
  AND option_d = $t$Current carbon sinks: forests currently absorb approximately 2.6 GtC/year (approximately 30% of anthropogenic emissions); oceans absorb approximately 2.5 GtC/year. Risks that sinks become sources: permafrost thaw (releases ancient methane and CO₂ as previously frozen organic matter decomposes — estimated 1500 GtC stored globally); Amazon dieback (deforestation plus drought may push the Amazon from carbon sink to source — tipping point possibly at 20–25% deforestation); boreal forest fires releasing stored carbon; and ocean acidification reducing the biological pump efficiency. Potential sink enhancement: afforestation/reforestation; soil carbon sequestration (regenerative agriculture); blue carbon (mangroves seagrasses saltmarshes). Climate-carbon feedback creates a positive feedback risk: warming reduces sink efficiency which allows more warming which further reduces sinks$t$
  AND explanation = $t$The carbon sink-source transition is one of the most critical uncertainties in climate projections. IPCC models include climate-carbon feedbacks (how warming affects ecosystem carbon uptake) as a major source of uncertainty. The permafrost carbon pool (approximately 1500 GtC — comparable to total anthropogenic emissions since industrialisation) represents a potential tipping element: if permafrost thaw accelerates it could release a carbon pulse that makes 2 degrees C targets unachievable regardless of emissions reductions. Amazon dieback research (Lovejoy and Nobre) estimates the critical deforestation threshold at approximately 20–25% — currently at approximately 17%.$t$;

UPDATE questions SET
  option_d = $t$Evidence for sixth mass extinction: current species extinction rates are estimated at 100-1000x background rates (the natural rate without human influence); approximately 1 million species currently threatened with extinction (IPBES 2019); population sizes of wild vertebrates have declined by approximately 68% since 1970 (Living Planet Index WWF 2020); habitat loss (particularly tropical deforestation) is the primary driver; and climate change will increasingly drive extinctions in the coming decades. Ecological consequences: loss of ecosystem services (pollination water purification climate regulation food security); trophic cascades when keystone species are lost; reduced ecosystem resilience to perturbation (more homogeneous ecosystems are less stable); loss of evolutionary potential (genetic diversity lost with species); and potential ecosystem collapse if extinction crosses critical thresholds. Unlike previous mass extinctions this one is occurring on a timescale of decades to centuries not millions of years giving no time for evolutionary recovery$t$
WHERE id = 2082
  AND option_d = $t$Evidence for sixth mass extinction: current species extinction rates are estimated at 100–1000× background rates (the natural rate without human influence); approximately 1 million species currently threatened with extinction (IPBES 2019); population sizes of wild vertebrates have declined by approximately 68% since 1970 (Living Planet Index WWF 2020); habitat loss (particularly tropical deforestation) is the primary driver; and climate change will increasingly drive extinctions in the coming decades. Ecological consequences: loss of ecosystem services (pollination water purification climate regulation food security); trophic cascades when keystone species are lost; reduced ecosystem resilience to perturbation (more homogeneous ecosystems are less stable); loss of evolutionary potential (genetic diversity lost with species); and potential ecosystem collapse if extinction crosses critical thresholds. Unlike previous mass extinctions this one is occurring on a timescale of decades to centuries not millions of years giving no time for evolutionary recovery$t$;

UPDATE questions SET
  option_c = $t$The greenhouse effect is the natural process by which certain gases in the atmosphere (greenhouse gases) absorb outgoing infrared radiation from the Earth and re-radiate it warming the lower atmosphere. This natural effect keeps the Earth approximately 33 degrees C warmer than it would otherwise be. Human activities enhance this effect by: burning fossil fuels (releasing CO2); deforestation (releasing stored carbon and reducing CO2 absorption); agriculture (methane from livestock and rice paddies; nitrous oxide from fertilisers); and industrial processes — increasing greenhouse gas concentrations and trapping more heat$t$,
  explanation = $t$The distinction between the natural greenhouse effect (essential for life) and the enhanced greenhouse effect (caused by human activities) is important. Without any greenhouse effect Earths average surface temperature would be approximately -18 degrees C (compared to the actual +15 degrees C). The enhanced greenhouse effect from increased CO2 (from approximately 280 ppm pre-industrial to approximately 420 ppm today) methane and nitrous oxide is causing global average temperatures to rise beyond the range of natural variation.$t$
WHERE id = 2085
  AND option_c = $t$The greenhouse effect is the natural process by which certain gases in the atmosphere (greenhouse gases) absorb outgoing infrared radiation from the Earth and re-radiate it warming the lower atmosphere. This natural effect keeps the Earth approximately 33 degrees C warmer than it would otherwise be. Human activities enhance this effect by: burning fossil fuels (releasing CO₂); deforestation (releasing stored carbon and reducing CO₂ absorption); agriculture (methane from livestock and rice paddies; nitrous oxide from fertilisers); and industrial processes — increasing greenhouse gas concentrations and trapping more heat$t$
  AND explanation = $t$The distinction between the natural greenhouse effect (essential for life) and the enhanced greenhouse effect (caused by human activities) is important. Without any greenhouse effect Earths average surface temperature would be approximately - 18 degrees C (compared to the actual + 15 degrees C). The enhanced greenhouse effect from increased CO₂ (from approximately 280 ppm pre-industrial to approximately 420 ppm today) methane and nitrous oxide is causing global average temperatures to rise beyond the range of natural variation.$t$;

UPDATE questions SET
  question_text = $t$What is the main cause of the increase in atmospheric CO2 concentration over the past 200 years?$t$,
  option_a = $t$Natural volcanic eruptions have released much more CO2 than usual since industrialisation$t$,
  option_b = $t$Ocean evaporation releasing dissolved CO2 as ocean temperatures rise$t$,
  option_d = $t$The burning of fossil fuels (coal oil and natural gas) which releases CO2 that was locked away in geological deposits for millions of years. Deforestation is the second major contributor — burning or decomposing trees releases their stored carbon and removes future carbon-absorbing capacity$t$,
  explanation = $t$Ice core records show that atmospheric CO2 was approximately 280 ppm for 800,000 years before industrialisation. Since 1850 it has risen to approximately 420 ppm (2023) — a 50% increase. The timing and isotopic composition of the additional CO2 (depleted in C-13 and C-14 characteristic of fossil fuel carbon) confirms fossil fuel combustion as the primary cause. Deforestation accounts for approximately 10-15% of anthropogenic CO2 emissions.$t$
WHERE id = 2086
  AND question_text = $t$What is the main cause of the increase in atmospheric CO₂ concentration over the past 200 years?$t$
  AND option_a = $t$Natural volcanic eruptions have released much more CO₂ than usual since industrialisation$t$
  AND option_b = $t$Ocean evaporation releasing dissolved CO₂ as ocean temperatures rise$t$
  AND option_d = $t$The burning of fossil fuels (coal oil and natural gas) which releases CO₂ that was locked away in geological deposits for millions of years. Deforestation is the second major contributor — burning or decomposing trees releases their stored carbon and removes future carbon-absorbing capacity$t$
  AND explanation = $t$Ice core records show that atmospheric CO₂ was approximately 280 ppm for 800 000 years before industrialisation. Since 1850 it has risen to approximately 420 ppm (2023) — a 50% increase. The timing and isotopic composition of the additional CO₂ (depleted in \(C - 13\) and \(C - 14\) characteristic of fossil fuel carbon) confirms fossil fuel combustion as the primary cause. Deforestation accounts for approximately 10–15% of anthropogenic CO₂ emissions.$t$;

UPDATE questions SET
  explanation = $t$Acid rain was a major environmental problem in the 1970s-1980s particularly in Scandinavia and Eastern North America. Controls on SO2 and NOx emissions (Clean Air Acts in the USA and UNECE protocols in Europe) have substantially reduced acid deposition. However many acidified lakes have not recovered because acidic soil conditions (metal ion mobilisation) persist. Acid rain leaches calcium from soils making them less suitable for calcium-shell-forming organisms (snails) which removes a key food source for birds.$t$
WHERE id = 2088
  AND explanation = $t$Acid rain was a major environmental problem in the \(1970s - 1980s\) particularly in Scandinavia and Eastern North America. Controls on SO₂ and NOx emissions (Clean Air Acts in the USA and UNECE protocols in Europe) have substantially reduced acid deposition. However many acidified lakes have not recovered because acidic soil conditions (metal ion mobilisation) persist. Acid rain leaches calcium from soils making them less suitable for calcium-shell-forming organisms (snails) which removes a key food source for birds.$t$;

UPDATE questions SET
  option_d = $t$Agricultural intensification has dramatically reduced biodiversity by: replacing diverse natural habitats with monocultures (supporting very few species); using pesticides that kill non-target insects birds and other wildlife; removing hedgerows field margins and other semi-natural habitats that provided refuges; draining wetlands; and applying fertilisers causing eutrophication of waterways. The UK has lost approximately 60% of its farmland bird species and approximately 50% of its butterfly species since the 1970s largely due to agricultural intensification$t$
WHERE id = 2091
  AND option_d = $t$Agricultural intensification has dramatically reduced biodiversity by: replacing diverse natural habitats with monocultures (supporting very few species); using pesticides that kill non-target insects birds and other wildlife; removing hedgerows field margins and other semi-natural habitats that provided refuges; draining wetlands; and applying fertilisers causing eutrophication of waterways. The UK has lost approximately 60% of its farmland bird species and approximately 50% of its butterfly species since the \(1970s\) largely due to agricultural intensification$t$;

UPDATE questions SET
  explanation = $t$Global warming is already affecting ecosystems detectably. Range shifts have been documented in hundreds of species. Phenological mismatches are being documented: great tits in the Netherlands now hatch slightly after peak caterpillar abundance (having not advanced their hatching date as fast as caterpillar timing has advanced with warming). Coral bleaching has increased dramatically: in 2016 and 2017 approximately 50% of the Great Barrier Reef coral experienced bleaching. Arctic ecosystems are warming approximately 4x faster than the global average.$t$
WHERE id = 2092
  AND explanation = $t$Global warming is already affecting ecosystems detectably. Range shifts have been documented in hundreds of species. Phenological mismatches are being documented: great tits in the Netherlands now hatch slightly after peak caterpillar abundance (having not advanced their hatching date as fast as caterpillar timing has advanced with warming). Coral bleaching has increased dramatically: in 2016 and 2017 approximately 50% of the Great Barrier Reef coral experienced bleaching. Arctic ecosystems are warming approximately 4× faster than the global average.$t$;

UPDATE questions SET
  option_c = $t$Deforestation contributes to climate change through: 1) Carbon release — Amazon forests store approximately 150-200 GtC; burning and decomposing trees releases this as CO2 and CH4; 2) Reduced carbon sink capacity — forest absorbs approximately 2 GtC/year which is lost when cleared; 3) Local climate effects — forests generate approximately 50% of their own rainfall through evapotranspiration (recycled rainfall) — deforestation reduces rainfall in cleared regions causing further stress on remaining forest edges; 4) Surface albedo change — dark forest canopy absorbs more solar radiation than pasture; replacing forest with pasture increases albedo but the net warming effect of CO2 release dominates; 5) Positive feedback — drought stress from reduced rainfall can trigger further tree mortality releasing more carbon$t$,
  explanation = $t$The Amazon is approaching a potential tipping point. Thomas Lovejoy and Carlos Nobre estimate that 20-25% deforestation (currently approximately 17%) could trigger a dieback cascade where reduced rainfall (from lost evapotranspiration) kills remaining forest even without further direct clearance. The Amazon carbon release in recent years has been measured directly: some areas now emit more carbon than they absorb (Gatti et al. 2021 Nature) — a significant shift from the historical sink status.$t$
WHERE id = 2093
  AND option_c = $t$Deforestation contributes to climate change through: 1) Carbon release — Amazon forests store approximately 150–200 GtC; burning and decomposing trees releases this as CO₂ and CH₄; 2) Reduced carbon sink capacity — forest absorbs approximately 2 GtC/year which is lost when cleared; 3) Local climate effects — forests generate approximately 50% of their own rainfall through evapotranspiration (recycled rainfall) — deforestation reduces rainfall in cleared regions causing further stress on remaining forest edges; 4) Surface albedo change — dark forest canopy absorbs more solar radiation than pasture; replacing forest with pasture increases albedo but the net warming effect of CO₂ release dominates; 5) Positive feedback — drought stress from reduced rainfall can trigger further tree mortality releasing more carbon$t$
  AND explanation = $t$The Amazon is approaching a potential tipping point. Thomas Lovejoy and Carlos Nobre estimate that 20–25% deforestation (currently approximately 17%) could trigger a dieback cascade where reduced rainfall (from lost evapotranspiration) kills remaining forest even without further direct clearance. The Amazon carbon release in recent years has been measured directly: some areas now emit more carbon than they absorb (Gatti et al. 2021 Nature) — a significant shift from the historical sink status.$t$;

UPDATE questions SET
  option_b = $t$Evidence for threat: ocean pH has fallen from 8.2 (pre-industrial) to 8.1 (approximately 30% increase in H+ concentration); CO2 dissolves in seawater forming carbonic acid; reduced pH decreases carbonate ion availability which is needed for calcium carbonate shells and skeletons. Measured effects: coral growth rates have declined; oyster larvae in Pacific Northwest hatcheries failed to form shells (direct economic impact); pteropod (sea butterfly) shells dissolving in Southern Ocean; and projected further acidification under high-emission scenarios (pH 7.8 by 2100) exceeds the tolerance of many calcifying organisms. Counter-considerations: some organisms show adaptation to acidification in laboratory experiments; actual seawater chemistry is complex with regional variation; and some non-calcifying algae may benefit. However the rate of acidification is faster than any geological precedent giving organisms insufficient time to adapt evolutionarily$t$,
  explanation = $t$Ocean acidification (the other CO2 problem described by Ken Caldeira) is directly driven by atmospheric CO2 regardless of whether warming occurs. The chemistry is straightforward: CO2 + H2O ⇌ H2CO3 ⇌ H+ + HCO3- ⇌ 2H+ + CO32-. As CO2 increases equilibrium shifts right increasing H+ and decreasing CO32-. The aragonite saturation state (critical for coral reef calcification) is projected to fall below 1 (undersaturation) in polar regions by 2050 under RCP 8.5 — meaning shells will dissolve spontaneously.$t$
WHERE id = 2094
  AND option_b = $t$Evidence for threat: ocean pH has fallen from 8.2 (pre-industrial) to 8.1 (approximately 30% increase in H⁺ concentration); CO₂ dissolves in seawater forming carbonic acid; reduced pH decreases carbonate ion availability which is needed for calcium carbonate shells and skeletons. Measured effects: coral growth rates have declined; oyster larvae in Pacific Northwest hatcheries failed to form shells (direct economic impact); pteropod (sea butterfly) shells dissolving in Southern Ocean; and projected further acidification under high-emission scenarios (pH 7.8 by 2100) exceeds the tolerance of many calcifying organisms. Counter-considerations: some organisms show adaptation to acidification in laboratory experiments; actual seawater chemistry is complex with regional variation; and some non-calcifying algae may benefit. However the rate of acidification is faster than any geological precedent giving organisms insufficient time to adapt evolutionarily$t$
  AND explanation = $t$Ocean acidification (the other CO₂ problem described by Ken Caldeira) is directly driven by atmospheric CO₂ regardless of whether warming occurs. The chemistry is straightforward: CO₂ + H₂O ⇌ H2CO3 ⇌ H⁺ + HCO₃⁻ ⇌ 2H⁺ + CO₃²⁻. As CO₂ increases equilibrium shifts right increasing H⁺ and decreasing CO₃²⁻. The aragonite saturation state (critical for coral reef calcification) is projected to fall below 1 (undersaturation) in polar regions by 2050 under RCP 8.5 — meaning shells will dissolve spontaneously.$t$;

UPDATE questions SET
  option_a = $t$Protected areas (national parks nature reserves): advantages — provide legal protection for key habitats secure large areas for mobile species. Limitations — cover only approximately 15% of land (CBD Aichi target 17% 30x30 goal 30% by 2030); may not include the most biodiverse areas; climate change will cause species to move beyond protected boundaries. Species recovery programmes: advantages — can save species from imminent extinction (California condor whooping crane black-footed ferret all recovered from single-digit populations). Limitations — extremely expensive per species; address symptoms not causes. Landscape-scale conservation: connects habitat patches through corridors maintains ecological processes across large areas allows species range shifts with climate change and addresses drivers of biodiversity loss. Most effective approach is integrating all three levels within a broader strategy of changing the land use policies and agricultural practices that drive biodiversity loss$t$,
  explanation = $t$Conservation effectiveness research shows that protected areas are necessary but insufficient. The systematic conservation planning approach (Margules and Pressey 2000) uses complementarity analysis to identify minimum sets of areas that represent maximum biodiversity. Connectivity (ecological corridors linking protected areas) is increasingly emphasised: Y2Y (Yellowstone to Yukon) corridor project aims to create a connected wildlife corridor from Yellowstone to the Canadian Rockies reducing fragmentation for large mobile species (grizzly bears wolves wolverines).$t$
WHERE id = 2095
  AND option_a = $t$Protected areas (national parks nature reserves): advantages — provide legal protection for key habitats secure large areas for mobile species. Limitations — cover only approximately 15% of land (CBD Aichi target \(17\% 30x30\) goal 30% by 2030); may not include the most biodiverse areas; climate change will cause species to move beyond protected boundaries. Species recovery programmes: advantages — can save species from imminent extinction (California condor whooping crane black-footed ferret all recovered from single-digit populations). Limitations — extremely expensive per species; address symptoms not causes. Landscape-scale conservation: connects habitat patches through corridors maintains ecological processes across large areas allows species range shifts with climate change and addresses drivers of biodiversity loss. Most effective approach is integrating all three levels within a broader strategy of changing the land use policies and agricultural practices that drive biodiversity loss$t$
  AND explanation = $t$Conservation effectiveness research shows that protected areas are necessary but insufficient. The systematic conservation planning approach (Margules and Pressey 2000) uses complementarity analysis to identify minimum sets of areas that represent maximum biodiversity. Connectivity (ecological corridors linking protected areas) is increasingly emphasised: \(Y2Y\) (Yellowstone to Yukon) corridor project aims to create a connected wildlife corridor from Yellowstone to the Canadian Rockies reducing fragmentation for large mobile species (grizzly bears wolves wolverines).$t$;

UPDATE questions SET
  option_d = $t$Invasive species (introduced outside their native range) cause biodiversity loss through: predation of naive prey (that have not co-evolved defences); competition (superior competitors outcompete native species for food space or other resources); habitat modification (changing the physical structure of the ecosystem); disease introduction; and hybridisation with native species. Named example: grey squirrel (Sciurus carolinensis) introduced to UK from North America (1870s) has caused the decline of the native red squirrel (Sciurus vulgaris) through: competitive exclusion (grey squirrels are larger and better able to digest tannins in unripe acorns); and squirrelpox virus transmission (grey squirrels carry but are not harmed by the poxvirus which is fatal to red squirrels). Red squirrel populations have declined by approximately 95% since grey squirrel introduction$t$
WHERE id = 2096
  AND option_d = $t$Invasive species (introduced outside their native range) cause biodiversity loss through: predation of naive prey (that have not co-evolved defences); competition (superior competitors outcompete native species for food space or other resources); habitat modification (changing the physical structure of the ecosystem); disease introduction; and hybridisation with native species. Named example: grey squirrel (Sciurus carolinensis) introduced to UK from North America \((1870s)\) has caused the decline of the native red squirrel (Sciurus vulgaris) through: competitive exclusion (grey squirrels are larger and better able to digest tannins in unripe acorns); and squirrelpox virus transmission (grey squirrels carry but are not harmed by the poxvirus which is fatal to red squirrels). Red squirrel populations have declined by approximately 95% since grey squirrel introduction$t$;

UPDATE questions SET
  option_a = $t$Ecosystem services are the benefits that humans obtain from ecosystems: 1) Provisioning services (food water timber medicines); 2) Regulating services (climate regulation flood control water purification pollination disease regulation); 3) Cultural services (recreation spiritual values education); 4) Supporting services (nutrient cycling soil formation primary production). Economic valuation: Costanza et al. (1997) estimated the total value of ecosystem services at approximately $33 trillion per year (exceeding global GDP at the time). Updated estimates (2014) put the value at approximately $125 trillion/year. Pollination alone is valued at approximately $235-577 billion of annual food production. Economic arguments for conservation: biodiversity loss destroys ecosystem services that are extremely expensive or impossible to replace with technology. Counter-argument: economic valuation may trivialise biodiversity by suggesting that everything has a price and can be substituted$t$
WHERE id = 2097
  AND option_a = $t$Ecosystem services are the benefits that humans obtain from ecosystems: 1) Provisioning services (food water timber medicines); 2) Regulating services (climate regulation flood control water purification pollination disease regulation); 3) Cultural services (recreation spiritual values education); 4) Supporting services (nutrient cycling soil formation primary production). Economic valuation: Costanza et al. (1997) estimated the total value of ecosystem services at approximately $33 trillion per year (exceeding global GDP at the time). Updated estimates (2014) put the value at approximately $125 trillion/year. Pollination alone is valued at approximately $235–577 billion of annual food production. Economic arguments for conservation: biodiversity loss destroys ecosystem services that are extremely expensive or impossible to replace with technology. Counter-argument: economic valuation may trivialise biodiversity by suggesting that everything has a price and can be substituted$t$;

UPDATE questions SET
  option_a = $t$Plastic harms marine ecosystems through multiple mechanisms: 1) Ingestion (seabirds fish turtles consume macro-plastics mistaking them for prey — filling stomachs with indigestible material causing starvation; plastic bags resemble jellyfish to turtles); 2) Entanglement (marine mammals dolphins seals get caught in lost fishing gear — ghost fishing — causing drowning or injury); 3) Microplastic pollution (plastics fragment into microplastics (<5mm) and nanoplastics that are ingested by zooplankton coral and fish — entering food chains at the base; microplastics carry persistent organic pollutants (POPs) concentrated on their surfaces); 4) Physical habitat alteration (plastic debris on coral reefs carries pathogens and blocks light); and 5) Bioaccumulation of associated chemicals through food chains$t$
WHERE id = 2098
  AND option_a = $t$Plastic harms marine ecosystems through multiple mechanisms: 1) Ingestion (seabirds fish turtles consume macro-plastics mistaking them for prey — filling stomachs with indigestible material causing starvation; plastic bags resemble jellyfish to turtles); 2) Entanglement (marine mammals dolphins seals get caught in lost fishing gear — ghost fishing — causing drowning or injury); 3) Microplastic pollution (plastics fragment into microplastics \((< 5\,\text{mm})\) and nanoplastics that are ingested by zooplankton coral and fish — entering food chains at the base; microplastics carry persistent organic pollutants (POPs) concentrated on their surfaces); 4) Physical habitat alteration (plastic debris on coral reefs carries pathogens and blocks light); and 5) Bioaccumulation of associated chemicals through food chains$t$;

UPDATE questions SET
  option_d = $t$The CBD (1992 Rio Earth Summit) is the primary international framework for biodiversity conservation. Key agreements: Aichi Biodiversity Targets (2010-2020 — largely not met); Nagoya Protocol on access and benefit-sharing from genetic resources. Kunming-Montreal Global Biodiversity Framework (2022): 30x30 target (protect 30% of land and ocean by 2030); 30x30 restoration target (restore 30% of degraded ecosystems); address harmful subsidies (approximately $500 billion/year currently subsidising biodiversity-harmful activities); integrate biodiversity into all sectors of economy and government; and mobilise approximately $200 billion/year for biodiversity. Scientific assessment of adequacy: the 30x30 targets are more ambitious than previous Aichi targets but scientists debate whether they are sufficient or well-targeted to protect the most biodiverse areas$t$,
  explanation = $t$The Kunming-Montreal framework (COP15 December 2022) was described as a Paris moment for biodiversity. However implementation is the critical challenge: the Aichi targets (2010-2020) were largely not achieved partly due to inadequate financing inadequate integration into national policies and insufficient monitoring. Scientists analysing the 30x30 target note that simply protecting 30% of land without ensuring the protected areas cover the most biodiverse regions may not achieve biodiversity goals. Additionally most protected areas in existing analyses would be in less developed countries raising questions about the equity of the financing arrangements.$t$
WHERE id = 2100
  AND option_d = $t$The CBD (1992 Rio Earth Summit) is the primary international framework for biodiversity conservation. Key agreements: Aichi Biodiversity Targets (\(2010 - 2020\) — largely not met); Nagoya Protocol on access and benefit-sharing from genetic resources. Kunming-Montreal Global Biodiversity Framework (2022): \(30x30\) target (protect 30% of land and ocean by 2030); \(30x30\) restoration target (restore 30% of degraded ecosystems); address harmful subsidies (approximately $500 billion/year currently subsidising biodiversity-harmful activities); integrate biodiversity into all sectors of economy and government; and mobilise approximately $200 billion/year for biodiversity. Scientific assessment of adequacy: the \(30x30\) targets are more ambitious than previous Aichi targets but scientists debate whether they are sufficient or well-targeted to protect the most biodiverse areas$t$
  AND explanation = $t$The Kunming-Montreal framework (COP15 December 2022) was described as a Paris moment for biodiversity. However implementation is the critical challenge: the Aichi targets \((2010 - 2020)\) were largely not achieved partly due to inadequate financing inadequate integration into national policies and insufficient monitoring. Scientists analysing the \(30x30\) target note that simply protecting 30% of land without ensuring the protected areas cover the most biodiverse regions may not achieve biodiversity goals. Additionally most protected areas in existing analyses would be in less developed countries raising questions about the equity of the financing arrangements.$t$;

UPDATE questions SET
  option_d = $t$The Kuznets curve hypothesis: environmental degradation increases with economic development up to a threshold then decreases as wealthy societies prioritise environmental quality and have resources for clean technology. Evidence for: air and water quality in many developed countries improved as they became wealthier; deforestation rates fell in some countries after economic development. Evidence against: many environmental indicators (CO2 emissions biodiversity loss) do not follow the Kuznets pattern — they continue rising with wealth; the apparent improvement in wealthy countries often reflects export of pollution-intensive industries to developing countries (pollution haven hypothesis); and some wealthy countries continue to have very high per capita environmental impacts. Alternative view: sustainable development can occur at any income level but requires institutional capacity governance and equitable distribution. The SDGs explicitly link poverty reduction and environmental goals as simultaneously achievable$t$,
  explanation = $t$The Environmental Kuznets Curve (EKC) hypothesis has been extensively empirically tested with mixed results. It appears to hold for some pollutants in developed countries (SO2 BOD in water) but not for others (CO2 material throughput biodiversity loss). The decoupling of economic growth from environmental impact is theoretically possible (circular economy green technology) but has not been achieved at the absolute level required for sustainability. The poverty-environment nexus is also complex in the other direction: environmental degradation (land degradation water scarcity) often increases poverty particularly for subsistence farmers.$t$
WHERE id = 2101
  AND option_d = $t$The Kuznets curve hypothesis: environmental degradation increases with economic development up to a threshold then decreases as wealthy societies prioritise environmental quality and have resources for clean technology. Evidence for: air and water quality in many developed countries improved as they became wealthier; deforestation rates fell in some countries after economic development. Evidence against: many environmental indicators (CO₂ emissions biodiversity loss) do not follow the Kuznets pattern — they continue rising with wealth; the apparent improvement in wealthy countries often reflects export of pollution-intensive industries to developing countries (pollution haven hypothesis); and some wealthy countries continue to have very high per capita environmental impacts. Alternative view: sustainable development can occur at any income level but requires institutional capacity governance and equitable distribution. The SDGs explicitly link poverty reduction and environmental goals as simultaneously achievable$t$
  AND explanation = $t$The Environmental Kuznets Curve (EKC) hypothesis has been extensively empirically tested with mixed results. It appears to hold for some pollutants in developed countries (SO₂ BOD in water) but not for others (CO₂ material throughput biodiversity loss). The decoupling of economic growth from environmental impact is theoretically possible (circular economy green technology) but has not been achieved at the absolute level required for sustainability. The poverty-environment nexus is also complex in the other direction: environmental degradation (land degradation water scarcity) often increases poverty particularly for subsistence farmers.$t$;

UPDATE questions SET
  option_c = $t$Biodiversity provides essential ecosystem services that human wellbeing depends on: food (diversity of crops livestock wild fish); medicines (approximately 25% of pharmaceutical drugs derived from plants and many from other organisms); pollination (approximately 75% of crops depend on animal pollination); clean water (natural filtration by wetlands); climate regulation (forests absorbing CO2); soil fertility (decomposers nutrient cycling organisms); and disease regulation (diverse ecosystems may buffer against disease outbreaks). Additionally biodiversity provides resilience — diverse ecosystems are more stable and recover better from disturbance than species-poor systems$t$,
  explanation = $t$The link between biodiversity and human wellbeing is well-documented. The value of pollination services is estimated at approximately $235-577 billion of annual food production. One in four pharmaceutical drugs traces its origin to a natural compound. The dilution effect (reduced disease transmission in diverse host communities) has been documented for Lyme disease West Nile virus and other zoonotic diseases. Biodiversity loss in one region can have cascading effects far beyond that region through global ecosystem services.$t$
WHERE id = 2105
  AND option_c = $t$Biodiversity provides essential ecosystem services that human wellbeing depends on: food (diversity of crops livestock wild fish); medicines (approximately 25% of pharmaceutical drugs derived from plants and many from other organisms); pollination (approximately 75% of crops depend on animal pollination); clean water (natural filtration by wetlands); climate regulation (forests absorbing CO₂); soil fertility (decomposers nutrient cycling organisms); and disease regulation (diverse ecosystems may buffer against disease outbreaks). Additionally biodiversity provides resilience — diverse ecosystems are more stable and recover better from disturbance than species-poor systems$t$
  AND explanation = $t$The link between biodiversity and human wellbeing is well-documented. The value of pollination services is estimated at approximately $235–577 billion of annual food production. One in four pharmaceutical drugs traces its origin to a natural compound. The dilution effect (reduced disease transmission in diverse host communities) has been documented for Lyme disease West Nile virus and other zoonotic diseases. Biodiversity loss in one region can have cascading effects far beyond that region through global ecosystem services.$t$;

UPDATE questions SET
  explanation = $t$The Svalbard Global Seed Vault (2008) was designed to survive natural and man-made disasters including nuclear war. It is cut into permafrost at -18 degrees C as a backup to national gene banks. Seed viability varies: wheat and barley seeds can survive 10,000+ years at ultra-low temperatures; some species have shorter viability requiring periodic regeneration. The first withdrawal from Svalbard occurred in 2015 when the Syrian war destroyed part of the ICARDA gene bank in Aleppo — demonstrating the vault critical value.$t$
WHERE id = 2106
  AND explanation = $t$The Svalbard Global Seed Vault (2008) was designed to survive natural and man-made disasters including nuclear war. It is cut into permafrost at - 18 degrees C as a backup to national gene banks. Seed viability varies: wheat and barley seeds can survive 10 000+ years at ultra-low temperatures; some species have shorter viability requiring periodic regeneration. The first withdrawal from Svalbard occurred in 2015 when the Syrian war destroyed part of the ICARDA gene bank in Aleppo — demonstrating the vault critical value.$t$;

UPDATE questions SET
  explanation = $t$The Brundtland definition of sustainable development remains the most widely cited definition globally. The UN Sustainable Development Goals (SDGs 2015-2030) operationalise sustainable development into 17 goals including SDG 14 (Life below water) and SDG 15 (Life on land) which directly address biodiversity. SDG 2 (Zero hunger) connects food security to sustainable agriculture. The challenge is that economic development as currently practised often conflicts with environmental sustainability requiring a fundamental rethinking of economic metrics beyond GDP.$t$
WHERE id = 2107
  AND explanation = $t$The Brundtland definition of sustainable development remains the most widely cited definition globally. The UN Sustainable Development Goals (SDGs \(2015 - 2030\)) operationalise sustainable development into 17 goals including SDG 14 (Life below water) and SDG 15 (Life on land) which directly address biodiversity. SDG 2 (Zero hunger) connects food security to sustainable agriculture. The challenge is that economic development as currently practised often conflicts with environmental sustainability requiring a fundamental rethinking of economic metrics beyond GDP.$t$;

UPDATE questions SET
  option_d = $t$Both damage aquatic ecosystems but through different mechanisms. Acid rain: caused by SO2 and NOx from fossil fuels reacting to form sulfuric and nitric acids; lowers pH of lakes and rivers; directly toxic to many aquatic organisms (fish die below pH 5); mobilises toxic aluminium ions from soil into water; reduces biodiversity particularly of acid-sensitive species. Eutrophication: caused by nitrate and phosphate runoff from agriculture; increases algal growth (algal bloom); depletes oxygen through decomposition of dead algae (BOD increase); kills fish through deoxygenation (not low pH). Difference: acid rain kills by direct pH toxicity; eutrophication kills by oxygen depletion. Both ultimately reduce biodiversity but through distinct mechanisms$t$,
  explanation = $t$Understanding the distinction between acid rain and eutrophication mechanisms is important for identifying solutions. Acid rain is controlled by reducing SO2 and NOx emissions (flue gas desulfurisation catalytic converters). Eutrophication is controlled by reducing N and P runoff from agriculture (buffer strips constructed wetlands phosphorus removal in sewage treatment). Both are pollution problems but they require different pollutant reduction strategies.$t$
WHERE id = 2108
  AND option_d = $t$Both damage aquatic ecosystems but through different mechanisms. Acid rain: caused by SO₂ and NOx from fossil fuels reacting to form sulfuric and nitric acids; lowers pH of lakes and rivers; directly toxic to many aquatic organisms (fish die below pH 5); mobilises toxic aluminium ions from soil into water; reduces biodiversity particularly of acid-sensitive species. Eutrophication: caused by nitrate and phosphate runoff from agriculture; increases algal growth (algal bloom); depletes oxygen through decomposition of dead algae (BOD increase); kills fish through deoxygenation (not low pH). Difference: acid rain kills by direct pH toxicity; eutrophication kills by oxygen depletion. Both ultimately reduce biodiversity but through distinct mechanisms$t$
  AND explanation = $t$Understanding the distinction between acid rain and eutrophication mechanisms is important for identifying solutions. Acid rain is controlled by reducing SO₂ and NOx emissions (flue gas desulfurisation catalytic converters). Eutrophication is controlled by reducing N and P runoff from agriculture (buffer strips constructed wetlands phosphorus removal in sewage treatment). Both are pollution problems but they require different pollutant reduction strategies.$t$;

UPDATE questions SET
  option_d = $t$Biodiversity hotspots are regions with exceptional concentrations of endemic species (found nowhere else on Earth) that are also experiencing exceptional habitat loss. They were defined by Norman Myers (1988) using two criteria: containing at least 1500 species of vascular plants as endemics (>0.5% of global total); and having lost at least 70% of their original habitat. The 36 recognised hotspots cover only 2.5% of the Earths land surface but contain approximately 44% of all plant species and approximately 35% of vertebrate species as endemics. Because these areas contain irreplaceable biodiversity (species found nowhere else) their conservation prevents extinctions that could not be avoided by protecting other areas$t$
WHERE id = 2109
  AND option_d = $t$Biodiversity hotspots are regions with exceptional concentrations of endemic species (found nowhere else on Earth) that are also experiencing exceptional habitat loss. They were defined by Norman Myers (1988) using two criteria: containing at least 1500 species of vascular plants as endemics (\(> 0.5\%\) of global total); and having lost at least 70% of their original habitat. The 36 recognised hotspots cover only 2.5% of the Earths land surface but contain approximately 44% of all plant species and approximately 35% of vertebrate species as endemics. Because these areas contain irreplaceable biodiversity (species found nowhere else) their conservation prevents extinctions that could not be avoided by protecting other areas$t$;

UPDATE questions SET
  option_d = $t$Overfishing has collapsed approximately 33% of global fish stocks with another 60% being fished at maximum sustainable yield. Without management fish populations can collapse below viable reproductive levels leading to commercial and ecological extinction. Management strategies: 1) Total allowable catch (TAC) based on stock assessments; 2) Fishing quotas allocated to fishing nations; 3) Marine protected areas (no-take zones allowing stock recovery); 4) Mesh size regulations (allowing juvenile fish to escape); 5) Seasonal and area closures (protecting spawning grounds); 6) Reducing bycatch (discards of non-target species); 7) Ecolabelling (MSC certification) incentivising sustainable fishing. The Grand Banks cod collapse (1990s) is the cautionary example: a seemingly inexhaustible fish stock collapsed due to overfishing and has not recovered despite a 30-year moratorium$t$,
  explanation = $t$The Grand Banks cod collapse is one of the most studied fisheries collapses. Canadian cod catch peaked at approximately 800,000 tonnes in 1968 and collapsed to near zero by 1992 despite scientific warnings from the 1980s. The cod moratorium (1992) has not led to stock recovery partly because the ecosystem has shifted to an alternative stable state dominated by shrimp and crab. This illustrates the concept of ecosystem regime shifts — once a stock collapses the ecosystem may not return to its former state even when fishing pressure is removed.$t$
WHERE id = 2111
  AND option_d = $t$Overfishing has collapsed approximately 33% of global fish stocks with another 60% being fished at maximum sustainable yield. Without management fish populations can collapse below viable reproductive levels leading to commercial and ecological extinction. Management strategies: 1) Total allowable catch (TAC) based on stock assessments; 2) Fishing quotas allocated to fishing nations; 3) Marine protected areas (no-take zones allowing stock recovery); 4) Mesh size regulations (allowing juvenile fish to escape); 5) Seasonal and area closures (protecting spawning grounds); 6) Reducing bycatch (discards of non-target species); 7) Ecolabelling (MSC certification) incentivising sustainable fishing. The Grand Banks cod collapse \((1990s)\) is the cautionary example: a seemingly inexhaustible fish stock collapsed due to overfishing and has not recovered despite a 30-year moratorium$t$
  AND explanation = $t$The Grand Banks cod collapse is one of the most studied fisheries collapses. Canadian cod catch peaked at approximately 800 000 tonnes in 1968 and collapsed to near zero by 1992 despite scientific warnings from the \(1980s\). The cod moratorium (1992) has not led to stock recovery partly because the ecosystem has shifted to an alternative stable state dominated by shrimp and crab. This illustrates the concept of ecosystem regime shifts — once a stock collapses the ecosystem may not return to its former state even when fishing pressure is removed.$t$;

UPDATE questions SET
  option_b = $t$Scientific basis: the SR1.5 (IPCC 2018 special report) assessed the differences between 1.5 and 2 degrees C warming. Key findings: 10 cm additional sea level rise at 2 vs 1.5 degrees; coral reefs virtually eliminated at 2 degrees (99% loss) vs severely impacted at 1.5 (70-90% loss); Arctic ice-free summers every decade at 2 degrees vs once per century at 1.5; significantly more extreme weather events crop yield declines and species extinctions at 2 vs 1.5. Feasibility: to limit warming to 1.5 degrees global CO2 emissions must reach net zero by approximately 2050 requiring approximately 45% reduction by 2030. Current nationally determined contributions (NDCs) put us on track for approximately 2.5-3 degrees. Carbon removal technologies (BECCS DAC) would be required at massive scale. The 1.5 degrees target is technically feasible but requires societal transformation beyond what current policies are delivering$t$,
  explanation = $t$The IPCC SR1.5 report demonstrated that the half-degree difference between targets produces dramatically different impacts. The coral reef finding is particularly striking: at 2 degrees virtually all coral reefs die — representing the complete destruction of an ecosystem that supports approximately 25% of all marine species and the livelihoods of approximately 500 million people. Current emissions trajectories are tracking toward approximately 2.5-3.0 degrees. The carbon budget for 1.5 degrees (with 50% probability) is approximately 500 GtCO2 from 2020 — at current emission rates this will be exhausted by approximately 2033.$t$
WHERE id = 2114
  AND option_b = $t$Scientific basis: the SR1.5 (IPCC 2018 special report) assessed the differences between 1.5 and 2 degrees C warming. Key findings: 10 cm additional sea level rise at 2 vs 1.5 degrees; coral reefs virtually eliminated at 2 degrees (99% loss) vs severely impacted at 1.5 (70–90% loss); Arctic ice-free summers every decade at 2 degrees vs once per century at 1.5; significantly more extreme weather events crop yield declines and species extinctions at 2 vs 1.5. Feasibility: to limit warming to 1.5 degrees global CO₂ emissions must reach net zero by approximately 2050 requiring approximately 45% reduction by 2030. Current nationally determined contributions (NDCs) put us on track for approximately 2.5–3 degrees. Carbon removal technologies (BECCS DAC) would be required at massive scale. The 1.5 degrees target is technically feasible but requires societal transformation beyond what current policies are delivering$t$
  AND explanation = $t$The IPCC SR1.5 report demonstrated that the half-degree difference between targets produces dramatically different impacts. The coral reef finding is particularly striking: at 2 degrees virtually all coral reefs die — representing the complete destruction of an ecosystem that supports approximately 25% of all marine species and the livelihoods of approximately 500 million people. Current emissions trajectories are tracking toward approximately 2.5–3.0 degrees. The carbon budget for 1.5 degrees (with 50% probability) is approximately 500 GtCO2 from 2020 — at current emission rates this will be exhausted by approximately 2033.$t$;

UPDATE questions SET
  option_d = $t$Tipping elements are components of the Earth system that may pass a threshold (tipping point) beyond which self-reinforcing feedbacks drive the system to a new state without further external forcing. Key tipping elements: 1) West Antarctic Ice Sheet collapse (could raise sea levels by 3-4 m — may be committed at 1.5 degrees); 2) Greenland Ice Sheet melting (7 m sea level rise potential — tipping point approximately 1.5-2 degrees); 3) Amazon dieback (20-25% deforestation threshold interacting with warming and drought); 4) Permafrost carbon release (gradual at first then potentially rapid carbon pulse); 5) Atlantic Meridional Overturning Circulation (AMOC) collapse (potentially tipping point has already been approached — would cause rapid cooling in Northwestern Europe and alter global rainfall patterns). Cascading risk: individual tipping elements are interconnected — crossing one increases the probability of crossing others (domino effect). Recent modelling suggests that multiple tipping points could interact even at 2 degrees warming$t$
WHERE id = 2115
  AND option_d = $t$Tipping elements are components of the Earth system that may pass a threshold (tipping point) beyond which self-reinforcing feedbacks drive the system to a new state without further external forcing. Key tipping elements: 1) West Antarctic Ice Sheet collapse (could raise sea levels by 3–4 \(m\) — may be committed at 1.5 degrees); 2) Greenland Ice Sheet melting (7 m sea level rise potential — tipping point approximately 1.5–2 degrees); 3) Amazon dieback (20–25% deforestation threshold interacting with warming and drought); 4) Permafrost carbon release (gradual at first then potentially rapid carbon pulse); 5) Atlantic Meridional Overturning Circulation (AMOC) collapse (potentially tipping point has already been approached — would cause rapid cooling in Northwestern Europe and alter global rainfall patterns). Cascading risk: individual tipping elements are interconnected — crossing one increases the probability of crossing others (domino effect). Recent modelling suggests that multiple tipping points could interact even at 2 degrees warming$t$;

UPDATE questions SET
  option_b = $t$Citizen science (volunteer public participation in scientific data collection) has transformed ecological monitoring through platforms like: iNaturalist (>3 million species observations per week); eBird (approximately 1.5 billion bird observations); BTO Garden BirdWatch; UK Butterfly Monitoring Scheme; and Christmas Bird Count (oldest citizen science survey 1900). Advantages: massive spatial and temporal coverage impossible with professional surveys; long time series tracking change over decades; democratises science (public engages with nature and conservation); and low cost per observation. Reliability concerns: spatial bias (observations concentrated near human population centres); taxonomic bias (charismatic species over-represented); identification errors (mitigated by AI-assisted identification on iNaturalist and community verification); and variable effort. Quality control methods: expert verification of unusual records; occupancy modelling to account for detection probability; comparison with structured professional surveys (generally shows strong correlations for common species). Citizen science data is increasingly accepted in peer-reviewed research when appropriate analytical methods are applied$t$
WHERE id = 2119
  AND option_b = $t$Citizen science (volunteer public participation in scientific data collection) has transformed ecological monitoring through platforms like: iNaturalist (\(> 3\) million species observations per week); eBird (approximately 1.5 billion bird observations); BTO Garden BirdWatch; UK Butterfly Monitoring Scheme; and Christmas Bird Count (oldest citizen science survey 1900). Advantages: massive spatial and temporal coverage impossible with professional surveys; long time series tracking change over decades; democratises science (public engages with nature and conservation); and low cost per observation. Reliability concerns: spatial bias (observations concentrated near human population centres); taxonomic bias (charismatic species over-represented); identification errors (mitigated by AI-assisted identification on iNaturalist and community verification); and variable effort. Quality control methods: expert verification of unusual records; occupancy modelling to account for detection probability; comparison with structured professional surveys (generally shows strong correlations for common species). Citizen science data is increasingly accepted in peer-reviewed research when appropriate analytical methods are applied$t$;

UPDATE questions SET
  option_b = $t$Ecological stoichiometry examines the balance of energy and multiple chemical elements in ecological systems. Key concept: each organism has characteristic elemental ratios (particularly C:N:P) that are tightly regulated (homeostasis). When organisms eat food that has different ratios from their body they must excrete excess elements or suffer growth limitation. Consequences: 1) Nutrient limitation — phytoplankton growing under P-limitation have high C:P ratios; zooplankton (Daphnia) require low C:P food; high C:P food reduces zooplankton growth (food quality effect independent of caloric content); 2) Herbivore-plant mismatches — woody plant tissues have very high C:N ratios relative to the requirements of insect herbivores making many plants poor food quality for herbivores; 3) Climate change is increasing plant C:N and C:P ratios (higher CO2 increases carbon fixation relative to mineral nutrient uptake) potentially reducing food quality for herbivores throughout terrestrial and aquatic food chains$t$,
  explanation = $t$Ecological stoichiometry (Sterner and Elser 2002) has transformed understanding of nutrient cycling and food quality. The Daphnia-algae system is the best-studied: Daphnia has a fixed low C:P ratio (approximately 60:1) because ribosomes contain high phosphorus. Algae grown under P-limitation have C:P ratios of 300-1000:1. When Daphnia eat P-limited algae they are phosphorus-limited despite adequate caloric intake. This stoichiometric limitation is now recognised in many terrestrial systems: rising atmospheric CO2 is predicted to increase plant C:N and C:P ratios by 5-20% reducing the nutritional quality of plant food for herbivores — a largely overlooked consequence of climate change.$t$
WHERE id = 2120
  AND option_b = $t$Ecological stoichiometry examines the balance of energy and multiple chemical elements in ecological systems. Key concept: each organism has characteristic elemental ratios (particularly C:N:P) that are tightly regulated (homeostasis). When organisms eat food that has different ratios from their body they must excrete excess elements or suffer growth limitation. Consequences: 1) Nutrient limitation — phytoplankton growing under P-limitation have high C:P ratios; zooplankton (Daphnia) require low C:P food; high C:P food reduces zooplankton growth (food quality effect independent of caloric content); 2) Herbivore-plant mismatches — woody plant tissues have very high C:N ratios relative to the requirements of insect herbivores making many plants poor food quality for herbivores; 3) Climate change is increasing plant C:N and C:P ratios (higher CO₂ increases carbon fixation relative to mineral nutrient uptake) potentially reducing food quality for herbivores throughout terrestrial and aquatic food chains$t$
  AND explanation = $t$Ecological stoichiometry (Sterner and Elser 2002) has transformed understanding of nutrient cycling and food quality. The Daphnia-algae system is the best-studied: Daphnia has a fixed low C:P ratio (approximately \(60 : 1\)) because ribosomes contain high phosphorus. Algae grown under P-limitation have C:P ratios of 300-\(1000 : 1\). When Daphnia eat P-limited algae they are phosphorus-limited despite adequate caloric intake. This stoichiometric limitation is now recognised in many terrestrial systems: rising atmospheric CO₂ is predicted to increase plant C:N and C:P ratios by 5–20% reducing the nutritional quality of plant food for herbivores — a largely overlooked consequence of climate change.$t$;

UPDATE questions SET
  option_d = $t$Solar Radiation Management (SRM) approaches (stratospheric aerosol injection — SAI; marine cloud brightening; space mirrors): could reduce global temperature relatively rapidly and cheaply but do not address CO2 accumulation (ocean acidification continues); may alter regional precipitation patterns (risks to monsoon systems affecting billions); termination shock risk (abrupt warming if deployment stops); side effects poorly understood; governance challenges (unilateral deployment possible; effects cross borders). Carbon Dioxide Removal (CDR — Bioenergy with Carbon Capture and Storage BECCS; Direct Air Capture DAC; enhanced weathering; ocean iron fertilisation): addresses the underlying cause (CO2 accumulation) but requires vast scale (BECCS would require land areas comparable to India for 1.5 degrees scenario); energy intensive; may have unintended ecological consequences (ocean fertilisation stimulates blooms with downstream ecosystem effects). Key debate: are geoengineering risks greater or lesser than the risks of unmitigated climate change? No scientific consensus exists. Governance frameworks are underdeveloped$t$
WHERE id = 2121
  AND option_d = $t$Solar Radiation Management (SRM) approaches (stratospheric aerosol injection — SAI; marine cloud brightening; space mirrors): could reduce global temperature relatively rapidly and cheaply but do not address CO₂ accumulation (ocean acidification continues); may alter regional precipitation patterns (risks to monsoon systems affecting billions); termination shock risk (abrupt warming if deployment stops); side effects poorly understood; governance challenges (unilateral deployment possible; effects cross borders). Carbon Dioxide Removal (CDR — Bioenergy with Carbon Capture and Storage BECCS; Direct Air Capture DAC; enhanced weathering; ocean iron fertilisation): addresses the underlying cause (CO₂ accumulation) but requires vast scale (BECCS would require land areas comparable to India for 1.5 degrees scenario); energy intensive; may have unintended ecological consequences (ocean fertilisation stimulates blooms with downstream ecosystem effects). Key debate: are geoengineering risks greater or lesser than the risks of unmitigated climate change? No scientific consensus exists. Governance frameworks are underdeveloped$t$;

UPDATE questions SET
  option_d = $t$Factors threatening food security include: 1) Increasing world population (expected to reach 10 billion by 2050 requiring 50-70% more food); 2) Climate change (altering rainfall patterns increasing extreme weather events — droughts floods — reducing crop yields particularly in tropical regions); 3) Loss of agricultural land (to urbanisation desertification salinisation); 4) Water scarcity (agriculture uses approximately 70% of global freshwater); 5) Increasing demand for meat (requires more land and resources per unit of nutrition); 6) Food waste (approximately 30% of food produced is wasted); and 7) Political instability and conflict (disrupting food distribution)$t$,
  explanation = $t$Food security threats interact and compound each other. Climate change is projected to reduce crop yields in tropical regions by 2-6% per decade while demand increases with population growth. The FAO projects that a 70% increase in food production is needed by 2050 — requiring sustainable intensification (producing more from existing agricultural land) rather than further expansion (which would drive additional deforestation). Water scarcity may be the binding constraint in many regions: aquifer depletion in India and North America is already reducing irrigation capacity.$t$
WHERE id = 2124
  AND option_d = $t$Factors threatening food security include: 1) Increasing world population (expected to reach 10 billion by 2050 requiring 50–70% more food); 2) Climate change (altering rainfall patterns increasing extreme weather events — droughts floods — reducing crop yields particularly in tropical regions); 3) Loss of agricultural land (to urbanisation desertification salinisation); 4) Water scarcity (agriculture uses approximately 70% of global freshwater); 5) Increasing demand for meat (requires more land and resources per unit of nutrition); 6) Food waste (approximately 30% of food produced is wasted); and 7) Political instability and conflict (disrupting food distribution)$t$
  AND explanation = $t$Food security threats interact and compound each other. Climate change is projected to reduce crop yields in tropical regions by 2–6% per decade while demand increases with population growth. The FAO projects that a 70% increase in food production is needed by 2050 — requiring sustainable intensification (producing more from existing agricultural land) rather than further expansion (which would drive additional deforestation). Water scarcity may be the binding constraint in many regions: aquifer depletion in India and North America is already reducing irrigation capacity.$t$;

UPDATE questions SET
  option_b = $t$Intensive farming aims to maximise yields per unit area using large amounts of synthetic fertilisers pesticides machinery and often selective breeding or GM varieties. Organic farming prohibits synthetic fertilisers and most pesticides relying instead on crop rotation compost green manures and biological pest control. Organic farming typically produces lower yields (approximately 20-25% lower on average) but has lower environmental impacts (less pesticide use better for biodiversity; though often higher land use per unit of food)$t$,
  explanation = $t$The organic vs intensive debate reflects broader tensions in sustainable food production. Meta-analyses (Seufert 2012 Nature; Ponisio 2015 Proc Roy Soc) consistently find that organic yields are approximately 19-25% lower than conventional yields on average. However this hides wide variation: organic legumes (using biological N fixation) perform comparably; organic cereals have larger yield gaps. Environmental benefits of organic farming: higher farmland biodiversity (approximately 30% more species according to Hole et al.); lower pesticide residues; no manufactured N fertiliser (reducing fossil fuel use and N pollution). Land use penalty is the main sustainability concern.$t$
WHERE id = 2126
  AND option_b = $t$Intensive farming aims to maximise yields per unit area using large amounts of synthetic fertilisers pesticides machinery and often selective breeding or GM varieties. Organic farming prohibits synthetic fertilisers and most pesticides relying instead on crop rotation compost green manures and biological pest control. Organic farming typically produces lower yields (approximately 20–25% lower on average) but has lower environmental impacts (less pesticide use better for biodiversity; though often higher land use per unit of food)$t$
  AND explanation = $t$The organic vs intensive debate reflects broader tensions in sustainable food production. Meta-analyses (Seufert 2012 Nature; Ponisio 2015 Proc Roy Soc) consistently find that organic yields are approximately 19–25% lower than conventional yields on average. However this hides wide variation: organic legumes (using biological N fixation) perform comparably; organic cereals have larger yield gaps. Environmental benefits of organic farming: higher farmland biodiversity (approximately 30% more species according to Hole et al.); lower pesticide residues; no manufactured N fertiliser (reducing fossil fuel use and N pollution). Land use penalty is the main sustainability concern.$t$;

UPDATE questions SET
  explanation = $t$Global fisheries provide approximately 17% of animal protein consumed by humans and are the primary protein source for approximately 3 billion people. The Food and Agriculture Organization (FAO) State of World Fisheries 2022 report confirms that approximately 35% of stocks are fished at biologically unsustainable levels. Illegal unreported and unregulated (IUU) fishing (estimated at 15-30% of global catch) undermines management measures. The Parties to the Nauru Agreement (PNA) controlling Western Pacific tuna fisheries is considered a successful regional fisheries management model.$t$
WHERE id = 2127
  AND explanation = $t$Global fisheries provide approximately 17% of animal protein consumed by humans and are the primary protein source for approximately 3 billion people. The Food and Agriculture Organization (FAO) State of World Fisheries 2022 report confirms that approximately 35% of stocks are fished at biologically unsustainable levels. Illegal unreported and unregulated (IUU) fishing (estimated at 15–30% of global catch) undermines management measures. The Parties to the Nauru Agreement (PNA) controlling Western Pacific tuna fisheries is considered a successful regional fisheries management model.$t$;

UPDATE questions SET
  explanation = $t$Fermentation is one of humanitys oldest biotechnologies used for approximately 10,000 years. Fermented foods provide calories preservation and health benefits (probiotics in yoghurt and fermented vegetables). Modern industrial fermentation produces: citric acid (Aspergillus niger — food additive); monosodium glutamate; vitamins B12 and B2; and industrial enzymes (amylases proteases lipases — all used in food processing). Mycoprotein (Quorn) has grown significantly as a plant-based protein: Fusarium fermentation converts carbohydrates to fungal mycelium with protein content and texture resembling meat.$t$
WHERE id = 2128
  AND explanation = $t$Fermentation is one of humanitys oldest biotechnologies used for approximately 10 000 years. Fermented foods provide calories preservation and health benefits (probiotics in yoghurt and fermented vegetables). Modern industrial fermentation produces: citric acid (Aspergillus niger — food additive); monosodium glutamate; vitamins B12 and B2; and industrial enzymes (amylases proteases lipases — all used in food processing). Mycoprotein (Quorn) has grown significantly as a plant-based protein: Fusarium fermentation converts carbohydrates to fungal mycelium with protein content and texture resembling meat.$t$;

UPDATE questions SET
  option_a = $t$Biotechnology contributes to food security by: 1) Increasing crop yields — GM crops (Bt insecticidal crops) have increased cotton and maize yields by 10-25% in regions with significant pest pressure; high-yielding selective breeding has doubled wheat and rice yields since the Green Revolution; 2) Improving resistance to diseases and pests — reducing losses from fungal rust viruses and insects; 3) Developing drought-tolerant varieties — critical as climate change reduces rainfall reliability; 4) Improving nutritional content — golden rice (beta-carotene); biofortified crops (zinc iron — HarvestPlus programme); 5) Extending storage life — reducing postharvest losses in developing countries; and 6) Nitrogen-fixing cereals (research stage) — potentially reducing fertiliser need$t$
WHERE id = 2130
  AND option_a = $t$Biotechnology contributes to food security by: 1) Increasing crop yields — GM crops (Bt insecticidal crops) have increased cotton and maize yields by 10–25% in regions with significant pest pressure; high-yielding selective breeding has doubled wheat and rice yields since the Green Revolution; 2) Improving resistance to diseases and pests — reducing losses from fungal rust viruses and insects; 3) Developing drought-tolerant varieties — critical as climate change reduces rainfall reliability; 4) Improving nutritional content — golden rice (beta-carotene); biofortified crops (zinc iron — HarvestPlus programme); 5) Extending storage life — reducing postharvest losses in developing countries; and 6) Nitrogen-fixing cereals (research stage) — potentially reducing fertiliser need$t$;

UPDATE questions SET
  option_a = $t$Intensive crop production impacts: 1) Soil degradation — tillage destroys soil structure compaction erosion loss of organic matter; 2) Water pollution — nitrate and phosphate runoff causing eutrophication; pesticide contamination of groundwater; 3) Greenhouse gas emissions — nitrogen fertiliser production (Haber-Bosch process uses approximately 1% of global energy); N2O emissions from fertilised soils (approximately 300x more potent than CO2); 4) Biodiversity loss — monocultures support few species; pesticides kill non-target organisms including pollinators; 5) Water depletion — irrigation drawing down aquifers. Mitigation approaches: no-till agriculture (preserving soil structure); precision agriculture (GPS-guided application of exact fertiliser and pesticide amounts needed); buffer strips along waterways (filtering runoff); cover crops (protecting soil and reducing N leaching); integrated pest management (reducing pesticide use); and agroecological approaches (diversifying crop rotations and integrating biodiversity into farming landscapes)$t$,
  explanation = $t$Nitrogen fertiliser use is a key sustainability challenge: the Haber-Bosch process (producing synthetic N fertiliser) uses approximately 1% of global energy and is responsible for approximately 50% of the dietary protein for approximately 4 billion people. Nitrous oxide emissions from fertilised soils are approximately 6-7% of total greenhouse gas emissions. The nitrogen planetary boundary is already significantly exceeded. Precision agriculture (variable rate application matching fertiliser to soil need) can reduce N use by 15-20% without yield loss. Cover crops (winter cover protecting soil while fixing N or reducing leaching) are one of the most cost-effective sustainability measures.$t$
WHERE id = 2131
  AND option_a = $t$Intensive crop production impacts: 1) Soil degradation — tillage destroys soil structure compaction erosion loss of organic matter; 2) Water pollution — nitrate and phosphate runoff causing eutrophication; pesticide contamination of groundwater; 3) Greenhouse gas emissions — nitrogen fertiliser production (Haber-Bosch process uses approximately 1% of global energy); \(N2O\) emissions from fertilised soils (approximately 300× more potent than CO₂); 4) Biodiversity loss — monocultures support few species; pesticides kill non-target organisms including pollinators; 5) Water depletion — irrigation drawing down aquifers. Mitigation approaches: no-till agriculture (preserving soil structure); precision agriculture (GPS-guided application of exact fertiliser and pesticide amounts needed); buffer strips along waterways (filtering runoff); cover crops (protecting soil and reducing N leaching); integrated pest management (reducing pesticide use); and agroecological approaches (diversifying crop rotations and integrating biodiversity into farming landscapes)$t$
  AND explanation = $t$Nitrogen fertiliser use is a key sustainability challenge: the Haber-Bosch process (producing synthetic N fertiliser) uses approximately 1% of global energy and is responsible for approximately 50% of the dietary protein for approximately 4 billion people. Nitrous oxide emissions from fertilised soils are approximately 6–7% of total greenhouse gas emissions. The nitrogen planetary boundary is already significantly exceeded. Precision agriculture (variable rate application matching fertiliser to soil need) can reduce N use by 15–20% without yield loss. Cover crops (winter cover protecting soil while fixing N or reducing leaching) are one of the most cost-effective sustainability measures.$t$;

UPDATE questions SET
  explanation = $t$The land use efficiency of different diets is stark: producing 1 kg of beef requires approximately 20 kg of grain equivalent approximately 15,000 litres of water and approximately 20 m2 of land per day. Producing 1 kg of pulses requires approximately 50-300 litres of water and approximately 2 m2 of land per day. A global shift to largely plant-based diets could reduce agricultural greenhouse gas emissions by approximately 70% (Springmann et al. 2018 Nature) and free up land equivalent to the area of the USA from livestock production. The Lancet EAT commission (Willett et al. 2019) proposed a planetary health diet compatible with both human health and environmental sustainability.$t$
WHERE id = 2132
  AND explanation = $t$The land use efficiency of different diets is stark: producing \(1\,\text{kg}\) of beef requires approximately \(20\,\text{kg}\) of grain equivalent approximately 15 000 litres of water and approximately \(20 m^{2}\) of land per day. Producing \(1\,\text{kg}\) of pulses requires approximately 50–300 litres of water and approximately \(2 m^{2}\) of land per day. A global shift to largely plant-based diets could reduce agricultural greenhouse gas emissions by approximately 70% (Springmann et al. 2018 Nature) and free up land equivalent to the area of the USA from livestock production. The Lancet EAT commission (Willett et al. 2019) proposed a planetary health diet compatible with both human health and environmental sustainability.$t$;

UPDATE questions SET
  option_a = $t$Pre-industrial nitrogen cycling was dominated by biological fixation and relatively small natural losses. The Haber-Bosch process (1913) has doubled the amount of reactive nitrogen in the global environment — approximately 120 Tg N/year is fixed industrially versus approximately 140 Tg/year biologically (now greatly exceeding pre-industrial rates). Consequences: nitrate leaching into groundwater (drinking water contamination — WHO limit 50 mg/L NO3); coastal eutrophication creating approximately 400 dead zones globally (Gulf of Mexico dead zone approximately 20,000 km2); nitrous oxide emissions (powerful greenhouse gas); and indirect effects on terrestrial biodiversity (nitrogen deposition). Phosphorus: mined from finite rock phosphate reserves at rates unsustainable for centuries; approximately 80% of applied P is lost to waterways; freshwater eutrophication (P is typically limiting in freshwater vs N in coastal seas); and phosphate is a non-renewable resource with potential scarcity implications for food security. Solutions: precision fertiliser application; phosphorus recycling (from sewage struvite precipitation); cover crops; constructed wetlands filtering agricultural runoff; and riparian buffer strips$t$,
  explanation = $t$The planetary boundaries for nitrogen and phosphorus flows are among those most severely transgressed. The biogeochemical flows boundary requires keeping P addition to freshwater below approximately 11 Tg/year and total N added to land below approximately 62 Tg/year — current rates are approximately 22 Tg/year for P and approximately 150 Tg/year for N (both substantially exceeding boundaries). The social cost of reactive nitrogen (including health effects from air pollution water eutrophication greenhouse gas warming and biodiversity loss) has been estimated at approximately €70-320 billion/year for the EU alone.$t$
WHERE id = 2134
  AND option_a = $t$Pre-industrial nitrogen cycling was dominated by biological fixation and relatively small natural losses. The Haber-Bosch process (1913) has doubled the amount of reactive nitrogen in the global environment — approximately 120 Tg N/year is fixed industrially versus approximately 140 Tg/year biologically (now greatly exceeding pre-industrial rates). Consequences: nitrate leaching into groundwater (drinking water contamination — WHO limit \(50\,\text{mg/L}\) NO₃); coastal eutrophication creating approximately 400 dead zones globally (Gulf of Mexico dead zone approximately \(20\,000\,\text{km}^{2}\)); nitrous oxide emissions (powerful greenhouse gas); and indirect effects on terrestrial biodiversity (nitrogen deposition). Phosphorus: mined from finite rock phosphate reserves at rates unsustainable for centuries; approximately 80% of applied P is lost to waterways; freshwater eutrophication (P is typically limiting in freshwater vs N in coastal seas); and phosphate is a non-renewable resource with potential scarcity implications for food security. Solutions: precision fertiliser application; phosphorus recycling (from sewage struvite precipitation); cover crops; constructed wetlands filtering agricultural runoff; and riparian buffer strips$t$
  AND explanation = $t$The planetary boundaries for nitrogen and phosphorus flows are among those most severely transgressed. The biogeochemical flows boundary requires keeping P addition to freshwater below approximately 11 Tg/year and total N added to land below approximately 62 Tg/year — current rates are approximately 22 Tg/year for P and approximately 150 Tg/year for N (both substantially exceeding boundaries). The social cost of reactive nitrogen (including health effects from air pollution water eutrophication greenhouse gas warming and biodiversity loss) has been estimated at approximately €70–320 billion/year for the EU alone.$t$;

UPDATE questions SET
  option_c = $t$Vertical farming (multi-layer crop production in controlled environments): advantages — land use efficiency (up to 100x more efficient per m2 than field production); water use efficiency (up to 95% less water than conventional — closed-loop recirculation); elimination of pesticides (sealed environment); year-round production independent of weather; proximity to urban consumers (reducing transport emissions and food miles); and potential for crop production in non-agricultural land (deserts urban areas). Limitations: very high energy use (LED lighting and HVAC are major costs — currently makes carbon footprint higher than conventional for many crops unless powered by renewables); high capital and operating costs (currently only economically viable for high-value crops like leafy vegetables herbs strawberries); cannot currently produce staple crops (wheat rice maize) at competitive cost; and depends on manufactured nutrients (no natural soil cycling). Potential under renewables: if powered entirely by solar energy the carbon and economic arguments improve substantially making it viable for more crops$t$,
  explanation = $t$Vertical farming has grown rapidly: the global vertical farming market was approximately $5 billion in 2022 projected to reach approximately $25 billion by 2028. Companies like AeroFarms (USA) Bowery (USA) and Nordic Harvest (Denmark) operate large commercial facilities. The energy challenge is significant: LEDs consume approximately 30-40 kWh per kg of lettuce produced — approximately 20-40x the energy of field production. However if powered by excess renewable electricity (solar during peak generation) the carbon footprint can be competitive. The breakthrough required for wider application is developing economically viable LED-based production for cereal crops which provide approximately 50% of human calories.$t$
WHERE id = 2135
  AND option_c = $t$Vertical farming (multi-layer crop production in controlled environments): advantages — land use efficiency (up to 100× more efficient per \(m^{2}\) than field production); water use efficiency (up to 95% less water than conventional — closed-loop recirculation); elimination of pesticides (sealed environment); year-round production independent of weather; proximity to urban consumers (reducing transport emissions and food miles); and potential for crop production in non-agricultural land (deserts urban areas). Limitations: very high energy use (LED lighting and HVAC are major costs — currently makes carbon footprint higher than conventional for many crops unless powered by renewables); high capital and operating costs (currently only economically viable for high-value crops like leafy vegetables herbs strawberries); cannot currently produce staple crops (wheat rice maize) at competitive cost; and depends on manufactured nutrients (no natural soil cycling). Potential under renewables: if powered entirely by solar energy the carbon and economic arguments improve substantially making it viable for more crops$t$
  AND explanation = $t$Vertical farming has grown rapidly: the global vertical farming market was approximately $5 billion in 2022 projected to reach approximately $25 billion by 2028. Companies like AeroFarms (USA) Bowery (USA) and Nordic Harvest (Denmark) operate large commercial facilities. The energy challenge is significant: LEDs consume approximately 30–40 kWh per kg of lettuce produced — approximately 20–40× the energy of field production. However if powered by excess renewable electricity (solar during peak generation) the carbon footprint can be competitive. The breakthrough required for wider application is developing economically viable LED-based production for cereal crops which provide approximately 50% of human calories.$t$;

UPDATE questions SET
  explanation = $t$The HarvestPlus programme (CGIAR) has released over 290 biofortified varieties of 12 crops in more than 30 countries. The evidence base is strongest for orange-fleshed sweet potato (OFSP): multiple RCTs in Sub-Saharan Africa have demonstrated statistically significant improvements in child vitamin A status and serum retinol concentrations. Iron-biofortified bean RCTs have shown improvements in haematological status in women. Cost-effectiveness analyses (Copenhagen Consensus) consistently rank biofortification among the highest return interventions for reducing hidden hunger — approximately $10-50 per DALY (disability-adjusted life year) saved compared to $100+ for many pharmaceutical interventions.$t$
WHERE id = 2136
  AND explanation = $t$The HarvestPlus programme (CGIAR) has released over 290 biofortified varieties of 12 crops in more than 30 countries. The evidence base is strongest for orange-fleshed sweet potato (OFSP): multiple RCTs in Sub-Saharan Africa have demonstrated statistically significant improvements in child vitamin A status and serum retinol concentrations. Iron-biofortified bean RCTs have shown improvements in haematological status in women. Cost-effectiveness analyses (Copenhagen Consensus) consistently rank biofortification among the highest return interventions for reducing hidden hunger — approximately $10–50 per DALY (disability-adjusted life year) saved compared to $100+ for many pharmaceutical interventions.$t$;

UPDATE questions SET
  option_b = $t$The protein transition: as incomes rise meat consumption typically increases (following a dietary transition from cereals and pulses to more diverse diets including more animal products — Bennetts law of dietary transition). China meat consumption has increased approximately 4x since 1980; Brazil meat consumption has doubled. Implications: livestock production currently uses approximately 80% of global agricultural land and accounts for approximately 14.5% of greenhouse gas emissions; a doubling of global meat demand would require massive additional agricultural expansion (primarily in tropical regions — driving deforestation) and double agricultural greenhouse gas emissions; water use for livestock production would strain already scarce freshwater resources; and grain prices would increase as more grain is diverted to animal feed reducing access for the poor. Counter-trends: plant-based meat alternatives (Beyond Meat Impossible Foods) and cultured meat are growing rapidly; some countries show a decoupling of income from meat consumption at high income levels; and dietary guidelines increasingly recommend reducing red meat consumption$t$,
  explanation = $t$The dietary transition poses one of the largest sustainability challenges for the food system. The FAO projects global meat demand to increase by approximately 50-70% by 2050. The environmental consequences of meeting this demand through conventional livestock production would be catastrophic for climate change and biodiversity. Alternative proteins (plant-based cultured insect-based) are growing rapidly from a small base — BloombergNEF projects alternative proteins could reach approximately 11% of the global protein market by 2035. Preventing the worst environmental impacts requires both supply-side innovation (alternative proteins) and demand-side change (particularly in high-consumption developed countries).$t$
WHERE id = 2138
  AND option_b = $t$The protein transition: as incomes rise meat consumption typically increases (following a dietary transition from cereals and pulses to more diverse diets including more animal products — Bennetts law of dietary transition). China meat consumption has increased approximately 4× since 1980; Brazil meat consumption has doubled. Implications: livestock production currently uses approximately 80% of global agricultural land and accounts for approximately 14.5% of greenhouse gas emissions; a doubling of global meat demand would require massive additional agricultural expansion (primarily in tropical regions — driving deforestation) and double agricultural greenhouse gas emissions; water use for livestock production would strain already scarce freshwater resources; and grain prices would increase as more grain is diverted to animal feed reducing access for the poor. Counter-trends: plant-based meat alternatives (Beyond Meat Impossible Foods) and cultured meat are growing rapidly; some countries show a decoupling of income from meat consumption at high income levels; and dietary guidelines increasingly recommend reducing red meat consumption$t$
  AND explanation = $t$The dietary transition poses one of the largest sustainability challenges for the food system. The FAO projects global meat demand to increase by approximately 50–70% by 2050. The environmental consequences of meeting this demand through conventional livestock production would be catastrophic for climate change and biodiversity. Alternative proteins (plant-based cultured insect-based) are growing rapidly from a small base — BloombergNEF projects alternative proteins could reach approximately 11% of the global protein market by 2035. Preventing the worst environmental impacts requires both supply-side innovation (alternative proteins) and demand-side change (particularly in high-consumption developed countries).$t$;

UPDATE questions SET
  option_c = $t$Agriculture uses approximately 70% of global freshwater withdrawals. Water scarcity: approximately 4 billion people experience severe water scarcity for at least one month per year; aquifer depletion (particularly Ogallala aquifer in USA and fossil aquifers in Middle East and North Africa) is reducing irrigation capacity; climate change is predicted to increase water stress in agricultural regions; and irrigation competes with municipal and industrial demand. Water use efficiency strategies: 1) Drip irrigation (reduces water use by 30-50% vs flood irrigation delivering water directly to roots); 2) Deficit irrigation (deliberately stressing crops at less water-sensitive growth stages); 3) Rainwater harvesting and conservation tillage (increasing rainfall infiltration); 4) Drought-tolerant crop varieties (via conventional breeding and GM); 5) Virtual water trade (importing water-intensive products from water-rich regions rather than growing them in water-scarce regions); and 6) Pricing water at its true value (currently underpriced in most regions creating wasteful use incentives)$t$,
  explanation = $t$The Ogallala aquifer depletion is a critical food security issue for the USA. The aquifer (one of the worlds largest) underlies approximately 450,000 km2 of the Great Plains and supports approximately 30% of US groundwater irrigation producing approximately $35 billion in food annually. Depletion rates exceed recharge by approximately 100:1 — much of the water is ancient fossil water from the last ice age. At current depletion rates approximately 35% of the aquifer will be unusable for irrigation within 30 years. This represents one of the most concrete near-term food security threats for a major food exporting country.$t$
WHERE id = 2139
  AND option_c = $t$Agriculture uses approximately 70% of global freshwater withdrawals. Water scarcity: approximately 4 billion people experience severe water scarcity for at least one month per year; aquifer depletion (particularly Ogallala aquifer in USA and fossil aquifers in Middle East and North Africa) is reducing irrigation capacity; climate change is predicted to increase water stress in agricultural regions; and irrigation competes with municipal and industrial demand. Water use efficiency strategies: 1) Drip irrigation (reduces water use by 30–50% vs flood irrigation delivering water directly to roots); 2) Deficit irrigation (deliberately stressing crops at less water-sensitive growth stages); 3) Rainwater harvesting and conservation tillage (increasing rainfall infiltration); 4) Drought-tolerant crop varieties (via conventional breeding and GM); 5) Virtual water trade (importing water-intensive products from water-rich regions rather than growing them in water-scarce regions); and 6) Pricing water at its true value (currently underpriced in most regions creating wasteful use incentives)$t$
  AND explanation = $t$The Ogallala aquifer depletion is a critical food security issue for the USA. The aquifer (one of the worlds largest) underlies approximately \(450\,000\,\text{km}^{2}\) of the Great Plains and supports approximately 30% of US groundwater irrigation producing approximately $35 billion in food annually. Depletion rates exceed recharge by approximately \(100 : 1\) — much of the water is ancient fossil water from the last ice age. At current depletion rates approximately 35% of the aquifer will be unusable for irrigation within 30 years. This represents one of the most concrete near-term food security threats for a major food exporting country.$t$;

UPDATE questions SET
  option_a = $t$Insects as food (entomophagy) and as animal feed: approximately 2 billion people in 80 countries regularly eat insects (beetles caterpillars ants termites grasshoppers). Sustainability advantages: 1) Feed conversion efficiency — insects convert feed to protein approximately 2x more efficiently than chicken 4x more than pigs and 12x more than cattle; 2) Land and water use — approximately 10x less land per kg protein than beef approximately 1000x less water; 3) Greenhouse gas emissions — approximately 100x less per kg protein than beef; 4) Can be raised on organic waste streams (reducing waste while producing protein); 5) High nutritional value (protein fat vitamins minerals). Barriers to adoption in Western markets: cultural reluctance (neophobia); food safety regulations (particularly for waste-fed insects); allergen concerns (cross-reactivity with crustaceans); and scale-up challenges. Species being commercially developed: black soldier fly (Hermetia illucens — primarily for animal feed); yellow mealworm (Tenebrio molitor — EU approved as novel food 2021); crickets (Acheta domesticus)$t$
WHERE id = 2140
  AND option_a = $t$Insects as food (entomophagy) and as animal feed: approximately 2 billion people in 80 countries regularly eat insects (beetles caterpillars ants termites grasshoppers). Sustainability advantages: 1) Feed conversion efficiency — insects convert feed to protein approximately 2× more efficiently than chicken 4× more than pigs and 12× more than cattle; 2) Land and water use — approximately 10× less land per kg protein than beef approximately 1000× less water; 3) Greenhouse gas emissions — approximately 100× less per kg protein than beef; 4) Can be raised on organic waste streams (reducing waste while producing protein); 5) High nutritional value (protein fat vitamins minerals). Barriers to adoption in Western markets: cultural reluctance (neophobia); food safety regulations (particularly for waste-fed insects); allergen concerns (cross-reactivity with crustaceans); and scale-up challenges. Species being commercially developed: black soldier fly (Hermetia illucens — primarily for animal feed); yellow mealworm (Tenebrio molitor — EU approved as novel food 2021); crickets (Acheta domesticus)$t$;

UPDATE questions SET
  option_d = $t$Cultured meat is produced by cultivating animal cells in bioreactors without slaughtering animals. Potential advantages: 1) Land use — could reduce land use by approximately 95% vs conventional beef (no need for animal grazing or feed crop land — only small quantities of growth medium ingredients needed); 2) Greenhouse gas emissions — lifecycle analysis estimates approximately 78-92% reduction in CO2 equivalent vs conventional beef (eliminating enteric fermentation from cattle); 3) Animal welfare (no slaughter no intensive farming conditions); 4) Food safety (controlled sterile production eliminates risk of contamination at source). Uncertainties and concerns: 1) Energy use — bioreactor production is energy-intensive (current estimates suggest higher energy use per kg than conventional beef potentially offsetting GHG benefits unless powered by renewables); 2) Current cost is very high ($10-100/kg in 2023 vs $5-20/kg conventional — though declining rapidly); 3) Social impacts — conventional livestock farming employs approximately 1 billion people globally — cultured meat growth could displace livelihoods; 4) Public acceptance; and 5) Regulatory approval (USA and Singapore approved in 2023)$t$,
  explanation = $t$Cultured meat received regulatory approval for commercial sale in Singapore (2020) and the USA (USDA/FDA approval for Upside Foods and Good Meat 2023). The price decline trajectory resembles early solar panel cost reductions: from approximately $325,000/kg (first burger 2013) to approximately $10-100/kg (2023) and predicted to reach price parity with conventional meat by approximately 2030. The lifecycle analysis uncertainty is significant: Risner et al. (2023 Future Foods) found that under a high-energy scenario cultured meat could have higher long-term climate impact than conventional beef due to CO2 vs CH4 differences in atmospheric lifetime — CO2 persists for centuries while CH4 is shorter-lived.$t$
WHERE id = 2141
  AND option_d = $t$Cultured meat is produced by cultivating animal cells in bioreactors without slaughtering animals. Potential advantages: 1) Land use — could reduce land use by approximately 95% vs conventional beef (no need for animal grazing or feed crop land — only small quantities of growth medium ingredients needed); 2) Greenhouse gas emissions — lifecycle analysis estimates approximately 78–92% reduction in CO₂ equivalent vs conventional beef (eliminating enteric fermentation from cattle); 3) Animal welfare (no slaughter no intensive farming conditions); 4) Food safety (controlled sterile production eliminates risk of contamination at source). Uncertainties and concerns: 1) Energy use — bioreactor production is energy-intensive (current estimates suggest higher energy use per kg than conventional beef potentially offsetting GHG benefits unless powered by renewables); 2) Current cost is very high ($\(10 - 100\)/kg in 2023 vs $\(5 - 20\)/kg conventional — though declining rapidly); 3) Social impacts — conventional livestock farming employs approximately 1 billion people globally — cultured meat growth could displace livelihoods; 4) Public acceptance; and 5) Regulatory approval (USA and Singapore approved in 2023)$t$
  AND explanation = $t$Cultured meat received regulatory approval for commercial sale in Singapore (2020) and the USA (USDA/FDA approval for Upside Foods and Good Meat 2023). The price decline trajectory resembles early solar panel cost reductions: from approximately $325 000/kg (first burger 2013) to approximately $\(10 - 100\)/kg (2023) and predicted to reach price parity with conventional meat by approximately 2030. The lifecycle analysis uncertainty is significant: Risner et al. (2023 Future Foods) found that under a high-energy scenario cultured meat could have higher long-term climate impact than conventional beef due to CO₂ vs CH₄ differences in atmospheric lifetime — CO₂ persists for centuries while CH₄ is shorter-lived.$t$;

UPDATE questions SET
  option_d = $t$Food aid provides emergency nutrition during famines and conflicts and has undoubtedly saved millions of lives (Ethiopia 1984-85 Somalia 1992 South Sudan ongoing). However it has documented limitations and potential harms: 1) Market disruption — surplus food from developed countries (often subsidised) can undercut local food production when distributed commercially (commodity food aid) reducing incentives for local agricultural investment and creating dependency; 2) Tied aid — historically much food aid required purchase from donor country producers even when local or regional purchase would be cheaper and faster; 3) Political manipulation — food aid has been used as a geopolitical tool and withheld for political reasons; 4) Logistical challenges — food aid takes weeks or months to arrive by which time acute food emergencies may have peaked; 5) Local market development — cash transfers and local purchase (buying food from markets close to the emergency) is generally more cost-effective at maintaining local agricultural incentives while still providing nutrition. Evolution: the humanitarian community has increasingly shifted from commodity aid to cash transfers (giving recipients purchasing power) and local and regional procurement (buying food from within the region) which addresses many of the dependency and market disruption concerns$t$,
  explanation = $t$The food aid reform debate reflects genuine tensions in humanitarian assistance. PL 480 (the US Food for Peace programme established 1954) was originally designed to dispose of US agricultural surpluses while providing development assistance — an inherent conflict of interest between donor commercial interests and recipient needs. The 2008 Farm Bill introduced limited flexibility for local and regional purchase in US food aid which evidence showed reduced costs by approximately 20-25% and response times by approximately 100 days. The WFP increasingly uses cash-based assistance (approximately 40% of its programming) showing comparable nutritional outcomes to in-kind food at lower cost.$t$
WHERE id = 2142
  AND option_d = $t$Food aid provides emergency nutrition during famines and conflicts and has undoubtedly saved millions of lives (Ethiopia 1984–85 Somalia 1992 South Sudan ongoing). However it has documented limitations and potential harms: 1) Market disruption — surplus food from developed countries (often subsidised) can undercut local food production when distributed commercially (commodity food aid) reducing incentives for local agricultural investment and creating dependency; 2) Tied aid — historically much food aid required purchase from donor country producers even when local or regional purchase would be cheaper and faster; 3) Political manipulation — food aid has been used as a geopolitical tool and withheld for political reasons; 4) Logistical challenges — food aid takes weeks or months to arrive by which time acute food emergencies may have peaked; 5) Local market development — cash transfers and local purchase (buying food from markets close to the emergency) is generally more cost-effective at maintaining local agricultural incentives while still providing nutrition. Evolution: the humanitarian community has increasingly shifted from commodity aid to cash transfers (giving recipients purchasing power) and local and regional procurement (buying food from within the region) which addresses many of the dependency and market disruption concerns$t$
  AND explanation = $t$The food aid reform debate reflects genuine tensions in humanitarian assistance. PL 480 (the US Food for Peace programme established 1954) was originally designed to dispose of US agricultural surpluses while providing development assistance — an inherent conflict of interest between donor commercial interests and recipient needs. The 2008 Farm Bill introduced limited flexibility for local and regional purchase in US food aid which evidence showed reduced costs by approximately 20–25% and response times by approximately 100 days. The WFP increasingly uses cash-based assistance (approximately 40% of its programming) showing comparable nutritional outcomes to in-kind food at lower cost.$t$;

UPDATE questions SET
  option_c = $t$Climate change threatens crop production by: altering rainfall patterns (more intense rainfall and droughts reducing reliable water supply for agriculture); increasing temperatures above optimal ranges for key crops (wheat rice maize have reduced yields above approximately 30 degrees C); increasing frequency of extreme weather events (floods droughts heat waves); shifting pest and disease ranges into previously protected regions; changing pollinator distributions and timing; and rising sea levels salinising coastal agricultural land. Models project crop yield declines of 2-6% per decade for major crops in tropical regions while demand increases with population growth$t$,
  explanation = $t$The impact of climate change on crop yields is well-modelled. IPCC AR6 projects that without adaptation climate change will reduce global crop yields by approximately 2-6% per decade while demand increases by approximately 1-2% per decade — a growing gap between supply and potential demand. Tropical and subtropical regions are most affected because temperatures are already near the upper thermal limits of many crops. Wealthier temperate regions may initially see yield increases (longer growing seasons) but this advantage will be overwhelmed by warming at higher temperature scenarios. Water stress (drought) is the dominant agricultural impact pathway in most regions.$t$
WHERE id = 2144
  AND option_c = $t$Climate change threatens crop production by: altering rainfall patterns (more intense rainfall and droughts reducing reliable water supply for agriculture); increasing temperatures above optimal ranges for key crops (wheat rice maize have reduced yields above approximately 30 degrees C); increasing frequency of extreme weather events (floods droughts heat waves); shifting pest and disease ranges into previously protected regions; changing pollinator distributions and timing; and rising sea levels salinising coastal agricultural land. Models project crop yield declines of 2–6% per decade for major crops in tropical regions while demand increases with population growth$t$
  AND explanation = $t$The impact of climate change on crop yields is well-modelled. IPCC AR6 projects that without adaptation climate change will reduce global crop yields by approximately 2–6% per decade while demand increases by approximately 1–2% per decade — a growing gap between supply and potential demand. Tropical and subtropical regions are most affected because temperatures are already near the upper thermal limits of many crops. Wealthier temperate regions may initially see yield increases (longer growing seasons) but this advantage will be overwhelmed by warming at higher temperature scenarios. Water stress (drought) is the dominant agricultural impact pathway in most regions.$t$;

UPDATE questions SET
  option_a = $t$Plant-based diets have significantly lower environmental impacts because: 1) Land use — livestock farming (including land for feed crops) uses approximately 80% of agricultural land but provides approximately 20% of caloric intake; plant foods require approximately 10x less land per unit of nutrition; 2) Greenhouse gas emissions — plant production emits approximately 10-50x less greenhouse gas per unit of protein than beef; 3) Water use — plant foods require approximately 10-100x less water per unit of protein; 4) Biodiversity impact — reducing livestock farming would allow land to be restored to natural habitats. Switching the average UK diet from the current diet to a vegan diet would reduce food-related greenhouse gas emissions by approximately 50-70%$t$
WHERE id = 2145
  AND option_a = $t$Plant-based diets have significantly lower environmental impacts because: 1) Land use — livestock farming (including land for feed crops) uses approximately 80% of agricultural land but provides approximately 20% of caloric intake; plant foods require approximately 10× less land per unit of nutrition; 2) Greenhouse gas emissions — plant production emits approximately 10–50× less greenhouse gas per unit of protein than beef; 3) Water use — plant foods require approximately 10–100× less water per unit of protein; 4) Biodiversity impact — reducing livestock farming would allow land to be restored to natural habitats. Switching the average UK diet from the current diet to a vegan diet would reduce food-related greenhouse gas emissions by approximately 50–70%$t$;

UPDATE questions SET
  option_c = $t$Approximately 75% of the worlds 115 most important food crops benefit from animal pollination (IPBES 2016). Pollination contributes approximately $235-577 billion of global crop production annually. Crops dependent on pollinators include: fruits (apples strawberries almonds); vegetables (tomatoes cucumbers squash); oil crops (oilseed rape sunflower); and many others. Threats to pollinators: 1) Habitat loss (removal of wildflower habitats and hedgerows reducing food and nesting resources); 2) Pesticide use (neonicotinoid insecticides particularly harmful to bees — affecting navigation reproduction and immune function); 3) Disease and parasites (Varroa mite in honeybees; Nosema pathogens); 4) Climate change (altering flowering timing and bee emergence phenology); and 5) Invasive species (Asian hornet attacking honeybee colonies)$t$,
  explanation = $t$The value of pollination services to food security has been quantified increasingly precisely. Almonds are entirely dependent on bee pollination — the California almond industry (approximately 80% of global supply) requires approximately 1.8 million honeybee colonies for pollination each spring. Bee decline has driven up commercial pollination costs dramatically. Wild bees provide pollination services valued at approximately $3,000-$6,000 per hectare for certain crops. The loss of wild bee populations through habitat loss and pesticide use therefore represents a direct food security risk.$t$
WHERE id = 2147
  AND option_c = $t$Approximately 75% of the worlds 115 most important food crops benefit from animal pollination (IPBES 2016). Pollination contributes approximately $235–577 billion of global crop production annually. Crops dependent on pollinators include: fruits (apples strawberries almonds); vegetables (tomatoes cucumbers squash); oil crops (oilseed rape sunflower); and many others. Threats to pollinators: 1) Habitat loss (removal of wildflower habitats and hedgerows reducing food and nesting resources); 2) Pesticide use (neonicotinoid insecticides particularly harmful to bees — affecting navigation reproduction and immune function); 3) Disease and parasites (Varroa mite in honeybees; Nosema pathogens); 4) Climate change (altering flowering timing and bee emergence phenology); and 5) Invasive species (Asian hornet attacking honeybee colonies)$t$
  AND explanation = $t$The value of pollination services to food security has been quantified increasingly precisely. Almonds are entirely dependent on bee pollination — the California almond industry (approximately 80% of global supply) requires approximately 1.8 million honeybee colonies for pollination each spring. Bee decline has driven up commercial pollination costs dramatically. Wild bees provide pollination services valued at approximately $3 000-$6 000 per hectare for certain crops. The loss of wild bee populations through habitat loss and pesticide use therefore represents a direct food security risk.$t$;

UPDATE questions SET
  explanation = $t$The distinction has policy implications. Reducing food loss in Sub-Saharan Africa primarily requires investment in infrastructure (grain storage silos drying facilities cold chains) and market access improvements. These investments have high returns for food security. Reducing consumer food waste in developed countries requires behaviour change (arguably harder to achieve through policy) and changes in retail practices (date labelling FIFO stock management portion sizes). The WRAP estimate for the UK suggests reducing household food waste by 50% would save approximately 18 million tonnes of CO2 equivalent per year.$t$
WHERE id = 2148
  AND explanation = $t$The distinction has policy implications. Reducing food loss in Sub-Saharan Africa primarily requires investment in infrastructure (grain storage silos drying facilities cold chains) and market access improvements. These investments have high returns for food security. Reducing consumer food waste in developed countries requires behaviour change (arguably harder to achieve through policy) and changes in retail practices (date labelling FIFO stock management portion sizes). The WRAP estimate for the UK suggests reducing household food waste by 50% would save approximately 18 million tonnes of CO₂ equivalent per year.$t$;

UPDATE questions SET
  explanation = $t$Aquaculture has been the fastest growing food production sector for decades. China produces approximately 60% of global aquaculture output. The feed conversion efficiency of salmon (approximately 1.2:1 compared to approximately 6:1 for beef) makes it one of the most resource-efficient sources of animal protein. However the fishmeal problem (approximately 20% of global wild fish catch goes to fishmeal for aquaculture and livestock) creates a sustainability paradox where increasing fish farming can increase pressure on wild fish stocks. This is being addressed by fishmeal substitution with soy algae and insect protein.$t$
WHERE id = 2149
  AND explanation = $t$Aquaculture has been the fastest growing food production sector for decades. China produces approximately 60% of global aquaculture output. The feed conversion efficiency of salmon (approximately \(1.2 : 1\) compared to approximately \(6 : 1\) for beef) makes it one of the most resource-efficient sources of animal protein. However the fishmeal problem (approximately 20% of global wild fish catch goes to fishmeal for aquaculture and livestock) creates a sustainability paradox where increasing fish farming can increase pressure on wild fish stocks. This is being addressed by fishmeal substitution with soy algae and insect protein.$t$;

UPDATE questions SET
  option_a = $t$IPM is an ecosystem-based approach to pest management that combines multiple strategies to minimise pest damage while reducing reliance on chemical pesticides. Principles: 1) Prevention (crop rotation resistant varieties physical barriers); 2) Monitoring (regular scouting to detect pests before reaching damaging levels — only apply pesticides when pest populations exceed economic thresholds); 3) Biological control (using natural predators parasitoids and pathogens of pests — e.g. ladybirds eating aphids; Bacillus thuringiensis for caterpillars; parasitic wasps for whitefly); 4) Cultural controls (timing of planting to avoid pest peaks; removal of crop residues; diverse landscapes maintaining natural enemy populations); 5) Chemical control as a last resort (choosing selective pesticides that minimise harm to beneficial insects and using them only when other methods are insufficient). IPM typically reduces pesticide use by 30-50% while maintaining yield and often increasing profitability$t$,
  explanation = $t$IPM principles were developed from the 1950s onwards in response to the recognition that indiscriminate pesticide use caused resistance development in pests killed natural enemies (causing secondary pest outbreaks) and had unacceptable environmental costs. The economic threshold concept (Stern 1959) was revolutionary: not every pest should be controlled — only when pest density will cause economic damage exceeding the cost of control. IPM is now mainstream in developed country agriculture and is increasingly promoted in developing countries through Farmer Field Schools (FAO programme training farmers to observe and manage their own fields).$t$
WHERE id = 2150
  AND option_a = $t$IPM is an ecosystem-based approach to pest management that combines multiple strategies to minimise pest damage while reducing reliance on chemical pesticides. Principles: 1) Prevention (crop rotation resistant varieties physical barriers); 2) Monitoring (regular scouting to detect pests before reaching damaging levels — only apply pesticides when pest populations exceed economic thresholds); 3) Biological control (using natural predators parasitoids and pathogens of pests — e.g. ladybirds eating aphids; Bacillus thuringiensis for caterpillars; parasitic wasps for whitefly); 4) Cultural controls (timing of planting to avoid pest peaks; removal of crop residues; diverse landscapes maintaining natural enemy populations); 5) Chemical control as a last resort (choosing selective pesticides that minimise harm to beneficial insects and using them only when other methods are insufficient). IPM typically reduces pesticide use by 30–50% while maintaining yield and often increasing profitability$t$
  AND explanation = $t$IPM principles were developed from the \(1950s\) onwards in response to the recognition that indiscriminate pesticide use caused resistance development in pests killed natural enemies (causing secondary pest outbreaks) and had unacceptable environmental costs. The economic threshold concept (Stern 1959) was revolutionary: not every pest should be controlled — only when pest density will cause economic damage exceeding the cost of control. IPM is now mainstream in developed country agriculture and is increasingly promoted in developing countries through Farmer Field Schools (FAO programme training farmers to observe and manage their own fields).$t$;

UPDATE questions SET
  option_c = $t$Free trade arguments for food security: specialisation allows countries to import what they cannot produce efficiently; consumers benefit from lower prices; international trade smooths regional production shocks (a drought in one region is offset by imports from unaffected regions); and global food trade has grown approximately 5x since 1990 contributing to falling real food prices. Food sovereignty arguments: over-dependence on imports creates vulnerability to supply chain disruptions (COVID-19 demonstrated this dramatically); agricultural trade may drive land use change in exporting countries (deforestation); cheap imports can undercut local farmers reducing domestic production capacity; and countries with food sovereignty (ability to produce their own food) are more resilient to geopolitical shocks and price spikes. Recent experience: Russia invasion of Ukraine (2022) disrupted wheat and sunflower exports causing price spikes that triggered food crises in import-dependent countries (Egypt Tunisia Lebanon) — supporting food sovereignty arguments. The optimal policy likely involves some degree of strategic self-sufficiency combined with diversified trade relationships to balance efficiency and resilience$t$
WHERE id = 2152
  AND option_c = $t$Free trade arguments for food security: specialisation allows countries to import what they cannot produce efficiently; consumers benefit from lower prices; international trade smooths regional production shocks (a drought in one region is offset by imports from unaffected regions); and global food trade has grown approximately 5× since 1990 contributing to falling real food prices. Food sovereignty arguments: over-dependence on imports creates vulnerability to supply chain disruptions (COVID-19 demonstrated this dramatically); agricultural trade may drive land use change in exporting countries (deforestation); cheap imports can undercut local farmers reducing domestic production capacity; and countries with food sovereignty (ability to produce their own food) are more resilient to geopolitical shocks and price spikes. Recent experience: Russia invasion of Ukraine (2022) disrupted wheat and sunflower exports causing price spikes that triggered food crises in import-dependent countries (Egypt Tunisia Lebanon) — supporting food sovereignty arguments. The optimal policy likely involves some degree of strategic self-sufficiency combined with diversified trade relationships to balance efficiency and resilience$t$;

UPDATE questions SET
  option_b = $t$Land tenure (the legal and social rights to use occupy or own land) is one of the most important determinants of agricultural investment and food security in developing countries. Secure land tenure: enables farmers to invest in land improvement (irrigation drainage tree planting) with confidence they will benefit from the returns; allows land to be used as collateral for credit; reduces risk of displacement; and provides incentives for sustainable long-term soil management. Insecure land tenure consequences: farmers invest minimally in land they may lose; women (who perform approximately 60-80% of food production in Sub-Saharan Africa but rarely hold formal land rights) are particularly disadvantaged; investors acquire large tracts displacing smallholders (land grabbing — approximately 26 million ha acquired globally by foreign investors 2000-2016); and conflict over land is a major driver of food insecurity. Solutions: land registration programmes; community land rights recognition; gender-equitable land law reform; and international standards for responsible agricultural investment (Voluntary Guidelines on Land Tenure — FAO 2012)$t$,
  explanation = $t$Land tenure and food security linkages are well-documented. FAO evidence shows that secure land tenure increases agricultural investment by approximately 30-40%. The gender dimension is particularly important: women produce approximately 60-80% of food in Sub-Saharan Africa but typically have insecure secondary land rights through male relatives. When husbands die or leave women frequently lose land access reducing both their own food security and their ability to feed their children. Countries that have reformed land law to provide equal inheritance rights (Rwanda Ethiopia) have seen agricultural investment increases and improved food security outcomes.$t$
WHERE id = 2155
  AND option_b = $t$Land tenure (the legal and social rights to use occupy or own land) is one of the most important determinants of agricultural investment and food security in developing countries. Secure land tenure: enables farmers to invest in land improvement (irrigation drainage tree planting) with confidence they will benefit from the returns; allows land to be used as collateral for credit; reduces risk of displacement; and provides incentives for sustainable long-term soil management. Insecure land tenure consequences: farmers invest minimally in land they may lose; women (who perform approximately 60–80% of food production in Sub-Saharan Africa but rarely hold formal land rights) are particularly disadvantaged; investors acquire large tracts displacing smallholders (land grabbing — approximately 26 million ha acquired globally by foreign investors \(2000 - 2016\)); and conflict over land is a major driver of food insecurity. Solutions: land registration programmes; community land rights recognition; gender-equitable land law reform; and international standards for responsible agricultural investment (Voluntary Guidelines on Land Tenure — FAO 2012)$t$
  AND explanation = $t$Land tenure and food security linkages are well-documented. FAO evidence shows that secure land tenure increases agricultural investment by approximately 30–40%. The gender dimension is particularly important: women produce approximately 60–80% of food in Sub-Saharan Africa but typically have insecure secondary land rights through male relatives. When husbands die or leave women frequently lose land access reducing both their own food security and their ability to feed their children. Countries that have reformed land law to provide equal inheritance rights (Rwanda Ethiopia) have seen agricultural investment increases and improved food security outcomes.$t$;

UPDATE questions SET
  option_d = $t$The EAT-Lancet planetary health diet (Willett et al. 2019) analysis: the current food system contributes to approximately 11 million premature deaths per year from diet-related non-communicable diseases (cardiovascular disease type 2 diabetes cancer) while simultaneously causing environmental unsustainability. The planetary health diet proposes: approximately 2500 kcal/day with approximately 300g vegetables approximately 200g fruit approximately 230g whole grains approximately 50g legumes approximately 28g nuts approximately 32g red meat approximately 78g poultry approximately 28g fish approximately 196g dairy. Evidence for health benefits: large meta-analyses (PREDIMED etc.) confirm Mediterranean-style diets (emphasising plant foods olive oil fish modest poultry and dairy) reduce cardiovascular disease and cancer mortality by approximately 20-30%. Environmental evidence: adopting the planetary health diet universally would reduce food system greenhouse gas emissions by approximately 49%; land use by approximately 51%; freshwater use by approximately 15%. Barriers: cost accessibility (healthy diets cost approximately 5x more than calorie-sufficient minimum diets globally); cultural preferences; agricultural subsidy structures; and food environment (availability of healthy foods)$t$
WHERE id = 2156
  AND option_d = $t$The EAT-Lancet planetary health diet (Willett et al. 2019) analysis: the current food system contributes to approximately 11 million premature deaths per year from diet-related non-communicable diseases (cardiovascular disease type 2 diabetes cancer) while simultaneously causing environmental unsustainability. The planetary health diet proposes: approximately 2500 kcal/day with approximately \(300g\) vegetables approximately \(200g\) fruit approximately \(230g\) whole grains approximately \(50g\) legumes approximately \(28g\) nuts approximately \(32g\) red meat approximately \(78g\) poultry approximately \(28g\) fish approximately \(196g\) dairy. Evidence for health benefits: large meta-analyses (PREDIMED etc.) confirm Mediterranean-style diets (emphasising plant foods olive oil fish modest poultry and dairy) reduce cardiovascular disease and cancer mortality by approximately 20–30%. Environmental evidence: adopting the planetary health diet universally would reduce food system greenhouse gas emissions by approximately 49%; land use by approximately 51%; freshwater use by approximately 15%. Barriers: cost accessibility (healthy diets cost approximately 5× more than calorie-sufficient minimum diets globally); cultural preferences; agricultural subsidy structures; and food environment (availability of healthy foods)$t$;

UPDATE questions SET
  option_c = $t$Regenerative agriculture (RA) encompasses practices: no-till or minimal tillage; cover crops; crop rotation; composting and organic matter additions; integration of livestock; agroforestry; and reduced external inputs. Evidence for: long-term studies (Rodale Institute 30-year trial) show comparable yields in mature RA systems with lower inputs; soil carbon sequestration by RA could theoretically sequester approximately 1-2 GtC/year globally; improved soil water retention benefits in drought years; biodiversity improvements; and long-term soil health maintenance. Evidence against: yield transition period (5-10 year yield decline during transition from conventional to RA); high knowledge requirements; geographic limitations (RA may be less effective in highly degraded soils or certain climates); the carbon sequestration potential is disputed (realistic estimates are lower than advocates claim and saturation occurs); and formal peer-reviewed trials show more modest benefits than practitioner testimonials. Overall assessment: RA practices have demonstrable benefits for soil health biodiversity and resilience but the evidence for matching conventional yields at scale with lower inputs is mixed and context-dependent$t$
WHERE id = 2159
  AND option_c = $t$Regenerative agriculture (RA) encompasses practices: no-till or minimal tillage; cover crops; crop rotation; composting and organic matter additions; integration of livestock; agroforestry; and reduced external inputs. Evidence for: long-term studies (Rodale Institute 30-year trial) show comparable yields in mature RA systems with lower inputs; soil carbon sequestration by RA could theoretically sequester approximately 1–2 GtC/year globally; improved soil water retention benefits in drought years; biodiversity improvements; and long-term soil health maintenance. Evidence against: yield transition period (5–10 year yield decline during transition from conventional to RA); high knowledge requirements; geographic limitations (RA may be less effective in highly degraded soils or certain climates); the carbon sequestration potential is disputed (realistic estimates are lower than advocates claim and saturation occurs); and formal peer-reviewed trials show more modest benefits than practitioner testimonials. Overall assessment: RA practices have demonstrable benefits for soil health biodiversity and resilience but the evidence for matching conventional yields at scale with lower inputs is mixed and context-dependent$t$;

UPDATE questions SET
  explanation = $t$This synthesis question requires integration of multiple strands of evidence. The Potsdam Institute analysis (Rockstrom et al. 2020 Nature Food) found that a combination of sustainable intensification dietary change and food waste reduction could feed 10 billion people within planetary boundaries by 2050 — but that all three levers are simultaneously required (no single intervention is sufficient alone). The key policy insight is that technological solutions (sustainable intensification biotechnology) cannot substitute for dietary change at the scale required — current projections show dietary change must contribute approximately 50-70% of the required sustainability improvement.$t$
WHERE id = 2162
  AND explanation = $t$This synthesis question requires integration of multiple strands of evidence. The Potsdam Institute analysis (Rockstrom et al. 2020 Nature Food) found that a combination of sustainable intensification dietary change and food waste reduction could feed 10 billion people within planetary boundaries by 2050 — but that all three levers are simultaneously required (no single intervention is sufficient alone). The key policy insight is that technological solutions (sustainable intensification biotechnology) cannot substitute for dietary change at the scale required — current projections show dietary change must contribute approximately 50–70% of the required sustainability improvement.$t$;

UPDATE questions SET
  explanation = $t$Prokaryotes: no nucleus no membrane-bound organelles smaller (1-10 micrometres) circular DNA. Eukaryotes: true nucleus linear DNA membrane-bound organelles larger (10-100 micrometres).$t$
WHERE id = 2625
  AND explanation = $t$Prokaryotes: no nucleus no membrane-bound organelles smaller (1–10 micrometres) circular DNA. Eukaryotes: true nucleus linear DNA membrane-bound organelles larger (10–100 micrometres).$t$;

UPDATE questions SET
  explanation = $t$Total magnification = eyepiece x objective = 10 x 40 = 400.$t$
WHERE id = 2627
  AND explanation = $t$Total magnification = eyepiece × objective \(= 10 \times 40 = 400\).$t$;

UPDATE questions SET
  explanation = $t$Fick's law: rate proportional to (surface area x concentration difference) / diffusion distance. This underpins gas exchange adaptations in lungs gills and leaves.$t$
WHERE id = 2630
  AND explanation = $t$Fick's law: rate proportional to (surface area × concentration difference) / diffusion distance. This underpins gas exchange adaptations in lungs gills and leaves.$t$;

UPDATE questions SET
  explanation = $t$Actual size = image size / magnification = 15 mm / 750 = 0.02 mm = 20 micrometres.$t$
WHERE id = 2638
  AND explanation = $t$Actual size = image size / magnification \(= 15 \frac{\,\text{mm}}{750} = 0.02\,\text{mm} = 20\) micrometres.$t$;

UPDATE questions SET
  explanation = $t$SA:V decreases as size increases. Implications: bacteria (tiny high SA:V) rely entirely on diffusion. Humans: need lungs (SA approximately 70 m2) intestinal villi and circulatory system.$t$
WHERE id = 2642
  AND explanation = $t$SA:V decreases as size increases. Implications: bacteria (tiny high SA:V) rely entirely on diffusion. Humans: need lungs (SA approximately \(70 m^{2}\)) intestinal villi and circulatory system.$t$;

UPDATE questions SET
  option_b = $t$Only temperature needs controlling because CO2 is always in excess in water$t$,
  option_d = $t$Temperature must be controlled because it affects enzyme activity in photosynthesis. CO2 concentration must also be controlled because CO2 is a raw material — if CO2 runs low it becomes a limiting factor regardless of light intensity.$t$,
  explanation = $t$Controlled variables keep everything constant except the independent variable (light intensity). Temperature affects enzyme reactions. CO2 is a substrate for photosynthesis.$t$
WHERE id = 2643
  AND option_b = $t$Only temperature needs controlling because CO₂ is always in excess in water$t$
  AND option_d = $t$Temperature must be controlled because it affects enzyme activity in photosynthesis. CO₂ concentration must also be controlled because CO₂ is a raw material — if CO₂ runs low it becomes a limiting factor regardless of light intensity.$t$
  AND explanation = $t$Controlled variables keep everything constant except the independent variable (light intensity). Temperature affects enzyme reactions. CO₂ is a substrate for photosynthesis.$t$;

UPDATE questions SET
  option_b = $t$A partially permeable membrane allows certain molecules to pass through while preventing others. Small molecules (water oxygen CO2) pass through freely; larger molecules (glucose proteins) cannot. Example: the cell surface membrane of any living cell.$t$
WHERE id = 2644
  AND option_b = $t$A partially permeable membrane allows certain molecules to pass through while preventing others. Small molecules (water oxygen CO₂) pass through freely; larger molecules (glucose proteins) cannot. Example: the cell surface membrane of any living cell.$t$;

UPDATE questions SET
  explanation = $t$x-intercept of percentage mass change vs sucrose concentration graph: zero mass change means isotonic — external water potential equals cell water potential.$t$
WHERE id = 2649
  AND explanation = $t$\(x\)-intercept of percentage mass change vs sucrose concentration graph: zero mass change means isotonic — external water potential equals cell water potential.$t$;

UPDATE questions SET
  explanation = $t$Plant only vs animal: cellulose cell wall large central vacuole chloroplasts (in photosynthetic cells). Both: nucleus mitochondria ribosomes cell membrane. Bacteria: no nucleus circular DNA 70S ribosomes pili.$t$
WHERE id = 2651
  AND explanation = $t$Plant only vs animal: cellulose cell wall large central vacuole chloroplasts (in photosynthetic cells). Both: nucleus mitochondria ribosomes cell membrane. Bacteria: no nucleus circular \(DNA 70S\) ribosomes pili.$t$;

UPDATE questions SET
  explanation = $t$Bacteria (tiny high SA:V) rely entirely on diffusion. Humans: need lungs (SA approximately 70 m2) intestinal villi (SA approximately 200 m2) and circulatory system to move substances to all cells.$t$
WHERE id = 2653
  AND explanation = $t$Bacteria (tiny high SA:V) rely entirely on diffusion. Humans: need lungs (SA approximately \(70 m^{2}\)) intestinal villi (SA approximately \(200 m^{2}\)) and circulatory system to move substances to all cells.$t$;

UPDATE questions SET
  explanation = $t$DNA replication before division ensures identical chromatids. Mitosis separates chromatids one to each cell. Result: 2n daughter cells genetically identical to parent. Importance: growth maintaining genome integrity tissue repair.$t$
WHERE id = 2663
  AND explanation = $t$DNA replication before division ensures identical chromatids. Mitosis separates chromatids one to each cell. Result: \(2n\) daughter cells genetically identical to parent. Importance: growth maintaining genome integrity tissue repair.$t$;

UPDATE questions SET
  explanation = $t$iPSCs (Yamanaka 2006 Nobel Prize 2012): adult cells reprogrammed using Oct4 Sox2 Klf4 c-Myc. Current uses: disease modelling drug testing. Challenges: reprogramming efficiency genomic instability tumour risk from c-Myc.$t$
WHERE id = 2669
  AND explanation = $t$iPSCs (Yamanaka 2006 Nobel Prize 2012): adult cells reprogrammed using Oct4 Sox2 Klf4 \(c\)-Myc. Current uses: disease modelling drug testing. Challenges: reprogramming efficiency genomic instability tumour risk from \(c\)-Myc.$t$;

UPDATE questions SET
  explanation = $t$Semi-conservative: confirmed by Meselson and Stahl (1958) using 14N/15N density labelling. After one generation: all hybrid double helices. After two: equal amounts of hybrid and light. Helicase unwinds primase adds primer DNA polymerase III extends ligase seals gaps.$t$
WHERE id = 2675
  AND explanation = $t$Semi-conservative: confirmed by Meselson and Stahl (1958) using \(\frac{14N}{15}N\) density labelling. After one generation: all hybrid double helices. After two: equal amounts of hybrid and light. Helicase unwinds primase adds primer DNA polymerase III extends ligase seals gaps.$t$;

UPDATE questions SET
  explanation = $t$SAC proteins Mad1 Mad2 BubR1 form the mitotic checkpoint complex. MCC inhibits APC/C preventing securin degradation. One unattached kinetochore halts all progression. Failure: aneuploidy found in approximately 90% of solid tumours.$t$
WHERE id = 2676
  AND explanation = $t$SAC proteins Mad1 Mad2 BubR1 form the mitotic checkpoint complex. MCC inhibits \(\frac{APC}{C}\) preventing securin degradation. One unattached kinetochore halts all progression. Failure: aneuploidy found in approximately 90% of solid tumours.$t$;

UPDATE questions SET
  option_b = $t$ESCs: advantages — truly pluripotent established differentiation protocols. Limitations — ethical controversy immune rejection limited supply. iPSCs: advantages — patient-specific no immune rejection no embryo destruction can model any patient's disease. Limitations — reprogramming inefficiency genomic instability oncogene risk (c-Myc) epigenetic memory of donor cell type. Current view: iPSCs preferred for personalised treatment ESCs remain important for developmental biology research.$t$
WHERE id = 2677
  AND option_b = $t$ESCs: advantages — truly pluripotent established differentiation protocols. Limitations — ethical controversy immune rejection limited supply. iPSCs: advantages — patient-specific no immune rejection no embryo destruction can model any patient's disease. Limitations — reprogramming inefficiency genomic instability oncogene risk (\(c\)-Myc) epigenetic memory of donor cell type. Current view: iPSCs preferred for personalised treatment ESCs remain important for developmental biology research.$t$;

UPDATE questions SET
  option_c = $t$Cancer cells reactivate telomerase to maintain telomere length enabling unlimited division. If telomerase is inhibited telomeres will shorten with each division. After approximately 50-100 divisions telomeres become critically short triggering apoptosis or senescence — limiting tumour growth. Normal adult somatic cells do not express significant telomerase — their telomeres are already shortening and they divide infrequently so further inhibition should have minimal additional effect.$t$,
  explanation = $t$Telomere length: normal somatic cells approximately 5-15 kb. After approximately 50 divisions: Hayflick limit. Telomerase inhibitors in trials: imetelstat. Limitation: cancer cells already have long telomeres so many divisions occur before the effect is seen.$t$
WHERE id = 2678
  AND option_c = $t$Cancer cells reactivate telomerase to maintain telomere length enabling unlimited division. If telomerase is inhibited telomeres will shorten with each division. After approximately 50–100 divisions telomeres become critically short triggering apoptosis or senescence — limiting tumour growth. Normal adult somatic cells do not express significant telomerase — their telomeres are already shortening and they divide infrequently so further inhibition should have minimal additional effect.$t$
  AND explanation = $t$Telomere length: normal somatic cells approximately 5–15 kb. After approximately 50 divisions: Hayflick limit. Telomerase inhibitors in trials: imetelstat. Limitation: cancer cells already have long telomeres so many divisions occur before the effect is seen.$t$;

UPDATE questions SET
  option_c = $t$Hayflick (1961): normal human fibroblasts divide approximately 50-70 times then permanently arrest (replicative senescence). Cells from older donors had fewer remaining divisions. Implication for ageing: accumulated senescent cells may contribute to age-related decline by secreting pro-inflammatory factors (SASP). Implication for cancer: cancer cells bypass senescence by reactivating telomerase becoming effectively immortal.$t$
WHERE id = 2680
  AND option_c = $t$Hayflick (1961): normal human fibroblasts divide approximately 50–70 times then permanently arrest (replicative senescence). Cells from older donors had fewer remaining divisions. Implication for ageing: accumulated senescent cells may contribute to age-related decline by secreting pro-inflammatory factors (SASP). Implication for cancer: cancer cells bypass senescence by reactivating telomerase becoming effectively immortal.$t$;

UPDATE questions SET
  explanation = $t$Rapidly renewing: gut epithelium (4-5 days) skin (2-4 weeks) red blood cells (approximately 120 days). Non-renewing (post-mitotic): neurons cardiac muscle cells. Lack of neuronal renewal explains permanent brain injury.$t$
WHERE id = 2681
  AND explanation = $t$Rapidly renewing: gut epithelium (4–5 days) skin (2–4 weeks) red blood cells (approximately 120 days). Non-renewing (post-mitotic): neurons cardiac muscle cells. Lack of neuronal renewal explains permanent brain injury.$t$;

UPDATE questions SET
  option_a = $t$The claim is oversimplified. Cancer requires multiple mutations (typically 5-10 driver mutations) accumulating over years. Targeting one oncogene may slow growth but other mutations drive alternative pathways. Tumour heterogeneity means different cancer cells within a tumour have different mutation profiles — drugs targeting one mutation leave other cells to proliferate. Acquired resistance via secondary mutations is common. However targeted single-oncogene therapies have been remarkably effective in some cancers (e.g. imatinib for CML).$t$
WHERE id = 2682
  AND option_a = $t$The claim is oversimplified. Cancer requires multiple mutations (typically 5–10 driver mutations) accumulating over years. Targeting one oncogene may slow growth but other mutations drive alternative pathways. Tumour heterogeneity means different cancer cells within a tumour have different mutation profiles — drugs targeting one mutation leave other cells to proliferate. Acquired resistance via secondary mutations is common. However targeted single-oncogene therapies have been remarkably effective in some cancers (e.g. imatinib for CML).$t$;

UPDATE questions SET
  option_a = $t$Organoids are 3D structures grown from stem cells resembling the organ of origin. Value: more physiologically relevant than 2D culture; patient-specific (grown from patient cells to test personalised treatments); reduce animal use; model rare conditions; produced faster and in larger numbers than animal studies. Limitations: lack vascularisation limiting size and nutrient delivery; no immune system interaction; no systemic drug effects; cannot fully model whole-organ physiology.$t$,
  option_b = $t$Organoids are less useful than traditional 2D cell culture because they are three-dimensional$t$
WHERE id = 2684
  AND option_a = $t$Organoids are \(3D\) structures grown from stem cells resembling the organ of origin. Value: more physiologically relevant than \(2D\) culture; patient-specific (grown from patient cells to test personalised treatments); reduce animal use; model rare conditions; produced faster and in larger numbers than animal studies. Limitations: lack vascularisation limiting size and nutrient delivery; no immune system interaction; no systemic drug effects; cannot fully model whole-organ physiology.$t$
  AND option_b = $t$Organoids are less useful than traditional \(2D\) cell culture because they are three-dimensional$t$;

UPDATE questions SET
  explanation = $t$Gene: a sequence of DNA bases that codes for a protein (or functional RNA). Located at a specific locus on a chromosome. Humans have approximately 20,000-25,000 protein-coding genes.$t$
WHERE id = 2685
  AND explanation = $t$Gene: a sequence of DNA bases that codes for a protein (or functional RNA). Located at a specific locus on a chromosome. Humans have approximately \(20\,000 - 25\,000\) protein-coding genes.$t$;

UPDATE questions SET
  explanation = $t$Dominant (A): expressed in AA and Aa. Recessive (a): only expressed in aa. Carrier: heterozygous (Aa) does not show phenotype but can pass the recessive allele to offspring.$t$
WHERE id = 2687
  AND explanation = $t$Dominant (A): expressed in AA and Aa. Recessive (\(a\)): only expressed in aa. Carrier: heterozygous (Aa) does not show phenotype but can pass the recessive allele to offspring.$t$;

UPDATE questions SET
  question_text = $t$Both parents are carriers for cystic fibrosis (Cc x Cc). What is the probability their child will have cystic fibrosis?$t$,
  explanation = $t$Punnett square Cc x Cc: gametes C and c from each parent. Offspring CC (1/4) Cc (2/4) cc (1/4). Phenotype ratio 3 unaffected : 1 affected.$t$
WHERE id = 2688
  AND question_text = $t$Both parents are carriers for cystic fibrosis (Cc × Cc). What is the probability their child will have cystic fibrosis?$t$
  AND explanation = $t$Punnett square Cc \(x\) Cc: gametes C and \(c\) from each parent. Offspring \(CC (\frac{1}{4})\) Cc \((\frac{2}{4})\) cc \((\frac{1}{4})\). Phenotype ratio 3 unaffected : 1 affected.$t$;

UPDATE questions SET
  option_c = $t$Diploid cells (2n) contain two complete sets of chromosomes. Haploid cells (n) contain only one set. Gametes are haploid. When two haploid gametes fuse at fertilisation the diploid number is restored.$t$,
  explanation = $t$Human diploid: 2n = 46. Human haploid: n = 23. Meiosis halves chromosome number (diploid to haploid). Fertilisation doubles it (two haploid gametes produce diploid zygote).$t$
WHERE id = 2690
  AND option_c = $t$Diploid cells \((2n)\) contain two complete sets of chromosomes. Haploid cells (\(n\)) contain only one set. Gametes are haploid. When two haploid gametes fuse at fertilisation the diploid number is restored.$t$
  AND explanation = $t$Human diploid: \(2n = 46\). Human haploid: \(n = 23\). Meiosis halves chromosome number (diploid to haploid). Fertilisation doubles it (two haploid gametes produce diploid zygote).$t$;

UPDATE questions SET
  question_text = $t$A woman is a carrier for haemophilia (X^H X^h). Her husband does not have haemophilia (X^H Y). What is the probability their son will have haemophilia?$t$,
  option_a = $t$50% — the carrier mother produces X^H and X^h eggs. Sons inherit their X from their mother. Punnett square gives X^H Y (unaffected son 50%) and X^h Y (affected son 50%).$t$
WHERE id = 2692
  AND question_text = $t$A woman is a carrier for haemophilia \((X^{H} X^{h})\). Her husband does not have haemophilia \((X^{H} Y)\). What is the probability their son will have haemophilia?$t$
  AND option_a = $t$50% — the carrier mother produces \(X^{H}\) and \(X^{h}\) eggs. Sons inherit their X from their mother. Punnett square gives \(X^{H} Y\) (unaffected son 50%) and \(X^{h} Y\) (affected son 50%).$t$;

UPDATE questions SET
  option_c = $t$Codominance is when both alleles in a heterozygote are expressed simultaneously — neither is dominant over the other. Example: ABO blood groups — I^A and I^B alleles are codominant. A person with genotype I^A I^B has blood group AB because both A and B antigens are expressed on their red blood cells.$t$,
  explanation = $t$Codominance: both alleles expressed in heterozygote. ABO blood groups: I^A I^A or I^A i = group A; I^B I^B or I^B i = group B; I^A I^B = group AB (codominant); ii = group O.$t$
WHERE id = 2693
  AND option_c = $t$Codominance is when both alleles in a heterozygote are expressed simultaneously — neither is dominant over the other. Example: ABO blood groups — \(I^{A}\) and \(I^{B}\) alleles are codominant. A person with genotype \(I^{A}I^{B}\) has blood group AB because both A and B antigens are expressed on their red blood cells.$t$
  AND explanation = $t$Codominance: both alleles expressed in heterozygote. ABO blood groups: \(I^{A}I^{A}\) or \(I^{A}i\) = group A; \(I^{B}I^{B}\) or \(I^{B}i\) = group B; \(I^{A}I^{B}\) = group AB (codominant); ii = group O.$t$;

UPDATE questions SET
  option_c = $t$The 3:1 ratio shows tall (T) is dominant. F1 plants are all Tt. The breeder must identify TT plants from the F2 generation using a test cross — cross each tall F2 plant with a short plant (tt). Plants producing all tall offspring are TT (true-breeding). Plants producing 50% tall and 50% short offspring are Tt.$t$
WHERE id = 2694
  AND option_c = $t$The \(3 : 1\) ratio shows tall (T) is dominant. F1 plants are all Tt. The breeder must identify TT plants from the F2 generation using a test cross — cross each tall F2 plant with a short plant (tt). Plants producing all tall offspring are TT (true-breeding). Plants producing 50% tall and 50% short offspring are Tt.$t$;

UPDATE questions SET
  option_c = $t$Incomplete dominance is when neither allele is completely dominant — heterozygotes show an intermediate phenotype between the two homozygous phenotypes. Example: snapdragon flower colour — red (R^R R^R) crossed with white (R^W R^W) produces pink heterozygotes (R^R R^W). When pink plants are crossed together the ratio is 1 red : 2 pink : 1 white.$t$,
  explanation = $t$Incomplete dominance: heterozygote intermediate phenotype. F2 ratio 1:2:1 (phenotype = genotype ratio). Contrasts with complete dominance (3:1) and codominance (both alleles fully expressed not blended).$t$
WHERE id = 2695
  AND option_c = $t$Incomplete dominance is when neither allele is completely dominant — heterozygotes show an intermediate phenotype between the two homozygous phenotypes. Example: snapdragon flower colour — red \((R^{R} R^{R})\) crossed with white \((R^{W} R^{W})\) produces pink heterozygotes \((R^{R} R^{W})\). When pink plants are crossed together the ratio is 1 red : 2 pink : 1 white.$t$
  AND explanation = $t$Incomplete dominance: heterozygote intermediate phenotype. F2 ratio \(1 : 2 : 1\) (phenotype = genotype ratio). Contrasts with complete dominance (\(3 : 1\)) and codominance (both alleles fully expressed not blended).$t$;

UPDATE questions SET
  question_text = $t$A man with blood group A (I^A i) and a woman with blood group B (I^B i) have children. What blood groups are possible in their children?$t$,
  option_a = $t$All four blood groups are possible — Punnett square (I^A i x I^B i) gives: I^A I^B (AB 25%) I^A i (A 25%) I^B i (B 25%) ii (O 25%).$t$,
  explanation = $t$ABO genetics: I^A and I^B are codominant i is recessive. Cross I^A i x I^B i produces all four blood groups at equal frequency.$t$
WHERE id = 2696
  AND question_text = $t$A man with blood group A (\(I^{A}i\)) and a woman with blood group B (\(I^{B}i\)) have children. What blood groups are possible in their children?$t$
  AND option_a = $t$All four blood groups are possible — Punnett square (\(I^{A}i\) × \(I^{B}i\)) gives: \(I^{A}I^{B}\) (AB 25%) \(I^{A}i\) (A 25%) \(I^{B}i\) (B 25%) ii (O 25%).$t$
  AND explanation = $t$ABO genetics: \(I^{A}\) and \(I^{B}\) are codominant i is recessive. Cross \(I^{A}i\) × \(I^{B}i\) produces all four blood groups at equal frequency.$t$;

UPDATE questions SET
  option_c = $t$50% — the affected parent (Hh) produces H and h gametes. If the other parent is hh: Punnett square gives Hh (50% affected) and hh (50% unaffected).$t$,
  explanation = $t$Dominant condition inheritance (Hh x hh): 50% Hh (affected) 50% hh (unaffected). Huntingtons: autosomal dominant late onset progressive neurological deterioration caused by CAG repeat expansion in the HTT gene.$t$
WHERE id = 2699
  AND option_c = $t$50% — the affected parent (Hh) produces H and \(h\) gametes. If the other parent is hh: Punnett square gives Hh (50% affected) and hh (50% unaffected).$t$
  AND explanation = $t$Dominant condition inheritance (Hh × hh): 50% Hh (affected) 50% hh (unaffected). Huntingtons: autosomal dominant late onset progressive neurological deterioration caused by CAG repeat expansion in the HTT gene.$t$;

UPDATE questions SET
  question_text = $t$A chi-squared test on genetics data gives a value below the critical value at p=0.05. What does this mean?$t$,
  option_b = $t$If the calculated chi-squared value is below the critical value at p=0.05 we accept the null hypothesis — the difference between observed and expected results is not statistically significant and is likely due to chance.$t$,
  explanation = $t$Chi-squared: sum of (O-E)^2/E. Degrees of freedom = number of classes - 1. P = 0.05: if chi-squared less than critical value accept null hypothesis (differences due to chance). If greater than critical value reject null hypothesis.$t$
WHERE id = 2704
  AND question_text = $t$A chi-squared test on genetics data gives a value below the critical value at \(p = 0.05\). What does this mean?$t$
  AND option_b = $t$If the calculated chi-squared value is below the critical value at \(p = 0.05\) we accept the null hypothesis — the difference between observed and expected results is not statistically significant and is likely due to chance.$t$
  AND explanation = $t$Chi-squared: sum of \(\frac{(O - E)^{2}}{E}\). Degrees of freedom = number of classes \(- 1\). \(P = 0.05\): if chi-squared less than critical value accept null hypothesis (differences due to chance). If greater than critical value reject null hypothesis.$t$;

UPDATE questions SET
  explanation = $t$Balanced polymorphism (heterozygote advantage): HbA HbS maintained at approximately 10-40% HbS allele frequency in the malaria belt. Without malaria selection HbS frequency declines as HbS HbS individuals have lower fitness.$t$
WHERE id = 2706
  AND explanation = $t$Balanced polymorphism (heterozygote advantage): HbA HbS maintained at approximately 10–40% HbS allele frequency in the malaria belt. Without malaria selection HbS frequency declines as HbS HbS individuals have lower fitness.$t$;

UPDATE questions SET
  question_text = $t$In a dihybrid cross LlBb x LlBb 160 flies are produced. How many are expected to have long wings (L_) and grey body (B_)?$t$,
  explanation = $t$Probability of long wings (L_) = 3/4. Probability of grey body (B_) = 3/4. Probability of both = 9/16. Expected number = 9/16 x 160 = 90.$t$
WHERE id = 2707
  AND question_text = $t$In a dihybrid cross LlBb \(x\) LlBb 160 flies are produced. How many are expected to have long wings (L_) and grey body (B_)?$t$
  AND explanation = $t$Probability of long wings (L_) \(= \frac{3}{4}\). Probability of grey body (B_) \(= \frac{3}{4}\). Probability of both \(= \frac{9}{16}\). Expected number \(= \frac{9}{16} \times 160 = 90\).$t$;

UPDATE questions SET
  explanation = $t$Gene linkage: genes on same chromosome violate Mendels law of independent assortment. Recombination frequency = recombinant offspring/total offspring x 100% = map distance in cM. 1 cM = 1% recombination.$t$
WHERE id = 2708
  AND explanation = $t$Gene linkage: genes on same chromosome violate Mendels law of independent assortment. Recombination frequency = recombinant offspring/total offspring \(x 100\% = map\) distance in cM. 1 cM \(= 1\%\) recombination.$t$;

UPDATE questions SET
  question_text = $t$A recessive lethal allele causes yellow coat in heterozygous mice but death in utero when homozygous. Explain why a cross between two yellow mice gives a 1:2 ratio of agouti to yellow offspring instead of 3:1.$t$,
  option_a = $t$The 3:1 ratio is maintained because the lethal allele behaves like any other recessive allele$t$,
  option_b = $t$The cross between yellow heterozygotes (A^y A x A^y A) would normally give 1:2:1. However the A^y A^y homozygous genotype is lethal — these embryos die in utero. Of surviving offspring: 1 AA (agouti) : 2 A^y A (yellow) — a 1:2 ratio. The expected 3:1 is modified because one phenotype class is lethal.$t$,
  option_c = $t$The ratio becomes 1:3 because the lethal allele affects the other classes disproportionately$t$,
  explanation = $t$Agouti mouse: A^y allele dominant for yellow coat but lethal when homozygous. Surviving ratio = 1 agouti : 2 yellow instead of 1:2:1 because the A^y A^y class is absent.$t$
WHERE id = 2710
  AND question_text = $t$A recessive lethal allele causes yellow coat in heterozygous mice but death in utero when homozygous. Explain why a cross between two yellow mice gives \(a\) \(1 : 2\) ratio of agouti to yellow offspring instead of \(3 : 1\).$t$
  AND option_a = $t$The \(3 : 1\) ratio is maintained because the lethal allele behaves like any other recessive allele$t$
  AND option_b = $t$The cross between yellow heterozygotes \((A^{y} A \times A^{y} A)\) would normally give \(1 : 2 : 1\). However the \(A^{y} A^{y}\) homozygous genotype is lethal — these embryos die in utero. Of surviving offspring: 1 AA (agouti) : \(2 \text{A}^{y} A\) (yellow) — \(a\) \(1 : 2\) ratio. The expected \(3 : 1\) is modified because one phenotype class is lethal.$t$
  AND option_c = $t$The ratio becomes \(1 : 3\) because the lethal allele affects the other classes disproportionately$t$
  AND explanation = $t$Agouti mouse: \(A^{y}\) allele dominant for yellow coat but lethal when homozygous. Surviving ratio \(= 1\) agouti : 2 yellow instead of \(1 : 2 : 1\) because the \(A^{y} A^{y}\) class is absent.$t$;

UPDATE questions SET
  option_c = $t$The HGP showed there are approximately 100,000 genes$t$,
  explanation = $t$Key HGP findings: approximately 20,000-25,000 protein-coding genes only approximately 1.5% of genome codes for protein approximately 98% is non-coding (regulatory sequences transposons etc). Enabled whole-genome sequencing now used clinically.$t$
WHERE id = 2712
  AND option_c = $t$The HGP showed there are approximately 100 000 genes$t$
  AND explanation = $t$Key HGP findings: approximately \(20\,000 - 25\,000\) protein-coding genes only approximately 1.5% of genome codes for protein approximately 98% is non-coding (regulatory sequences transposons etc). Enabled whole-genome sequencing now used clinically.$t$;

UPDATE questions SET
  option_a = $t$A recombination frequency of 20% means that in 20% of meioses a crossover occurs between the two genes resulting in recombinant offspring. The map distance is 20 cM (centimorgans). 1 cM = 1% recombination. Genes more than 50 cM apart appear to assort independently even if on the same chromosome.$t$,
  explanation = $t$Map distance (cM) = recombination frequency (%). Maximum observable recombination = 50% (genes appear unlinked even if on same chromosome). Recombination frequency underestimates physical distance at large separations because double crossovers cancel out.$t$
WHERE id = 2713
  AND option_a = $t$A recombination frequency of 20% means that in 20% of meioses a crossover occurs between the two genes resulting in recombinant offspring. The map distance is 20 cM (centimorgans). 1 cM \(= 1\%\) recombination. Genes more than 50 cM apart appear to assort independently even if on the same chromosome.$t$
  AND explanation = $t$Map distance (cM) = recombination frequency (%). Maximum observable recombination \(= 50\%\) (genes appear unlinked even if on same chromosome). Recombination frequency underestimates physical distance at large separations because double crossovers cancel out.$t$;

UPDATE questions SET
  explanation = $t$Homeostasis: negative feedback systems maintain set points. Examples: body temperature (37 degrees C) blood glucose (approximately 5 mmol/L) blood pH (7.35-7.45). Negative feedback: deviation detected response opposes deviation restoring set point.$t$
WHERE id = 2717
  AND explanation = $t$Homeostasis: negative feedback systems maintain set points. Examples: body temperature (37 degrees C) blood glucose (approximately 5 mmol/L) blood pH \((7.35 - 7.45)\). Negative feedback: deviation detected response opposes deviation restoring set point.$t$;

UPDATE questions SET
  option_d = $t$Days 1-13: FSH stimulates follicle maturation and oestrogen production. Rising oestrogen thickens the uterine lining and triggers an LH surge. Day 14: LH surge causes ovulation. Days 15-28: LH stimulates corpus luteum to produce progesterone. Progesterone maintains the uterine lining and inhibits FSH and LH. If no fertilisation: corpus luteum degenerates progesterone falls and menstruation begins.$t$
WHERE id = 2730
  AND option_d = $t$Days \(1 - 13\): FSH stimulates follicle maturation and oestrogen production. Rising oestrogen thickens the uterine lining and triggers an LH surge. Day 14: LH surge causes ovulation. Days \(15 - 28\): LH stimulates corpus luteum to produce progesterone. Progesterone maintains the uterine lining and inhibits FSH and LH. If no fertilisation: corpus luteum degenerates progesterone falls and menstruation begins.$t$;

UPDATE questions SET
  explanation = $t$Insulin pharmacokinetics: rapid-acting analogues (aspart lispro) onset 15 min peak 1-2 h. Long-acting analogues (glargine detemir) provide basal insulin. Insulin pumps allow more precise matching of insulin to carbohydrate intake.$t$
WHERE id = 2732
  AND explanation = $t$Insulin pharmacokinetics: rapid-acting analogues (aspart lispro) onset 15 min peak 1–2 \(h\). Long-acting analogues (glargine detemir) provide basal insulin. Insulin pumps allow more precise matching of insulin to carbohydrate intake.$t$;

UPDATE questions SET
  explanation = $t$Closed-loop systems (artificial pancreas): CGM + pump algorithm automatically adjusts insulin delivery. Studies show lower HbA1c less hypoglycaemia and better quality of life vs multiple daily injections for many patients.$t$
WHERE id = 2734
  AND explanation = $t$Closed-loop systems (artificial pancreas): CGM + pump algorithm automatically adjusts insulin delivery. Studies show lower HbA\(1c\) less hypoglycaemia and better quality of life vs multiple daily injections for many patients.$t$;

UPDATE questions SET
  question_text = $t$A patient with type 2 diabetes has fasting blood glucose of 9.2 mmol/L and HbA1c of 9.5%. Explain what these measurements indicate and why HbA1c is used to monitor long-term control.$t$,
  option_a = $t$HbA1c only reflects glucose levels in the past 24 hours$t$,
  option_b = $t$HbA1c of 9.5% is within the normal range for a type 2 diabetic patient$t$,
  option_c = $t$Fasting blood glucose of 9.2 mmol/L (normal less than 5.6 mmol/L) confirms poorly controlled diabetes. HbA1c measures the percentage of haemoglobin that has glucose irreversibly bound to it (glycated haemoglobin). Because red blood cells survive approximately 120 days HbA1c reflects average blood glucose over the past 2-3 months — not just at the time of the test. An HbA1c of 9.5% indicates sustained poor glucose control (target for most type 2 diabetics is below 7%). This provides a reliable long-term measure that cannot be manipulated by short-term dietary changes before a test.$t$,
  explanation = $t$HbA1c: glycated haemoglobin percentage. Normal: below 5.7%. Pre-diabetes: 5.7-6.4%. Diabetes diagnosis: 6.5% or above. Each 1% increase in HbA1c increases risk of microvascular complications. Target for most type 2 diabetics: below 7% (53 mmol/mol in IFCC units).$t$
WHERE id = 2737
  AND question_text = $t$A patient with type 2 diabetes has fasting blood glucose of 9.2 mmol/L and HbA\(1c\) of 9.5%. Explain what these measurements indicate and why HbA\(1c\) is used to monitor long-term control.$t$
  AND option_a = $t$HbA\(1c\) only reflects glucose levels in the past 24 hours$t$
  AND option_b = $t$HbA\(1c\) of 9.5% is within the normal range for a type 2 diabetic patient$t$
  AND option_c = $t$Fasting blood glucose of 9.2 mmol/L (normal less than 5.6 mmol/L) confirms poorly controlled diabetes. HbA\(1c\) measures the percentage of haemoglobin that has glucose irreversibly bound to it (glycated haemoglobin). Because red blood cells survive approximately 120 days HbA\(1c\) reflects average blood glucose over the past 2–3 months — not just at the time of the test. An HbA\(1c\) of 9.5% indicates sustained poor glucose control (target for most type 2 diabetics is below 7%). This provides a reliable long-term measure that cannot be manipulated by short-term dietary changes before a test.$t$
  AND explanation = $t$HbA\(1c\): glycated haemoglobin percentage. Normal: below 5.7%. Pre-diabetes: 5.7–6.4%. Diabetes diagnosis: 6.5% or above. Each 1% increase in HbA\(1c\) increases risk of microvascular complications. Target for most type 2 diabetics: below 7% (53 mmol/mol in IFCC units).$t$;

UPDATE questions SET
  option_c = $t$The blood-brain barrier (BBB) is formed by tight junctions between endothelial cells of brain capillaries supplemented by astrocyte foot processes. It allows selective passage: small lipophilic molecules (oxygen CO2 alcohol anaesthetics) cross freely; glucose and amino acids cross via specific transporters; most large molecules proteins and hydrophilic drugs cannot cross. This protects the brain from pathogens toxins and fluctuating blood composition. Implication for treatment: most drugs cannot enter the brain — designing neurological drugs requires them to be small lipophilic or using drug delivery strategies (nanoparticles liposomes receptor-mediated transcytosis).$t$
WHERE id = 2738
  AND option_c = $t$The blood-brain barrier (BBB) is formed by tight junctions between endothelial cells of brain capillaries supplemented by astrocyte foot processes. It allows selective passage: small lipophilic molecules (oxygen CO₂ alcohol anaesthetics) cross freely; glucose and amino acids cross via specific transporters; most large molecules proteins and hydrophilic drugs cannot cross. This protects the brain from pathogens toxins and fluctuating blood composition. Implication for treatment: most drugs cannot enter the brain — designing neurological drugs requires them to be small lipophilic or using drug delivery strategies (nanoparticles liposomes receptor-mediated transcytosis).$t$;

UPDATE questions SET
  option_b = $t$Hormonal methods: combined pill (prevents ovulation thickens cervical mucus very high efficacy approximately 99% with perfect use) progesterone-only pill (mainly thickens cervical mucus) hormonal IUS (progesterone locally thins endometrium thickens mucus) implant (progesterone suppresses ovulation highly effective approximately 99.9%). Non-hormonal methods: copper IUD (copper ions toxic to sperm prevents implantation approximately 99% effective) condom (barrier method prevents STI transmission approximately 98% perfect use) natural family planning (low efficacy approximately 76-88%). Hormonal methods are generally more reliable but have side effects (nausea mood changes cardiovascular risks in smokers) and do not protect against STIs.$t$
WHERE id = 2741
  AND option_b = $t$Hormonal methods: combined pill (prevents ovulation thickens cervical mucus very high efficacy approximately 99% with perfect use) progesterone-only pill (mainly thickens cervical mucus) hormonal IUS (progesterone locally thins endometrium thickens mucus) implant (progesterone suppresses ovulation highly effective approximately 99.9%). Non-hormonal methods: copper IUD (copper ions toxic to sperm prevents implantation approximately 99% effective) condom (barrier method prevents STI transmission approximately 98% perfect use) natural family planning (low efficacy approximately 76–88%). Hormonal methods are generally more reliable but have side effects (nausea mood changes cardiovascular risks in smokers) and do not protect against STIs.$t$;

UPDATE questions SET
  explanation = $t$Negative feedback: T4/T3 high TSH falls (pituitary suppressed) T4/T3 low TSH rises (pituitary stimulated). Hypothyroidism: low thyroid hormones high TSH fatigue weight gain cold intolerance. Treatment: levothyroxine. Hyperthyroidism treatment: antithyroid drugs radioiodine thyroidectomy.$t$
WHERE id = 2742
  AND explanation = $t$Negative feedback: \(\frac{T4}{T3}\) high TSH falls (pituitary suppressed) T\(\frac{4}{T3}\) low TSH rises (pituitary stimulated). Hypothyroidism: low thyroid hormones high TSH fatigue weight gain cold intolerance. Treatment: levothyroxine. Hyperthyroidism treatment: antithyroid drugs radioiodine thyroidectomy.$t$;

UPDATE questions SET
  option_a = $t$The alveoli are adapted for efficient gas exchange by: very large total surface area (approximately 70 m2) thin walls (single cell layer — just one cell thick) moist lining (gases dissolve before crossing) rich capillary network (maintaining steep concentration gradients) and the short diffusion distance between air and blood.$t$
WHERE id = 2746
  AND option_a = $t$The alveoli are adapted for efficient gas exchange by: very large total surface area (approximately \(70 m^{2}\)) thin walls (single cell layer — just one cell thick) moist lining (gases dissolve before crossing) rich capillary network (maintaining steep concentration gradients) and the short diffusion distance between air and blood.$t$;

UPDATE questions SET
  explanation = $t$Haemoglobin: 4 subunits each containing a haem group with Fe2+ that binds one O2. Oxyhaemoglobin formation: Hb + 4O2 giving HbO8. Dissociation curve: sigmoid shape due to cooperative binding (loading of first O2 makes subsequent loading easier).$t$
WHERE id = 2749
  AND explanation = $t$Haemoglobin: 4 subunits each containing a haem group with Fe²⁺ that binds one O₂. Oxyhaemoglobin formation: Hb + 4O₂ giving HbO8. Dissociation curve: sigmoid shape due to cooperative binding (loading of first O₂ makes subsequent loading easier).$t$;

UPDATE questions SET
  option_b = $t$Carbon dioxide is transported in three ways: (1) Approximately 70% as hydrogencarbonate ions (HCO3-) — CO2 enters red blood cells combines with water to form carbonic acid then dissociates to H+ and HCO3-. (2) Approximately 23% bound to haemoglobin as carbaminohaemoglobin. (3) Approximately 7% dissolved directly in plasma.$t$,
  explanation = $t$CO2 transport: 70% as HCO3- (catalysed by carbonic anhydrase in RBCs) 23% as carbaminohaemoglobin 7% dissolved in plasma. The chloride shift: as HCO3- leaves RBCs chloride ions enter to maintain electrical balance.$t$
WHERE id = 2751
  AND option_b = $t$Carbon dioxide is transported in three ways: (1) Approximately 70% as hydrogencarbonate ions (HCO₃⁻) — CO₂ enters red blood cells combines with water to form carbonic acid then dissociates to H⁺ and HCO₃⁻. (2) Approximately 23% bound to haemoglobin as carbaminohaemoglobin. (3) Approximately 7% dissolved directly in plasma.$t$
  AND explanation = $t$CO₂ transport: 70% as HCO₃⁻ (catalysed by carbonic anhydrase in RBCs) 23% as carbaminohaemoglobin 7% dissolved in plasma. The chloride shift: as HCO₃⁻ leaves RBCs chloride ions enter to maintain electrical balance.$t$;

UPDATE questions SET
  option_a = $t$During exercise muscles respire more rapidly producing more CO2 and consuming more O2. Rising CO2 levels lower blood pH. Chemoreceptors in the medulla oblongata and aortic arch detect the fall in pH and rising CO2. They send signals to increase breathing rate and depth — increasing ventilation to remove CO2 faster and supply more O2 to working muscles.$t$,
  explanation = $t$Chemoreceptors: central (medulla — primarily respond to CO2 and pH) peripheral (carotid and aortic bodies — respond to O2 CO2 and pH). CO2/H+ is the primary driver of increased ventilation during exercise. O2 only becomes a driver at extreme altitude or during severe hypoxia.$t$
WHERE id = 2753
  AND option_a = $t$During exercise muscles respire more rapidly producing more CO₂ and consuming more O₂. Rising CO₂ levels lower blood pH. Chemoreceptors in the medulla oblongata and aortic arch detect the fall in pH and rising CO₂. They send signals to increase breathing rate and depth — increasing ventilation to remove CO₂ faster and supply more O₂ to working muscles.$t$
  AND explanation = $t$Chemoreceptors: central (medulla — primarily respond to CO₂ and pH) peripheral (carotid and aortic bodies — respond to O₂ CO₂ and pH). CO₂/H⁺ is the primary driver of increased ventilation during exercise. O₂ only becomes a driver at extreme altitude or during severe hypoxia.$t$;

UPDATE questions SET
  option_d = $t$In respiring tissues CO2 concentration is high and O2 concentration is low. The low partial pressure of O2 causes haemoglobin to release O2 — dissociation. Additionally CO2 dissolves in plasma and red blood cells producing carbonic acid which lowers pH. The Bohr effect: lower pH reduces haemoglobin's affinity for O2 shifting the dissociation curve to the right so more O2 is released at any given partial pressure of O2.$t$,
  explanation = $t$Bohr effect: CO2 + H2O giving H2CO3 giving H+ + HCO3-. H+ binds haemoglobin reducing O2 affinity. Shift of dissociation curve right: more O2 released at same pO2. More active tissues produce more CO2 so get more O2 delivered — self-regulating system.$t$
WHERE id = 2755
  AND option_d = $t$In respiring tissues CO₂ concentration is high and O₂ concentration is low. The low partial pressure of O₂ causes haemoglobin to release O₂ — dissociation. Additionally CO₂ dissolves in plasma and red blood cells producing carbonic acid which lowers pH. The Bohr effect: lower pH reduces haemoglobin's affinity for O₂ shifting the dissociation curve to the right so more O₂ is released at any given partial pressure of O₂.$t$
  AND explanation = $t$Bohr effect: CO₂ + H₂O giving H2CO3 giving H⁺ + HCO₃⁻. H⁺ binds haemoglobin reducing O₂ affinity. Shift of dissociation curve right: more O₂ released at same pO2. More active tissues produce more CO₂ so get more O₂ delivered — self-regulating system.$t$;

UPDATE questions SET
  question_text = $t$Explain why fish gills are efficient gas exchange organs despite fish living in water where O2 concentration is much lower than in air.$t$,
  option_c = $t$Fish extract O2 from water by active transport which is more efficient than diffusion$t$,
  option_d = $t$Fish gills use a countercurrent exchange system. Water flows over gill lamellae in one direction while blood flows through them in the opposite direction. At every point along the gill the blood has lower O2 than the water flowing past — maintaining a diffusion gradient along the entire length of the gill. This extracts up to 80% of dissolved O2 from water compared to approximately 25% without countercurrent flow.$t$
WHERE id = 2757
  AND question_text = $t$Explain why fish gills are efficient gas exchange organs despite fish living in water where O₂ concentration is much lower than in air.$t$
  AND option_c = $t$Fish extract O₂ from water by active transport which is more efficient than diffusion$t$
  AND option_d = $t$Fish gills use a countercurrent exchange system. Water flows over gill lamellae in one direction while blood flows through them in the opposite direction. At every point along the gill the blood has lower O₂ than the water flowing past — maintaining a diffusion gradient along the entire length of the gill. This extracts up to 80% of dissolved O₂ from water compared to approximately 25% without countercurrent flow.$t$;

UPDATE questions SET
  option_a = $t$During exercise muscles respire more rapidly producing more CO2 and consuming more O2. Rising CO2 lowers blood pH. Chemoreceptors in the aortic arch and carotid bodies detect this change and send signals via the cardiovascular centre in the medulla to increase heart rate (via sympathetic nerves). Adrenaline released from the adrenal glands also acts directly on the SAN to increase rate. The increased cardiac output delivers more O2 to muscles and removes CO2 faster.$t$
WHERE id = 2758
  AND option_a = $t$During exercise muscles respire more rapidly producing more CO₂ and consuming more O₂. Rising CO₂ lowers blood pH. Chemoreceptors in the aortic arch and carotid bodies detect this change and send signals via the cardiovascular centre in the medulla to increase heart rate (via sympathetic nerves). Adrenaline released from the adrenal glands also acts directly on the SAN to increase rate. The increased cardiac output delivers more O₂ to muscles and removes CO₂ faster.$t$;

UPDATE questions SET
  option_a = $t$Cardiac output = 5000 mL/min. During exercise cardiac output decreases to conserve energy$t$,
  option_b = $t$Cardiac output = 750 mL/min. During exercise only heart rate increases not stroke volume$t$,
  option_c = $t$Cardiac output = 5250 mL/min. During exercise only stroke volume increases not heart rate$t$,
  option_d = $t$Cardiac output = heart rate x stroke volume = 75 x 70 = 5250 mL/min = 5.25 L/min. During exercise both heart rate and stroke volume increase. Heart rate can rise to 180-200 bpm and stroke volume can increase from 70 mL to approximately 110-130 mL as stronger ventricular contractions pump more blood per beat. Cardiac output during intense exercise can reach 20-25 L/min in trained athletes.$t$,
  explanation = $t$Cardiac output = HR x SV. At rest approximately 5 L/min. During maximal exercise: approximately 20-25 L/min (trained) approximately 15-20 L/min (untrained). Frank-Starling mechanism: increased venous return stretches ventricle causing more forceful contraction (increased SV).$t$
WHERE id = 2760
  AND option_a = $t$Cardiac output = \(5000\,\text{mL/min}\). During exercise cardiac output decreases to conserve energy$t$
  AND option_b = $t$Cardiac output = \(750\,\text{mL/min}\). During exercise only heart rate increases not stroke volume$t$
  AND option_c = $t$Cardiac output = \(5250\,\text{mL/min}\). During exercise only stroke volume increases not heart rate$t$
  AND option_d = $t$Cardiac output = heart rate × stroke volume \(= 75 \times 70 = 5250\,\text{mL/min} = 5.25\,\text{L/min}\). During exercise both heart rate and stroke volume increase. Heart rate can rise to 180–200 bpm and stroke volume can increase from 70 mL to approximately 110–130 mL as stronger ventricular contractions pump more blood per beat. Cardiac output during intense exercise can reach 20–\(25\,\text{L/min}\) in trained athletes.$t$
  AND explanation = $t$Cardiac output \(= HR x SV\). At rest approximately \(5\,\text{L/min}\). During maximal exercise: approximately 20–\(25\,\text{L/min}\) (trained) approximately 15–\(20\,\text{L/min}\) (untrained). Frank-Starling mechanism: increased venous return stretches ventricle causing more forceful contraction (increased SV).$t$;

UPDATE questions SET
  option_a = $t$Not all tissue fluid is reabsorbed by capillaries — approximately 10% (about 2-4 L per day) drains into blind-ended lymph capillaries. This fluid (lymph) is propelled by skeletal muscle contractions and one-way valves through lymph vessels eventually returning to the blood via the thoracic duct at the subclavian veins. Lymph nodes along the lymph vessels filter the fluid removing pathogens and cellular debris. Without the lymphatic system tissues would swell with oedema.$t$
WHERE id = 2761
  AND option_a = $t$Not all tissue fluid is reabsorbed by capillaries — approximately 10% (about 2–4 L per day) drains into blind-ended lymph capillaries. This fluid (lymph) is propelled by skeletal muscle contractions and one-way valves through lymph vessels eventually returning to the blood via the thoracic duct at the subclavian veins. Lymph nodes along the lymph vessels filter the fluid removing pathogens and cellular debris. Without the lymphatic system tissues would swell with oedema.$t$;

UPDATE questions SET
  option_c = $t$Capillaries are adapted for exchange by: walls only one endothelial cell thick (minimising diffusion distance to approximately 1 micrometre) narrow lumen (5-10 micrometres — red blood cells squeeze through single file slowing flow and increasing contact time) gaps between endothelial cells (allowing passage of water and dissolved molecules into tissue fluid) and a vast network giving a huge total surface area.$t$,
  explanation = $t$Capillary wall: single endothelium layer + thin basement membrane. Total capillary length in a human: approximately 100,000 km. Total SA: enormous. Fenestrated capillaries (kidney glomerulus intestinal villi): extra pores for faster filtration. Continuous capillaries (brain muscle): tighter junctions.$t$
WHERE id = 2764
  AND option_c = $t$Capillaries are adapted for exchange by: walls only one endothelial cell thick (minimising diffusion distance to approximately 1 micrometre) narrow lumen (5–10 micrometres — red blood cells squeeze through single file slowing flow and increasing contact time) gaps between endothelial cells (allowing passage of water and dissolved molecules into tissue fluid) and a vast network giving a huge total surface area.$t$
  AND explanation = $t$Capillary wall: single endothelium layer + thin basement membrane. Total capillary length in a human: approximately 100 000 km. Total SA: enormous. Fenestrated capillaries (kidney glomerulus intestinal villi): extra pores for faster filtration. Continuous capillaries (brain muscle): tighter junctions.$t$;

UPDATE questions SET
  question_text = $t$Explain the Bohr effect and calculate the percentage saturation of haemoglobin at a pO2 of 5 kPa at pH 7.4 versus pH 7.2 using the following data: at pH 7.4 and pO2 5 kPa saturation = 75%; at pH 7.2 and pO2 5 kPa saturation = 55%.$t$,
  option_b = $t$The Bohr effect describes how increased CO2 (and the resulting decrease in pH) reduces haemoglobin's affinity for oxygen. At pH 7.4 (resting tissue pH): 75% saturation at pO2 = 5 kPa. At pH 7.2 (actively respiring muscle pH): 55% saturation at the same pO2. The difference = 20% more oxygen is released to actively respiring tissues at lower pH. This is physiologically important because tissues that need more oxygen (working muscles producing more CO2) automatically receive more oxygen from haemoglobin.$t$,
  explanation = $t$Bohr shift: CO2 produces H+ (via carbonic acid). H+ binds to haemoglobin (to histidine residues) causing conformational change reducing O2 affinity. Right shift of dissociation curve. This is a self-regulating delivery mechanism: more metabolically active tissues release more CO2 get more O2.$t$
WHERE id = 2765
  AND question_text = $t$Explain the Bohr effect and calculate the percentage saturation of haemoglobin at a pO2 of 5 kPa at pH 7.4 versus pH 7.2 using the following data: at pH 7.4 and pO2 5 kPa saturation \(= 75\%\); at pH 7.2 and pO2 5 kPa saturation \(= 55\%\).$t$
  AND option_b = $t$The Bohr effect describes how increased CO₂ (and the resulting decrease in pH) reduces haemoglobin's affinity for oxygen. At pH 7.4 (resting tissue pH): 75% saturation at pO\(2 = 5\,\text{kPa}\). At pH 7.2 (actively respiring muscle pH): 55% saturation at the same pO2. The difference \(= 20\%\) more oxygen is released to actively respiring tissues at lower pH. This is physiologically important because tissues that need more oxygen (working muscles producing more CO₂) automatically receive more oxygen from haemoglobin.$t$
  AND explanation = $t$Bohr shift: CO₂ produces H⁺ (via carbonic acid). H⁺ binds to haemoglobin (to histidine residues) causing conformational change reducing O₂ affinity. Right shift of dissociation curve. This is a self-regulating delivery mechanism: more metabolically active tissues release more CO₂ get more O₂.$t$;

UPDATE questions SET
  option_d = $t$Fish (gills): countercurrent blood-water flow maintains diffusion gradient along entire gill surface extracting up to 80% of dissolved O2. Essential because water has much less dissolved O2 than air. Mammals (lungs/alveoli): large surface area (70 m2) thin walls rich blood supply. Ventilation maintains O2 gradient. Air is approximately 21% O2 making diffusion efficient. Insects (tracheal system): air tubes (tracheae) branch into tracheoles delivering O2 directly to tissues without a blood-based transport system. Efficient for small organisms but limits body size because diffusion is only effective over short distances.$t$,
  explanation = $t$Insect tracheal system: no haemoglobin needed. O2 diffuses directly from tracheoles to muscle cells. Body size limited by diffusion distance. Active ventilation in some insects (abdominal pumping). Spiracles (openings) can close to reduce water loss.$t$
WHERE id = 2767
  AND option_d = $t$Fish (gills): countercurrent blood-water flow maintains diffusion gradient along entire gill surface extracting up to 80% of dissolved O₂. Essential because water has much less dissolved O₂ than air. Mammals (lungs/alveoli): large surface area \((70 m^{2})\) thin walls rich blood supply. Ventilation maintains O₂ gradient. Air is approximately 21% O₂ making diffusion efficient. Insects (tracheal system): air tubes (tracheae) branch into tracheoles delivering O₂ directly to tissues without a blood-based transport system. Efficient for small organisms but limits body size because diffusion is only effective over short distances.$t$
  AND explanation = $t$Insect tracheal system: no haemoglobin needed. O₂ diffuses directly from tracheoles to muscle cells. Body size limited by diffusion distance. Active ventilation in some insects (abdominal pumping). Spiracles (openings) can close to reduce water loss.$t$;

UPDATE questions SET
  option_c = $t$Pulmonary fibrosis causes scarring and thickening of the alveolar walls. This increases the diffusion distance for oxygen and CO2 between air and blood — reducing the rate of gas exchange even though the concentration gradient remains unchanged. Predicted symptoms: breathlessness (especially during exercise when demand for O2 rises and the impaired diffusion becomes insufficient) low blood oxygen saturation (hypoxaemia) and in severe cases bluish skin (cyanosis). The patient may compensate by breathing faster increasing ventilation.$t$,
  option_d = $t$Pulmonary fibrosis primarily affects CO2 removal not O2 uptake so symptoms are minimal$t$,
  explanation = $t$Fick's law: rate of diffusion proportional to SA x concentration difference and inversely proportional to diffusion distance. Pulmonary fibrosis: diffusion distance increases rate decreases. FVC (forced vital capacity) and FEV1 both reduced. Treatment: antifibrotic drugs (pirfenidone nintedanib) reduce progression rate.$t$
WHERE id = 2768
  AND option_c = $t$Pulmonary fibrosis causes scarring and thickening of the alveolar walls. This increases the diffusion distance for oxygen and CO₂ between air and blood — reducing the rate of gas exchange even though the concentration gradient remains unchanged. Predicted symptoms: breathlessness (especially during exercise when demand for O₂ rises and the impaired diffusion becomes insufficient) low blood oxygen saturation (hypoxaemia) and in severe cases bluish skin (cyanosis). The patient may compensate by breathing faster increasing ventilation.$t$
  AND option_d = $t$Pulmonary fibrosis primarily affects CO₂ removal not O₂ uptake so symptoms are minimal$t$
  AND explanation = $t$Fick's law: rate of diffusion proportional to SA \(x\) concentration difference and inversely proportional to diffusion distance. Pulmonary fibrosis: diffusion distance increases rate decreases. FVC (forced vital capacity) and FEV1 both reduced. Treatment: antifibrotic drugs (pirfenidone nintedanib) reduce progression rate.$t$;

UPDATE questions SET
  option_b = $t$The sigmoidal shape is disadvantageous because haemoglobin cannot load O2 fully at high pO2$t$,
  option_c = $t$The sigmoidal (S-shaped) curve results from cooperative binding: when one O2 binds to a haem group it causes a conformational change in the haemoglobin molecule that increases the affinity of the remaining binding sites for O2. This means the first O2 is hardest to bind but subsequent binding becomes progressively easier. Physiological advantage: at high pO2 in the lungs (approximately 13 kPa) haemoglobin is nearly fully saturated (loading is efficient). At low pO2 in tissues (approximately 5 kPa) the cooperative binding means a relatively small fall in pO2 releases a large amount of O2 (the steep part of the curve). A hyperbolic curve would either load poorly in the lungs or unload poorly in tissues — the sigmoidal shape optimises both.$t$,
  option_d = $t$A hyperbolic curve would be more efficient because it loads O2 faster in the lungs$t$,
  explanation = $t$T-state (tense): low O2 affinity. R-state (relaxed): high O2 affinity. Binding of first O2 shifts equilibrium toward R-state. Allosteric cooperativity. Hill coefficient n approximately 2.8 for haemoglobin (n=1 = no cooperativity n=4 = maximum). 2,3-BPG shifts curve right (reduces O2 affinity).$t$
WHERE id = 2769
  AND option_b = $t$The sigmoidal shape is disadvantageous because haemoglobin cannot load O₂ fully at high pO2$t$
  AND option_c = $t$The sigmoidal (S-shaped) curve results from cooperative binding: when one O₂ binds to a haem group it causes a conformational change in the haemoglobin molecule that increases the affinity of the remaining binding sites for O₂. This means the first O₂ is hardest to bind but subsequent binding becomes progressively easier. Physiological advantage: at high pO2 in the lungs (approximately 13 kPa) haemoglobin is nearly fully saturated (loading is efficient). At low pO2 in tissues (approximately 5 kPa) the cooperative binding means a relatively small fall in pO2 releases a large amount of O₂ (the steep part of the curve). A hyperbolic curve would either load poorly in the lungs or unload poorly in tissues — the sigmoidal shape optimises both.$t$
  AND option_d = $t$A hyperbolic curve would be more efficient because it loads O₂ faster in the lungs$t$
  AND explanation = $t$T-state (tense): low O₂ affinity. R-state (relaxed): high O₂ affinity. Binding of first O₂ shifts equilibrium toward R-state. Allosteric cooperativity. Hill coefficient \(n\) approximately 2.8 for haemoglobin (\(n = 1\) = no cooperativity \(n = 4\)= maximum). 2,3-BPG shifts curve right (reduces O₂ affinity).$t$;

UPDATE questions SET
  option_a = $t$Prolonged endurance training causes: cardiac hypertrophy (the left ventricle wall thickens and the chamber volume increases — the heart can pump more blood per beat). Resting stroke volume increases (from approximately 70 mL to 100+ mL in trained athletes). Resting heart rate decreases (athlete's bradycardia — can fall to 40-50 bpm) because the larger stroke volume maintains adequate cardiac output at lower frequency. Increased capillary density in muscles. Greater red blood cell mass. These adaptations enable a much higher maximal cardiac output during exercise.$t$,
  explanation = $t$Sports heart: physiological hypertrophy (enlarged stroke volume) vs pathological hypertrophy (thickened walls without increased chamber volume). Bradycardia: resting HR 40-50 bpm in elite endurance athletes. VO2max increases with training. Margaria's test measures cardiac output adaptations.$t$
WHERE id = 2770
  AND option_a = $t$Prolonged endurance training causes: cardiac hypertrophy (the left ventricle wall thickens and the chamber volume increases — the heart can pump more blood per beat). Resting stroke volume increases (from approximately 70 mL to 100+ mL in trained athletes). Resting heart rate decreases (athlete's bradycardia — can fall to 40–50 bpm) because the larger stroke volume maintains adequate cardiac output at lower frequency. Increased capillary density in muscles. Greater red blood cell mass. These adaptations enable a much higher maximal cardiac output during exercise.$t$
  AND explanation = $t$Sports heart: physiological hypertrophy (enlarged stroke volume) vs pathological hypertrophy (thickened walls without increased chamber volume). Bradycardia: resting HR 40–50 bpm in elite endurance athletes. VO2max increases with training. Margaria's test measures cardiac output adaptations.$t$;

UPDATE questions SET
  option_c = $t$In hypoxic conditions HbS haemoglobin polymerises into long fibres that deform the red blood cell into a rigid sickle shape. Sickled cells cannot deform to squeeze through narrow capillaries (5-8 micrometres) and become lodged blocking blood flow. This vaso-occlusion causes ischaemia (tissue oxygen deprivation) downstream producing intense pain (vaso-occlusive crisis) and potential organ damage. Sickled cells are also destroyed more rapidly (haemolytic anaemia) because the spleen removes abnormally shaped cells.$t$
WHERE id = 2771
  AND option_c = $t$In hypoxic conditions HbS haemoglobin polymerises into long fibres that deform the red blood cell into a rigid sickle shape. Sickled cells cannot deform to squeeze through narrow capillaries (5–8 micrometres) and become lodged blocking blood flow. This vaso-occlusion causes ischaemia (tissue oxygen deprivation) downstream producing intense pain (vaso-occlusive crisis) and potential organ damage. Sickled cells are also destroyed more rapidly (haemolytic anaemia) because the spleen removes abnormally shaped cells.$t$;

UPDATE questions SET
  option_b = $t$The resting membrane potential (approximately -70 mV inside) is established by: (1) Unequal ion distribution: high K+ inside the cell high Na+ outside maintained by the Na+/K+ ATPase pump (actively pumps 3 Na+ out and 2 K+ in per cycle keeping the inside negative). (2) Differential permeability: at rest the membrane is more permeable to K+ than Na+ (K+ leak channels are open). K+ diffuses out down its concentration gradient making the inside more negative until electrical attraction balances the diffusion tendency. This equilibrium is the resting potential.$t$,
  explanation = $t$Resting potential: -70 mV inside vs outside. Na+/K+ pump: 3 Na+ out 2 K+ in per ATP — electrogenic (makes inside more negative) and maintains concentration gradients. K+ equilibrium potential approximately -90 mV; Na+ equilibrium potential approximately +60 mV. Actual resting potential is a compromise between them.$t$
WHERE id = 2772
  AND option_b = $t$The resting membrane potential (approximately - 70 mV inside) is established by: (1) Unequal ion distribution: high K⁺ inside the cell high Na⁺ outside maintained by the Na⁺/K⁺ ATPase pump (actively pumps 3 Na⁺ out and 2 K⁺ in per cycle keeping the inside negative). (2) Differential permeability: at rest the membrane is more permeable to K⁺ than Na⁺ (K⁺ leak channels are open). K⁺ diffuses out down its concentration gradient making the inside more negative until electrical attraction balances the diffusion tendency. This equilibrium is the resting potential.$t$
  AND explanation = $t$Resting potential: - 70 mV inside vs outside. Na⁺/K⁺ pump: 3 Na⁺ out 2 K⁺ in per ATP — electrogenic (makes inside more negative) and maintains concentration gradients. K⁺ equilibrium potential approximately - 90 mV; Na⁺ equilibrium potential approximately + 60 mV. Actual resting potential is a compromise between them.$t$;

UPDATE questions SET
  option_b = $t$At high altitude the lower pO2 means haemoglobin loads less O2 in the lungs and blood O2 saturation falls. Physiological acclimatisation over weeks: (1) Increased erythropoietin (EPO) production from the kidneys stimulating red blood cell production — increasing haematocrit and O2 carrying capacity. (2) Increased 2,3-bisphosphoglycerate (2,3-BPG) in red blood cells — shifts the O2 dissociation curve right increasing O2 unloading in tissues. (3) Increased capillary density in muscles. (4) Increased breathing rate and depth (hyperventilation) reducing blood CO2 and alkalosis. High-altitude natives (Tibetans Andeans) have additional genetic adaptations.$t$,
  explanation = $t$EPO: glycoprotein hormone from peritubular cells of kidney. Stimulates haematopoiesis in bone marrow. EPO is the basis of blood doping in sport. Tibetans: EPAS1 gene variant (from Denisovan introgression) enables efficient O2 use without excessive polycythaemia.$t$
WHERE id = 2773
  AND option_b = $t$At high altitude the lower pO2 means haemoglobin loads less O₂ in the lungs and blood O₂ saturation falls. Physiological acclimatisation over weeks: (1) Increased erythropoietin (EPO) production from the kidneys stimulating red blood cell production — increasing haematocrit and O₂ carrying capacity. (2) Increased 2,3-bisphosphoglycerate (2,3-BPG) in red blood cells — shifts the O₂ dissociation curve right increasing O₂ unloading in tissues. (3) Increased capillary density in muscles. (4) Increased breathing rate and depth (hyperventilation) reducing blood CO₂ and alkalosis. High-altitude natives (Tibetans Andeans) have additional genetic adaptations.$t$
  AND explanation = $t$EPO: glycoprotein hormone from peritubular cells of kidney. Stimulates haematopoiesis in bone marrow. EPO is the basis of blood doping in sport. Tibetans: EPAS1 gene variant (from Denisovan introgression) enables efficient O₂ use without excessive polycythaemia.$t$;

UPDATE questions SET
  explanation = $t$Dialysis vs transplant: dialysis 5-year survival approximately 35-40%; transplant 5-year survival approximately 80-85%. Transplant restores full kidney function including EPO production. Dialysis: peritoneal dialysis (home-based uses abdominal peritoneum as membrane) vs haemodialysis (clinic-based).$t$
WHERE id = 2774
  AND explanation = $t$Dialysis vs transplant: dialysis 5-year survival approximately 35–40%; transplant 5-year survival approximately 80–85%. Transplant restores full kidney function including EPO production. Dialysis: peritoneal dialysis (home-based uses abdominal peritoneum as membrane) vs haemodialysis (clinic-based).$t$;

UPDATE questions SET
  explanation = $t$Bacteria: cell wall (targeted by penicillin) 70S ribosomes (targeted by streptomycin) no nucleus. Viruses: no organelles replicate using host ribosomes — antibiotics have no target. Antibiotic resistance: a major global health threat from overuse and misuse.$t$
WHERE id = 2777
  AND explanation = $t$Bacteria: cell wall (targeted by penicillin) \(70S\) ribosomes (targeted by streptomycin) no nucleus. Viruses: no organelles replicate using host ribosomes — antibiotics have no target. Antibiotic resistance: a major global health threat from overuse and misuse.$t$;

UPDATE questions SET
  explanation = $t$Physical barriers: skin (intact unbroken barrier) mucous membranes (trap and remove pathogens). Chemical barriers: stomach acid (pH 1-2) lysozyme in tears and saliva (breaks bacterial cell walls) sebum (acidic discourages bacterial growth) commensal bacteria (compete with pathogens).$t$
WHERE id = 2778
  AND explanation = $t$Physical barriers: skin (intact unbroken barrier) mucous membranes (trap and remove pathogens). Chemical barriers: stomach acid (pH \(1 - 2\)) lysozyme in tears and saliva (breaks bacterial cell walls) sebum (acidic discourages bacterial growth) commensal bacteria (compete with pathogens).$t$;

UPDATE questions SET
  option_d = $t$Antibiotic resistance develops by natural selection. Within a population of bacteria random mutations occasionally produce individuals with reduced sensitivity to an antibiotic. When antibiotics are used non-resistant bacteria are killed while resistant bacteria survive and reproduce passing on the resistance gene(s). Over many generations the frequency of resistant bacteria in the population increases. Misuse of antibiotics (incomplete courses wrong type) accelerates this process by allowing partially resistant bacteria to survive and selecting for full resistance.$t$
WHERE id = 2782
  AND option_d = $t$Antibiotic resistance develops by natural selection. Within a population of bacteria random mutations occasionally produce individuals with reduced sensitivity to an antibiotic. When antibiotics are used non-resistant bacteria are killed while resistant bacteria survive and reproduce passing on the resistance gene(\(s\)). Over many generations the frequency of resistant bacteria in the population increases. Misuse of antibiotics (incomplete courses wrong type) accelerates this process by allowing partially resistant bacteria to survive and selecting for full resistance.$t$;

UPDATE questions SET
  explanation = $t$Modern cancer treatment: often combination (surgery + chemotherapy + radiotherapy). Targeted therapies (e.g. imatinib trastuzumab) more specific less systemic side effects. Immunotherapy (checkpoint inhibitors CAR-T cells): harness the immune system against cancer. 5-year survival rates have improved dramatically for many cancers.$t$
WHERE id = 2783
  AND explanation = $t$Modern cancer treatment: often combination (surgery + chemotherapy + radiotherapy). Targeted therapies (e.g. imatinib trastuzumab) more specific less systemic side effects. Immunotherapy (checkpoint inhibitors \(CAR - T\) cells): harness the immune system against cancer. 5-year survival rates have improved dramatically for many cancers.$t$;

UPDATE questions SET
  option_a = $t$Primary response: first encounter with antigen. B lymphocytes specific to that antigen are activated and differentiate into plasma cells (producing antibodies) and memory B cells. Antibody levels rise slowly over 1-2 weeks reach a moderate peak then decline. Secondary response: second encounter with the same antigen. Memory B cells (persisting from primary response) are rapidly activated and differentiate into large numbers of plasma cells. Antibody levels rise faster (within days) to a higher peak and persist longer. The secondary response usually clears the infection before symptoms develop.$t$
WHERE id = 2786
  AND option_a = $t$Primary response: first encounter with antigen. B lymphocytes specific to that antigen are activated and differentiate into plasma cells (producing antibodies) and memory B cells. Antibody levels rise slowly over 1–2 weeks reach a moderate peak then decline. Secondary response: second encounter with the same antigen. Memory B cells (persisting from primary response) are rapidly activated and differentiate into large numbers of plasma cells. Antibody levels rise faster (within days) to a higher peak and persist longer. The secondary response usually clears the infection before symptoms develop.$t$;

UPDATE questions SET
  option_d = $t$Herd immunity occurs when enough of a population is immune (through vaccination or previous infection) that transmission chains are broken. When an infected person encounters mostly immune individuals the pathogen cannot spread easily and outbreaks are prevented. Unvaccinated individuals (including those who cannot be vaccinated for medical reasons) are indirectly protected because the pathogen rarely reaches them. The threshold coverage varies by disease: measles requires approximately 95% coverage (very high because it is highly contagious R0 = 12-18). Polio requires approximately 80-85%.$t$,
  explanation = $t$Herd immunity threshold: 1 - 1/R0. For measles (R0 = 15): threshold = 1 - 1/15 = approximately 93%. For COVID-19 original strain (R0 approximately 2.5): threshold approximately 60%. Falling below threshold: outbreaks can re-emerge even in previously well-vaccinated populations.$t$
WHERE id = 2787
  AND option_d = $t$Herd immunity occurs when enough of a population is immune (through vaccination or previous infection) that transmission chains are broken. When an infected person encounters mostly immune individuals the pathogen cannot spread easily and outbreaks are prevented. Unvaccinated individuals (including those who cannot be vaccinated for medical reasons) are indirectly protected because the pathogen rarely reaches them. The threshold coverage varies by disease: measles requires approximately 95% coverage (very high because it is highly contagious \(R0 = 12 - 18\)). Polio requires approximately 80–85%.$t$
  AND explanation = $t$Herd immunity threshold: \(1 - \frac{1}{R0}\). For measles \((R0 = 15)\): threshold \(= 1 - \frac{1}{15}\)= approximately 93%. For COVID-19 original strain (R0 approximately 2.5): threshold approximately 60%. Falling below threshold: outbreaks can re-emerge even in previously well-vaccinated populations.$t$;

UPDATE questions SET
  explanation = $t$RCT is the gold standard for evidence. Randomisation: ensures groups are comparable. Double-blind: eliminates expectation bias (placebo effect) and observer bias. Statistical significance: p < 0.05 standard threshold. Phase III can involve 10,000+ patients in multiple countries.$t$
WHERE id = 2791
  AND explanation = $t$RCT is the gold standard for evidence. Randomisation: ensures groups are comparable. Double-blind: eliminates expectation bias (placebo effect) and observer bias. Statistical significance: \(p < 0.05\) standard threshold. Phase III can involve 10 000+ patients in multiple countries.$t$;

UPDATE questions SET
  option_d = $t$Bacterial infections: many can be effectively treated with antibiotics that target structures unique to bacteria (cell wall 70S ribosomes DNA gyrase). Antibiotic resistance is a major and growing problem. Viral infections: antibiotics have no effect. Antiviral drugs exist for some viruses (aciclovir for herpes neuraminidase inhibitors for influenza antiretrovirals for HIV) but are generally less effective than antibiotics against bacteria. Viruses use host cell machinery making it difficult to target them without harming host cells. Many viral infections are self-limiting and do not require treatment.$t$
WHERE id = 2793
  AND option_d = $t$Bacterial infections: many can be effectively treated with antibiotics that target structures unique to bacteria (cell wall \(70S\) ribosomes DNA gyrase). Antibiotic resistance is a major and growing problem. Viral infections: antibiotics have no effect. Antiviral drugs exist for some viruses (aciclovir for herpes neuraminidase inhibitors for influenza antiretrovirals for HIV) but are generally less effective than antibiotics against bacteria. Viruses use host cell machinery making it difficult to target them without harming host cells. Many viral infections are self-limiting and do not require treatment.$t$;

UPDATE questions SET
  option_c = $t$For: large randomised trials (Heart Protection Study JUPITER) show statins reduce LDL cholesterol by 30-50% and significantly reduce myocardial infarction stroke and cardiovascular death in high-risk individuals. Evidence in lower-risk individuals is less clear — the absolute risk reduction is smaller meaning more people must be treated (higher NNT) to prevent one event. Against: side effects (myopathy rhabdomyolysis in rare cases increased type 2 diabetes risk liver enzyme elevations) small but real costs to individuals and health systems when treating millions of low-risk people. Current guidelines (NICE): offer statins to individuals with greater than 10% 10-year cardiovascular risk. The balance of benefit vs harm is favourable for high-risk individuals and uncertain for low-risk.$t$
WHERE id = 2795
  AND option_c = $t$For: large randomised trials (Heart Protection Study JUPITER) show statins reduce LDL cholesterol by 30–50% and significantly reduce myocardial infarction stroke and cardiovascular death in high-risk individuals. Evidence in lower-risk individuals is less clear — the absolute risk reduction is smaller meaning more people must be treated (higher NNT) to prevent one event. Against: side effects (myopathy rhabdomyolysis in rare cases increased type 2 diabetes risk liver enzyme elevations) small but real costs to individuals and health systems when treating millions of low-risk people. Current guidelines (NICE): offer statins to individuals with greater than 10% 10-year cardiovascular risk. The balance of benefit vs harm is favourable for high-risk individuals and uncertain for low-risk.$t$;

UPDATE questions SET
  option_c = $t$Three resistance mechanisms: (1) Enzymatic inactivation — bacteria produce enzymes that destroy the antibiotic. Beta-lactamases break the beta-lactam ring of penicillin and cephalosporins rendering them inactive. (2) Target site modification — mutation changes the antibiotic's target so it can no longer bind. MRSA has a modified PBP2a (encoded by mecA gene) that does not bind methicillin or other beta-lactams. (3) Efflux pumps — membrane proteins actively pump the antibiotic out of the bacterial cell before it can reach its target at a sufficient concentration. Common in multi-drug resistant tuberculosis. (4) Reduced permeability — mutations in outer membrane porins reduce antibiotic entry.$t$
WHERE id = 2796
  AND option_c = $t$Three resistance mechanisms: (1) Enzymatic inactivation — bacteria produce enzymes that destroy the antibiotic. Beta-lactamases break the beta-lactam ring of penicillin and cephalosporins rendering them inactive. (2) Target site modification — mutation changes the antibiotic's target so it can no longer bind. MRSA has a modified \(PBP2a\) (encoded by mecA gene) that does not bind methicillin or other beta-lactams. (3) Efflux pumps — membrane proteins actively pump the antibiotic out of the bacterial cell before it can reach its target at a sufficient concentration. Common in multi-drug resistant tuberculosis. (4) Reduced permeability — mutations in outer membrane porins reduce antibiotic entry.$t$;

UPDATE questions SET
  option_c = $t$Plasmodium falciparum life cycle: mosquito injects sporozoites into blood they travel to liver and multiply as merozoites. Merozoites infect red blood cells and multiply rupturing them releasing more merozoites (causing fever) and gametocytes. Mosquito ingests gametocytes completing the cycle. Control measures: insecticide-treated bed nets (ITNs) indoor residual spraying (IRS) artemisinin-based combination therapies (ACTs) drainage of standing water. Vaccine challenges: Plasmodium has a complex multi-stage life cycle with different antigens at each stage making a single vaccine difficult. Antigenic variation — the parasite changes surface proteins to evade immunity. RTS,S/AS01 (Mosquirix): first approved malaria vaccine (WHO 2021) reduces clinical malaria by approximately 30% in children. R21/Matrix-M: newer vaccine showing approximately 75% efficacy in Phase III trials.$t$,
  explanation = $t$Malaria burden: approximately 249 million cases and 608,000 deaths in 2022 (WHO). Approximately 95% of deaths in sub-Saharan Africa. Artemisinin resistance emerging in Southeast Asia is a major concern. Children under 5 account for approximately 80% of malaria deaths in Africa.$t$
WHERE id = 2797
  AND option_c = $t$Plasmodium falciparum life cycle: mosquito injects sporozoites into blood they travel to liver and multiply as merozoites. Merozoites infect red blood cells and multiply rupturing them releasing more merozoites (causing fever) and gametocytes. Mosquito ingests gametocytes completing the cycle. Control measures: insecticide-treated bed nets (ITNs) indoor residual spraying (IRS) artemisinin-based combination therapies (ACTs) drainage of standing water. Vaccine challenges: Plasmodium has a complex multi-stage life cycle with different antigens at each stage making a single vaccine difficult. Antigenic variation — the parasite changes surface proteins to evade immunity. RTS,S/AS01 (Mosquirix): first approved malaria vaccine (WHO 2021) reduces clinical malaria by approximately 30% in children. R21/Matrix\(- M\): newer vaccine showing approximately 75% efficacy in Phase III trials.$t$
  AND explanation = $t$Malaria burden: approximately 249 million cases and 608 000 deaths in 2022 (WHO). Approximately 95% of deaths in sub-Saharan Africa. Artemisinin resistance emerging in Southeast Asia is a major concern. Children under 5 account for approximately 80% of malaria deaths in Africa.$t$;

UPDATE questions SET
  option_b = $t$Conventional chemotherapy kills all rapidly dividing cells (cancer and normal). Immune checkpoint inhibitors work by releasing brakes on the immune system that cancer cells exploit to escape destruction. PD-1 and CTLA-4 are checkpoint proteins on T cells that normally prevent excessive immune activation. Many cancers express PD-L1 which binds PD-1 on T cells suppressing their activity — allowing cancer cells to hide from the immune system. Checkpoint inhibitors (pembrolizumab nivolumab ipilimumab) are antibodies that block these interactions releasing T cells to attack cancer cells. Advantages: can produce durable responses in cancers that respond. Disadvantages: works only for a subset of patients immune-related adverse events (autoimmune side effects).$t$,
  explanation = $t$Anti-PD-1/PD-L1 (pembrolizumab nivolumab atezolizumab): approved for melanoma lung NSCLC bladder kidney bladder urothelial and many others. Anti-CTLA-4 (ipilimumab): approved for melanoma. Combination (anti-PD-1 + anti-CTLA-4): higher response rate but more toxicity. Biomarker selection (PD-L1 expression tumour mutation burden) predicts response.$t$
WHERE id = 2798
  AND option_b = $t$Conventional chemotherapy kills all rapidly dividing cells (cancer and normal). Immune checkpoint inhibitors work by releasing brakes on the immune system that cancer cells exploit to escape destruction. \(PD - 1\) and CTLA-4 are checkpoint proteins on T cells that normally prevent excessive immune activation. Many cancers express \(PD - L1\) which binds \(PD - 1\) on T cells suppressing their activity — allowing cancer cells to hide from the immune system. Checkpoint inhibitors (pembrolizumab nivolumab ipilimumab) are antibodies that block these interactions releasing T cells to attack cancer cells. Advantages: can produce durable responses in cancers that respond. Disadvantages: works only for a subset of patients immune-related adverse events (autoimmune side effects).$t$
  AND explanation = $t$Anti\(- PD - \frac{1}{PD} - L1\) (pembrolizumab nivolumab atezolizumab): approved for melanoma lung NSCLC bladder kidney bladder urothelial and many others. Anti-CTLA-4 (ipilimumab): approved for melanoma. Combination (anti\(- PD - 1\)+ anti-CTLA-4): higher response rate but more toxicity. Biomarker selection (\(PD - L1\) expression tumour mutation burden) predicts response.$t$;

UPDATE questions SET
  explanation = $t$Placebo effect: approximately 30-40% improvement in subjective outcomes (pain mood) in placebo groups. ITT prevents informative censoring bias: if sicker patients (who have worse outcomes) are more likely to drop out and are excluded results are biased toward positive outcomes.$t$
WHERE id = 2801
  AND explanation = $t$Placebo effect: approximately 30–40% improvement in subjective outcomes (pain mood) in placebo groups. ITT prevents informative censoring bias: if sicker patients (who have worse outcomes) are more likely to drop out and are excluded results are biased toward positive outcomes.$t$;

UPDATE questions SET
  explanation = $t$UNAIDS 95-95-95 targets: 95% of people with HIV diagnosed 95% on treatment 95% virally suppressed. Achievement of these targets would end AIDS as a public health threat. Progress: global HIV incidence fell from approximately 3.3 million in 2001 to approximately 1.3 million new infections in 2022.$t$
WHERE id = 2803
  AND explanation = $t$UNAIDS \(95 - 95 - 95\) targets: 95% of people with HIV diagnosed 95% on treatment 95% virally suppressed. Achievement of these targets would end AIDS as a public health threat. Progress: global HIV incidence fell from approximately 3.3 million in 2001 to approximately 1.3 million new infections in 2022.$t$;

UPDATE questions SET
  option_a = $t$Natural selection was first proposed by Gregor Mendel in the 1860s$t$
WHERE id = 2805
  AND option_a = $t$Natural selection was first proposed by Gregor Mendel in the \(1860s\)$t$;

UPDATE questions SET
  explanation = $t$Evolution evidence: fossils (Archaeopteryx transitional bird-reptile) homologous structures (forelimb bones in human bat whale) molecular phylogenetics (cytochrome c sequences reflect evolutionary relationships) observed evolution (Grants finch beak studies antibiotic resistance peppered moth).$t$
WHERE id = 2807
  AND explanation = $t$Evolution evidence: fossils (Archaeopteryx transitional bird-reptile) homologous structures (forelimb bones in human bat whale) molecular phylogenetics (cytochrome \(c\) sequences reflect evolutionary relationships) observed evolution (Grants finch beak studies antibiotic resistance peppered moth).$t$;

UPDATE questions SET
  explanation = $t$Fossilisation conditions: rapid burial (prevents scavenging and decay) anoxic conditions (slow bacterial decomposition) hard parts (bones shells chitin). Exceptional preservation: amber (insects) permafrost (woolly mammoths) La Brea tar pits. Radiometric dating: carbon-14 (up to 50,000 years) potassium-40 (millions to billions of years).$t$
WHERE id = 2813
  AND explanation = $t$Fossilisation conditions: rapid burial (prevents scavenging and decay) anoxic conditions (slow bacterial decomposition) hard parts (bones shells chitin). Exceptional preservation: amber (insects) permafrost (woolly mammoths) La Brea tar pits. Radiometric dating: carbon-14 (up to 50 000 years) potassium-40 (millions to billions of years).$t$;

UPDATE questions SET
  explanation = $t$Galapagos finches: radiation from one ancestral finch species into 14 species with different beak sizes and feeding habits. Each island population isolated — different food sources drive different adaptations. Allopolyploid speciation (sympatric): Spartina anglica arose in 1870s from hybridisation and chromosome doubling of two parent grass species.$t$
WHERE id = 2815
  AND explanation = $t$Galapagos finches: radiation from one ancestral finch species into 14 species with different beak sizes and feeding habits. Each island population isolated — different food sources drive different adaptations. Allopolyploid speciation (sympatric): Spartina anglica arose in \(1870s\) from hybridisation and chromosome doubling of two parent grass species.$t$;

UPDATE questions SET
  explanation = $t$Bottleneck effect: cheetahs (extreme genetic uniformity from bottleneck approximately 10,000 years ago) northern elephant seals (reduced to approximately 20-100 individuals in 1890s). Founder effect: Amish community high frequency of Ellis-van Creveld syndrome. Small populations: genetic drift can fix deleterious alleles despite natural selection against them.$t$
WHERE id = 2816
  AND explanation = $t$Bottleneck effect: cheetahs (extreme genetic uniformity from bottleneck approximately 10 000 years ago) northern elephant seals (reduced to approximately 20–100 individuals in \(1890s\)). Founder effect: Amish community high frequency of Ellis-van Creveld syndrome. Small populations: genetic drift can fix deleterious alleles despite natural selection against them.$t$;

UPDATE questions SET
  explanation = $t$Cytochrome c: conserved protein used in early molecular phylogenetics. Mitochondrial DNA: evolves faster useful for recent divergences. Nuclear DNA: more slowly evolving for deeper phylogenies. BLAST: database comparison tool. Phylogenetic trees: maximum likelihood Bayesian inference distance methods.$t$
WHERE id = 2817
  AND explanation = $t$Cytochrome \(c\): conserved protein used in early molecular phylogenetics. Mitochondrial DNA: evolves faster useful for recent divergences. Nuclear DNA: more slowly evolving for deeper phylogenies. BLAST: database comparison tool. Phylogenetic trees: maximum likelihood Bayesian inference distance methods.$t$;

UPDATE questions SET
  explanation = $t$Recombinant human insulin (humulin): first recombinant therapeutic protein approved 1982. Produced in E. coli. Gene therapy successes: SCID-ADA (Strimvelis) haemophilia B (etranacogene dezaparvovec) Leber congenital amaurosis (voretigene neparvovec). Xenotransplantation: pig kidneys with 10 human gene edits transplanted into brain-dead human patients (2022-2023).$t$
WHERE id = 2818
  AND explanation = $t$Recombinant human insulin (humulin): first recombinant therapeutic protein approved 1982. Produced in E. coli. Gene therapy successes: SCID-ADA (Strimvelis) haemophilia B (etranacogene dezaparvovec) Leber congenital amaurosis (voretigene neparvovec). Xenotransplantation: pig kidneys with 10 human gene edits transplanted into brain-dead human patients \((2022 - 2023)\).$t$;

UPDATE questions SET
  option_d = $t$CRISPR is identical to restriction enzyme technology from the 1970s$t$
WHERE id = 2820
  AND option_d = $t$CRISPR is identical to restriction enzyme technology from the \(1970s\)$t$;

UPDATE questions SET
  option_d = $t$Fossil record: shows progression of life forms over geological time. Transitional fossils (Archaeopteryx tiktaalik) show intermediate characteristics. Limitation: fossils only form under specific conditions so the record is incomplete. Comparative anatomy: homologous structures (pentadactyl limb across mammals bats whales and humans all have same basic bone arrangement) indicate common ancestry. Analogous structures (convergent evolution) can mislead. Molecular biology: DNA and protein sequence similarities directly reflect evolutionary relationships. Cytochrome c sequences virtually identical in humans and chimpanzees diverge in proportion to evolutionary distance. Mitochondrial DNA enables tracking of human migration. All three evidence types independently support the same evolutionary relationships — their convergence provides very strong evidence.$t$
WHERE id = 2821
  AND option_d = $t$Fossil record: shows progression of life forms over geological time. Transitional fossils (Archaeopteryx tiktaalik) show intermediate characteristics. Limitation: fossils only form under specific conditions so the record is incomplete. Comparative anatomy: homologous structures (pentadactyl limb across mammals bats whales and humans all have same basic bone arrangement) indicate common ancestry. Analogous structures (convergent evolution) can mislead. Molecular biology: DNA and protein sequence similarities directly reflect evolutionary relationships. Cytochrome \(c\) sequences virtually identical in humans and chimpanzees diverge in proportion to evolutionary distance. Mitochondrial DNA enables tracking of human migration. All three evidence types independently support the same evolutionary relationships — their convergence provides very strong evidence.$t$;

UPDATE questions SET
  option_c = $t$Gene banks (seed banks genetic resource collections) store living plant material (seeds) tissue culture or frozen gametes/embryos of animals. They are important for: (1) Conservation of genetic diversity — preserving genetic variation that may be lost from wild populations. This variation may be needed for future crop improvement or ecological restoration. (2) Food security — storing the genetic diversity of crop wild relatives that may carry resistance to future diseases or tolerance to climate change. (3) Species preservation — cryopreservation of sperm eggs and embryos of endangered animals. Examples: Svalbard Global Seed Vault (1.3 million seed samples from 6000 plant species) Frozen Zoo at San Diego (10,500 individual animals from 1000 species).$t$
WHERE id = 2822
  AND option_c = $t$Gene banks (seed banks genetic resource collections) store living plant material (seeds) tissue culture or frozen gametes/embryos of animals. They are important for: (1) Conservation of genetic diversity — preserving genetic variation that may be lost from wild populations. This variation may be needed for future crop improvement or ecological restoration. (2) Food security — storing the genetic diversity of crop wild relatives that may carry resistance to future diseases or tolerance to climate change. (3) Species preservation — cryopreservation of sperm eggs and embryos of endangered animals. Examples: Svalbard Global Seed Vault (1.3 million seed samples from 6000 plant species) Frozen Zoo at San Diego (10 500 individual animals from 1000 species).$t$;

UPDATE questions SET
  explanation = $t$Diversity indices: Simpson's index D = 1 - sum(n/N)^2. Shannon index H = -sum(pi ln pi). These account for both richness and evenness. Island biogeography (MacArthur Wilson): species richness determined by immigration and extinction rates.$t$
WHERE id = 2823
  AND explanation = $t$Diversity indices: Simpson's index \(D = 1 - sum(\frac{n}{N})^{2}\). Shannon index \(H = - sum(\pi \ln \pi)\). These account for both richness and evenness. Island biogeography (MacArthur Wilson): species richness determined by immigration and extinction rates.$t$;

UPDATE questions SET
  option_c = $t$Evidence: IUCN Red List shows approximately 42% of assessed species are threatened or near-threatened. Current extinction rate estimated at 100-1000 times the background rate (pre-human extinction rate approximately 0.1-1 species per million species-years). Vertebrate populations declined by average 69% between 1970 and 2018 (WWF Living Planet Report). Drivers: habitat destruction (primary driver accounting for approximately 75% of recent extinctions) overexploitation climate change invasive species pollution. Conservation strategies: in situ (protected areas national parks restoration ecology) ex situ (zoos seed banks captive breeding) legislation (CITES IUCN). Evidence for effectiveness: giant panda downlisted from endangered to vulnerable (2016) northern white rhino failed (functionally extinct). Rewilding (reintroducing keystone species) showing promise in some ecosystems.$t$
WHERE id = 2824
  AND option_c = $t$Evidence: IUCN Red List shows approximately 42% of assessed species are threatened or near-threatened. Current extinction rate estimated at 100–1000 times the background rate (pre-human extinction rate approximately 0.1–1 species per million species-years). Vertebrate populations declined by average 69% between 1970 and 2018 (WWF Living Planet Report). Drivers: habitat destruction (primary driver accounting for approximately 75% of recent extinctions) overexploitation climate change invasive species pollution. Conservation strategies: in situ (protected areas national parks restoration ecology) ex situ (zoos seed banks captive breeding) legislation (CITES IUCN). Evidence for effectiveness: giant panda downlisted from endangered to vulnerable (2016) northern white rhino failed (functionally extinct). Rewilding (reintroducing keystone species) showing promise in some ecosystems.$t$;

UPDATE questions SET
  option_a = $t$Lamarck's theory (1809): organisms acquire characteristics during their lifetime in response to the environment and pass these acquired characteristics to offspring. Classic example: giraffes stretching necks passing longer necks to offspring. Darwin's theory replaced Lamarck's: heritable variation arises from random mutation not from use or disuse. Modern epigenetics has complicated this picture: some epigenetic modifications (DNA methylation histone marks) can be transmitted to offspring in some organisms (transgenerational epigenetic inheritance). Studies in mice show that acquired fear responses and metabolic changes can be transmitted epigenetically for 2-3 generations. This is not classical Lamarckism (it does not involve protein-level acquired traits) but it demonstrates that the environment can influence gene expression across generations via epigenetic mechanisms without DNA sequence changes.$t$
WHERE id = 2826
  AND option_a = $t$Lamarck's theory (1809): organisms acquire characteristics during their lifetime in response to the environment and pass these acquired characteristics to offspring. Classic example: giraffes stretching necks passing longer necks to offspring. Darwin's theory replaced Lamarck's: heritable variation arises from random mutation not from use or disuse. Modern epigenetics has complicated this picture: some epigenetic modifications (DNA methylation histone marks) can be transmitted to offspring in some organisms (transgenerational epigenetic inheritance). Studies in mice show that acquired fear responses and metabolic changes can be transmitted epigenetically for 2–3 generations. This is not classical Lamarckism (it does not involve protein-level acquired traits) but it demonstrates that the environment can influence gene expression across generations via epigenetic mechanisms without DNA sequence changes.$t$;

UPDATE questions SET
  option_c = $t$Antibiotic resistance exemplifies rapid evolution observable within years: MRSA evolved from fully susceptible Staphylococcus aureus within decades of penicillin introduction. CRKP (carbapenem-resistant Klebsiella pneumoniae) evolved resistance to our antibiotics of last resort. The MEGA evolution experiment (Kishony lab 2016) showed E. coli evolving from susceptible to 1000x the lethal concentration of antibiotic in 11 days on a 2-metre gradient plate. This demonstrated stepwise acquisition of resistance mutations under selection. Implications: (1) Clinical: empirical prescribing becoming unreliable requiring culture and sensitivity testing. (2) Public health: global surveillance networks needed. (3) Drug development: new antibiotics needed but return on investment is low (short treatment course vs chronic disease drugs taken lifelong). (4) One Health approach: resistance in agriculture environmental bacteria and human medicine are interconnected.$t$
WHERE id = 2827
  AND option_c = $t$Antibiotic resistance exemplifies rapid evolution observable within years: MRSA evolved from fully susceptible Staphylococcus aureus within decades of penicillin introduction. CRKP (carbapenem-resistant Klebsiella pneumoniae) evolved resistance to our antibiotics of last resort. The MEGA evolution experiment (Kishony lab 2016) showed E. coli evolving from susceptible to 1000× the lethal concentration of antibiotic in 11 days on a 2-metre gradient plate. This demonstrated stepwise acquisition of resistance mutations under selection. Implications: (1) Clinical: empirical prescribing becoming unreliable requiring culture and sensitivity testing. (2) Public health: global surveillance networks needed. (3) Drug development: new antibiotics needed but return on investment is low (short treatment course vs chronic disease drugs taken lifelong). (4) One Health approach: resistance in agriculture environmental bacteria and human medicine are interconnected.$t$;

UPDATE questions SET
  option_b = $t$Gene drives use CRISPR to engineer a genetic element that spreads through a population faster than normal inheritance. In mosquitoes a gene drive could spread a sterility gene through Anopheles populations potentially eliminating or greatly reducing them in malaria-endemic areas. Case for deployment: malaria kills approximately 600,000 people per year mostly children under 5 in sub-Saharan Africa. Eliminating the vector could save millions of lives. Case for caution: ecological risks — Anopheles mosquitoes play roles in food webs and pollination. Irreversibility — once released a gene drive may be impossible to recall. Cross-border spread — cannot be contained within a country. Lack of long-term ecological data. Need for community consent from affected populations particularly in Africa. Regulatory frameworks are not yet adequate.$t$
WHERE id = 2828
  AND option_b = $t$Gene drives use CRISPR to engineer a genetic element that spreads through a population faster than normal inheritance. In mosquitoes a gene drive could spread a sterility gene through Anopheles populations potentially eliminating or greatly reducing them in malaria-endemic areas. Case for deployment: malaria kills approximately 600 000 people per year mostly children under 5 in sub-Saharan Africa. Eliminating the vector could save millions of lives. Case for caution: ecological risks — Anopheles mosquitoes play roles in food webs and pollination. Irreversibility — once released a gene drive may be impossible to recall. Cross-border spread — cannot be contained within a country. Lack of long-term ecological data. Need for community consent from affected populations particularly in Africa. Regulatory frameworks are not yet adequate.$t$;

UPDATE questions SET
  explanation = $t$Beta-carotene in Golden Rice 2: approximately 1.6 micrograms per gram of dry weight. Single serving provides approximately 50-60% of child daily requirement. Study in Chinese schoolchildren showed equivalent efficacy to beta-carotene supplements (Tufts University 2012 — later controversial due to consent issues in study conduct).$t$
WHERE id = 2829
  AND explanation = $t$Beta-carotene in Golden Rice 2: approximately 1.6 micrograms per gram of dry weight. Single serving provides approximately 50–60% of child daily requirement. Study in Chinese schoolchildren showed equivalent efficacy to beta-carotene supplements (Tufts University 2012 — later controversial due to consent issues in study conduct).$t$;

UPDATE questions SET
  option_a = $t$Synthetic biology (synbio) uses engineering principles to design and construct new biological parts systems and organisms. Applications: (1) Industrial: engineered yeast or bacteria producing biofuels (isobutanol farnesene from sugars) biodegradable plastics chemicals replacing petrochemical synthesis. (2) Medical: engineered bacteria sensing and treating disease from within the gut cells producing insulin in situ chimeric antigen receptor (CAR-T) cells. (3) Biomaterials: spider silk proteins biosensors. (4) Environmental: biosensors detecting pollution biosynthetic pathways for sustainable chemistry. Risks: (1) Engineered organisms might escape into the environment with unpredictable ecological effects. (2) Dual use — technologies could theoretically be used to engineer dangerous pathogens. (3) Ethical concerns about creating artificial life. Safeguards: genetic containment (auxotrophy — organisms require non-natural amino acids to survive) kill switches.$t$
WHERE id = 2830
  AND option_a = $t$Synthetic biology (synbio) uses engineering principles to design and construct new biological parts systems and organisms. Applications: (1) Industrial: engineered yeast or bacteria producing biofuels (isobutanol farnesene from sugars) biodegradable plastics chemicals replacing petrochemical synthesis. (2) Medical: engineered bacteria sensing and treating disease from within the gut cells producing insulin in situ chimeric antigen receptor \((CAR - T)\) cells. (3) Biomaterials: spider silk proteins biosensors. (4) Environmental: biosensors detecting pollution biosynthetic pathways for sustainable chemistry. Risks: (1) Engineered organisms might escape into the environment with unpredictable ecological effects. (2) Dual use — technologies could theoretically be used to engineer dangerous pathogens. (3) Ethical concerns about creating artificial life. Safeguards: genetic containment (auxotrophy — organisms require non-natural amino acids to survive) kill switches.$t$;

UPDATE questions SET
  option_a = $t$Altruistic behaviour (helping others at cost to oneself) poses a challenge to natural selection: why would an organism sacrifice fitness for another? Kin selection (Hamilton 1964) provides the answer: genes are shared between relatives. An altruistic act that reduces the individual's fitness but increases the fitness of related individuals can still increase the frequency of shared genes. Hamilton's rule: altruism is favoured when r x B > C where r = coefficient of relatedness B = benefit to recipient C = cost to actor. Example: a worker bee sacrifices reproduction to help the queen produce more offspring. Worker bees share approximately 75% of genes with sisters (due to haplodiploidy in Hymenoptera) so raising sisters propagates more of their genes than direct reproduction would.$t$
WHERE id = 2834
  AND option_a = $t$Altruistic behaviour (helping others at cost to oneself) poses a challenge to natural selection: why would an organism sacrifice fitness for another? Kin selection (Hamilton 1964) provides the answer: genes are shared between relatives. An altruistic act that reduces the individual's fitness but increases the fitness of related individuals can still increase the frequency of shared genes. Hamilton's rule: altruism is favoured when \(r \times B > C\) where \(r\)= coefficient of relatedness B = benefit to recipient C = cost to actor. Example: a worker bee sacrifices reproduction to help the queen produce more offspring. Worker bees share approximately 75% of genes with sisters (due to haplodiploidy in Hymenoptera) so raising sisters propagates more of their genes than direct reproduction would.$t$;

UPDATE questions SET
  explanation = $t$Photosynthesis: CO2 + H2O + light giving glucose + O2 (in chloroplasts). Respiration: glucose + O2 giving CO2 + H2O + ATP (in mitochondria). In bright light photosynthesis rate exceeds respiration rate. At the compensation point they are equal.$t$
WHERE id = 2835
  AND explanation = $t$Photosynthesis: CO₂ + H₂O + light giving glucose + O₂ (in chloroplasts). Respiration: glucose + O₂ giving CO₂ + H₂O + ATP (in mitochondria). In bright light photosynthesis rate exceeds respiration rate. At the compensation point they are equal.$t$;

UPDATE questions SET
  explanation = $t$Word equation: carbon dioxide + water + light energy giving glucose + oxygen. Symbol equation: 6CO2 + 6H2O + light energy giving C6H12O6 + 6O2. CO2 enters via stomata water absorbed by root hair cells.$t$
WHERE id = 2836
  AND explanation = $t$Word equation: carbon dioxide + water + light energy giving glucose + oxygen. Symbol equation: 6CO₂ + 6H₂O + light energy giving C₆H₁₂O₆ + 6O₂. CO₂ enters via stomata water absorbed by root hair cells.$t$;

UPDATE questions SET
  option_c = $t$The leaf is adapted for photosynthesis by: a thin flat shape (maximises surface area for light absorption and CO2 diffusion) transparent waxy cuticle (allows light through prevents excessive water loss) palisade mesophyll cells (tightly packed under the upper surface packed with chloroplasts) spongy mesophyll (air spaces allow CO2 and O2 to diffuse) stomata (pores in the lower epidermis allow gas exchange controlled by guard cells) and veins (xylem delivers water phloem transports sugars).$t$
WHERE id = 2837
  AND option_c = $t$The leaf is adapted for photosynthesis by: a thin flat shape (maximises surface area for light absorption and CO₂ diffusion) transparent waxy cuticle (allows light through prevents excessive water loss) palisade mesophyll cells (tightly packed under the upper surface packed with chloroplasts) spongy mesophyll (air spaces allow CO₂ and O₂ to diffuse) stomata (pores in the lower epidermis allow gas exchange controlled by guard cells) and veins (xylem delivers water phloem transports sugars).$t$;

UPDATE questions SET
  option_a = $t$Guard cells are specialised bean-shaped cells on either side of each stoma. When they absorb water by osmosis they swell and their unusual cell wall structure (thicker on the inner wall facing the pore) causes them to bend opening the pore. Stomata open in light (when photosynthesis requires CO2) when CO2 concentration inside the leaf is low and when temperatures are moderate. They close in darkness during drought conditions or when CO2 levels are high.$t$,
  option_c = $t$Guard cells use active transport to push CO2 out of the leaf forcing stomata open$t$,
  option_d = $t$Stomata are permanently open in all plants because CO2 must always enter$t$,
  explanation = $t$Guard cell mechanism: light triggers H+ pump expelling protons creating negative charge inside. K+ enters by facilitated diffusion water follows by osmosis. Guard cells swell (become turgid) and open the stoma. In drought: abscisic acid (ABA) triggers K+ to leave guard cells lose water and stomata close.$t$
WHERE id = 2838
  AND option_a = $t$Guard cells are specialised bean-shaped cells on either side of each stoma. When they absorb water by osmosis they swell and their unusual cell wall structure (thicker on the inner wall facing the pore) causes them to bend opening the pore. Stomata open in light (when photosynthesis requires CO₂) when CO₂ concentration inside the leaf is low and when temperatures are moderate. They close in darkness during drought conditions or when CO₂ levels are high.$t$
  AND option_c = $t$Guard cells use active transport to push CO₂ out of the leaf forcing stomata open$t$
  AND option_d = $t$Stomata are permanently open in all plants because CO₂ must always enter$t$
  AND explanation = $t$Guard cell mechanism: light triggers H⁺ pump expelling protons creating negative charge inside. K⁺ enters by facilitated diffusion water follows by osmosis. Guard cells swell (become turgid) and open the stoma. In drought: abscisic acid (ABA) triggers K⁺ to leave guard cells lose water and stomata close.$t$;

UPDATE questions SET
  option_b = $t$The light-dependent reactions occur in the thylakoid membranes: light energy is absorbed by chlorophyll and used to split water (photolysis) producing oxygen protons and electrons. The electrons pass along the electron transport chain generating ATP and NADPH. The light-independent reactions (Calvin cycle) occur in the stroma: CO2 is fixed to RuBP (ribulose bisphosphate) by the enzyme rubisco. The resulting compound is reduced using ATP and NADPH from the light-dependent stage to form G3P (glyceraldehyde-3-phosphate) which is used to synthesise glucose and to regenerate RuBP.$t$,
  option_d = $t$The light-dependent reactions occur in the stroma and produce glucose directly from CO2$t$,
  explanation = $t$Light-dependent (thylakoids): photolysis of water O2 released ATP and NADPH produced. Photosystems I and II electron transport chain. Light-independent (stroma): Calvin cycle CO2 + RuBP giving 2x GP (C3) reduced to G3P (NADPH + ATP used) RuBP regenerated. Three CO2 molecules fixed per turn.$t$
WHERE id = 2845
  AND option_b = $t$The light-dependent reactions occur in the thylakoid membranes: light energy is absorbed by chlorophyll and used to split water (photolysis) producing oxygen protons and electrons. The electrons pass along the electron transport chain generating ATP and NADPH. The light-independent reactions (Calvin cycle) occur in the stroma: CO₂ is fixed to RuBP (ribulose bisphosphate) by the enzyme rubisco. The resulting compound is reduced using ATP and NADPH from the light-dependent stage to form \(G3P\) (glyceraldehyde-3-phosphate) which is used to synthesise glucose and to regenerate RuBP.$t$
  AND option_d = $t$The light-dependent reactions occur in the stroma and produce glucose directly from CO₂$t$
  AND explanation = $t$Light-dependent (thylakoids): photolysis of water O₂ released ATP and NADPH produced. Photosystems I and II electron transport chain. Light-independent (stroma): Calvin cycle CO₂ + RuBP giving \(2x GP\) (C3) reduced to \(G3P\) (NADPH + ATP used) RuBP regenerated. Three CO₂ molecules fixed per turn.$t$;

UPDATE questions SET
  option_b = $t$Only light intensity limits photosynthesis — CO2 and temperature have no effect$t$,
  option_d = $t$The main limiting factors are: light intensity CO2 concentration and temperature. At any given moment the factor in shortest supply limits the rate. If light intensity is increased when CO2 is limiting more light cannot increase rate further. At high light and CO2 concentration temperature becomes limiting (enzyme activity of rubisco and other enzymes). In greenhouses: supplemental CO2 (0.1-0.2%) elevated temperature (25-30 degrees C) and supplemental lighting can all increase crop yields because all three factors are optimised simultaneously. Above the optimum temperature rate decreases as enzymes denature.$t$,
  explanation = $t$Blackman's law of limiting factors: rate of a process is limited by the single factor present at the lowest (most limiting) level. Light response curve: linear region (light-limited) then plateau (CO2 or temperature limited). CO2 concentration in natural air approximately 0.04% is often limiting.$t$
WHERE id = 2847
  AND option_b = $t$Only light intensity limits photosynthesis — CO₂ and temperature have no effect$t$
  AND option_d = $t$The main limiting factors are: light intensity CO₂ concentration and temperature. At any given moment the factor in shortest supply limits the rate. If light intensity is increased when CO₂ is limiting more light cannot increase rate further. At high light and CO₂ concentration temperature becomes limiting (enzyme activity of rubisco and other enzymes). In greenhouses: supplemental CO₂ (0.1–0.2%) elevated temperature (25–30 degrees C) and supplemental lighting can all increase crop yields because all three factors are optimised simultaneously. Above the optimum temperature rate decreases as enzymes denature.$t$
  AND explanation = $t$Blackman's law of limiting factors: rate of a process is limited by the single factor present at the lowest (most limiting) level. Light response curve: linear region (light-limited) then plateau (CO₂ or temperature limited). CO₂ concentration in natural air approximately 0.04% is often limiting.$t$;

UPDATE questions SET
  explanation = $t$Evidence for pressure-flow (Munch 1930): aphid stylet experiments (aphids feed on phloem sap confirming pressure and sucrose content) and phloem transport velocities (approximately 30-150 cm/hour consistent with mass flow not diffusion). Companion cells: actively load sucrose into sieve tubes requiring mitochondria and ATP.$t$
WHERE id = 2848
  AND explanation = $t$Evidence for pressure-flow (Munch 1930): aphid stylet experiments (aphids feed on phloem sap confirming pressure and sucrose content) and phloem transport velocities (approximately 30–150 cm/hour consistent with mass flow not diffusion). Companion cells: actively load sucrose into sieve tubes requiring mitochondria and ATP.$t$;

UPDATE questions SET
  option_c = $t$Ethylene (a gas) is a plant hormone produced by many tissues particularly ripening fruit wounded tissue and in response to stress. Roles: promotes fruit ripening (stimulates softening starch-to-sugar conversion colour change) promotes leaf abscission (falling) promotes flowering in some plants promotes senescence (aging). Commercial applications: (1) Harvesting bananas green then treating with ethylene to ripen them uniformly after transport — prevents bruising during shipping. (2) Storing apples in modified atmospheres with reduced O2 and CO2 and ethylene scrubbers — delays ripening and extends shelf life significantly.$t$
WHERE id = 2851
  AND option_c = $t$Ethylene (a gas) is a plant hormone produced by many tissues particularly ripening fruit wounded tissue and in response to stress. Roles: promotes fruit ripening (stimulates softening starch-to-sugar conversion colour change) promotes leaf abscission (falling) promotes flowering in some plants promotes senescence (aging). Commercial applications: (1) Harvesting bananas green then treating with ethylene to ripen them uniformly after transport — prevents bruising during shipping. (2) Storing apples in modified atmospheres with reduced O₂ and CO₂ and ethylene scrubbers — delays ripening and extends shelf life significantly.$t$;

UPDATE questions SET
  question_text = $t$A student measures transpiration rate using a potometer at different temperatures. Results: 15 degrees C = 2 mm/min 25 degrees C = 5 mm/min 35 degrees C = 9 mm/min. Describe the pattern and explain the results using biological principles.$t$,
  option_d = $t$The data shows that transpiration rate increases with temperature. At 15 degrees C rate is 2 mm/min at 25 degrees C it is 5 mm/min (2.5x higher) and at 35 degrees C it is 9 mm/min (4.5x higher). The relationship is non-linear — rate increases more steeply at higher temperatures. Explanation: higher temperature increases the kinetic energy of water molecules increasing the rate of evaporation from spongy mesophyll cells. Higher temperatures also decrease the humidity of the air surrounding the leaf (if humidity is not controlled) increasing the water vapour concentration gradient and therefore increasing diffusion rate. The non-linear relationship reflects that evaporation rate increases exponentially with temperature (Clausius-Clapeyron relationship).$t$
WHERE id = 2852
  AND question_text = $t$A student measures transpiration rate using a potometer at different temperatures. Results: 15 degrees \(C = 2\,\text{mm/min}\) 25 degrees \(C = 5\,\text{mm/min}\) 35 degrees \(C = 9\,\text{mm/min}\). Describe the pattern and explain the results using biological principles.$t$
  AND option_d = $t$The data shows that transpiration rate increases with temperature. At 15 degrees C rate is \(2\,\text{mm/min}\) at 25 degrees C it is \(5\,\text{mm/min}\) (2.5× higher) and at 35 degrees C it is \(9\,\text{mm/min}\) (4.5× higher). The relationship is non-linear — rate increases more steeply at higher temperatures. Explanation: higher temperature increases the kinetic energy of water molecules increasing the rate of evaporation from spongy mesophyll cells. Higher temperatures also decrease the humidity of the air surrounding the leaf (if humidity is not controlled) increasing the water vapour concentration gradient and therefore increasing diffusion rate. The non-linear relationship reflects that evaporation rate increases exponentially with temperature (Clausius-Clapeyron relationship).$t$;

UPDATE questions SET
  option_b = $t$In most dicotyledonous plants stomata are predominantly or exclusively on the lower epidermis (abaxial surface). The lower surface is shaded from direct sunlight so it is cooler and more humid — reducing water loss by transpiration compared to the upper surface. The upper epidermis has a thicker waxy cuticle and fewer or no stomata. This reduces evaporative water loss while still allowing CO2 entry for photosynthesis. Plants in arid environments (e.g. cacti) may have stomata in pits (sunken stomata) or reduced numbers. Aquatic plant leaves often have stomata only on the upper surface (to access air).$t$,
  explanation = $t$Typical dicot leaf: 100-300 stomata per mm2 on lower surface fewer on upper. Xerophytes: sunken stomata (creates humid microenvironment reducing gradient) thick cuticle fewer stomata rolled leaves (reduce surface area). Marram grass: can roll leaf blade enclosing stomata in a humid cavity.$t$
WHERE id = 2854
  AND option_b = $t$In most dicotyledonous plants stomata are predominantly or exclusively on the lower epidermis (abaxial surface). The lower surface is shaded from direct sunlight so it is cooler and more humid — reducing water loss by transpiration compared to the upper surface. The upper epidermis has a thicker waxy cuticle and fewer or no stomata. This reduces evaporative water loss while still allowing CO₂ entry for photosynthesis. Plants in arid environments (e.g. cacti) may have stomata in pits (sunken stomata) or reduced numbers. Aquatic plant leaves often have stomata only on the upper surface (to access air).$t$
  AND explanation = $t$Typical dicot leaf: 100–300 stomata per \(mm^{2}\) on lower surface fewer on upper. Xerophytes: sunken stomata (creates humid microenvironment reducing gradient) thick cuticle fewer stomata rolled leaves (reduce surface area). Marram grass: can roll leaf blade enclosing stomata in a humid cavity.$t$;

UPDATE questions SET
  option_a = $t$Electrons begin at Photosystem II (PSII) where light energy boosts electrons to a high energy state. These electrons pass down the electron transport chain (plastoquinone cytochrome b6f complex plastocyanin) losing energy that is used to pump protons across the thylakoid membrane creating a proton gradient. This gradient drives ATP synthase (chemiosmosis) producing ATP. Electrons reach Photosystem I (PSI) where light boosts them again. These high-energy electrons reduce NADP+ to NADPH using ferredoxin and NADP+ reductase. Water is split at PSII (photolysis) releasing O2 and providing replacement electrons.$t$,
  explanation = $t$Z-scheme: PSII absorbs 680 nm light PSI absorbs 700 nm light. Cyclic photophosphorylation: electrons from PSI cycle back through the ETC producing more ATP but no NADPH no water splitting. Non-cyclic: both PSI and PSII involved water split O2 released ATP and NADPH produced.$t$
WHERE id = 2855
  AND option_a = $t$Electrons begin at Photosystem II (PSII) where light energy boosts electrons to a high energy state. These electrons pass down the electron transport chain (plastoquinone cytochrome \(b6f\) complex plastocyanin) losing energy that is used to pump protons across the thylakoid membrane creating a proton gradient. This gradient drives ATP synthase (chemiosmosis) producing ATP. Electrons reach Photosystem I (PSI) where light boosts them again. These high-energy electrons reduce NADP+ to NADPH using ferredoxin and NADP+ reductase. Water is split at PSII (photolysis) releasing O₂ and providing replacement electrons.$t$
  AND explanation = $t$Z-scheme: PSII absorbs 680 nm light PSI absorbs 700 nm light. Cyclic photophosphorylation: electrons from PSI cycle back through the ETC producing more ATP but no NADPH no water splitting. Non-cyclic: both PSI and PSII involved water split O₂ released ATP and NADPH produced.$t$;

UPDATE questions SET
  explanation = $t$Phytochrome discovery: Sterling Hendricks Harold Borthwick 1950s. Night-break experiment: brief red light pulse interrupts long night preventing short-day plant flowering. Far-red light after red reverses the effect (converts Pfr back to Pr). Used in horticulture to control flowering of chrysanthemums and poinsettias using supplemental lighting.$t$
WHERE id = 2857
  AND explanation = $t$Phytochrome discovery: Sterling Hendricks Harold Borthwick \(1950s\). Night-break experiment: brief red light pulse interrupts long night preventing short-day plant flowering. Far-red light after red reverses the effect (converts Pfr back to Pr). Used in horticulture to control flowering of chrysanthemums and poinsettias using supplemental lighting.$t$;

UPDATE questions SET
  option_d = $t$ABA (abscisic acid) is produced when plants experience water stress drought or other stressors. In guard cells: ABA binds to receptors (PYR/PYL/RCAR) activating a signalling cascade that opens anion channels allowing Cl- and malate to leave the guard cell. The resulting loss of negative charge opens K+ outward channels allowing K+ to leave. Loss of solutes decreases osmotic pressure water leaves by osmosis guard cells lose turgor and the stomata close — reducing water loss. ABA also promotes seed dormancy and inhibits germination until conditions are favourable.$t$,
  explanation = $t$ABA signalling pathway: ABA + PYR/PYL receptor inhibits PP2C (protein phosphatase) which normally inhibits SnRK2 kinase. SnRK2 activates SLAC1 (slow anion channel) anion efflux membrane depolarisation K+ efflux water loss stomatal closure. Rapid response (minutes) vital for drought survival.$t$
WHERE id = 2858
  AND option_d = $t$ABA (abscisic acid) is produced when plants experience water stress drought or other stressors. In guard cells: ABA binds to receptors (PYR/PYL/RCAR) activating a signalling cascade that opens anion channels allowing Cl⁻ and malate to leave the guard cell. The resulting loss of negative charge opens K⁺ outward channels allowing K⁺ to leave. Loss of solutes decreases osmotic pressure water leaves by osmosis guard cells lose turgor and the stomata close — reducing water loss. ABA also promotes seed dormancy and inhibits germination until conditions are favourable.$t$
  AND explanation = $t$ABA signalling pathway: ABA + PYR/PYL receptor inhibits PP2C (protein phosphatase) which normally inhibits SnRK2 kinase. SnRK2 activates SLAC1 (slow anion channel) anion efflux membrane depolarisation K⁺ efflux water loss stomatal closure. Rapid response (minutes) vital for drought survival.$t$;

UPDATE questions SET
  question_text = $t$A researcher investigates the rate of photosynthesis in aquatic plants using a hydrogen carbonate indicator solution which changes from red (neutral) to yellow (acid) when CO2 increases and purple (alkaline) when CO2 decreases. Predict the colour changes at different distances from a light source and at different temperatures.$t$,
  option_a = $t$The indicator stays red at all distances because CO2 concentration is always at equilibrium$t$,
  option_b = $t$The indicator turns yellow at all distances because plants always produce more CO2 than they absorb$t$,
  option_c = $t$Close to light source: photosynthesis rate exceeds respiration rate. CO2 is consumed faster than it is produced. CO2 concentration falls. Indicator turns purple (alkaline — bicarbonate forms alkaline solution as CO2 is removed). Far from light source (low intensity): respiration rate exceeds photosynthesis rate. CO2 is produced faster than consumed. CO2 rises. Indicator turns yellow (acidic). At intermediate distance (compensation point): photosynthesis rate = respiration rate. No net change in CO2. Indicator stays red. At high temperature (above optimum): enzyme activity decreases reducing photosynthesis rate. Even at close distance indicator may not turn purple or may turn yellow if enzymes are denatured.$t$,
  explanation = $t$DCPIP indicator or hydrogen carbonate indicator: used in photosynthesis practicals. Compensation point: the light intensity at which gross photosynthesis = respiration rate. Net O2 exchange = 0. Below compensation point: net CO2 release. Above: net CO2 uptake.$t$
WHERE id = 2859
  AND question_text = $t$A researcher investigates the rate of photosynthesis in aquatic plants using a hydrogen carbonate indicator solution which changes from red (neutral) to yellow (acid) when CO₂ increases and purple (alkaline) when CO₂ decreases. Predict the colour changes at different distances from a light source and at different temperatures.$t$
  AND option_a = $t$The indicator stays red at all distances because CO₂ concentration is always at equilibrium$t$
  AND option_b = $t$The indicator turns yellow at all distances because plants always produce more CO₂ than they absorb$t$
  AND option_c = $t$Close to light source: photosynthesis rate exceeds respiration rate. CO₂ is consumed faster than it is produced. CO₂ concentration falls. Indicator turns purple (alkaline — bicarbonate forms alkaline solution as CO₂ is removed). Far from light source (low intensity): respiration rate exceeds photosynthesis rate. CO₂ is produced faster than consumed. CO₂ rises. Indicator turns yellow (acidic). At intermediate distance (compensation point): photosynthesis rate = respiration rate. No net change in CO₂. Indicator stays red. At high temperature (above optimum): enzyme activity decreases reducing photosynthesis rate. Even at close distance indicator may not turn purple or may turn yellow if enzymes are denatured.$t$
  AND explanation = $t$DCPIP indicator or hydrogen carbonate indicator: used in photosynthesis practicals. Compensation point: the light intensity at which gross photosynthesis = respiration rate. Net O₂ exchange \(= 0\). Below compensation point: net CO₂ release. Above: net CO₂ uptake.$t$;

UPDATE questions SET
  option_b = $t$C3 plants (most plants): CO2 fixed directly to RuBP by rubisco producing a 3-carbon compound (3-PGA). Problem: rubisco has oxygenase activity (photorespiration) which wastes energy particularly at high temperatures. C4 plants (maize sugarcane tropical grasses): CO2 first fixed in mesophyll cells to a 4-carbon compound (OAA) which travels to bundle sheath cells where CO2 is released and concentrated around rubisco. The high CO2 concentration suppresses photorespiration. Adapted to hot sunny environments. CAM plants (cacti succulents): stomata open only at night to fix CO2 into malic acid. In the day stomata close (reducing water loss) and the stored CO2 is released for the Calvin cycle. Adapted to hot dry environments.$t$,
  explanation = $t$C4 advantages: at temperatures above approximately 25-30 degrees C suppressed photorespiration makes C4 net photosynthesis more efficient than C3. At lower temperatures C3 is equally or more efficient. Maize (C4) has higher water use efficiency and yield potential than wheat (C3) in tropical conditions. CAM: extreme water use efficiency at cost of slow growth.$t$
WHERE id = 2861
  AND option_b = $t$C3 plants (most plants): CO₂ fixed directly to RuBP by rubisco producing a 3-carbon compound (3-PGA). Problem: rubisco has oxygenase activity (photorespiration) which wastes energy particularly at high temperatures. C4 plants (maize sugarcane tropical grasses): CO₂ first fixed in mesophyll cells to a 4-carbon compound (OAA) which travels to bundle sheath cells where CO₂ is released and concentrated around rubisco. The high CO₂ concentration suppresses photorespiration. Adapted to hot sunny environments. CAM plants (cacti succulents): stomata open only at night to fix CO₂ into malic acid. In the day stomata close (reducing water loss) and the stored CO₂ is released for the Calvin cycle. Adapted to hot dry environments.$t$
  AND explanation = $t$C4 advantages: at temperatures above approximately 25–30 degrees C suppressed photorespiration makes C4 net photosynthesis more efficient than C3. At lower temperatures C3 is equally or more efficient. Maize (C4) has higher water use efficiency and yield potential than wheat (C3) in tropical conditions. CAM: extreme water use efficiency at cost of slow growth.$t$;

UPDATE questions SET
  option_b = $t$Benefits: (1) Ethylene and ethylene inhibitors (1-MCP): coordinate harvesting and extend post-harvest shelf life reducing food waste. (2) Gibberellins: increase fruit size (grapes) accelerate malting (barley) break seed dormancy allowing earlier planting. (3) Auxin-based herbicides (2,4-D MCPA): selective weed killers that mimic auxin at toxic concentrations in broadleaved plants but not cereals. (4) Synthetic cytokinins: delay leaf senescence in cut flowers. Environmental concerns: synthetic auxin herbicides (2,4-D was a component of Agent Orange though 2,4-D alone is approved) can affect non-target plants through spray drift. Ethephon (releases ethylene) may have non-target effects on wildlife. Some PGRs are persistent in soil. However most approved PGRs have regulatory approval based on risk assessment and are used at very low concentrations.$t$,
  explanation = $t$2,4-D: one of the most widely used herbicides. Selective for dicots (broadleaved weeds) safe for monocot cereals because dicots have more auxin-responsive cells. Agent Orange controversy: was 50:50 mixture of 2,4-D and 2,4,5-T (contaminated with dioxin). 2,4-D alone does not contain dioxin and remains approved.$t$
WHERE id = 2864
  AND option_b = $t$Benefits: (1) Ethylene and ethylene inhibitors (1-MCP): coordinate harvesting and extend post-harvest shelf life reducing food waste. (2) Gibberellins: increase fruit size (grapes) accelerate malting (barley) break seed dormancy allowing earlier planting. (3) Auxin-based herbicides \((2,\ 4 - D MCPA)\): selective weed killers that mimic auxin at toxic concentrations in broadleaved plants but not cereals. (4) Synthetic cytokinins: delay leaf senescence in cut flowers. Environmental concerns: synthetic auxin herbicides (\(2,\ 4 - D\) was a component of Agent Orange though 2,\(4 - D\) alone is approved) can affect non-target plants through spray drift. Ethephon (releases ethylene) may have non-target effects on wildlife. Some PGRs are persistent in soil. However most approved PGRs have regulatory approval based on risk assessment and are used at very low concentrations.$t$
  AND explanation = $t$2,\(4 - D\): one of the most widely used herbicides. Selective for dicots (broadleaved weeds) safe for monocot cereals because dicots have more auxin-responsive cells. Agent Orange controversy: was \(50 : 50\) mixture of 2,\(4 - D\) and 2,4,\(5 - T\) (contaminated with dioxin). 2,\(4 - D\) alone does not contain dioxin and remains approved.$t$;

UPDATE questions SET
  option_d = $t$An ecosystem is a community of living organisms (biotic component) interacting with each other and with their non-living environment (abiotic component) in a particular area. Biotic components: all living organisms — producers consumers decomposers. Abiotic components: physical and chemical factors — temperature light intensity soil pH water availability CO2 concentration mineral availability.$t$
WHERE id = 2865
  AND option_d = $t$An ecosystem is a community of living organisms (biotic component) interacting with each other and with their non-living environment (abiotic component) in a particular area. Biotic components: all living organisms — producers consumers decomposers. Abiotic components: physical and chemical factors — temperature light intensity soil pH water availability CO₂ concentration mineral availability.$t$;

UPDATE questions SET
  explanation = $t$Food chain example: grass --> rabbit --> fox --> eagle. Food web: includes grass rabbit fox eagle plus hare mouse vole buzzard with multiple connections. Keystone species: species whose removal disproportionately affects the food web structure (e.g. sea otter removal leads to urchin population explosion and kelp forest destruction).$t$
WHERE id = 2866
  AND explanation = $t$Food chain example: grass --> rabbit \(- - > fox - - > \text{eagle}\). Food web: includes grass rabbit fox eagle plus hare mouse vole buzzard with multiple connections. Keystone species: species whose removal disproportionately affects the food web structure (e.g. sea otter removal leads to urchin population explosion and kelp forest destruction).$t$;

UPDATE questions SET
  option_c = $t$Only approximately 10% of energy at each trophic level is transferred to the next. Energy is lost because: organisms use energy for respiration (maintaining body temperature movement growth repair); some biomass is not eaten (bones shells roots); some eaten material is not digested and is lost in faeces; energy is lost as heat from metabolic processes. Because so little energy transfers at each level there is insufficient energy to support organisms at many trophic levels — typically no more than 4-5 links in a food chain.$t$,
  explanation = $t$Ecological efficiency approximately 10% (range 5-20%). Example: 10,000 kJ at producers gives 1,000 kJ at primary consumers gives 100 kJ at secondary consumers gives 10 kJ at tertiary consumers. Pyramid of energy: shows actual energy flow. Always a true pyramid (unlike pyramids of numbers or biomass).$t$
WHERE id = 2867
  AND option_c = $t$Only approximately 10% of energy at each trophic level is transferred to the next. Energy is lost because: organisms use energy for respiration (maintaining body temperature movement growth repair); some biomass is not eaten (bones shells roots); some eaten material is not digested and is lost in faeces; energy is lost as heat from metabolic processes. Because so little energy transfers at each level there is insufficient energy to support organisms at many trophic levels — typically no more than 4–5 links in a food chain.$t$
  AND explanation = $t$Ecological efficiency approximately 10% (range 5–20%). Example: 10 000 kJ at producers gives 1 000 kJ at primary consumers gives 100 kJ at secondary consumers gives 10 kJ at tertiary consumers. Pyramid of energy: shows actual energy flow. Always a true pyramid (unlike pyramids of numbers or biomass).$t$;

UPDATE questions SET
  explanation = $t$Decomposers: bacteria (aerobic and anaerobic) and fungi (saprotrophic — secrete enzymes onto dead material and absorb the products). Role in nutrient cycling: mineralisation converts organic N to NH4+ (ammonium) which can then be nitrified or absorbed by plants. Detritivores (earthworms woodlice) physically break down organic matter increasing surface area for decomposers.$t$
WHERE id = 2868
  AND explanation = $t$Decomposers: bacteria (aerobic and anaerobic) and fungi (saprotrophic — secrete enzymes onto dead material and absorb the products). Role in nutrient cycling: mineralisation converts organic N to NH₄⁺ (ammonium) which can then be nitrified or absorbed by plants. Detritivores (earthworms woodlice) physically break down organic matter increasing surface area for decomposers.$t$;

UPDATE questions SET
  option_c = $t$Carbon cycles through the following processes: photosynthesis (CO2 removed from atmosphere fixed as organic carbon in producers) respiration (organic carbon oxidised back to CO2 by all organisms) feeding (carbon passes from producers to consumers along food chains) decomposition (decomposers release CO2 from dead organic matter) combustion (burning fossil fuels releases ancient carbon rapidly) and fossilisation (carbon locked in fossil fuels and limestone over millions of years).$t$,
  explanation = $t$Carbon reservoirs: atmosphere (CO2 CH4) biosphere (living biomass) soil organic matter ocean (dissolved CO2 marine organisms) lithosphere (fossil fuels limestone). Human activities: burning fossil fuels deforestation cement production have increased atmospheric CO2 from 280 ppm (pre-industrial) to over 420 ppm (2024).$t$
WHERE id = 2869
  AND option_c = $t$Carbon cycles through the following processes: photosynthesis (CO₂ removed from atmosphere fixed as organic carbon in producers) respiration (organic carbon oxidised back to CO₂ by all organisms) feeding (carbon passes from producers to consumers along food chains) decomposition (decomposers release CO₂ from dead organic matter) combustion (burning fossil fuels releases ancient carbon rapidly) and fossilisation (carbon locked in fossil fuels and limestone over millions of years).$t$
  AND explanation = $t$Carbon reservoirs: atmosphere (CO₂ CH₄) biosphere (living biomass) soil organic matter ocean (dissolved CO₂ marine organisms) lithosphere (fossil fuels limestone). Human activities: burning fossil fuels deforestation cement production have increased atmospheric CO₂ from 280 ppm (pre-industrial) to over 420 ppm (2024).$t$;

UPDATE questions SET
  option_a = $t$The nitrogen cycle describes the movement of nitrogen through ecosystems. Key processes: (1) Nitrogen fixation — bacteria (Rhizobium in root nodules and free-living Azotobacter) convert atmospheric N2 to ammonia (NH3/NH4+) available to plants. (2) Nitrification — nitrifying bacteria convert ammonia to nitrite then nitrate (usable form for plants). (3) Uptake — plants absorb nitrate and ammonium and incorporate nitrogen into proteins. (4) Decomposition — decomposers break down dead organisms releasing ammonia. (5) Denitrification — denitrifying bacteria convert nitrate back to N2 in anaerobic conditions.$t$,
  explanation = $t$Nitrogen fixation: N2 + 8H+ + 8e- + 16ATP giving 2NH3 + H2 + 16ADP + 16Pi. Catalysed by nitrogenase enzyme (oxygen-sensitive). Rhizobium infects legume roots forming nodules provides NH3 to plant receives carbohydrates from plant. Haber process: industrial N fixation for fertilisers.$t$
WHERE id = 2870
  AND option_a = $t$The nitrogen cycle describes the movement of nitrogen through ecosystems. Key processes: (1) Nitrogen fixation — bacteria (Rhizobium in root nodules and free-living Azotobacter) convert atmospheric N₂ to ammonia (NH₃/NH₄⁺) available to plants. (2) Nitrification — nitrifying bacteria convert ammonia to nitrite then nitrate (usable form for plants). (3) Uptake — plants absorb nitrate and ammonium and incorporate nitrogen into proteins. (4) Decomposition — decomposers break down dead organisms releasing ammonia. (5) Denitrification — denitrifying bacteria convert nitrate back to N₂ in anaerobic conditions.$t$
  AND explanation = $t$Nitrogen fixation: N₂ + 8H⁺ + 8e⁻ \(+ 16ATP\) giving 2NH₃ + H₂ \(+ 16ADP + 16\)Pi. Catalysed by nitrogenase enzyme (oxygen-sensitive). Rhizobium infects legume roots forming nodules provides NH₃ to plant receives carbohydrates from plant. Haber process: industrial N fixation for fertilisers.$t$;

UPDATE questions SET
  option_c = $t$Human activities generally reduce biodiversity through: (1) Habitat destruction — deforestation conversion of natural habitats to agriculture reduces species richness. Example: tropical deforestation destroys the most biodiverse habitats on Earth losing perhaps 50,000 species per year. (2) Pollution — oil spills pesticides eutrophication from agricultural fertilisers kill species and reduce diversity. (3) Overexploitation — overfishing and hunting drive species toward extinction (Atlantic cod northern white rhino). (4) Invasive species — deliberately or accidentally introduced species can outcompete native species.$t$,
  explanation = $t$HIPPO acronym: Habitat destruction Invasive species Pollution Population growth (human) Overexploitation — the main drivers of biodiversity loss. Sixth mass extinction: current extinction rate 100-1000x background rate.$t$
WHERE id = 2872
  AND option_c = $t$Human activities generally reduce biodiversity through: (1) Habitat destruction — deforestation conversion of natural habitats to agriculture reduces species richness. Example: tropical deforestation destroys the most biodiverse habitats on Earth losing perhaps 50 000 species per year. (2) Pollution — oil spills pesticides eutrophication from agricultural fertilisers kill species and reduce diversity. (3) Overexploitation — overfishing and hunting drive species toward extinction (Atlantic cod northern white rhino). (4) Invasive species — deliberately or accidentally introduced species can outcompete native species.$t$
  AND explanation = $t$HIPPO acronym: Habitat destruction Invasive species Pollution Population growth (human) Overexploitation — the main drivers of biodiversity loss. Sixth mass extinction: current extinction rate 100–1000× background rate.$t$;

UPDATE questions SET
  explanation = $t$Eutrophication: nitrate + phosphate input algal bloom light blocked submerged plants die algae die bacteria decompose algae using O2 oxygen falls BOD rises fish die. Sources: agricultural fertiliser runoff (diffuse) sewage effluent (point source). Solutions: buffer strips reducing fertiliser application phosphate stripping in sewage treatment.$t$
WHERE id = 2873
  AND explanation = $t$Eutrophication: nitrate + phosphate input algal bloom light blocked submerged plants die algae die bacteria decompose algae using O₂ oxygen falls BOD rises fish die. Sources: agricultural fertiliser runoff (diffuse) sewage effluent (point source). Solutions: buffer strips reducing fertiliser application phosphate stripping in sewage treatment.$t$;

UPDATE questions SET
  option_b = $t$Nitrification: two groups of bacteria convert ammonia to nitrate in aerobic soil. Nitrosomonas (and related genera) oxidises NH4+ to NO2- (nitrite). Nitrobacter (and related genera) oxidises NO2- to NO3- (nitrate). Both are chemoautotrophs gaining energy from these oxidation reactions. Denitrification: anaerobic bacteria (Pseudomonas Paracoccus) in waterlogged anaerobic soil reduce NO3- back to N2 (or N2O) releasing nitrogen gas back to the atmosphere. This can reduce soil fertility by removing fixed nitrogen.$t$,
  option_d = $t$Nitrification converts N2 to ammonia and denitrification converts ammonia to N2$t$,
  explanation = $t$Nitrification: NH4+ to NO2- (Nitrosomonas) then NO2- to NO3- (Nitrobacter). Aerobic process generates ATP for chemoautotrophs. Denitrification: NO3- to N2O to N2 (Pseudomonas Paracoccus). Anaerobic. Reduces bioavailable nitrogen. Agricultural implication: waterlogged soils lose more nitrogen by denitrification.$t$
WHERE id = 2875
  AND option_b = $t$Nitrification: two groups of bacteria convert ammonia to nitrate in aerobic soil. Nitrosomonas (and related genera) oxidises NH₄⁺ to NO₂⁻ (nitrite). Nitrobacter (and related genera) oxidises NO₂⁻ to NO₃⁻ (nitrate). Both are chemoautotrophs gaining energy from these oxidation reactions. Denitrification: anaerobic bacteria (Pseudomonas Paracoccus) in waterlogged anaerobic soil reduce NO₃⁻ back to N₂ (or \(N2O\)) releasing nitrogen gas back to the atmosphere. This can reduce soil fertility by removing fixed nitrogen.$t$
  AND option_d = $t$Nitrification converts N₂ to ammonia and denitrification converts ammonia to N₂$t$
  AND explanation = $t$Nitrification: NH₄⁺ to NO₂⁻ (Nitrosomonas) then NO₂⁻ to NO₃⁻ (Nitrobacter). Aerobic process generates ATP for chemoautotrophs. Denitrification: NO₃⁻ to \(N2O\) to N₂ (Pseudomonas Paracoccus). Anaerobic. Reduces bioavailable nitrogen. Agricultural implication: waterlogged soils lose more nitrogen by denitrification.$t$;

UPDATE questions SET
  option_c = $t$Energy enters ecosystems through photosynthesis (primary productivity). Not all gross primary production (GPP) is available for growth — plants use approximately 50% for respiration (net primary productivity = GPP - respiration). When herbivores consume plants: some plant biomass is not eaten some eaten material is not digested (faeces) some assimilated energy is lost to respiration. Only assimilation minus respiration = production is available for the next trophic level. Example: if grass produces 10,000 kJ and rabbits assimilate 1,500 kJ: efficiency = 1500/10,000 = 15%.$t$,
  explanation = $t$GPP = gross primary production (total photosynthesis). NPP = GPP - plant respiration = energy available to herbivores. Trophic efficiency: typically 5-20% (10% rule of thumb). Secondary production: energy incorporated into animal biomass. Assimilation efficiency = assimilation/ingestion. Production efficiency = production/assimilation.$t$
WHERE id = 2876
  AND option_c = $t$Energy enters ecosystems through photosynthesis (primary productivity). Not all gross primary production (GPP) is available for growth — plants use approximately 50% for respiration (net primary productivity \(= GPP\)- respiration). When herbivores consume plants: some plant biomass is not eaten some eaten material is not digested (faeces) some assimilated energy is lost to respiration. Only assimilation minus respiration = production is available for the next trophic level. Example: if grass produces 10 000 kJ and rabbits assimilate 1 500 kJ: efficiency \(= \frac{1500}{10\,000} = 15\%\).$t$
  AND explanation = $t$GPP = gross primary production (total photosynthesis). \(NPP = GPP\)- plant respiration = energy available to herbivores. Trophic efficiency: typically 5–20% (10% rule of thumb). Secondary production: energy incorporated into animal biomass. Assimilation efficiency = assimilation/ingestion. Production efficiency = production/assimilation.$t$;

UPDATE questions SET
  option_d = $t$Species diversity considers both the number of species (species richness) and the relative abundance of each species (evenness). A habitat with 100 species all at similar abundance has higher diversity than one with 100 species where 99% of individuals belong to one species. Simpson's Diversity Index: D = 1 - sum(n(n-1)/(N(N-1))) where n = number of individuals of each species and N = total individuals. D ranges from 0 (no diversity) to 1 (maximum diversity). Higher D indicates a more diverse stable ecosystem.$t$,
  explanation = $t$Shannon diversity index H = -sum(pi ln pi) where pi = proportion of individuals belonging to species i. High H = high diversity and evenness. Simpson's D: more weight to dominant species. Practical application: comparing managed vs unmanaged grassland heathland vs intensive farmland.$t$
WHERE id = 2877
  AND option_d = $t$Species diversity considers both the number of species (species richness) and the relative abundance of each species (evenness). A habitat with 100 species all at similar abundance has higher diversity than one with 100 species where 99% of individuals belong to one species. Simpson's Diversity Index: \(D = 1 - sum(\frac{n(n - 1)}{N(N - 1)})\) where \(n\)= number of individuals of each species and N = total individuals. D ranges from 0 (no diversity) to 1 (maximum diversity). Higher D indicates a more diverse stable ecosystem.$t$
  AND explanation = $t$Shannon diversity index \(H = - sum(\pi \ln \pi)\) where \(\pi\)= proportion of individuals belonging to species i. High H = high diversity and evenness. Simpson's D: more weight to dominant species. Practical application: comparing managed vs unmanaged grassland heathland vs intensive farmland.$t$;

UPDATE questions SET
  explanation = $t$Amazon forest: approximately 50% of its own rainfall is self-generated through transpiration. Deforestation causes a positive feedback: less forest less transpiration less rainfall less forest regrowth. Amazon tipping point: some scientists estimate that at 20-25% deforestation the Amazon may transition from rainforest to savanna.$t$
WHERE id = 2879
  AND explanation = $t$Amazon forest: approximately 50% of its own rainfall is self-generated through transpiration. Deforestation causes a positive feedback: less forest less transpiration less rainfall less forest regrowth. Amazon tipping point: some scientists estimate that at 20–25% deforestation the Amazon may transition from rainforest to savanna.$t$;

UPDATE questions SET
  option_a = $t$Intensive farming (maximising yield per hectare): uses high pesticide inputs reducing insect diversity removing food sources for birds hedgerow removal destroying habitat loss of field margins wild flower strips creating monocultures with low plant diversity drainage of wetlands eliminating habitats application of fertilisers causing eutrophication in waterways. Extensive farming (traditional mixed farming or organic farming): maintains hedgerows and field margins retains wildflower-rich grasslands uses reduced pesticides tolerates some pest species providing prey for predators. Biodiversity significantly higher in extensively farmed landscapes than intensively farmed ones. The intensification of UK agriculture since the 1970s has caused approximately 55% decline in farmland bird populations.$t$
WHERE id = 2880
  AND option_a = $t$Intensive farming (maximising yield per hectare): uses high pesticide inputs reducing insect diversity removing food sources for birds hedgerow removal destroying habitat loss of field margins wild flower strips creating monocultures with low plant diversity drainage of wetlands eliminating habitats application of fertilisers causing eutrophication in waterways. Extensive farming (traditional mixed farming or organic farming): maintains hedgerows and field margins retains wildflower-rich grasslands uses reduced pesticides tolerates some pest species providing prey for predators. Biodiversity significantly higher in extensively farmed landscapes than intensively farmed ones. The intensification of UK agriculture since the \(1970s\) has caused approximately 55% decline in farmland bird populations.$t$;

UPDATE questions SET
  option_a = $t$The natural greenhouse effect: solar radiation passes through the atmosphere and warms Earth's surface. The surface re-radiates energy as infrared radiation. Greenhouse gases (water vapour CO2 CH4 N2O) absorb some of this infrared and re-radiate it in all directions including back to Earth. This keeps Earth approximately 33 degrees C warmer than it would otherwise be — essential for life. Enhanced greenhouse effect: human activities (burning fossil fuels deforestation agriculture) have increased concentrations of CO2 (from 280 to 420 ppm) and methane. This increases the warming effect causing global average temperature rise (approximately 1.2 degrees C above pre-industrial levels as of 2023) contributing to climate change.$t$,
  option_d = $t$CO2 has no role in the greenhouse effect — only methane and water vapour matter$t$,
  explanation = $t$IPCC AR6 (2021): human-caused climate change unequivocal. Current CO2: approximately 422 ppm (2024). Methane: 2.6x pre-industrial level. Planetary boundary for CO2: 350 ppm (already exceeded). Feedback loops: ice-albedo feedback permafrost thaw releasing methane amplify warming.$t$
WHERE id = 2881
  AND option_a = $t$The natural greenhouse effect: solar radiation passes through the atmosphere and warms Earth's surface. The surface re-radiates energy as infrared radiation. Greenhouse gases (water vapour CO₂ CH₄ \(N2O\)) absorb some of this infrared and re-radiate it in all directions including back to Earth. This keeps Earth approximately 33 degrees C warmer than it would otherwise be — essential for life. Enhanced greenhouse effect: human activities (burning fossil fuels deforestation agriculture) have increased concentrations of CO₂ (from 280 to 420 ppm) and methane. This increases the warming effect causing global average temperature rise (approximately 1.2 degrees C above pre-industrial levels as of 2023) contributing to climate change.$t$
  AND option_d = $t$CO₂ has no role in the greenhouse effect — only methane and water vapour matter$t$
  AND explanation = $t$IPCC AR6 (2021): human-caused climate change unequivocal. Current CO₂: approximately 422 ppm (2024). Methane: \(2.6 \times pre\)-industrial level. Planetary boundary for CO₂: 350 ppm (already exceeded). Feedback loops: ice-albedo feedback permafrost thaw releasing methane amplify warming.$t$;

UPDATE questions SET
  option_c = $t$Predation (+/-): one organism (predator) kills and eats another (prey). Example: lion and wildebeest. Competition (-/-): both species suffer reduced fitness when sharing limited resources. Interspecific competition: barnacle Chthamalus excluded from lower shore by Semibalanus. Mutualism (+/+): both species benefit. Example: Rhizobium bacteria in legume root nodules (bacterium gets carbon plant gets fixed nitrogen). Parasitism (+/-): parasite benefits host harmed. Example: Plasmodium falciparum in humans (malaria). Commensalism (+/0): one benefits other unaffected. Example: cattle egrets feeding on insects disturbed by grazing cattle.$t$
WHERE id = 2883
  AND option_c = $t$Predation \((+ / -)\): one organism (predator) kills and eats another (prey). Example: lion and wildebeest. Competition \((- / -)\): both species suffer reduced fitness when sharing limited resources. Interspecific competition: barnacle Chthamalus excluded from lower shore by Semibalanus. Mutualism \((+ / +)\): both species benefit. Example: Rhizobium bacteria in legume root nodules (bacterium gets carbon plant gets fixed nitrogen). Parasitism \((+ / -)\): parasite benefits host harmed. Example: Plasmodium falciparum in humans (malaria). Commensalism \((+ / 0)\): one benefits other unaffected. Example: cattle egrets feeding on insects disturbed by grazing cattle.$t$;

UPDATE questions SET
  option_b = $t$Evidence for Amazon tipping point: (1) Deforestation: approximately 17% of the Amazon has been deforested since 1970 (approaching the estimated 20-25% tipping point threshold identified by Carlos Nobre and others). (2) Moisture recycling data: forests generate approximately 50-75% of their own rainfall through transpiration; as forest area decreases less moisture is recycled increasing drought risk. (3) Observed drying: severe droughts in 2005 2010 2015 2016 and 2020-2023 — previously rare events now occurring more frequently. (4) Forest degradation: fires degrade forest edges reducing biomass and moisture retention. Potential consequences: if tipping point is crossed irreversible dieback of eastern Amazon converts from dense rainforest to savanna or degraded scrubland. Loss of approximately 90 billion tonnes of carbon to atmosphere (one to two decades of global fossil fuel emissions). Loss of biodiversity in the most species-rich biome on Earth. Disruption of regional water cycle affecting agricultural productivity.$t$
WHERE id = 2885
  AND option_b = $t$Evidence for Amazon tipping point: (1) Deforestation: approximately 17% of the Amazon has been deforested since 1970 (approaching the estimated 20–25% tipping point threshold identified by Carlos Nobre and others). (2) Moisture recycling data: forests generate approximately 50–75% of their own rainfall through transpiration; as forest area decreases less moisture is recycled increasing drought risk. (3) Observed drying: severe droughts in 2005 2010 2015 2016 and \(2020 - 2023\) — previously rare events now occurring more frequently. (4) Forest degradation: fires degrade forest edges reducing biomass and moisture retention. Potential consequences: if tipping point is crossed irreversible dieback of eastern Amazon converts from dense rainforest to savanna or degraded scrubland. Loss of approximately 90 billion tonnes of carbon to atmosphere (one to two decades of global fossil fuel emissions). Loss of biodiversity in the most species-rich biome on Earth. Disruption of regional water cycle affecting agricultural productivity.$t$;

UPDATE questions SET
  option_d = $t$Ecosystem services are the benefits that ecosystems provide to humans: (1) Provisioning: food water timber medicines fibres. (2) Regulating: climate regulation (carbon sequestration) flood mitigation water purification pollination disease regulation. (3) Cultural: recreation aesthetic spiritual educational values. (4) Supporting: nutrient cycling soil formation primary production. Economic valuation: The Economics of Ecosystems and Biodiversity (TEEB) project estimated global ecosystem services at approximately USD 125-145 trillion per year (more than global GDP). Arguments for conservation: biodiversity loss impairs ecosystem function and reduces service delivery. Pollination services alone worth approximately USD 235-577 billion annually. Arguments against purely economic valuation: difficult to value and pricing nature may not change behaviour; some things have intrinsic value beyond economics; market failures mean biodiversity will be systematically undervalued.$t$
WHERE id = 2886
  AND option_d = $t$Ecosystem services are the benefits that ecosystems provide to humans: (1) Provisioning: food water timber medicines fibres. (2) Regulating: climate regulation (carbon sequestration) flood mitigation water purification pollination disease regulation. (3) Cultural: recreation aesthetic spiritual educational values. (4) Supporting: nutrient cycling soil formation primary production. Economic valuation: The Economics of Ecosystems and Biodiversity (TEEB) project estimated global ecosystem services at approximately USD 125–145 trillion per year (more than global GDP). Arguments for conservation: biodiversity loss impairs ecosystem function and reduces service delivery. Pollination services alone worth approximately USD 235–577 billion annually. Arguments against purely economic valuation: difficult to value and pricing nature may not change behaviour; some things have intrinsic value beyond economics; market failures mean biodiversity will be systematically undervalued.$t$;

UPDATE questions SET
  option_a = $t$Ocean acidification is caused by pollution from industrial chemicals not CO2$t$,
  option_b = $t$Ocean acidification: approximately 30% of anthropogenic CO2 emissions are absorbed by the ocean. CO2 dissolves in seawater forming carbonic acid (H2CO3) which dissociates to H+ and HCO3-. Since pre-industrial times ocean pH has fallen from approximately 8.2 to approximately 8.1 (a 30% increase in H+ concentration — logarithmic pH scale). Consequences: (1) Reduced carbonate ion concentration inhibits calcification in organisms with shells or skeletons (corals oysters pteropods). (2) Coral bleaching (from warming) combined with acidification makes reef recovery harder. (3) Changes to food web structure as shell-forming organisms decline. (4) Altered behaviour in some fish species (disrupted olfactory signalling). Strategies: reducing CO2 emissions (primary) enhanced weathering (adding alkaline minerals to ocean increases pH and sequesters carbon) reducing other stressors (water quality pollution warming) protecting resilient coral populations.$t$,
  option_d = $t$Ocean pH is self-regulating and cannot change significantly regardless of CO2 levels$t$
WHERE id = 2887
  AND option_a = $t$Ocean acidification is caused by pollution from industrial chemicals not CO₂$t$
  AND option_b = $t$Ocean acidification: approximately 30% of anthropogenic CO₂ emissions are absorbed by the ocean. CO₂ dissolves in seawater forming carbonic acid (H2CO3) which dissociates to H⁺ and HCO₃⁻. Since pre-industrial times ocean pH has fallen from approximately 8.2 to approximately 8.1 (a 30% increase in H⁺ concentration — logarithmic pH scale). Consequences: (1) Reduced carbonate ion concentration inhibits calcification in organisms with shells or skeletons (corals oysters pteropods). (2) Coral bleaching (from warming) combined with acidification makes reef recovery harder. (3) Changes to food web structure as shell-forming organisms decline. (4) Altered behaviour in some fish species (disrupted olfactory signalling). Strategies: reducing CO₂ emissions (primary) enhanced weathering (adding alkaline minerals to ocean increases pH and sequesters carbon) reducing other stressors (water quality pollution warming) protecting resilient coral populations.$t$
  AND option_d = $t$Ocean pH is self-regulating and cannot change significantly regardless of CO₂ levels$t$;

UPDATE questions SET
  option_d = $t$The Lincoln-Petersen mark-recapture method: capture a sample mark individuals and release. Later capture a second sample. Count how many in the second sample are marked. Population estimate N = (M x C)/R where M = number marked in first capture C = total in second capture R = marked individuals in second capture. Assumptions that must be met: (1) Marks do not affect survival or behaviour (marks must not make animals more visible to predators or impair movement). (2) No births deaths immigration or emigration between captures (closed population). (3) Marks are not lost between captures. (4) Marked and unmarked individuals have equal probability of capture (no trap-shyness or trap-happiness). Violation of any assumption biases the estimate.$t$,
  explanation = $t$Lincoln-Petersen: N = MC/R. Example: M = 50 marked C = 100 recaptured R = 10 marked in second sample. N = 50 x 100 / 10 = 500. For small populations or rare species: Chapman's modified estimator reduces bias. Frame sampling (quadrats transects): used for sessile organisms plants.$t$
WHERE id = 2889
  AND option_d = $t$The Lincoln-Petersen mark-recapture method: capture a sample mark individuals and release. Later capture a second sample. Count how many in the second sample are marked. Population estimate \(N = \frac{M \times C}{R}\) where M = number marked in first capture C = total in second capture R = marked individuals in second capture. Assumptions that must be met: (1) Marks do not affect survival or behaviour (marks must not make animals more visible to predators or impair movement). (2) No births deaths immigration or emigration between captures (closed population). (3) Marks are not lost between captures. (4) Marked and unmarked individuals have equal probability of capture (no trap-shyness or trap-happiness). Violation of any assumption biases the estimate.$t$
  AND explanation = $t$Lincoln-Petersen: \(N = \frac{MC}{R}\). Example: \(M = 50\) marked \(C = 100\) recaptured \(R = 10\) marked in second sample. \(N = 50 \times \frac{100}{10} = 500\). For small populations or rare species: Chapman's modified estimator reduces bias. Frame sampling (quadrats transects): used for sessile organisms plants.$t$;

UPDATE questions SET
  explanation = $t$Maximum sustainable yield: the largest catch that can be taken indefinitely. Often set at 50% of carrying capacity population. Grand Banks cod: catastrophic collapse in early 1990s due to decades of overfishing — still not recovered 30 years later. Lesson: precautionary approach needed.$t$
WHERE id = 2891
  AND explanation = $t$Maximum sustainable yield: the largest catch that can be taken indefinitely. Often set at 50% of carrying capacity population. Grand Banks cod: catastrophic collapse in early \(1990s\) due to decades of overfishing — still not recovered 30 years later. Lesson: precautionary approach needed.$t$;

UPDATE questions SET
  explanation = $t$Phenological mismatch: great tit and caterpillar timing (Visser et al). Coral bleaching: mass mortality events intensifying in frequency. Caribbean coral reefs: approximately 50% decline in coral cover since 1970s. Conservation genetics: maintaining genetic diversity enables evolutionary adaptation to climate change.$t$
WHERE id = 2892
  AND explanation = $t$Phenological mismatch: great tit and caterpillar timing (Visser et al). Coral bleaching: mass mortality events intensifying in frequency. Caribbean coral reefs: approximately 50% decline in coral cover since \(1970s\). Conservation genetics: maintaining genetic diversity enables evolutionary adaptation to climate change.$t$;

UPDATE questions SET
  option_d = $t$Tropical rainforests have extremely nutrient-poor soils (oxisols) despite high productivity. The reason: virtually all nutrients are locked up in living biomass not the soil. Nutrient cycling is extremely rapid and tight: dead organic matter (leaves wood) decomposes within weeks to months in the warm moist conditions (vs years in temperate forests). Decomposer fungi and bacteria immediately release nutrients which are immediately absorbed by fine root networks (often directly associated with mycorrhizal fungi) before nutrients can leach away with heavy rainfall. The cycle is extremely efficient with minimal nutrient loss. Consequence of deforestation: when forest is cleared nutrients are rapidly lost by leaching leaving the already thin infertile soil productive for only 2-3 years before becoming degraded.$t$,
  explanation = $t$Oxisols (laterite soils): highly weathered nutrient-poor dominated by iron and aluminium oxides. Nutrient cycling in rainforest: 99% of nutrients in biomass versus approximately 50% in temperate forests. After slash-and-burn: initial flush of nutrients from ash then rapid leaching. Shifting cultivation: traditional approach of burning and farming for 2-3 years then moving on giving 20+ years fallow recovery.$t$
WHERE id = 2893
  AND option_d = $t$Tropical rainforests have extremely nutrient-poor soils (oxisols) despite high productivity. The reason: virtually all nutrients are locked up in living biomass not the soil. Nutrient cycling is extremely rapid and tight: dead organic matter (leaves wood) decomposes within weeks to months in the warm moist conditions (vs years in temperate forests). Decomposer fungi and bacteria immediately release nutrients which are immediately absorbed by fine root networks (often directly associated with mycorrhizal fungi) before nutrients can leach away with heavy rainfall. The cycle is extremely efficient with minimal nutrient loss. Consequence of deforestation: when forest is cleared nutrients are rapidly lost by leaching leaving the already thin infertile soil productive for only 2–3 years before becoming degraded.$t$
  AND explanation = $t$Oxisols (laterite soils): highly weathered nutrient-poor dominated by iron and aluminium oxides. Nutrient cycling in rainforest: 99% of nutrients in biomass versus approximately 50% in temperate forests. After slash-and-burn: initial flush of nutrients from ash then rapid leaching. Shifting cultivation: traditional approach of burning and farming for 2–3 years then moving on giving 20+ years fallow recovery.$t$;

UPDATE questions SET
  option_c = $t$The Convention on Biological Diversity (CBD 1992) has three objectives: conservation of biological diversity sustainable use of its components and fair sharing of benefits from genetic resources. The Aichi Biodiversity Targets (2010-2020 strategic plan): 20 targets including protecting 17% of terrestrial and 10% of marine areas. Assessment: most targets not met by 2020. Target 11 (17% land 10% ocean protected): 15% of land approximately 7% of ocean protected by 2020. However quality of protection variable — many protected areas are paper parks with inadequate enforcement. Successes: CITES (Convention on International Trade in Endangered Species) has prevented extinction of tiger trade ban on ivory. Montreal Protocol (ozone): successful precedent for international environmental agreements. Kunming-Montreal Framework (2022): new 30x30 target (protect 30% of land and ocean by 2030). Biodiversity credits emerging as financing mechanism.$t$,
  explanation = $t$Kunming-Montreal Global Biodiversity Framework (COP15 2022): 196 nations agreed to 23 targets. 30x30: ambitious but dependent on country-level implementation. Finance gap: developing countries need USD 700 billion annually for biodiversity implementation vs current USD 120 billion available. Debt-for-nature swaps: debt relief in exchange for conservation commitments.$t$
WHERE id = 2894
  AND option_c = $t$The Convention on Biological Diversity (CBD 1992) has three objectives: conservation of biological diversity sustainable use of its components and fair sharing of benefits from genetic resources. The Aichi Biodiversity Targets (2010–2020 strategic plan): 20 targets including protecting 17% of terrestrial and 10% of marine areas. Assessment: most targets not met by 2020. Target 11 (17% land 10% ocean protected): 15% of land approximately 7% of ocean protected by 2020. However quality of protection variable — many protected areas are paper parks with inadequate enforcement. Successes: CITES (Convention on International Trade in Endangered Species) has prevented extinction of tiger trade ban on ivory. Montreal Protocol (ozone): successful precedent for international environmental agreements. Kunming-Montreal Framework (2022): new \(30x30\) target (protect 30% of land and ocean by 2030). Biodiversity credits emerging as financing mechanism.$t$
  AND explanation = $t$Kunming-Montreal Global Biodiversity Framework (COP15 2022): 196 nations agreed to 23 targets. \(30x30\): ambitious but dependent on country-level implementation. Finance gap: developing countries need USD 700 billion annually for biodiversity implementation vs current USD 120 billion available. Debt-for-nature swaps: debt relief in exchange for conservation commitments.$t$;

UPDATE questions SET
  explanation = $t$Bb × Bb cross gives: BB (1), Bb (2), bb (1). Ratio of dominant phenotype (BB or Bb) to recessive phenotype (bb) = 3:1. One quarter of offspring will show the recessive phenotype; three quarters will show the dominant phenotype.$t$
WHERE id = 3467
  AND explanation = $t$Bb × Bb cross gives: BB (1), Bb (2), bb (1). Ratio of dominant phenotype (BB or Bb) to recessive phenotype (bb) \(= 3 : 1\). One quarter of offspring will show the recessive phenotype; three quarters will show the dominant phenotype.$t$;

UPDATE questions SET
  question_text = $t$A woman who is a carrier for haemophilia (X^H X^h) has children with an unaffected man (X^H Y). What is the probability that a son will have haemophilia?$t$,
  explanation = $t$X^H X^h (carrier mother) × X^H Y (normal father). Sons receive Y from father and either X^H or X^h from mother. Sons with X^h Y are affected — that's 50% of sons. No daughters are affected (they all receive X^H from father). 50% of their sons will have haemophilia.$t$
WHERE id = 3468
  AND question_text = $t$A woman who is a carrier for haemophilia \((X^{H} X^{h})\) has children with an unaffected man \((X^{H} Y)\). What is the probability that a son will have haemophilia?$t$
  AND explanation = $t$\(X^{H} X^{h}\) (carrier mother) × \(X^{H} Y\) (normal father). Sons receive Y from father and either \(X^{H}\) or \(X^{h}\) from mother. Sons with \(X^{h} Y\) are affected — that's 50% of sons. No daughters are affected (they all receive \(X^{H}\) from father). 50% of their sons will have haemophilia.$t$;

UPDATE questions SET
  explanation = $t$A dominant allele is expressed whenever at least one copy is present. If the parent is Dd (heterozygous), offspring from Dd × dd: Dd (affected) and dd (unaffected) in 1:1 ratio — 50% chance of inheriting the condition. Dominant conditions can skip no generations if present.$t$
WHERE id = 3470
  AND explanation = $t$A dominant allele is expressed whenever at least one copy is present. If the parent is Dd (heterozygous), offspring from Dd × dd: Dd (affected) and dd (unaffected) in \(1 : 1\) ratio — 50% chance of inheriting the condition. Dominant conditions can skip no generations if present.$t$;

UPDATE questions SET
  question_text = $t$A gene has two alleles: T (tall, dominant) and t (dwarf, recessive). A tall plant is crossed with a dwarf plant and half the offspring are tall. What is the genotype of the tall parent?$t$,
  explanation = $t$T (tall) is dominant. The cross is Tt × tt (tall × dwarf). Offspring: Tt (tall) and tt (dwarf) in 1:1 ratio. A plant that is tall but has some dwarf offspring must be heterozygous (Tt) — a homozygous tall (TT) cross with tt would give all tall offspring.$t$
WHERE id = 3472
  AND question_text = $t$A gene has two alleles: T (tall, dominant) and \(t\) (dwarf, recessive). A tall plant is crossed with a dwarf plant and half the offspring are tall. What is the genotype of the tall parent?$t$
  AND explanation = $t$T (tall) is dominant. The cross is Tt × tt (tall × dwarf). Offspring: Tt (tall) and tt (dwarf) in \(1 : 1\) ratio. A plant that is tall but has some dwarf offspring must be heterozygous (Tt) — a homozygous tall (TT) cross with tt would give all tall offspring.$t$;

UPDATE questions SET
  explanation = $t$Ff × Ff (both carriers): FF (1/4, unaffected), Ff (1/2, carrier), ff (1/4, affected with CF). The probability of having an affected child (ff) is 1/4 = 25%. The probability of being a carrier (Ff) is 1/2 = 50%. These are the standard ratios from a carrier × carrier cross.$t$
WHERE id = 3474
  AND explanation = $t$Ff × Ff (both carriers): FF (\(\frac{1}{4}\), unaffected), Ff (\(\frac{1}{2}\), carrier), ff (\(\frac{1}{4}\), affected with CF). The probability of having an affected child (ff) is \(\frac{1}{4} = 25\%\). The probability of being a carrier (Ff) is \(\frac{1}{2} = 50\%\). These are the standard ratios from a carrier × carrier cross.$t$;

UPDATE questions SET
  explanation = $t$In DNA, base pairing is complementary and specific: A pairs with T; C pairs with G. If cytosine = 30%, then guanine = 30% (C always equals G). Remaining = 100 − 30 − 30 = 40% for A+T. A = T = 20%. Therefore adenine = 20%.$t$
WHERE id = 3476
  AND explanation = $t$In DNA, base pairing is complementary and specific: A pairs with T; C pairs with G. If cytosine \(= 30\%\), then guanine \(= 30\%\) (C always equals G). Remaining \(= 100 - 30 - 30 = 40\%\) for \(A + T\). \(A = T = 20\%\). Therefore adenine \(= 20\%\).$t$;

UPDATE questions SET
  question_text = $t$How does negative feedback maintain body temperature when core temperature rises above 37°C?$t$,
  option_a = $t$The hypothalamus detects the rise; blood vessels in the skin dilate and sweat glands become active; heat is lost; core temperature returns to 37°C$t$,
  explanation = $t$When temperature rises above 37°C: vasodilation (blood vessels near skin widen — more heat radiated), sweating (evaporation cools skin). Shivering generates more heat and is a WARMING response — it occurs when temperature falls, not rises. The question asks about responding to a temperature rise.$t$
WHERE id = 3481
  AND question_text = $t$How does negative feedback maintain body temperature when core temperature rises above \(37^\circ C\)?$t$
  AND option_a = $t$The hypothalamus detects the rise; blood vessels in the skin dilate and sweat glands become active; heat is lost; core temperature returns to \(37^\circ C\)$t$
  AND explanation = $t$When temperature rises above \(37^\circ C\): vasodilation (blood vessels near skin widen — more heat radiated), sweating (evaporation cools skin). Shivering generates more heat and is a WARMING response — it occurs when temperature falls, not rises. The question asks about responding to a temperature rise.$t$;

UPDATE questions SET
  explanation = $t$The hypothalamus acts as the body's thermostat: it has temperature receptors that detect changes in blood temperature, and it coordinates the appropriate warming or cooling responses via the autonomic nervous system and hormones. It sets the set point for body temperature (~37°C).$t$
WHERE id = 3485
  AND explanation = $t$The hypothalamus acts as the body's thermostat: it has temperature receptors that detect changes in blood temperature, and it coordinates the appropriate warming or cooling responses via the autonomic nervous system and hormones. It sets the set point for body temperature (~\(37^\circ C\)).$t$;

UPDATE questions SET
  explanation = $t$The student is incorrect: hormones travel in the blood (relatively slow — minutes) while nerve impulses travel along axons at up to 100 m/s (milliseconds). Hormones generally have a slower onset but longer duration of effect. Reflexes requiring immediate response use nerves, not hormones.$t$
WHERE id = 3486
  AND explanation = $t$The student is incorrect: hormones travel in the blood (relatively slow — minutes) while nerve impulses travel along axons at up to \(100\,\text{m/s}\) (milliseconds). Hormones generally have a slower onset but longer duration of effect. Reflexes requiring immediate response use nerves, not hormones.$t$;

UPDATE questions SET
  explanation = $t$Alveoli adaptations: very large total surface area (~70 m²), walls only one cell thick (short diffusion distance), moist lining (gases dissolve for diffusion), rich capillary supply (maintains steep concentration gradient by removing oxygen and delivering CO₂). All four features maximise diffusion rate.$t$
WHERE id = 3487
  AND explanation = $t$Alveoli adaptations: very large total surface area (~\(70 m^{2}\)), walls only one cell thick (short diffusion distance), moist lining (gases dissolve for diffusion), rich capillary supply (maintains steep concentration gradient by removing oxygen and delivering CO₂). All four features maximise diffusion rate.$t$;

UPDATE questions SET
  explanation = $t$Villi greatly increase the surface area of the small intestine. They have thin walls (one cell thick) to minimise diffusion distance, capillaries inside for glucose and amino acids, and lacteals for fatty acids. Their combined surface area (~250 m²) allows efficient absorption of all digested nutrients.$t$
WHERE id = 3489
  AND explanation = $t$Villi greatly increase the surface area of the small intestine. They have thin walls (one cell thick) to minimise diffusion distance, capillaries inside for glucose and amino acids, and lacteals for fatty acids. Their combined surface area (~\(250 m^{2}\)) allows efficient absorption of all digested nutrients.$t$;

UPDATE questions SET
  explanation = $t$Haemoglobin is a protein in red blood cells that reversibly binds oxygen: Hb + 4O₂ ⇌ HbO₂. It loads oxygen in the lungs (high pO₂) and unloads it in respiring tissues (low pO₂). It does NOT destroy pathogens — that is the role of white blood cells.$t$
WHERE id = 3490
  AND explanation = $t$Haemoglobin is a protein in red blood cells that reversibly binds oxygen: Hb + 4O₂ ⇌ HbO₂. It loads oxygen in the lungs (high \(p\)O₂) and unloads it in respiring tissues (low \(p\)O₂). It does NOT destroy pathogens — that is the role of white blood cells.$t$;

UPDATE questions SET
  option_a = $t$It would increase the rate of breathing to compensate for reduced CO2 removal$t$
WHERE id = 3494
  AND option_a = $t$It would increase the rate of breathing to compensate for reduced CO₂ removal$t$;

UPDATE questions SET
  explanation = $t$Ff × Ff cross gives: FF (unaffected, 1/4), Ff (carrier, 2/4), ff (affected, 1/4). The probability of being UNAFFECTED = 3/4 = 75%. Students often confuse "unaffected" with "homozygous dominant" — carriers (Ff) are also unaffected since f is recessive.$t$
WHERE id = 3659
  AND explanation = $t$Ff × Ff cross gives: FF (unaffected, \(\frac{1}{4}\)), Ff (carrier, \(\frac{2}{4}\)), ff (affected, \(\frac{1}{4}\)). The probability of being UNAFFECTED \(= \frac{3}{4} = 75\%\). Students often confuse "unaffected" with "homozygous dominant" — carriers (Ff) are also unaffected since \(f\) is recessive.$t$;

UPDATE questions SET
  explanation = $t$Human body cells (somatic cells) contain 46 chromosomes arranged in 23 pairs — they are diploid. Each pair consists of one chromosome from each parent. Gametes (sperm and egg) contain only 23 chromosomes (haploid). At fertilisation, 23+23=46 chromosomes are restored.$t$
WHERE id = 3661
  AND explanation = $t$Human body cells (somatic cells) contain 46 chromosomes arranged in 23 pairs — they are diploid. Each pair consists of one chromosome from each parent. Gametes (sperm and egg) contain only 23 chromosomes (haploid). At fertilisation, \(23 + 23 = 46\) chromosomes are restored.$t$;

UPDATE questions SET
  question_text = $t$Cystic fibrosis is caused by a recessive allele (f). What genotype would a person need to have cystic fibrosis?$t$,
  explanation = $t$Cystic fibrosis is caused by the recessive allele f. To be affected, a person must have genotype ff (homozygous recessive) — two copies of the recessive allele. Having one copy (Ff) makes you a carrier — unaffected but able to pass the allele to children.$t$
WHERE id = 3663
  AND question_text = $t$Cystic fibrosis is caused by a recessive allele (\(f\)). What genotype would a person need to have cystic fibrosis?$t$
  AND explanation = $t$Cystic fibrosis is caused by the recessive allele \(f\). To be affected, a person must have genotype ff (homozygous recessive) — two copies of the recessive allele. Having one copy (Ff) makes you a carrier — unaffected but able to pass the allele to children.$t$;

UPDATE questions SET
  question_text = $t$A person has the genotype Bb where B is dominant (brown eyes) and b is recessive (blue eyes). What is their phenotype?$t$,
  explanation = $t$B (brown) is dominant over b (blue). A person with genotype Bb (heterozygous) has one dominant allele B — the dominant allele is expressed. Their eyes are brown. Only bb individuals have blue eyes. One copy of B is enough to produce brown pigment.$t$
WHERE id = 3665
  AND question_text = $t$A person has the genotype Bb where B is dominant (brown eyes) and \(b\) is recessive (blue eyes). What is their phenotype?$t$
  AND explanation = $t$B (brown) is dominant over \(b\) (blue). A person with genotype Bb (heterozygous) has one dominant allele B — the dominant allele is expressed. Their eyes are brown. Only bb individuals have blue eyes. One copy of B is enough to produce brown pigment.$t$;

UPDATE questions SET
  explanation = $t$When body temperature rises above 37°C: blood vessels in the skin dilate (vasodilation) — more blood flows to the skin surface, radiating heat; sweat glands produce sweat which evaporates, cooling the skin. Both responses increase heat loss from the body.$t$
WHERE id = 3673
  AND explanation = $t$When body temperature rises above \(37^\circ C\): blood vessels in the skin dilate (vasodilation) — more blood flows to the skin surface, radiating heat; sweat glands produce sweat which evaporates, cooling the skin. Both responses increase heat loss from the body.$t$;

UPDATE questions SET
  option_a = $t$36°C$t$,
  option_b = $t$38°C$t$,
  option_c = $t$40°C$t$,
  option_d = $t$37°C$t$,
  explanation = $t$Normal human body temperature is 37°C. The hypothalamus acts as the thermostat — it detects deviations from this set point and coordinates responses to return to 37°C. Enzymes in the body work optimally at this temperature; significant deviation impairs enzyme activity.$t$
WHERE id = 3676
  AND option_a = $t$\(36^\circ C\)$t$
  AND option_b = $t$\(38^\circ C\)$t$
  AND option_c = $t$\(40^\circ C\)$t$
  AND option_d = $t$\(37^\circ C\)$t$
  AND explanation = $t$Normal human body temperature is \(37^\circ C\). The hypothalamus acts as the thermostat — it detects deviations from this set point and coordinates responses to return to \(37^\circ C\). Enzymes in the body work optimally at this temperature; significant deviation impairs enzyme activity.$t$;

UPDATE questions SET
  question_text = $t$Haemophilia is X-linked recessive. A carrier woman (X^H X^h) has children with an affected man (X^h Y). What proportion of daughters will be affected?$t$,
  option_c = $t$50% of daughters are affected (X^h X^h genotype)$t$,
  explanation = $t$X^H X^h (carrier mother) × X^h Y (affected father). Sons: X^H Y (unaffected, ½) and X^h Y (affected, ½). Daughters: X^H X^h (carrier, ½) and X^h X^h (affected, ½). With an affected father, daughters CAN be affected (they inherit X^h from father and may inherit X^h from mother). 50% of daughters are affected.$t$
WHERE id = 3849
  AND question_text = $t$Haemophilia is X-linked recessive. A carrier woman \((X^{H} X^{h})\) has children with an affected man \((X^{h} Y)\). What proportion of daughters will be affected?$t$
  AND option_c = $t$50% of daughters are affected (\(X^{h} X^{h}\) genotype)$t$
  AND explanation = $t$\(X^{H} X^{h}\) (carrier mother) × \(X^{h} Y\) (affected father). Sons: \(X^{H} Y\) (unaffected, \(\tfrac{1}{2}\)) and \(X^{h} Y\) (affected, \(\tfrac{1}{2}\)). Daughters: \(X^{H} X^{h}\) (carrier, \(\tfrac{1}{2}\)) and \(X^{h} X^{h}\) (affected, \(\tfrac{1}{2}\)). With an affected father, daughters CAN be affected (they inherit \(X^{h}\) from father and may inherit \(X^{h}\) from mother). 50% of daughters are affected.$t$;

UPDATE questions SET
  option_a = $t$1/2$t$,
  option_b = $t$3/4$t$,
  option_c = $t$1/4$t$,
  option_d = $t$1/1$t$,
  explanation = $t$Roan × roan: RW × RW gives RR (red, ¼), RW (roan, ½), WW (white, ¼). The question asks for probability of roan offspring = 2/4 = 1/2. Codominant alleles are both expressed in the heterozygote — neither is dominant. A roan animal shows both red and white hairs simultaneously.$t$
WHERE id = 3850
  AND option_a = $t$\(\frac{1}{2}\)$t$
  AND option_b = $t$\(\frac{3}{4}\)$t$
  AND option_c = $t$\(\frac{1}{4}\)$t$
  AND option_d = $t$\(\frac{1}{1}\)$t$
  AND explanation = $t$Roan × roan: \(RW \times RW\) gives RR (red, \(\tfrac{1}{4}\)), RW (roan, \(\tfrac{1}{2}\)), WW (white, \(\tfrac{1}{4}\)). The question asks for probability of roan offspring \(= \frac{2}{4} = \frac{1}{2}\). Codominant alleles are both expressed in the heterozygote — neither is dominant. A roan animal shows both red and white hairs simultaneously.$t$;

UPDATE questions SET
  option_d = $t$Over one billion copies (2³⁰ ≈ 1.07 × 10⁹)$t$,
  explanation = $t$PCR doubles the DNA each cycle. After 30 cycles: 2³⁰ = 1 073 741 824 ≈ 10⁹ copies from one original template. Starting from 1 molecule: after 10 cycles ≈ 1000; after 20 ≈ 10⁶; after 30 ≈ 10⁹. The exponential amplification makes PCR extraordinarily sensitive — can detect a single DNA molecule.$t$
WHERE id = 3851
  AND option_d = $t$Over one billion copies \((2^{30} \approx 1.07 \times 10^{9})\)$t$
  AND explanation = $t$PCR doubles the DNA each cycle. After 30 cycles: \(2^{30} = 1\,073\,741\,824 \approx 10^{9}\) copies from one original template. Starting from 1 molecule: after 10 cycles \(\approx 1000\); after \(20 \approx 10^{6}\); after \(30 \approx 10^{9}\). The exponential amplification makes PCR extraordinarily sensitive — can detect a single DNA molecule.$t$;

UPDATE questions SET
  option_d = $t$Children will be A or B only, because I^A and I^B are codominant — neither is dominant over the other, so each is expressed separately$t$,
  explanation = $t$Woman is AB: she can pass I^A or I^B to children. Partner is O (I^O I^O): all children receive I^O from father. Children: I^A I^O (blood group A) or I^B I^O (blood group B) — 50% each. No AB or O children possible from this cross. Codominance means AB individuals express both antigens simultaneously.$t$
WHERE id = 3852
  AND option_d = $t$Children will be A or B only, because \(I^{A}\) and \(I^{B}\) are codominant — neither is dominant over the other, so each is expressed separately$t$
  AND explanation = $t$Woman is AB: she can pass \(I^{A}\) or \(I^{B}\) to children. Partner is \(O (I^{O} I^{O})\): all children receive \(I^{O}\) from father. Children: \(I^{A}\) \(I^{O}\) (blood group A) or \(I^{B}\) \(I^{O}\) (blood group B) — 50% each. No AB or O children possible from this cross. Codominance means AB individuals express both antigens simultaneously.$t$;

UPDATE questions SET
  explanation = $t$Pp × pp (dominant condition × unaffected): Pp (affected) and pp (unaffected) in 1:1 ratio = 50% of children affected. The dominant allele P causes the condition even in heterozygotes (Pp). Unaffected partner has no dominant allele to pass on, so half the children are Pp (affected).$t$
WHERE id = 3853
  AND explanation = $t$\(\text{Pp} \times pp\) (dominant condition × unaffected): Pp (affected) and pp (unaffected) in \(1 : 1\) ratio \(= 50\%\) of children affected. The dominant allele P causes the condition even in heterozygotes (Pp). Unaffected partner has no dominant allele to pass on, so half the children are Pp (affected).$t$;

UPDATE questions SET
  option_a = $t$3/4$t$,
  option_b = $t$9/16$t$,
  option_c = $t$27/64$t$,
  option_d = $t$1/64$t$,
  explanation = $t$For each child: P(recessive) = 1/4. For 3 children all affected: (1/4)³ = 1/64. Independent events — the probability of each child being affected is independent of the others. Multiply probabilities for independent AND events. Previous children's genotypes do not affect subsequent siblings' probabilities.$t$
WHERE id = 3856
  AND option_a = $t$\(\frac{3}{4}\)$t$
  AND option_b = $t$\(\frac{9}{16}\)$t$
  AND option_c = $t$\(\frac{27}{64}\)$t$
  AND option_d = $t$\(\frac{1}{64}\)$t$
  AND explanation = $t$For each child: P(recessive) \(= \frac{1}{4}\). For 3 children all affected: \((\frac{1}{4})^{3} = \frac{1}{64}\). Independent events — the probability of each child being affected is independent of the others. Multiply probabilities for independent AND events. Previous children's genotypes do not affect subsequent siblings' probabilities.$t$;

UPDATE questions SET
  explanation = $t$Expected from Bb × Bb: 3 blue (BB or Bb): 1 orange (bb) = 60 blue and 20 orange from 80 offspring. Actual results may differ from expected due to sampling variation — random chance in which alleles are inherited. Chi-squared test can determine if differences are statistically significant or just due to chance.$t$
WHERE id = 3858
  AND explanation = $t$Expected from Bb × Bb: 3 blue (BB or Bb): 1 orange (bb) \(= 60\) blue and 20 orange from 80 offspring. Actual results may differ from expected due to sampling variation — random chance in which alleles are inherited. Chi-squared test can determine if differences are statistically significant or just due to chance.$t$;

UPDATE questions SET
  explanation = $t$Blood glucose rises after a high-carbohydrate meal → beta cells in pancreas detect this and secrete insulin into the bloodstream → insulin causes liver and muscle cells to absorb glucose (converting it to glycogen) and adipose tissue to take up glucose → blood glucose returns to normal set point (~4-6 mmol/L).$t$
WHERE id = 3860
  AND explanation = $t$Blood glucose rises after a high-carbohydrate meal → beta cells in pancreas detect this and secrete insulin into the bloodstream → insulin causes liver and muscle cells to absorb glucose (converting it to glycogen) and adipose tissue to take up glucose → blood glucose returns to normal set point (~4–6 mmol/L).$t$;

UPDATE questions SET
  option_c = $t$Hypothalamus only responds to extreme temperatures above 40°C or below 35°C$t$,
  option_d = $t$Hypothalamus monitors blood temperature. If too hot: signals skin vasodilation, sweat glands activated, hairs lie flat. If too cold: signals vasoconstriction, shivering generates heat, piloerection traps air. Both use negative feedback to restore 37°C.$t$,
  explanation = $t$The hypothalamus contains thermoreceptors that detect blood temperature deviations from 37°C. If too hot: sends signals via autonomic nervous system to cause vasodilation and sweating. If too cold: causes vasoconstriction, shivering and piloerection. It responds to small deviations (not just extremes) to maintain homeostasis continuously.$t$
WHERE id = 3866
  AND option_c = $t$Hypothalamus only responds to extreme temperatures above \(40^\circ C\) or below \(35^\circ C\)$t$
  AND option_d = $t$Hypothalamus monitors blood temperature. If too hot: signals skin vasodilation, sweat glands activated, hairs lie flat. If too cold: signals vasoconstriction, shivering generates heat, piloerection traps air. Both use negative feedback to restore \(37^\circ C\).$t$
  AND explanation = $t$The hypothalamus contains thermoreceptors that detect blood temperature deviations from \(37^\circ C\). If too hot: sends signals via autonomic nervous system to cause vasodilation and sweating. If too cold: causes vasoconstriction, shivering and piloerection. It responds to small deviations (not just extremes) to maintain homeostasis continuously.$t$;

UPDATE questions SET
  question_text = $t$A person moves from 25°C indoors to −5°C outside. Describe four physiological responses and the benefit of each.$t$,
  option_a = $t$Vasoconstriction (reduces heat loss from skin), shivering (generates heat from muscle activity), piloerection (traps air as insulation layer), reduced sweating (prevents evaporative heat loss). Together these maintain core temperature at 37°C despite the 30°C environmental drop.$t$,
  explanation = $t$Moving from 25°C to −5°C: four physiological responses are vasoconstriction (blood vessels near skin narrow — reduces heat loss), shivering (involuntary muscle contractions generate heat), piloerection (hair stands up — traps insulating air layer) and reduced sweating. Vasodilation and sweating are warming responses and would be incorrect.$t$
WHERE id = 3868
  AND question_text = $t$A person moves from \(25^\circ C\) indoors to \(- 5^\circ C\) outside. Describe four physiological responses and the benefit of each.$t$
  AND option_a = $t$Vasoconstriction (reduces heat loss from skin), shivering (generates heat from muscle activity), piloerection (traps air as insulation layer), reduced sweating (prevents evaporative heat loss). Together these maintain core temperature at \(37^\circ C\) despite the \(30^\circ C\) environmental drop.$t$
  AND explanation = $t$Moving from \(25^\circ C\) to \(- 5^\circ C\): four physiological responses are vasoconstriction (blood vessels near skin narrow — reduces heat loss), shivering (involuntary muscle contractions generate heat), piloerection (hair stands up — traps insulating air layer) and reduced sweating. Vasodilation and sweating are warming responses and would be incorrect.$t$;

UPDATE questions SET
  question_text = $t$Resting: HR = 70 bpm, stroke volume = 75 mL. Exercise: cardiac output = 20 L/min, HR = 150 bpm. Calculate resting cardiac output and exercise stroke volume.$t$,
  option_a = $t$Resting CO = 5.25 L/min; exercise stroke volume = 133 mL$t$,
  option_b = $t$Resting CO = 70 L/min; exercise stroke volume = 75 mL$t$,
  option_c = $t$Resting CO = 5.25 L/min; exercise stroke volume = 75 mL$t$,
  option_d = $t$Resting CO = 52.5 L/min; exercise stroke volume = 133 mL$t$,
  explanation = $t$Resting cardiac output = HR × SV = 70 × 75 = 5250 mL/min = 5.25 L/min. During exercise: CO = 20 L/min. Exercise SV = CO/HR = 20 000/HR. If exercise HR = 150 bpm: SV = 20 000/150 = 133 mL. The heart increases both rate and stroke volume during exercise to meet increased oxygen demand.$t$
WHERE id = 3869
  AND question_text = $t$Resting: \(HR = 70\,\text{bpm}\), stroke volume \(= 75\,\text{mL}\). Exercise: cardiac output = \(20\,\text{L/min}\), \(HR = 150\,\text{bpm}\). Calculate resting cardiac output and exercise stroke volume.$t$
  AND option_a = $t$Resting CO = \(5.25\,\text{L/min}\); exercise stroke volume \(= 133\,\text{mL}\)$t$
  AND option_b = $t$Resting CO = \(70\,\text{L/min}\); exercise stroke volume \(= 75\,\text{mL}\)$t$
  AND option_c = $t$Resting CO = \(5.25\,\text{L/min}\); exercise stroke volume \(= 75\,\text{mL}\)$t$
  AND option_d = $t$Resting CO = \(52.5\,\text{L/min}\); exercise stroke volume \(= 133\,\text{mL}\)$t$
  AND explanation = $t$Resting cardiac output \(= HR \times SV = 70 \times 75 = 5250\,\text{mL/min} = 5.25\,\text{L/min}\). During exercise: CO = \(20\,\text{L/min}\). Exercise SV = CO/\(HR = \frac{20\,000}{HR}\). If exercise \(HR = 150\,\text{bpm}\): \(SV = \frac{20\,000}{150} = 133\,\text{mL}\). The heart increases both rate and stroke volume during exercise to meet increased oxygen demand.$t$;

UPDATE questions SET
  explanation = $t$Blood flow resistance increases dramatically when cross-sectional area is reduced by 75% — the remaining 25% of area must carry the same flow, requiring much higher pressure difference (Poiseuille's Law: resistance ∝ 1/r⁴). The patient experiences angina (chest pain) due to inadequate oxygen supply to heart muscle, especially during exercise.$t$
WHERE id = 3871
  AND explanation = $t$Blood flow resistance increases dramatically when cross-sectional area is reduced by 75% — the remaining 25% of area must carry the same flow, requiring much higher pressure difference (Poiseuille's Law: resistance \(\propto \frac{1}{r^{4}}\)). The patient experiences angina (chest pain) due to inadequate oxygen supply to heart muscle, especially during exercise.$t$;

UPDATE questions SET
  question_text = $t$Before exercise: breathing rate = 15/min, tidal volume = 500 mL. After sprint: 40/min, 1500 mL. Calculate minute ventilation before and after.$t$,
  option_a = $t$Before = 7500 mL/min; after = 60 000 mL/min$t$,
  option_b = $t$Before = 7500 mL/min; after = 40 000 mL/min$t$,
  option_c = $t$Before = 500 mL/min; after = 1500 mL/min$t$,
  option_d = $t$Before = 7500 mL/min; after = 30 000 mL/min$t$,
  explanation = $t$Minute ventilation = breathing rate × tidal volume. Before exercise: 15 × 500 = 7500 mL/min. After sprinting: breathing rate and tidal volume both increase. If after: 40 breaths/min × 1000 mL = 40 000 mL/min. Oxygen delivery must match the enormous increase in oxygen consumption during intense exercise.$t$
WHERE id = 3872
  AND question_text = $t$Before exercise: breathing rate \(= 15\)/min, tidal volume \(= 500\,\text{mL}\). After sprint: 40/min, 1500 mL. Calculate minute ventilation before and after.$t$
  AND option_a = $t$Before = \(7500\,\text{mL/min}\); after = \(60\,000\,\text{mL/min}\)$t$
  AND option_b = $t$Before = \(7500\,\text{mL/min}\); after = \(40\,000\,\text{mL/min}\)$t$
  AND option_c = $t$Before = \(500\,\text{mL/min}\); after = \(1500\,\text{mL/min}\)$t$
  AND option_d = $t$Before = \(7500\,\text{mL/min}\); after = \(30\,000\,\text{mL/min}\)$t$
  AND explanation = $t$Minute ventilation = breathing rate × tidal volume. Before exercise: \(15 \times 500 = 7500\,\text{mL/min}\). After sprinting: breathing rate and tidal volume both increase. If after: 40 breaths/\(min \times 1000\,\text{mL} = 40\,000\,\text{mL/min}\). Oxygen delivery must match the enormous increase in oxygen consumption during intense exercise.$t$;

UPDATE questions SET
  option_b = $t$Countercurrent flow means blood and water flow in opposite directions; this maintains a concentration gradient for oxygen along the entire gill length — blood always encounters water with higher oxygen concentration, allowing continuous diffusion; parallel flow causes equilibration midway with ~50% extraction versus >80% for countercurrent$t$
WHERE id = 3876
  AND option_b = $t$Countercurrent flow means blood and water flow in opposite directions; this maintains a concentration gradient for oxygen along the entire gill length — blood always encounters water with higher oxygen concentration, allowing continuous diffusion; parallel flow causes equilibration midway with ~50% extraction versus \(> 80\%\) for countercurrent$t$;

UPDATE questions SET
  explanation = $t$The S-shape (sigmoid) of the oxygen dissociation curve results from haem cooperativity: binding of the first O₂ molecule causes conformational changes that increase affinity for subsequent O₂ molecules (cooperative binding). This gives the characteristic shape — steep in the mid-range (alveolar pO₂) allowing efficient loading and unloading.$t$
WHERE id = 3878
  AND explanation = $t$The S-shape (sigmoid) of the oxygen dissociation curve results from haem cooperativity: binding of the first O₂ molecule causes conformational changes that increase affinity for subsequent O₂ molecules (cooperative binding). This gives the characteristic shape — steep in the mid-range (alveolar \(p\)O₂) allowing efficient loading and unloading.$t$;

UPDATE questions SET
  question_text = $t$A student uses a light microscope with a ×10 eyepiece and ×40 objective lens to view a cell. The image of the cell is 20 mm wide. Calculate the actual width of the cell.$t$,
  option_a = $t$800 µm$t$,
  option_b = $t$50 µm$t$,
  option_c = $t$2000 µm$t$,
  option_d = $t$200 µm$t$,
  explanation = $t$Total magnification = 10 × 40 = 400. Image width = 20 mm = 20 000 µm. Actual width = image ÷ magnification = 20 000 ÷ 400 = 50 µm.$t$
WHERE id = 3960
  AND question_text = $t$A student uses a light microscope with \(a \times 10\) eyepiece and \(\times 40\) objective lens to view a cell. The image of the cell is 20 mm wide. Calculate the actual width of the cell.$t$
  AND option_a = $t$\(800\,\mu\text{m}\)$t$
  AND option_b = $t$\(50\,\mu\text{m}\)$t$
  AND option_c = $t$\(2000\,\mu\text{m}\)$t$
  AND option_d = $t$\(200\,\mu\text{m}\)$t$
  AND explanation = $t$Total magnification \(= 10 \times 40 = 400\). Image width \(= 20\,\text{mm} = 20\,000\,\mu\text{m}\). Actual width = image ÷ magnification \(= 20\,000 \div 400 = 50\,\mu\text{m}\).$t$;

UPDATE questions SET
  question_text = $t$An enzyme has a Km of 2 mmol/dm³. What does this tell you about the enzyme's affinity for its substrate?$t$
WHERE id = 3962
  AND question_text = $t$An enzyme has a Km of 2 mmol/\(dm^{3}\). What does this tell you about the enzyme's affinity for its substrate?$t$;

UPDATE questions SET
  question_text = $t$A cell has a water potential of −500 kPa. It is placed in a solution with water potential −300 kPa. In which direction will water move and by what process?$t$,
  explanation = $t$Osmosis moves water from higher to lower water potential. The cell has water potential −500 kPa; if the solution has a less negative (higher) water potential than the cell, water moves INTO the cell. If the solution has a more negative water potential, water moves OUT.$t$
WHERE id = 3963
  AND question_text = $t$A cell has a water potential of \(- 500\,\text{kPa}\). It is placed in a solution with water potential \(- 300\,\text{kPa}\). In which direction will water move and by what process?$t$
  AND explanation = $t$Osmosis moves water from higher to lower water potential. The cell has water potential \(- 500\,\text{kPa}\); if the solution has a less negative (higher) water potential than the cell, water moves INTO the cell. If the solution has a more negative water potential, water moves OUT.$t$;

UPDATE questions SET
  question_text = $t$A student calculates the magnification of an image as ×400. The image is 8 cm wide. What is the actual width of the object?$t$,
  option_d = $t$200 µm$t$,
  explanation = $t$Actual size = image size ÷ magnification = 8 cm ÷ 400. Convert 8 cm to µm: 8 × 10 000 = 80 000 µm. Actual size = 80 000 ÷ 400 = 200 µm. Always convert the image measurement to the same units as your required answer before dividing.$t$
WHERE id = 3966
  AND question_text = $t$A student calculates the magnification of an image as \(\times 400\). The image is 8 cm wide. What is the actual width of the object?$t$
  AND option_d = $t$\(200\,\mu\text{m}\)$t$
  AND explanation = $t$Actual size = image size ÷ magnification \(= 8\,\text{cm} \div 400\). Convert 8 cm to µ\(m\): \(8 \times 10\,000 = 80\,000\,\mu\text{m}\). Actual size \(= 80\,000 \div 400 = 200\,\mu\text{m}\). Always convert the image measurement to the same units as your required answer before dividing.$t$;

UPDATE questions SET
  option_c = $t$Eukaryotic cells have membrane-bound organelles including a nucleus; prokaryotic cells have no membrane-bound nucleus, smaller ribosomes (70S vs 80S) and often have plasmids and a cell wall of peptidoglycan$t$
WHERE id = 3969
  AND option_c = $t$Eukaryotic cells have membrane-bound organelles including a nucleus; prokaryotic cells have no membrane-bound nucleus, smaller ribosomes (\(70S\) vs \(80S\)) and often have plasmids and a cell wall of peptidoglycan$t$;

UPDATE questions SET
  question_text = $t$A student tests their reaction time by catching a dropped ruler. The ruler falls 20 cm before it is caught. Using s = ½gt², calculate the reaction time. (g = 10 m/s²)$t$,
  option_a = $t$t = 0.04 s$t$,
  option_b = $t$t = 0.2 s$t$,
  option_c = $t$t = 0.02 s$t$,
  option_d = $t$t = 2 s$t$,
  explanation = $t$Using h = ½gt²: t = √(2h/g) = √(2×0.08/10) = √0.016 ≈ 0.04 s (if h = 0.08 m). The ruler falls h = ½ × 10 × t². Rearrange: t = √(2h/g). A faster reaction time means the ruler is caught at a shorter distance — shorter distance = shorter time = faster reaction.$t$
WHERE id = 3979
  AND question_text = $t$A student tests their reaction time by catching a dropped ruler. The ruler falls 20 cm before it is caught. Using \(s = \tfrac{1}{2}gt^{2}\), calculate the reaction time. (\(g = 10\,\text{m/s}^{2}\))$t$
  AND option_a = $t$\(t = 0.04\,\text{s}\)$t$
  AND option_b = $t$\(t = 0.2\,\text{s}\)$t$
  AND option_c = $t$\(t = 0.02\,\text{s}\)$t$
  AND option_d = $t$\(t = 2\,\text{s}\)$t$
  AND explanation = $t$Using \(h = \tfrac{1}{2}gt^{2}\): \(t = \sqrt{}\)(\(2\,\text{h/g}\)) \(= \sqrt{2 \times \frac{0.08}{10}} = \sqrt{0.016} \approx 0.04\,\text{s}\) (if \(h = 0.08\,\text{m}\)). The ruler falls \(h = \tfrac{1}{2} \times 10 \times t^{2}\). Rearrange: \(t = \sqrt{}\)(\(2\,\text{h/g}\)). A faster reaction time means the ruler is caught at a shorter distance — shorter distance = shorter time = faster reaction.$t$;

UPDATE questions SET
  explanation = $t$Antibodies have a Y-shaped structure with a variable region at each arm tip. The variable region has a unique 3D shape complementary to a specific antigen. Only the matching antigen fits the binding site — like a lock and key. This specificity means each antibody type only targets one antigen.$t$
WHERE id = 3980
  AND explanation = $t$Antibodies have a Y-shaped structure with a variable region at each arm tip. The variable region has a unique \(3D\) shape complementary to a specific antigen. Only the matching antigen fits the binding site — like a lock and key. This specificity means each antibody type only targets one antigen.$t$;

UPDATE questions SET
  question_text = $t$Phloem tissue transports sugars from sources to sinks in a plant. Explain what is meant by a 'source' and a 'sink', giving one example of each.$t$
WHERE id = 4005
  AND question_text = $t$Phloem tissue transports sugars from sources to sinks in a plant. Explain what is meant by \(a\) 'source' and \(a\) 'sink', giving one example of each.$t$;

UPDATE questions SET
  explanation = $t$Red light (wavelength ~660–700 nm) is the peak absorption wavelength for chlorophyll a. Photosynthesis would occur at a good rate under red light alone. Blue light also drives photosynthesis but is absent here. Without green light (which chlorophyll reflects), the plant would not be affected — photosynthesis rate would be near normal.$t$
WHERE id = 4008
  AND explanation = $t$Red light (wavelength ~660–700 nm) is the peak absorption wavelength for chlorophyll \(a\). Photosynthesis would occur at a good rate under red light alone. Blue light also drives photosynthesis but is absent here. Without green light (which chlorophyll reflects), the plant would not be affected — photosynthesis rate would be near normal.$t$;

UPDATE questions SET
  question_text = $t$A student calculates the efficiency of energy transfer in a food chain as 15%. Primary producer energy = 10 000 kJ/m². Calculate the energy available to secondary consumers.$t$,
  option_a = $t$225 kJ/m²$t$,
  option_b = $t$22.5 kJ/m²$t$,
  option_c = $t$1500 kJ/m²$t$,
  option_d = $t$15 kJ/m²$t$,
  explanation = $t$Producers → primary consumers: 10 000 × 0.15 = 1500 kJ/m². Primary → secondary consumers: 1500 × 0.15 = 225 kJ/m². Secondary consumers are two transfers from the producers.$t$
WHERE id = 4016
  AND question_text = $t$A student calculates the efficiency of energy transfer in a food chain as 15%. Primary producer energy = \(10\,000\,\text{kJ/m}^{2}\). Calculate the energy available to secondary consumers.$t$
  AND option_a = $t$\(225\,\text{kJ/m}^{2}\)$t$
  AND option_b = $t$\(22.5\,\text{kJ/m}^{2}\)$t$
  AND option_c = $t$\(1500\,\text{kJ/m}^{2}\)$t$
  AND option_d = $t$\(15\,\text{kJ/m}^{2}\)$t$
  AND explanation = $t$Producers → primary consumers: \(10\,000 \times 0.15 = 1500\,\text{kJ/m}^{2}\). Primary → secondary consumers: \(1500 \times 0.15 = 225\,\text{kJ/m}^{2}\). Secondary consumers are two transfers from the producers.$t$;

UPDATE questions SET
  explanation = $t$Glycolysis occurs in the cytoplasm. Glucose (6C) is split into two pyruvate molecules (3C each). It produces a small net gain of 2 ATP and 2 NADH. No oxygen is required for glycolysis — it occurs in both aerobic and anaerobic respiration. The pyruvate then enters the mitochondria if oxygen is available.$t$
WHERE id = 4020
  AND explanation = $t$Glycolysis occurs in the cytoplasm. Glucose \((6C)\) is split into two pyruvate molecules (\(3C\) each). It produces a small net gain of 2 ATP and 2 NADH. No oxygen is required for glycolysis — it occurs in both aerobic and anaerobic respiration. The pyruvate then enters the mitochondria if oxygen is available.$t$;

UPDATE questions SET
  option_a = $t$RQ = 0.7; indicates fat is being respired$t$,
  option_b = $t$RQ = 1.5; indicates a mixture of substrates$t$,
  option_c = $t$RQ = 1.0; this indicates that carbohydrate (glucose) is the sole respiratory substrate because equal volumes of CO₂ are produced and O₂ is consumed$t$,
  option_d = $t$RQ = 0.5; indicates protein is being respired$t$,
  explanation = $t$RQ = CO₂ produced / O₂ consumed. For glucose: C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O. RQ = 6/6 = 1.0. RQ = 1.0 indicates carbohydrate is the sole respiratory substrate. RQ < 1 indicates fat metabolism; RQ > 1 indicates anaerobic respiration occurring alongside aerobic.$t$
WHERE id = 4022
  AND option_a = $t$\(RQ = 0.7\); indicates fat is being respired$t$
  AND option_b = $t$\(RQ = 1.5\); indicates a mixture of substrates$t$
  AND option_c = $t$\(RQ = 1.0\); this indicates that carbohydrate (glucose) is the sole respiratory substrate because equal volumes of CO₂ are produced and O₂ is consumed$t$
  AND option_d = $t$\(RQ = 0.5\); indicates protein is being respired$t$
  AND explanation = $t$RQ = CO₂ produced / O₂ consumed. For glucose: C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O. \(RQ = \frac{6}{6} = 1.0\). \(RQ = 1.0\) indicates carbohydrate is the sole respiratory substrate. \(RQ < 1\) indicates fat metabolism; \(RQ > 1\) indicates anaerobic respiration occurring alongside aerobic.$t$;

UPDATE questions SET
  question_text = $t$A student measures the oxygen consumption of a woodlouse at 15°C and 25°C using a respirometer. The rate at 25°C is twice that at 15°C. Explain this result.$t$,
  option_c = $t$At 25°C, enzyme-catalysed reactions in the mitochondria proceed faster because molecules have more kinetic energy and collision frequency increases; the rate of aerobic respiration approximately doubles for every 10°C rise (Q10 ≈ 2), so oxygen consumption doubles$t$,
  explanation = $t$Higher temperature (25°C vs 15°C) increases the kinetic energy of molecules. Enzyme-catalysed reactions in the mitochondria (Krebs cycle, electron transport chain) proceed faster — more substrate-enzyme collisions per second, more successful reactions. Oxygen consumption increases proportionally with the higher respiration rate.$t$
WHERE id = 4025
  AND question_text = $t$A student measures the oxygen consumption of a woodlouse at \(15^\circ C\) and \(25^\circ C\) using a respirometer. The rate at \(25^\circ C\) is twice that at \(15^\circ C\). Explain this result.$t$
  AND option_c = $t$At \(25^\circ C\), enzyme-catalysed reactions in the mitochondria proceed faster because molecules have more kinetic energy and collision frequency increases; the rate of aerobic respiration approximately doubles for every \(10^\circ C\) rise \((Q10 \approx 2)\), so oxygen consumption doubles$t$
  AND explanation = $t$Higher temperature (\(25^\circ C\) vs \(15^\circ C\)) increases the kinetic energy of molecules. Enzyme-catalysed reactions in the mitochondria (Krebs cycle, electron transport chain) proceed faster — more substrate-enzyme collisions per second, more successful reactions. Oxygen consumption increases proportionally with the higher respiration rate.$t$;

UPDATE questions SET
  option_d = $t$Yeast: glucose → ethanol + carbon dioxide (+ 2 ATP). Human muscle: glucose → lactic acid (+ 2 ATP). The difference occurs because yeast lacks the enzyme to produce lactic acid; instead, pyruvate is decarboxylated to ethanal and then reduced to ethanol by ethanol dehydrogenase.$t$,
  explanation = $t$Anaerobic respiration in yeast: glucose → ethanol + CO₂ (+ 2 ATP). Anaerobic respiration in human muscles: glucose → lactic acid (+ 2 ATP). These are different products — yeast produces ethanol and CO₂; human muscles produce lactic acid (no CO₂). They do NOT both produce "ethanol only".$t$
WHERE id = 4027
  AND option_d = $t$Yeast: glucose → ethanol + carbon dioxide \((+ 2 ATP)\). Human muscle: glucose → lactic acid \((+ 2 ATP)\). The difference occurs because yeast lacks the enzyme to produce lactic acid; instead, pyruvate is decarboxylated to ethanal and then reduced to ethanol by ethanol dehydrogenase.$t$
  AND explanation = $t$Anaerobic respiration in yeast: glucose → ethanol + CO₂ \((+ 2 ATP)\). Anaerobic respiration in human muscles: glucose → lactic acid \((+ 2 ATP)\). These are different products — yeast produces ethanol and CO₂; human muscles produce lactic acid (no CO₂). They do NOT both produce "ethanol only".$t$;

UPDATE questions SET
  explanation = $t$When glycogen is depleted, fat stores are mobilised — fatty acids are converted to acetyl-CoA and enter the Krebs cycle. This is a slower energy source than glucose. Marathon runners may also use some protein catabolism. Fat oxidation has RQ ≈ 0.7 (less CO₂ per O₂); runners breathe differently at "the wall".$t$
WHERE id = 4028
  AND explanation = $t$When glycogen is depleted, fat stores are mobilised — fatty acids are converted to acetyl-CoA and enter the Krebs cycle. This is a slower energy source than glucose. Marathon runners may also use some protein catabolism. Fat oxidation has \(RQ \approx 0.7\) (less CO₂ per O₂); runners breathe differently at "the wall".$t$;

UPDATE questions SET
  option_b = $t$ATP is the universal energy currency because: it releases a small, manageable amount of energy when hydrolysed (ADP + Pᵢ), which is directly usable by enzymes and molecular motors; glucose contains too much energy in a single molecule and cannot directly drive cellular processes. ATP can be rapidly regenerated and used wherever energy is needed in the cell.$t$,
  explanation = $t$ATP (adenosine triphosphate) is the universal energy currency because: it releases a small, manageable amount of energy per hydrolysis (ATP → ADP + Pᵢ); it is immediately available for cellular work; it can be regenerated from ADP using energy from respiration; it couples energy-releasing reactions (respiration) to energy-requiring reactions (muscle contraction, active transport).$t$
WHERE id = 4029
  AND option_b = $t$ATP is the universal energy currency because: it releases a small, manageable amount of energy when hydrolysed (\(ADP + P\)ᵢ), which is directly usable by enzymes and molecular motors; glucose contains too much energy in a single molecule and cannot directly drive cellular processes. ATP can be rapidly regenerated and used wherever energy is needed in the cell.$t$
  AND explanation = $t$ATP (adenosine triphosphate) is the universal energy currency because: it releases a small, manageable amount of energy per hydrolysis (\(ATP \to ADP + P\)ᵢ); it is immediately available for cellular work; it can be regenerated from ADP using energy from respiration; it couples energy-releasing reactions (respiration) to energy-requiring reactions (muscle contraction, active transport).$t$;

UPDATE questions SET
  question_text = $t$Cystic fibrosis is caused by a recessive allele (f). Two carriers (Ff × Ff) have children. What proportion will have cystic fibrosis?$t$,
  option_a = $t$1/2$t$,
  option_b = $t$3/4$t$,
  option_c = $t$1/1$t$,
  option_d = $t$1/4$t$
WHERE id = 4211
  AND question_text = $t$Cystic fibrosis is caused by a recessive allele (\(f\)). Two carriers (Ff × Ff) have children. What proportion will have cystic fibrosis?$t$
  AND option_a = $t$\(\frac{1}{2}\)$t$
  AND option_b = $t$\(\frac{3}{4}\)$t$
  AND option_c = $t$\(\frac{1}{1}\)$t$
  AND option_d = $t$\(\frac{1}{4}\)$t$;

UPDATE questions SET
  explanation = $t$Human body cells (somatic cells) contain 46 chromosomes in 23 pairs — they are diploid. Gametes (sperm and egg) contain 23 chromosomes — they are haploid. At fertilisation, 23 + 23 = 46 chromosomes are restored.$t$
WHERE id = 4214
  AND explanation = $t$Human body cells (somatic cells) contain 46 chromosomes in 23 pairs — they are diploid. Gametes (sperm and egg) contain 23 chromosomes — they are haploid. At fertilisation, \(23 + 23 = 46\) chromosomes are restored.$t$;

UPDATE questions SET
  explanation = $t$TT × tt produces all Tt offspring — heterozygous. Since T is dominant, all show the tall phenotype. No offspring will be dwarf (tt) because the tall parent has no t allele to pass on in this case.$t$
WHERE id = 4216
  AND explanation = $t$\(TT \times tt\) produces all Tt offspring — heterozygous. Since T is dominant, all show the tall phenotype. No offspring will be dwarf (tt) because the tall parent has no \(t\) allele to pass on in this case.$t$;

UPDATE questions SET
  question_text = $t$Red-green colour blindness is X-linked recessive. A carrier woman (X^N X^n) has children with a normal man (X^N Y). What fraction of their sons will be colour blind?$t$,
  option_a = $t$1/4$t$,
  option_b = $t$1/2$t$,
  option_d = $t$3/4$t$,
  explanation = $t$Sons inherit their X chromosome from their mother. X^N X^n × X^N Y gives sons: X^N Y (normal vision) and X^n Y (colour blind) — 50% of sons are colour blind. If the father were also affected, all daughters would be carriers.$t$
WHERE id = 4218
  AND question_text = $t$Red-green colour blindness is X-linked recessive. A carrier woman \((X^{N} X^{n})\) has children with a normal man \((X^{N} Y)\). What fraction of their sons will be colour blind?$t$
  AND option_a = $t$\(\frac{1}{4}\)$t$
  AND option_b = $t$\(\frac{1}{2}\)$t$
  AND option_d = $t$\(\frac{3}{4}\)$t$
  AND explanation = $t$Sons inherit their X chromosome from their mother. \(X^{N} X^{n} \times X^{N} Y\) gives sons: \(X^{N} Y\) (normal vision) and \(X^{n} Y\) (colour blind) — 50% of sons are colour blind. If the father were also affected, all daughters would be carriers.$t$;

UPDATE questions SET
  question_text = $t$When body temperature rises above 37°C, which responses help cool the body down?$t$
WHERE id = 4225
  AND question_text = $t$When body temperature rises above \(37^\circ C\), which responses help cool the body down?$t$;

UPDATE questions SET
  explanation = $t$Alveoli have large surface area (~70 m²), very thin walls (one cell thick), a moist lining for gas dissolving, and rich capillary blood supply to maintain steep concentration gradients. All four adaptations work together for maximum gas exchange efficiency.$t$
WHERE id = 4237
  AND explanation = $t$Alveoli have large surface area (~\(70 m^{2}\)), very thin walls (one cell thick), a moist lining for gas dissolving, and rich capillary blood supply to maintain steep concentration gradients. All four adaptations work together for maximum gas exchange efficiency.$t$;

UPDATE questions SET
  question_text = $t$A cell is viewed under a microscope with total magnification ×400. The cell image is 4 mm wide. What is the actual width of the cell?$t$,
  option_a = $t$1600 µm$t$,
  option_b = $t$400 µm$t$,
  option_c = $t$10 µm$t$,
  option_d = $t$4400 µm$t$,
  explanation = $t$Magnification = image size ÷ actual size. Rearranged: actual size = image size ÷ magnification = 4 mm ÷ 400 = 0.01 mm = 10 µm. Always divide image by magnification — never multiply. Convert units carefully: 0.01 mm = 10 µm.$t$
WHERE id = 4320
  AND question_text = $t$A cell is viewed under a microscope with total magnification \(\times 400\). The cell image is 4 mm wide. What is the actual width of the cell?$t$
  AND option_a = $t$\(1600\,\mu\text{m}\)$t$
  AND option_b = $t$\(400\,\mu\text{m}\)$t$
  AND option_c = $t$\(10\,\mu\text{m}\)$t$
  AND option_d = $t$\(4400\,\mu\text{m}\)$t$
  AND explanation = $t$Magnification = image size ÷ actual size. Rearranged: actual size = image size ÷ magnification \(= 4\,\text{mm} \div 400 = 0.01\,\text{mm} = 10\,\mu\text{m}\). Always divide image by magnification — never multiply. Convert units carefully: 0.01 mm = \(10\,\mu\text{m}\).$t$;

UPDATE questions SET
  explanation = $t$MRI produces detailed 3D images of brain structure and activity without surgery, ionising radiation or physical damage. It allows researchers to identify active brain regions during tasks. Brain lesion studies and electrode implants are more invasive alternatives.$t$
WHERE id = 4338
  AND explanation = $t$MRI produces detailed \(3D\) images of brain structure and activity without surgery, ionising radiation or physical damage. It allows researchers to identify active brain regions during tasks. Brain lesion studies and electrode implants are more invasive alternatives.$t$;

UPDATE questions SET
  explanation = $t$Fermentation is anaerobic respiration in yeast: glucose → ethanol + carbon dioxide (+ 2 ATP). CO₂ makes bread dough rise; ethanol is the alcohol in beer and wine. This process is exploited commercially worldwide and does not require oxygen.$t$
WHERE id = 4385
  AND explanation = $t$Fermentation is anaerobic respiration in yeast: glucose → ethanol + carbon dioxide \((+ 2 ATP)\). CO₂ makes bread dough rise; ethanol is the alcohol in beer and wine. This process is exploited commercially worldwide and does not require oxygen.$t$;

UPDATE questions SET
  explanation = $t$ATP (adenosine triphosphate) is the universal energy currency of cells. When it is hydrolysed to ADP + Pᵢ, a small, controlled amount of energy is released — directly usable to power cellular processes. Glucose stores too much energy in one molecule and cannot power reactions directly.$t$
WHERE id = 4387
  AND explanation = $t$ATP (adenosine triphosphate) is the universal energy currency of cells. When it is hydrolysed to \(ADP + P\)ᵢ, a small, controlled amount of energy is released — directly usable to power cellular processes. Glucose stores too much energy in one molecule and cannot power reactions directly.$t$;

UPDATE questions SET
  question_text = $t$A student measures a yeast culture's CO₂ production at 20°C and 40°C. At 40°C the rate is much higher. Explain this result.$t$,
  option_b = $t$At 40°C, the yeast cells contain more oxygen so respiration is faster$t$,
  option_d = $t$At 40°C the yeast produces more lactic acid instead of CO₂$t$,
  explanation = $t$Higher temperature increases the kinetic energy of molecules — enzyme-substrate collisions occur more frequently and with more energy. The rate of respiration (and therefore CO₂ production) approximately doubles for every 10°C rise up to the optimum temperature.$t$
WHERE id = 4389
  AND question_text = $t$A student measures a yeast culture's CO₂ production at \(20^\circ C\) and \(40^\circ C\). At \(40^\circ C\) the rate is much higher. Explain this result.$t$
  AND option_b = $t$At \(40^\circ C\), the yeast cells contain more oxygen so respiration is faster$t$
  AND option_d = $t$At \(40^\circ C\) the yeast produces more lactic acid instead of CO₂$t$
  AND explanation = $t$Higher temperature increases the kinetic energy of molecules — enzyme-substrate collisions occur more frequently and with more energy. The rate of respiration (and therefore CO₂ production) approximately doubles for every \(10^\circ C\) rise up to the optimum temperature.$t$;

UPDATE questions SET
  question_text = $t$An electron micrograph of a cell shows a mitochondrion 4.8 cm long. The magnification is ×12 000. Calculate the actual length in µm.$t$,
  option_a = $t$576 000 µm$t$,
  option_b = $t$2.5 µm$t$,
  option_c = $t$4 µm$t$,
  option_d = $t$40 µm$t$,
  explanation = $t$Image length = 4.8 cm = 48 000 µm (1 cm = 10 000 µm). Actual length = image ÷ magnification = 48 000 ÷ 12 000 = 4 µm.$t$
WHERE id = 4710
  AND question_text = $t$An electron micrograph of a cell shows a mitochondrion 4.8 cm long. The magnification is \(\times 12\,000\). Calculate the actual length in µ\(m\).$t$
  AND option_a = $t$\(576\,000\,\mu\text{m}\)$t$
  AND option_b = $t$\(2.5\,\mu\text{m}\)$t$
  AND option_c = $t$\(4\,\mu\text{m}\)$t$
  AND option_d = $t$\(40\,\mu\text{m}\)$t$
  AND explanation = $t$Image length \(= 4.8\,\text{cm} = 48\,000\,\mu\text{m}\) (1 cm = \(10\,000\,\mu\text{m}\)). Actual length = image ÷ magnification \(= 48\,000 \div 12\,000 = 4\,\mu\text{m}\).$t$;

UPDATE questions SET
  question_text = $t$An enzyme has Km = 2 mmol/dm³. A second enzyme catalysing the same reaction has Km = 0.5 mmol/dm³. Which has greater affinity for the substrate and why?$t$,
  explanation = $t$Km is the substrate concentration at half-maximal reaction rate. Lower Km = enzyme reaches half-maximal rate at a lower substrate concentration = higher affinity for substrate. Enzyme 2 (Km = 0.5) has 4× greater affinity than Enzyme 1 (Km = 2). Think of Km as an "EC50" — lower is more potent.$t$
WHERE id = 4711
  AND question_text = $t$An enzyme has Km \(= 2\) mmol/\(dm^{3}\). A second enzyme catalysing the same reaction has Km \(= 0.5\) mmol/\(dm^{3}\). Which has greater affinity for the substrate and why?$t$
  AND explanation = $t$Km is the substrate concentration at half-maximal reaction rate. Lower Km = enzyme reaches half-maximal rate at a lower substrate concentration = higher affinity for substrate. Enzyme 2 (Km \(= 0.5\)) has 4× greater affinity than Enzyme 1 (Km \(= 2\)). Think of Km as an "EC50" — lower is more potent.$t$;

UPDATE questions SET
  question_text = $t$A plant cell has water potential −600 kPa and turgor pressure 200 kPa. What is its solute potential?$t$,
  option_a = $t$−400 kPa$t$,
  option_b = $t$−800 kPa$t$,
  option_d = $t$−200 kPa$t$,
  explanation = $t$Water potential (ψ) = solute potential (ψs) + pressure potential (ψp). ψ = ψs + ψp → −600 = ψs + 200 → ψs = −800 kPa. Solute potential is always negative (solutes lower water potential). Turgor pressure is positive (physical pressure from the cell wall pushing inward).$t$
WHERE id = 4713
  AND question_text = $t$A plant cell has water potential \(- 600\,\text{kPa}\) and turgor pressure 200 kPa. What is its solute potential?$t$
  AND option_a = $t$\(- 400\,\text{kPa}\)$t$
  AND option_b = $t$\(- 800\,\text{kPa}\)$t$
  AND option_d = $t$\(- 200\,\text{kPa}\)$t$
  AND explanation = $t$Water potential (ψ) = solute potential (ψ\(s\)) + pressure potential (ψ\(p\)). ψ = ψ\(s\)+ ψ\(p \to - 600\)= ψ\(s + 200\)→ ψ\(s = - 800\,\text{kPa}\). Solute potential is always negative (solutes lower water potential). Turgor pressure is positive (physical pressure from the cell wall pushing inward).$t$;

UPDATE questions SET
  option_c = $t$A base change alters an amino acid in the active/channel region — changing the protein's 3D shape so it can no longer transport Cl⁻ ions$t$,
  explanation = $t$CFTR is a chloride channel whose 3D shape depends on its amino acid sequence. A single base substitution can change one amino acid; if that amino acid is in or near the channel pore, it changes the protein's tertiary structure — the channel no longer opens correctly or at all. The most common CF mutation (ΔF508) deletes a single phenylalanine, causing misfolding.$t$
WHERE id = 4714
  AND option_c = $t$A base change alters an amino acid in the active/channel region — changing the protein's \(3D\) shape so it can no longer transport Cl⁻ ions$t$
  AND explanation = $t$CFTR is a chloride channel whose \(3D\) shape depends on its amino acid sequence. A single base substitution can change one amino acid; if that amino acid is in or near the channel pore, it changes the protein's tertiary structure — the channel no longer opens correctly or at all. The most common CF mutation (ΔF508) deletes a single phenylalanine, causing misfolding.$t$;

UPDATE questions SET
  question_text = $t$The image of a cheek cell measures 24 mm across when viewed at ×400 magnification. Calculate the actual cell diameter in µm.$t$,
  option_a = $t$24 µm$t$,
  option_b = $t$150 µm$t$,
  option_c = $t$600 µm$t$,
  option_d = $t$60 µm$t$,
  explanation = $t$Image size = 24 mm = 24 000 µm. Actual size = image ÷ magnification = 24 000 ÷ 400 = 60 µm.$t$
WHERE id = 4716
  AND question_text = $t$The image of a cheek cell measures 24 mm across when viewed at \(\times 400\) magnification. Calculate the actual cell diameter in µ\(m\).$t$
  AND option_a = $t$\(24\,\mu\text{m}\)$t$
  AND option_b = $t$\(150\,\mu\text{m}\)$t$
  AND option_c = $t$\(600\,\mu\text{m}\)$t$
  AND option_d = $t$\(60\,\mu\text{m}\)$t$
  AND explanation = $t$Image size \(= 24\,\text{mm} = 24\,000\,\mu\text{m}\). Actual size = image ÷ magnification \(= 24\,000 \div 400 = 60\,\mu\text{m}\).$t$;

UPDATE questions SET
  explanation = $t$2 hours ÷ 20 minutes = 6 divisions. Each division doubles the number: 1 → 2 → 4 → 8 → 16 → 32 → 64, so 2⁶ = 64 cells.$t$
WHERE id = 4718
  AND explanation = $t$2 hours \(\div 20\) minutes \(= 6\) divisions. Each division doubles the number: \(1 \to 2 \to 4 \to 8 \to 16 \to 32 \to 64\), so \(2^{6} = 64\) cells.$t$;

UPDATE questions SET
  question_text = $t$A nerve impulse travels along a myelinated axon at 80 m/s. The distance from receptor to spinal cord is 1.2 m. How long does the impulse take to travel this distance?$t$,
  option_d = $t$15 ms — 1.2/80 = 0.015 s$t$,
  explanation = $t$Time = distance/speed = 1.2/80 = 0.015 s = 15 ms. A myelinated axon conducting at 80 m/s — this represents the fastest nerve conduction in the body (large myelinated A-fibres). Unmyelinated C-fibres conduct at only ~0.5 m/s, taking 2.4 seconds for the same distance.$t$
WHERE id = 4720
  AND question_text = $t$A nerve impulse travels along a myelinated axon at \(80\,\text{m/s}\). The distance from receptor to spinal cord is 1.2 m. How long does the impulse take to travel this distance?$t$
  AND option_d = $t$15 ms — \(\frac{1.2}{80} = 0.015\,\text{s}\)$t$
  AND explanation = $t$Time = distance/speed \(= \frac{1.2}{80} = 0.015 s = 15\,\text{ms}\). A myelinated axon conducting at \(80\,\text{m/s}\) — this represents the fastest nerve conduction in the body (large myelinated A-fibres). Unmyelinated C-fibres conduct at only ~\(0.5\,\text{m/s}\), taking 2.4 seconds for the same distance.$t$;

UPDATE questions SET
  question_text = $t$A student's ruler-drop reaction time test gives a drop of 18 cm. Using h = ½gt², calculate their reaction time. (g = 10 m/s²)$t$,
  explanation = $t$h = ½gt², so t = √(2h ÷ g) = √(2 × 0.18 ÷ 10) = √0.036 ≈ 0.19 s. Convert 18 cm to 0.18 m first.$t$
WHERE id = 4724
  AND question_text = $t$A student's ruler-drop reaction time test gives a drop of 18 cm. Using \(h = \tfrac{1}{2}gt^{2}\), calculate their reaction time. (\(g = 10\,\text{m/s}^{2}\))$t$
  AND explanation = $t$\(h = \tfrac{1}{2}gt^{2}\), so \(t = \sqrt{2h \div g} = \sqrt{2 \times 0.18 \div 10} = \sqrt{0.036} \approx 0.19\,\text{s}\). Convert 18 cm to 0.18 m first.$t$;

UPDATE questions SET
  explanation = $t$Maximum impulse frequency = 1/refractory period = 1/0.002 = 500 Hz. The refractory period is the minimum time between two successive action potentials. During this period, sodium channels are inactivated and cannot be reopened. This limits the maximum firing rate and encodes signal intensity as frequency.$t$
WHERE id = 4726
  AND explanation = $t$Maximum impulse frequency \(= 1\)/refractory period \(= \frac{1}{0.002} = 500\,\text{Hz}\). The refractory period is the minimum time between two successive action potentials. During this period, sodium channels are inactivated and cannot be reopened. This limits the maximum firing rate and encodes signal intensity as frequency.$t$;

UPDATE questions SET
  option_a = $t$½ of the molecules — 2 out of 4 molecules each contain one original strand$t$,
  option_c = $t$¼ of the molecules contain original DNA$t$,
  explanation = $t$After two rounds of replication: 4 molecules total. Semi-conservative replication means each new molecule contains one original strand and one new strand. After round 1: 2 molecules each with 1 original strand. After round 2: 4 molecules — 2 still contain an original strand, 2 have only new strands. So 2/4 = ½ of molecules contain original DNA.$t$
WHERE id = 4728
  AND option_a = $t$\(\tfrac{1}{2}\) of the molecules — 2 out of 4 molecules each contain one original strand$t$
  AND option_c = $t$\(\tfrac{1}{4}\) of the molecules contain original DNA$t$
  AND explanation = $t$After two rounds of replication: 4 molecules total. Semi-conservative replication means each new molecule contains one original strand and one new strand. After round 1: 2 molecules each with 1 original strand. After round 2: 4 molecules — 2 still contain an original strand, 2 have only new strands. So \(\frac{2}{4} = \tfrac{1}{2}\) of molecules contain original DNA.$t$;

UPDATE questions SET
  question_text = $t$Thalidomide was prescribed to pregnant women in the 1950s for morning sickness. It caused severe birth defects. Which failure in the drug testing process most directly led to this tragedy?$t$
WHERE id = 4736
  AND question_text = $t$Thalidomide was prescribed to pregnant women in the \(1950s\) for morning sickness. It caused severe birth defects. Which failure in the drug testing process most directly led to this tragedy?$t$;

UPDATE questions SET
  question_text = $t$Antibiotic-resistant MRSA is described as a "superbug". Explain using natural selection how MRSA evolved resistance to methicillin.$t$
WHERE id = 4738
  AND question_text = $t$Antibiotic-resistant MRSA is described as \(a\) "superbug". Explain using natural selection how MRSA evolved resistance to methicillin.$t$;

UPDATE questions SET
  question_text = $t$In an ELISA test for an antigen, the optical density reading is proportional to antigen concentration. A sample gives OD = 0.72. A standard with 36 ng/mL gives OD = 0.48. Estimate the antigen concentration in the sample.$t$,
  explanation = $t$Using direct proportion from the standard: concentration = (OD sample / OD standard) × standard concentration = (0.72/0.48) × 36 = 1.5 × 36 = 54 ng/mL. This assumes a linear relationship between OD and concentration (valid within the linear range of the standard curve).$t$
WHERE id = 4739
  AND question_text = $t$In an ELISA test for an antigen, the optical density reading is proportional to antigen concentration. A sample gives \(OD = 0.72\). A standard with 36 ng/mL gives \(OD = 0.48\). Estimate the antigen concentration in the sample.$t$
  AND explanation = $t$Using direct proportion from the standard: concentration \(=\) (OD sample / OD standard) × standard concentration \(= (\frac{0.72}{0.48}) \times 36 = 1.5 \times 36 = 54\) ng/mL. This assumes a linear relationship between OD and concentration (valid within the linear range of the standard curve).$t$;

UPDATE questions SET
  question_text = $t$The frequency of a dominant allele (A) in a population is p = 0.7. Using Hardy-Weinberg, what is the frequency of homozygous recessive (aa) individuals? (q = 1 − p = 0.3)$t$,
  option_a = $t$q² = 0.09$t$,
  option_b = $t$p² = 0.49$t$,
  option_c = $t$2pq = 0.42$t$,
  option_d = $t$q = 0.3$t$,
  explanation = $t$Hardy-Weinberg: p + q = 1; p² + 2pq + q² = 1. p = 0.7 (dominant allele A), q = 0.3 (recessive allele a). Frequency of homozygous recessive (aa) = q² = 0.3² = 0.09 = 9%. The remaining 91% have at least one A allele (AA = p² = 0.49; Aa = 2pq = 0.42).$t$
WHERE id = 4743
  AND question_text = $t$The frequency of a dominant allele (A) in a population is \(p = 0.7\). Using Hardy-Weinberg, what is the frequency of homozygous recessive (aa) individuals? \((q = 1 - p = 0.3)\)$t$
  AND option_a = $t$\(q^{2} = 0.09\)$t$
  AND option_b = $t$\(p^{2} = 0.49\)$t$
  AND option_c = $t$\(2pq = 0.42\)$t$
  AND option_d = $t$\(q = 0.3\)$t$
  AND explanation = $t$Hardy-Weinberg: \(p + q = 1\); \(p^{2} + 2pq + q^{2} = 1\). \(p = 0.7\) (dominant allele A), \(q = 0.3\) (recessive allele \(a\)). Frequency of homozygous recessive (aa) \(= q^{2} = 0.3^{2} = 0.09 = 9\%\). The remaining 91% have at least one A allele (\(AA = p^{2} = 0.49\); Aa \(= 2pq = 0.42\)).$t$;

UPDATE questions SET
  explanation = $t$A restriction enzyme cuts at every recognition site it encounters. Three copies of GAATTC = 3 cuts. In a circular plasmid, each cut creates a linear fragment, so 3 cuts give 3 linear fragments. The number of cuts equals the number of recognition sites — one cut per site.$t$
WHERE id = 4746
  AND explanation = $t$A restriction enzyme cuts at every recognition site it encounters. Three copies of GAATTC \(= 3\) cuts. In a circular plasmid, each cut creates a linear fragment, so 3 cuts give 3 linear fragments. The number of cuts equals the number of recognition sites — one cut per site.$t$;

UPDATE questions SET
  explanation = $t$Frequency of aa (white) = 160/1000 = 0.16 = q². q = √0.16 = 0.4. p = 1 − 0.4 = 0.6. Frequency of Aa (heterozygous) = 2pq = 2×0.6×0.4 = 0.48. Number of heterozygous mice = 0.48 × 1000 = 480. Hardy-Weinberg allows us to calculate allele and genotype frequencies from observed phenotype frequencies.$t$
WHERE id = 4747
  AND explanation = $t$Frequency of aa (white) \(= \frac{160}{1000} = 0.16 = q^{2}\). \(q = \sqrt{0.16} = 0.4\). \(p = 1 - 0.4 = 0.6\). Frequency of Aa (heterozygous) \(= 2pq = 2 \times 0.6 \times 0.4 = 0.48\). Number of heterozygous mice \(= 0.48 \times 1000 = 480\). Hardy-Weinberg allows us to calculate allele and genotype frequencies from observed phenotype frequencies.$t$;

UPDATE questions SET
  question_text = $t$Using the limiting factor concept, a plant is kept at 25°C with CO₂ at 0.04% and light intensity 500 lux. Doubling light intensity has no effect on photosynthesis rate. Which factor is limiting?$t$
WHERE id = 4750
  AND question_text = $t$Using the limiting factor concept, a plant is kept at \(25^\circ C\) with CO₂ at 0.04% and light intensity 500 lux. Doubling light intensity has no effect on photosynthesis rate. Which factor is limiting?$t$;

UPDATE questions SET
  question_text = $t$A plant produces 10 mmol/s of sucrose in its leaves. Translocation rate through the phloem is measured at 0.4 mm/s. If the phloem sieve tube area is 0.25 mm², calculate the concentration of sucrose in the phloem. (Use: rate = concentration × velocity × area)$t$,
  option_a = $t$100 mmol/mm³$t$,
  option_b = $t$10 mmol/mm³$t$,
  option_c = $t$0.025 mmol/mm³$t$,
  option_d = $t$100 mmol/mm³ — rate = C × v × A; C = rate/(v×A) = 10/(0.4×0.25) = 100 mmol/mm³$t$,
  explanation = $t$Rate = concentration × velocity × area. C = rate/(v×A) = 10/(0.4×0.25) = 10/0.1 = 100 mmol/mm³. This calculation applies the mass flow equation for phloem transport. The high sucrose concentration in phloem (typically 0.3–0.9 mol/L) reflects the active loading mechanism.$t$
WHERE id = 4752
  AND question_text = $t$A plant produces 10 mmol/\(s\) of sucrose in its leaves. Translocation rate through the phloem is measured at \(0.4\,\text{mm/s}\). If the phloem sieve tube area is \(0.25\,\text{mm}^{2}\), calculate the concentration of sucrose in the phloem. (Use: rate = concentration × velocity × area)$t$
  AND option_a = $t$100 mmol/\(mm^{3}\)$t$
  AND option_b = $t$10 mmol/\(mm^{3}\)$t$
  AND option_c = $t$0.025 mmol/\(mm^{3}\)$t$
  AND option_d = $t$100 mmol/\(mm^{3}\) — rate \(= C \times v \times A\); C = rate/\((v \times A) = \frac{10}{0.4 \times 0.25} = 100\) mmol/\(mm^{3}\)$t$
  AND explanation = $t$Rate = concentration × velocity × area. C = rate/\((v \times A) = \frac{10}{0.4 \times 0.25} = \frac{10}{0.1} = 100\) mmol/\(mm^{3}\). This calculation applies the mass flow equation for phloem transport. The high sucrose concentration in phloem (typically 0.3–\(0.9\,\text{mol/L}\)) reflects the active loading mechanism.$t$;

UPDATE questions SET
  question_text = $t$A potometer records 2 cm³ of water uptake per minute by a leafy shoot in still air. Wind speed is increased. Water uptake rises to 8 cm³/min. Explain this change in terms of the water potential gradient.$t$
WHERE id = 4756
  AND question_text = $t$A potometer records \(2\,\text{cm}^{3}\) of water uptake per minute by a leafy shoot in still air. Wind speed is increased. Water uptake rises to 8 \(\text{cm}^{3}\text{/min}\). Explain this change in terms of the water potential gradient.$t$;

UPDATE questions SET
  explanation = $t$The sucrose concentration in sieve tubes (up to 30% w/v) is far higher than in surrounding mesophyll cells — it cannot have moved in by passive diffusion (diffusion goes down the gradient, not up). Metabolic inhibitors (e.g. cyanide, which blocks ATP synthesis) abolish phloem loading — confirming it requires active transport (ATP-driven).$t$
WHERE id = 4757
  AND explanation = $t$The sucrose concentration in sieve tubes (up to \(30\% \frac{w}{v}\)) is far higher than in surrounding mesophyll cells — it cannot have moved in by passive diffusion (diffusion goes down the gradient, not up). Metabolic inhibitors (e.g. cyanide, which blocks ATP synthesis) abolish phloem loading — confirming it requires active transport (ATP-driven).$t$;

UPDATE questions SET
  question_text = $t$The efficiency of energy transfer between two trophic levels is 10%. If 50 000 kJ/m²/yr enters the producers, how much energy is available at the tertiary consumer level?$t$,
  option_a = $t$500 kJ/m²/yr$t$,
  option_b = $t$5000 kJ/m²/yr$t$,
  option_c = $t$50 kJ/m²/yr$t$,
  option_d = $t$50 kJ/m²/yr — 50 000 × 0.1 × 0.1 × 0.1 = 50 kJ/m²/yr$t$,
  explanation = $t$10% efficiency per transfer: producers (50 000) → primary consumers (5000) → secondary consumers (500) → tertiary consumers (50). 50 000 × 0.1 × 0.1 × 0.1 = 50 kJ/m²/yr. Three transfer steps means multiplying by 0.1 three times = multiplying by 0.001. Only 0.1% of primary producer energy reaches the tertiary consumer level.$t$
WHERE id = 4761
  AND question_text = $t$The efficiency of energy transfer between two trophic levels is 10%. If \(50\,000\,\text{kJ/m}^{2}\text{/yr}\) enters the producers, how much energy is available at the tertiary consumer level?$t$
  AND option_a = $t$\(500\,\text{kJ/m}^{2}\text{/yr}\)$t$
  AND option_b = $t$\(5000\,\text{kJ/m}^{2}\text{/yr}\)$t$
  AND option_c = $t$\(50\,\text{kJ/m}^{2}\text{/yr}\)$t$
  AND option_d = $t$\(50\,\text{kJ/m}^{2}\text{/yr}\) — \(50\,000 \times 0.1 \times 0.1 \times 0.1 = 50\,\text{kJ/m}^{2}\text{/yr}\)$t$
  AND explanation = $t$10% efficiency per transfer: producers (50 000) → primary consumers (5000) → secondary consumers (500) → tertiary consumers (50). \(50\,000 \times 0.1 \times 0.1 \times 0.1 = 50\,\text{kJ/m}^{2}\text{/yr}\). Three transfer steps means multiplying by 0.1 three times = multiplying by 0.001. Only 0.1% of primary producer energy reaches the tertiary consumer level.$t$;

UPDATE questions SET
  question_text = $t$A student calculates the net primary productivity (NPP) of a forest as 8 kg C/m²/yr. Gross primary productivity (GPP) is 12 kg C/m²/yr. Calculate the percentage of GPP lost to plant respiration.$t$,
  explanation = $t$Plant respiration = GPP − NPP = 12 − 8 = 4 kg C/m²/yr. As a percentage of GPP: (4/12) × 100 = 33.3%. NPP is what remains after the plant has used energy for its own respiration — it represents the carbon available to consumers. Globally, plants respire about 50% of their GPP.$t$
WHERE id = 4763
  AND question_text = $t$A student calculates the net primary productivity (NPP) of a forest as \(8\,\text{kg}\) \(\frac{C}{m^{2}}\)/yr. Gross primary productivity (GPP) is \(12\,\text{kg}\) \(\frac{C}{m^{2}}\)/yr. Calculate the percentage of GPP lost to plant respiration.$t$
  AND explanation = $t$Plant respiration \(= GPP - NPP = 12 - 8 = 4\,\text{kg}\) \(\frac{C}{m^{2}}\)/yr. As a percentage of GPP: \((\frac{4}{12}) \times 100 = 33.3\%\). NPP is what remains after the plant has used energy for its own respiration — it represents the carbon available to consumers. Globally, plants respire about 50% of their GPP.$t$;

UPDATE questions SET
  explanation = $t$Producer 0.001 ppm → primary consumer 0.01 ppm → secondary consumer 0.1 ppm → tertiary consumer 1 ppm. That is three transfers, each ×10.$t$
WHERE id = 4767
  AND explanation = $t$Producer 0.001 ppm → primary consumer 0.01 ppm → secondary consumer 0.1 ppm → tertiary consumer 1 ppm. That is three transfers, each \(\times 10\).$t$;

UPDATE questions SET
  question_text = $t$RQ = CO₂ produced/O₂ consumed. A resting person has RQ = 0.85. What does this suggest about their respiratory substrate?$t$,
  option_a = $t$They are only metabolising fat (RQ = 0.7)$t$,
  option_b = $t$They are only metabolising carbohydrate (RQ = 1.0)$t$,
  explanation = $t$RQ = CO₂/O₂. For pure carbohydrate: RQ = 1.0. For pure fat: RQ = 0.7. For pure protein: RQ ≈ 0.8. An RQ of 0.85 is between carbohydrate (1.0) and fat (0.7) — indicating a mixture of both substrates. This is typical of a resting person metabolising a mixed diet.$t$
WHERE id = 4770
  AND question_text = $t$RQ = CO₂ produced/O₂ consumed. A resting person has \(RQ = 0.85\). What does this suggest about their respiratory substrate?$t$
  AND option_a = $t$They are only metabolising fat \((RQ = 0.7)\)$t$
  AND option_b = $t$They are only metabolising carbohydrate \((RQ = 1.0)\)$t$
  AND explanation = $t$RQ = CO₂/O₂. For pure carbohydrate: \(RQ = 1.0\). For pure fat: \(RQ = 0.7\). For pure protein: \(RQ \approx 0.8\). An RQ of 0.85 is between carbohydrate (1.0) and fat (0.7) — indicating a mixture of both substrates. This is typical of a resting person metabolising a mixed diet.$t$;

UPDATE questions SET
  explanation = $t$Lactic acid produced in 2 min sprint = 2 × 120 = 240 mmol. Clearance rate = 15 mmol/min. Time to clear = 240/15 = 16 minutes. This is why athletes continue to breathe hard after stopping — the oxygen debt must be repaid to clear the accumulated lactate in the liver (Cori cycle) and muscles.$t$
WHERE id = 4771
  AND explanation = $t$Lactic acid produced in 2 min sprint \(= 2 \times 120 = 240\) mmol. Clearance rate \(= 15\) mmol/min. Time to clear \(= \frac{240}{15} = 16\) minutes. This is why athletes continue to breathe hard after stopping — the oxygen debt must be repaid to clear the accumulated lactate in the liver (Cori cycle) and muscles.$t$;

UPDATE questions SET
  explanation = $t$From the Krebs cycle per glucose (2 turns): 6 NADH and 2 FADH₂. In the ETC: 6 NADH × 2.5 ATP = 15 ATP; 2 FADH₂ × 1.5 ATP = 3 ATP. Total from ETC = 18 ATP. Adding Krebs cycle substrate-level ATP (2) and glycolysis (2) gives ~30-32 total, but from the ETC alone = 18 ATP... the answer D (34 ATP) uses older textbook values. Modern estimates are 28-30 ATP total per glucose.$t$
WHERE id = 4772
  AND explanation = $t$From the Krebs cycle per glucose (2 turns): 6 NADH and 2 FADH₂. In the ETC: \(6 NADH \times 2.5 ATP = 15 ATP\); 2 FADH₂ \(\times 1.5 ATP = 3 ATP\). Total from \(ETC = 18 ATP\). Adding Krebs cycle substrate-level ATP (2) and glycolysis (2) gives ~30–32 total, but from the ETC alone \(= 18 ATP\ldots\) the answer D (34 ATP) uses older textbook values. Modern estimates are 28–30 ATP total per glucose.$t$;

UPDATE questions SET
  question_text = $t$Cyanide blocks cytochrome c oxidase in the electron transport chain. Explain why cyanide poisoning is rapidly fatal even though glycolysis and the Krebs cycle continue.$t$
WHERE id = 4773
  AND question_text = $t$Cyanide blocks cytochrome \(c\) oxidase in the electron transport chain. Explain why cyanide poisoning is rapidly fatal even though glycolysis and the Krebs cycle continue.$t$;

UPDATE questions SET
  question_text = $t$A student measures yeast fermentation by CO₂ production. At 35°C, CO₂ is produced at 4 cm³/min. At 45°C, CO₂ production falls to 1 cm³/min despite faster enzyme kinetics. Explain.$t$,
  option_a = $t$At 45°C, more oxygen is available for aerobic respiration, which does not produce CO₂$t$,
  option_b = $t$At 45°C, CO₂ dissolves more in the medium reducing the measured volume$t$,
  option_c = $t$At 45°C many yeast enzymes are near their denaturation temperature — although uncatalysed reactions speed up, denaturation of key respiratory enzymes reduces their activity, causing an overall decrease in fermentation rate$t$,
  option_d = $t$At 45°C yeast switches to aerobic respiration completely$t$,
  explanation = $t$At 35°C, enzyme kinetics are fast and near-optimal for yeast (optimum ~35-40°C). At 45°C, though uncatalysed reaction rates increase with temperature, yeast enzymes (being proteins) are partially denatured — their active sites lose the precise shape needed for catalysis. Key respiratory enzymes (pyruvate decarboxylase, alcohol dehydrogenase) are denatured, outweighing the kinetic speed-up.$t$
WHERE id = 4774
  AND question_text = $t$A student measures yeast fermentation by CO₂ production. At \(35^\circ C\), CO₂ is produced at 4 \(\text{cm}^{3}\text{/min}\). At \(45^\circ C\), CO₂ production falls to 1 \(\text{cm}^{3}\text{/min}\) despite faster enzyme kinetics. Explain.$t$
  AND option_a = $t$At \(45^\circ C\), more oxygen is available for aerobic respiration, which does not produce CO₂$t$
  AND option_b = $t$At \(45^\circ C\), CO₂ dissolves more in the medium reducing the measured volume$t$
  AND option_c = $t$At \(45^\circ C\) many yeast enzymes are near their denaturation temperature — although uncatalysed reactions speed up, denaturation of key respiratory enzymes reduces their activity, causing an overall decrease in fermentation rate$t$
  AND option_d = $t$At \(45^\circ C\) yeast switches to aerobic respiration completely$t$
  AND explanation = $t$At \(35^\circ C\), enzyme kinetics are fast and near-optimal for yeast (optimum ~35–40°C). At \(45^\circ C\), though uncatalysed reaction rates increase with temperature, yeast enzymes (being proteins) are partially denatured — their active sites lose the precise shape needed for catalysis. Key respiratory enzymes (pyruvate decarboxylase, alcohol dehydrogenase) are denatured, outweighing the kinetic speed-up.$t$;

UPDATE questions SET
  option_b = $t$As muscle glycogen depletes, the runner increasingly relies on fat oxidation (RQ ≈ 0.7). Fat provides more ATP per gram but requires more O₂, hence the lower RER$t$,
  explanation = $t$RER = CO₂ produced/O₂ consumed. Fat oxidation: C₁₆H₃₂O₂ + 23O₂ → 16CO₂ + 16H₂O; RQ = 16/23 = 0.7. As glycogen depletes around mile 18, the runner increasingly oxidises fatty acids (fat oxidation has RQ ≈ 0.7). The shift from 0.95 to 0.75 shows transition from predominantly carbohydrate to predominantly fat metabolism.$t$
WHERE id = 4775
  AND option_b = $t$As muscle glycogen depletes, the runner increasingly relies on fat oxidation \((RQ \approx 0.7)\). Fat provides more ATP per gram but requires more O₂, hence the lower RER$t$
  AND explanation = $t$RER = CO₂ produced/O₂ consumed. Fat oxidation: C₁₆H₃₂O₂ + 23O₂ → 16CO₂ + 16H₂O; \(RQ = \frac{16}{23} = 0.7\). As glycogen depletes around mile 18, the runner increasingly oxidises fatty acids (fat oxidation has \(RQ \approx 0.7\)). The shift from 0.95 to 0.75 shows transition from predominantly carbohydrate to predominantly fat metabolism.$t$;

UPDATE questions SET
  question_text = $t$A cell has 10 mmol of ADP and 10 mmol of Pi available. If the P/O ratio (ATP produced per oxygen atom consumed) is 2.5, how many mmol of O₂ must be consumed to phosphorylate all available ADP?$t$,
  option_d = $t$2 mmol — oxygen atoms needed = 10/2.5 = 4; O₂ molecules (2 atoms) = 2 mmol$t$,
  explanation = $t$ATP available = 10 mmol. Each O₂ atom consumed produces 2.5 ATP (P/O ratio). O atoms needed = 10/2.5 = 4. O₂ molecules = 4/2 = 2 mmol. The P/O ratio relates moles of ATP synthesised to moles of oxygen atoms consumed. O₂ is diatomic — divide atom count by 2 to get molecular O₂.$t$
WHERE id = 4777
  AND question_text = $t$A cell has 10 mmol of ADP and 10 mmol of Pi available. If the \(\frac{P}{O}\) ratio (ATP produced per oxygen atom consumed) is 2.5, how many mmol of O₂ must be consumed to phosphorylate all available ADP?$t$
  AND option_d = $t$2 mmol — oxygen atoms needed \(= \frac{10}{2.5} = 4\); O₂ molecules (2 atoms) \(= 2\) mmol$t$
  AND explanation = $t$ATP available \(= 10\) mmol. Each O₂ atom consumed produces 2.5 ATP (\(\frac{P}{O}\) ratio). O atoms needed \(= \frac{10}{2.5} = 4\). O₂ molecules \(= \frac{4}{2} = 2\) mmol. The \(\frac{P}{O}\) ratio relates moles of ATP synthesised to moles of oxygen atoms consumed. O₂ is diatomic — divide atom count by 2 to get molecular O₂.$t$;

UPDATE questions SET
  question_text = $t$A sprinter has a VO₂ max of 60 mL/kg/min and body mass 75 kg. During a 10 s sprint they consume oxygen at the maximum rate. Calculate total oxygen consumed during the sprint.$t$,
  option_d = $t$VO₂ max = 60 × 75 = 4500 mL/min. In 10 s = 10/60 min: 4500 × 10/60 = 750 mL$t$,
  explanation = $t$VO₂ max rate = 60 mL/kg/min × 75 kg = 4500 mL/min. In 10 s = 10/60 min: O₂ consumed = 4500 × 10/60 = 750 mL. VO₂ max represents the maximum rate of oxygen consumption — the ceiling of aerobic capacity. Elite endurance athletes may have VO₂ max values of 80-90 mL/kg/min.$t$
WHERE id = 4779
  AND question_text = $t$A sprinter has \(a\) VO₂ max of \(60\,\text{mL/kg/min}\) and body mass 75 kg. During a 10 s sprint they consume oxygen at the maximum rate. Calculate total oxygen consumed during the sprint.$t$
  AND option_d = $t$VO₂ \(max = 60 \times 75 = 4500\,\text{mL/min}\). In \(10 s = \frac{10}{60}\,\text{min}\): \(4500 \times \frac{10}{60} = 750\,\text{mL}\)$t$
  AND explanation = $t$VO₂ max rate = \(60\,\text{mL/kg/min}\) \(\times 75\,\text{kg} = 4500\,\text{mL/min}\). In \(10 s = \frac{10}{60}\,\text{min}\): O₂ consumed \(= 4500 \times \frac{10}{60} = 750\,\text{mL}\). VO₂ max represents the maximum rate of oxygen consumption — the ceiling of aerobic capacity. Elite endurance athletes may have VO₂ max values of 80–\(90\,\text{mL/kg/min}\).$t$;

COMMIT;

-- Check: expect 0.
SELECT count(*) AS typeset_rows FROM questions
 WHERE id IN (23,30,51,52,60,252,256,257,258,259,260,285,288,296,305,306,307,310,387,401,402,403,405,406,407,409,410,974,975,980,994,996,1021,1030,1040,1042,1049,1058,1214,1215,1222,1233,1237,1241,1279,1292,1358,1420,1432,1435,1437,1452,1454,1455,1459,1462,1473,1501,1510,1515,1522,1546,1550,1554,1558,1559,1560,1561,1569,1575,1578,1581,1582,1591,1593,1594,1595,1602,1616,1619,1620,1621,1622,1627,1628,1629,1631,1633,1635,1637,1639,1641,1656,1657,1672,1673,1675,1682,1683,1694,1695,1696,1697,1700,1701,1702,1703,1704,1707,1709,1713,1714,1715,1717,1718,1721,1722,1735,1737,1742,1747,1752,1753,1754,1755,1757,1760,1761,1762,1765,1767,1770,1771,1773,1774,1775,1779,1781,1782,1784,1785,1786,1787,1789,1790,1791,1792,1793,1795,1796,1797,1798,1799,1801,1802,1814,1821,1833,1837,1838,1839,1842,1852,1853,1854,1858,1860,1861,1867,1871,1874,1875,1891,1895,1896,1897,1899,1905,1906,1912,1915,1917,1918,1921,1922,1929,1931,1934,1935,1937,1938,1941,1942,1945,1948,1950,1952,1953,1954,1956,1959,1960,1961,1962,1964,1966,1968,1969,1971,1972,1973,1974,1975,1976,1981,1982,1986,1988,1989,1991,1992,1994,1995,2000,2001,2002,2003,2008,2011,2013,2014,2015,2020,2025,2026,2031,2033,2035,2036,2037,2038,2040,2047,2052,2053,2054,2056,2057,2058,2060,2062,2065,2067,2068,2070,2073,2074,2075,2076,2077,2078,2079,2081,2082,2085,2086,2088,2091,2092,2093,2094,2095,2096,2097,2098,2100,2101,2105,2106,2107,2108,2109,2111,2114,2115,2119,2120,2121,2124,2126,2127,2128,2130,2131,2132,2134,2135,2136,2138,2139,2140,2141,2142,2144,2145,2147,2148,2149,2150,2152,2155,2156,2159,2162,2625,2627,2630,2638,2642,2643,2644,2649,2651,2653,2663,2669,2675,2676,2677,2678,2680,2681,2682,2684,2685,2687,2688,2690,2692,2693,2694,2695,2696,2699,2704,2706,2707,2708,2710,2712,2713,2717,2730,2732,2734,2737,2738,2741,2742,2746,2749,2751,2753,2755,2757,2758,2760,2761,2764,2765,2767,2768,2769,2770,2771,2772,2773,2774,2777,2778,2782,2783,2786,2787,2791,2793,2795,2796,2797,2798,2801,2803,2805,2807,2813,2815,2816,2817,2818,2820,2821,2822,2823,2824,2826,2827,2828,2829,2830,2834,2835,2836,2837,2838,2845,2847,2848,2851,2852,2854,2855,2857,2858,2859,2861,2864,2865,2866,2867,2868,2869,2870,2872,2873,2875,2876,2877,2879,2880,2881,2883,2885,2886,2887,2889,2891,2892,2893,2894,3467,3468,3470,3472,3474,3476,3481,3485,3486,3487,3489,3490,3494,3659,3661,3663,3665,3673,3676,3849,3850,3851,3852,3853,3856,3858,3860,3866,3868,3869,3871,3872,3876,3878,3960,3962,3963,3966,3969,3979,3980,4005,4008,4016,4020,4022,4025,4027,4028,4029,4211,4214,4216,4218,4225,4237,4320,4338,4385,4387,4389,4710,4711,4713,4714,4716,4718,4720,4724,4726,4728,4736,4738,4739,4743,4746,4747,4750,4752,4756,4757,4761,4763,4767,4770,4771,4772,4773,4774,4775,4777,4779)
   AND strpos(concat_ws(' ', question_text, option_a, option_b, option_c, option_d, explanation), chr(92) || '(') > 0;
