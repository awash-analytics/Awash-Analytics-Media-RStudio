
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
## Reading all reviews for an attraction site.       ##
#######################################################
## Load custom source codes
source("./functions/get_10Reviews.R")
source("./functions/get_allReviews_v2.R")

## Get reviews about Lalibela, Ethiopia
reviews_lalibela <- get_allReviews(nbr_page = 2, 
                                   site_gCode = "480193", site_dCode = "324957", 
                                   site_name = "Rock_Hewn_Churches_of_Lalibela", site_geoLocation = "Lalibela_Amhara_Region"
                                   )

## Get reviews about Axum, Ethiopia
reviews_axum <- get_allReviews(nbr_page = 2, 
                               site_gCode = "3667784", site_dCode = "324991", 
                               site_name = "The_Ruins_of_Aksum", site_geoLocation = "Axum_Tigray_Region"
                               )

## Get reviews about Mount Kenya, Kenya
reviews_mountKenya <- get_allReviews(nbr_page = 2, 
                                     site_gCode = "319715", site_dCode = "1936998", 
                                     site_name = "Mount_Kenya", site_geoLocation = "Mount_Kenya_National_Park"
                                     )

## Get reviews about Louvre Museum, Paris, France
reviews_louvreMuseum <- get_allReviews(nbr_page = 2, 
                                       site_gCode = "187147", site_dCode = "188757", 
                                       site_name = "Louvre_Museum", site_geoLocation = "Paris_Ile_de_France"
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








