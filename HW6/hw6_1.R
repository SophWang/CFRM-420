
#define the function F(x) that takes in an array x, outputs the value of gradient of the lagrangian
F<- function(x){
  c(1+2*x[5]*x[1]+2*x[6]*x[1], 
    -2+2*x[5]*x[2]+4*x[6]*x[2],
    3+6*x[6]*x[3],-4-2*x[4]*x[5],
    x[1]**x[1]+x[2]**x[2]-x[4]**x[4]-1, x[1]**x[1]+2*x[2]**x[2]+3*x[3]**x[3]-6)}

#define the function DF(x) that takes in x and outputs the gradient of F(x)
DF<- function(x){matrix(c(2*x[5]+2*x[6],0,0,0,2*x[1],2*x[1],
                          0,2*x[5]+4*x[6], 0, 0, 2*x[2], 4*x[2], 
                          0, 0, 6*x[6], 0, 0, 6*x[3], 
                          0, 0, 0, -2*x[5],-2*x[4], 0,
                          2*x[1], 2*x[2], 0, -2*x[4], 0, 0, 
                          2*x[1], 4*x[2], 6*x[3], 0, 0, 0),
                        6,6,byrow = TRUE)}

#define x and u
x <- rep(-1, 6)
u<- rep(1, 6)

#Newton's method to find the solution
while(sqrt(sum(u^2)) / sqrt(sum(x^2)) > 1e-4){
  u <- solve(DF(x), F(x))
  x <- x - u
}
x

#check if the solution is a maximum or minimum
round(DG(x), digits = 3)