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

registerDoParallel() # remember not to set cores there to override later

setup_mc <- function(cores) {
  options(cores = cores)
}

res <- grid_search(measure_cor, 1:(detectCores() + 2),
                   block_sizes(ncol(series), 20), 5, setup_mc)

res <- grid_search(measure_cor, c(4, 8), c(50, 100, 175), 3, setup_mc)
saveRDS(res, "../output/measure_foreach_mc.rds")
  
head(res[order(res$q50),])

qplot(data = res[res$cores == 8,], x = block_size, y = q50)
qplot(data = res[res$block_size == 140,], x = cores, y = q50)

setup_psock <- function(cores) {
  cluster <- makePSOCKcluster(cores)
  registerDoParallel(cluster)
  cluster
}

teardown_psock <- function(cluster) {
  stopCluster(cluster)
}

res <- grid_search(measure_cor, c(4, 8), c(50, 100, 175), 3, setup_psock, teardown_psock)
saveRDS(res, "../output/measure_foreach_psock.rds")
