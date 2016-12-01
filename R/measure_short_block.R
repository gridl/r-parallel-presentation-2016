source("make-data.R")
source("functions.R")

cluster <- makePSOCKcluster(1)
registerDoParallel(cluster)

par_cor(series, 20)

stopCluster(cluster)
