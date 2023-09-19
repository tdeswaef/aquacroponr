#' A wrapper function for running a sensitivity analysis for AquaCrop using the morris method
#'
#' `aquacrop_morris` operates in 5 steps:
#' 1. Define the morris design in terms of parameters, parameter ranges, trajectories and method. See also the `morris` function in the [sensitivity package]().
#' 2. Run the AquaCrop model with all parameter combinations from the morris design.
#' 3. Choose the level of integration: model time steps, different variables
#' 4. Make an array with the correct dimensions based on the simulations (step 2) and the integration level (step 3).
#' 5. `tell` the array to the morris design from step 1.
#'
#' `r lifecycle::badge('experimental')`
#'
#' @import sensitivity
#' @param situation character string or vector of scenarios to run
#' @param backgroundpar the reference parameter set (as made by `read_CRO`)
#' @param r number of trajectories in the morris algorithm
#' @param binf named vector with lower boundaries of the parameter ranges
#' @param bsup named vector with upper boundaries of the parameter ranges
#' @param design list for designing the morris algorithm
#' @param outvars character vector with output variable names for the sensitivity analysis
#'
#' @returns a list of class `morris`, containing all the input arguments, plus the following components:
#'
#' `call`: the matched call
#'
#' `X` a `data.frame` containing the design of experiments (parameter value combinations)
#'
#' `y` either a vector, a matrix or a three-dimensional array of model responses (depends on the output of model)
#'
#' `ee`:
#'
#' - if y is a vector: a \eqn{(r \times p)} - matrix of elementary effects for all the factors.
#' - if y is a matrix: a \eqn{(r \times p \times ncol(y))} - array of elementary effects for all the factors and all columns of y.
#' - if y is a three-dimensional array: a \eqn{(r \times p \times dim(y)[2] \times dim(y)[3])} - array of elementary effects for all the factors and all elements of the second and third dimension of y.
#'
#' @examples
#' Scenario_s <- design_scenario(name = "S_01",
#'     Plant_Date = as.Date("2019-04-01"),
#'     IRRI = "IRRI_01",
#'     Soil = "Soil_01",
#'     Plu = "Plu_01",
#'     Tnx = "Tnx_01",
#'     ETo = "ETo_01")
#'
#' p <- aquacrop_morris(situation = "S_01", backgroundpar=Spinach, r = 20, binf=c(rt_max = 0.12, cgc = 0.1), bsup = c(rt_max = 0.55, cgc = 0.21), outvars = c("Biomass", "YSdryS"))
#'
#' @export
aquacrop_morris <- function(situation = "S_01",
                            cycle_length,
                            backgroundpar=Spinach,
                            r = r,
                            binf = c(),
                            bsup = c(),
                            design = list(type = "oat", levels = 8, grid.jump = 1),
                            outvars = c("Biomass")
                            ){

  #0. check validity of inputs
  if(!(all(names(binf) %in% names(bsup)) && all(names(bsup) %in% names(binf)))) stop("Check the binf and bsup input data")
  #1. generate the empty Morris design
  mo <- morris(model = NULL,
               factors = names(binf),
               r = r,
               binf = binf,
               bsup = bsup,
               design = design)
  #2. Run the AquaCrop model with all parameter combinations from the morris design.
  Y <- 1:nrow(mo$X) %>%
    map(\(i) aquacrop_wrapper(param_values=mo$X[i,],
                   situation = situation,
                   cycle_length = cycle_length,
                   model_options = list(AQ = AQ, defaultpar=backgroundpar, output = 'df')) %>%
          dplyr::mutate(x = i)) %>%
    list_rbind()

  #3. Choose the level of integration: model time steps, different variables
  filldata <- Y %>%
    select(all_of(outvars), Scenario, x, DAP) %>%
    pivot_longer(cols = all_of(outvars)) %>%
    arrange(name, DAP, x) %>% .$value

  #4. Make an array with the correct dimensions based on the simulations (step 2) and the integration level (step 3).
  a <-array(data = filldata,
            dim = c(nrow(mo$X), max(Y$DAP), length(outvars)),
            dimnames = list(1:nrow(mo$X), 1:max(Y$DAP), outvars))
  # construct the Y variable to 'tell' based on the time steps, variables and scenarios settings

  #5. "tell" the array to the morris design from step 1.
  tell(mo, a)

  return(mo)
}

