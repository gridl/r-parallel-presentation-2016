source("make-data.R")
source("functions.R")

object_size(series)

# TODO example graph autoplot(zoo(series[,1:5]), facet=NULL)

# WAT slowdown slide
system.time(cor(series))

registerDoParallel() # remember not to set cores there to override later
options(cores = 1)
system.time(par_cor(series, ncol(series)))

system.time(cor(series, series))

# WAT different results
identical(cor(series), par_cor(series))
all.equal(cor(series), par_cor(series), tolerance = 0)

.Machine$double.eps

all.equal(cor(series), cor(series, series), tolerance = 0)

profvis({ par_cor(series, ncol(series)) })


res <- readRDS("../output/measure_foreach_mc.rds")
res <- readRDS("../output/measure_foreach_psock.rds")

head(res[order(res$q50),])

##mc
ggplot(data = res[res$cores %in% c(1, 2, 7, 8, 9),], aes(x = block_size, y = q50, color = factor(cores))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100))

##psock
ggplot(data = res[res$cores %in% c(1, 2, 4, 5),], aes(x = block_size, y = q50, color = factor(cores))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100))


ggplot(data = res[res$block_size %in% c(70, 100, 140, 350),], aes(x = cores, y = q50, color = factor(block_size))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100))

## R CMD BATCH --no-save --no-restore measure_mc.R

cluster <- makePSOCKcluster(1)
registerDoParallel(cluster)

system.time(par_cor(series, 20))

system.time(par_cor(series, 25))

snow_options <- list(preschedule = TRUE)

system.time(par_cor(series, 20, .options.snow = snow_options))

system.time(par_cor(series, 25, .options.snow = snow_options))


stopCluster(cluster)


res <- readRDS("../output/measure_foreach_mc_small.rds")

res <- readRDS("../output/measure_foreach_psock_small.rds")
ggplot(data = res, aes(x = block_size, y = q50, color = factor(cores))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100))


library(doSNOW)
cluster <- makeCluster(1, type = "SOCK")
registerDoSNOW(cluster)

st <- snow.time(par_cor(series, 25))
st

st2 <- snow.time(par_cor(series, 20))
st2

stopCluster(cluster)
