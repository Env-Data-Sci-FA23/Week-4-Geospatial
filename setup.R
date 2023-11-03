# Set up script


# function to check for package installation, then install and load libraries
packageLoad <-
  function(x) {
    for (i in 1:length(x)) {
      if (!x[i] %in% installed.packages()) {
        install.packages(x[i])
      }
      library(x[i], character.only = TRUE)
    }
  }


# vector of packages to load
packages <- c('tidyverse',
              'palmerpenguins',
              'sf',
              'terra',
              'tmap',
              'rmarkdown',
              'tigris',
              'elevatr',
              'rgbif',
              'soilDB',
              'plotly')

packageLoad(packages)

