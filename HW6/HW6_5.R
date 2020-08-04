#defines the function that calculates the black scholes' price
bsc <- function(S,T,t,K,r,s,q){
  d1 <- (log(S/K)+(r-q+0.5 *s^2)*(T-t))/(s*sqrt(T-t))
  d2 <- d1-s*sqrt(T-t)
  S*exp(-q*(T-t))*pnorm(d1)-K*exp(-r*(T-t))*pnorm(d2)
}

#defines the bisection method
bisection <- function(f, a, b, tol=1e-6){
  while(b-a>tol){
    c <- (a+b)/2
    if(sign(f(c))==sign(f(a)))
      a <- c
    else
      b <- c
  }
  (a+b)/2
}

#define the function that calculates the difference between the black scholes' price and the option price (2.5)
fsig <- function(sigma)
  bsc(30, 0.25, 0.0, 30, 0.06, sigma, 0.02)-2.5

# calculate the sigma with given range
bisection(fsig, 0.0001, 1)



# defines bsc'
dbsc <- function(S, T, t, K, r, s, q){
  d1 <-(log(S/K)+(r-q+0.5*s^2)*(T-t))/(s*sqrt(T-t))
  S*exp(-q*(T-t))*1/sqrt(2*pi)*exp(-d1^2/2)*sqrt(T-t)
}

# calculates value of bsc'(x) and bsc(x) - 2.5
dfsig <- function(sigma)dbsc(30, 0.25, 0.0, 30, 0.06, sigma, 0.02)
fsig <- function(sigma)bsc(30, 0.25, 0.0, 30, 0.06, sigma, 0.02)-2.5

# defines the Newton's method with initial guess 0.5
u <- 500
x <- 0.5
k <- 0
while (abs(u)/abs(x)>1e-6){
  u <- fsig(x)/ dfsig(x)
  x <- x-u
  k <- k+1
}
x