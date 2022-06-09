
<!-- README.md is generated from README.Rmd. Please edit that file -->

# datefixR <img src="man/figures/logo.png" align="right" width="150" />

<!-- badges: start -->

| Usage                                                                                                                                 | Release                                                                                                                                          | Development                                                                                                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| ![R](https://img.shields.io/badge/r-%23276DC3.svg?style=for-the-badge&logo=r&logoColor=white)                                         | [![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/datefixR)](https://cran.r-project.org/package=datefixR)                             | [![R build status](https://github.com/nathansam/datefixR/workflows/CI/badge.svg)](https://github.com/nathansam/datefixR/actions)                                                                       |
| [![License: GPL-3](https://img.shields.io/badge/License-GPL3-green.svg)](https://opensource.org/licenses/GPL-3.0)                     | [![datefixR status badge](https://nathansam.r-universe.dev/badges/datefixR)](https://nathansam.r-universe.dev)                                   | [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) |
| [![CRAN RStudio mirror downloads](https://cranlogs.r-pkg.org/badges/grand-total/datefixR?color=blue)](https://r-pkg.org/pkg/datefixR) | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5655311.svg)](https://doi.org/10.5281/zenodo.5655311)                                        | [![codecov](https://codecov.io/gh/nathansam/datefixR/branch/main/graph/badge.svg?token=lb83myWBXt)](https://app.codecov.io/gh/nathansam/datefixR)                                                      |
|                                                                                                                                       | [![Status at rOpenSci Software Peer Review](https://badges.ropensci.org/533_status.svg)](https://github.com/ropensci/software-review/issues/533) | [![Tidyverse style guide](https://img.shields.io/static/v1?label=Code%20Style&message=Tidyverse&color=1f1c30)](https://style.tidyverse.org)                                                            |

<!-- badges: end -->

`datefixR` is designed to standardize messy date data, such as dates
entered by different people via text boxes, by converting the dates to
R’s Date data type.

This package arose from my own fights with messy date data where dates
were written in many different formats e.g 01-jan-15, 2015 04 02,
10/12/2010 and more.

## Installation instructions

`datefixR` is now available on CRAN.

``` r
install.packages("datefixR")
```

The most up-to-date (hopefully) stable version of `datefixR` can be
installed via [r-universe](https://r-universe.dev/search/)

``` r
# Enable universe(s) by nathansam
options(repos = c(
  nathansam = 'https://nathansam.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))

install.packages('datefixR')
```

If you wish to live on the cutting edge of `datefixR` development, then
the development version can be installed via

``` r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("nathansam/datefixR", "devel")
```

## Package vignette

`datefixR` has a “Getting Started” vignette which describes how to use
this package in more detail than this page. View the vignette by either
calling

``` r
browseVignettes("datefixR")
```

or visiting the vignette on the [package
website](https://www.constantine-cooke.com/datefixR/articles/datefixR.html)

## Usage

`datefixR` is most commonly used to standardize columns of date data in
a data frame or tibble. For this demonstration, we will use an example
toy dataset provided alongside the package, `exampledates`.

``` r
library(datefixR)
data("exampledates")
knitr::kable(exampledates)
```

| id | some.dates  | some.more.dates |
| -: | :---------- | :-------------- |
|  1 | 02 05 92    | 2015            |
|  2 | 01-04-2020  | 02/05/00        |
|  3 | 1996/05/01  | 05/1990         |
|  4 | 2020-may-01 | 2012-08         |
|  5 | 2 April 96  | jan 2020        |

We can standardize these date columns by using the `fix_date_df()`
function and passing the data frame/tibble object and a character vector
of column names for the corresponding columns to fix.

``` r
fixed.df <- fix_date_df(exampledates, c("some.dates", "some.more.dates"))
knitr::kable(fixed.df)
```

| id | some.dates | some.more.dates |
| -: | :--------- | :-------------- |
|  1 | 1992-05-02 | 2015-07-01      |
|  2 | 2020-04-01 | 2000-05-02      |
|  3 | 1996-05-01 | 1990-05-01      |
|  4 | 2020-05-01 | 2012-08-01      |
|  5 | 96-04-02   | 2020-01-01      |

By default, `datefixR` imputes missing days of the month as 01, and
missing months as 07 (July). However, this behaviour can be modified via
the `day.impute` or `month.impute` arguments.

``` r
 example.df <- data.frame(example = "1994")

fix_date_df(example.df, "example", month.impute = 1)
#>      example
#> 1 1994-01-01
```

Functions in `datefixR` assume day-first instead of month-first when
day, month, and year are all given (unless year is given first). However
this behavior can be modified by passing `format = "mdy"` to function
calls.

## Limitations

The package is written solely in R and seems fast enough for my current
use cases (a few hundred rows). However, I may convert the core for loop
to C++ in the future if I (or others) need it to be faster.

## Similar packages to datefixR

### `lubridate`

[`lubridate::guess_formats()`](https://lubridate.tidyverse.org/reference/guess_formats.html)
can be used to guess a date format and
[`lubridate::parse_date_time()`](https://lubridate.tidyverse.org/reference/parse_date_time.html)
calls this function when it attempts to parse a vector into a POSIXct
date-time object. However:

1.  When a date fails to parse in `{lubridate}` then the user is simply
    told how many dates failed to parse. In `datefixR` the user is told
    the ID (assumed to be the first column by default but can be
    user-specified) corresponding to the date which failed to parse and
    reports the considered date: making it much easier to figure out
    which dates supplied failed to parse and why.
2.  When imputing a missing day or month, there is no user-control over
    this behavior. For example, when imputing a missing month, the user
    may wish to impute July, the middle of the year, instead of January.
    However, January will always be imputed in `{lubridate}`. In
    `datefixR`, this behavior can be controlled by the `month.impute`
    argument.
3.  These functions require all possible date formats to be specified in
    the `orders` argument, which may result in a date format not being
    considered if the user forgets to list one of the possible formats.
    By contrast, `datefixR` only needs a format to be specified if
    month-first is to be preferred over day-first when guessing a date.

However, `{lubridate}` of course excels in general date manipulation and
is an excellent tool to use alongside `datefixR`.

### `anytime`

An alternative function is
[`anytime::anydate()`](https://dirk.eddelbuettel.com/code/anytime.html)
which also attempts to convert dates to a consistent format (POSIXct).
However `{anytime}` assumes year, month, and day have all been provided
and does not permit imputation. Moreover, if a date cannot be parsed,
then the date is converted to an NA object and no warning is raised-
which may lead to issues later in the analysis.

### Speed comparison

Both `{lubridate}` and and `{anytime}` use compiled code and therefore
have the potential to be orders of magnitude faster than `datefixR`.
However, in my own testing, I found `{anytime}` to actually be slower
than `datefixR`: consistently being over 3 times slower (testing up to
10,000 dates). `lubridate::parse_date_time()` (which is written in R) is
an order of magnitude of time faster than `datefixR` and
`lubridate::parse_date_time2()`, which is written in C but only allows
numeric dates, is even faster. If you are don’t mind not having control
over imputation, do not expect to have to deal with many dates which
fail to parse, are confident you will specify all potential formats the
supplied dates will be in, and you have many many dates to standardize
(hundreds of thousands or more), `{lubridate}`’s functions may be a
better option than `datefixR`.

### Not actively maintained alternatives

[`linelist::guess_dates()`](https://www.repidemicsconsortium.org/linelist/reference/guess_dates.html)
appears to also have performed a somewhat similar role to the above
functions. However, this function did not leave the experimental
lifecycle phase and the package itself is no longer available on CRAN.

## Citation

If you use this package in your research, please consider citing
`datefixR`\! An up-to-date citation can be obtained by running

``` r
citation("datefixR")
```
