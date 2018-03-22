
## load library
source("./functions/load library.R")

## load analysis dataset (obtained during the second episode)
lalibela_data <- readr::read_csv(file = file.choose(), col_names = T, na = "NA")

## calculate sentimenet values
lalibela_data$sentiment <- syuzhet::get_sentiment(char_v = as.character(lalibela_data$title), 
                                                  method = "nrc")

## -- negative feedback
neg_feedback <- lalibela_data %>% 
  dplyr::filter(sentiment < 0) %>% 
  dplyr::select(title, City, Country, sentiment)

## ---------------------- ##
## Development area.      ##
## ---------------------- ##
mywords <- data.frame(word = as.character(c("good", "bad", "good and bad", "amazing", "amazing and bad")))

# mywords2 <- mywords %>% 
#   dplyr::inner_join(tidytext::get_sentiments(lexicon = "nrc"))

mywords$sentiment <- syuzhet::get_sentiment(char_v = as.character(mywords$word), method = "nrc")
