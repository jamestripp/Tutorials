# File:           heirarchical_bayes_rft.R
# Version:        1
# Last changed:   Friday 15th May 2015
# Purpose:        Heirarchical bayesian modeling of RFT
# Author:         Dr James Tripp
# Copyright:      (C) James Tripp 2015

# Define stimuli
s <- c(1, 2, 3, 4, 7, 9, 11, 13, 16, 18, 21);

# The position of each stimulus in the range.
r <- (s - min(s))/(max(s) - min(s))

# The rank of the stimulus within the stimuli.
f <- (1:length(s) - 1) / (length(s) - 1)

# Define our model. Here we give a function implementing 
# range frequency theory. 
range_frequency_theory <- function(w) {
  # Our predictions are a weighted average of the range and rank position.
  (w * r) + ((1 - w) * f)
}

# Define our data generating paramters
w <- 0.8
SD <- 0.08

ind.sd <- 0.11 # individual variance

N <- 10 # Number of participants we will simulate

# Let us assume participant paramters are 
# drawn from a group norm
ind.w <- rnorm(N, mean = w, sd = ind.sd)
ind.sd <- rnorm(N, mean = SD, sd = ind.sd)
ind.sd[ind.sd < 0] <- 0

#preallocate data matrix
data <- matrix(NaN, nrow = N, ncol = length(s))

# generate data from normal distribution with mean 
# equal to the predictions of the range frequency model
# note: we use the individual paramters to generate the data
for (i in 1:N){ 
  data[i,] <- rnorm(n = length(s), 
                    mean = range_frequency_theory(ind.w[i]), sd = ind.sd[i])
}

data[data<0] <- 0
data[data>1] <- 1

# Load R2JAGS library
library('R2jags')

jags.params <- c('w', 'sd', 'grp.w.mu', 'grp.sd.mu')

jags.inits <- function(){
  list(
    'width' = rexp(1, rate = 1),
    'grp.w.mu' = runif(1, 0, 1),
    'grp.sd.sigma' = rnorm(1, 0, 1),
    'grp.sd.mu' = rnorm(1, 0, 1)
  )
}

# shortcut to create matrix
m <- function(v, n.ppts){
  t(matrix(v, ncol=n.ppts))
}

jags.data <- list(
  'N' = length(s),
  'range' = t(matrix(rep(r, N), ncol = N)),
  'rank' = t(matrix(rep(f, N), ncol = N)),
  'response' = data,
  'n.ppts' = N
)

jagsfit <- jags(data=jags.data, inits=jags.inits, jags.params,
                n.iter=10, model.file='RFT_hierarchical_model.txt')

jagsfit.auto <- autojags(object = jagsfit, n.iter = 100, n.thin = 0, n.update = 100)

# Print model statistics
# Note: the 95% confidence intervals allow us 
# to quantify our parameter uncertainty. Cool!
print(jagsfit.auto)

# Unpack the posterior samples
mcmc <- as.mcmc(jagsfit.auto)
mcmc <- as.data.frame(rbind(mcmc[[1]], mcmc[[2]], mcmc[[3]]))

# Plot the posterior distributions
# It looks like we're bang on the money.
hist(mcmc$grp.w.mu, main = 'grp.w.mu', xlab = 'Sample value')

