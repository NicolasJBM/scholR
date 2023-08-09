
<!-- README.md is generated from README.Rmd. Please edit that file -->

# scholR <img src="https://raw.githubusercontent.com/NicolasJBM/scholR/ddc7fecbd529ef9088295ef8aedf471014545b82/docs/assets/scholR.svg" align="right" width="100" height="100" >

<!-- badges: start -->

[![DOI](https://zenodo.org/badge/454038310.svg)](https://zenodo.org/badge/latestdoi/454038310)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/scholR)](https://CRAN.R-project.org/package=scholR)
[![R-CMD-check](https://github.com/NicolasJBM/scholR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/NicolasJBM/scholR/actions/workflows/R-CMD-check.yaml)
[![CodeFactor](https://www.codefactor.io/repository/github/NicolasJBM/scholR/badge)](https://www.codefactor.io/repository/github/NicolasJBM/scholR)
<!-- badges: end -->

The goal of *scholR* is to help you install suites of packages, files,
and applications useful to conduct academic work, more specifically
course management and study management. It is the entry point to an R
environment (or “universe”) designed so that anyone can practice
education and research in a free, open, diverse, inclusive, and
collaborative way. This package also includes various functions helping
me in package creation and maintenance.

## Prerequisites

To use scholR, you will need to install first a set of supporting pieces
of software:

- <a href="https://cran.rstudio.com/" target="_blank">R</a>
- <a href="https://cran.r-project.org/bin/windows/Rtools/"
  target="_blank">Rtools</a> (only on Windows)
- <a href="https://posit.co/download/rstudio-desktop/"
  target="_blank">RStudio</a>
- <a href="https://quarto.org/docs/get-started/"
  target="_blank">Quarto</a>

## Installation

Then, you can install the development version of scholR from
<a href="https://github.com/" target="_blank">GitHub</a> with:

``` r
devtools::install_github("NicolasJBM/scholR")
```

There is so far no CRAN version, but I plan to release this set of
packages on CRAN once each of them stands alone and properly and fully
documented.

## Installation of the education suite

To install the education suite, use the following command lines:

``` r
scholR::install_scholR(
  preinstall_requisites = TRUE,
  install_for_education = TRUE,
  keep_existing = TRUE
)
```

“preinstall_requisites” set to “TRUE” means that all required packages
will be installed before the scholR education packages themselves.

“install_for_education” set to “TRUE” means that all packages useful for
education, and only packages useful for edication, will be installed.
These packages are the following (the order of installation matters as
there are dependencies between packages):

- <a href="https://nicolasjbm.github.io/bibliogR/"
  target="_blank">bibliogR</a>
- <a href="https://nicolasjbm.github.io/chartR/"
  target="_blank">chartR</a>
- <a href="https://nicolasjbm.github.io/classR/"
  target="_blank">classR</a>
- <a href="https://nicolasjbm.github.io/editR/" target="_blank">editR</a>
- <a href="https://nicolasjbm.github.io/teachR/"
  target="_blank">teachR</a>
- <a href="https://nicolasjbm.github.io/testR/" target="_blank">testR</a>
- <a href="https://nicolasjbm.github.io/gradR/" target="_blank">gradR</a>
- <a href="https://nicolasjbm.github.io/reportR/"
  target="_blank">reportR</a>

Finally, “keep_existing” set to “TRUE” means that if a required package
is already installed it will not be installed again, even if an more
recent release is available.

## Installation of the research suite

This part of the environment is **not available yet**, but coming soon.
It will contain the following packages:

- <a href="https://nicolasjbm.github.io/bibliogR/"
  target="_blank">bibliogR</a>
- researchR
- reviewR

## Creation of programs and projects

Once you have installed the complete scholR suite for either/both
education and research, you can create a program (folder containing a
set of courses or studies) and within this program various projects
(folders for either courses or studies). For this, I designed a shiny
gadget function called “*create_new()*”. You can launch this gadget from
the command line:

``` r
scholR::create_new()
```

or use the addin in RStudio:

![](https://raw.githubusercontent.com/NicolasJBM/scholR/main/docs/assets/scholR-create_new.gif)

This gadget will help you perform several tasks. First, it will create a
program folder if it does not already exist. Then, it will create within
this program folder a reference database, only if it does not already
exist.

If the type of project is set to “Course”, the gadget will add the
application *“manage_course.R”* (again, if it does not already exist)
and a course folder with the appropriate structure, all the necessary
files, and named according to the user input. It will also create or
update a .csv file indicating the path to the course on the local disk.
You are then ready to start building your teaching, learning, and
testing materials.

I have chosen to have the application as a file on disk rather than a
function in a package because this facilitates working directory
management and also allows the user to customize (more specifically
simplify) the user interface.

## Using the applications

To use the applications you have installed, you now just have to open
one of them (manage_course.R or manage_study.R) and run the application:

![](https://raw.githubusercontent.com/NicolasJBM/scholR/main/docs/assets/scholR-run_manage_course.gif)

The actual use of applications is describe and explained in dedicated
user guides:

- <a href="" target="_blank">for course management</a>
- <a href="" target="_blank">for study management</a>

## Other functions you might find useful

The *scholR* package also contains some functions I use in package
design and maintenance, and sometimes for other purposes as well.

The function *“list_used_packages_and_functions()”* scan files in a
specified folder and make a list of all the packages and functions used
in these files. Note that this assumes that each function is called
preceded by it package, so that you use he synthax
“packageName::functionName()” when you write code.

The function *“open_files_containing_pattern.R”* scan files in a
specified folder and open in RStudio any file containing the specified
regex pattern.

Finally, the function *“replace_pattern_in_files.R”* scan files in a
specified folder and replace a regex pattern by the specified
replacement in all files.

## Databases

The *scholR* package finally contains some databases useful for the
installation of the whole environment.

The data.frame *references* contains the references to the scholR
packages. The table is formatted to be compatible with the bibliogR
system of reference management.

The data.frame *require_packages* contains a list of packages used by
scholR packages with the version I have installed on my computer. Should
you encounter some issues with one of these packages because of an
update, try installing the older version with the following command
line:

``` r
devtools::install_version(
  package = "DiagrammeR", # Replace by the appropriate package name
  version = "1.0.10" # Replace by the corresponding version
)
```

## Common fixes to known issues

This section is a work in progress. Of course, I correct issues in my
own code - but sometimes the issue lies in applications I do not
control… and therefore ends up in this section. I will enrich it as I
become aware of more external issues for which I identify fixes which I
cannot embed in my code. Hopefully it will remain short…

### Sweave not found

If you encounter issues in printing PDF documents, you may also have to
install one of the following additional supporting pieces of software:

- <a href="https://miktex.org/" target="_blank">MiKTeX</a> (preferred on
  Windows based on my experience){target=“\_blank”} or
- <a href="https://tug.org/texlive/" target="_blank">TeX Live</a>
  (preferred on Mac based on my experience){target=“\_blank”}.

Note that the link between R and Latex might sometimes get missing or
broken on Windows. When trying to print PDF documents, you might then
have the following error message:

    !Latex Error: 'Sweave.sty' not found

I found the solution to this issue on <a
href="https://tex.stackexchange.com/questions/153193/latex-error-sweave-sty-not-found"
target="_blank">this blog post</a>. After a small adaptation to a more
recent version of both MiKTeX and Windows, the procedure to properly map
the texmf directory to Miktex’s root directory in Windows 11 is as
follow:

1.  Locate the texmf directory inside the share folder in R. For me, the
    path was C:Files.2but this can change from user to user.
2.  Launch Miktex’s Options via the start menu or by locating this
    exectuable C:Files-console_admin.exe.
3.  Click on the “Settings” tab and click “+” /// now just click on
    “setting”
4.  Map the folder path to texmf that you located earlier.
5.  If you receive an error about the file being in use, make sure to
    close out of any open session of TeXworks.
6.  Click “Ok” and you’re set to go.
