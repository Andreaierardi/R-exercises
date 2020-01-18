#install.packages("Rtools")

# The easiest way to get ggplot2 is to install the whole tidyverse:

tidyverse::is.tidyverse(1)
devtools::is.devtools(1)
library(ggplot2)
ggplot2::is.ggplot2(1)

leggo <- read.csv(file="C:/Users/AndreDany/Downloads/Milan_airquality2019.csv", header=TRUE, sep=",")
#ggplot(Data,aes(displ,hwy,colour=blue)) + geom_point()

Data = leggo
plot(Data)
Data$stazione_id=NULL
Data
plot(Data)
summary(Data)

Data$data
Data$inquinante

ggplot(Data,aes(Data$data, Data$valore, colour=Data$inquinante)) + geom_point() +facet_wrap(~ Data$inquinante)+ geom_smooth(method="lm")

Data = Data[complete.cases(Data),]
Data
plot(Data)

install.packages("xts", TRUE)
xts::is.xts(1)
library(xts)

#dfX <- xts(Data$valore, as.Date(Data$data, tz="DMY"))
#dfx
#apply.daily(dfX, mean)
?aggregate
Data
test = aggregate(valore~ data+inquinante, Data , mean)
test

data.ts = as.ts(test)
plot(data.ts)

plot(test)
ggplot(test,aes(test$data, test$valore, colour=test$inquinante)) + geom_point() + facet_wrap(~ test$inquinante, scales = "free")+ geom_smooth(method="lm")
Data
test


co = subset(test,subset= inquinante=="C6H6")
co = co[,c('data','valore')]
co
plot(co)
ggplot(co, aes(x=data,y=valore, group=1))+geom_point()+geom_line()+ geom_smooth(method="lm")
cots = as.ts(co)
write.csv(co,"co.csv")

pm10 = subset(test,subset= inquinante=="PM10")
pm10 = pm10[,c('data','valore')]
pm10
#sas
plot(pm10)
ggplot(pm10, aes(x=data,y=valore, group=1))+geom_point()+geom_line() + geom_smooth(method="lm")

pm10$data= NULL
data.ts = as.ts(pm10)

plot(data.ts)

fit= arima(data.ts, order=c(1,1,1))
install.packages("forecast")
fit = auto.arima(data.ts)
plot(forecast(fit,30))
forecast(fit,30)

cots
data.ts
plot(cots)
co.ts = as.ts(co)
co.ts

co.ts

  
cor(data.ts,cots)
library(tseries)
library(forecast)
accuracy(fit)
write.csv(pm10,"pm10.csv")

install.packages("zoo")
library(zoo)
plot(merge(cots,data.ts), plot.type="single", lty=c(2,1), lwd=2, xlab="Date", ylab="Value for day", ylim=c(-5,17), main="Inquinanti")
#Data[!is.na(Data$valore)]
#Data[, Data[is.na(Data$valore)]]=NULL
#Data = Data[!(Data$valore==NA),]
