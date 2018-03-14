

get_geoLocation <- function (dsin = NULL, place_type = NULL) {
  
  ## get unique location (e.g., country/city) names
  # locations_all <- dsin[, place_type]
  locations_all <- dsin %>% 
    dplyr::pull(place_type)
  locations_uniq <- unique(locations_all)
  
  # get geo-location value from Google
  geo_res <- data.frame(a = character(), b = numeric(), c = numeric(), 
                        d = character(), e = character())
  
  for (place in locations_uniq) {
    
    ## get lon/lat
    geo_val <- ggmap::geocode(location = place)
    
    ## get city/country info
    if ( !is.na(geo_val$lon) | !is.na(geo_val$lat) ) {
      
      ## get city/country info
      revGeo_val <- ggmap::revgeocode(location = c(geo_val$lon, geo_val$lat), 
                                      output = "more")
      
      ## Get city
      city_temp <- as.character(revGeo_val$locality)
      
      if ( !purrr::is_empty(city_temp) ) {           ## evaluate empty character variable in R
        city <- city_temp
      } else {
        city <- "NA"
      }
      
      ## Get country
      country_temp <- as.character(revGeo_val$country)
      
      if ( !purrr::is_empty(country_temp) ) {
        country <- country_temp
      } else {
        country <- "NA"
      }
    } 
    else {
      
      ## fetching for lon/lat was not successful
      city <- "NA"
      country <- "NA"
    }
    
    ## combine results
    geo_val <- cbind(place, geo_val, city, country)
    
    geo_res <- rbind(geo_res, geo_val)
  }
  
  ## Modify column names
  geo_res <- as.data.frame(geo_res)
  colnames(geo_res) <- c(place_type, 
                         paste("lon", "_", place_type, sep = ""), 
                         paste("lat", "_", place_type, sep = ""),
                         "City", "Country")
  
  ## Change factor variables to character, if required
  geo_res_final <- geo_res %>% dplyr::mutate_if(is.factor,as.character)
  
  return(geo_res_final)
}