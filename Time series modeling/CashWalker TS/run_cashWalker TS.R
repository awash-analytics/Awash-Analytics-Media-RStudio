
## load dependence library
source("./load_library.R")

## load main library
library(forecast)

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
  dplyr::mutate(day = lubridate::day(date))  %>% 
  dplyr::mutate(wkday = lubridate::wday(date, label = TRUE, abbr = FALSE)) %>% 
  dplyr::select(-transactiondate)

## preprocess amount
bank_analdata2 <- bank_analdata1 %>% 
  dplyr::mutate(amount_tmp = amount) %>%
  dplyr::mutate(amount = abs(amount_tmp)) %>% 
  dplyr::select(-amount_tmp)

## collapse daily amount, and remove big expenses (e.g., housing, etc)
bank_analdata3 <- bank_analdata2 %>% 
  dplyr::group_by(date, year_f, month, day, wkday) %>% 
  dplyr::summarise(amount_day = sum(amount)) %>% 
  dplyr::filter(!amount_day > 150) %>% 
  dplyr::select(date, year_f, month, day, wkday, amount_day)

## create final dataset
bank_analdata <- bank_analdata3

####################################
## Exploratory data analysis.     ##
####################################
ggplot2::ggplot(data = bank_analdata, 
                mapping = aes(x = day, y = amount_day, group = year_f)) +
  geom_line() +
  facet_grid(facets = year_f ~ .) +
  xlab("Day") + ylab("Expense") +
  theme_bw()



