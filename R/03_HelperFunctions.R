#' @import stringr

getExtension <- function(file){
  ex <- strsplit(basename(file), split="\\.")[[1]]
  return(ex[-1])
}

splitfun <- function(X){
  A <- stringr::str_split(X, pattern = ":")[[1]]
  return(A[!is.na(suppressWarnings(A %>% as.numeric() ))])
}

checkInputdata <- function(Scenario_, cycle_info, cycle_length){

  input <- (Scenario_s %>% filter(Scenario == Scenario_) %>% .$Tnx) %>% get() %>% tidyr::drop_na()
  input_date <- (Scenario_s %>% filter(Scenario == Scenario_) %>% .$Input_Date)
  plant_date <- (Scenario_s %>% filter(Scenario == Scenario_) %>% .$Plant_Date)

  if(as.numeric(plant_date - i))

  Tmax_fun <- approxfun(input$DAY, input$TMAX)
  Tmin_fun <- approxfun(input$DAY, input$TMIN)
  Tmax <- Tmax_fun(1:max(input$DAY))
  Tmin <- Tmin_fun(1:max(input$DAY))
  Temps <- tibble(Tmin=Tmin, Tmax=Tmax)

  TT_check <- Temps %>% mutate(Tmean = (Tmax+Tmin)/2) %>%
    slice(((plant_date - input_date) %>% as.numeric() + 1):nrow(Temps)) %>%
    mutate(GD = pmax(Tmean-cycle_info[4], 0)) %>%
    mutate(GDD = cumsum(GD))

  GDD_max <- max(TT_check$GDD)


  if(cycle_info[1] == 1){
    if(cycle_info[2] > nrow(TT_check)) stop("The crop cycle length is longer than the available meteo data: adjust the crop parameters or add more meteo data")
    if(cycle_info[2] > cycle_length) stop("The cycle_length is smaller than the crop cycle length: adjust the cycle_length input parameter or the crop parameter cyc_d")
  } else {
    if(cycle_info[3] > GDD_max) {
      stop("The thermal time sum required for maturation is higher than the data provided: adjust the crop parameter (mat_gdd), or add more meteo data")
    } else {
      mat_day <- (TT_check %>% filter(GDD < cycle_info[3]) %>% .$GDD %>% which.max()) + 1
      if(mat_day > cycle_length) stop("The cycle_length is smaller than the crop cycle length: adjust the cycle_length input parameter or the crop parameter mat_gdd")
    }

  }

}
