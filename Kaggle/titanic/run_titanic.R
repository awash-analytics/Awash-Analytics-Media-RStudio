
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

## submission
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
readr::write_csv(x = submit, path = "./submissions/theyallperish.csv", col_names = TRUE)


#########################################
## Model 1: The gender-class model.    ##
#########################################
table(train$Sex)

## two-way comparison on the number of males and females that survived
prop.table(table(train$Sex, train$Survived))

## -- Row-wise proportion
## -- conclustion: We now can see that the majority of females aboard survived, and a very low percentage of males did.
prop.table(table(train$Sex, train$Survived), 1)

## Building Model 1
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1

## submission
submit_mod1 <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
readr::write_csv(x = submit_mod1, path = "./submissions/gender_class_model.csv", 
                 col_names = TRUE)


#########################################
## Model 2: The gender and age model.  ##
#########################################

## Issue: missing values
## -- Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
## -- 0.42   20.12   28.00   29.70   38.00   80.00     177 
## conclusion (missing values): It is possible for values to be missing in data analytics, 
##                              and this can cause a variety of problems out in the real 
##                              world that can be quite difficult to deal with at times. 
## For now we could assume that the 177 missing values are the average age of the rest of the passengers, ie. late twenties.
summary(train$Age)

## categorize age
## assumption: any passengers with an age of NA have been assigned a zero, 
##             this is because the NA will fail any boolean test. This is what we wanted though, since we had decided to use the average age, which was an adult.
train$Child <- 0
train$Child[train$Age < 18] <- 1

## summary for sex and child variables
aggregate(Survived ~ Child + Sex, data=train, FUN=sum)
aggregate(Survived ~ Child + Sex, data=train, FUN=length)

## conclusion: 
## Well, it still appears that if a passenger is female most survive, 
## and if they were male most don’t, regardless of whether they were a child or not. 
## So we haven’t got anything to change our predictions on here.
aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

######################
## Fare variable.   ##
######################
## categorize
train$Fare2 <- "30+"
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- "20-30"
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- "10-20"
train$Fare2[train$Fare < 10] <- "<10"

## summarize
aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

## prediction
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare >= 20] <- 0

## submission
submit_mod2 <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
readr::write_csv(x = submit_mod2, path = "./submissions/submit_model2.csv", 
                 col_names = TRUE)




















