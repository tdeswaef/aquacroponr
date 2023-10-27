###########################################################################################
# Soil file

# 1. Calculates following features based on the soil parameter input:
# - Relative Extractable Water (REW) #https://www.fao.org/3/br267e/br267e.pdf page 345
# - Capillary Rise parameters CRa and CRb #https://www.fao.org/3/br267e/br267e.pdf page 344
# - Curve Number based on Ksat #https://www.fao.org/3/br267e/br267e.pdf page 225

# 2. Writes the data into the .SOL file

############################################################################################


## calculation of REW https://www.fao.org/3/br267e/br267e.pdf page 345

REW_fun <- function(FC, PWP){
  REW <- 10 *(FC - PWP / 2) *0.04
  REW <- max(0, REW)
  REW <-  min(15, REW)
  return(REW)
}



SoilClass_fun <- function(SAT, FC, PWP, Ksat){
  if(PWP >= 20){
    if(SAT >= 49 && FC >= 40){
      SoilClass <- 4 # silty clayey soils
    } else {
      SoilClass <- 3 # sandy clayey soils
    }
  } else {
    if(FC <= 23){
      SoilClass <- 1 # sandy soil
    } else {
      if(PWP > 16 && Ksat < 100){
        SoilClass <- 3 # sandy clayey soils
      } else {
        if(PWP < 6 && FC < 28 && Ksat > 750){
          SoilClass <- 1 # sandy soil
        } else {
          SoilClass <- 2 # loamy soil
        }
      }
    }
  }
  return(SoilClass)
}

CR_fun <- function(SAT, FC, PWP, Ksat){
  SoilClass_ <- SoilClass_fun(SAT, FC, PWP, Ksat)
  #" calculation of the CRa and CRb parameters based on the soil type class (A-B) 'capillary rise' #https://www.fao.org/3/br267e/br267e.pdf page 344
  CR_Tibble <- tibble::tibble(SoilClass = 1:4,
                      a_0 = c(-0.3112, -0.4986, -0.5677, -0.6366),
                      a_1 = c(-1e-5, 9e-5, -4e-5, 8e-4),
                      b_0 = c(-1.4936, -2.1320, -3.7189, -1.9165),
                      b_1 = c(0.2416, 0.4778, 0.5922, 0.7063))
  CR_parm <- CR_Tibble %>% dplyr::filter(SoilClass == SoilClass_)
  CRa <- CR_parm$a_0 + CR_parm$a_1*Ksat
  CRb <- CR_parm$b_0 + CR_parm$b_1*log(Ksat)
  return(tibble::tibble(CRa = CRa, CRb = CRb))
}


## calculation of the CN parameter based on the Ksat
CN_fun <- function(Ksat){
  if(Ksat > 864){
    CN <- 46
  } else {
    if(dplyr::between(Ksat, 347, 864)){
      CN <- 61
    } else {
      if(dplyr::between(Ksat, 36, 347)){
        CN <- 72
      } else {
        CN <- 77
      }
    }
  }
  return(CN)
}


## the write function for .SOL

write_SOL <- function(Scenario_){
  filename <- paste("DATA/", Scenario_,".SOL", sep="")
  SOL <- SOL_s %>% dplyr::filter(ID == (Scenario_s %>% dplyr::filter(Scenario == Scenario_) %>% .$Soil)) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(CRa = CR_fun(SAT, FC, WP, Ksat) %>% .$CRa ,
                  CRb = CR_fun(SAT, FC, WP, Ksat) %>% .$CRb ,
                  description = "placeholder")

  cat(Scenario_, "\n",
      '7.0        : AquaCrop Version (August 2022)\n',
      CN_fun(SOL$Ksat[1]),'         : CN (Curve Number)\n',
      REW_fun(FC = SOL$FC[1], PWP = SOL$WP[1]) %>% round(),'         : Readily evaporable water from top layer (mm)\n',
      max(SOL$Horizon),'           : number of soil horizons
      -9          : variable no longer applicable
      Thickness  Sat   FC    WP     Ksat   Penetrability  Gravel   CRa        CRb           description
      ---(m)-   ----(vol %)-----  (mm/day)      (%)        (%)    -----------------------------------------\n',
      file = filename, append=F, sep = "    ")

  SOL_write <- SOL %>%
    dplyr::mutate(Thickness = format(Thickness, digits = 1, nsmall = 2),
                  SAT = format(SAT, digits = 1, nsmall = 1),
                  FC = format(FC, digits = 1, nsmall = 1),
                  WP = format(WP, digits = 1, nsmall = 1),
                  Ksat = format(Ksat, digits = 1, nsmall = 1),
                  Penetrability = format(Penetrability, digits = 1, nsmall = 0),
                  Gravel = format(Gravel, digits = 1, nsmall = 0),
                  CRa = format(CRa, digits = 1, nsmall = 6),
                  CRb = format(CRb, digits = 1, nsmall = 6)) %>%
    dplyr::select(!c(ID, Horizon))
  write.table(SOL_write,
              filename, row.names = F,
              col.names = F, append = TRUE, quote = F)
}


