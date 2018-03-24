
################################
## Environmental settings.    ##
################################
## Set the working directory
setwd("./TripAdvisor/tourism/")

## Install and load library
library(xml2)         ## for read_html function
library(rvest)        ## for all other functions important for Web Scrapping, please see documentation
library(stringr)      ## for regex
library(readr)        ## for import/export of data
library(dplyr)        ## for data manipulation

#######################################################
## Get all reviews about Lalibela from TripAdvisor.  ##
#######################################################
## Main TripAdvisor URL
TripAdvisor_url <- "https://www.tripadvisor.com"

## Load source codes used for extracting reviews
source("./functions/get_10Reviews.R")
source("./functions/get_allReviews.R")

## Read reviews
## -- As of today (21 Dec 2017), there are a total of 97 pages of reviews found in TripAdvisor for Lalibela
reviews <- get_allReviews(num_pages = 97)


################################################
## Combine reviews data with other columns.   ##
################################################
TripAdvisor_lalibela_homePage <- "https://www.tripadvisor.com/Attraction_Review-g480193-d324957-Reviews-Rock_Hewn_Churches_of_Lalibela-Lalibela_Amhara_Region.html"
TripAdvisor_lalibela <- xml2::read_html(TripAdvisor_lalibela_homePage)

## get number of reviews about Lalibela
total_reviews <- TripAdvisor_lalibela %>%
  rvest::html_nodes(".seeAllReviews") %>%
  rvest::html_text() %>%
  stringr::str_replace(pattern = "(reviews)", replacement = "") %>%   ## removes the text "reviews"
  stringr::str_trim() %>%
  stringr::str_replace(pattern = ",", replacement = "") %>%   ## removes the comma
  as.numeric() %>%
  print()

## get location of Lalibela church
attraction_location <- TripAdvisor_lalibela %>%
  rvest::html_node(".address") %>%
  rvest::html_text() %>%
  print()

## Date for data access
date_dataAccess <- Sys.Date() %>%
  format(format = "%B %d, %Y") 

## Combine main reviews data and additional info about the site
reviews_final <- data.frame(site="lalibela", attraction_location, total_reviews, 
                            date_dataAccess, reviews 
)


#################################################
## Export reviews data as a CSV file format.   ##
#################################################
## Define filename
filename_reviews <- paste("./output/rawdata/reviews_TripAdvisor_lalibela-", 
                          format(Sys.Date(), format="%B_%d_%Y"), 
                          ".csv", 
                          sep = "")

## Export reviews data
readr::write_csv(x = reviews_final, path = file.path(filename_reviews))








