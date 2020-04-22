library(shinydashboard)
library(shiny)
library(shinythemes)

data = read.csv('04-18-2020.csv', TRUE)
df = data.frame(data)
setnames(df, old = 'Province_State', new = 'State')

df_num = select(df, c(1,6,7,11,12,13,14,17,18))
df_num
