% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fix_date_df.R
\name{fix_date_df}
\alias{fix_date_df}
\title{Clean up messy date columns}
\usage{
fix_date_df(
  df,
  col.names,
  day.impute = 1,
  month.impute = 7,
  id = NULL,
  format = "dmy",
  excel = FALSE,
  roman.numeral = FALSE
)
}
\arguments{
\item{df}{A \code{dataframe} or \code{tibble} object containing messy date
column(s).}

\item{col.names}{Character vector specifying column names of date data to be
cleaned.}

\item{day.impute}{Integer between 1 and 31, or NA, or NULL. Day of the month
to be imputed when missing. Defaults to 1. If \code{day.impute} is greater
than the number of days in a given month, the last day of that month will
be imputed (accounting for leap years). If \code{day.impute = NA}, then
\code{NA} will be imputed for the entire date and a warning will be raised.
If \code{day.impute = NULL}, the function will fail with an error when day
is missing.}

\item{month.impute}{Integer between 1 and 12, or NA, or NULL. Month to be
imputed when missing. Defaults to 7 (July). If \code{month.impute = NA},
then \code{NA} will be imputed for the entire date and a warning will be
raised.
If \code{month.impute = NULL}, the function will fail with an error when
month is missing.}

\item{id}{Optional parameter specifying the name of the column containing
row IDs. Defaults to using the first column for IDs.}

\item{format}{Character string specifying date interpretation preference.
Either \code{"dmy"} (day-month-year, default) or \code{"mdy"}
(month-day-year, US format). This setting only affects ambiguous numeric
dates like "01/02/2023". When month names are present or year appears
first, the format is auto-detected regardless of this parameter. Note that
unambiguous dates (e.g., "25/12/2023") are parsed correctly regardless of
the format setting.}

\item{excel}{Logical: Assumes \code{FALSE} by default. If \code{TRUE}, treats
numeric-only dates with more than four digits as Excel serial dates with
1900-01-01 origin, correcting for known Excel date discrepancies.}

\item{roman.numeral}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#experimental}{\figure{lifecycle-experimental.svg}{options: alt='[Experimental]'}}}{\strong{[Experimental]}} Logical: Defaults
to \code{FALSE}. When \code{TRUE}, attempts to interpret Roman numeral
month indications within datasets. This feature may not handle all cases
correctly.}
}
\value{
A revised \code{dataframe} or \code{tibble} structure, maintaining
input type. Date columns will be formatted with \code{Date} class and
display as \code{yyyy-mm-dd}.
}
\description{
Tidies a \code{dataframe} or \code{tibble} object with date
columns entered via a free-text interface, addressing non-standardized
formats. Supports diverse separators including /, -, ., and spaces. Handles
all-numeric, abbreviated, or full-length month names in languages such as
English, French, German, Spanish,  Portuguese, Russian, Czech, Slovak, and
Indonesian. Imputes missing day data by  default, with flexibility for custom
imputation strategies.
}
\details{
This function processes messy date data by:
\itemize{
\item{Supporting mixed format data entries}
\item{Recognizing multilingual month names and Roman numeral inputs}
\item{Interpreting Excel-style serial date numbers if specified}
\item{Providing warnings and controls for missing day/month imputation}
}
For further details and advanced usage, refer to the vignette via
\code{browseVignettes("datefixR")} or visit the online documentation at
\url{https://docs.ropensci.org/datefixR/}.
}
\examples{
# Basic cleanup
data(exampledates)
fix_date_df(exampledates, c("some.dates", "some.more.dates"))

# Usage with metadata
messy_dates_df <- data.frame(
  id = seq(1, 3),
  dates = c("1992", "April 1990", "Mar 19")
)
fix_date_df(messy_dates_df, "dates", day.impute = 15, month.impute = 12)

# Diverse format normalization
df_formats <- data.frame(
  mixed.dates = c("02/05/92", "2020-may-01", "1996.05.01", "October 2022"),
  european.dates = c("22.07.1977", "05.06.2023")
)
fix_date_df(df_formats, c("mixed.dates", "european.dates"))

# Excel serial examples
serial_df <- data.frame(serial.dates = c("44197", "44927"))
fix_date_df(serial_df, "serial.dates", excel = TRUE)

# Handling Roman numerals
roman_df <- data.frame(roman.dates = c("15.I.2023", "03.XII.2019"))
fix_date_df(roman_df, "roman.dates", roman.numeral = TRUE)
}
\seealso{
\code{\link{fix_date_char}} for similar functionality on character vectors
and \code{\link{fix_date}} for single date entries.

For comprehensive examples and usage practices, consult:
\itemize{
\item{Vignette: \code{browseVignettes("datefixR")}}
\item{Documentation: \url{https://docs.ropensci.org/datefixR/articles/datefixR.html}}
\item{README Overview: \url{https://docs.ropensci.org/datefixR/}}
}
}
