# File:           rft_functions.R
# Version:        1
# Last changed:   Thursday 4th June 2015
# Purpose:        Function for producing the prediction 
# 		  of range frequency theory
# Author:         Dr James Tripp
# Copyright:      (C) James Tripp 2015

# Define stimuli
range.pred <- function(stim)
{
  (stim - min(stim)) / (max(stim) - min(stim))
}

rank.pred <- function(stim)
{
  (cumsum(rep(1, length(stim))) - 1) / (length(stim) - 1)
}

rft.prediction <- function(stim, w)
{
  (w * range.pred(stim)) + ((1-w) * rank.pred(stim))
}

get.rft <- function(stimuli, w) {
  rft.prediction(stimuli, w)
}

