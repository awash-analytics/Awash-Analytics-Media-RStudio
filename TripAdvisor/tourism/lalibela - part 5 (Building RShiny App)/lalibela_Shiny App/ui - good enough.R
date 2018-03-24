
# This is the user-interface definition of a Shiny web application.
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

shinyUI(dashboardPage(
  dashboardHeader(title = "My Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Help", tabName = "downloads", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              # tabBox(title = "", id = "home", 
              #        tabPanel("Home", 
              #                  fluidRow(
              #                     box(
              #                       numericInput(inputId = 'numOfPages', label = "Number of Pages:",
              #                                    value = 2, min = 1, max = 5, step = 1, width = "200px"),
              #                       br(),
              #                       actionButton(inputId = 'fetchTripAdv', label = 'Go & Fetch Data',
              #                                    icon('paper-plane'))
              #                     )
              #                   ),
              #                   fluidRow(
              #                     box(
              #                       DT::dataTableOutput("data", width = "800px")
              #                     )
              #                   )
              #        ),
              #        tabPanel("Readme", "Second tab content")
              #   )
              
              
              fluidRow(
                box(
                  numericInput(inputId = 'numOfPages', label = "Number of Pages:",
                               value = 2, min = 1, max = 5, step = 1),
                  br(),
                  actionButton(inputId = 'fetchTripAdv', label = 'Go & Fetch Data',
                               icon('paper-plane')),
                  br(),
                  br(),
                  downloadLink('downloadData', 'Download')
                  # uiOutput("download")
                )
              ),
              fluidRow(
                box(
                  DT::dataTableOutput("data", width = "800px")
                )
              )
      ),
      tabItem(tabName = "downloads",
              h2("Download Lalibela package...") 
      )
    )
  )
))
