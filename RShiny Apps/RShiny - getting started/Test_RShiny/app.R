#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

## user interface
ui <- dashboardPage(
  dashboardHeader(title = "My Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
        fluidRow(
          box(
            title = "Histogram", status = "primary", solidHeader = T,
            collapsible = T,
            plotOutput("distPlot")
          ),
          box(
            title = "Inputs", status = "warning", solidHeader = T,
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
          )
        ),
        fluidRow(
          tabBox(
            title = "First tabBox",
            # The id lets us use input$tabset1 on the server to find the current tab
            id = "tabset1", height = "250px",
            tabPanel("Tab1", "First tab content"),
            tabPanel("Tab2", "Tab content 2")
          ),
          tabBox(
            side = "right", height = "250px",
            selected = "Tab3",
            tabPanel("Tab1", "Tab content 1"),
            tabPanel("Tab2", "Tab content 2"),
            tabPanel("Tab3", "Note that when side=right, the tab order is reversed.")
          )
        )
      ),
      
      tabItem(tabName = "widgets", 
        h2("Widgets tab content")   
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

