rm(list=ls())

library('rvest')

# Number of imdb entries we want to look at
N <- 2000

start_number <- 113000 # initial index
rating <<- rep(NA, N) # preallocate rating vector

get_rating <- function(i)
{
  # create web address
  url <- paste('http://www.imdb.com/title/tt0', as.character(start_number + i), '/', sep='')
  
  # get webpage
  url.html <- html(url)
  
  # find section with user ratings
  url.giga <- html_node(url.html, xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "giga-star", " " ))]')
  
  # convert rating to a number
  url.rating <- as.numeric(html_text(html_node(url.giga, 'div')))
  
  return(url.rating)
}

# For N entries in imdb
for (i in 1:N) {
  # use try to avoid stopping in case of errors
  r <- try(get_rating(i))
  
  # store rating if it's a number
  if (is.numeric(r)){
    rating[i] <- r
  }
}

# histogram of ratings. NAs are ignored
p <- hist(x = rating, main = 'Imdb ratings', xlab = 'User rating')
print(p)