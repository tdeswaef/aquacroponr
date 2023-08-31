#' A wrapper function for running AquaCrop
#'
#' `solve_AquaCrop` takes parameter values as an input for an AquaCrop simulation and returns a dataframe as an output
#' @import dplyr
#' @import purrr
#' @import readr
#' @param croppar list of crop parameters to modify from the default
#' @param defaultpar list of default parameter values
#' @param scenario_s character vector of scenario names as listed in the Scenario_s tibble
#' @returns a dataframe of daily outputs of AquaCrop, concatenated over the different scenario's.
#'
#'
#' @export
solve_AquaCrop <- function(croppar, defaultpar, scenario_s){
  #check the required initial steps
  if(!file.exists("aquacrop.exe")) stop("set your working directory to the AquaCrop.path")
  if(!dir.exists("DATA/")) stop("run the Path_config function first")
  if(!exists(quote(defaultpar))) stop("the default parameter file is not loaded, use the read_CRO function first")


  # Create crop parameter file
  cycle_length <- write_CRO(croppar, defaultpar)
  # for now, the Ground Water Table is fixed
  GWT <- 2.0
  # create project, meteo, soil, management,... files
  createfiles(scenario_s, cycle_length, GWT)

  ###########################################
  # Run Aquacrop for all the created projects

  system(AQ)

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

