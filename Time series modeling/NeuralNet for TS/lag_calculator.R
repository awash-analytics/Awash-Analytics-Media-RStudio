# lag_calculator <- function(y = NULL, n_lags = 2, 
#                            scale = FALSE, scale_type = "norm") {
lag_calculator <- function(y = NULL, n_lags = 2) {
  
  ## Initialize lag variable
  dat <- numeric()
  
  for (i in 1:n_lags) {
    
    ## Derive lag variable
    dat <- as.data.frame(cbind(dat, 
                               quantmod::Lag(x = y, k=i))
    )
  }
  
  ## Add the original TS variable
  dat <- as.data.frame(cbind(y, dat))
  
  ## Update column names
  colnames(dat) <- c("y", 
                   paste("x", c(1:n_lags), sep = ""))
  
  ## Remove missing records (due to lag derivatation)
  dat <- dat %>%
    dplyr::filter(row_number() > n_lags)
  
  # ## Apply transformation, if required
  # if (scale) {
  #   if (scale_type == "range") {
  #     dat <- sapply(dat, 
  #                 function(x) {
  #                   (x - min(x)) / (max(x) - min(x))
  #                 }, 
  #                 simplify = TRUE)
  #   }
  #   else {
  #     dat <- dat %>%
  #       dplyr::mutate_all(funs(scale))
  #   }
  # }
  
  ## Change to Tibble data frame
  dat <- dplyr::as_data_frame(dat)
  
  return(dat)
}