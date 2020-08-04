#store the function that calculates the Black-Scholes's formula
bs <- function(S, T, t, K, r, s, q) {
  dp <- (log(S/K) + (r - q + 0.5 * s^2) * (T - t)) / (s * sqrt(T - t))
  dm <- dp - s * sqrt(T - t)
  S * exp(-q * (T - t)) * pnorm(dp) - K * exp(-r * (T - t)) * pnorm(dm)
}


#Calculate and plot the value of Black-Scholes price with respect to the volatility
#From the plot we can see that with volatility close to 0.3, the error from the real option price is close to 0.
sigmas <- seq(0.05, 0.5, by=0.01)
fsig <- bs(50, 0.5, 0.0, 45, 0.06, sigmas, 0.02) - 8
plot(sigmas, fsig, type="l", col="red", xlab=expression(sigma), ylab=expression(f(sigma)), lwd=2)


#Create a function that calculates the bisection value f(c) until the error is within the tolerance of 0.001
bisection <- function(f, a, b, tol=0.001) {
  while (b - a > tol) {
    c <- (a + b) / 2
    if (sign(f(c)) == sign(f(a)))
      a <- c
    else
      b <- c
  }
  (a + b) / 2
}



#calculate the volatility for this Black-Scholes formula
fsig <- function (sigma)
  bs(50, 0.5, 0.0, 45, 0.06, sigma, 0.02) - 8
bisection(fsig, 0.2, 0.4)



#calculate the Black-Scholes price
bs(50, 0.5, 0, 45, 0.06, 0.3433594, 0.02)
