generate_data = function(n,p) {
  covariates = matrix(rnorm(0,1), n, p)
  responses = c(rnorm(n,0,1))
  return(list(covariates=covariates, responses =responses))
}
