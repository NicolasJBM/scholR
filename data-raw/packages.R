library(tidyverse)

versions <- as.data.frame(installed.packages()) %>%
  dplyr::select(package = Package, version = Version)

dat_packages <- read_csv("data-raw/packages.csv") %>%
  dplyr::select(-version) %>%
  dplyr::left_join(versions, by = "package")

save(dat_packages, file = "data/dat_packages.RData")
