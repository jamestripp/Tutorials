# Baysian parameter estimation

The use of Bayesian estimation in psychology is a recent development.
However, Bayesian methods are widely used in other areas of science, as
Wagenmaker points out [here](http://www.ejwagenmakers.com/papers.html). Increasingly, Bayesian
methods are superseding maximum likelihood estimation.

Why use Bayesian methods? Well, the answer is rather simple.

In Bayesian methods we define our uncertainly with parameters using a
prior distribution. For instance, we might assume that all parameter
values are equally likely. Then we update these distributions using the
data. We can then examine the updated posterior distribution to find out
how likely values are given our data.

1. We gain an honest measure of uncertainty in our estimates. For instance, one parameter value might be only slightly more probable then all of the other possibilities, or one parameter value may be considerable more likely than all of the others. Conclusions based on the latter are more convincing and informative than the former.
2. We can insert our past experience into the model fit. If there are 100 previous studies telling us that parameter *w* equals 0.5 then we can use a prior where 0.5 is the most likely value. The posterior distributions tell use, when the previous findings are considered, what our data tells us about w.

# Files

In this folder we have three examples of Bayesian parameter estimation.

1. Bayesian_estimation_rft.R generates data from the range frequency model and then fits a bayesian model to the data using JAGS.
2. Bayesian_estimation.py also generates data from the range frequency model but this time uses pymcmc to fit the model to the data.
3. Hierarchical_bayes_rft.r generates data from several simulated participants. Unlike the other two examples, the participant parameter is taken from a group level distribution (i.e., their compromise between range and rank is similar). Hierarchical estimation assumes that there is a group level distribution. See [this](http://www.ejwagenmakers.com/2011/NilssonEtAl2011.pdf) paper for a nice example.  

There is more information about each example in the files above. If you have any questions then feel free to contact me on james.tripp@warwick.ac.uk
