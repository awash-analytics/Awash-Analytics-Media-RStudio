
#############################################################################################
## Inspired by Trevor Stephens (Data Scientist)                                            ##
## source: http://trevorstephens.com/kaggle-titanic-tutorial/getting-started-with-r/       ##
#############################################################################################
## Data source: Kaggle (https://www.kaggle.com/c/titanic/data)                             ##
#############################################################################################
## Date: 21FEB2018 (Initial version)                                                       ##                                    
#############################################################################################

## load library
source("./load_library.R")

## load datasets
train <- readr::read_csv(file = "./datasets/train.csv", col_names = TRUE, na = "")
test <- readr::read_csv(file = "./datasets/test.csv", col_names = TRUE, na = "")
gender_submission <- readr::read_csv(file = "./datasets/gender_submission.csv", col_names = TRUE, na = "")

## summary stat
table(train$Survived)
prop.table(table(train$Survived))


################################################################
## Model 0: The naive model (assumes all travellers died).    ##
################################################################
test$Survived <- rep(0, 418)

submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
readr::write_csv(x = submit, path = "./submissions/theyallperish.csv", col_names = TRUE)



