library(shinydashboard)
library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)
library(tidyr)
library(data.table)
library(extrafont)
library(googleVis)
library(maps)

#data for US map on first page
data = read.csv('04-18-2020.csv', TRUE)
df = data.frame(data)
setnames(df, old = 'Province_State', new = 'State')

df_num = select(df, c(1,6,7,11,12,13,14,17,18))
df_num


#data for state level density maps

counties = map_data('county')
time_series = data <-read.csv("4_15_covid_confirmed_US.csv", TRUE)

tidy_time_series = time_series %>% 
  select( -c(1:5), -c(11:50)) %>% 
  setnames( old = c('Admin2', 'Province_State'), new = c('subregion', 'state')) %>%
  mutate(subregion = tolower(subregion))  %>% 
  mutate(state = tolower(state)) %>%
  gather(key='date', value= 'cases', starts_with('X'), na.rm=T)

tidy_time_series$date=sub('X', '', tidy_time_series$date)
tidy_time_series$date=as.Date(tidy_time_series$date, '%m.%d.%y')

joined=inner_join(tidy_time_series,counties, by= 'subregion' )




  
  
