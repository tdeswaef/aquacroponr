
varnames_fun <- function(Daily_output, soil_prof){
  names_1 = c("WC_prof", "Rain", "Irri", "Surf", "Infilt", "RO", "Drain", "CR", "Zgwt",
              "Ex", "E", "E_rel", "Trx", "Tr", "Tr_rel", "ETx", "ET", "ET_rel") # 18
  names_2 = c("GD", "Z", "StExp", "StSto", "StSen", "StSalt", "StWeed",
              "CC", "CCw", "StTr", "KcTr", "Trx", "Tr", "TrW", "Tr_rel", "WP",
              "Biomass", "HI", "Ydry", "Yfresh", "Brelative", "WPet", "Bin", "Bout") # 24
  names_3 = c("WC_prof", "WC_rtmax", "Z", "WC_rteff", "WC_SAT_rteff", "WC_FC_rteff",
              "WC_exp_rteff", "WC_sto_rteff", "WC_sen_rteff", "WC_PWP_rteff") # 10
  names_4 = c("SaltIn", "SaltOut", "SaltUp", "Salt_prof", "SaltZ", "Z",
              "ECe", "ECsw", "StSalt", "Zgwt", "ECgw") # 11
  names_5 = c("WC01", "WC02", "WC03", "WC04", "WC05", "WC06",
              "WC07", "WC08", "WC09", "WC10", "WC11", "WC12") # 12
  names_6 = c("ECe01", "ECe02", "ECe03", "ECe04", "ECe05", "ECe06",
              "ECe07", "ECe08", "ECe09", "ECe10", "ECe11", "ECe12") # 12
  names_7 = c("Rain", "ETo", "Tmin", "Tavg", "Tmax", "CO2") # 6
  names_0 = c("Day", "Month", "Year", "DAP", "Stage")
  names_list <- list(names_1, names_2, names_3, names_4,
                     names_5[1:min(soil_prof, 12)], names_6[1:min(soil_prof,12)], names_7, names_0)
  return(c(names_0, names_list[Daily_output] %>% unlist() %>% unname()))
}




