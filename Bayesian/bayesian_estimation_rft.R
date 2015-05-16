# File:           bayesian_estimation_rft.R
# Version:        1
# Last changed:   Friday 15th May 2015
# Purpose:        Example Bayesian estimation code for R and JAGS
# Author:         Dr James Tripp
# Copyright:      (C) James Tripp 2015

# Define stimuli
s <- c(1, 2, 3, 4, 7, 9, 11, 13, 16, 21, 18);

# Define our data generating paramters
w <- 0.2
SD <- 0.01

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

# Generate sample data from a normal distribution with a mean
# equal to the predictions of the range frequency model and 
# normally distributed noise.
responses <- rnorm(n = length(s), 
                   mean = range_frequency_theory(w), sd = SD)

# Keep values between 0 and 1.
responses[responses > 1] <- 1
responses[responses < 0] <- 0

# Load R2JAGS library
library('R2jags')

# Define range frequency model in JAGS
rft.model <- function(){
  # passed to model
  #   N = number of data points
  #   range = pure range prediction
  #   rank = pure rank prediction
  #   response = participant responses
  
  w ~ dunif(0, 1)
  sigma ~ dunif(0, 1000)
  tau <- pow(sigma, -2)
  
  for (item_idx in 1:N){
    rft[item_idx] <- (w * range[item_idx]) + ((1 - w) * rank[item_idx])
    response[item_idx] ~ dnorm(rft[item_idx], tau)
  }
}

# Parameter porteriors we want back from JAGS
jags.params <- c('w', 'sigma')

# Function used by R to generate the
# MCMC chain starting values
jags.inits <- function(){
  list(
    'w' = runif(1, 0, 1),
    'sigma' = runif(1, 0.01, 1000)
  )
}

# Collect together the values we will pass 
# to JAGS in a list.
jags.data <- list(
  'N' = length(s),
  'range' = r,
  'rank' = f,
  'response' = responses
)

# Compile the model and run 10 iterations to make sure all is ok
jagsfit <- jags(data=jags.data, inits=jags.inits, jags.params,
                n.iter=10, model.file=rft.model)

# Continually update the model until the it looks like the MCMC 
# chains do not depend on the starting values (R) Rhat <= 1.1
jagsfit.auto <- autojags(object = jagsfit, n.iter = 100, n.thin = 0, 
                         n.update = 100)

# Print model statistics
# Note: the 95% confidence intervals allow us 
# to quantify our parameter uncertainty. Cool!
print(jagsfit.auto)

# Unpack the posterior samples
mcmc <- as.mcmc(jagsfit.auto)
mcmc <- as.data.frame(rbind(mcmc[[1]], mcmc[[2]], mcmc[[3]]))

# Plot the posterior distributions
# It looks like we're bang on the money.
par(mfrow=c(1,2))
hist(mcmc$w, main = 'W', xlab = 'Sample value')
hist(mcmc$sigma, main = 'Sigma', xlab = 'Sample value')
