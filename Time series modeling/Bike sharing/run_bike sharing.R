
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
options(tz = "Europe/Amsterdam")

## load library
source("./functions/load_library.R")

## load source dataset
day <- readr::read_csv(file = "./dataset/day.csv", col_names = TRUE)
hour <- readr::read_csv(file = "./dataset/hour.csv", col_names = TRUE)

## --------------------------------------------- ##
## Understanding derivation of important days    ##
## (e.g., weekday, holiday, season)              ##
## --------------------------------------------- ##
day_wkday <- day %>% 
  dplyr::select(dteday, weekday) %>% 
  dplyr::mutate(weekday_mine = weekdays(as.Date(dteday, "%y-%m-%d")))






