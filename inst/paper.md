---
title: 'datefixR: Standardize Dates in Different Formats or with Missing Data'
tags:
  - R
  - dates
  - wrangling
  - munging
authors:
  - name: Nathan Constantine-Cooke
    orcid: 0000-0002-4437-8713
    affiliation: "1, 2"
affiliations:
 - name: MRC Human Genetics Unit, University of Edinburgh, UK
   index: 1
 - name: Centre for Genomic and Experimental Medicine, University of Edinburgh, UK
   index: 2
date: 31 August 2022
bibliography: paper.bib
---

# Summary

There are many different formats dates are commonly represented with: the order
of day, month, or year can differ, different separators (“-”, “/”, or
whitespace) can be used, months can be numerical, names, or abbreviations and
year given as two digits or four. `datefixR`, an Ropensci R package, takes dates
in all these different formats and converts them to R’s built-in date class.

Date data may also have been recalled from memory and be missing partial
information such as day of the month of the month itself. `datefixR` allows easy
imputation of missing date data with control over how dates are imputed. 

`datefixR` has multilingual support for dates: supporting English, French,
German, Spanish, and Portuguese at present. `datefixR's` functionality is also
available as a Shiny web application.

# Statement of need

The `datefixR` R package automates much of the work required to standardize and
perform naïve date imputation whilst also being flexible enough to meet users’
specific needs.  `datefixR` supports whitespace, “/” and “-“ or "de" separators
for supplied data in addition to “dmy”, “ymd” and “mdy” date order (although
“mdy” must be specified by the user to be preferred over “dmy” to resolve
potential conflicts over ambiguity). Months are supported as full
names or abbreviations (in multiple languages) or as a numerical format.
Dates are formatted to R’s built-in `Date` class which follows the ISO 8601
standard [@ISO]. If a date cannot be standardized, then datefixR informs the
user which dates cannot be standardized and the corresponding row ID (assumed to
be given by the first column unless user-specified). 

`datefixR` also imputes missing data by imputing a missing month as July
and a missing day as the 1st day of the month by default. However, this behavior
can be modified by the user to impute a specific day or month or, if data are
missing, impute NA or intentionally error.

`datefixR` has been used in research which is currently undergoing peer review
[@ConstantineCooke2022] and has gathered a user base: having been downloaded
from Rstudio's CRAN mirror approximately 4000 times to date. 

There are R packages which provide similar functionality to `datefixR`, namely
`guess_formats()` and `parse_date_time()` from `lubridate` [@lubridate] and
`anydate ()` from the `anytime` [@anytime] package. However, there are
limitations to these functions where `datefixR` prevails. If a date fails to
parse in `lubridate` then the user is only informed how many dates failed to
parse: making these dates difficult to find. Moreover, the user has no control
over how dates are imputed: always imputing a missing day as the first of the
month and a missing month as January. This means an imputed date could be nearly
a year away from the true date. Additionally, `lubridate` requires potential
date formats to be explicitly defined by the user which may result in potential
formats being missed. `anytime` does not allow imputation and does not raise a
warning when a date is converted to NA which potentially results in erroneous
downstream analyses.      

# Acknowledgements

This work has been financially supported by the Medical Research Council and the
University of Edinburgh via a Precision Medicine PhD studentship (MR/N013166/1).

# References
