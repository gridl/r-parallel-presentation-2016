source("make-data.R")
source("functions.R")
source("theme.R")

image_device("series")
print(autoplot(zoo(series[,1:5]), facet=NULL) + tm + theme_no_labels + theme(legend.position = "none"))
dev.off()

mc <- readRDS("../output/measure_foreach_mc.rds")

image_device("mc_cores")
ggplot(data = mc[mc$block_size %in% c(100, 140, 175, 350),], aes(x = cores, y = q50, color = factor(block_size))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100)) + scale_x_continuous(breaks = mc$cores) + labs(y = "time (s)", color = "block_size") + tm
dev.off()

image_device("mc_block_size")
ggplot(data = mc[mc$cores %in% c(1, 2, 7, 8, 9),], aes(x = block_size, y = q50, color = factor(cores))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100)) + labs(y = "time (s)", color = "cores") + tm
dev.off()

psock <- readRDS("../output/measure_foreach_psock.rds")

image_device("psock_cores")
ggplot(data = psock[psock$block_size %in% c(70, 100, 140, 350),], aes(x = cores, y = q50, color = factor(block_size))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100)) + scale_x_continuous(breaks = psock$cores) + labs(y = "time (s)", color = "block_size") + tm
dev.off()

image_device("psock_block_size")
ggplot(data = psock[psock$cores %in% c(1, 2, 4, 5),], aes(x = block_size, y = q50, color = factor(cores))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100)) + labs(y = "time (s)", color = "cores") + tm
dev.off()

psock_small <- readRDS("../output/measure_foreach_psock_small.rds")

image_device("psock_small_block_size")
ggplot(data = psock_small, aes(x = block_size, y = q50, color = factor(cores))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100)) + labs(y = "time (s)", color = "cores") + tm
dev.off()

psock_preschedule_small <- readRDS("../output/measure_foreach_psock_small_preschedule.rds")

image_device("psock_preschedule_small_block_size")
ggplot(data = psock_preschedule_small, aes(x = block_size, y = q50, color = factor(cores))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100)) + labs(y = "time (s)", color = "cores") + tm
dev.off()

psock_preschedule <- readRDS("../output/measure_foreach_psock_preschedule.rds")

image_device("psock_preschedule_block_size")
ggplot(data = psock_preschedule[psock_preschedule$cores %in% c(1, 2, 4, 5),], aes(x = block_size, y = q50, color = factor(cores))) + geom_point() + geom_line() + geom_linerange(aes(ymin = q0, ymax = q100)) + labs(y = "time (s)", color = "cores") + tm
dev.off()
