#' Transform the elemental effects array into a tibble
#'
#' `ee_to_dataframe` takes the morris output and transforms the 4-dimensional
#' elemental effects array into a more useful tibble
#'
#' @import reshape2
#'
#' @param p is the output of the `aquacrop_morris` function
#' @param situation are the situations listed in the [aquacrop_morris()] function
#' @param cycle_length is the cycle_length parameter in the [aquacrop_morris()] function
#' @returns a tibble with 6 variables: traject, par, DAP, outvar, ee and Scenario
#'
#' @details
#' The resulting tibble has 6 variables:
#' - `traject`: refers to the trajectory number in the Morris design
#' - `par`: the parameters that for which the sensitivity is evaluated
#' - `DAP`: the Days After Planting of the simulation as we save a time series
#' - `outvar`: the output variables for which the sensitivity is evaluated
#' - `ee`: the elemental effects as output from the [aquacrop_morris()] function. These elemental effects are scaled for the parameter range (see [sensitivity::morris()]).
#' - `Scenario`: the scenarios for which the simulation was done
#'
#' @export
ee_to_dataframe <- function(p, situation, cycle_length){
  scenario <- sort(situation)
  EE <- p$ee %>%
    melt(value.name = "ee", varnames = c("traject", "par", "DAP", "outvar")) %>%
    dplyr::mutate(Scenario = scenario[((DAP - 1) %/% cycle_length)+1]) %>%
    dplyr::mutate(DAP = ((DAP-1) %% cycle_length) +1)
  return(EE)
}

#'
#'
