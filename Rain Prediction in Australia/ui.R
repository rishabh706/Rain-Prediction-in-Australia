#install.packages("shiny")
library(shiny)
library(shinythemes)
library(shinyalert)
# Importing the dataset
dataset=read.csv("weatherAus.csv")

# Define UI
ui<-fluidPage(theme=shinytheme("superhero"),
mainPanel(
fluidRow(
column(9,h2("Rain Prediction in Australia")),
column(4,numericInput(inputId='mintemp',h4("Min Temp in Degree Celsius"),value=1,step=0.1)),  
column(4,numericInput(inputId='maxtemp',h4("Max Temp in Degree Celsius"),value=1,step=0.1)),
column(4,numericInput(inputId='rainfall',h4("RainFall in cms"),value=1,step=0.1)),
column(4,numericInput(inputId='evaporation',h4("Evaporation per unit Area"),value=1,step=0.1)),
column(4,numericInput(inputId='sunshine',h4("Sunshine in Kwh"),value=1,step=0.1)),
column(4,selectInput(inputId='windgustdir',h4("WindGustDir"),choices = levels(dataset$WindGustDir))),
column(4,numericInput(inputId='windgustspeed',h4("WindGustSpeed"),value=1,step=0.1)),
column(4,selectInput(inputId='winddir9am',h4("WindDir9am"),choices = levels(dataset$WindDir9am))),
column(4,selectInput(inputId='winddir3pm',h4("WindDir3pm"),choices = levels(dataset$WindDir3pm))),
column(4,numericInput(inputId='windspeed9am',h4("WindSpeed9am"),value=1,step=0.1)),
column(4,numericInput(inputId='windspeed3pm',h4("WindSpeed3pm"),value=1,step=0.1)),
column(4,numericInput(inputId='humidity9am',h4("Humidity9am"),value=1,step=0.1)),
column(4,numericInput(inputId='humidity3pm',h4("Humidity3pm"),value=1,step=0.1)),
column(4,numericInput(inputId='pressure9am',h4("Pressure9am"),value=1,step=0.1)),
column(4,numericInput(inputId='pressure3pm',h4("Pressure3pm"),value=1,step=0.1)),
column(4,numericInput(inputId='cloud9am',h4("Cloud9am"),value=1,step=0.1)),
column(4,numericInput(inputId='cloud3pm',h4("Cloud3pm"),value=1,step=0.1)),
column(4,numericInput(inputId='temp9am',h4("Temp9am"),value=1,step=0.1)),
column(4,numericInput(inputId='temp3pm',h4("Temp3pm"),value=1,step=0.1)),
column(4,selectInput(inputId='raintoday',h4("RainToday"),choices =levels(dataset$RainToday))),
column(4,numericInput(inputId='riskmm',h4("Risk_MM"),value=1,step=0.1)),
tags$head(
  tags$style(HTML('#Run_Model{background-color:#ff5405}'))
),
div(style="margin-left:40%;width:20%;margin-bottom:20px",actionButton("Run_Model","Predict")),

useShinyalert()



),
verbatimTextOutput("Text")
)

    
)
 
  