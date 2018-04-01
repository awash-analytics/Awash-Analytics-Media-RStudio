## Load library
library(tidyverse)     ## data science framework
library(leaflet)       ## construct map
library(ggmap)         ## fetch geolocation
library(htmlwidgets)   ## save leaflet map

## Load source codes
source("./lalibela - part 2 (Preprocessing)/functions/get_geoLocation.R")    ## to extract geo-location

## Load dataset
data_all <- readr::read_csv(file = file.choose(), col_names = T)

## Remove missing city/country
data_prepro <- data_all %>%
  dplyr::filter(!is.na(City)) %>%
  dplyr::filter(!is.na(Country))

## Get metadata for city/country
# metadata_city <- data_prepro %>%
#   dplyr::select(Country, City, lon_user_location, lat_user_location) %>%
#   unique() %>%
#   dplyr::arrange(Country, City)

metadata_country <- data_prepro %>%
  dplyr::select(Country) %>%
  unique() %>%
  dplyr::arrange(Country)

## Get geolocation of countries
# google_api <- readLines(con = file.choose())
# ggmap::register_google(key = google_api)
# 
# metadata_country_lonLat <- get_geoLocation(dsin = metadata_country,
#                                            user_location = "Country")
# 
# ## Save geolocation
# metadata_country <- metadata_country_lonLat %>% 
#   dplyr::select(Country, lon_Country, lat_Country)
# 
# readr::write_csv(x = metadata_country, path = "./lalibela - part 3 (Data Analysis)/visualization/output/metadata_country.csv", 
#                  col_names = T)

## Import metadata
metadata_country <- readr::read_csv(file = file.choose(), col_names = T)

## ----------------------------
## Summarize by City/country.
## ----------------------------
# data_city <- data_prepro %>%
#   dplyr::group_by(City) %>%
#   dplyr::summarise(count = n())

data_country <- data_prepro %>%
  dplyr::group_by(Country) %>%
  dplyr::summarise(count = n())

# ## Get lon/lat info
# data_lonlat <- data_city %>%
#   dplyr::left_join(metadata_city, by = c("City"))

# ## Combine City and Country
# data <- data_city_lonlat %>%
#   dplyr::mutate(city_country = paste(City, ", ", Country, sep = ""))


## Get geolocation from metadata file
data <- data_country %>% 
  dplyr::left_join(metadata_country, by = "Country") 

## Derive popup message for leaflet plot
data <- data %>% 
  dplyr::mutate(popup_msg = paste(Country, " (n = ", count, ")", sep = ""))

# readr::write_csv(x = data, path = "./lalibela - part 3 (Data Analysis)/visualization/output/data_leaflet.csv", col_names = T)

## --------------------------------
## Visualization using leaflet.
## --------------------------------
## Main plot
my_map <- leaflet::leaflet(data = data) %>%
  # addTiles()
  addProviderTiles(providers$OpenStreetMap)      ## This renders the whole map when the map is saved as html file

## Populate lon/lat
map <- my_map %>%
  leaflet::addCircleMarkers(lng = data$lon_Country, lat = data$lat_Country,
                            radius = log(data$count) * 3, weight = 1.5, 
                            popup = data$popup_msg) %>% 
  leaflet::addLegend(position = "bottomright", values = data$popup_msg, colors = data$popup_msg)
map

## save map
## -- It is better to save the map manually!!!
# htmlwidgets::saveWidget(widget = map, file = "test.html", selfcontained = F)






