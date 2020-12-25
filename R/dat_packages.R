#' @name dat_packages
#' @title List of packages for SCHOL^R
#' @author Nicolas Mangin
#' @description List of packages constitutive of the SCOL^R environment, with their sources and versions specified if necessary.
#' @format 6 variables:
#' \itemize{
#'   \item **order**: Order in which the packages should be installed.
#'   \item **use**: The type of task for which the package is useful.
#'   \item **origin**: Indicate whether the packages should be installed from cran, GitHub, or BioConductor
#'   \item **repository**: If GitHub, the developer.
#'   \item **package**: Name of the package.
#'   \item **version**: Version of the package which should be installed. Latest if not specified.
#' }
#' @docType data
#' @keywords packages environment
#' @usage data("dat_packages")
"dat_packages"