source("make-data.R")
source("functions.R")

res <- grid_search(measure_cor, c(1, 2, 4), c(4, 5, 7, 10, 14, 20, 25), 5,
                   setup_psock, teardown_psock)

saveRDS(res, "../output/measure_foreach_psock_small.rds")
