
library(dplyr)
mydata<- read.csv(file = "C:\\Users\\KWASI\\Documents\\books\\MastersCUTN\\3rd Sem\\Project Data analytics\\datasets\\murders.csv",stringsAsFactors = FALSE)
mydata

#here we are going to arrange the dataframe based on murders
mysubdata<- arrange(mydata,murders)
mysubdata

#using a select function we will create another dataset with columns we need
#this will create a dataset with state and murders done in the state
mysubdatamurder<-select(mysubdata,state,population,murders)
mysubdatamurder

#we can decide to see the sections of datasets using head and tails
head(mysubdatamurder,5)
tail(mysubdatamurder,5)

#renaming columns in a dataframe
names(mydata)
#mydata<-rename(mydata,#newname=oldname)

#using Mutate to add or remove columns to existing dataframes
#here we are creating a new table called ratio base on murders against population
newmydata<-mutate(mydata,ratio=murders/population)
names(newmydata)

#Then we create another frame using Select function.
mysubnewdataRatio<-select(newmydata,state,population,murders,ratio)
mysubnewdataRatio

#Using the groupby function we can grroup base on a set column
mysubgroup<-group_by(mydata,region)
mysubgroup
#we can summarize to find the murders in the various regions
summarize(mysubgroup,sum(murders))

#we can also calculate the mean of the murders in the various regions
summarize(mysubgroup,mean(murders))

#Using pipe operator to apply sequence operators on dataframes
#in pipe line it moves from left to right and the results from left is treated 
#as input for right

#we are printing Top 3 states murders
arrange(mydata,desc(murders)) %>% select(state,murders) %>% head(3)


#Data Visualization
#Bar char
library(ggplot2)
myplotdata<- select(mydata,state,population,murders)

#we want to plot the bar chart for the states and their population
ggplot(myplotdata,aes(x=state,y=population))+geom_bar(stat = "identity", fill=rgb(0.1,0.4,0.5,0.7))+ggtitle("States Vs Population")

#we want to plot the bar chart for the states and their respective murders
ggplot(myplotdata,aes(x=state,y=murders))+geom_bar(stat = "identity", fill=rgb(0.1,0.4,0.5,0.7))+ggtitle("States Vs Murders")

#we want to plot top 5 states with highest murders
mysubplt<-arrange(myplotdata,desc(murders))
highestmurder<-head(mysubplt,5)
highestmurder
ggplot(highestmurder,aes(x=state,y=murders))+geom_bar(stat = "identity", fill=rgb(0.1,0.4,0.5,0.7))+ggtitle("Top 5 states with highest murders")

#horizontal bar chart
mydata2<- read.csv(file = "C:\\Users\\KWASI\\Documents\\books\\MastersCUTN\\3rd Sem\\Project Data analytics\\datasets\\murdersmini.csv",stringsAsFactors = FALSE)
mydata2
mysubdata2<- select(mydata2,state,murders)
ggplot(mysubdata2,aes(x=state,y=murders))+geom_bar(stat="identity",fill=rgb(0.1,0.4,0.5,0.7))+ggtitle("State vs Murders")+coord_flip()


#histogram of stock price data
myhistodata<- read.csv(file = "C:\\Users\\KWASI\\Documents\\books\\MastersCUTN\\3rd Sem\\Project Data analytics\\datasets\\GEStock.csv",stringsAsFactors = FALSE)
mysubhistodata<-select(myhistodata,Date,Price)
ggplot(mysubhistodata,aes(x=Price))+geom_histogram( binwidth=10, fill="#69b3a2", color="#e9ecef")

#Scatter plots of murder data
par(mfrow=c(1,2))
myscadata<-select(mydata,state,population,murders)
ggplot(myscadata,aes(population,murders))+geom_point( 
                                                        fill="#69b3a2",
                                                          shape=21,
                                                          alpha=0.5,
                                                           size=2,
                                                             stroke = 2)
ggplot(myscadata,aes(population,murders))+geom_point( 
  fill="#69b3a2",
  shape=21,
  alpha=0.5,
  size=2,
  stroke = 2)

