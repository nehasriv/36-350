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


run_simulation = function(n_trials, n, p, cutoff=.05) {
  p.values = c()
  for (i in 1:n_trials) {
    data = generate_data(n,p)
    p.values = model_select(data$covariates, data$responses)
    save(p.values)
  }
}


make_plot = function(datapath){
  p.values = load(p.values)
  hist(p.values)
}

run_simulation(10, n=c(100,1000,10000), p=c(10,20,50), cutoff = .05)

