#################################################################################
## Inspired by Vidha from AnalyticsVidha
## Source: https://www.analyticsvidhya.com/blog/2015/12/complete-tutorial-time-series-modeling/
#################################################################################
## Date: 24-Feb-2018
#################################################################################

## -------------------------- ##
## Environmental setting.     ##
## -------------------------- ##
## set time zone
options(tz = "Europe/Berlin")

## load library
source("./load_library.R")

## Install TS packages
# devtools::install_github("robjhyndman/forecast")

## load library
library(forecast)

## load dataset
data("AirPassengers")

## Explore dataset
class(AirPassengers)    ## this returns "ts"
start(AirPassengers)
end(AirPassengers)
frequency(AirPassengers)

summary(AirPassengers)

## Detailed Metrics
plot(AirPassengers)
abline(reg=lm(AirPassengers~time(AirPassengers)))

#This will print the cycle across years.
cycle(AirPassengers)

#This will aggregate the cycles and display a year on year trend
plot(aggregate(AirPassengers,FUN=mean))

#Box plot across months will give us a sense on seasonal effect
boxplot(AirPassengers~cycle(AirPassengers))

# Important Inferences
# The year on year trend clearly shows that the #passengers have been increasing without fail.
# The variance and the mean value in July and August is much higher than rest of the months.
# Even though the mean value of each month is quite different their variance is small. Hence, we have strong seasonal effect with a cycle of 12 months or less.


## --------------------------------------------- ##
## Introduction to ARMA Time Series Modeling.    ##
## --------------------------------------------- ##


## ----------------------------------------------------------- ##
## Framework and Application of ARIMA Time Series Modeling.    ##
## ---
## 1. Visualize the TS
## 2. Stationarize the series
## 3. Plot ACF/PACF charts and find optimal parameters
## 4. Build the ARIMA model
## 5. Make predictions
## ----------------------------------------------------------- ##

########################################
## Applications of Time Series Model. ##
########################################

## 1. stationary effect
tseries::adf.test(x = AirPassengers, alternative="stationary", k=0)

## after differencing
tseries::adf.test(x = diff(log(AirPassengers)), alternative="stationary", k=0)

## 2. Find parameters
## conclusion: the decay of ACF chart is very slow, which means that the population is not stationary.
acf(log(AirPassengers))        
acf(diff(log(AirPassengers)))

## conclusion: ACF plot cuts off after the first lag. Hence, we understood that value of p should be 0 as the ACF is the curve getting a cut off. 
##             While value of q should be 1 or 2. After a few iterations, we found that (0,1,1) as (p,d,q) comes out to be the combination with least AIC and BIC.
pacf(diff(log(AirPassengers)))  

## 3. Prediction using ARIMA
(fit <- arima(log(AirPassengers), c(0, 1, 1), 
              seasonal = list(order = c(0, 1, 1), 
                              period = 12)))

pred <- predict(fit, n.ahead = 10*12)

ts.plot(AirPassengers, 2.718^pred$pred, log = "y", lty = c(1,3))
