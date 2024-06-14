###Groundwater file (fixed depth)
# GWT <- 2.0

write_GWT <- function(Scenario_){
  filename <- paste("DATA/", Scenario_,".GWT", sep="")
  GWT <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$GWT %>% format(nsmall = 1)
  cat('Groundwater table\n',
      '7.0   : AquaCrop Version (August 2022)
      1     : groundwater table at fixed depth and with constant salinity

      Day    Depth (m)    ECw (dS/m)
      ====================================
        1   ',GWT,'         0.0',file = filename, append=F, sep = "    ")
}
#write_GWT("S_01", GWT)
