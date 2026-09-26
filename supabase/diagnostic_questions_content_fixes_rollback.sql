-- Rollback for diagnostic_questions_content_fixes.sql: restores the exact
-- text those 55 rows had on 2026-09-26.

BEGIN;

UPDATE diagnostic_questions SET
  misconception_d = $t$Used incorrect formula, possibly confused with momentum$t$,
  updated_at = now()
WHERE id = 1 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_c = $t$Weight equals air resistance — resultant force is zero$t$,
  updated_at = now()
WHERE id = 4 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_a = $t$Energy cannot be created or destroyed — only transferred or transformed$t$,
  option_c = $t$Energy can be created by burning fuel$t$,
  updated_at = now()
WHERE id = 7 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_d = $t$250 m/s$t$,
  misconception_a = $t$Multiplied frequency × wavelength correctly but made an arithmetic error: \(200 \times 0.5 = 100\), not 400$t$,
  misconception_b = $t$Divided wavelength by frequency: \(\frac{0.5}{200}\)$t$,
  misconception_d = $t$Used an incorrect rearrangement of the wave equation$t$,
  updated_at = now()
WHERE id = 9 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Frequency changes with medium — this is incorrect. Frequency is determined by the source$t$,
  updated_at = now()
WHERE id = 11 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$Multiplied \(V \times I\) instead of dividing: \(12 \times 3 = 36\)$t$,
  misconception_c = $t$Inverted: \(\frac{I}{V} = \frac{3}{12} = 0.25\)$t$,
  misconception_d = $t$Used an incorrect formula$t$,
  updated_at = now()
WHERE id = 13 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Added resistances directly — this is for series circuits, not parallel$t$,
  misconception_c = $t$Used average of the two values$t$,
  misconception_d = $t$Multiplied instead of using the parallel formula$t$,
  updated_at = now()
WHERE id = 14 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Divided \(V\) by \(I\): \(\frac{230}{8}\) — confused power formula with resistance$t$,
  misconception_b = $t$Added \(V + I = 238\) — meaningless calculation$t$,
  misconception_d = $t$Used \(P = \frac{V^{2}}{I}\) or similar incorrect formula$t$,
  updated_at = now()
WHERE id = 15 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_a = $t$Always parallel to the magnetic field$t$,
  option_d = $t$Perpendicular to both the current and the magnetic field$t$,
  updated_at = now()
WHERE id = 17 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Multiplied instead of divided: \(240 \times \frac{200}{50} = 960\) — inverted the ratio$t$,
  misconception_c = $t$Subtracted turns: \(240 \times \frac{200 - 50}{200}\)$t$,
  updated_at = now()
WHERE id = 19 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_b = $t$Increasing the current or using a stronger magnetic field$t$,
  updated_at = now()
WHERE id = 20 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_a = $t$The energy is used to break intermolecular bonds, not increase kinetic energy$t$,
  updated_at = now()
WHERE id = 23 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Multiplied mass × volume instead of dividing$t$,
  misconception_b = $t$Inverted: \(\frac{\text{volume}}{\text{mass}} = \frac{150}{300} = 0.5\)$t$,
  misconception_d = $t$Divided by 100 or made a decimal error$t$,
  updated_at = now()
WHERE id = 24 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$This describes beta-minus decay (neutron → proton + electron)$t$,
  updated_at = now()
WHERE id = 26 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_c = $t$Neutron radiation is not on the AQA GCSE specification$t$,
  updated_at = now()
WHERE id = 28 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Sequence is wrong — main sequence comes first, then nebula is the start$t$,
  updated_at = now()
WHERE id = 29 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_a = $t$Multiplied \(Q \times t\) instead of dividing: \(120 \times 40 = 4800\)$t$,
  misconception_c = $t$Added \(Q + t = 160\), then divided incorrectly$t$,
  misconception_d = $t$Inverted: \(\frac{t}{Q} = \frac{40}{120} = 0.33\)$t$,
  updated_at = now()
WHERE id = 33 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_c = $t$2.4 Ω$t$,
  option_d = $t$3.33 Ω$t$,
  misconception_b = $t$Multiplied all three values together$t$,
  misconception_c = $t$Used parallel formula instead of series: \(\frac{1}{R} = \frac{1}{4} + \frac{1}{6} + \frac{1}{10}\)$t$,
  misconception_d = $t$Used average: \(\frac{4 + 6 + 10}{3} = 6.67\)$t$,
  updated_at = now()
WHERE id = 35 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  option_b = $t$AC periodically reverses direction; DC flows in one direction only$t$,
  updated_at = now()
WHERE id = 36 AND subject = 'Physics';

