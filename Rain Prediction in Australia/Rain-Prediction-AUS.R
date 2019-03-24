
# Importing the dataset
dataset=read.csv("weatherAUS.csv",na.strings=c("?","NA"))

# Checking whether the dataset is balanced or not
#install.packages("plm")
library("plm")
print(is.pbalanced(dataset))

# Checking the datatype of the each column
sapply(dataset,typeof)

# Taking the necessary  columns from the dataset
dataset=dataset[c('MinTemp','MaxTemp','Rainfall'
                  ,'Evaporation','Sunshine',
                  'WindGustDir','WindGustSpeed',
                  'WindDir9am','WindDir3pm','WindSpeed9am',
                  'WindSpeed3pm','Humidity9am','Humidity3pm',
                  'Pressure9am','Pressure3pm','Cloud9am','Cloud3pm',
                  'Temp9am','Temp3pm','RainToday','RISK_MM','RainTomorrow')]

# Checking the percentage of missing values in columns
apply(dataset,2,function(dataset)sum(is.na(dataset))/length(dataset)*100)
float_cols=c('MinTemp','MaxTemp','Rainfall',
             'Evaporation',
             'Sunshine',
            'WindGustSpeed','WindSpeed9am',
            'WindSpeed3pm','Humidity9am','Humidity3pm'
            ,'Pressure3pm','Pressure9am','Cloud9am','Cloud3pm','Temp9am','Temp3pm')

# Replacing the float columns with the mean
dataset[float_cols]=colMeans(dataset[float_cols],na.rm=TRUE)

# Replacing the  categorical columns Na with its most frequent values
table(dataset$RainToday)
#length(dataset$WindGustDir)
categorical_columns=c('WindGustDir','WindDir9am',
                      'WindDir3pm')

i1<-!sapply(dataset,is.numeric)

Mode<-function(x){
  ux<-sort(unique(x))
  ux[which.max(tabulate(match(x,ux)))]
}
dataset[i1]<-lapply(dataset[i1],function(x)replace(x,is.na(x),Mode(x[!is.na(x)])))

######################################

# Splitting the dataset into the training set , test set and validation test
library(caTools)
set.seed(123)
split=sample.split(dataset$RainTomorrow,SplitRatio =0.75)
training_set=subset(dataset,split==TRUE)
test_set=subset(dataset,split==FALSE)


# Fitting the Logistic Regression to the training set
#classifier=glm(formula=RainTomorrow ~.,family=binomial,data=training_set,control=glm.control(maxit=100))

 #Fitting the decision Tree classification to the training set
library(rpart)
classifier=rpart(formula=RainTomorrow ~.,data=training_set)
#Predicting the test set results
y_pred=predict(classifier,type='class',newdata = test_set[,-which(names(test_set)=='RainTomorrow')])

#y_pred=as.factor(y_pred)

# Making the confusion matrix
#sapply(test_set$RainTomorrow,class)

#cm=table(test_set$RainTomorrow,y_pred)
cm=table(test_set$RainTomorrow,y_pred)
library(caret)
confusionMatrix(test_set$RainTomorrow,y_pred)

# Applying K-Fold Cross Validation

library(caret)
folds=createFolds(training_set$RainTomorrow,k=10)
cv=lapply(folds,function(x){
  training_fold=training_set[-x,]
  test_fold=test_set[x,]
  library(rpart)
  classifier=rpart(formula=RainTomorrow ~.,data=training_fold)
y_pred=predict(classifier,type='prob',newdata = test_fold[,-which(names(test_set)=='RainTomorrow')])
cm=table(test_fold$RainTomorrow,y_pred)
accuracy=((cm[1,1]+cm[2,2])/(cm[1,1]+cm[2,2]+cm[1,2]+cm[2,1]))
return(accuracy)
})
accuracy=mean(as.numeric(cv))

# Saving the model for future Predictions
#saveRDS(classifier,file="model.rds")

#load("model.rda")





























