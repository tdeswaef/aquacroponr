
#' Setup of AquaCrop path
#'
#' Returns the correct the AquaCrop.exe path, while checking the required folder structure. Be aware that the
#' working directory should be set to the the folder where the aquacrop.exe file is located (`setwd()`).
#' @importFrom readr write_lines
#' @param AquaCrop.path character name of the folder where the aquacrop.exe file is located
#' @returns a character name of the path of the aquacrop.exe file, but also writes the \emph{DailyResults.SIM} file in the appropriate folder. file
#' @export
path_config <- function(AquaCrop.path){
  if(!any(file.exists(paste0(AquaCrop.path, c("aquacrop", "aquacrop.exe"))))) stop("No executable file found in Aquacrop folder")

  AquaCrop.data <- "DATA/" #contains files about weather, soil, crop etc
  AquaCrop.simul <- "SIMUL/" #under this location Mauna loa CO2 file is usually located standard when installing AquaCrop plugin
  AquaCrop.list <- "LIST/" #path where project files are generated for AquaCrop to run
  AquaCrop.output <- "OUTP/" #output path for simulations

 # Linux-Windows switch
  OS <- Sys.info()["sysname"]

  if(OS == "Windows"){
    AQ <- paste0(AquaCrop.path, "aquacrop.exe") # AquaCrop executable

    path.data <- gsub('/','\\\\', paste0(AquaCrop.path, AquaCrop.data)) #Creating a windows valid path
    path.simul <- gsub('/','\\\\', paste0(AquaCrop.path, AquaCrop.simul)) #Creating a windows valid path
    path.list <- gsub('/','\\\\', paste0(AquaCrop.path, AquaCrop.list)) #Creating a windows valid path
    path.output <- gsub('/','\\\\',paste0(AquaCrop.path, AquaCrop.output)) #Creating a windows valid path
    
  }else if(OS == "Linux"){
    AQ <- paste0(AquaCrop.path, "aquacrop") # AquaCrop executable

    path.data <- AquaCrop.data
    path.simul <-  AquaCrop.simul
    path.list <- AquaCrop.list
    path.output <- AquaCrop.output

  }

# create directories if not present
  if(!dir.exists(path.data)) dir.create(path.data, recursive = T)
  if(!dir.exists(path.simul)) dir.create(path.simul)
  if(!dir.exists(path.list)) dir.create(path.list)
  if(!dir.exists(path.output)) dir.create(path.output)

  ## Emptying folders before starting
  unlink("OUTP/*")
  unlink("LIST/*")
  return(AQ)
}






