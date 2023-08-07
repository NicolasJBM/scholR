#' @name open_files_containing_pattern
#' @title Open files containing a pattern
#' @author Nicolas Mangin
#' @description Function identifying and opening files containing the specified regex pattern.
#' @param path Character. Path to the folder containing the files.
#' @param pattern Character. Regex pattern to be replaced.
#' @importFrom rstudioapi navigateToFile
#' @importFrom stringr str_detect
#' @export

open_files_containing_pattern <- function(path, pattern){
  
  string <- NULL
  
  files <- base::list.files(path, full.names = TRUE)
  for (file in files){
    lines <- base::readLines(file)
    if (any(stringr::str_detect(lines, string))) rstudioapi::navigateToFile(file)
  }
}
