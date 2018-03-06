##########################################
## Inspired by a book by Dr. N.D. Lewis ##
## ------------------------------------ ##
## Date: 06-Mar-2018                    ##
##########################################

## load supportive library
source("./load library.R")

## load main library
# install.packages("tscount", dependencies = TRUE)
library(tscount)

# install.packages("forecast", dependencies = TRUE)
library(forecast)
library(tseries)

library(zoo)         # needed for deriving lag variables
library(quantmod)    # needed for deriving lag variables


## --------------------------------------------------- ##
## Example: Forecasting the number of new cases of     ##
## Escherichia coli.                                   ##
## --------------------------------------------------- ##

## -- Step 1. load data
data("ecoli", package = "tscount")

## -- Step 2. Exploring and preparing the data
## pull response variable
data <- ecoli %>%
  dplyr::pull(cases)

## create time series variable
data <- ts(data, start = c(2001, 1), end = c(2013, 20), frequency = 52)

## Visualizing the data
plot(data, xlab='Date', ylab='Number of Cases', col='darkblue')

## partial autocorrelation plot (ACF)
pacf(data)

## derive lag variables
data <- zoo::as.zoo(data)

x1 <- quantmod::Lag(x = data, k = 1)
x2 <- quantmod::Lag(x = data, k = 2)
x3 <- quantmod::Lag(x = data, k = 3)
x4 <- quantmod::Lag(x = data, k = 4)

x <- cbind(x1, x2, x3, x4)

## remove missing values (due to lag computation)
x <- x[-(1:4), ]

