
<!-- README.md is generated from README.Rmd. Please edit that file -->

# AquacropOnR

<!-- badges: start -->
<!-- badges: end -->

The goal of AquacropOnR is to make AquaCrop simulations from within `R`
as easy as possible. The package has currently been tested with the
AquaCrop standalone version 7.0 on Windows. The most recent version can
be downloaded from the [FAO
website](https://www.fao.org/aquacrop/software/aquacropplug-inprogramme/en/#c518670).

## Installation and setup

First install [git](https://git-scm.com/downloads). Then you can install
the development version of `AquacropOnR` using the `devtools` package:

``` r
library(devtools)
devtools::install_git(url = "https://github.com/tdeswaef/aquacroponr.git", force = TRUE)
```

The installation of the AquaCrop standalone version is required.

## Roadmap

- [x] definition of the AquaCrop wrapper function `aquacrop_wrapper`  
- [x] allow option to run AquaCrop on growing degree days instead of
  days  
- [x] include code for running sensitivity analysis using the morris
  method
