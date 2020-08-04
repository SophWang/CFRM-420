# Solution to Homework 6 - CFRM 420, Autumn of 2019

#-------------------------------------------------------------------------------------#
#                                                                                     #
#                   Question 1                                                        #
#                                                                                     #
#-------------------------------------------------------------------------------------#
# Loading data
# make sure that "HW6-Q1.txt" is in your working directory
library(quantmod)
dat=read.table("HW6-Q1.txt", header=TRUE, sep = ",")
KO=xts(dat[,2], order.by=as.Date(dat[, 1]));names(KO) = c("KO")
r <- 100*diff(log(KO))[-1]

# (a)
acf(r)
Box.test(r, lag = 10, type = "Ljung-Box")

# (b)
# Finding the mean equation
library(forecast)
fit=auto.arima(r, max.p = 20, max.q = 20, max.d = 2, ic="bic")
print(fit)
pacf((resid(fit)**2), main=expression("sample PACF of "~ residaul^2))

# Fitting a MA(1)+GARC(1,1) model
library(fGarch)
magarch = garchFit(~arma(0,1)+garch(1,1), data=r, trace = F) 
summary(magarch)

# for diagnostic use options 10, 11, and 13
par(mar=c(4.5,4.5,4.5,4.5))
plot(magarch)

# (c)
magarch_t = garchFit(~arma(0,1)+garch(1,1), data=r,
                     cond.dist = "std", # using standard t distribution
                     trace = F)
summary(magarch_t)
par(mar=c(4.5,4.5,4.5,4.5))
plot(magarch_t)

# (d)
print(predict(magarch,5))
print(predict(magarch_t,5))

#-------------------------------------------------------------------------------------#
#                                                                                     #
#                   Question 3                                                        #
#                                                                                     #
#-------------------------------------------------------------------------------------#
# Loading data
# make sure that "HW6-Q3.txt" is in your working directory
library(quantmod)
dat=read.table("HW6-Q3.txt", header=TRUE, sep = ",")
VALE=xts(dat[,2], order.by=as.Date(dat[, 1]));names(VALE) = c("VALE")
BHP=xts(dat[,3], order.by=as.Date(dat[, 1]));names(BHP) = c("BHP")
chartSeries(VALE, theme=chartTheme("white", up.col='black'))
chartSeries(BHP, theme=chartTheme("white", up.col='black'))
p1=log(BHP)
p2=log(VALE)
rtn1 = diff(p1)[-1]
rtn2 = diff(p2)[-1]

# (a)
library(tseries)
# BHP
adf.test(p1)
pp.test(p1)
kpss.test(p1) # non-stationary
adf.test(rtn1)
pp.test(rtn1)
kpss.test(rtn1) # non-stationary
# VALE
adf.test(p2)
pp.test(p2)
kpss.test(p2) # non-stationary
adf.test(rtn2)
pp.test(rtn2)
kpss.test(rtn2) # non-stationary

# (b) and (c)
twosteps = lm(coredata(p1)~coredata(p2))
summary(twosteps)
po.test(coredata(merge(p1,p2))) # cointegrated

# (d)
library(urca)
summary(ca.jo(merge(p1,p2)))
