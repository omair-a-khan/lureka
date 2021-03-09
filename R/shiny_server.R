server <- shinyServer(
  function(input, output, session) {
    # =========================================================================
    # create reactive data
    
    reac_participant_data.df <- reactive({
      data.df <- complete_np_data.df[complete_np_data.df$map_id %in% input$map_id, ]
      return(data.df)
    })
    
    reac_specific_data.df <- reactive({
      data.df <- reac_participant_data.df()[reac_participant_data.df()$epoch %in% input$epoch, ]
      return(data.df)
    })
    
    # create reactive data for plots
    
    reac_plot_cvlt.df <- reactive({
      data.df <- reac_participant_data.df()
      
      cvlt.df <- pivot_longer(data.df[, c("map_id", "epoch", cvlt.var)], !c("map_id", "epoch"))
      cvlt2.df <- pivot_longer(data.df[, c("map_id", "epoch", cvlt.unscaled.var)], !c("map_id", "epoch"), names_to = "unscaled_name", values_to = "unscaled_values")
      
      cvlt.df <- cbind(cvlt.df, cvlt2.df[, 3:4])
      cvlt.df <- left_join(cvlt.df, data.frame(name = cvlt.var, displayname = cvlt.names), by = "name")
      
      cvlt.df$txt <- glue::glue("Epoch {cvlt.df$epoch}<br>{cvlt.df$displayname}<br>Score: {cvlt.df$unscaled_values}<br>Z = {sprintf('%.2f', cvlt.df$value)}")
      cvlt.df$epoch <- factor(cvlt.df$epoch)
      cvlt.df$name <- factor(cvlt.df$name, levels = cvlt.var)
      cvlt.df$displayname <- factor(cvlt.df$displayname, levels = cvlt.names)
      
      return(cvlt.df)
    })
    
    reac_plot_biber.df <- reactive({
      data.df <- reac_participant_data.df()
      
      biber.df <- pivot_longer(data.df[, c("map_id", "epoch", biber.var)], !c("map_id", "epoch"))
      biber2.df <- pivot_longer(data.df[, c("map_id", "epoch", biber.unscaled.var)], !c("map_id", "epoch"), names_to = "unscaled_name", values_to = "unscaled_values")
      
      biber.df <- cbind(biber.df, biber2.df[, 3:4])
      biber.df <- left_join(biber.df, data.frame(name = biber.var, displayname = biber.names), by = "name")
      
      biber.df$txt <- glue::glue("Epoch {biber.df$epoch}<br>{biber.df$displayname}<br>Score: {biber.df$unscaled_values}<br>Z = {sprintf('%.2f', biber.df$value)}")
      biber.df$epoch <- factor(biber.df$epoch)
      biber.df$name <- factor(biber.df$name, levels = biber.var)
      biber.df$displayname <- factor(biber.df$displayname, levels = biber.names)
      
      return(biber.df)
    })
    
    reac_plot_biber_recognition.df <- reactive({
      data.df <- reac_participant_data.df()
      
      biber.df <- pivot_longer(data.df[, c("map_id", "epoch", biber_recognition.var)], !c("map_id", "epoch"))
      biber.df <- left_join(biber.df, data.frame(name = biber_recognition.var, displayname = biber_recognition.names), by = "name")
      
      biber.df$txt <- glue::glue("Epoch {biber.df$epoch}<br>{biber.df$displayname}<br>Value: {biber.df$value}")
      biber.df$epoch <- factor(biber.df$epoch)
      biber.df$name <- factor(biber.df$name, levels = biber_recognition.var)
      biber.df$displayname <- factor(biber.df$displayname, levels = biber_recognition.names)
      
      return(biber.df)
    })
    
    # =========================================================================
    # update MAP ID choices for selectInput("map_id", ...)
    
    map_id_in_input = reactive({
      return(complete_np_data.df[complete_np_data.df$epoch %in% input$epoch, "map_id"])
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
    # create plots
    
    # dot plots
    
    output$cvlt_dot.plot <- renderPlotly({
      data.df <- reac_plot_cvlt.df() %>% na.omit()
      
      data.df$bold_epoch <- glue::glue("<b>{data.df$epoch}</b>")
      
      p <- data.df %>%
        plot_ly(
          data = .,
          type = "scatter",
          mode = "text",
          y = ~displayname,
          x = ~value,
          color = ~factor(epoch, levels = 1:5),
          colors = RColorBrewer::brewer.pal(4, "Spectral"),
          text = ~bold_epoch,
          hovertemplate = ~txt
        ) %>%
        layout(
          font = list(size = 14),
          xaxis = list(
            title = "Z-Score",
            zeroline = T,
            showticklabels = T,
            range = c(-5.8, 5.8)
          ),
          yaxis = list(
            title = "",
            zeroline = F,
            showticklabels = T,
            categoryorder = "array",
            categoryarray = rev(cvlt.names)
          ),
          shapes = list(plotly_vline(x = -1.5, dash = "dash"), plotly_vline(x = 1.5, dash = "dash"))
        )
      
      return(p)
    })
    
    output$biber_dot.plot <- renderPlotly({
      data.df <- reac_plot_biber.df() %>% na.omit()
      
      data.df$bold_epoch <- glue::glue("<b>{data.df$epoch}</b>")
      
      p <- data.df %>%
        plot_ly(
          data = .,
          type = "scatter",
          mode = "text",
          y = ~displayname,
          x = ~value,
          color = ~factor(epoch, levels = 1:5),
          colors = RColorBrewer::brewer.pal(4, "Spectral"),
          text = ~bold_epoch,
          hovertemplate = ~txt
        ) %>%
        layout(
          font = list(size = 14),
          xaxis = list(
            title = "Z-Score",
            zeroline = T,
            showticklabels = T,
            range = c(-5.8, 5.8)
          ),
          yaxis = list(
            title = "",
            zeroline = F,
            showticklabels = T,
            categoryorder = "array",
            categoryarray = rev(biber.names)
          ),
          shapes = list(plotly_vline(x = -1.5, dash = "dash"), plotly_vline(x = 1.5, dash = "dash"))
        )
      
      return(p)
    })
    
    # line plots: CVLT
    
    output$cvlt_line_learning.plot <- renderPlotly({
      data.df <- reac_plot_cvlt.df() %>% 
        filter(
          name %in% cvlt_learning.var
        ) %>%
        na.omit()
      
      p <- data.df %>%
        plot_ly(
          data = .,
          type = "scatter",
          mode = "lines+markers",
          y = ~value,
          x = ~factor(epoch, levels = 1:5),
          color = ~factor(displayname, levels = cvlt_learning.names),
          colors = RColorBrewer::brewer.pal(8, "Spectral"),
          hovertemplate = ~txt
        ) %>%
        layout(
          xaxis = list(
            title = "Epoch",
            zeroline = F,
            showticklabels = T,
            range = c(1, 5)
          ),
          yaxis = list(
            title = "Z-Score",
            zeroline = T,
            showticklabels = T,
            range = c(-5.8, 5.8)
          ),
          shapes = list(plotly_hline(-1.5, dash = "dash"))
        )
      
      return(p)
    })
    
    output$cvlt_line_recall.plot <- renderPlotly({
      data.df <- reac_plot_cvlt.df() %>% 
        filter(
          name %in% cvlt_recall.var
        ) %>%
        na.omit()
      
      p <- data.df %>%
        plot_ly(
          data = .,
          type = "scatter",
          mode = "lines+markers",
          y = ~value,
          x = ~factor(epoch, levels = 1:5),
          color = ~factor(displayname, levels = cvlt_recall.names),
          colors = RColorBrewer::brewer.pal(8, "Spectral"),
          hovertemplate = ~txt
        ) %>%
        layout(
          xaxis = list(
            title = "Epoch",
            zeroline = F,
            showticklabels = T,
            range = c(1, 5)
          ),
          yaxis = list(
            title = "Z-Score",
            zeroline = T,
            showticklabels = T,
            range = c(-5.8, 5.8)
          ),
          shapes = list(plotly_hline(-1.5, dash = "dash"))
        )
      
      return(p)
    })
    
    output$cvlt_line_recognition.plot <- renderPlotly({
      data.df <- reac_plot_cvlt.df() %>% 
        filter(
          name %in% cvlt_recognition.var
        ) %>%
        na.omit()
      
      p <- data.df %>%
        plot_ly(
          data = .,
          type = "scatter",
          mode = "lines+markers",
          y = ~value,
          x = ~factor(epoch, levels = 1:5),
          color = ~factor(displayname, levels = cvlt_recognition.names),
          colors = RColorBrewer::brewer.pal(8, "Spectral"),
          hovertemplate = ~txt
        ) %>%
        layout(
          xaxis = list(
            title = "Epoch",
            zeroline = F,
            showticklabels = T,
            range = c(1, 5)
          ),
          yaxis = list(
            title = "Z-Score",
            zeroline = T,
            showticklabels = T,
            range = c(-5.8, 5.8)
          ),
          shapes = list(plotly_hline(-1.5, dash = "dash"), plotly_hline(1.5, dash = "dash"))
        )
      
      return(p)
    })
    
    # line plots: Biber
    
    output$biber_line_learning.plot <- renderPlotly({
      data.df <- reac_plot_biber.df() %>% 
        filter(
          name %in% biber_learning.var
        ) %>%
        na.omit()

      p <- data.df %>%
        plot_ly(
          data = .,
          type = "scatter",
          mode = "lines+markers",
          y = ~value,
          x = ~factor(epoch, levels = 1:5),
          color = ~factor(displayname, levels = biber_learning.names),
          colors = RColorBrewer::brewer.pal(8, "Spectral"),
          hovertemplate = ~txt
        ) %>%
        layout(
          xaxis = list(
            title = "Epoch",
            zeroline = F,
            showticklabels = T,
            range = c(1, 5)
          ),
          yaxis = list(
            title = "Z-Score",
            zeroline = T,
            showticklabels = T,
            range = c(-5.8, 5.8)
          ),
          shapes = list(plotly_hline(-1.5, dash = "dash"))
        )
      
      return(p)
    })
    
    output$biber_line_recall.plot <- renderPlotly({
      data.df <- reac_plot_biber.df() %>% 
        filter(
          name %in% biber_recall.var
        ) %>%
        na.omit()
      
      p <- data.df %>%
        plot_ly(
          data = .,
          type = "scatter",
          mode = "lines+markers",
          y = ~value,
          x = ~factor(epoch, levels = 1:5),
          color = ~factor(displayname, levels = biber_recall.names),
          colors = RColorBrewer::brewer.pal(8, "Spectral"),
          hovertemplate = ~txt
        ) %>%
        layout(
          xaxis = list(
            title = "Epoch",
            zeroline = F,
            showticklabels = T,
            range = c(1, 5)
          ),
          yaxis = list(
            title = "Z-Score",
            zeroline = T,
            showticklabels = T,
            range = c(-5.8, 5.8)
          ),
          shapes = list(plotly_hline(-1.5, dash = "dash"))
        )
      
      return(p)
    })
    
    output$biber_line_recognition.plot <- renderPlotly({
      data.df <- reac_plot_biber_recognition.df() %>% 
        na.omit()
      
      p <- data.df %>%
        plot_ly(
          data = .,
          type = "scatter",
          mode = "lines+markers",
          y = ~value,
          x = ~factor(epoch, levels = 1:5),
          color = ~factor(displayname, levels = biber_recognition.names),
          colors = RColorBrewer::brewer.pal(8, "Spectral"),
          hovertemplate = ~txt
        ) %>%
        layout(
          xaxis = list(
            title = "Epoch",
            zeroline = F,
            showticklabels = T,
            range = c(1, 5)
          ),
          yaxis = list(
            title = "Value",
            showticklabels = T
          )
        )
      
      return(p)
    })
    
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
