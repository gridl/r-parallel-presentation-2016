source("make-data.R")
source("functions.R")

registerDoParallel()

setup_mc <- function(cores) {
  options(cores = cores)
}

res <- grid_search(measure_cor, 1:(detectCores() + 2),
                   block_sizes(ncol(series), 20), 5, setup_mc)

saveRDS(res, "../output/measure_foreach_mc.rds")
