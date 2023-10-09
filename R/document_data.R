#' @name document_data
#' @title Document data for a package
#' @author Nicolas Mangin
#' @param x Dataframe or tibble. Data for which a description should be created.
#' @param datname Character. Name of the dataset.
#' @param path Character. Path to which the description should be added.
#' @description Function creating a .R file for a dataset.
#' @importFrom tibble is_tibble
#' @export


document_data <- function(x = NULL, datname = NULL, path = "R"){
  
  base::stopifnot(
    base::is.data.frame(x) | tibble::is_tibble(x),
    !base::is.null(datname)
  )
  
  variables <- base::names(x)
  classes <- base::apply(x, 2, class)
  
  base::writeLines(c(
    base::paste0("#' @name ", datname),
    base::paste0("#' @title ", datname),
    base::paste0("#' @format A data frame with ", base::nrow(x), " rows and ", base::ncol(x), " variables"),
    "#' \\itemize{",
    base::paste("#'   \\item ", variables, " ", classes),
    "#' }",
    "#' @docType data",
    "#' @keywords datasets",
    base::paste0("#' @usage data(", datname,")"),
    "NULL"
  ), base::paste0(path, "/", datname, ".R"))
  
}
