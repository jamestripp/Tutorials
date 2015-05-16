# File:           bayesian_estimation.py
# Version:        1
# Last changed:   Saturday 16th May 2015
# Purpose:        Example Bayesian estimation code for Python
# Author:         Dr James Tripp
# Copyright:      (C) James Tripp 2015

import model_definition

from pymc import *

model = MCMC(model_definition)
model.sample(iter=3000)
print(model.stats())
