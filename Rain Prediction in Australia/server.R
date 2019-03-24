#library(caret)
#library(rpart)

# Define server logic
#
#
#install.packages("shinyalert")
library(shinyalert)
server<-function(input,output,session){
  set.seed(1234)
  observe({
    MinTemp<-as.numeric(input$mintemp)
    MaxTemp<-as.numeric(input$maxtemp)
    Rainfall<-as.numeric(input$rainfall)
    Evaporation<-as.numeric(input$evaporation)
    Sunshine<-as.numeric(input$sunshine)
    WindGustDir<-as.factor(input$windgustdir)
    WindGustSpeed<-as.numeric(input$windgustspeed)
    WindDir9am<-as.factor(input$winddir9am)
    WindDir3pm<-as.factor(input$winddir3pm)
    WindSpeed9am<-as.numeric(input$windspeed9am)
    WindSpeed3pm<-as.numeric(input$windspeed3pm)
    Humidity9am<-as.numeric(input$humidity9am)
    Humidity3pm<-as.numeric(input$humidity3pm)
    Pressure9am<-as.numeric(input$pressure9am)
    Pressure3pm<-as.numeric(input$pressure3pm)
    Cloud9am<-as.numeric(input$cloud9am)
    Cloud3pm<-as.numeric(input$cloud3pm)
    Temp9am<-as.numeric(input$temp9am)
    Temp3pm<-as.numeric(input$temp3pm)
    RainToday<-as.factor(input$raintoday)
    RISK_MM<-as.numeric(input$riskmm)
    
inputs<-data.frame(MinTemp,MaxTemp,Rainfall,Evaporation,Sunshine
                   ,WindGustDir,WindGustSpeed,WindDir9am,WindDir3pm,WindSpeed9am,
                   WindSpeed3pm,Humidity9am,
                   Humidity3pm,Pressure9am,Pressure3pm,Cloud9am,
                   Cloud3pm,Temp9am,Temp3pm,RainToday,RISK_MM)
model<-readRDS("model.rds")
# Model action Button

observeEvent(input$Run_Model,{
pred<-predict(model,newdata=inputs,type="class")
if(pred=="Yes"){
  shinyalert("Yes it will rain in Australia Tomorrow",type="success",confirmButtonCol ="#ff5405",closeOnClickOutside = TRUE)
    
}
else{
  shinyalert("No it will not rain in Australia Tomorrow",type="success",confirmButtonCol ="#ff5405",closeOnClickOutside = TRUE)
  
}

})

  
  })
}

