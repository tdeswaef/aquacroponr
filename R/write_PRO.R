###Project file
# This file generates the project file for each scenario
# the function requires following arguments:
# - Scenario_ : a string that identifies your scenario. This scenario is defined in the tibble 'Scenario_s'


# It produces an AquaCrop project file with the name 'Scenario_.PRO'


#(yday(Harvest_Date) + (year(Harvest_Date)-1901)*365.25) %>% as.integer()

write_PRO <- function(Scenario_, cycle_length){
  filename <- paste0("LIST/", Scenario_, ".PRO")
  path.data <- gsub('/','\\\\', paste0(getwd(), "/DATA/")) #Creating a windows valid path
  path.simul <- gsub('/','\\\\', paste0(getwd(), "/SIMUL/"))
  Plant_Date <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Plant_Date
  Plant_input <- (yday(Plant_Date) + (year(Plant_Date)-1901)*365.25) %>% as.integer()
  Harvest_input <- Plant_input + round(cycle_length[2]) - 1  #130 is the duration of the growing season in the crop file

  cat("Project file\n",
      "7.0     : AquaCrop Version (August 2022)\n",
      "1       : Year number of cultivation (Seeding/planting year)\n",
      Plant_input ,"   : First day of simulation period\n",   #always put a space after the number. Aquacrop reads first string to perform simulation.
      Harvest_input ,"   : Last day of simulation period\n",
      Plant_input ,"   : First day of cropping period\n",
      Harvest_input ,"   : Last day of cropping period
-- 1. Climate (CLI) file\n",
      "    ", Scenario_,".CLI\n",
      "    ", path.data, "\n",
      "   1.1 Temperature (Tnx or TMP) file\n",
      "    ", Scenario_, ".Tnx\n",
      "    ", path.data, "\n",
      "   1.2 Reference ET (ETo) file\n",
      "    ", Scenario_, ".ETo\n",
      "    ", path.data, "\n",
      "   1.3 Rain (PLU) file\n",
      "    ", Scenario_,".PLU\n",
      "    ", path.data, "\n",
      "   1.4 Atmospheric CO2 concentration (CO2) file
    MaunaLoa.CO2\n",
      "    ", path.simul, "\n",
      "-- 2. Calendar (CAL) file\n",
      "    ", Scenario_,".CAL\n",
      "    ", path.data, "\n",
      "-- 3. Crop (CRO) file\n",
    "Crop.CRO\n",
      "    ", path.data,"\n",
      "-- 4. Irrigation management (IRR) file\n",
      "    ", Scenario_,".IRR\n",
      "    ", path.data, "\n",
      "-- 5. Field management (MAN) file
        (None)
        (None)
-- 6. Soil profile (SOL) file\n",
      "    ", Scenario_, ".SOL\n",
      "    ", path.data,"\n",
      "-- 7. Groundwater table (GWT) file\n",
      "    ", Scenario_, ".GWT\n",
      "    ", path.data,"\n",
      "-- 8. Initial conditions (SW0) file\n",
      "    ", Scenario_,".SW0\n",
      "    ", path.data, "\n",
      "-- 9. Off-season conditions (OFF) file
        (None)
        (None)
-- 10. Field data (OBS) file
        (None)
        (None)",
      file = filename, sep="", append=F)
}