UPDATE diagnostic_questions SET
  misconception_b = $t$£30 is the SMALLER share (3 parts \(\times \text{£}10\) per part) — the question asks specifically for the larger share.$t$,
  misconception_c = $t$This treats the larger share as simply \(\frac{3}{5}\) of the total \((\text{£}80 \times 0.6 = \text{£}48)\) — but the ratio \(3 : 5\) has 8 total parts, so the larger share is 5 OUT OF 8 parts, not 5 out of 5.$t$,
  misconception_d = $t$Splitting £80 exactly in half ignores the ratio entirely — a ratio of 3:5 specifically means an UNEQUAL split, not a 50:50 share.$t$,
  updated_at = now()
WHERE id = 183 AND subject = 'Mathematics';

UPDATE diagnostic_questions SET
  option_a = $t$They have the same number of protons$t$,
  option_c = $t$They have the same number of electrons in their outer shell$t$,
  updated_at = now()
WHERE id = 245 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Delocalised electrons are free to move throughout the structure$t$,
  option_c = $t$Metal atoms are arranged in a rigid lattice$t$,
  option_d = $t$Metal atoms share electrons in fixed pairs$t$,
  updated_at = now()
WHERE id = 248 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Every carbon atom in diamond forms 4 covalent bonds, leaving no free electrons; graphite's carbons form only 3 bonds each, leaving one delocalised electron per atom$t$,
  option_b = $t$Diamond has stronger covalent bonds than graphite$t$,
  option_c = $t$Diamond is a metal and graphite is not$t$,
  option_d = $t$Graphite has ionic bonds between its layers$t$,
  misconception_c = $t$Neither diamond nor graphite is a metal — both are non-metal giant covalent structures made entirely of carbon.$t$,
  misconception_d = $t$Graphite's layers are held together by weak forces between layers, not ionic bonds — the bonding within each layer is covalent.$t$,
  updated_at = now()
WHERE id = 249 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  misconception_a = $t$This adds only one oxygen instead of two — CO₂ contains two oxygen atoms, not one.$t$,
  misconception_b = $t$This doubles the oxygen contribution incorrectly — check the calculation: \(12 + (16 \times 2) = 44\), not 32.$t$,
  misconception_d = $t$This is the mass of oxygen alone, ignoring the carbon atom entirely.$t$,
  updated_at = now()
WHERE id = 250 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_d = $t$Reactant B, because it runs out first and limits the reaction$t$,
  updated_at = now()
WHERE id = 252 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$At the cathode (negative electrode), because Pb²⁺ ions are attracted there and gain electrons$t$,
  option_c = $t$At the anode, because bromide ions are attracted there$t$,
  option_d = $t$Lead is produced at both electrodes equally$t$,
  misconception_c = $t$Bromide ions (Br⁻) are the ones attracted to the anode, not lead ions — this mixes up which ion goes to which electrode.$t$,
  updated_at = now()
WHERE id = 255 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$The total energy released by the reaction$t$,
  option_d = $t$The minimum energy that colliding particles need for a reaction to occur$t$,
  updated_at = now()
WHERE id = 261 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_b = $t$The particles must collide, and with enough energy (at least the activation energy)$t$,
  updated_at = now()
WHERE id = 262 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Particles become larger and collide more easily$t$,
  option_b = $t$Particles move faster, so they collide more often and with more energy$t$,
  option_c = $t$The activation energy of the reaction decreases$t$,
  option_d = $t$Particles become less concentrated$t$,
  misconception_a = $t$Increasing temperature does not change the size of particles — it changes how fast they move.$t$,
  misconception_d = $t$Temperature does not directly change concentration — heating a fixed amount of reactant in a fixed volume does not reduce how much of it is present.$t$,
  updated_at = now()
WHERE id = 263 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_b = $t$A reaction between two reversible metals$t$,
  option_d = $t$A reaction where the products can react together to reform the original reactants$t$,
  misconception_b = $t$"Reversible metals" is not a real chemistry term — reversibility describes the reaction itself, not a property of specific metals.$t$,
  updated_at = now()
WHERE id = 264 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$It shifts towards the reactants, favouring the backward (endothermic) reaction$t$,
  updated_at = now()
WHERE id = 265 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$They contain only single covalent bonds between carbon atoms$t$,
  option_d = $t$They contain only carbon atoms, no hydrogen$t$,
  updated_at = now()
WHERE id = 266 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_c = $t$To produce shorter, more useful hydrocarbons, including alkenes for making polymers$t$,
  updated_at = now()
WHERE id = 267 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$It is more soluble in the mobile phase (the solvent) relative to the stationary phase$t$,
  option_c = $t$It has a larger relative formula mass$t$,
  updated_at = now()
WHERE id = 270 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$Hold a lit splint to the gas — a squeaky pop confirms carbon dioxide$t$,
  option_b = $t$Test the gas with damp litmus paper — it turns red if carbon dioxide is present$t$,
  option_c = $t$Hold a glowing splint in the gas — it relights if carbon dioxide is present$t$,
  option_d = $t$Bubble the gas through limewater — it turns cloudy/milky if carbon dioxide is present$t$,
  misconception_b = $t$Damp litmus paper turning red (and bleaching white) is associated with testing for chlorine gas, not carbon dioxide.$t$,
  updated_at = now()
