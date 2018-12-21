## specify packages to be loaded during analysis
packages <- c("tidyverse", "spotifyr", "highcharter", "ggthemes", "htmltools", "viridis")

## verify which packages needs to be additionally installed
to_install <- packages[!(packages %in% rownames(installed.packages()))]

## install packages
invisible(sapply(to_install, install.packages))

## load packages
invisible(sapply(packages, library, character.only = TRUE))

## clean up
rm(packages); rm(to_install)

thm <- hc_theme_merge(
  hc_theme_elementary(),
  hc_theme(
    chart = list(zoomType = "xy", style = 
                   list(fontFamily = "Open Sans, Arial, sans-serif")),
    title = list(style = 
                   list(fontWeight = "bold",
                        fontFamily = "Open Sans")),
    subtitle = list(style = 
                      list(fontFamily = "Open Sans")),
    legend = list(align = "right",
                  verticalAlign = "middle",
                  layout = "vertical",
                  itemStyle = 
                    list(width = 150, 
                         fontWeight = "bold",
                         fontFamily = "Open Sans")),
    xAxis = list(gridLineWidth = 1,
                 startOnTick = T,
                 title = list( style = list(fontWeight = "bold"))),
    yAxis = list(title = list( style = list(fontWeight = "bold")),
                 gridLineWidth = 1,
                 startOnTick = T)
  )
)