source("make-data.R")
source("functions.R")

registerDoParallel()

res <- grid_search(measure_cor, c(1, 2, 4),
                   c(1, 2, 4, 5, 7, 10, 14, 20, 25, 35, 50), 5, setup_mc)

saveRDS(res, "../output/measure_foreach_mc_small.rds")
