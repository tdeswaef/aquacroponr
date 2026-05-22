##################################################################
# CO2 file
##################################################################

write_CO2 <- function(Scenario_){
  filename <- paste0("SIMUL/", Scenario_, ".CO2")
  input <- (Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$CO2) %>% get() %>% tidyr::drop_na()
  CO2_conc <- input %>% mutate(CO2 = format(CO2, digits = 1, nsmall = 1))

  cat(Scenario_, " CO2 concentration\n",
      "Year    CO2 (ppm by volume)\n",
      "=====================\n",
      file = filename, sep="", append=F)
  write.table(CO2_conc, filename, row.names = F, col.names = F, append = TRUE, quote = F)
}
