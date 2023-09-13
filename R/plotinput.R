#' plot the the input data for quality control
#'
#' `plotinput()` takes the scenario tibble as an input, checks whether the scenario tibble is correctly designed, and the required data are correctly loaded. If successful,
#' it produces a ggplot with visualization of the input data
#' @import ggplot2
#' @import purrr
#' @param Scenario_s is the tibble with designed scenarios (designed with `design_scenario()`)
#'
#' @returns ggplots with input data (in RStudio: check the 'Plots' tab) and tables for irrigation and soils (in RStudio: check the 'Viewer' tab)
#' @examples
#' plotinput(Scenario_s)
#'
#' @export
plotinput <- function(Scenario_s){

  data_irri <- Scenario_s %>% select(IRRI) %>% left_join(IRRI_s, by = c("IRRI" = "ID")) %>%
    gt()
  data_soil <- Scenario_s %>% select(Soil) %>% left_join(SOL_s, by = c("Soil" = "ID")) %>%
    gt()
  data_precip <- get_data(Scenario_s, "Plu") %>%
    imap(plot_plu)
  data_temp <- get_data(Scenario_s, "Tnx") %>%
    imap(plot_tmp)
  data_ETo <- get_data(Scenario_s, "ETo") %>%
    imap(plot_eto)
  # plot TMAX, TMIN, PRECIP and ETo

  #make plot_list
  plot_list <- c(data_precip, data_temp, data_ETo)
  print(plot_list)
  print(data_irri)
  print(data_soil)
}



get_data <- function(Scenario_s, inputvar){
  return(Scenario_s %>% select(matches(inputvar)) %>% unlist() %>% purrr::map(get))
}

plot_plu <- function(plu_data, ids){
  ggplot(data = plu_data) +
    theme_bw() +
    geom_col(mapping = aes(DOY, PLU)) +
    labs(title = ids)
}

plot_tmp <- function(tmp_data, ids){
  ggplot(data = tmp_data) +
    theme_bw() +
    geom_line(mapping = aes(DOY, TMAX), color= 'red') +
    geom_line(mapping = aes(DOY, TMIN), color= 'blue') +
    labs(title = ids)
}

plot_eto <- function(eto_data, ids){
  ggplot(data = eto_data) +
    theme_bw() +
    geom_line(mapping = aes(DOY, ETo)) +
    labs(title = ids)
}


