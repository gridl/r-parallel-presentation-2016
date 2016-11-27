source("make-data.R")
source("functions.R")

object_size(series)

# WAT slowdown slide
system.time(cor(series))

registerDoParallel(1)
system.time(par_cor(series))

system.time(cor(series, series))

# WAT different results
all.equal(cor(series), par_cor(series), tolerance = 0)

all.equal(cor(series), cor(series, series), tolerance = 0)

.Machine$double.eps

profvis({ par_cor(series) })

# available block sizes
sort(sapply(unique(powerSet(as.integer(factorize(1500)))), prod))

# TODO grid search to find optimal cores, block size


profvis({ par_cor(series, 1500) })

registerDoParallel(4)
system.time(par_cor(series))
