
LungCapData

#we want to split the dataset into train and testing values

set.seed(2)
library(caTools)
split<-sample.split(LungCapData$LungCap,SplitRatio = 0.7)
split

training.ds<-subset(LungCapData,split=="TRUE")
testing.ds<-subset(LungCapData,split=="FALSE")

training.ds
testing.ds

#Now we need to find the various correlation that exist
cr1<-cor(LungCapData$Age,LungCapData$LungCap)
cr2<-cor(LungCapData$Height,LungCapData$LungCap)
cr1
qcr2
#we plot the correlation
#library(corrplot)
#corrplot(cr,type="lower")

#
library(car)

#training the model
model<-lm(LungCap~Age,data = training.ds)
vif(model)

predic<-predict(model,testing.ds)
predic
summary(model)


plot(training.ds$Age,training.ds$LungCap,main = "Lung Capacity Against Age",
     xlab = "Age", ylab = "Lung Capacity")
abline(model,col = "blue")



 






plot(testing.ds$LungCap,type = "l",lty=1.8,col="green")
lines(predic,type = "l",col="blue")


Age<-c(60)
sampled<-data.frame(Age)
predic1<-predict(model,sampled)
predic1









