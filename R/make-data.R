source("libraries.R")

rows <- 1000
cols <- 10000
series <- apply(matrix(rnorm(rows * cols), rows, cols), 2, cumsum)


# TODO example graph autoplot(zoo(series[,1:5]), facet=NULL)
