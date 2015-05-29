# Tutorials

These tutorials are snippets of code. The code is fully commented and the examples should be straightforward.
I have written the code so that a PhD student in Psychology, or someone with little coding experience 
can try out the methods.

## Maximum likelihood estimation (/MLE)

Cognitive psychologists often want to fit a model to data. Models take a set of inputs (e.g., stimuli presented to participants) 
and return outputs (e.g., predicted responses). Parameters are passed to the model which change the outputs.

Maximum likelihood estimation is a method for finding the parameters which produce outputs which are closest the data. We use an 
algorithm to vary the parmeter values systematically. For each paramter value our code gives the probability of the data given 
the prediction. The algorithm simply varies the parameters to maximise this probability.

Pros: Fast, simple to code

Cons: Gives us one value. We do not know how uncertain we are about that value.

## Bayesian parameter estimation (/Bayesian)

Maximum likelihood estimation gives us *the* most likely parameter (assuming it doesn't get stuck). Bayesian estimation, on the other hand, 
gives us a distribution of likely paramter values. It does this by starting with a prior distribution. Our priors are uniform, meaning we don't
 think any parameter value is more likely than another. Then an MCMC sampler goes through each distribution in turn and draws samples based 
on the data. We link the data to the sampler using a likelihood function similiar to that used in the maximum likelihood estimations.

Also, there is an example of heirarchical modeling. This method is more complicated because it assumes that individuals have a similiar set of 
parameters values. The result is that our estimate at the end uses information from each participants, but individuals are 'drawn togather' making 
estimates similiar. 

Pros: Give us parameter uncertainty. More informative.

Cons: Slow and can be tricky to code.
