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
yesterday = format(Sys.Date() -1, '%m-%d-20%y')
url = paste0('https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports_us/', yesterday, '.csv')
data = fread(url)
df = data.frame(data)
setnames(df, old = 'Province_State', new = 'State')

df_num = select(df, c(1,6,7,11,12,13,14,17,18))
df_num$hover <- with(df_num, paste(State, '<br>', "Confirmed:", Confirmed, '<br>', 'Deaths:', Deaths))
df_num$State_abb = state.abb[match(df_num$State,state.name)]
df_num

# give state boundaries a white border
l <- list(color = 'white', width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = 'white'
)

#fig <- plot_geo(df_num, locationmode = 'USA-states')



#data for state level density maps and time series charts

counties = map_data('county')
time_series = fread('https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv')

tidy_time_series = time_series %>% 
  select( -c(1:5), -c(11:50)) %>% 
  setnames( old = c('Admin2', 'Province_State'), new = c('subregion', 'state')) %>%
  mutate(subregion = tolower(subregion))  %>% 
  mutate(state = tolower(state)) %>%
  gather(key='date', value= 'cases', contains('/'), na.rm=T)

tidy_time_series$date=as.Date(tidy_time_series$date, '%m/%d/%y')

joined=inner_join(tidy_time_series,counties, by= 'subregion' )

tidy_time_series

  
  
