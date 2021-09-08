plotly_hline <- function(y = 0, color = "grey", dash = "dash", opacity = 0.5) {
  list(
    type = "line", 
    xref = "paper",
    x0 = 0, 
    x1 = 1, 
    y0 = y, 
    y1 = y, 
    line = list(color = color, dash = dash),
    opacity = opacity
  )
}

plotly_vline <- function(x = 0, color = "grey", dash = "dash", opacity = 0.5) {
  list(
    type = "line", 
    yref = "paper",
    x0 = x, 
    x1 = x, 
    y0 = 0, 
    y1 = 1, 
    line = list(color = color, dash = dash),
    opacity = opacity
  )
}
