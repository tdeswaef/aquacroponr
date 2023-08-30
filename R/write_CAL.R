# This file generates the calendar file required for AquaCrop

#' @import dplyr
#' @import magrittr
#' @import lubridate
write_CAL <- function(Scenario_){
  filename <- paste0("DATA/", Scenario_, ".CAL")
  Plant_Date <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Plant_Date %>% yday()
  cat('Calendar file ', Scenario_, ' \n',
      '7.0  : AquaCrop Version (August 2022)\n',
      '0    : The onset of the growing period is fixed on a specific date\n',
      '1    : Day-number (Table 6) of the Start of the time window for the onset criterion\n',
      '1    : Length (days) of the time window for the onset criterion\n',
      Plant_Date, '  : Day-number (Table 6) for the onset of the growing period if fixed on a specific date (switch = 0 in line 3)\n',
      '-9   :  Value of the onset criterion (in mm , mm/day, °C, degree-days, or percentage of Rain/ETo ratio)\n',
      '-9   :  Number of successive days for the onset criterion (days)\n',
      '-9   :  Number of occurrences before the onset criterion applies (max = 3)',
      file = filename, sep="", append=F)
}


