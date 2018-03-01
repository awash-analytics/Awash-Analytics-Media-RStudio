######################################
## Inspired by the ff articles.     
## 1. https://datascienceplus.com/fitting-neural-network-in-r/
######################################

## -------------------------- ##
## Environmental setting.     ##
## -------------------------- ##
## load library
source("./load_library.R")

## set seed
set.seed(pi)

## ---------------------- ##
## load Boston dataset.   ##
## ---------------------- ##
data("Boston")

## ---------------------- ##
## Preprocessing.         ##
## ---------------------- ##
## check for missingness
summary(Boston)

## ---------------------- ## 
## Modeling.              ##
## ---------------------- ## 
## creaet train and test dataset
i_train <- caret::createDataPartition(y = Boston$medv, p = 0.75, list = FALSE)

train <- Boston[i_train, ]
test <- Boston[-i_train, ]

## create feature and response datasets
features <- train %>%
  dplyr::select(-medv)
response <- train %>%
  dplyr::select(medv) %>%
  unlist() %>%
  as.numeric()

## fit linear regression model
fit_lm <- caret::train(x = features, y = response, method = "lm")
fit_glm <- caret::train(x = features, y = response, method = "glm")

## predict 
features_test <- test %>%
  dplyr::select(-medv)
response_test <- test %>%
  dplyr::select(medv)

pred_lm <- predict(object = fit_lm, newdata = features_test)

pred_lm_ds <- data.frame(pred_lm, response_test)







