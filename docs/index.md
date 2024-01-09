
## About

<!-- badges: start -->
<!-- badges: end -->

The goal of AquacropOnR is to make AquaCrop simulations from within `R`
as easy as possible. The installation of the AquaCrop standalone version is required. The package has currently been tested with the
AquaCrop standalone version 7.1 on Windows. The most recent version can
be downloaded from the [FAO
website](https://www.fao.org/aquacrop/software/aquacropplug-inprogramme/en/#c518670).

## Installation and setup

You can install the development version of `AquacropOnR` using the `devtools` package:

``` r
library(devtools)
devtools::install_github(repo = "https://github.com/tdeswaef/aquacroponr.git", force = TRUE)
```

## Documentation and examples 
- [Info on the AquaCrop crop parameter names and their meaning](cropparameters.md)
- [A simple example of the workflow for a spinach crop](example.md)
