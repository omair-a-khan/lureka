library(knitr)

shinyServer(
  function(input, output) {
    output$report = downloadHandler(
      filename = 'report.pdf',
      
      content = function(file) {
        out = knit2pdf('../test_report.Rnw', clean = TRUE)
        file.rename(out, file) 
      },
      
      contentType = 'application/pdf'
    )
  }
)
