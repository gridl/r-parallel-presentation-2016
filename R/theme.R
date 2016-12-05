image_width <- 16
image_height <- 10

font_size <- 40

tm <- theme_bw(base_size = font_size) +
  theme(panel.border = element_blank(), 
        plot.margin = unit(c(1, 0, 1, 0), "lines"))

theme_no_labels <-
    theme(axis.text.x = element_blank(), axis.title.x = element_blank(),
          axis.ticks.x = element_blank(), axis.text.y = element_blank(),
          axis.title.y = element_blank(), axis.ticks.y = element_blank())
