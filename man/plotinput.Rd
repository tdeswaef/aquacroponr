% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotinput.R
\name{plotinput}
\alias{plotinput}
\title{plot the the input data for quality control}
\usage{
plotinput(Scenario_s)
}
\arguments{
\item{Scenario_s}{is the tibble with designed scenarios (designed with \code{design_scenario()})}
}
\value{
ggplots with input data (in RStudio: check the 'Plots' tab) and tables for irrigation and soils (in RStudio: check the 'Viewer' tab)
}
\description{
\code{plotinput()} takes the scenario tibble as an input, checks whether the scenario tibble is correctly designed, and the required data are correctly loaded. If successful,
it produces a ggplot with visualization of the input data
}
\examples{
\dontrun{plotinput(Scenario_s)}

}
