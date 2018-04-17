generate_data = function(n,p) {
  covariates = matrix(rnorm(0,1), n, p)
  responses = c(rnorm(n,0,1))
  return(list(covariates=covariates, responses =responses))
}


model_select = function(covariates, responses, cutoff) {
  lm = lm(responses~covariates)
  retain = covariates[which(lm$coefficients[,"Pr(>|t|)"] <= cutoff)]
  lm2 = lm(responses~retain)
  if (length(retain) == 0) {
    return(c())
  } else {
    return(lm2$coefficients[,"Pr(>|t|)"])
  }
}