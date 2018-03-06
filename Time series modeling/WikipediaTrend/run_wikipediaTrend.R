

##########################################################################
## Predicting popularity of Lucy (Australopithecus) from Ethiopia.      ##
## -------------------------------------------------------------------- ##
## Inspired by WikipediaTrend package in R.                             ##
## -------------------------------------------------------------------- ##
## Date: 03-Mar-2018.                                                   ##
## -------------------------------------------------------------------- ##

## load supportive libraries
source("./load_library.R")

## load main library
## install.packages("wikipediatrend")
library(wikipediatrend)

## load data
data <- wikipediatrend::wp_trend(page = "Haile_Gebrselassie", from = "2016-01-01", to = "2017-01-01", lang = "en")       ## Lucy_(Australopithecus) was discovered on November 24, 1974 (source: https://en.wikipedia.org/wiki/Lucy_(Australopithecus))

## reset catch
# wikipediatrend::wp_cache_reset()




