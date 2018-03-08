##########################################
## Inspired by a book by Dr. N.D. Lewis ##
## ------------------------------------ ##
## Date: 06-Mar-2018                    ##
##########################################

## load library
source("./load library.R")

## load lag calculator
# source("./lag_calculator.R")


## --------------------------------------------------- ##
## Example: Forecasting the number of new cases of     ##
## Escherichia coli.                                   ##
## --------------------------------------------------- ##

## -- Step 1. load data
data("ecoli", package = "tscount")

## -- Step 2. Exploring and preparing the data
## pull response variable
y <- ecoli %>%
  dplyr::pull(cases)

# y <- ecoli %>%
#   dplyr::filter(year <= 2009) %>%
#   dplyr::pull(cases)

## create time series variable
y2 <- ts(y, start = c(2001, 1), end = c(2013, 20), frequency = 52)

## Visualizing the data
plot(y2, xlab='Date', ylab='Number of Cases', col='darkblue')

## partial autocorrelation plot (ACF)
pacf(y2)

## derive lag variables
# data_unstd <- lag_calculator(y = y, n_lags = 4)
# data_std <- lag_calculator(y = y, n_lags = 4, scale = TRUE, scale_type = "range")


## -- Step 3. Training a Model on the Data
# data <- data_unstd
# data <- data_unstd
# data <- y2

## partition dataset for training/testing
# set.seed(pi)
# 
# myTimeControl <- trainControl(method = "timeslice", 
#                               initialWindow = 40, 
#                               horizon = 12, 
#                               fixedWindow = TRUE)
# 
# # m1 <- caret::train(y ~ ., data = data, method = "nnet", linout=TRUE, trace=FALSE)
# m2 <- caret::train(y ~ ., data = data, 
#                    method = "neuralnet", 
#                    preProc = c("center", "scale"), 
#                    hidden = c(10, 2),
#                    trControl = myTimeControl
#                    # ,  
#                    # algorithm = 'backprop', learningrate = 0.25, hidden = 3, linout = TRUE
#                    )

## using pkg::forecast
fit_nnetar_default <- forecast::nnetar(y = y2)
fit_nnetar_default

fcast_default <- forecast::forecast(object = fit_nnetar_default, PI = TRUE)
plot(fcast_default)
autoplot(fcast_default)

fit_nnetar <- forecast::nnetar(y = y2, p = 4, size = 4)
fit_nnetar
# plot(fit_nnetar)     ## failed

fcast <- forecast::forecast(object = fit_nnetar, PI = TRUE)
plot(fcast)
autoplot(fcast)

fcast_summary <- summary(fcast)
mean <- fcast$mean


fcast_fitvalues <- fitted.values(fcast)
# plot(fcast_summary)

# sim <- ts(matrix(0, nrow=20, ncol=9), start=end(y)[1]+1)
# for(i in seq(9))
#   sim[,i] <- simulate(m3, nsim=20)
# 
# library(ggplot2)
# autoplot(y) + forecast::autolayer(sim)
# 
# ## prediction
# pred_m1 <- predict(m1, data)
# 
# ## Examine results
# pred_m1_ts <- ts(pred_m1, start = c(2001, 1), end = c(2013, 20), frequency = 52)
# 
# plot(y2, xlab='Date', ylab='Number of Cases', col='2')
# lines(pred_m1_ts, col=3)
# # legend(5, 70, c("y", "pred"), cex=1.5, fill=2:3)

