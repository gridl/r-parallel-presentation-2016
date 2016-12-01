source("make-data.R")
source("functions.R")

snow_options <- list(preschedule = TRUE)

res <- grid_search(measure_cor, c(1, 2, 4),
                   c(4, 5, 7, 10, 14, 20, 25, 35, 50), 5,
                   setup_psock, teardown_psock, .options.snow = snow_options)

saveRDS(res, "../output/measure_foreach_psock_small_preschedule.rds")
