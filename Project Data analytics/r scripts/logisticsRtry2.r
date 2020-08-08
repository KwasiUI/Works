#libraries
library(caTools)
library(dplyr)
library(ggplot2)
library(corrplot)
#begin by importing data
data<- read.csv(file = "C:\\Users\\KWASI\\Documents\\books\\MastersCUTN\\3rd Sem\\Project Data analytics\\datasets\\telecomdata.csv")
names(data)
View(data)
summary(data)
class(data)

#lets visualize 

#histogram for monthly charges
hist(data$MonthlyCharges,
     main = "Histogram of Monthly Charges",
     xlab = "Monthly Charges",
     ylab = "Frequency",
     las = 1,
     col = c("skyblue", "chocolate2")
)
#histogram for total charges
hist(data$TotalCharges,
     main = "Histogram of Monthly Charges",
     xlab = "Monthly Charges",
     ylab = "Frequency",
     las = 1,
     col = c("skyblue", "chocolate2")
)

gender.count<-table(data$gender)
churn.count<-table(data$Churn)
gen.chu.count<-table(data$gender,data$Churn)



#lets find the number of males as compaired to female customers
par(mfrow=c(2,2))
gender.count
barplot(gender.count,horiz = TRUE, names.arg=c('Female','Male'), 
        main='Distribution of gender', xlab='Count', ylab='Gender',
        col = c("orange","steelblue")
        )

#Lets find the number of churn  
churn.count
barplot(churn.count, names.arg=c('No','Yes'), 
        main='Customer Attrition', xlab='Count', ylab='Churn',
        col = c("brown","orange"),
        horiz = TRUE
        )




#next we find the number of churn in terms of gender

gen.chu.count
barplot(gen.chu.count,col=c('orange','brown'), 
                 names.arg=c('No', 'Yes'),
                 main='Gender Distribution of Customer Attrition',
                 ylab='Customer Attrition',
                 xlab='Count',
                 beside=T,legend=c('F','M')
        ,horiz = TRUE)
#mtext("Telecom Dashboard", side = 3, line = -21, outer = TRUE)

#contracts
cont.count<-table(data$Contract)
cont.count
barplot(cont.count,col=c('orange','brown'), 
        names.arg=c('Month To Month', 'One Year','Two Years'),
        main='Distribution of Customer On Contracts',
        ylab='Contracts',
        xlab='Count'
        ,horiz = TRUE)

#lets categorize tenure
catTenure<-cut(data$tenure,breaks = c(0,12,24,48,60,400),right = FALSE)
Tencount<-table(catTenure)
Tencount
barplot(Tencount, names.arg=c('0 to 12','12 to 24','24 to 48','48 to 60','60 to 400'), 
        main='Tenure Distribution', xlab='Tenure', ylab='Churn',
        col = c("brown","orange"),
       
)
#Group Churn based on Tenure
t.c<-table(data$Churn,catTenure)
barplot(t.c, names.arg=c('0 to 12','12 to 24','24 to 48','48 to 60','60 to 400'), 
        main='Tenure Distribution in Customer Attrition', xlab='Churn', ylab='Count',
        col = c("brown","orange"),
        beside=T,
        #legend=c("No Churn","Chun"),
        
)

#scatter plot for total charges against montly charges
plot(x=data$MonthlyCharges,y=data$TotalCharges,
     xlab = "Monthly Charges", ylab = "Total Charges",main = "Monthly and Total Charges group by Tenure"
     ,col=catTenure,
     legend=c("0-12","12-24","24-48","48-60","60-400")
     )
any(is.na(data))
