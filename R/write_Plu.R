###Rainfall file


write_Plu <- function(Scenario_){
  filename <- paste0("DATA/", Scenario_, ".PLU")
  input <- (Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Plu) %>% get() %>% tidyr::drop_na()

  Precip_fun <- approxfun(input$DOY, input$PLU)
  Precip <- Precip_fun(1:365) %>% format(digits = 1, nsmall=1)

  YEAR <- Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Plant_Date %>% lubridate::year()

  cat(Scenario_, " daily rainfall: 1 January ", YEAR, " - 31 December ", YEAR, "\n",
      "1  : Daily records (1=daily, 2=10-daily and 3=monthly data)\n",
      "1  : First day of record (1, 11 or 21 for 10-day or 1 for months)\n",
      "1  : First month of record\n",
      YEAR, "  : First year of record (1901 if not linked to a specific year)\n",
      "\n",
      "Total rain (mm)","\n",
      "=====================\n",
      file = filename, sep="", append=F)
  write.table(Precip, filename, row.names = F,
              col.names = F, append = TRUE, quote = F)
}


