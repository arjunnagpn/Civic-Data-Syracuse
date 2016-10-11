# Arjun Nag Puttaiah Nagaraja,
# MS in Information Management,
# CAS in Data Science,
# Syracuse University - Spring 2017
# Oct 9, 2016

# Load required packages to library

library(RColorBrewer)
library(ggmap) 
library(htmltools)
library(rgdal)
library(shiny)
library(shinydashboard)
library(DT)
library(leaflet)
library(readr)
library(dplyr)
library(magrittr)

shinyUI(
  
  dashboardPage(
    
    skin = "yellow",
    title = "Syracuse Civic Data Hackathon",
    
    dashboardHeader(
      title = "Syracuse Civic Data"
      ),
    
    dashboardSidebar(
      
      sidebarMenu(
        
        # Display Sidebar Labels
        
        menuItem("Summary", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Potholes Graph", tabName = "potholesGraph", icon = icon("bar-chart")),
        menuItem("Potholes Map", tabName = "potholesMap", icon = icon("car")),
        menuItem("Street Map", tabName = "streetMap", icon = icon("road"))
      )
    ),
    
    dashboardBody(
      
      tabItems(
        
        # Display Dashboard
        
        tabItem(tabName = "dashboard",
                
                h2("Syracuse Civic Data Dashboard"),
                
                br(),
                
                h2("Pothole Information"),
                
                fluidRow(
                  
                  br(),
                  
                  valueBoxOutput("progressBox1a"),
                  
                  valueBoxOutput("progressBox1b"),
                  
                  valueBoxOutput("progressBox1c")
                ),
                
                h2("Street Information"),
                
                fluidRow(
                  
                  br(),
                  
                  valueBoxOutput("progressBox2a"),
                  
                  valueBoxOutput("progressBox2b"),
                  
                  valueBoxOutput("progressBox2c")
                )

        ),
        
        tabItem(tabName = "potholesGraph",
                
                # Display Pothole Graphs and Widgets
                
                fluidRow(
                  box(status = "warning",
                      
                      br(),
                      uiOutput("o.year"),
                    
                    br(),
                    
                    selectInput(
                      "month",
                      "Select Month",
                      choices = c(
                        "January" = 1, 
                        "February" = 2, 
                        "March" = 3, 
                        "April" = 4, 
                        "May" = 5, 
                        "June" = 6, 
                        "July" = 7, 
                        "August" = 8, 
                        "September" = 9, 
                        "October" = 10, 
                        "November" = 11, 
                        "December" = 12
                      ),
                      selected = 5
                    ),
                    
                    width = 4
                  ),
                  box(status = "warning",
                      uiOutput("ranking"),
                    plotOutput("o.bar1"),
                    width = 8
                  )
                  
                ),
                
                fluidRow(
                  column(4,
                         br()
                         ),
                  
                  box(status = "warning",
                      uiOutput("o.street.abb2"),
                      plotOutput("o.bar2"),
                      width = 8
                  )
                )
                
        ),
        
        # Display Pothole Maps and Widgets
        
        tabItem(tabName = "potholesMap",
                
                fluidRow(
                  box(status = "warning",
                      
                      br(),
                      
                      radioButtons(
                        "scatter.type",
                        "Display Type",
                        choices = c(
                          "Clustered" = 1,
                          "Scattered" = 2
                        ),
                        selected = 1
                      ),
                      br(),
                      
                      uiOutput("o.street.abb"),
                      br(),
                      
                      selectInput(
                        "bus.type", 
                        "Durapatcher Truck",
                        choices = c(
                          "Both",
                          "DP1",
                          "DP2"
                        ),
                        selected = "Both"
                      ),
                      br(),
                      
                      dateRangeInput(
                        'fix.date',
                        label = 'Fix Date',
                        start = Sys.Date() - 180, 
                        end = Sys.Date()
                      ),
                      width = 3
                      
                  ),
                  tabBox(
                    title = "Syracuse Pothole Information",
                    id = "tabset", 
                    height = "250px",
                    
                    tabPanel(
                      "Interactive Map", 
                      leafletOutput("map")
                    ),
                    
                    tabPanel(
                      "Data Explorer", 
                      DT::dataTableOutput("table.df")
                    ),
                    width = 9
                  )
                )
        ),
        
        # Display Street Maps and Widgets
        
        tabItem(tabName = "streetMap",
                fluidRow(
                  box(status = "warning",
                      
                      selectInput(
                        "road.attribute", 
                        "Road Attribute",
                        choices = c(
                          "Overall" = "overall", 
                          "Crack" = "crack", 
                          "Patch" = "patch"
                        ),
                        selected = "overall"
                      ),
                      
                      br(),
                      
                      uiOutput("o.year2"),
                      
                      br(),
                      
                      uiOutput("o.oil"),
                      
                      br(),
                      
                      uiOutput("o.class"),
                      
                      br(),
                      
                      uiOutput("o.pavement"),
                      
                      width = 3
                      
                  ),
                  
                  tabBox(
                    title = "Syracuse Street Information",
                    id = "tabset2", 
                    height = "250px",
                    
                    tabPanel(
                      "Interactive Map", 
                      leafletOutput("map2")
                    ),
                    
                    tabPanel(
                      "Data Explorer",
                      DT::dataTableOutput("table.df2")
                    ),
                    width = 9
                  )
                )
        )
        
      )
    )
  )
)
