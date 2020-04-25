

navbarPage(theme = shinytheme('journal'),
           "COVID-19 Data Tracker",
           tabPanel("National Overview", icon=icon('map'),
                    sidebarLayout(
                      sidebarPanel(
                        radioButtons("mapType", "Metric",
                                     c("Confirmed Cases"="Confirmed"), 
                                       # "Mortaility Rate"="Mortality_Rate",
                                       # 'Testing Rate (tested per 100k people)' = 'Testing_Rate') 
                                       # Hospitilization Rate'='Hospitalization_Rate')
                        )
                      ),
                      mainPanel(
                        htmlOutput('USmap'),
                        tags$p('*If US map does not show, please refresh page until it appears')
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
                                    value=as.Date(Sys.Date() -1),
                                    timeFormat="%Y-%m-%d"),
                        textOutput('grey')
                      ),
                      
                      
                      mainPanel(
                        tabsetPanel(type='tab',
                                    tabPanel('Growth',
                                             
                                             mainPanel(
                                               h4('Line graph shows the 5 day moving average'),
                                               
                                               selectInput('multistate_growth', 'Compare Multiple States', choices=unique(joined$state), multiple = T),
                                               
                                               plotOutput('growth', width = '800px',height='550px')
                                               
                                               )
                                             
                                             
                                    ),
                                    tabPanel('Density Map', plotOutput('density',width = '800px',height='550px')),
                                    tabPanel('Case Graph (linear)', 
                                             
                                             mainPanel(
                                               selectInput('multistate', 'Compare Multiple States', choices=unique(joined$state), multiple = T),
                                               plotOutput('linear', width = '800px',height='550px'))
                                             ),
                                    tabPanel('Case Graph (logarithmic)',
                                             
                                             mainPanel(
                                               selectInput('multistate_log', 'Compare Multiple States', choices=unique(joined$state), multiple = T),
                                               plotOutput('log', width = '800px',height='550px'))
                                             
                                             )
                                    
                                    
                                    )
                        
                      )
                    )
                    
           ),
           navbarMenu("More", icon = icon('info-circle'),
                      tabPanel("Data", icon = icon('database'),
                               
                               verbatimTextOutput("rawtable")
                      ),
                      tabPanel("About Me", icon = icon('linkedin'),
                               fluidRow(
                                 box(
                                   title = 'About Me',
                                   tags$p(
                                     class = 'text-center',
                                     tags$img(class = "img-responsive img-rounded center-block", src = "soham.png", style = "max-width: 150px;"),
                                     tags$a(href = "linkedin.com/in/soham-mishra-a2a909b9", "Linkedin"),
                                     tags$a(href = "https://github.com/sohammishra/Project1_ShinyApp", "Github")
                                     
                                     
                                   ),
                                   tags$li( icon=icon('map'),
                                           'My name is Soham Mishra and I am currently a Data Science Fellow at NYC Data Science Academy'
                                     
                                   ),
                                   tags$li( 'Prior to my data science journey, I worked at Citigroup Global Markets as an Institutional Equity Analyst. 
                                            I have experience performing fundamental analysis on macro and micro topics and businesses, as well as
                                            analyzing financial market data to derive and implement profitable investments'),
                                   
                                   tags$li('Obtained Bachelor of Business Administration with emphasis in finance 
                                           from the University of Michigan - Ross School of Business'),
                                   tags$li('Interested in utilizing analytics and visualization tools, 
                                           at the intersection of business and technology,
                                           in order to uncover new insights and drive positive outcomes for stakeholders')
                                   

                                 ),
                                 box(title = 'About the Project',
                                        
                                     tags$p('For the last few months I have been trying my best to keep 
                                            track of how our country is handling the coronavirus situation. 
                                            During this time, I noticed many of the news networks focussing 
                                            on the number of national cases. As the numbers continue to rise,
                                            they start to lose meaning, particularly for individuals in states 
                                            that have a lower case count. I created this Shiny App to focus on 
                                            tracking the virus at the state and county level, in an effort to
                                            make the numbers more meaningful through multiple visualizations. '),
                                     tags$p(
                                          "This dashboard was built in",
                                          tags$a(href = "https://r-project.org", target = "_blank", "R"),
                                          "and", tags$a(href = "https://rstudio.com", target = "_blank", "RStudio"), "with",
                                          tags$strong("shiny,"),
                                          tags$strong("shinydashboard,"),
                                          tags$strong("ggplot2,"),
                                          tags$strong("and tidyverse.")
                                          
                                        ),
                                     tags$p('Data Source:', tags$a(tags$a(href = "https://github.com/CSSEGISandData/COVID-19", 
                                                                          "John Hopkins University")))
                                        
                                 )
                               )
                      )
           )
)




# )