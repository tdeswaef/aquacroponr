###Field management file


write_MAN <- function(Scenario_){
  filename <- paste0("DATA/", Scenario_, ".MAN")
  man <- FMAN_s %>% dplyr::filter(ID == (Scenario_s %>% filter(Scenario == Scenario_) %>% .$FMAN)) %>%
    dplyr::mutate(mulch_perc  = round(mulch_perc), mulch_eff = round(mulch_eff),
                  fert_stress = round(fert_stress), soil_bunds = format(soil_bunds, digits = 1, nsmall = 2),
                  runoff_aff = round(runoff_aff), CN_eff = round(CN_eff),
                  weed_clo = round(weed_clo), weed_mid = round(weed_mid),
                  weed_cc = format(weed_cc, digits = 1, nsmall = 2))

  if(nrow(man) == 0){
    man <- tibble(mulch_perc = 0, mulch_eff = 50, fert_stress = 0,
                  soil_bunds = format(0, digits = 1, nsmall = 2),
                  runoff_aff = 0, CN_eff=0, weed_clo=0, weed_mid = 0, weed_cc = format(-0.01, digits = 1, nsmall = 2))
  }

  cat(Scenario_,' field management file\n',
      '7.1    : AquaCrop Version (August 2022)\n',
      man$mulch_perc, '      : Percentage of ground surface covered by mulches\n',
      man$mulch_eff, '    : Percentage effect of mulch on evaporation\n',
      man$fert_stress, '      : Percentage of soil fertility stress\n',
      man$soil_bunds, '     : Height (m) of soil bunds\n',
      man$runoff_aff, "   : Surface runoff is (not) affected by field practices\n",
      man$CN_eff, "    : Percent increase/decrease of soil profile CN value\n",
      man$weed_clo , "    : Weed presence at canopy closure\n",
      man$weed_mid , "    : increase of relative cover of weeds in mid-season (+%)\n",
      man$weed_cc, "      : shape factor of the CC expansion function in a weed infested field\n",
      "100      : replacement (%) by weeds of the self-thinned part of the CC - only for perennials\n",
      "0         : Multiple cuttings are not considered\n",
      "30         : Canopy cover (%) after cutting - not considered\n",
      "-9         : parameter no longer considered\n",
      "1         : First day of window for multiple cuttings (1 = start of growth cycle)\n",
      "-9         : Number of days in window for multiple cuttings (-9 = total growth cycle)\n",
      "-9         : Timing of multiple cuttings: Not Applicable\n",
      "0         : Time criterion: Not Applicable\n",
      "0         : final harvest at crop maturity is not considered\n",
      "-9         : Start of the growing cycle is Day 1 in list of cuttings",
      file = filename, sep="", append=F)
}


FMAN_s <- tibble(ID = "default", mulch_perc = 0, mulch_eff = 50, fert_stress = 0,
                 soil_bunds = 0,
                 runoff_aff = 0, CN_eff=0, weed_clo=0, weed_mid = 0, weed_cc = -0.01)
