###Irrigation file

## Specification of irrigation events: useful for calibration purposes
write_IRR_ev <- function(Scenario_){
  filename <- paste0("DATA/", Scenario_, ".IRR")
  irri <- IRRI_s %>% dplyr::filter(ID == (Scenario_s %>% filter(Scenario == Scenario_) %>% .$IRRI)) %>%
    dplyr::select(Timing, Depth, ECw) %>%
    dplyr::mutate(Timing = round(Timing), Depth = round(Depth), ECw = format(ECw, digits = 1, nsmall = 1))

  if(nrow(irri) == 0){
    irri <- tibble(Timing = 10, Depth = 0, ECw = format(0, digits = 1, nsmall = 1))
  }

  cat(Scenario_,' Irrigation file\n',
      '7.0    : AquaCrop Version (August 2022)\n',
      '1      : Sprinkler irrigation\n',
      '100    : Percentage of soil surface wetted by irrigation\n',
      '1      : Specification of irrigation events\n',
      '-9     : Reference DayNr for Day 1 (-9 if reference day is the onset of the growing period)\n',
      "Day    Depth (mm)   ECw (dS/m)\n",
      "=====================\n",
      file = filename, sep="", append=F)
  write.table(x = irri, file = filename,
              row.names = F, col.names = F, append = T, quote = F)
}

## AquaCrop-generated irrigation scheduling (example for depletion of 40% RAW and refill to Field capacity)
## scenario analysis, irrigation scheduling
write_IRR_Gen <- function(Scenario_){
  filename <- paste0("DATA/", Scenario_, "_gen.IRR")
  cat('Generation of irrigation schedule for sprinkler irrigation starting from DAP=1 when 40% RAW is depleted back to FC\n',
      '7.0   : AquaCrop Version (August 2022)\n',
      '1     : Sprinkler irrigation\n',
      '100   : Percentage of soil surface wetted by irrigation\n',
      '2     : Generation of irrigation schedule\n',
      '3     : Time criterion = allowable depletion (% of RAW)\n',
      '1     : Depth criterion = back to FC',
      "\n",
      "From day    Depleted RAW (%)   Back to Fc (+/- mm)   ECw (dS/m)\n",
      "===============================================================\n",
      "  1               40                  0                  0.0     ",
      file = filename, sep="", append=F)
}
