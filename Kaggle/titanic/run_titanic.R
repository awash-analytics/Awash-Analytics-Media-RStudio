
## load library
source("./load_library.R")

## load datasets
train <- readr::read_csv(file = "./datasets/train.csv", col_names = TRUE, na = "")
test <- readr::read_csv(file = "./datasets/test.csv", col_names = TRUE, na = "")
gender_submission <- readr::read_csv(file = "./datasets/gender_submission.csv", col_names = TRUE, na = "")
