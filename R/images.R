source("make-data.R")
source("functions.R")
source("theme.R")

image_device("series")
print(autoplot(zoo(series[,1:5]), facet=NULL) + tm + theme_no_labels + theme(legend.position = "none"))
dev.off()
