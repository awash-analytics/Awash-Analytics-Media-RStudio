
## load library
source("./lalibela - part 3/time series analysis/functions/load_library.R")

## --------------------------------------------------- ##
## Step 1. Reading analysis dataset and preprocess.    ##
## --------------------------------------------------- ##
## Import analysis dataset from the second episode folder
lalibela_data <- readr::read_csv(file = file.choose(), col_names = T, na = "NA")

## count number of tourists per month
lalibela <- lalibela_data %>% 
  dplyr::group_by(year, month) %>% 
  dplyr::summarise(count = n()) %>% 
  dplyr::select(year, month, count)

## create date column from year and month variables
lalibela_ready <- lalibela %>% 
  dplyr::mutate(date = as.Date(as.yearmon(paste(year, month, sep = "-"))))


## ---------------------------------- ##
## Step 2. Time series analysis.      ##
## ---------------------------------- ##
## create time series variable
count_tourist_xts <- xts::xts(x = lalibela_ready$count, 
                              order.by = lalibela_ready$date, 
                              frequency = 12)

## plot
filename_out <- file.path(paste("./lalibela - part 3/time series analysis/plots/number of tourists for lalibela (", Sys.Date(), ").png", sep = ""))
png(filename = filename_out)

plot(count_tourist_xts)

dev.off()






