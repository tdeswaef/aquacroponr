#' Read a .CRO file and return it as a list
#' @import readr
#' @import purrr
#'
#' @param default_crop file path of the .CRO file to be read.
#' @returns a named list with crop parameter name-value pairs.
#' @details The crop file required for AquaCrop 7.0 and higher requires 83 lines of content.
#' Crop files generated using previous AquaCrop versions, typically contain less lines (76).
#' The `read_CRO` function detects whether the file has sufficient length, and complements the file if needed.
#' @export
read_CRO <- function(default_crop){
  listA <- readr::read_lines(default_crop) %>%
    purrr::map(~splitfun(.x)) %>% purrr::flatten() %>% as.numeric()

  if(length(listA==76)){
    listA <- append(listA, c(90,0,0,0,0,0,0))
  }

  listA <- listA %>% as.list()
  names(listA) <- names(Digit_requirements_fun())
  return(listA)
}

