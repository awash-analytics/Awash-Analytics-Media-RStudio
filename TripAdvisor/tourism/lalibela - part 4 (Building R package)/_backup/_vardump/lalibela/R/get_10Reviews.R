#' 
#' Extracts all components of a review such as review title, date, location, device, etc.
#' 
#' @param node the single review given by a user
#' 
#' @references 
#' Inspired by Hadley Wickham (author of pkg::rvest) and BjaRule (StackOverflow).
#' https://github.com/hadley/rvest/issues/12
#' https://stackoverflow.com/questions/33250826/scraping-with-rvest-complete-with-nas-when-tag-is-not-present
#' 
#' @author Awash Analytics (December 2017)
#' 
#' @seealso The main program get_allReviews.R make use of this program to extract all the components of a given review.
#' 
#' 

get_10Reviews <- function(node) {

  ## Get current node/row
  node_current <- node
  
  ##########################
  ## Extract all columns  ##
  ##########################
  ## review title
  tmp_title <- node_current %>%
    rvest::html_node(".noQuotes") %>%
    rvest::html_text() 
  
  ## review title
  tmp_fullReview <- node_current %>%
    rvest::html_node(".partial_entry") %>%
    rvest::html_text() 
  
  ## review date
  tmp_date <- node_current %>%
    rvest::html_node(".relativeDate") %>%
    rvest::html_text() %>%
    stringr::str_replace(pattern = "(Reviewed)", replacement = "") %>%   ## removes the text "reviews"
    stringr::str_trim() 
  
  ## reviewer username
  tmp_userName <- node_current %>%
    rvest::html_node(".scrname") %>%
    rvest::html_text()
  
  ## reviewer location
  tmp_userLocation <- node_current %>%
    rvest::html_node(css = ".userLocation") %>%
    html_text()
  
  ## reviewer country of origin, probably a city
  tmp_device <- node_current %>%
    rvest::html_node(".viaMobile") %>%
    rvest::html_text()
  
  ##############################################################
  ## Create final dataframe.                                  ##
  ##############################################################
  ## ** A null value is filled whenever no value is returned  ##
  ##    from Web Scrapping step.                              ##
  ##############################################################
  data.frame(
    title = ifelse(length(tmp_title) == 0, NA,       ## the IFELSE function is used to fill NA whenever HTML_NODES is not able to return a value
                   tmp_title),
    full_review = ifelse(length(tmp_fullReview) == 0, NA,
                         tmp_fullReview),
    date = ifelse(length(tmp_date) == 0, NA,
                  tmp_date),
    user_name = ifelse(length(tmp_userName) == 0, NA,
                      tmp_userName),
    user_device = ifelse(length(tmp_device) == 0, NA,
                    tmp_device),
    user_location = ifelse(length(tmp_userLocation) == 0, NA,      
                                 tmp_userLocation),
    stringsAsFactors=F
  )
}