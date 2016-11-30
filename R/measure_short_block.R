source("make-data.R")
source("functions.R")

## perf record -F 999 --call-graph dwarf -o fast.data -a -m 512M -- R CMD BATCH --no-save --no-restore measure_short_block.R

cluster <- makePSOCKcluster(1)
registerDoParallel(cluster)

par_cor(series, 20)

stopCluster(cluster)
