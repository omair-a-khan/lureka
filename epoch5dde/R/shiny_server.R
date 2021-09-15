server <- shinyServer(
  function(input, output, session) {
    # =========================================================================
    # create reactive data
    
    reac_specific_data.df <- reactive({
      data.df <- complete_epoch5dde_data.df[complete_epoch5dde_data.df$map_id %in% input$map_id, ]
      return(data.df)
    })
    
    # =========================================================================
    # update MAP ID choices for selectInput("map_id", ...)
    
    map_id_in_input = reactive({
      return(complete_epoch5dde_data.df[, "map_id"])
    })
    
    observe({
      updateSelectInput(session, "map_id", choices = map_id_in_input())
    })
    
    # =========================================================================
    # generate tables for summary sheet
    
    reac_tables.list <- reactive({
      tables.list <- generate_tables(reac_specific_data.df())
      return(tables.list)
    })
    
    output$metadata.df <- function(){
      reac_tables.list()[["metadata.df"]] %>%
        knitr::kable(., align = 'll') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$metadata_wide.df <- function(){
      reac_tables.list()[["metadata_wide.df"]] %>%
        knitr::kable(., align = 'ccccc', col.names = NULL, table.attr = "style='width:90%;'") %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed")) %>%
        row_spec(c(1, 3), bold = T)
    }
    
    output$moca.df <- function(){
      reac_tables.list()[["moca.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed")) %>%
        column_spec(
          1:3, 
          color = replace_na(ifelse(reac_tables.list()[["moca.df"]]$interpretation == "Impaired", "red", "black"), "black"),
          italic = replace_na(ifelse(reac_tables.list()[["moca.df"]]$interpretation == "Impaired", TRUE, FALSE), FALSE)
        )
    }
    
    output$cvlt.df <- function(){
      reac_tables.list()[["cvlt.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed")) %>%
        column_spec(
          1:3, 
          color = replace_na(ifelse(reac_tables.list()[["cvlt.df"]]$scaled_score <= -1.5, "red", "black"), "black"),
          italic = replace_na(ifelse(reac_tables.list()[["cvlt.df"]]$scaled_score <= -1.5, TRUE, FALSE), FALSE)
        )
    }
    
    output$biber.df <- function(){
      reac_tables.list()[["biber.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed")) %>%
        column_spec(
          1:3, 
          color = replace_na(ifelse(c(reac_tables.list()[["biber.df"]]$scaled_score[1:9] <= -1.5, rep(FALSE, 4)), "red", "black"), "black"),
          italic = replace_na(ifelse(c(reac_tables.list()[["biber.df"]]$scaled_score[1:9] <= -1.5, rep(FALSE, 4)), TRUE, FALSE), FALSE)
        )
    }
    
    output$bnt.df <- function(){
      reac_tables.list()[["bnt.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed")) %>%
        column_spec(
          1:3, 
          color = replace_na(ifelse(reac_tables.list()[["bnt.df"]]$scaled_score <= -1.5, "red", "black"), "black"),
          italic = replace_na(ifelse(reac_tables.list()[["bnt.df"]]$scaled_score <= -1.5, TRUE, FALSE), FALSE)
        )
    }
    
    output$animals.df <- function(){
      reac_tables.list()[["animals.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed")) %>%
        column_spec(
          1:3, 
          color = replace_na(ifelse(reac_tables.list()[["animals.df"]]$scaled_score <= 35, "red", "black"), "black"),
          italic = replace_na(ifelse(reac_tables.list()[["animals.df"]]$scaled_score <= 35, TRUE, FALSE), FALSE)
        )
    }
    
    output$gds.df <- function(){
      reac_tables.list()[["gds.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed")) %>%
        column_spec(
          1:3, 
          color = replace_na(ifelse(reac_tables.list()[["gds.df"]]$score >= 10, "red", "black"), "black"),
          italic = replace_na(ifelse(reac_tables.list()[["gds.df"]]$score >= 10, TRUE, FALSE), FALSE)
        )
    }
    
    output$hvot.df <- function(){
      reac_tables.list()[["hvot.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed")) %>%
        column_spec(
          1:3, 
          color = replace_na(ifelse(reac_tables.list()[["hvot.df"]]$scaled_score >= 65, "red", "black"), "black"),
          italic = replace_na(ifelse(reac_tables.list()[["hvot.df"]]$scaled_score >= 65, TRUE, FALSE), FALSE)
        )
    }
    
    output$dkefs_trail.df <- function(){
      reac_tables.list()[["dkefs_trail.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$dkefs_color.df <- function(){
      reac_tables.list()[["dkefs_color.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$cowa.df <- function(){
      reac_tables.list()[["cowa.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$tower.df <- function(){
      reac_tables.list()[["tower.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$digit_symbol.df <- function(){
      reac_tables.list()[["digit_symbol.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$mc1.df <- function(){
      reac_tables.list()[["mc1.df"]] %>%
        knitr::kable(., digits = 2, align = 'lrrrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$mc2.df <- function(){
      reac_tables.list()[["mc2.df"]] %>%
        knitr::kable(., digits = 2, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$symbol_span.df <- function(){
      reac_tables.list()[["symbol_span.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    # generate np_notes
    
    output$np_notes.str <- function(){
      reac_specific_data.df()$np_notes
    }
    
    # =========================================================================
    # generate downloadable summary sheet
    
    output$report <- downloadHandler(
      filename = function() {
        glue::glue("summary_sheet_epoch_{input$epoch}_map_{input$map_id}.html")
      },
      content = function(file) {
        # Copy the report file to a temporary directory before processing it, in
        # case we don't have write permissions to the current working dir
        tempReport <- file.path(tempdir(), "summary_sheet.Rmd")
        file.copy("summary_sheet.Rmd", tempReport, overwrite = TRUE)
        
        # Set up parameters to pass to Rmd document
        params <- list(
          epoch = input$epoch,
          map_id = input$map_id
        )
        
        # Knit the document, passing in the `params` list, and eval it in a
        # child of the global environment (this isolates the code in the document
        # from the code in this app).
        rmarkdown::render(
          input = tempReport, 
          output_file = file,
          params = params,
          envir = new.env(parent = globalenv())
        )
      }
    )
  }
)
