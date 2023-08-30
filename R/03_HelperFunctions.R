#' @import stringr

getExtension <- function(file){
  ex <- strsplit(basename(file), split="\\.")[[1]]
  return(ex[-1])
}

splitfun <- function(X){
  A <- stringr::str_split(X, pattern = ":")[[1]]
  return(A[!is.na(suppressWarnings(A %>% as.numeric() ))])
}
