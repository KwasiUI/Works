library(MASS)
data(Boston)
?Boston

head(Boston,5)
#we want to split the dataset into train and testing values

set.seed(2)
install.packages('caTools')
library(caTools)

#we divide the dataset with 0.7 ratio
split<-sample.split(Boston$medv,SplitRatio = 0.7)
split

training.ds<-subset(Boston,split=="TRUE")
testing.ds<-subset(Boston,split=="FALSE")

#Now we need to find the various correlation that exist
cr<-cor(Boston)

#we plot the correlation
install.packages('corrplot')
library(corrplot)
corrplot(cr,type="lower")

#
install.packages('car')
library(car)

model<-lm(medv~.,data = training.ds)
vif(model)

summary(model)

#bulding a model

#medv here is the dependent variable while the rest are independent variables
#this the value of medv depends entirely on the values of the rest.
model<-lm(medv~crim+zn+indus+chas+nox+rm+age+dis+rad+ptratio+black+lstat, data = training.ds)
summary(model)


model<-lm(medv~crim+zn+chas+nox+rm+dis+rad+ptratio+black+lstat, data = training.ds)
summary(model)


#now to predict
predic<-predict(model,testing.ds)
predic


#newxt we plot a graph to compair both values
plot(testing.ds$medv,type = "l",lty=1.8,col="green")
lines(predic,type = "l",col="blue")


crim<-c(0.2389)
zn<-c(13.7)
chas<-c(0)
nox<-c(0.479)
rm<-c(6.9989)
dis<-c(5.967)
ptratio<-c(16.9)
black<-c(209.6)
lstat<-c(6.1)
rad<-c(0)

sampledatab<-data.frame(crim,zn,chas,nox,rm,dis,rad,ptratio,black,lstat)
sampledatab

predic1<-predict(model,sampledatab)
predic1
