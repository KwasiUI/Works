file<-"C:\\Users\\KWASI\\Documents\\books\\Online Courses\\data analytics mysql\\Tabluee datasets\\taskONE.csv"
task1<- read.csv(file ,stringsAsFactors = FALSE)
task1<-data.frame(task1)
task1
library(ggplot2)
ggplot(task1,aes(x=C_Year,y=Employees,fill=gender))+geom_bar(stat="identity", position="dodge")+geom_text(aes(label=Employees ))
mean(task1$Employees)
sum(task1$Employees)
median(task1$Employees)