WHERE id = 272 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$The mass of carbon it physically contains$t$,
  option_b = $t$The total amount of carbon dioxide and other greenhouse gases released over its full life cycle$t$,
  updated_at = now()
WHERE id = 276 AND subject = 'Chemistry';

UPDATE diagnostic_questions SET
  option_a = $t$It has no nucleus — its DNA lies free in the cytoplasm$t$,
  option_b = $t$It contains genetic material$t$,
  option_c = $t$It has a cell membrane$t$,
  option_d = $t$It is always larger than a eukaryotic cell$t$,
  updated_at = now()
WHERE id = 278 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_c = $t$The tail allows swimming towards the egg, and the many mitochondria provide the energy needed for this movement$t$,
  updated_at = now()
WHERE id = 279 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$Glucose moves into the cell by diffusion$t$,
  option_d = $t$Water moves out of the cell by osmosis, and the cell becomes flaccid/plasmolysed$t$,
  updated_at = now()
WHERE id = 280 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_c = $t$To produce two genetically identical daughter cells, for growth and repair of tissues$t$,
  updated_at = now()
WHERE id = 281 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$The active site changes shape, so the substrate can no longer bind to it$t$,
  updated_at = now()
WHERE id = 282 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$Arteries carry blood back to the heart, so need to be strong; veins carry blood away from the heart at low pressure$t$,
  option_c = $t$Arteries carry blood at high pressure away from the heart; veins carry blood at lower pressure back to the heart and need valves to prevent backflow$t$,
  updated_at = now()
WHERE id = 284 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_c = $t$Xylem transports water and minerals upward from the roots; phloem transports dissolved sugars (produced by photosynthesis) around the plant$t$,
  updated_at = now()
WHERE id = 285 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$It introduces a small, safe amount of dead or inactive pathogen, causing white blood cells to produce antibodies and "remember" that pathogen$t$,
  option_c = $t$It removes the person's ability to catch any disease at all$t$,
  updated_at = now()
WHERE id = 287 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_d = $t$Antibiotics target processes specific to bacterial cells, which viruses do not have, since viruses are not living cells$t$,
  updated_at = now()
WHERE id = 288 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$Droplet infection — through coughing or sneezing, releasing pathogen-containing droplets into the air$t$,
  updated_at = now()
WHERE id = 289 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$Light intensity is no longer the limiting factor; some other factor, such as carbon dioxide concentration or temperature, is now limiting the rate$t$,
  option_b = $t$The plant has stopped photosynthesising entirely$t$,
  misconception_b = $t$A levelling-off rate means photosynthesis is continuing at a steady rate, not that it has stopped entirely.$t$,
  updated_at = now()
WHERE id = 291 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_d = $t$Lactic acid builds up, which can cause muscle fatigue and cramp$t$,
  updated_at = now()
WHERE id = 293 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$Effector → receptor → coordinator → stimulus$t$,
  option_b = $t$Response → stimulus → receptor → effector$t$,
  option_c = $t$Stimulus → receptor → coordinator (CNS) → effector → response$t$,
  option_d = $t$Stimulus → effector → receptor → coordinator$t$,
  misconception_a = $t$This lists the pathway components in reverse order, starting from the effector rather than ending with it.$t$,
  misconception_b = $t$This starts with "response," which should come at the end of the pathway, after the effector has acted, not at the beginning.$t$,
  misconception_d = $t$This has the effector and receptor in the wrong order — the receptor detects the stimulus first, before any signal reaches the coordinator or effector.$t$,
  updated_at = now()
WHERE id = 294 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_a = $t$The pancreas releases insulin, which causes cells (especially in the liver) to take up glucose from the blood and store it as glycogen$t$,
  option_d = $t$The liver stops producing glycogen entirely$t$,
  updated_at = now()
WHERE id = 295 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_c = $t$The pathway (reflex arc) bypasses conscious processing in the brain, going directly from sensory neurone to relay neurone to motor neurone, often via the spinal cord$t$,
  updated_at = now()
WHERE id = 297 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_d = $t$A double helix, found mainly in the nucleus of the cell$t$,
  updated_at = now()
WHERE id = 298 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_d = $t$The proportion of darker insects would increase, because they are more likely to survive and reproduce, passing on the alleles for dark colour$t$,
  updated_at = now()
WHERE id = 300 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$The gradual change in the inherited characteristics of a population over many generations$t$,
  option_c = $t$The process by which an individual organism learns new skills$t$,
  misconception_c = $t$Evolution is not about an individual learning new skills during its lifetime — those skills are not passed on genetically, and learning is a different process entirely from evolutionary, inherited change.$t$,
  updated_at = now()
WHERE id = 301 AND subject = 'Biology';

UPDATE diagnostic_questions SET
  option_b = $t$Abiotic, because temperature is a non-living, physical/chemical factor affecting the organisms in the ecosystem$t$,
  updated_at = now()
WHERE id = 305 AND subject = 'Biology';

COMMIT;
