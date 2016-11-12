source("libraries.R")

# 360Mb, 66s cor on rugged
rows <- 30000
cols <- 1500
series <- apply(matrix(rnorm(rows * cols), rows, cols), 2, cumsum)


# TODO example graph autoplot(zoo(series[,1:5]), facet=NULL)
