
#################################################################################
## Inspired by Datascience.come
## Source: https://www.datascience.com/blog/introduction-to-forecasting-with-arima-in-r-learn-data-science-tutorials
## Source (Dataset): https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset
#################################################################################
## Date: 23-Feb-2018
#################################################################################

## -------------------------- ##
## Environmental setting.     ##
## -------------------------- ##
## set time zone
options(tz = "Europe/Berlin")

## load library
source("./functions/load_library.R")

## Install TS packages
# devtools::install_github("robjhyndman/forecast")

## load library
library(forecast)

## load source dataset
daily_data <- readr::read_csv(file = "./dataset/day.csv", col_names = TRUE)
hour <- readr::read_csv(file = "./dataset/hour.csv", col_names = TRUE)



