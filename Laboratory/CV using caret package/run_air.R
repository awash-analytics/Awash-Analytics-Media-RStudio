
#########################################################################################################################
## Inspired by Zevross
## Blog post: http://zevross.com/blog/2017/09/19/predictive-modeling-and-machine-learning-in-r-with-the-caret-package/
## Blog post title: Predictive modeling and machine learning in R with the caret package
#########################################################################################################################
## Data: Clean Air Survey Content (2009)
## Source: https://data.cityofnewyork.us/Environment/Clean-Air-Survey-Content-2009-/fmhd-mfkw
#########################################################################################################################
## Date: Feb-2018
#########################################################################################################################


## load library
source("./load_library.R")

library(caret)


## ------------------------------------------------------ ##
## A “real-world” example: Air quality data from NYC.     ##
## ------------------------------------------------------ ##
## load dataset
annavg <- readr::read_csv(file = "./NYC_20Clean_20Air_20Survey_20Content/NYCCAS CSV Data Files/NYCCAS_2009_CD_annavg.csv", col_names = TRUE)
summer2009 <- readr::read_csv(file = "./NYC_20Clean_20Air_20Survey_20Content/NYCCAS CSV Data Files/summer2009_CD.csv", col_names = TRUE)
winter2009 <- readr::read_csv(file = "./NYC_20Clean_20Air_20Survey_20Content/NYCCAS CSV Data Files/winter2009CD.csv", col_names = TRUE)



