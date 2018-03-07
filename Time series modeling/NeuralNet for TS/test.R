# set.seed(pi)
# qwe <- as.numeric(round(runif(10,10,20)))
# 
# qwe <- data.frame(cbind(qwe, z=scale(qwe), cnt = cen rng=range(qwe)))

## -- partitoning TS data
## source: https://stackoverflow.com/questions/24758218/time-series-data-spliting-and-model-evaluation
library(pls)

# economics_raw <- dplyr::as_data_frame(data(economics))

## get week variable for economics dataset
economics2 <- economics %>%
  dplyr::mutate(date = lubridate::ymd(date)) %>%
  dplyr::mutate(year = lubridate::year(date)) %>%
  dplyr::mutate(week = lubridate::week(date)) %>%
  dplyr::select(date, year, week)
  
## max(week) = 48
timeSlices <- createTimeSlices(1:nrow(economics), 
                               initialWindow = 36, horizon = 12, fixedWindow = TRUE)
str(timeSlices,max.level = 1)

trainSlices <- timeSlices[[1]]
testSlices <- timeSlices[[2]]

i_trainCtrl <- trainSlices[[1]]
i_trainCtrl2 <- trainSlices[[2]]

i_testCtrl <- testSlices[[1]]
i_testCtrl2 <- testSlices[[2]]

## ---
## Apply the above StackOverflow logic for ecoli dataset
## ---
## get week variable for economics dataset
## max(week) = 53
max(ecoli$week)

# timeSlices <- caret::createTimeSlices(1:nrow(ecoli), 
#                                       initialWindow = 41, horizon = 12, fixedWindow = TRUE)
# str(timeSlices,max.level = 1)
# 
# trainSlices <- timeSlices[[1]]
# testSlices <- timeSlices[[2]]
# 
# ## view
# i_trainCtrl <- trainSlices[[1]]
# i_trainCtrl2 <- trainSlices[[2]]
# i_trainCtrl594 <- trainSlices[[594]]
# length(i_trainCtrl594)
# 
# i_testCtrl <- testSlices[[1]]
# i_testCtrl2 <- testSlices[[2]]
# i_testCtrl594 <- testSlices[[594]]

## -- Similarly, 
myTimeControl <- trainControl(method = "timeslice", 
                              initialWindow = 41, 
                              horizon = 12, 
                              fixedWindow = TRUE)

plsFitTime <- train(unemploy ~ pce + pop + psavert,
                      data = economics, 
                      method = "pls", 
                      preProc = c("center", "scale"), 
                      trControl = myTimeControl)

#################################################
## Testing NNER function from pkg::forecast    ##
#################################################
data("lynx")
help("lynx")

