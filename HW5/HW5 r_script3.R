#calculate the function f(x) with input of x
f <- function(x) {
  -x^5 -cos(x)
}
#calculate the derivative of f(x)
df <- function(x) {
  -5*x^4 + sin(x)
}

#calculate the Newton's method to find the solution x such that f(x) = 0, counter keeps track of how many time of iterations
u <- 500
x <- 1
counter <- 0
while ((abs(u) / abs(x)) > 1e-4) {
  u <- f(x) / df(x)
  x <- x - u
  counter <- counter + 1
}
counter
x
sol1 <- f(x)

#The modified Newton's method with smaller tolerance value so that the final solution calculated is closer than before.
u <- 500
x <- 1
counter <- 0
while ((abs(u) / abs(x)) > 1e-8) {
  u <- f(x) / df(x)
  x <- x - u
  counter <- counter + 1
}
counter
x
f(x) - sol1