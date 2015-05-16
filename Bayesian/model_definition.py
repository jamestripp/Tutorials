# File:           model_definition.py
# Version:        1
# Last changed:   Saturday 16th May 2015
# Purpose:        Define bayesian model for rft
#                 and generate data
# Author:         Dr James Tripp
# Copyright:      (C) James Tripp 2015

import numpy as np
from pymc import *

# Define our stimuli
s = np.array([1, 2, 3, 4, 7, 9, 11, 13, 16, 18, 21], dtype = 'float64')
N = s.size # number of stimuli

# Define parameters for generating our false data
w = 0.2;
sd = 0.2;

R = (s - s.min())/(s.max() - s.min())
F = np.arange(N, dtype = 'float64')/(s.size - 1)

# Define function for our model
# Here we use range frequency theory
def rft(w):
    return((w * R) + ((1 - w) * F))

# Get our model predictions
rft_pred = rft(w)

# Create our response array which will be filled
r = np.arange(N, dtype = 'float64')

# Generate random values from normal distribution with mean
# equal to range frequency theory prediction
for i in range(N):
  r[i] = np.random.normal(loc=rft_pred[i], scale=sd, size=1)[0]

# Keep responses between 0 and 1
r[r<0] = 0
r[r>1] = 1

# Define uniform priors for w and sigma
sigma = Uniform('sigma', lower = 0, upper = 1000)
bayes_w = Uniform('bayes_w', lower=0, upper=1)

# Deterministic nodes change given sampled 
# values. In this case we take a value of 
# sigma and turn it into the precision variable
# required for our likelihood function
@deterministic(plot=False)
def precision(std_dev=sigma):
    return 1.0 / (std_dev * std_dev)

# The range frequency predictions for the 
# currently w sample are generated each time
# this function is called.
#@deterministic(plot=False)
#def rft_pred(w = bayes_w):
#    return rft(w)

# Predictions using current bayes_w
#prediction = rft_pred

pred = [None] * N

# Iterate over the data and calculate the likelihood function
for i in range(N):
    pred[i] = Normal('Pred', mu=rft(bayes_w)[i], tau=precision, value=r[i], observed=True)
