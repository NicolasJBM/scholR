#' @name list_used_packages_and_functions
#' @title List packages and functions
#' @author Nicolas Mangin
#' @description Function listing all the packages and functions used in a folder specified by a path.
#' @param path Character. Path to the folder containing the files.
#' @return Tibble with packages and function names, as well as the related imports.
#' @importFrom dplyr arrange
#' @importFrom dplyr bind_rows
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom stringr str_extract_all
#' @importFrom stringr str_remove_all
#' @importFrom tibble tibble
#' @importFrom tidyr separate
#' @export



list_used_packages_and_functions <- function(path = "R"){
  
  packages <- NULL
  functions <- NULL
  
  funs <- base::list.files(path, full.names = TRUE)
  pkg <- base::list()
  for (file in funs){
    lines <- base::readLines(file)
    calls <- stringr::str_extract_all(lines,"[a-z,A-Z,0-9,-,_,\\.]+::[a-z,A-Z,0-9,-,_,\\.]+\\(", simplify = TRUE)
    calls <- stringr::str_remove_all(base::trimws(base::as.vector(base::unlist(calls))), "\\(")
    calls <- base::unique(calls[base::nchar(calls) > 0])
    funs <- tibble::tibble(calls = calls) |>
      tidyr::separate(calls, into = c("packages","functions"), sep = "::") |>
      dplyr::arrange(packages, functions) |>
      dplyr::filter(!(packages %in% c("base","stats","utils"))) |>
      dplyr::mutate(
        file = file,
        import = base::paste0("#' @importFrom ", packages, " ", functions)
      )
    pkg[[file]] <- funs
  }
  pkg <- dplyr::bind_rows(pkg)
  return(pkg)
}
