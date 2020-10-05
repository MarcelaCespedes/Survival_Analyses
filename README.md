# Survival Analyses

This repository will hold notes, R code to generate synthetic survival analyses data and carry out analyses which mimics features from the [AIBL](https://aibl.csiro.au/) study.

As discussed in ITTC reading group meetings, there are several issues when it comes to analyes of surivival data pertaining to clinical studies of Alzheimer's disease (AD). The event for these survival analyses is generally time to clinical diagnosis of AD. The outcome of interest is time taken (typically in years) for an individual to deteriorate to an AD diagnosis, and investigate biomarkers which affect this disease progression.

## Background 

James and I presented on the differences between standard survival analyses where the time to event is known and their respective proportional Cox Hazard models, versus interval censored survival analyes, where the exact time an event occured is unknown, only the interval when the event occurred. In my interval censored analyses, periodic dips occured approximately every 1.5 years - which is not very informative.

Previous published work on survival analyses in AIBL data are listed below - there is no standard way to analyse time to an event in AIBL.

## In this repository

This repository will consist of R code to generate survival AIBL data and perform basic survival analyses.


# References

Dang, C., Harrington, K.D., Lim, Y.Y., Ames, D., Hassenstab, J., Laws, S.M., Yassi, N., Hickey, M., Rainey-Smith, S., Robertson, J. and Sohrabi, H.R., 2018. Relationship between amyloid-β positivity and progression to mild cognitive impairment or dementia over 8 years in cognitively normal older adults. Journal of Alzheimer's Disease, 65(4), pp.1313-1325.

(Did not use survival analyses) Sona, A., Zhang, P., Ames, D., Bush, A.I., Lautenschlager, N.T., Martins, R.N., Masters, C.L., Rowe, C.C., Szoeke, C., Taddei, K. and Ellis, K.A., 2012. Predictors of rapid cognitive decline in Alzheimer's disease: results from the Australian Imaging, Biomarkers and Lifestyle (AIBL) study of ageing. International Psychogeriatrics, 24(2), pp.197-204.

Moore, D.F., 2016. Applied survival analysis using R. New York, NY: Springer.
