

navbarPage(theme = shinytheme('cyborg'),
           "Coronavirus Data Tracker",
           tabPanel("National Overview",
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
           tabPanel("State Level Analysis",
                    sidebarLayout(
                      sidebarPanel(),
                      
                      
                      mainPanel(
                        tabsetPanel(type='tab',
                                    tabPanel('Density Map'),
                                    tabPanel('Case Graph (linear)'),
                                    tabPanel('Case Graph (logarithmic)'),
                                    tabPanel('Growth Rate'))
                        
                      )
                    )
                    
           ),
           navbarMenu("More",
                      tabPanel("Data"
                      ),
                      tabPanel("About",
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