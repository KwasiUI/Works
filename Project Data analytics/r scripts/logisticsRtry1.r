#demo for diabetic prediction

#import data
data<- read.csv(file = "C:\\Users\\KWASI\\Documents\\books\\MastersCUTN\\3rd Sem\\Project Data analytics\\datasets\\pima.csv",stringsAsFactors = FALSE)

#split data into training and testing
library(caTools)
split<-sample.split(data,SplitRatio = 0.8)
training<-subset(data,split=TRUE)
testing<-subset(data,split=FALSE)

#creating the model
model<-glm(type~.,training, family = "binomial")
summary(model)

#optimizing our model 
model<-glm(type~.-skin,training, family = "binomial")
summary(model)

#after removing a parameter if AIC decrease and Residual does not increase
# or increase is not significant that parameter can be reduced to optimize 
#the model

#Now we create prediction model
res<-predict(model,testing, type = "response")
res

#confusion Matrix is used to test the accuracy of the model
#in terms of what was in the actual dataset and what the model predicted
table(ActualVale=testing$type,PredictionValue=res>0.3)
#To find accuracy is correct instances /total instance
accuracy<-(439+155)/(439+61+113+155)
accuracy

#we want to confirm the speculated threshold
res<-predict(model,training, type = "response")
library(ROCR)

#we define prediction and performance
ROCRpred<-prediction(res,training$type)
ROCRref<-performance(ROCRpred,"tpr","fpr")#tpr=True positive rate fpr=False positive r

#plot the graph of performance
plot(ROCRref,colorize=TRUE,print.cutoffs.at=seq(0.1, by=0.1))
#For better accuracy we go with threshold with higher True positive rate
#and less False postive rate
# this will sometimes decrease the accuracy of your model but its efficient if 
#the actual value against predicted value FALSE is reduced.


#now lets enter some sample data and see the results if patient is diabetic or not
sampledata<-data.frame(npreg=2,glu=142,bp=82,skin=18,bmi=24.6,ped=0.761,age=21)
typeprediction<-predict(model,sampledata)
typeprediction
