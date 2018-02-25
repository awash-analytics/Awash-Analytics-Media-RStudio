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
