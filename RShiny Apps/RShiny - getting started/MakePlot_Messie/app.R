#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

## additional packages
library(shinydashboard)
library(ggplot2)


## load my plot function
makePlot <- function(x, y) {
  plot(x, y)
}


## This is the user interface (ui)
ui <- dashboardPage(
  dashboardHeader(title = "My Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Help", tabName = "help", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
        fluidRow(
          box(
            selectInput("variable1", "Variable:",
                        c("Sepal Length" = "Sepal.Length",
                          "Sepal Width" = "Sepal.Width",
                          "Petal Length" = "Petal.Length",
                          "Petal Width" = "Petal.Width")
            ),
            
            selectInput("variable2", "Variable:",
                        c("Sepal Length" = "Sepal.Length",
                          "Sepal Width" = "Sepal.Width",
                          "Petal Length" = "Petal.Length",
                          "Petal Width" = "Petal.Width")
            )
          ),
          box(
            # tableOutput("data"),
            plotOutput("makeHist")
          )
        )
      ),
      tabItem(tabName = "help",
          h2("call Help desk!") 
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  ## Display Iris dataset
  output$data <- renderTable({
    iris[, input$variable, drop = FALSE]
  }, rownames = TRUE)
  
  ## Plot histogram
  output$makeHist <- renderPlot({
    
    x <- iris[, input$variable1] 
    y <- iris[, input$variable2] 
    
    # ggplot(data = iris, aes(x = x, y = y, colour = Species)) + geom_point()
    
    ## call my own function
    makePlot(x = x, y = y)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

