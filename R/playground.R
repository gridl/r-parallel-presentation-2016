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


measure_foreach <- function(cores, block_size) {
  options(cores = cores)
  par_cor(series, block_size)
}

res <- grid_search(measure_foreach, 2:detectCores(), block_sizes(ncol(series)))
