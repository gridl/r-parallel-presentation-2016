source("make-data.R")
source("functions.R")

object_size(series)

system.time(cor(series))

system.time(cor(series[, 1:100]))

options(mc.cores = 1)
system.time(par_cor(series[, 1:100], 10))

options(mc.cores = 2)
system.time(par_cor(series[, 1:100], 10))

options(mc.cores = 4)
system.time(par_cor(series[, 1:100], 10))

all.equal(cor(series[, 1:100]), par_cor(series[, 1:100], 10))

cor(series[, 1:100])[1,1] - cor(series[,1], series[,1])
.Machine$double.eps

profvis({ cor(series[, 1:100]) })

profvis({ par_cor(series[, 1:100], 10) })
