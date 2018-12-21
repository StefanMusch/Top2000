
# Setup -------------------------------------------------------------------
source("R/999_get_data.R")

tooltip <- c("position", "artist_name", "track_name", "album_name", "track_popularity",
             "valence", "energy") %>%
  map(function(x){
    tags$tr(
      tags$th(str_replace_all(str_to_title(x), "_", " ")),
      tags$td(paste0("{point.", x, "}"))
    )
  }) %>% 
  do.call(tagList, .) %>% 
  as.character()

tooltip <- paste0(as.character(tagList(
  tags$tr(
    tags$th(rowspan= 8,
            tags$img(src = "{point.album_img}",
                     width = "125px",
                     height = "125px",
                     align = "middle",
                     border = "1px solid black")))
)), tooltip)

plot <- 
  highchart() %>%
  hc_add_series(data = top2000, 
                type = "scatter",
                marker = list(symbol = "circle"),
                hcaes(x = valence, y = energy, color = position)) %>%
  hc_yAxis(min = 0, max = 1,
           title = list(text = "<b>Energy</b>"),
           plotLines = list(
             list(color = "black", # Set black origin line
                  width = 2,
                  dashStyle = "ShortDashDot",
                  value = 0.5))) %>%
  hc_xAxis(min = 0, max = 1,
           title = list(text = "<b>Valence</b>"),
           plotLines = list(
             list(color = "black", # Set black origin line
                  width = 2,
                  dashStyle = "ShortDashDot",
                  value = 0.5))) %>%
  hc_plotOptions(series = list(fillOpacity = 0.5)) %>%
  hc_tooltip(
    useHTML = TRUE,
    borderRadius = 0,
    borderWidth = 5,
    headerFormat = "<table>",
    pointFormat = tooltip,
    footerFormat = "</table>"
  ) %>%
  hc_add_theme(thm) %>%
  hc_title(text = "Energy vs Valence") %>%
  hc_exporting(enabled = TRUE) %>%
  hc_add_annotation(labelOptions = list(shape = "rect"),
                    labels = list(
                      list(point = list(xAxis = 0, yAxis = 0, x =0.75 , y = 0.85),
                           text = 'Energetic & Happy'),
                      list(point = list(xAxis = 0, yAxis = 0, x =0.75 , y = 0),
                           text = 'Chill & Peaceful.'),
                      list(point = list(xAxis = 0, yAxis = 0, x =0.25 , y = 0.85),
                           text = 'Energetic & Angry'),
                      list(point = list(xAxis = 0, yAxis = 0, x =0.25 , y = 0),
                           text = 'Sad & Slow')
                    )
  )
