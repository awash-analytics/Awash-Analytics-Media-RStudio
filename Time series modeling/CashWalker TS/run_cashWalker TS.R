
## load dependence library
source("./load_library.R")

## load main library
library(forecast)
library(tseries)

#############################
## load source dataset.    ##
#############################
bank_rwdata <- readxl::read_excel(path = "./../../../cashWalker_rawdata/transactions_20160216_20170815.xls", sheet = "Sheet0", col_names = TRUE)


#############################
## Preprocess dataset.     ##
#############################
## preprocess date 
bank_analdata1 <- bank_rwdata %>% 
  dplyr::select(transactiondate, amount) %>% 
  dplyr::mutate(date = lubridate::ymd(transactiondate)) %>%
  dplyr::mutate(year = lubridate::year(date)) %>% 
  dplyr::mutate(year_f = as.factor(year)) %>% 
  dplyr::mutate(month = lubridate::month(date, label = TRUE, abbr = TRUE)) %>% 
  dplyr::mutate(week = lubridate::week(date))  %>% 
  # dplyr::mutate(day = lubridate::day(date))  %>% 
  # dplyr::mutate(wkday = lubridate::wday(date, label = TRUE, abbr = FALSE)) %>% 
  dplyr::select(-transactiondate)

## preprocess amount (make expense to positive value)
bank_analdata2 <- bank_analdata1 %>% 
  dplyr::mutate(amount_tmp = amount) %>%
  dplyr::mutate(amount = abs(amount_tmp)) %>% 
  dplyr::select(-amount_tmp)

## collapse dat by week and then remove big expenses (e.g., housing, etc)
bank_analdata3 <- bank_analdata2 %>% 
  dplyr::group_by(date, year_f, month, week) %>% 
  dplyr::summarise(amount_week = sum(amount)) %>% 
  dplyr::filter(!amount_week > 150) %>% 
  dplyr::select(date, year_f, month, week, amount_week)

## create final dataset
bank_analdata <- bank_analdata3

###################################
## Split dataset by train/test.  ##
###################################
## train dataset
expense_train <- bank_analdata %>% 
  dplyr::filter(year_f %in% c("2016"))

## test dataset
expense_test <- bank_analdata %>% 
  dplyr::filter(year_f %in% c("2017"))

####################################
## Exploratory data analysis.     ##
####################################
ggplot2::ggplot(data = expense_train, 
                mapping = aes(x = week, y = amount_week, group = year_f)) +
  geom_line() +
  facet_grid(facets = year_f ~ .) +
  xlab("Week") + ylab("Expense") +
  theme_bw()

####################################
## Modeling.                      ##
####################################
## create time series dataset
## - IMPORTANT: To know how to define START/END options, run <cycle(ts_train)>
# ts_train <- ts(expense_train$amount_week, frequency = 52, start=7, end=53)      ## The value START=7 and END=53 is based on observed weekly time points from train dataset
# ts_train <- ts(expense_train$amount_week, frequency = 52, 
#                start = c(2016, 7), 
#                end = c(2016, 53))
ts_train <- ts(expense_train$amount_week, frequency = 365.25/7, 
               start = c(2016, 7), 
               end = c(2016, 53))

## check
cycle(ts_train)

## plot for time series
png("./time series plot.png")
plot(ts_train, ylab = "Expense", xlab = "Time")
dev.off()

# plot(ts_train, ylab = "Expense", xlab = "Time")

## plot for decompose TS by trend and seasonality
# png("./time series plot - decompose.png")
# plot(decompose(ts_train, type = "additive"))
# dev.off()

# plot(decompose(ts_train, type = "additive"))

## ------------------------------------ ##
## Conclusion (from previous plot):     ##
## - No trend effect ??                 ##
## - There's seasonality (week) eefect. ##
## ------------------------------------ ##

## Get residuals for TS analysis
ts_decompose <- decompose(ts_train, type = "additive")
ts_random <- ts_decompose$random

## Model 1: Remove trend/seasonality
# lm1 <- lm(ts_train ~ time(ts_train) + factor(cycle(ts_train)), data = ts_train)
lm1 <- lm(ts_train ~ time(ts_train) + as.numeric(cycle(ts_train)), data = ts_train)

summary(lm1)




