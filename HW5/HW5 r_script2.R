#Create a function that calculates the bisection value f(c) until the error is within the tolerance of 0.00001
bisection <- function(f, a, b, tol=0.00001) {
  while (b - a > tol) {
    c <- (a + b) / 2
    if (sign(f(c)) == sign(f(a)))
      a <- c
    else
      b <- c
  }
  (a + b) / 2
}

#define the function g and returns the value of g(x) - 1 with the input of x
g <- function(x) {
  x^3 - 5*x^2 -7*x - 1
}

#plot the g(x) - 1 with respect to values of x from x=-4 to x=8, and find that there are two other value of x such that g(x) - 1 = 0
x <- seq(-4, 8, by=0.01)
gs <- g(x)
plot(x, gs, type="l", col="red", xlab=expression(sigma), ylab=expression(f(sigma)), lwd=2)


#I choose the value that is negative and calculate the estimated x value as -1
bisection(g, -1.5, 1)
