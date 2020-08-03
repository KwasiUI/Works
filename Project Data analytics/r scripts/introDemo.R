#install dplyr packages
#install.packages("dplyr")
# - _
library(dplyr)

#load and assign dataset
database<- read.csv(file = "C:\\Users\\KWASI\\Documents\\books\\MastersCUTN\\3rd Sem\\Project Data analytics\\datasets\\demo.csv",stringsAsFactors = FALSE)

#view the imported database
View(database)

install.packages("tibble")
library(tibble)

#here too much data so we need to work with just few 
library(dplyr) 
database<- tibble::as.tibble(database)              
database

#function we can use
#head shows a few rows
#tail shows last few rows
#dim shows the number of rows X number coulumns
#name shows column names
head(database)
tail(database)
dim(database)
names(database)
glimpse(database)

#descriptive analysis

#we are going to try to see all genders
database$gender

#next we try to identify unique gender 
unique(database$gender)
length(unique(database$gender))

# to perform some calculation on our dataset

#mean will calculate the average salary of employees
mean(database$salary)

#range will calculate the range of salary of the employees
range(database$salary)

#summary will provide you with a brief info on dataset
summary(database$salary)

#now we need to check for null values and total number of null values 
is.na(database$salary)
sum(is.na(database$salary))

#now we plot
install.packages("ggplot2")
library(ggplot2)

#salary plotting
ggplot(database, aes(salary))+ geom_histogram(bins = 30)

#scatter for which employees are earning more
ggplot(database, aes(salary,emp_no,col=gender)) +geom_point()


#T test
# we are going to get all people with less salary into a dataset so we can work with it
smallmoney<-filter(database, salary<50000)
view(smallmoney)


##ML we are going to build a linear regression model


