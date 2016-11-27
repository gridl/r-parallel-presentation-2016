source("make-data.R")
source("functions.R")

object_size(series)

# TODO example graph autoplot(zoo(series[,1:5]), facet=NULL)

# WAT slowdown slide
system.time(cor(series))

registerDoParallel() # remember not to set cores there to override later
options(cores = 1)
system.time(par_cor(series, ncol(series)))

system.time(cor(series, series))

# WAT different results
all.equal(cor(series), par_cor(series), tolerance = 0)

all.equal(cor(series), cor(series, series), tolerance = 0)

.Machine$double.eps

profvis({ par_cor(series) })

# TODO grid search to find optimal cores, block size


profvis({ par_cor(series, ncol(series)) })

head(res[order(res$q50),])

qplot(data = res[res$cores == 8,], x = block_size, y = q50)
qplot(data = res[res$block_size == 140,], x = cores, y = q50)

## R CMD BATCH --no-save --no-restore measure_mc.R
