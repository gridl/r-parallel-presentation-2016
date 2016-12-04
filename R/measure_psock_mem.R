source("make-data.R")
source("functions.R")

cluster <- makePSOCKcluster(4)
registerDoParallel(cluster)
snow_options <- list(preschedule = TRUE)
system.time(par_cor(series, 140, .options.snow = snow_options))
stopCluster(cluster)
