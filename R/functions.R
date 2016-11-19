source('libraries.R')

par_cor_naive <- function(d) {
  n <- ncol(d)
  rl <- mclapply(combn(n, 2, simplify = FALSE), function(ij) {
    i <- ij[1]
    j <- ij[2]
    cr <- cor(d[, i], d[, j])
    list(i, j, cr)
  })
  r <- matrix(0, nrow = n, ncol = n)
  for (ijc in rl) r[ijc[[1]], ijc[[2]]] <- ijc[[3]]
  r + t(r) + diag(n)
}

# based on https://gist.github.com/bobthecat/5024079
par_cor_block <- function(d, nblocks = 10) {
  n <- ncol(d)
  if (n %% nblocks != 0) {
    stop("Choose different 'nblocks' so that ncol(x) %% nblocks = 0!")
  }
  splits <- split(1:n, rep(1:nblocks, each = n / nblocks))
  nsplits <- length(splits)
  combs <- unique(t(apply(expand.grid(1:nsplits, 1:nsplits), 1 ,sort)))
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
