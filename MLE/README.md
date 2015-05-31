# Maximum likelihood estimation

People in research often use mathematical models. For example, linear
regression where one variable is predicted using another, or cognitive
models where stimuli values are altered into predicted responses. These
models have numbers which can be changed which are called parameters.

Maximum likelihood estimation - a nice tutorial is [here](http://css-kti.tugraz.at/research/cssarchive/courses/mathpsy/pkst04/material/TutOnLikelihood.pdf) - is a method for finding the parameters
which minimize the difference between the predictions of the model 
data.

The code in this folder shows how one can use maximum likelihood estimation 
in three programming languages: MATLAB, R and Python. In my experience, these 
languages are most common in cognitive Psychology.

The functionality for each file is as follows:

1. Parameters are set. These are the parameters we want MLE to find.
2. Functions for the range frequency model are defined. For more details about the model see the [wikipedia entry](http://en.wikipedia.org/wiki/Range-Frequency_Theory)
3. Sample data are generated from the range frequency model. We simulate participants 
by drawing samples from a normal (Gaussian) distribution. The mean of the distribution is 
the prediction of the model
4. A function is defined which takes parameters and returns the negative log likelihood of the 
data given the model. In this case the parameters are w and sd
5. A function minimisation algorithm is called which cycles through parameters, calling the function defined in step 4 for each set, and finds the parameters which give us the smallest negative log likelihood.
