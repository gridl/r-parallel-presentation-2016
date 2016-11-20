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
  blocks <- mclapply(1:nrow(combs), function(i) {
    ca <- splits[[combs[i, 1]]]
    cb <- splits[[combs[i, 2]]]
    list(ca, cb, cor(d[, ca], d[, cb]))
  })
  res <- matrix(0, nrow = n, ncol = n)
  for(block in blocks) {
    res[block[[1]], block[[2]]] <- block[[3]]
    res[block[[2]], block[[1]]] <- t(block[[3]])
  }
  res
}
