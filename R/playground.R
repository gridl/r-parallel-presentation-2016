source("functions.R")

object_size(series)

system.time(cor(series))

options(mc.cores = 1)

system.time(par_cor(series[, 1:100]))
system.time(cor(series[, 1:100]))

(par_cor(series[, 1:10]))
(cor(series[, 1:10]))
