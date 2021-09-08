source("eligibility/R/setup.R")
source("eligibility/R/shiny_ui.R")
source("eligibility/R/shiny_server.R")

shinyApp(ui = ui, server = server)
