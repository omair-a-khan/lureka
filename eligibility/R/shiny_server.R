server <- shinyServer(
  function(input, output, session) {
    # =========================================================================
    # create reactive data
    
    options(knitr.kable.NA = "--")
    
    reac_participant_data.df <- reactive({
      data.df <- complete_eligibility_data.df[complete_eligibility_data.df$vmac_id %in% input$vmac_id, ]
      return(data.df)
    })
    
    # reac_specific_data.df <- reactive({
    #   data.df <- reac_participant_data.df()[reac_participant_data.df()$epoch %in% input$epoch, ]
    #   return(data.df)
    # })
    
    # =========================================================================
    # update VMAC ID choices for selectInput("vmac_id", ...)
    
    vmac_id_in_input = reactive({
      return(complete_eligibility_data.df[, "vmac_id"])
    })
    
    observe({
      updateSelectInput(session, "vmac_id", choices = vmac_id_in_input())
    })
    
    # =========================================================================
    # generate tables for summary sheet
    
    reac_tables.list <- reactive({
      tables.list <- generate_tables(reac_participant_data.df())
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
    
    output$cdr.df <- function(){
      reac_tables.list()[["cdr.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$srt.df <- function(){
      reac_tables.list()[["srt.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$bvrt.df <- function(){
      reac_tables.list()[["bvrt.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$digit_span.df <- function(){
      reac_tables.list()[["digit_span.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$rey15.df <- function(){
      reac_tables.list()[["rey15.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$wrat3_reading.df <- function(){
      reac_tables.list()[["wrat3_reading.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$block_design.df <- function(){
      reac_tables.list()[["block_design.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$bnt.df <- function(){
      reac_tables.list()[["bnt.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$vegetables.df <- function(){
      reac_tables.list()[["vegetables.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$trail.df <- function(){
      reac_tables.list()[["trail.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$stroop.df <- function(){
      reac_tables.list()[["stroop.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$cowa.df <- function(){
      reac_tables.list()[["cowa.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$faq.df <- function(){
      reac_tables.list()[["faq.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    output$gds.df <- function(){
      reac_tables.list()[["gds.df"]] %>%
        knitr::kable(., digits = 1, align = 'lrr') %>% 
        kable_styling(bootstrap_options = c("striped", "hover", "condensed"))
    }
    
    # generate np_notes
    
    output$np_notes.str <- function(){
      reac_participant_data.df()$np_notes
    }
    
    # # =========================================================================
    # # create plots
    # 
    # # dot plots
    # 
    # output$cvlt_dot.plot <- renderPlotly({
    #   data.df <- reac_plot_cvlt.df() %>% na.omit()
    #   
    #   data.df$bold_epoch <- glue::glue("<b>{data.df$epoch}</b>")
    #   
    #   p <- data.df %>%
    #     plot_ly(
    #       data = .,
    #       type = "scatter",
    #       mode = "text",
    #       y = ~displayname,
    #       x = ~value,
    #       color = ~factor(epoch, levels = 1:5),
    #       colors = RColorBrewer::brewer.pal(4, "Spectral"),
    #       text = ~bold_epoch,
    #       hovertemplate = ~txt
    #     ) %>%
    #     layout(
    #       font = list(size = 14),
    #       xaxis = list(
    #         title = "Z-Score",
    #         zeroline = T,
    #         showticklabels = T,
    #         range = c(-5.8, 5.8)
    #       ),
    #       yaxis = list(
    #         title = "",
    #         zeroline = F,
    #         showticklabels = T,
    #         categoryorder = "array",
    #         categoryarray = rev(cvlt.names)
    #       ),
    #       shapes = list(plotly_vline(x = -1.5, dash = "dash"), plotly_vline(x = 1.5, dash = "dash"))
    #     )
    #   
    #   return(p)
    # })
    # 
    # output$biber_dot.plot <- renderPlotly({
    #   data.df <- reac_plot_biber.df() %>% na.omit()
    #   
    #   data.df$bold_epoch <- glue::glue("<b>{data.df$epoch}</b>")
    #   
    #   p <- data.df %>%
    #     plot_ly(
    #       data = .,
    #       type = "scatter",
    #       mode = "text",
    #       y = ~displayname,
    #       x = ~value,
    #       color = ~factor(epoch, levels = 1:5),
    #       colors = RColorBrewer::brewer.pal(4, "Spectral"),
    #       text = ~bold_epoch,
    #       hovertemplate = ~txt
    #     ) %>%
    #     layout(
    #       font = list(size = 14),
    #       xaxis = list(
    #         title = "Z-Score",
    #         zeroline = T,
    #         showticklabels = T,
    #         range = c(-5.8, 5.8)
    #       ),
    #       yaxis = list(
    #         title = "",
    #         zeroline = F,
    #         showticklabels = T,
    #         categoryorder = "array",
    #         categoryarray = rev(biber.names)
    #       ),
    #       shapes = list(plotly_vline(x = -1.5, dash = "dash"), plotly_vline(x = 1.5, dash = "dash"))
    #     )
    #   
    #   return(p)
    # })
    # 
    # # line plots: CVLT
    # 
    # output$cvlt_line_learning.plot <- renderPlotly({
    #   data.df <- reac_plot_cvlt.df() %>% 
    #     filter(
    #       name %in% cvlt_learning.var
    #     ) %>%
    #     na.omit()
    #   
    #   p <- data.df %>%
    #     plot_ly(
    #       data = .,
    #       type = "scatter",
    #       mode = "lines+markers",
    #       y = ~value,
    #       x = ~factor(epoch, levels = 1:5),
    #       color = ~factor(displayname, levels = cvlt_learning.names),
    #       colors = RColorBrewer::brewer.pal(8, "Spectral"),
    #       hovertemplate = ~txt
    #     ) %>%
    #     layout(
    #       xaxis = list(
    #         title = "Epoch",
    #         zeroline = F,
    #         showticklabels = T,
    #         range = c(1, 5)
    #       ),
    #       yaxis = list(
    #         title = "Z-Score",
    #         zeroline = T,
    #         showticklabels = T,
    #         range = c(-5.8, 5.8)
    #       ),
    #       shapes = list(plotly_hline(-1.5, dash = "dash"))
    #     )
    #   
    #   return(p)
    # })
    # 
    # output$cvlt_line_recall.plot <- renderPlotly({
    #   data.df <- reac_plot_cvlt.df() %>% 
    #     filter(
    #       name %in% cvlt_recall.var
    #     ) %>%
    #     na.omit()
    #   
    #   p <- data.df %>%
    #     plot_ly(
    #       data = .,
    #       type = "scatter",
    #       mode = "lines+markers",
    #       y = ~value,
    #       x = ~factor(epoch, levels = 1:5),
    #       color = ~factor(displayname, levels = cvlt_recall.names),
    #       colors = RColorBrewer::brewer.pal(8, "Spectral"),
    #       hovertemplate = ~txt
    #     ) %>%
    #     layout(
    #       xaxis = list(
    #         title = "Epoch",
    #         zeroline = F,
    #         showticklabels = T,
    #         range = c(1, 5)
    #       ),
    #       yaxis = list(
    #         title = "Z-Score",
    #         zeroline = T,
    #         showticklabels = T,
    #         range = c(-5.8, 5.8)
    #       ),
    #       shapes = list(plotly_hline(-1.5, dash = "dash"))
    #     )
    #   
    #   return(p)
    # })
    # 
    # output$cvlt_line_recognition.plot <- renderPlotly({
    #   data.df <- reac_plot_cvlt.df() %>% 
    #     filter(
    #       name %in% cvlt_recognition.var
    #     ) %>%
    #     na.omit()
    #   
    #   p <- data.df %>%
    #     plot_ly(
    #       data = .,
    #       type = "scatter",
    #       mode = "lines+markers",
    #       y = ~value,
    #       x = ~factor(epoch, levels = 1:5),
    #       color = ~factor(displayname, levels = cvlt_recognition.names),
    #       colors = RColorBrewer::brewer.pal(8, "Spectral"),
    #       hovertemplate = ~txt
    #     ) %>%
    #     layout(
    #       xaxis = list(
    #         title = "Epoch",
    #         zeroline = F,
    #         showticklabels = T,
    #         range = c(1, 5)
    #       ),
    #       yaxis = list(
    #         title = "Z-Score",
    #         zeroline = T,
    #         showticklabels = T,
    #         range = c(-5.8, 5.8)
    #       ),
    #       shapes = list(plotly_hline(-1.5, dash = "dash"), plotly_hline(1.5, dash = "dash"))
    #     )
    #   
    #   return(p)
    # })
    # 
    # # line plots: Biber
    # 
    # output$biber_line_learning.plot <- renderPlotly({
    #   data.df <- reac_plot_biber.df() %>% 
    #     filter(
    #       name %in% biber_learning.var
    #     ) %>%
    #     na.omit()
    #   
    #   p <- data.df %>%
    #     plot_ly(
    #       data = .,
    #       type = "scatter",
    #       mode = "lines+markers",
    #       y = ~value,
    #       x = ~factor(epoch, levels = 1:5),
    #       color = ~factor(displayname, levels = biber_learning.names),
    #       colors = RColorBrewer::brewer.pal(8, "Spectral"),
    #       hovertemplate = ~txt
    #     ) %>%
    #     layout(
    #       xaxis = list(
    #         title = "Epoch",
    #         zeroline = F,
    #         showticklabels = T,
    #         range = c(1, 5)
    #       ),
    #       yaxis = list(
    #         title = "Z-Score",
    #         zeroline = T,
    #         showticklabels = T,
    #         range = c(-5.8, 5.8)
    #       ),
    #       shapes = list(plotly_hline(-1.5, dash = "dash"))
    #     )
    #   
    #   return(p)
    # })
    # 
    # output$biber_line_recall.plot <- renderPlotly({
    #   data.df <- reac_plot_biber.df() %>% 
    #     filter(
    #       name %in% biber_recall.var
    #     ) %>%
    #     na.omit()
    #   
    #   p <- data.df %>%
    #     plot_ly(
    #       data = .,
    #       type = "scatter",
    #       mode = "lines+markers",
    #       y = ~value,
    #       x = ~factor(epoch, levels = 1:5),
    #       color = ~factor(displayname, levels = biber_recall.names),
    #       colors = RColorBrewer::brewer.pal(8, "Spectral"),
    #       hovertemplate = ~txt
    #     ) %>%
    #     layout(
    #       xaxis = list(
    #         title = "Epoch",
    #         zeroline = F,
    #         showticklabels = T,
    #         range = c(1, 5)
    #       ),
    #       yaxis = list(
    #         title = "Z-Score",
    #         zeroline = T,
    #         showticklabels = T,
    #         range = c(-5.8, 5.8)
    #       ),
    #       shapes = list(plotly_hline(-1.5, dash = "dash"))
    #     )
    #   
    #   return(p)
    # })
    # 
    # output$biber_line_recognition.plot <- renderPlotly({
    #   data.df <- reac_plot_biber_recognition.df() %>% 
    #     na.omit()
    #   
    #   p <- data.df %>%
    #     plot_ly(
    #       data = .,
    #       type = "scatter",
    #       mode = "lines+markers",
    #       y = ~value,
    #       x = ~factor(epoch, levels = 1:5),
    #       color = ~factor(displayname, levels = biber_recognition.names),
    #       colors = RColorBrewer::brewer.pal(8, "Spectral"),
    #       hovertemplate = ~txt
    #     ) %>%
    #     layout(
    #       xaxis = list(
    #         title = "Epoch",
    #         zeroline = F,
    #         showticklabels = T,
    #         range = c(1, 5)
    #       ),
    #       yaxis = list(
    #         title = "Value",
    #         showticklabels = T
    #       )
    #     )
    #   
    #   return(p)
    # })
    
    # =========================================================================
    # generate downloadable summary sheet
    
    output$report <- downloadHandler(
      filename = function() {
        glue::glue("summary_sheet_eligibility_vmac_{input$vmac_id}.html")
      },
      content = function(file) {
        # Copy the report file to a temporary directory before processing it, in
        # case we don't have write permissions to the current working dir
        tempReport <- file.path(tempdir(), "summary_sheet.Rmd")
        file.copy("summary_sheet.Rmd", tempReport, overwrite = TRUE)
        
        # Set up parameters to pass to Rmd document
        params <- list(
          epoch = input$epoch,
          vmac_id = input$vmac_id
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
