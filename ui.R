# Arjun Nag Puttaiah Nagaraja,
# MS in Information Management,
# CAS in Data Science,
# Syracuse University - Spring 2017
# Oct 9, 2016

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
                  
                  valueBox(
                    nrow(potholes.load[potholes.load$year == 2016,]), 
                    "Potholes Fixed This Year", 
                    icon = icon("road"),
                    color = "purple"
                  ),
                  
                  valueBox(
                    highest.potholes.st, 
                    "Highest Potholes Fixed", 
                    icon = icon("building-o"),
                    color = "purple"
                  ),
                  
                  valueBox(
                    highest.potholes.veh, 
                    "Durapatcher With Most Potholes Fixed", 
                    icon = icon("bus"),
                    color = "purple"
                  )
                ),
                
                h2("Street Information"),
                
                fluidRow(
                  
                  br(),
                  
                  valueBox(
                    low.road.sat.st, 
                    "Street With Least Overall Satisfaction", 
                    icon = icon("thumbs-o-down"),
                    color = "purple"
                  ),
                  
                  valueBox(
                    low.crack.sat.st, 
                    "Street With Least Crack Rating", 
                    icon = icon("chain-broken"),
                    color = "purple"
                  ),
                  
                  valueBox(
                    low.patch.sat.st, 
                    "Street With Least Patch Rating", 
                    icon = icon("repeat"),
                    color = "purple"
                  )
                )

        ),
        
        tabItem(tabName = "potholesGraph",
                
                # Display Pothole Graphs and Widgets
                
                fluidRow(
                  box(status = "warning",
                      
                      br(),
                      
                      selectInput(
                        "year",
                        "Select Year",
                        choices = all.years,
                        selected = all.years[1]
                    ),
                    
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
                      selectizeInput(
                        'street.abb2', 
                        'Search Street',
                        choices = allstreets,
                        multiple = TRUE,
                        selected = allstreets[2:6]
                      ),
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
                      
                      selectizeInput(
                        'street.abb', 
                        'Search Street',
                        choices = allstreets,
                        multiple = TRUE,
                        selected = "All"
                      ),
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
                      
                      selectInput(
                        "year2",
                        "Select Year",
                        choices = all.years2,
                        selected = all.years2[5]
                      ),
                      
                      br(),
                      
                      selectizeInput(
                        "oil",
                        "Flush Oil Type",
                        choices = all.oil,
                        multiple = T,
                        selected = "All"
                      ),
                      
                      br(),
                      
                      selectizeInput(
                        "class",
                        "Class Type",
                        choices = all.class,
                        multiple = T,
                        selected = "All"
                      ),
                      
                      br(),
                      
                      selectizeInput(
                        "pavement",
                        "Pavement Type",
                        multiple = T,
                        choices = all.pavement,
                        selected = "All"
                      ),
                      
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