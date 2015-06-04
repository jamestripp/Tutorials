#generic functions
rep.row = function(x, n)
{
  matrix(rep(x, each = n), nrow = n)
}

rep.col = function(x, n)
{
  matrix(rep(x, each = n), ncol = n, byrow = TRUE)
}

#generic sdbs functions
sdbs.calculate.distance <- function(stimuli)
{
  n = length(stimuli)
  abs(rep.row(stimuli, n) - t(rep.row(stimuli, n)))
}

sdbs.calculate.similarity <- function(distance, confusability)
{
  similarity = exp(distance * ((-1) * confusability))
  similarity
}

sdbs.calculate.discriminability <- function(similarity)
{
  discrim <- similarity / rep.col(rowSums(similarity,1), nrow(similarity))
  discrim
}

sdbs.calculate.threshold <- function(discriminability, slope, threshold)
{
  1 / (1 + exp (-slope * (discriminability - threshold)))
}

sdbs.calculate.overall <- function(thresholded_probability)
{ 
  1 - apply(1 - thresholded_probability, 1, prod)
}

sdbs.predictions.simple <- function(stim, c, s, t)
{
  sdbs.calculate.overall(sdbs.calculate.threshold(sdbs.calculate.discriminability(sdbs.calculate.similarity(sdbs.calculate.distance(stim), c)), s, t))
}

sdbs.predictions.dbs <- function(recall.probability)
{
    sum_lower <- c(0, cumsum(recall.probability))
    sum_lower <- sum_lower[1:(length(sum_lower) - 1)]
    sum_higher <- c(rev(cumsum(rev(recall.probability))), 0)
    sum_higher <- sum_higher[2:length(sum_higher)] 
    sdbs <- sum_lower / (sum_lower + sum_higher)# +.000000001) #added constant to prevent NaN from 0/0
    sdbs[is.nan(sdbs)] <- 0 #turn NaN values into zero. This should prevent error
    sdbs
}

get.sdbs.discriminability <- function(stimuli, c, s) {
  sdbs.predictions.simple(stimuli, c, s, t = 0.5)
}

get.sdbs.prediction <- function(discriminability) {
  sdbs.predictions.dbs(discriminability)
}