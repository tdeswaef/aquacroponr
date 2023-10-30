
# This file generates the climate files required for AquaCrop
# It consists of
# - writing the .CL file, which lists the files with the actual data
# - reading the meteo data from the KMI source
# - writing the .Plu, .Tnx and .ETo files with the data

###Climate file
write_CLI <- function(Scenario_){
  filename <- paste0("DATA/", Scenario_, ".CLI")
  Plant_Date <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Plant_Date

  cat('Climate file starting on 1 January ', year(Input_Date), '\n',
      '7.0  : AquaCrop Version (August 2022)\n',
      paste0(Scenario_,  ".Tnx\n"),
      paste0(Scenario_,  ".ETo\n"),
      paste0(Scenario_,  ".PLU\n"),
      "MaunaLoa.CO2"
      , file = filename, sep="", append=F)
}



