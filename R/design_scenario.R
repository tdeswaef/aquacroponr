#' Makes the required tibble that is used as scenario argument in the `solve_AquaCrop()` function.
#'
#' @param name character vector with names of the scenarios.
#' @param Input_Date Date format vector with initial input dates for the different scenarios
#' @param Plant_Date Date format vector with planting dates for the different scenarios
#' @param IRRI character vector with names of Irrigation tibble(s)
#' @param Soil character vector with names of Soil tibble(s)
#' @param Plu character vector with names of Precipitation tibble(s)
#' @param Tnx character vector with names of Temperature tibble(s)
#' @param ETo character vector with names of Reference Evapotranspiration tibble(s)
#' @returns A tibble with the different scenarios to run in AquaCrop
#' @export
design_scenario <- function(name, Input_Date, Plant_Date, IRRI, Soil, Plu, Tnx, ETo, FMAN = "default"){
  # if there are more scenario names than scenario's, only retain the first occurrence unique()

  no_scenarios <- length(name)
  if(length(name |> unique()) != no_scenarios) stop("there are non-unique scenario names")
  Scenario_1 <- tibble(Scenario = name)

  # argList <- list(name, Plant_Date, IRRI, Soil, Plu, Tnx, ETo)
  # maxargs <- argList %>% purrr::map(length) %>% purrr::list_c()
  Input_Date <- length_check_fun(Input_Date, no_scenarios)
  Plant_Date <- length_check_fun(Plant_Date, no_scenarios)
  IRRI <- length_check_fun(IRRI, no_scenarios)
  Soil <- length_check_fun(Soil, no_scenarios)
  Plu <- length_check_fun(Plu, no_scenarios)
  Tnx <- length_check_fun(Tnx, no_scenarios)
  ETo <- length_check_fun(ETo, no_scenarios)
  FMAN <- length_check_fun(FMAN, no_scenarios)

  Scenario_2 <- tibble(Input_Date = Input_Date,
                       Plant_Date = Plant_Date,
                       IRRI = IRRI,
                       Soil = Soil,
                       Plu = Plu,
                       Tnx = Tnx,
                       ETo = ETo,
                       FMAN = FMAN) |> unique()

  if(nrow(Scenario_1)==nrow(Scenario_2)){
    Scenario <- Scenario_1 |> bind_cols(Scenario_2)
  } else {
    stop("Scenario names do not match scenarios")
  }

  return(Scenario)

}

length_check_fun <- function(arg, no_scenarios){
  if(length(arg) != 1){
    if(length(arg) == no_scenarios){
      arg_L <- arg
    } else {
      stop(paste0("check the input length of argument", arg))
    }
  } else {
    arg_L <- rep(arg, no_scenarios)
  }
  return(arg_L)
}


