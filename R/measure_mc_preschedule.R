source("make-data.R")
source("functions.R")

registerDoParallel()

mcoptions <- list(preschedule = TRUE)

res <- grid_search(measure_cor, 1:(detectCores() + 2),
                   block_sizes(ncol(series), 20), 5, setup_mc,
                   .options.multicore = mcoptions)

saveRDS(res, "../output/measure_foreach_mc_preschedule.rds")
