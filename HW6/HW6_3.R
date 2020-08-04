#define variables
maturities = c( 6, 12, 18, 24, 30, 36, 42, 48, 54, 60)
yearFrac = maturities / 12
faceval = 3201/32
price = 3201/32
couponRate = 0.03375
cashFlows = rep((price * couponRate) / 2.0, 10)
cashFlows[10] = price + cashFlows[10]
initialF = 0.1

# define the function to calculate the yield of bond with given parameters
calcField<- function(guess, cashflow, yearfrac, price) {
  xi = guess
  xNext = guess
  
  # use Newton's method to find the value of field that fits the best
  while (abs(xNext - xi) > 1e-6) {
    xi = xNext
    a = sum(cashflow * exp(yearfrac*-1*xi))
    b = sum(yearfrac*cashflow*exp(yearfrac*-1*xi))
    xNext = xi + (a - price) / b
  }
  xNext
}
calcField(initialF, cashFlows, yearFrac, price)