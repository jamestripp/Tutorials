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
s = np.array([1, 2, 3, 4, 7, 9, 11, 13, 16, 21, 18,], dtype = 'float64')
N = s.size # number of stimuli

# Define parameters for generating our false data
w = 0.5;
sd = 0.01;

# Define function for our model
# Here we use range frequency theory
def rft(w):
  R = (s - s.min())/(s.max() - s.min())
  F = np.arange(N, dtype = 'float64')/(s.size - 1)
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


# Define function to return likelihood of data given 
# values of w and sd. Small values = higher likelihood
def get_lhood(p):
  w = 1/(1 + m.exp(-p[0])) #keep w between 0 and 1
pred = rft(w)
lnL = np.arange(N, dtype = 'float64')
for i in range(N):
  lnL[i] = -2 * m.log(stats.norm(pred[i], p[1]).pdf(r[i]))

return(sum(lnL))

# Set starting values for minimization function
x0 = np.array([0, 1])

# Run minimization function to estimtate w and sd
res = minimize(get_lhood, x0, method='nelder-mead',
               options={'xtol': 1e-8, 'disp': True})

# Print out the result
print "Our generating value for w is", w
print "Our estimate for w is", 1/(1+m.exp(-res.x[0]))

print "Our generating value for sd is", sd
print "Our estimate for sd is", res.x[1]
