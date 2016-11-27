source("libraries.R")

# 360Mb, 66s cor on rugged
rows <- 30000
cols <- 700
series <- apply(matrix(rnorm(rows * cols), rows, cols), 2, cumsum)
