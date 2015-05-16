% File:           MLE.m
% Version:        1
% Last changed:   Friday 15th May 2015
% Purpose:        Example MLE code for MATLAB
% Author:         Dr James Tripp
% Copyright:      (C) James Tripp 2015

% Define our stimuli
s = [1 2 3 4 7 9 11 13 16 21 18];

% Our parameters for generating data
w = 0.5;
sd = 0.01;

% Functions for calculating range and rank prediction
range = (s - min(s)) / (max(s) - min(s));
rank = (cumsum(ones(1, length(s))) - 1) /(length(s) - 1);

% Anonymous function called to return range and rank
% compromise for given value of w
rft = @(w) (w * range) + ((1 - w) * rank);

% Generate random data from normal probability function
% where mean equals model predictions and sd defined above
r = normrnd(rft(w), sd);

% Keep responses between 0 and 1
r(r<0) = 0;
r(r>1) = 1;

% Anonymous function calculating negative log likelihood
% given value of w and sd. W is transformed by logistic
% function to keep values between 0 and 1
return_lhood = @(p) sum(-2 * log(normpdf(rft((1/(1+exp(-p(1))))), r, p(2))));

% Run minimizer
result = fminsearch(return_lhood, [.5, .5]);

% Print results
sprintf('We set w as %0.5g and our estimate is %0.5g', w, 1/(1+exp(-result(1))))
sprintf('We set sd as %0.5g and our estimate is %0.5g', sd, result(2))