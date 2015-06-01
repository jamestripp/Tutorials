# Web scraping

The internet is a useful source of information. One way to get this information is to write code which downloads webpage and stores some relevelevent information. We 'scrape' the information of the web.

# Files

1. scrape_imdb_rating.R uses the 'rvest' library to download pages starting from a particular film. In each page it records the user rating. Then a histogram ('imdb_rating.pdf') is created showing the that the rating are negatively skewed, so high ratings are more common (i.e., people are actually rather nice).
