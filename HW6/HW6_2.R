# the function that calculates the portfolio with given expected return
efficient.portfolio <-
  function(er, cov.mat, target.return, shorts=TRUE)
  {
    call <- match.call()
    
    #
    # check for valid inputs
    #
    asset.names <- names(er)
    er <- as.vector(er) # assign names if none exist
    N <- length(er)
    cov.mat <- as.matrix(cov.mat)
    if(N != nrow(cov.mat))
      stop("invalid inputs")
    if(any(diag(chol(cov.mat)) <= 0))
      stop("Covariance matrix not positive definite")
    # remark: could use generalized inverse if cov.mat is positive semidefinite
    
    #
    # compute efficient portfolio
    #
    if(shorts==TRUE){
      ones <- rep(1, N)
      top <- cbind(2*cov.mat, er, ones)
      bot <- cbind(rbind(er, ones), matrix(0,2,2))
      A <- rbind(top, bot)
      b.target <- as.matrix(c(rep(0, N), target.return, 1))
      x <- solve(A, b.target)
      w <- x[1:N]
    } else if(shorts==FALSE){
      Dmat <- 2*cov.mat
      dvec <- rep.int(0, N)
      Amat <- cbind(rep(1,N), er, diag(1,N))
      bvec <- c(1, target.return, rep(0,N))
      result <- quadprog::solve.QP(Dmat=Dmat,dvec=dvec,Amat=Amat,bvec=bvec,meq=2)
      w <- round(result$solution, 6)
    } else {
      stop("shorts needs to be logical. For no-shorts, shorts=FALSE.")
    }
    
    #
    # compute portfolio expected returns and variance
    #
    names(w) <- asset.names
    er.port <- crossprod(er,w)
    sd.port <- sqrt(w %*% cov.mat %*% w)
    ans <- list("call" = call,
                "er" = as.vector(er.port),
                "sd" = as.vector(sd.port),
                "weights" = w) 
    class(ans) <- "portfolio"
    return(ans)
  }


#define expected returns for each asset and the correlation matrix
er = c(0.08, 0.1, 0.13, 0.15, 0.2)
corr = matrix(c(1, -0.3, 0.4, 0.25, -0.2,
                  -0.3, 1, -0.1, -0.2, 0.15,
                  0.4, -0.1, 1, 0.35, 0.25,
                  0.25, -0.2, 0.35, 1, -0.15,
                  -0.2, 0.15, 0.25, -0.15, 1),
                nrow=5, ncol=5)
sd = c(0.14, 0.18, 0.23, 0.25, 0.35)
d = diag(sd)
covmat = d %*% corr %*% d

#calculate the minimum variance portfolio with 15% expected return
e.port.all = efficient.portfolio(er, covmat, 0.15)
e.port.all

# define the function for gradient of maximum expected return portfolio
G <- function(x, mu, Sigma, sigmaP2){
  n <- length(mu)
  c(mu + rep(x[n+1], n) + 2*x[n+2]*(Sigma %*% x[1:n]),
    sum(x[1:n]) -  1,
    t(x[1:n]) %*% Sigma %*% x[1:n] - sigmaP2)
}


# define the function for the gradient of G(x)
DG <- function(x, mu, Sigma, sigmaP2){
  n <- length(mu)
  grad <- matrix(0.0, n+2, n + 2)
  grad[1:n, 1:n] <- 2*x[n+2]*Sigma
  grad[1:n, n+1] <- 1
  grad[1:n, n+2] <- 2*(Sigma %*% x[1:n])
  grad[n+1, 1:n] <- 1
  grad[n+2, 1:n] <- 2*t(x[1:n]) %*% Sigma
  grad}


# define values for x, u, mu, sigma, and sigmap2. Use Newtonw's method to find weights.
x <- c(rep(0.5, 5), 1, 1)
u <- rep(1, length(x))
mu = c(0.08, 0.1, 0.13, 0.15, 0.2)
Sigma = covmat
while(sqrt(sum(u^2)) / sqrt(sum(x^2)) > 1e-4){
  u <- solve(DG(x, mu, Sigma, 0.25^2),G(x, mu, Sigma, 0.25^2))
  x <- x - u
}
x[1:5] %*% mu
