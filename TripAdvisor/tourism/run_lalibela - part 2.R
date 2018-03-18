######################################################
## Minining Lalibela (Part 2) by Awash Analytics.   ##
## ------------------------------------------------ ##
## Blog: http://awash-analytics.info                ##
## ------------------------------------------------ ##
## Date: March 2018.                                ##
######################################################

## load library
source("./functions/load library.R")

## load custom functions
source("./functions/get_geoLocation.R")

##################################
## Step 1. Import raw dataset.  ##
##################################
lalibela_raw <- readr::read_csv(file = "./output/rawdata/reviews_TripAdvisor-lalibela_December_22_2017.csv", col_names = T)

##################################
## Step 2. Preprocess data.     ##
##################################
## -- preprocess user location
lalibela_flt <- lalibela_raw %>% 
  dplyr::filter(!is.na(user_location)) %>%    ## keep only records whose user location is known
  dplyr::mutate(user_location_tmp = user_location) %>%     ## get copy of user location
  dplyr::mutate(user_location = unlist(stringr::str_extract_all(string = user_location_tmp, pattern = "\\D+"))) %>%   ## drop numeric values, important to find the lon/lat of user location
  dplyr::select(attraction_location, title, date, user_location, date_dataAccess)

## -- preprocess date values
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
  # google_api <- readLines(con = "./../../../api/ggmap_geocode_api.txt")
  google_api <- readLines(con = file.choose())
  
  ## Register api
  ggmap::register_google(key = google_api)
  
  # ## filter user location
  # lalibela_prep1$user_location_splt <- stringr::str_split_fixed(string = lalibela_prep1$user_location, pattern = "\\,", n = 2)
  
  ## Get latitude/longitude for user location
  user_loc_lalibela <- get_geoLocation(dsin = lalibela_prep1, place_type = "user_location")
  
  ## -- Drop unknown country (e.g., user_location = "europe")
  user_loc_lalibela_flt <- user_loc_lalibela %>% 
    dplyr::filter(!Country == "NA")
  
  ## Save user location data
  fname_out <- file.path(paste("./output/part 2/user_loc_lalibela_", Sys.Date(), ".csv", sep = ""))
  
  readr::write_csv(x = user_loc_lalibela_flt, path = fname_out, col_names = T)
}

## -- Merge dataset, add geo-location info to the main analysis dataset
user_loc_lalibela <- readr::read_csv(file = file.choose(), col_names = TRUE)

lalibela_prep2 <- lalibela_prep1 %>% 
  dplyr::left_join(user_loc_lalibela, by = "user_location")

## -- drop unknown lon/lat (e.g., user_location = "europe")
lalibela_prep3 <- lalibela_prep2 %>% 
  dplyr::filter( !is.na(lon_user_location) | !is.na(lat_user_location) )

## Save the final (preprocessed) dataset for later analysis in Episode 3 (i.e., visualization)
fname_out <- file.path(paste("./output/part 2/lalibela_preprocessed_", Sys.Date(), ".csv", sep = ""))

readr::write_csv(x = lalibela_prep3, path = fname_out)




