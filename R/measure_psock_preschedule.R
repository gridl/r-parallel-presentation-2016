source("make-data.R")
source("functions.R")

snow_options <- list(preschedule = TRUE)

res <- grid_search(measure_cor, 1:(detectCores() + 2),
                   block_sizes(ncol(series), 20), 5,
                   setup_psock, teardown_psock, .options.snow = snow_options)

saveRDS(res, "../output/measure_foreach_psock_preschedule.rds")
