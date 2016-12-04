source("make-data.R")
source("functions.R")

registerDoParallel()

options(cores = 9)
mcoptions <- list(preschedule = TRUE)
system.time(par_cor(series, 175, .options.multicore = mcoptions))
