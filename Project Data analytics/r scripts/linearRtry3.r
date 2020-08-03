
#declare
amount<-c(6,7,8,10,12,15,20,22,23)
yield<-c(10,12,15,12,16,20,15,25,24)


Ex<-sum(amount)
Ey<-sum(yield)
x2<-sum(amount*amount)
y2<-sum(yield*yield)

Exy<-sum(amount*yield)
Exy

hist(amount,yield)
#assign dataset
dataset<-data.frame(amount,yield)

#call dataset
summary(dataset)

plot(dataset$amount,dataset$yield )

#find correlation between x and y
corralationCoeffiency<-cor(dataset$amount,dataset$yield)
corralationCoeffiency

model1<-lm(yield~amount, data = dataset)
summary(model1)
plot(dataset$amount,dataset$yield )
abline(model1)






