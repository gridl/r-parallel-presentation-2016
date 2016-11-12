source('libraries.R')

par_cor <- function(d, split = 1) {
  n <- ncol(d)
  g <- ceiling(n / split)
  part <- (g * (i - 1)) : min(n, g * i)
  rl <- mclapply(combn(n, 2, simplify = FALSE), function(ij) {
    i <- ij[1]
    j <- ij[2]
    x2 <- d[, i]
    y2 <- d[, j]
    cr <- cor(x2, y2)
    list(i, j, cr)
  })
  r <- matrix(0, nrow = n, ncol = n)
  for (ijc in rl) r[ijc[[1]], ijc[[2]]] <- ijc[[3]]
  r + t(r) + diag(n)
}
