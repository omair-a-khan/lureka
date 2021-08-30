source("R/setup.R")
source("R/shiny_ui_eligibility.R")
source("R/shiny_server_eligibility.R")

shinyApp(ui = ui, server = server)
