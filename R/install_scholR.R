#' @name install_scholR
#' @title Install scholR packages
#' @author Nicolas Mangin
#' @description Function installing packages required by, and from, the scholR environment.
#' @param preinstall_requisites Logical. Whether packages necessary for all other scholR pachages should be pre-installed.
#' @param install_for_education Logical. Whether packages from the education universe should be installed.
#' @param install_for_research Logical. Whether packages from the research universe should be installed.
#' @param keep_existing Logical. Whether already installed packages should be reinstalled.
#' @importFrom devtools install_github
#' @importFrom dplyr bind_rows
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom tibble tribble
#' @export



install_scholR <- function(
    preinstall_requisites = FALSE,
    install_for_education = TRUE,
    install_for_research = FALSE,
    keep_existing = TRUE
){
  
  Package <- NULL
  Version <- NULL
  required_packages <- NULL
  
  cran_packages <- tibble::tribble(
    ~"Package", ~"Version",
    "tools", "4.3.1",
    "devtools", "2.4.5",
    "tinytex", "0.45",
    "shinyFiles", "O.9.3",
    "markdown", "1.7",
    "RJSONIO", "1.3-1.8",
    "quarto", "1.2"
  )
  
  required_packages <- scholR::required_packages |>
    dplyr::filter(!(Package %in% cran_packages$Package)) |>
    base::unique()
  
  already_installed <- utils::installed.packages() |>
    base::as.data.frame() |>
    dplyr::select(Package, Version)
  
  if (keep_existing){
    cran_packages <- cran_packages |>
      dplyr::filter(!(Package %in% already_installed$Package)) |>
      base::unique()
    required_packages <- required_packages |>
      dplyr::filter(!(Package %in% already_installed$Package)) |>
      base::unique()
  }
  
  if (preinstall_requisites){
    install_from_cran <- cran_packages |>
      dplyr::bind_rows(required_packages)
  } else install_from_cran <- cran_packages
  
  for (i in base::seq_len(base::nrow(install_from_cran))){
    utils::install.packages(install_from_cran$Package[i])
  }
  
  scholR_education_packages <- c(
    "NicolasJBM/bibliogR",
    "NicolasJBM/chartR",
    "NicolasJBM/classR",
    "NicolasJBM/editR",
    "NicolasJBM/teachR",
    "NicolasJBM/testR",
    "NicolasJBM/gradR",
    "NicolasJBM/reportR"
  )
  
  if (install_for_education){
    for (pkg in scholR_education_packages){
      devtools::install_github(pkg)
    }
  }
  
}



#teachR <- base::unique(scholR::list_used_packages_and_functions("../teachR/R")$packages)
#classR <- base::unique(scholR::list_used_packages_and_functions("../classR/R")$packages)
#bibliogR <- base::unique(scholR::list_used_packages_and_functions("../bibliogR/R")$packages)
#chartR <- base::unique(scholR::list_used_packages_and_functions("../chartR/R")$packages)
#editR <- base::unique(scholR::list_used_packages_and_functions("../editR/R")$packages)
#testR <- base::unique(scholR::list_used_packages_and_functions("../testR/R")$packages)
#gradR <- base::unique(scholR::list_used_packages_and_functions("../gradR/R")$packages)
#reportR <- base::unique(scholR::list_used_packages_and_functions("../reportR/R")$packages)
#scholR <- base::unique(scholR::list_used_packages_and_functions("../scholR/R")$packages)
#keep <- base::unique(c(bibliogR, chartR, classR, editR, teachR, testR, gradR, reportR, scholR)) |>
#  base::setdiff(c("bibliogR", "chartR", "classR", "editR", "teachR", "testR", "gradR", "reportR", "scholR"))
#required_packages <- utils::installed.packages() |>
#  base::as.data.frame() |>
#  dplyr::select(Package, Version) |>
#  dplyr::filter(Package %in% keep)


