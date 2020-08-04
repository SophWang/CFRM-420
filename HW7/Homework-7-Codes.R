## HW7 
## Code Starter.  
## I am making no guarantee that all you need for HW 7 is included here
## Add more R code parts to it as you need them.  

## install.packages('tidyverse')
require(tidyverse)

## Problem 2

data = read.table('HW7Q2.txt',header = T)
Y= data[,2:6]

CovMat = var(Y)
plot(prcomp(CovMat))
summary(prcomp(CovMat))

CorrMat = cor(Y)
plot(prcomp(CorrMat))
summary(prcomp(CorrMat))

fa_none = factanal(Y, 2, rotation = "none")
print(fa_none)

## Problem 3 

require(tidyverse)
data = read.table('HW7Q3.txt',header = T)
Y = data %>% select(-SP5)
X = data %>% mutate(Const=1) %>% select(Const,SP5)

## Problem 3.a


mABT = lm(ABT~SP5, data=data)
mLLY = lm(LLY~SP5, data=data)
mMRK = lm(MRK~SP5, data=data)
mPFE = lm(PFE~SP5, data=data)
mF = lm(F~SP5, data=data)
mGM = lm(GM~SP5, data=data)
mBP = lm(BP~SP5, data=data)
mCVX = lm(CVX~SP5, data=data)
mRD = lm(RD~SP5, data=data)
mXOM = lm(XOM~SP5, data=data)

Beta01 = rbind(
	mABT$coefficients, 
	mLLY$coefficients,
	mMRK$coefficients,
	mPFE$coefficients,
	mF$coefficients,
	mGM$coefficients,
	mBP$coefficients,
	mCVX$coefficients,
	mRD$coefficients,
	mXOM$coefficients)

RSQD = rbind(
	summary(mABT)$r.squared, 
	summary(mLLY)$r.squared,
	summary(mMRK)$r.squared,
	summary(mPFE)$r.squared,
	summary(mF)$r.squared,
	summary(mGM)$r.squared,
	summary(mBP)$r.squared,
	summary(mCVX)$r.squared,
	summary(mRD)$r.squared,
	summary(mXOM)$r.squared)

EpsVar = rbind(
	summary(mABT)$sigma^2, 
	summary(mLLY)$sigma^2,
	summary(mMRK)$sigma^2,
	summary(mPFE)$sigma^2,
	summary(mF)$sigma^2,
	summary(mGM)$sigma^2,
	summary(mBP)$sigma^2,
	summary(mCVX)$sigma^2,
	summary(mRD)$sigma^2,
	summary(mXOM)$sigma^2)



my_summary = cbind(Beta01, RSQD, EpsVar)
colnames(my_summary) = c("B0","B1","rsquared","epsvar")
rownames(my_summary) = colnames(Y)
my_summary




options(digits=3)

## Sample Covariance Matrix 
CovEst1 = var(Y)

## Covariance Matrix Implied by 10 Single Factor Models 
## This might look foreign at a glance, but if you try to see what's going on, you should be able to
## You don't need to justify this next formula, and just use it
## If interested, check (18.17) of the text book again on Page 542. 
CovEst2 = var(X %>% select(SP5)) * cbind(beta01[,2]) %*% rbind(beta01[,2]) + diag(EpsVar)
colnames(CovEst2) = colnames(CovEst1)
rownames(CovEst2) = rownames(CovEst1)

## this is the (dummy) even-weighted portpolio version 
## This was introduced in Video Lecture 
## Also see Page 545 of the text 
portpolio_weight = cbind(rep(1,ncol(Y)))/ncol(Y)
portpolio_weight
t(portpolio_weight) %*% CovEst1 %*% portpolio_weight
t(portpolio_weight) %*% CovEst2 %*% portpolio_weight

## This is new.  But, see also Page 545 for related discussion.
## the global minimum variance portfolio is the portfolio weight that 
## solves a variance minimization problem can be obtained as follows. Namely, 
## the global minimum variance portfolio = 
## CovMatInverse * VectorOne/  VectorOneTranspose * CovMatInverse * VectorOne 
## See below for more concreate computation 

vector_ones = cbind(rep(1,ncol(Y)))
optimal_portpolio_weight1 =  solve(CovEst1) %*% vector_ones/ as.numeric(t(vector_ones) %*% solve(CovEst1) %*% vector_ones)
optimal_portpolio_weight2 =  solve(qr(CovEst2,LAPACK=TRUE),vector_ones)/ as.numeric(t(vector_ones) %*% solve(qr(CovEst2,LAPACK=TRUE),vector_ones))

sum(optimal_portpolio_weight1)
sum(optimal_portpolio_weight1)

print(optimal_portpolio_weight1)
print(optimal_portpolio_weight2)

t(optimal_portpolio_weight1) %*% CovEst1 %*% optimal_portpolio_weight1
t(optimal_portpolio_weight1) %*% CovEst2 %*% optimal_portpolio_weight1


## Problem 3.b
plot(prcomp(Y))
summary(prcomp(Y))

## Problem 3.c
print(factanal(Y,5,rotations='none'))
