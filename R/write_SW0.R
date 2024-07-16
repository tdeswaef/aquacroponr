###Initial conditions

## In the absence of a file with initial conditions, it is assumed that in the soil profile (i) the
## soil water content is at field capacity and (ii) salts are absent at the start of the simulation.

write_SW0 <- function(Scenario_){
  filename <- paste0("DATA/", Scenario_, ".SW0")
  SW0_ID <- Scenario_s %>% filter(Scenario == Scenario_) %>% .$SW0
  SOL <- SOL_s %>%
    dplyr::filter(ID == (Scenario_s %>% filter(Scenario == Scenario_) %>% .$Soil)) %>%
    dplyr::mutate(ECe = format(0.00, digits = 1, nsmall = 2),
                  Thickness = format(Thickness, digits = 1, nsmall = 2),
                  WC = format(FC, digits = 1, nsmall = 2))

  if(SW0_ID == "FC"){
    SW0 <- SOL
  } else {
    SW0 <- SW0_s %>%
      dplyr::filter(ID == (Scenario_s %>% filter(Scenario == Scenario_) %>% .$SW0)) %>%
      dplyr::mutate(ECe = format(ECe, digits = 1, nsmall = 2),
                    Thickness = format(Thickness, digits = 1, nsmall = 2),
                    WC = format(WC, digits = 1, nsmall = 2))
  }
  if(nrow(SOL) != nrow(SW0)) stop("the number of layers in soil data does not match the number of layers in initial conditions")

  cat('Initial conditions
    7.1   : AquaCrop Version (August 2023)
    -9.00 : initial canopy cover that can be reached without water stress will be used as default
    0.000 : biomass (ton/ha) produced before the start of the simulation period
    -9.00 : initial effective rooting depth that can be reached without water stress will be used as default
    0.0   : water layer (mm) stored between soil bunds (if present)
    0.00  : electrical conductivity (dS/m) of water layer stored between soil bunds (if present)
    0     : soil water content specified at particular depths (linear interpolation applied)\n',
    max(SOL$Horizon),'   : number of layers considered

     Soil depth (m)     Water content (vol%)     ECe (dS/m)
==============================================================\n',
      file = filename, sep="", append=F)
    write.table(x = SW0 %>%  dplyr::select(Thickness, WC, ECe), file = filename,
                row.names = F, col.names = F, append = T, quote = F)
}

#write_SW0(Scenario_)
