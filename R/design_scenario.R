#' Makes the required tibble that is used as scenario argument in the `aquacrop_wrapper` function.
#'
#' @param name character vector with names of the scenarios.
#' @param Input_Date Date format vector with initial input dates for the different scenarios
#' @param Sim_Date Date format vector with dates for starting simulation. if NULL, set to Plant_Date
#' @param Plant_Date Date format vector with planting dates for the different scenarios
#' @param IRRI character vector with names for the ID in the IRRI_s tibble
#' @param Soil character vector with names of Soil tibble(s)
#' @param Plu character vector with names of Precipitation tibble(s)
#' @param Tnx character vector with names of Temperature tibble(s)
#' @param ETo character vector with names of Reference Evapotranspiration tibble(s)
#' @param FMAN character vector with names for the ID in the FMAN_s tibble
#' @param GWT numeric vector with depth of ground water table in m
#' @param SW0 character vector with names for the ID in the SW0_s tibble. If "FC" initial conditions are taken from SOL_s tibble.
#' @returns A tibble with the different scenarios to run in AquaCrop
#' @export
design_scenario <- function(name, Input_Date, Sim_Date = NULL, Plant_Date, IRRI, Soil, Plu, Tnx, ETo, FMAN = "default", GWT = 2.0, SW0 = "FC"){
  # if there are more scenario names than scenario's, only retain the first occurrence unique()

  no_scenarios <- length(name)
  if(length(name |> unique()) != no_scenarios) stop("there are non-unique scenario names")
  if(is.null(Sim_Date)) Sim_Date = Plant_Date
  Scenario_1 <- tibble(Scenario = name)

  # argList <- list(name, Plant_Date, IRRI, Soil, Plu, Tnx, ETo)
  # maxargs <- argList %>% purrr::map(length) %>% purrr::list_c()
  Input_Date <- length_check_fun(Input_Date, no_scenarios)
  Sim_Date <- length_check_fun(Sim_Date, no_scenarios)
  Plant_Date <- length_check_fun(Plant_Date, no_scenarios)
  IRRI <- length_check_fun(IRRI, no_scenarios)
  Soil <- length_check_fun(Soil, no_scenarios)
  Plu <- length_check_fun(Plu, no_scenarios)
  Tnx <- length_check_fun(Tnx, no_scenarios)
  ETo <- length_check_fun(ETo, no_scenarios)
  FMAN <- length_check_fun(FMAN, no_scenarios)
  GWT <- length_check_fun(GWT, no_scenarios)
  SW0 <- length_check_fun(SW0, no_scenarios)

  Scenario_2 <- tibble(Input_Date = Input_Date,
                       Sim_Date = Sim_Date,
                       Plant_Date = Plant_Date,
                       IRRI = IRRI,
                       Soil = Soil,
                       Plu = Plu,
                       Tnx = Tnx,
                       ETo = ETo,
                       FMAN = FMAN,
                       GWT = GWT,
                       SW0 = SW0) |> unique()

  if(nrow(Scenario_1)==nrow(Scenario_2)){
    Scenario <- Scenario_1 |> bind_cols(Scenario_2)
  } else {
    stop("Scenario names do not match scenario number")
  }

  # check if Scenario needs growth length

  diffmax <- (Scenario$Plant_Date - Scenario$Sim_Date) %>% as.numeric %>% max
  if(any(Scenario$Plant_Date < Scenario$Sim_Date)) warning("Some of the planting dates are earlier than the start of simulation. Is this intentionally?")
  if(any(Scenario$Plant_Date != Scenario$Sim_Date)) message(cat("Some of the planting dates differ from the start of the simulation.\nThe maximum difference is",
                                                                diffmax, "days.\ncycle_length should be at least", diffmax, "higher than growth_length."))

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


