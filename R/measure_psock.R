source("make-data.R")
source("functions.R")

setup_psock <- function(cores) {
  cluster <- makePSOCKcluster(cores)
  registerDoParallel(cluster)
  cluster
}

teardown_psock <- function(cluster) {
  stopCluster(cluster)
}

res <- grid_search(measure_cor, 1:(detectCores() + 2),
                   block_sizes(ncol(series), 20), 5,
                   setup_psock, teardown_psock)

saveRDS(res, "../output/measure_foreach_psock.rds")
