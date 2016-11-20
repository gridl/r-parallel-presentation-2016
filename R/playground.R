source("make-data.R")
source("functions.R")

object_size(series)

system.time(cor(series))

system.time(cor(series[, 1:100]))

options(mc.cores = 1)
system.time(par_cor_naive(series[, 1:100]))

options(mc.cores = 2)
system.time(par_cor_naive(series[, 1:100]))

(par_cor_naive(series[, 1:10]))
(cor(series[, 1:10]))
(par_cor_block(series[, 1:10]))

all.equal(cor(series[, 1:100]), par_cor_block(series[, 1:100], 10))
all.equal(cor(series[, 1:100]), par_cor_naive(series[, 1:100]))

options(mc.cores = 1)
system.time(par_cor_block(series[, 1:100]))

options(mc.cores = 2)
system.time(par_cor_block(series[, 1:100]))

options(mc.cores = 4)
system.time(par_cor_block(series[, 1:100]))

which((cor(series[, 1:100]) - par_cor_naive(series[, 1:100])) > 0)
(cor(series[, 1:10]) - par_cor_naive(series[, 1:10]))[1:10, 1:10]

tcor <- cor(series[, 1:100])
ncor <- par_cor_naive(series[, 1:100])
bcor <- par_cor_block(series[, 1:100])
summary(as.vector(tcor - ncor))  
summary(as.vector(tcor - bcor))  
sum(as.vector(tcor - bcor) != 0)  
which((tcor - bcor) != 0, arr.ind = T)  
tcor[1,1]
bcor[1,1]
(tcor - bcor)[1,1]

cor(series[, 1:100])[1,1] - cor(series[,1], series[,1])
.Machine$double.eps

profvis({ cor(series[, 1:100]) })

profvis({ par_cor_naive(series[, 1:100]) })

profvis({ par_cor_block(series[, 1:100]) })
