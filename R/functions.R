source('libraries.R')

# based on https://gist.github.com/bobthecat/5024079
par_cor <- function(d, block_size = 100) {
  n <- ncol(d)
  if (n %% block_size != 0) {
    stop("Choose different 'block_size' so that ncol(x) %% block_size = 0!")
  }
  nblocks <- n / block_size
  splits <- split(1:n, rep(1:nblocks, each = block_size))
  combs <- unique(t(apply(expand.grid(1:nblocks, 1:nblocks), 1, sort)))
  blocks <- foreach(i = 1:nrow(combs)) %dopar% {
    ca <- splits[[combs[i, 1]]]
    cb <- splits[[combs[i, 2]]]
    d_a <- d[, ca]
    d_b <- d[, cb]
    list(ca, cb, cor(d_a, d_b))
  }
  res <- matrix(0, nrow = n, ncol = n)
  for(block in blocks) {
    ca <- block[[1]]
    cb <- block[[2]]
    res[ca, cb] <- block[[3]]
    res[cb, ca] <- t(block[[3]])
  }
  res
}

block_sizes <- function(n, min_size = 50) {
  bs <- sort(sapply(unique(powerSet(as.integer(factorize(n)))), prod))
  bs[bs >= min_size & bs < n]
}

print_df <- function(x) {
  x <- as.list(x)
  cat(sprintf("%s = %s", names(x), x), "\n", sep = ", ")
}

grid_search <- function(measure, cores, block_sizes, times = 3,
                        setup = function(cores) {NULL},
                        teardown = function(cluster) {NULL}) {
  mdply(
    expand.grid(cores = cores, block_size = block_sizes),
    function(cores, block_size) {
      cl <- setup(cores)
      q <- quantile(benchmark(measure(cores, block_size), times = times)$time,
                    c(0, 0.5, 1))
      teardown(cl)
      r <- data.frame(cores = cores, block_size = block_size,
                      q0 = q[1], q50 = q[2], q100 = q[3])
      print_df(r)
      r
    })
}

measure_cor <- function(cores, block_size) {
  par_cor(series, block_size)
}
