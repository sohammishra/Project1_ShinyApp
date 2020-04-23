


server = function(input, output, session){
  
  output$USmap = renderGvis({
    gvisGeoChart(df_num, 'State', input$mapType, 
                 options = list(title = 'US Coronavirus',
                                region='US', 
                                displayMode='regions', 
                                resolution="provinces",
                                width='auto',height='auto',
                                colorAxis=ifelse(input$mapType == 'Confirmed', "{values:[0,5000,40000], colors:[\'white', \'pink\', \'red']}", 
                                                 ifelse(input$mapType == 'Mortality_Rate',"{values:[0,2.5,7], colors:[\'white', \'pink\', \'purple']}",
                                                        ifelse(input$mapType == 'Testing_Rate', "{values:[750,1250,2500], colors:[\'white', \'lightgreen\', \'green']}", 
                                                               "{values:[0,10,30], colors:[\'white', \'lightblue\', \'blue']}"))),
                                #colorAxis="{values:[0,5000,40000],
                                   #colors:[\'white', \'pink\', \'red']}",
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
      #annotate('text', x=5,y=25,label = 'grey = Data Unavailable') +
      theme_void()+
      #xlab('Grey = Data Unavailable')+
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
  
}


#colorAxis=ifelse(input$plotType == 'Confirmed', "{values:[0,5000,40000], colors:[\'white', \'pink\', \'red']}")
