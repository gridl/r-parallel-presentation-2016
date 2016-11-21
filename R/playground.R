source("make-data.R")
source("functions.R")

object_size(series)

system.time(cor(series))
system.time(cor(series, series))

options(mc.cores = 1)
system.time(par_cor(series))

options(mc.cores = 2)
system.time(par_cor(series))

options(mc.cores = 4)
system.time(par_cor(series))

all.equal(cor(series), par_cor(series), tolerance = 0)

all.equal(cor(series), cor(series, series), tolerance = 0)

all.equal(cor(series[, 1:100]), par_cor(series[, 1:100], 50), tolerance = 0)

cor(series[, 1:100])[1,1] - cor(series[,1], series[,1])
.Machine$double.eps

profvis({ cor(series) })

profvis({ par_cor(series) })

# available block sizes
sort(sapply(unique(powerSet(as.integer(factorize(1500)))), prod))

# TODO grid search to find optimal cores, block size


options(mc.cores = 1)
Rprof(filename = "../output/par_cor.rprof", interval = 0.001, line.profiling = T)
cr <- par_cor(series, 1500)
Rprof(NULL)

summaryRprof(filename = "../output/par_cor.rprof", lines = "both")

profvis({ par_cor(series, 1500) })
