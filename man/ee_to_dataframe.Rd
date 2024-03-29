% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ee_to_tibble.R
\name{ee_to_dataframe}
\alias{ee_to_dataframe}
\title{Transform the elemental effects array into a tibble}
\usage{
ee_to_dataframe(p, situation, cycle_length)
}
\arguments{
\item{p}{is the output of the \code{aquacrop_morris} function}

\item{situation}{are the situations listed in the \code{\link[=aquacrop_morris]{aquacrop_morris()}} function}

\item{cycle_length}{is the cycle_length parameter in the \code{\link[=aquacrop_morris]{aquacrop_morris()}} function}
}
\value{
a tibble with 6 variables: traject, par, DAP, outvar, ee and Scenario
}
\description{
\code{ee_to_dataframe} takes the morris output and transforms the 4-dimensional
elemental effects array into a more useful tibble
}
\details{
The resulting tibble has 6 variables:
\itemize{
\item \code{traject}: refers to the trajectory number in the Morris design
\item \code{par}: the parameters that for which the sensitivity is evaluated
\item \code{DAP}: the Days After Planting of the simulation as we save a time series
\item \code{outvar}: the output variables for which the sensitivity is evaluated
\item \code{ee}: the elemental effects as output from the \code{\link[=aquacrop_morris]{aquacrop_morris()}} function. These elemental effects are scaled for the parameter range (see \code{\link[sensitivity:morris]{sensitivity::morris()}}).
\item \code{Scenario}: the scenarios for which the simulation was done
}
}
