

navbarPage(theme = shinytheme('journal'),
           "COVID-19 Data Tracker",
           tabPanel("National Overview", icon=icon('map'),
                    #title=div(img(src="covid.jpg"), height='50',width='50'),
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("mapType", "Select Metric",
                                     c("Confirmed Cases"="Confirmed", 
                                       "Mortaility Rate"="Mortality_Rate",
                                       'Testing Rate (tested per 100k people)' = 'Testing_Rate', 
                                       'Hospitilization Rate'='Hospitalization_Rate')
                        )
                      ),
                      mainPanel(
                        htmlOutput('USmap')
                      )
                    )
           ),
           tabPanel("State Level Analysis", icon=icon('map-pin'),
                    sidebarLayout(position='right',
                      sidebarPanel(
                        selectizeInput('state', 'Select State', choices=unique(joined$state)),
                        
                        
                        sliderInput("Date",
                                    "Select Date:",
                                    min = as.Date("2020-03-01","%Y-%m-%d"),
                                    max=Sys.Date() -1,
                                    #max = as.Date("2020-04-14","%Y-%m-%d"),
                                    value=as.Date("2020-04-14"),
                                    timeFormat="%Y-%m-%d"),
                        textOutput('grey')
                      ),
                      
                      
                      mainPanel(
                        tabsetPanel(type='tab',
                                    tabPanel('Density Map', plotOutput('density')),
                                    tabPanel('Case Graph (linear)', 
                                             
                                             mainPanel(
                                               selectInput('multistate', 'Compare Multiple States', choices=unique(joined$state), multiple = T),
                                               # selectizeInput('state2', 'Compare up to 5 States', choices=unique(joined$state)),
                                               # selectizeInput('state3', '', choices=unique(joined$state)),
                                               # selectizeInput('state4', '', choices=unique(joined$state)),
                                               # selectizeInput('state5', '', choices=unique(joined$state)),
                                               plotOutput('linear', width = '600px',height='350px'))
                                             ),
                                    tabPanel('Case Graph (logarithmic)',
                                             
                                             mainPanel(
                                               selectInput('multistate_log', 'Compare Multiple States', choices=unique(joined$state), multiple = T),
                                               plotOutput('log', width = '600px',height='350px'))
                                             
                                             ),
                                    tabPanel('Growth Rate'))
                        
                      )
                    )
                    
           ),
           navbarMenu("More", icon = icon('info-circle'),
                      tabPanel("Data", icon = icon('database'),
                      ),
                      tabPanel("About Me", icon = icon('linkedin'),
                               fluidRow(
                                 column(6,
                                        'test'
                                 ),
                                 column(3,
                                        'test',
                                        
                                 )
                               )
                      )
           )
)






# fluidPage(theme = 'bootstrap.css',
#           #tags$head(tags$style(HTML('* {font-family: .New York;}'))),
#           titlePanel('Coronavirus Data Tracker'),
#           
#          
#           
#           sidebarLayout(position='right',
#             sidebarPanel(
#               
#             ),
#             mainPanel(
#               
#             )
#           )
# )