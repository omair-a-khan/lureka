library(shiny)

shinyUI(
  basicPage(
    titlePanel("Lureka: VMAP Neuropsychological Assessment Summary Sheet Generator"),
    selectInput("epoch", "Epoch:", c(2:5)),
    selectInput("map_id", "MAP ID:", formatC(1:336, width = 3, flag = "0")),
    downloadButton('report', label = "Generate Report")
  )
)
