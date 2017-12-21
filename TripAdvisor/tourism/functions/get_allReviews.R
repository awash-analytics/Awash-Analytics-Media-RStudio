get_allReviews <- function(num_pages) {
  
  message("Page extraction is started: ", date())
  
  ## loop through reviews page
  for (i in 1:num_pages) {
    
    ## Get appropriate link for reviews
    if (i == 1) {
      lalibela_reviewHomePg <- "/Attraction_Review-g480193-d324957-Reviews-Rock_Hewn_Churches_of_Lalibela-Lalibela_Amhara_Region"
      TripAdvisor_lalibela_review <- paste(TripAdvisor_url, lalibela_reviewHomePg, ".html", 
                                           sep = "") 
    } 
    else {
      lalibela_reviewOtherPg <- paste("/Attraction_Review-g480193-d324957-Reviews-or", i-1, "0-Rock_Hewn_Churches_of_Lalibela-Lalibela_Amhara_Region",
                                      sep = "")
      TripAdvisor_lalibela_review <- paste(TripAdvisor_url, lalibela_reviewOtherPg, ".html",
                                           sep = "")
    }
    
    ## Read reviews about Lalibela from TripAdvisor website 
    TripAdvisor_topic <- xml2::read_html(TripAdvisor_lalibela_review)
    
    ## Get main container which contains touris reviews
    reviewer_container <- TripAdvisor_topic %>%
      html_nodes("div.review-container")
    
    ## Get all required columns using the EXTRACTOR function
    reviews_data <- lapply(X = reviewer_container, get_10Reviews) %>%
      dplyr::bind_rows()
    
    if (i == 1) {
      reviews_dataAll = data.frame(page_nbr = i, reviews_data)
    } else {
      reviews_dataAll <- rbind(reviews_dataAll, 
                               data.frame(page_nbr = i, reviews_data))
    }
  }
  
  message("Page extraction is completed: ", date())
  
  return(reviews_dataAll)
}