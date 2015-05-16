from pymc import *
# File:           MLE.py
# Version:        1
# Last changed:   Friday 15th May 2015
# Purpose:        Example MLE code for Python
# Author:         Dr James Tripp
# Copyright:      (C) James Tripp 2015

import numpy as np
import scipy.stats as stats
from scipy.optimize import minimize
import math as m

# Define our stimuli
s = np.array([1, 2, 3, 4, 7, 9, 11, 13, 16, 21, 18], dtype = 'float64')
N = s.size # number of stimuli

# Define parameters for generating our false data
w = 0.9;
sd = 0.001;

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

bayes_w = Uniform('bayes_w', lower=0, upper=1)
sigma = Uniform('sigma', lower = 0, upper = 1000)

@deterministic(plot=False)
def precision(std_dev=sigma):
    return 1.0 / (std_dev * std_dev)

@deterministic(plot=False)
def rft_pred(w = bayes_w):
    return rft(w)

prediction = rft_pred

for i in range(11):
    pred = Normal('Pred', mu=prediction[i], tau=precision, value=r[i], observed=True)
