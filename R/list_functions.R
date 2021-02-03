#' @name list_functions
#' @title Replace a pattern in several documents
#' @author Nicolas Mangin
#' @description List all the packages used in a set of .R files (identified with ::)
#' @importFrom scholR dat_packages
#' @importFrom dplyr arrange
#' @importFrom dplyr filter
#' @importFrom devtools install_cran
#' @importFrom devtools install_version
#' @importFrom devtools install_github
#' @importFrom BiocManager install
#' @importFrom blogdown install_hugo
#' @importFrom webshot install_phantomjs
#' @export


list_functions <- function(path = "R/", type = ".R") {
  files <- list.files(path)
  files <- files[stringr::str_detect(files, type)]

  packages <- list()

  for (file in files) {
    functions <- readLines(paste0(path, file)) %>%
      stringr::str_extract_all("\\w+::\\w+") %>%
      unlist() %>%
      unique()

    packages[[file]] <- tibble::tibble(
      files = file,
      functions = functions
    ) %>%
      tidyr::separate(functions, into = c("packages", "functions"), sep = "::")
  }

  packages <- dplyr::bind_rows(packages)

  imports <- packages %>%
    dplyr::mutate(imports = paste0(
      "#' @importFrom ",
      packages, " ", functions
    )) %>%
    dplyr::select(files, imports) %>%
    dplyr::group_by(files) %>%
    tidyr::nest() %>%
    dplyr::mutate(data = purrr::map(data, function(x) unlist(x$imports)))

  description <- paste0(unique(packages$packages), ",")

  results <- list(
    imports = imports,
    description = description
  )

  return(results)
}
