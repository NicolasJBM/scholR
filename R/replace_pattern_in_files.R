#' @name replace_pattern_in_files
#' @title Replace pattern in files
#' @author Nicolas Mangin
#' @description Function identifying files containing the specified regex pattern and replacing this pattern by the desired replacement.
#' @param path Character. Path to the folder containing the files.
#' @param pattern Character. Regex pattern to be replaced.
#' @param replacement Chatacter. Replacement for the regex pattern.
#' @importFrom stringr str_detect
#' @importFrom stringr str_replace_all
#' @export

replace_pattern_in_files <- function(path, pattern, replacement){
  files <- base::list.files(path, full.names = TRUE)
  files <- files[stringr::str_detect(files, "\\.R$|\\.Rmd|\\.Qmd")]
  for (file in files){
    lines <- base::readLines(file)
    if (base::any(stringr::str_detect(lines, pattern))) {
      lines <- stringr::str_replace_all(lines, pattern, replacement)
      base::writeLines(lines, file)
    }
  }
}
