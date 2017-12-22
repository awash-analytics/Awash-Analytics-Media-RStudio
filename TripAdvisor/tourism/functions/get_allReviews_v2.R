#' 
#' Extracts reviews of an attraction site posted by tourists on TripAdvisor website.
#' It takes care of single and multiple pages.
#' 
#' @param nbr_page the number of pages to grab.
#' @param site_gCode the "g" code as defined by TripAdvisor pagination. Please see the example below.
#' @param site_dCode the "d" code as defined by TripAdvisor pagination. Please see the example below.
#' @param site_name the name of an attraction site.
#' @param site_geoLocation the geographical location of an attraction site. Not that this is not related to a latitude/longitude values. Please see the example below.
#' 
#' @describe This source code calls get_10Reviews.R program to extract the required components (e.g., review title, date, device). Depending on
#' a user request, it can also loop through multiple pages. Finally, it adds extra columns (e.g., attraction location, number of reviews, etc) 
#' to existing reviews stored in a dataframe.
#' 
#' @author Awash Analytics (December 2017)
#' 
#' @example reviews_lalibela <- get_allReviews(nbr_page = 2, 
#'                                             site_gCode = "480193", site_dCode = "324957", 
#'                                             site_name = "Rock_Hewn_Churches_of_Lalibela", site_geoLocation = "Lalibela_Amhara_Region"
#'                                             )
#' 

get_allReviews <- function(nbr_page = NULL, 
                           site_gCode = NULL, site_dCode = NULL, 
                           site_name = NULL, site_geoLocation = NULL) {
  
  message("Page extraction is started: ", date())
  
  ## Main TripAdvisor URL
  TripAdvisor_url <- "https://www.tripadvisor.com"
  
  ## loop through reviews page
  for (i in 1:nbr_page) {
    print(paste("i = ", i, sep = " "))
    
    ## Construct url address associated to the reviews page
    url_extCommon <- paste("/Attraction_Review-g", site_gCode, "-d", site_dCode, "-Reviews-", 
                           sep = "") 
    
    if (i == 1) {
      # reviewHomePg <- "/Attraction_Review-g480193-d324957-Reviews-Rock_Hewn_Churches_of_Lalibela-Lalibela_Amhara_Region"
      reviewHomePg <- paste(url_extCommon,
                            site_name, "-", site_geoLocation, 
                            sep = "")
      
      TripAdvisor_reviewUrl <- paste(TripAdvisor_url, reviewHomePg, ".html", 
                                           sep = "") 
      
      ## Backup review home address for later use
      TripAdvisor_reviewHomeUrl <- TripAdvisor_reviewUrl
    } 
    else {
      # reviewOtherPg <- paste("/Attraction_Review-g480193-d324957-Reviews-or", i-1, "0-Rock_Hewn_Churches_of_Lalibela-Lalibela_Amhara_Region",
      #                                 sep = "")
      reviewOtherPg <- paste(url_extCommon, 
                             "or", i-1, "0-", 
                             site_name, "-", site_geoLocation, 
                             sep = "")
      
      TripAdvisor_reviewUrl <- paste(TripAdvisor_url, reviewOtherPg, ".html",
                                           sep = "")
    }
    
    ## Read reviews given about an attraction site 
    TripAdvisor_topic <- xml2::read_html(TripAdvisor_reviewUrl)
    
    ## Get main container which contains a single review
    reviewer_container <- TripAdvisor_topic %>%
      html_nodes("div.review-container")
    
    ## Get all components of reviews (e.g., title, location, device, etc) and loop through the ten (10) reviews
    reviews_data <- lapply(X = reviewer_container, get_10Reviews) %>%
      dplyr::bind_rows()
    
    ## Concatenate reviews obtained from all pages
    if (i == 1) {
      reviews_dataAll = data.frame(page_nbr = i, reviews_data)
    } else {
      reviews_dataAll <- rbind(reviews_dataAll, 
                               data.frame(page_nbr = i, reviews_data))
    }
  }
  
  #############################################################################################################################
  ## Combine reviews data with other variables available in review homepage (e.g., number of reviews, site location, etc).   ##
  #############################################################################################################################
  # TripAdvisor_homePage <- "https://www.tripadvisor.com/Attraction_Review-g480193-d324957-Reviews-Rock_Hewn_Churches_of_Lalibela-Lalibela_Amhara_Region.html"
  TripAdvisor_reviewHome <- xml2::read_html(TripAdvisor_reviewHomeUrl)
  
  ## Get total number of reviews given for an attraction site
  total_reviews <- TripAdvisor_reviewHome %>%
    rvest::html_nodes(".seeAllReviews") %>%
    rvest::html_text() %>%
    stringr::str_replace_all(pattern = "(reviews)|(\\\nRead\\s+(all))", replacement = "") %>%   ## removes the text "reviews"
    stringr::str_trim() %>%
    stringr::str_replace(pattern = ",", replacement = "") %>%           ## removes the comma
    as.numeric() %>%
    dplyr::first()          ## In case, multiple values are returned (e.g., "204", "204" which is true for Axum, Ethiopia)
  
  ## get attraction site location
  attraction_location <- TripAdvisor_reviewHome %>%
    rvest::html_node(".address") %>%
    rvest::html_text() 
  
  ## Date for data access
  date_dataAccess <- Sys.Date() %>%
    format(format = "%B %d, %Y")          ## this gives date format like "December 21, 2017"
  
  ## Combine main reviews data and additional info about the site
  reviews_final <- data.frame(attraction_location, total_reviews, 
                              date_dataAccess, reviews_dataAll 
  )
  
  message("Page extraction is completed: ", date())
  
  return(reviews_final)
}