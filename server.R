


server = function(input, output, session){
  
  g_rate = reactive({
    tidy_time_series %>% 
      filter(state %in% c(input$state, input$multistate_growth)) %>% 
      filter(date >= '2020-03-15') %>% #& date <= '2020-04-23') %>% 
      group_by(state,date) %>% 
      summarise( totalperday = sum(cases)) %>% 
      mutate(new_cases = totalperday - lag(totalperday), growth_rate = (totalperday - lag(totalperday))/totalperday*100)
    
  })
  
  axis = reactive({
    
    ifelse(input$mapType == 'Confirmed', "{values:[0,7000,50000], colors:[\'white', \'pink\', \'red']}",
           ifelse(input$mapType == 'Mortality_Rate',"{values:[0,2.5,7], colors:[\'white', \'pink\', \'purple']}",
                  ifelse(input$mapType == 'Testing_Rate', "{values:[750,1250,2500], colors:[\'white', \'lightgreen\', \'green']}",
                         "{values:[0,10,30], colors:[\'white', \'lightblue\', \'blue']}")))
    
  })
  
  dataSource <- reactive({
    df_num %>%
      select(State, Confirmed, Mortality_Rate, Testing_Rate) 
  })
  
  output$USmap = renderGvis({
    
    geo_data = dataSource()
    axis_label=axis()
    
    gvisGeoChart(geo_data, 'State', 'Confirmed',
                 options = list(title = 'US Coronavirus',
                                region='US',
                                displayMode='regions',
                                resolution="provinces",
                                width='800',height='550',
                                colorAxis = axis_label,
                                
                                # colorAxis=ifelse(input$mapType == 'Confirmed', "{values:[0,5000,40000], colors:[\'white', \'pink\', \'red']}",
                                #                  ifelse(input$mapType == 'Mortality_Rate',"{values:[0,2.5,7], colors:[\'white', \'pink\', \'purple']}",
                                #                         ifelse(input$mapType == 'Testing_Rate', "{values:[750,1250,2500], colors:[\'white', \'lightgreen\', \'green']}",
                                #                                "{values:[0,10,30], colors:[\'white', \'lightblue\', \'blue']}"))),

                                backgroundColor="white"))
    
  })
  
  output$density = renderPlot({
    ggplot(filter(joined, region==input$state & date == input$Date), mapping = aes(x=long, 
                                                                                    y=lat,fill = cases, 
                                                                                    group = group), color='white') + 
      geom_polygon() + 
      scale_fill_gradient(low='white', high='red',trans = "log10") +
      ggtitle('Which Counties are Most Impacted?') + 
      geom_polygon(color = "black", fill = NA) +
      theme_void()+
      theme(text = element_text(family='.New York', size =15)) +
      coord_map()
    
  })
  
  output$grey = renderText({
    '*Grey = County Data Unavailable'
    
  })
  
  output$linear = renderPlot({
    
    tidy_time_series %>% 
      group_by(state,date) %>% 
      filter(state %in% c(input$state, input$multistate)) %>% 
      filter(date >= 2020-03-01 & date <= input$Date) %>% 
      summarise( totalperday = sum(cases)) %>% 
      ggplot(., aes(x=date, y=totalperday)) + geom_jitter(aes(color=state)) +
      geom_smooth(aes(color = state), se=F, size=.5) +
      theme_bw() + xlab('Date') + ylab('Number of Cases') + ggtitle('Exponential Growth?') +
      theme(text = element_text(family='.New York', size =15))
    
  })
  
  output$log = renderPlot({
    breaks = 10**(1:10)
    
    g_rate_df = g_rate()
    
    #log graph
    tidy_time_series %>% 
      group_by(state,date) %>% 
      filter(state %in% c(input$state, input$multistate_log)) %>% 
      filter(date >= 2020-03-01 & date <= input$Date) %>% 
      summarise( totalperday = sum(cases)) %>% 
      ggplot(., aes(x=date, y=totalperday)) + geom_jitter(aes(color=state)) +
      scale_y_log10(breaks=breaks, labels=breaks)+
      geom_smooth(aes(color = state), se=F, size=.5) +
      theme_bw() + xlab('Date') + ylab('Number of Cases') + ggtitle('Is your state flattening the curve?') +
      theme(text = element_text(family='.New York', size =15))
      
    
  })
  
  
  output$growth = renderPlot({
    tidy_time_series %>% 
      group_by(state,date) %>% 
      filter(state %in% c(input$state, input$multistate_growth)) %>% 
      filter(date >= 2020-03-15 & date <= input$Date) %>% 
      summarise( totalperday = sum(cases)) %>% 
      mutate(new_cases = totalperday - lag(totalperday), growth_rate = (totalperday - lag(totalperday))/totalperday*100,
             moving_avg = (new_cases + lag(new_cases) + lag(new_cases,2) + lag(new_cases,3)+lag(new_cases,4)+ lag(new_cases,5))/5)%>% 
      ggplot() + geom_bar(aes(x=date, y=new_cases, fill = state), alpha = .3, stat = 'identity', position = 'dodge') + 
      geom_smooth(aes(x=date, y=moving_avg, color=state), se=F, size=1) +
      theme_bw() + xlab('Date') + ylab('New Cases') + ggtitle('Daily Growth') +
      theme(text = element_text(family='.New York', size =15))
      

    
  })
  
  
  output$rawtable = renderPrint({
    print(time_series)
    print(df_num %>% 
            select(c(1:8)))

    
  })

}



