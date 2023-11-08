# this file defines the function to write the temperature file for AquaCrop

# - read the temperature data from a csv file ## Current requirement!!!
# - get the max and min temperature
# - impute missing data


write_Tnx <- function(Scenario_){
  filename <- paste0("DATA/", Scenario_, ".Tnx")
  input <- (Scenario_s %>% filter(Scenario == Scenario_) %>% .$Tnx) %>% get() %>% tidyr::drop_na()

  Tmax_fun <- approxfun(input$DAY, input$TMAX)
  Tmin_fun <- approxfun(input$DAY, input$TMIN)
  Tmax <- Tmax_fun(1:max(input$DAY)) %>% format(digits = 1, nsmall = 1)
  Tmin <- Tmin_fun(1:max(input$DAY)) %>% format(digits = 1, nsmall = 1)
  Temps <- tibble(Tmin=Tmin, Tmax=Tmax)

  YEAR <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Input_Date %>% lubridate::year()
  MONTH <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Input_Date %>% lubridate::month()
  DAY <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Input_Date %>% lubridate::day()

  cat(Scenario_, " daily data from 1 January ", DAY, " ", MONTH, " ", YEAR, "\n",
      "1  : Daily records (1=daily, 2=10-daily and 3=monthly data)\n",
      DAY, "  : First day of record (1, 11 or 21 for 10-day or 1 for months)\n",
      MONTH, "  : First month of record\n",
      YEAR, "  : First year of record (1901 if not linked to a specific year)\n",
      "\n",
      "TMPmin (C)     TMPmax (C)\n",
      "=========================\n",
      file = filename, sep="", append=F)
  write.table(Temps, filename, row.names = F,
              col.names = F, append = TRUE, quote = F) #important: write_delim function doesn't provide output which is correctly read by AquaCrop. (not sure why) Therefore write.table is used
}


