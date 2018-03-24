
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)
library(shinyjs)
library(DT)

## load lalibela package
library(lalibela)

shinyServer(function(input, output) {
  
  ## Reactive event handler to start fetching the data
  df <- eventReactive(input$fetchTripAdv, {
    
    ## Fetch data from TripAdvisor website
    reviews_lalibela <- lalibela::get_allReviews(nbr_page = input$numOfPages,
                                                 site_gCode = "480193",
                                                 site_dCode = "324957",
                                                 site_name = "Rock_Hewn_Churches_of_Lalibela",
                                                 site_geoLocation = "Lalibela_Amhara_Region")
    
    ## Preprocess data for display
    reviews_lalibela_flt <- reviews_lalibela %>% 
      dplyr::select(-c(attraction_location, total_reviews, date_dataAccess, page_nbr,
                       full_review))
  })
  
  ## Return fetched data
  output$data = DT::renderDataTable({
    df()
  })
  
  ## Download data
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(con) {
      write.csv(df(), con)
    }
  )
  
  # output$download <- renderUI({
  #   if(!is.null(input$file1) & !is.null(input$file2)) {
  #     downloadButton('OutputFile', 'Download Output File')
  #   }
  # })

})
