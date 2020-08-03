
#mutiple linear regression
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

#age and heigh as independent variables
model1<-lm(LungCap~Age+Height,data = LungCapData)
summary(model1)


#creating and using a dummy or indicator variable
LungCapData$Smoke<-as.factor(LungCapData$Smoke) 
levels(lung$Smoke)

class(LungCapData$Height)
LungCapData$Height[1:10]

#heigth category
CatHeight<-cut(LungCapData$Height, breaks = c(0,50,55,60,65,70,100),labels=c("A","B","C","D","E","F"),right = FALSE)
CatHeight[1:10]
CatHeight=="A"


#we want to calculate the mean for each category of height
#mean(LungCapData[CatHeight=="A"])

#re order of smoke 
table(LungCapData$Smoke)
LungCapData$Smoke<-relevel(LungCapData$Smoke,ref = "yes")
table(LungCapData$Smoke)


model2<-lm(LungCap~CatHeight,data = LungCapData)
summary(model2)


#we want to model based on smokers and non smokers
#and train our data
mod1<-lm(LungCapData$LungCap~LungCapData$Age+LungCapData$Smoke,data = LungCapData)
summary(mod1)

#prediction based on mod with traing data
predic<-predict(mod1,testing.ds)
predic

#scatter plot with regression line
plot(training.ds$Age,training.ds$LungCap,main = "Lung Capacity Against Age",
     xlab = "Age", ylab = "Lung Capacity")
abline(mod1,col = "blue")

#we want to compaire to ensure prediction module is efficient
plot(testing.ds$LungCap,type = "l",lty=1.8,col="green")
lines(predic,type = "l",col="blue")



#including variables/ factors in regression
plot(LungCapData$Age[LungCapData$Smoke=="no"], LungCapData$LungCap[LungCapData$Smoke=="no"], col="blue", ylim=c(0,15), 
     xlim=c(0,20), xlab="Age", ylab="LungCap", 
     main="LungCap vs. Age,Smoke")



#Now, add in the points for the Smokers, in Solid Red Circles
points(LungCapData$Age[LungCapData$Smoke=="yes"], LungCapData$LungCap[LungCapData$Smoke=="yes"], col="red", pch=16)
# And, add in a legend
legend(1,15,legend=c("NonSmoker", "Smoker"), col=c("blue", "red"), 
       pch=c(1,16), bty="n")

model1 <- lm(LungCapData$LungCap ~ LungCapData$Age+LungCapData$Smoke+LungCapData$Age:LungCapData$Smoke)
summary(model1)

abline(a=1.052, b=0.558, col="blue", lwd=3)
# And now, add in the line for Smokers, in Red
abline(a=0.43714, b=0.55, col="red", lwd=3)

#from this plot we can clearly say that age has an effect on lung capacity and 
#also weather or not you smoke also has an effect on your lung capacity



