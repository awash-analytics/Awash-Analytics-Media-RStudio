######################################################
## Minining Lalibela (Part 2) by Awash Analytics.   ##
## ------------------------------------------------ ##
## Blog: http://awash-analytics.info                ##
## ------------------------------------------------ ##
## Date: March 2018.                                ##
######################################################

## load library
source("./load library.R")

## load custom functions
source("./functions/get_geoLocation.R")

##################################
## Step 1. Import raw dataset.  ##
##################################
lalibela_raw <- readr::read_csv(file = "./output/rawdata/reviews_TripAdvisor-lalibela_December_22_2017.csv", col_names = T)

##################################
## Step 2. Preprocess data.     ##
##################################
## -- keep only records whose user location is known
lalibela_flt <- lalibela_raw %>% 
  dplyr::filter(!is.na(user_location)) %>% 
  dplyr::select(attraction_location, title, date, user_location, date_dataAccess)

## -- preprocess date variable
lalibela_prep1 <- lalibela_flt %>% 
  dplyr::mutate(date_raw = as.Date(date, format = "%B%d,%Y")) %>% 
  dplyr::filter(!is.na(date_raw)) %>%         ## drop records with latest reviews (e.g., date = 4 days ago)
  dplyr::select(-date) %>% 
  dplyr::mutate(year = lubridate::year(date_raw)) %>% 
  dplyr::mutate(month = lubridate::month(date_raw)) %>% 
  dplyr::mutate(day = lubridate::day(date_raw)) 

## --------------------------------------------------------------------------------- ##
## -- preprocess user location (i.e., get latitude/longitude for user location).     ##
## Get an API Key from the Google API Console                                        ##
## --------------------------------------------------------------------------------- ##
## --------------------------------------------------------------------------------------------------------------- ##
## -- source:                                                                   
## -- 1. https://stackoverflow.com/questions/36175529/getting-over-query-limit-after-one-request-with-geocode
## -- 2. https://developers.google.com/maps/documentation/geocoding/get-api-key?refresh=1
## --------------------------------------------------------------------------------------------------------------- ##
donotrun_prep2 <- function() {
  google_api <- readLines(con = "./../../../api/ggmap_geocode_api.txt")
  
  ## Register api
  ggmap::register_google(key = google_api)
  
  # ## filter user location
  # lalibela_prep1$user_location_splt <- stringr::str_split_fixed(string = lalibela_prep1$user_location, pattern = "\\,", n = 2)
  
  ## Get latitude/longitude for user location
  user_loc_lalibela <- get_geoLocation(dsin = lalibela_prep1, place_type = "user_location")
  
  ## Save user location data
  readr::write_csv(x = user_loc_lalibela, path = "./output/part 2/user_loc_lalibela.csv", col_names = T)
}

## -- Merge dataset
user_loc_lalibela <- readr::read_csv(file = "./output/part 2/user_loc_lalibela.csv", col_names = TRUE)

## -- add geo-location info to main analysis dataset
lalibela_prep2 <- sqldf("SELECT A.*, B.lon_user_location, B.lat_user_location
                         FROM lalibela_prep1 AS A 
                         LEFT JOIN user_loc_lalibela AS B 
                         ON A.user_location = B.user_location")

##################################
## Step 3. Visualization.       ##
##################################
