
<!-- badges: start -->

[![R-CMD-check](https://github.com/NicolasJBM/scholR/workflows/R-CMD-check/badge.svg)](https://github.com/NicolasJBM/scholR/actions)
[![CodeFactor](https://www.codefactor.io/repository/github/nicolasjbm/scholr/badge)](https://www.codefactor.io/repository/github/nicolasjbm/scholr)
<!-- badges: end -->

# scholR <img src="man/figures/logo.svg" align="right" width="120" />

Streamlining academic work flows.

## Overview

*SCHOL^R* (standing for *scholarship powered by R*) is a set of packages
I created to facilitate and speed up academic tasks. It makes the code I
use for research, development, and teaching activities transparent,
verifiable, and reproducible. Hopefully, it can also be useful to you.

The *scholR* package serves a unique purpose: to prepare the R work
environment by installing key packages supporting the toolboxes of the
*SCHOL^R* environment. These toolboxes are described at the end of this
page.

## Pre-requisites

First, make sure to have R and RStudio installed:

  - [R for Windows](https://cran.r-project.org/bin/windows/base/) or [R
    for Mac OS X](https://cran.r-project.org/bin/macosx/)
  - [RStudio](https://rstudio.com/products/rstudio/download/#download)

Second, all the tools necessary to fully leverage the *SCHOL^R*
environment cannot be installed from within R. You will find hereafter a
list with links towards additional pieces of software for either Windows
or Mac OS (I do not work on Linux, sorry…).

For Windows:

  - [Rtools](https://cran.r-project.org/bin/windows/Rtools/)
  - [Perl](https://strawberryperl.com/)
  - [MiKTeX](https://miktex.org/download) if you want the complete
    standalone version for LaTeX

For Mac OS X:

  - [MacTeX](https://www.tug.org/mactex/) if you want the complete
    standalone version for LaTeX

## Installation

Before you can install *scholR* itself, you will also need to install
from CRAN the following R packages:

``` r
install.packages("knitr")
install.packages("devtools")
install.packages("BiocManager")
install.packages("blogdown")
install.packages("webshot")
install.packages("tidyverse")
```

Then, install *scholR* from its GitHub public repository:

``` r
devtools::install.github("NicolasJBM/scholR")
```

## Usage

The only function in this package checks the packages already installed
and adds those missing. To proceed with the installation of the
environment, just type the following lines of code:

``` r
scholR::prepare_environment(
  cran = TRUE,
  github = TRUE,
  bioconductor = TRUE,
  hugo = FALSE,
  webshot = FALSE
)
```

Switch the parameters “hugo” and “webshot” to TRUE only if they are not
already installed on your system. This does not affect your otherwise
already installed packages and only adds those missing for a proper
implementation of the toolboxes presented hereafter. Here are for
instance the first six entries of this package list:

``` r
library(scholR)
library(dplyr)
data("dat_packages")
head(dat_packages) %>%
  knitr::kable(format="html")
```

<table>

<thead>

<tr>

<th style="text-align:right;">

order

</th>

<th style="text-align:left;">

use

</th>

<th style="text-align:left;">

origin

</th>

<th style="text-align:left;">

repository

</th>

<th style="text-align:left;">

package

</th>

<th style="text-align:left;">

version

</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

1

</td>

<td style="text-align:left;">

code

</td>

<td style="text-align:left;">

cran

</td>

<td style="text-align:left;">

</td>

<td style="text-align:left;">

formatR

</td>

<td style="text-align:left;">

1.7

</td>

</tr>

<tr>

<td style="text-align:right;">

2

</td>

<td style="text-align:left;">

code

</td>

<td style="text-align:left;">

cran

</td>

<td style="text-align:left;">

</td>

<td style="text-align:left;">

git2r

</td>

<td style="text-align:left;">

0.27.1

</td>

</tr>

<tr>

<td style="text-align:right;">

3

</td>

<td style="text-align:left;">

code

</td>

<td style="text-align:left;">

cran

</td>

<td style="text-align:left;">

</td>

<td style="text-align:left;">

gitcreds

</td>

<td style="text-align:left;">

0.1.1

</td>

</tr>

<tr>

<td style="text-align:right;">

4

</td>

<td style="text-align:left;">

code

</td>

<td style="text-align:left;">

cran

</td>

<td style="text-align:left;">

</td>

<td style="text-align:left;">

goodpractice

</td>

<td style="text-align:left;">

1.0.2

</td>

</tr>

<tr>

<td style="text-align:right;">

5

</td>

<td style="text-align:left;">

code

</td>

<td style="text-align:left;">

cran

</td>

<td style="text-align:left;">

</td>

<td style="text-align:left;">

gtools

</td>

<td style="text-align:left;">

3.8.2

</td>

</tr>

<tr>

<td style="text-align:right;">

6

</td>

<td style="text-align:left;">

code

</td>

<td style="text-align:left;">

cran

</td>

<td style="text-align:left;">

</td>

<td style="text-align:left;">

lintr

</td>

<td style="text-align:left;">

2.0.1

</td>

</tr>

</tbody>

</table>

Note that this function does not install the toolboxes themselves.

## Toolboxes

The *SCHOL^R* environment is composed of the following toolboxes (those
flagged as “project” are not operational yet):

  - *[fmtR](https://github.com/NicolasJBM/fmtR)*: functions quickly
    formating numbers and statistics.
  - *[lexR](https://github.com/NicolasJBM/lexR)*: functions supporting
    lexical analyses.
  - *[bibliogR](https://github.com/NicolasJBM/bibliogR)*: functions and
    applications supporting literature search and citations.
  - *[collectR](https://github.com/NicolasJBM/collectR)* (project):
    functions and applications supporting data collection and storage.
  - *[buildR](https://github.com/NicolasJBM/buildR)*: functions and
    applications supporting variable transformation as well as the
    production and validation of constructs.
  - *[modlR](https://github.com/NicolasJBM/modlR)*: functions and
    applications supporting complex statistical estimations.
  - *[tablR](https://github.com/NicolasJBM/tablR)*: functions supporting
    table manipulation.
  - *[chartR](https://github.com/NicolasJBM/chartR)*: functions and
    applications supporting the design, production, insertion, and
    formating of diagrams and graphs.
  - *[writR](https://github.com/NicolasJBM/writR)*: functions and
    applications supporting the production of HTML or PDF documents
    (presentations, papers, books).
  - *[reviewR](https://github.com/NicolasJBM/reviewR)* (project):
    functions and applications supporting reviewing process.
  - *[simulR](https://github.com/NicolasJBM/simulR)* (project):
    functions and applications supporting business simulations.
  - *[teachR](https://github.com/NicolasJBM/teachR)*: functions and
    applications supporting test generation, grading, and feedback.
  - *[Rtist](https://github.com/NicolasJBM/Rtist)* (project): functions
    and applications helping the creation of mathematical of data art.
