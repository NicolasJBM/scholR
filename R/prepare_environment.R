#' @name install_environment
#' @title Install scholR environment
#' @author Nicolas Mangin
#' @description Install all packages supporting the scholR universe in the appropriate versions.
#' @param cran Logical. TRUE to install cran packages.
#' @param github  Logical. TRUE to install github packages.
#' @param bioconductor  Logical. TRUE to install BioConductor packages.
#' @param hugo Logical. TRUE to install.
#' @param webshot Logical. TRUE to install.
#' @importFrom devtools install_cran
#' @importFrom devtools install_github
#' @importFrom BiocManager install
#' @importFrom blogdown install_hugo
#' @importFrom webshot install_phantomjs
#' @importFrom utils installed.packages
#' @importFrom dplyr %>%
#' @importFrom dplyr filter
#' @importFrom dplyr arrange
#' @export


prepare_environment <- function(cran = TRUE,
                                github = TRUE,
                                bioconductor = TRUE,
                                hugo = FALSE,
                                webshot = FALSE) {

  # Link variables for dplyr manipulations
  origin <- NULL
  package <- NULL


  # Install cran packages if requested
  if (cran) {

    # Identify missing packages
    installed <- rownames(installed.packages())
    instpkg <- scholR::dat_packages %>%
      dplyr::arrange(order) %>%
      dplyr::filter(origin == "cran", !(package %in% installed))

    if (nrow(instpkg)>0) print(paste("Now installing", paste(instpkg$package, collapse = ", ")))

    # Install packages one by one with their dependencies
    while (nrow(instpkg) > 0) {
      pkg <- instpkg$package[[1]]
      vrs <- instpkg$version[[1]]

      # Differentiate between packages without versions (install the latest)
      # from packages with a version specified (install that version).
      if (is.na(vrs)) {
        print(paste0("Installing package ", pkg, "."))
        devtools::install_cran(pkg,
          dependencies = TRUE,
          upgrade = "never",
          quiet = TRUE,
          build = TRUE
        )
      } else {
        print(paste0("Installing package ", pkg, " version ", vrs, "."))
        devtools::install_version(pkg,
          version = vrs,
          dependencies = TRUE,
          upgrade = "never",
          quiet = TRUE,
          build = TRUE
        )
      }

      installed <- rownames(installed.packages())
      instpkg <- scholR::dat_packages %>%
        dplyr::filter(origin == "cran", !(package %in% installed))
    }
  }


  # Install GitHub packages if requested
  if (github) {

    # Identify missing packages
    installed <- rownames(installed.packages())
    instpkg <- scholR::dat_packages %>%
      dplyr::arrange(order) %>%
      dplyr::filter(origin == "GitHub", !(package %in% installed))

    if (nrow(instpkg)>0) print(paste("Now installing", paste(instpkg$package, collapse = ", ")))

    # Install packages one by one with their dependencies
    while (nrow(instpkg) > 0) {
      pkg <- instpkg$package[[1]]
      rep <- instpkg$repository[[1]]
      devtools::install_github(paste0(rep, "/", pkg),
        dependencies = TRUE,
        upgrade = "never",
        quiet = TRUE,
        build = TRUE
      )

      installed <- rownames(installed.packages())
      instpkg <- scholR::dat_packages %>%
        dplyr::filter(origin == "GitHub", !(package %in% installed))
    }
  }


  # Install BioConductor packages if requested
  if (bioconductor) {

    # Identify missing packages
    installed <- rownames(installed.packages())
    instpkg <- scholR::dat_packages %>%
      dplyr::arrange(order) %>%
      dplyr::filter(origin == "bioconductor", !(package %in% installed))

    if (nrow(instpkg)>0) print(paste("Now installing", paste(instpkg$package, collapse = ", ")))

    # Install packages one by one with their dependencies
    while (nrow(instpkg) > 0) {
      pkg <- instpkg$package[[1]]
      BiocManager::install(pkg, update = FALSE)

      # Update the
      installed <- rownames(installed.packages())
      instpkg <- scholR::dat_packages %>%
        dplyr::filter(origin == "bioconductor", !(package %in% installed))
    }
  }


  # Install Hugo (for the creation of blogs) if requested.
  if (hugo) blogdown::install_hugo(force = TRUE)


  # Install webshot (to replace dynamic figures by screen-shots) if requested.
  if (webshot) webshot::install_phantomjs()
}
