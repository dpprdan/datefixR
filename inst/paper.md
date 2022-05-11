---
title: 'datefixR: Fix really messy dates'
tags:
  - R
  - dates
  - wrangling
  - munging
authors:
  - name: Nathan Constantine-Cooke
    orcid: 0000-0002-4437-8713
    affiliation: "1, 2" # (Multiple affiliations must be quoted)
affiliations:
 - name: MRC Human Genetics Unit, University of Edinburgh, UK
   index: 1
 - name: Centre for Genomic and Experimental Medicine, University of Edinburgh, UK
   index: 2
date: 11 May 2022
bibliography: paper.bib
---

# Summary

Dates can be represented in many different formats and, often in the case of
dates being recalled from memory, may be missing partial information such as day
of the month of the month itself. Whilst ensuring date data is supplied via a
date specific input field in a webform (which validates the date or otherwise
enforces consistency across entries) avoids these problems, study design for a
research project may have not used this approach: especially if the study design
involves a subject questionnaire which has been designed and deployed without
the input of statisticians. Situations where date data has been entered via a
free text box by different people can be a major inconvenience for statisticians
using the data who must first standardise all date data and impute missing data. 

# Statement of need

The `datefixR` R package automates much of the work required to standardise and
perform naïve date imputation whilst also being flexible enough to meet users’
specific needs. When standardising, `datefixR` permits whitespace, “/” and “-“
separators for supplied data in addition to “dmy”, “ymd” and “mdy” date order
(although “mdy” must be specified by the user to be preferred over “dmy” due to
ambiguity). Months are supported as full, abbreviation, or numerical formats.
Dates are formatted to R’s built-in `Date` class which follows the ISO 8601
standard [@ISO]. If a date cannot be standardised, then datefixR informs the
user which dates cannot be standardised and the corresponding row ID (assumed to
be given by the first column unless specified). 

`datefixR` also imputes missing data by default imputing a missing month as July
and a missing day as the 1st. However, this behaviour can be modified by the
user to impute a specific day or month, impute NA in the presence of an NA, or
intentionally error if these data are missing.

There are R packages which provide similar functionality, namely
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
