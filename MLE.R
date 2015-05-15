# File:           MLE.R
# Version:        1
# Last changed:   Friday 15th May 2015
# Purpose:        Example MLE code for R
# Author:         Dr James Tripp
# Copyright:      (C) James Tripp 2015

# Define stimuli
stimuli <- c(1, 2, 5, 8, 15, 20)

# Define our data generating paramters
SD <- 0.01
w <- 0.2

# Define our model. Here we give a function implementing 
# range frequency theory. 
range_frequency_theory <- function(stimuli, w) {
  
  # The position of each stimulus in the range.
  range <- (stimuli - min(stimuli))/(max(stimuli) - min(stimuli))
  
  # The rank of the stimulus within the stimuli.
  frequency <- (1:length(stimuli) - 1) / (length(stimuli) - 1)
  
  # Our predictions are a weighted average of the range and rank position.
  (w * range) + ((1 - w) * frequency)
}


# Generate sample data from a normal distribution with a mean
# equal to the predictions of the range frequency model and 
# normally distributed noise.
responses <- rnorm(n = length(stimuli), 
                   mean = range_frequency_theory(stimuli, w), sd = SD)

# Keep values between 0 and 1.
responses[responses > 1] <- 1
responses[responses < 0] <- 0

# Function which gives us the negative log likelihood of the
# data on a normal distribution with a mean equal to the predictions
# of the model. Small values correspond to predictions which are close to 
# our data.
likelihood <- function(responses, predictions, sd){
  sum(-2 * dnorm(x = responses, 
                 mean = predictions, sd = sd, log = TRUE))
}

# This function is called by our minimisation algorithm to return 
# the negative log likelihood of the response given a value of
# sd and w parameters.
wrapper <- function(par, stimuli, responses){
  
  # w is transformed though a logistic function to keep 
  # the value between 0 and 1
  w = 1/(1+exp(-par[1])))

  sd = par[2]
  likelihood(responses, range_frequency_theory(stimuli, w, sd)
}

# Run our algorithm with a starting value of 0.5 for both sd and w
result <- optim(par = c(0.5, 0.5), wrapper, 
                stimuli = stimuli, responses = responses)

# Print out our result
print(paste('Our starting value for w is', w, ' and our estimate is', 1/(1+exp(-result$par[1])), '.', sep = ' ')
      print(paste('Our starting value for sd is', SD, ' and our estimate is', result$par[2])), '.', sep = ' ')