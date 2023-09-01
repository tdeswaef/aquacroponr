#' A wrapper function for running AquaCrop for use in CroptimizR package
#'
#' `aquacrop_wrapper` takes parameter values as an input for an AquaCrop simulation and returns a result list as requested by the
#' `CroptimizR` package.
#' `r lifecycle::badge('experimental')`
#' @import dplyr
#' @import purrr
#' @import readr
#' @param param_values list of crop parameters to modify from the default
#' @param situation character vector of scenario names as listed in the Scenario_s tibble
#' @param model_options list of model options
#' @returns a dataframe of daily outputs of AquaCrop, concatenated over the different scenario's.
#'
#'
#' @export
aquacrop_wrapper <- function(param_values, situation, model_options, ...){
  #check the required initial steps
  if(!file.exists("aquacrop.exe")) stop("set your working directory to the AquaCrop.path")
  if(!dir.exists("DATA/")) stop("run the Path_config function first")
  #if(!exists(quote(model_options$defaultpar))) stop("the default parameter file is not loaded, use the read_CRO function first")


  # Create crop parameter file
  cycle_length <- write_CRO(param_values, model_options$defaultpar)
  # for now, the Ground Water Table is fixed
  GWT <- 2.0
  # create project, meteo, soil, management,... files
  createfiles(Exp_list = situation, cycle_length = cycle_length, GWT = GWT)

  ###########################################
  # Run Aquacrop for all the created projects

  system(model_options$AQ)

  #############
  # Read output

  df_out <- list.files("OUTP/", pattern = "PROday.OUT", full.names = F) %>%
    purrr::map_dfr(~readoutput(.x))

  unlink("OUTP/*")
  unlink("LIST/*")

  return(df_out)
}
#'
#'
#'
readoutput <- function(outputfile){
  df <- readr::read_table(file = paste0("OUTP/", outputfile),  skip = 4, col_names = F)
  names(df) <- readr::read_table(file = paste0("OUTP/", outputfile),  skip = 2, col_names = F)[1,]
  df <- df %>%
    dplyr::select(which(!duplicated(names(.)))) %>%
    dplyr::mutate(Scenario = gsub("PROday.OUT", "", outputfile))
  names(df) <- gsub("[()/.]", "S", names(df))
  return(df)
}


# # Link to CroptimizR
# results$sim_list <- setNames(vector("list",length(situation)), nm = situation)
#
# attr(results$sim_list, "class") <- "cropr_simulation"

