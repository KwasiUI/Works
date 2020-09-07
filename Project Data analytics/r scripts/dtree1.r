  #Analysis on survival of an individual in a ship reck

#load our libraries
library("dplyr")
library("rpart")
library("caTools")
library("rpart.plot")
install.packages("caret",dependencies=TRUE)
library("caret")
#load our dataset
filepa<-"C:\\Users\\KWASI\\Documents\\books\\MastersCUTN\\3rd Sem\\Project Data analytics\\datasets\\titanic.csv"
df<-read.csv(file =filepa )

#view dataset
View(head(df,5))

#select needed parts for analysis
subdf<-select(df,Survived,Pclass,Sex,Age)
str(subdf)
subdf<-mutate(subdf, Survived=factor(Survived),Pclass=as.numeric(Pclass),Age=as.numeric(Age))




#exploratory data analysis on data 
#number of males on the ship
gendercount<-table(df$Sex)
gendercount
barplot(gendercount, main = "Sex Present on Ship"
        ,xlab = "Gender",ylab = "Count",col = c("orange","brown"))



#number of people who survived
suvive<-table(df$Survived)
suvive
barplot(suvive, main = "Number of Survivors Against Non Survivors",
        names.arg = c("Died","Survived"),
        ylab = "Count",col=c("red","green"))


#next we want to know the number of males to female who survived in various clases
gendersurvc<-table(df$Survived,df$Sex)
gendersurvc
barplot(gendersurvc,main = "Male to Female Survival",beside = T,col=c("red","green"))
legend("topleft", 
      legend = c("Died", "Survived"), 
      col = c("red", 
              "green"), 
      pch = c(15,15), #shape
      bty = "n", 
      pt.cex = 2,#size 
      cex = 1.2, #size
      horiz = F , 
      )



#next we want to male to female ratio in class
genderclass<-table(df$Sex,df$Pclass)
genderclass
barplot(genderclass,main = "Gender Count Per Ship Class",
        beside = T,col = c("orange","brown"),names.arg = c("1st Class","2nd Class","3rd class")
        )
legend("top", 
       legend = c("Female", "Male"), 
       col = c("orange", 
               "brown"), 
       pch = c(15,15), #shape
       bty = "n", 
       pt.cex = 2,#size 
       cex = 1.2, #size
       horiz = F  
)
#gender survival count in classes 
genderclasssur<-table(df$Sex,df$Pclass,df$Survived)
genderclasssur

#age classification
#age distribution'
summary(df$Age)
agesplit<-cut(df$Age,breaks = c(0,12,24,48,90),right = FALSE)
agedis<-table(agesplit)
agedis
barplot(agedis,main = "Age Distribution",names.arg = c("Children","Young Adult","Adult","Old Peeps")
        ,ylab="count",col =rainbow(4) )


#survival count vs age
agesurv<-table(df$Survived,agesplit)
agesurv
barplot(agesurv,beside = T,names.arg =c("Children","Young Adult","Adult","Old Peeps" )
        ,col = c("red","green"))
legend("topright",
  legend = c("Died", "Survived"), 
  col = c("red", 
          "green"), 
  pch = c(15,15), #shape
  bty = "n", 
  pt.cex = 2,#size 
  cex = 1.2, #size
  horiz = F  
)

#analytics
set.seed(555)
#we need to split data for analysis
dfsplit<-sample.split(subdf$Survived,SplitRatio = 0.7)
trainingds<-subset(subdf,dfsplit==TRUE)
testingds<-subset(subdf,dfsplit==FALSE)

#training our tree model
treeM<-rpart(Survived~.,trainingds)
treeM
rpart.plot(treeM,extra = 4) 
prp(treeM)

#interpretation
# 1st Activity is for those who did not survive 0:there 
# .68 did not survive but .38 survived
# 
# activity not male(right) with activity survived: .28 people survived but .72 didnt(women)
# activity male(left) with  activity  not survived: .80 didnot survivr but .20 survived
# 
# same for rest


#making prediction
survivalPredict<-predict(treeM,testingds,type = 'class')
survivalPredict


#checking the accuracy of our model
confusionMatrix(survivalPredict,testingds$Survived)
