


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
                                backgroundColor="black"))
    
  })
  
  
  
}


#colorAxis=ifelse(input$plotType == 'Confirmed', "{values:[0,5000,40000], colors:[\'white', \'pink\', \'red']}")
