###Evapotranspiration file


write_ETo <- function(Scenario_){
  filename <- paste0("DATA/", Scenario_, ".ETo")
  input <- (Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$ETo) %>% get() %>% tidyr::drop_na()

  ETo_fun <- approxfun(input$DOY, input$ETo)
  ETo <- (ETo_fun(1:nrow(input)) + 1e-6) %>% format(digits = 1, nsmall = 1)

  YEAR <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Plant_Date %>% lubridate::year()
  MONTH <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Input_Date %>% lubridate::month()
  DAY <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Input_Date %>% lubridate::day()

  cat(Scenario_, " daily reference evapotranspiration (ETo): 1 January ", YEAR, " - 31 December ", YEAR, "\n",
      "1  : Daily records (1=daily, 2=10-daily and 3=monthly data)\n",
      DAY, "  : First day of record (1, 11 or 21 for 10-day or 1 for months)\n",
      MONTH, "  : First month of record\n",
      YEAR, "  : First year of record (1901 if not linked to a specific year)\n",
      "\n",
      "Average ETo (mm/day)\n",
      "=====================\n",
      file = filename, sep="", append=F)
  write.table(ETo, filename, row.names = F, col.names = F, append = TRUE, quote = F)
}


