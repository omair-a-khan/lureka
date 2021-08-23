header <- dashboardHeader(
  title = "Lureka: Eligibility"
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    # selectInput("epoch", "Epoch", unique(complete_np_data.df$epoch)),
    selectInput("vmac_id", "VMAC ID", ""),
    hr(),
    menuItem("Summary Sheet", tabName = "summary_sheet", icon = icon("columns")),
    menuItem("Options", tabName = "options", icon = icon("cog"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "summary_sheet",
      h2("Vanderbilt Memory & Aging Project: Eligibility Visit Data Summary Sheet"),
      
      downloadButton('report', label = "Download Report", class = "download_button"),
      br(),
      br(),
      
      fluidRow(
        box(
          title = "Metadata", width = 12, status = "primary", solidHeader = TRUE,
          tableOutput("metadata_wide.df")
        )
      ),
      
      fluidRow(
        column(
          width = 5,
          box(
            title = "Global Cognition", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>MOCA</h4></em>"),
            tableOutput("moca.df"),
            HTML("<em><h4>CDR</h4></em>"),
            tableOutput("cdr.df")
          ),
          box(
            title = "Learning & Memory", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>SRT</h4></em>"),
            tableOutput("srt.df"),
            HTML("<em><h4>BVRT</h4></em>"),
            tableOutput("bvrt.df")
          ),
          box(
            title = "Attention", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>WAIS-III Digit Span</h4></em>"),
            tableOutput("digit_span.df")
          ),
          box(
            title = "Effort", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>Rey 15 Item Test</h4></em>"),
            tableOutput("rey15.df")
          )
        ),
        
        column(
          width = 7,
          box(
            title = "Estimated Pre-Morbid Intelligence", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>WRAT-3 Reading</h4></em>"),
            tableOutput("wrat3_reading.df")
          ),
          box(
            title = "Visuospatial Skills", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>WAIS-IV Block Design</h4></em>"),
            tableOutput("block_design.df")
          ),
          box(
            title = "Language", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>BNT-30 item (odd)</h4></em>"),
            tableOutput("bnt.df"),
            HTML("<em><h4>Vegetables</h4></em>"),
            tableOutput("vegetables.df")
          ),
          box(
            title = "Executive Functioning/Information Processing", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>Trail Making Test</h4></em>"),
            tableOutput("trail.df"),
            HTML("<em><h4>Stroop</h4></em>"),
            tableOutput("stroop.df"),
            HTML("<em><h4>COWA</h4></em>"),
            tableOutput("cowa.df")
          ),
          box(
            title = "Function/ADLs", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>FAQ</h4></em>"),
            tableOutput("faq.df")
          ),
          # box(
          #   title = "Mood", width = NULL, status = "primary", solidHeader = TRUE,
          #   HTML("<em><h4>GDS</h4></em>"),
          #   tableOutput("gds.df")
          # ),
          box(
            title = "Notes", width = NULL, status = "primary", solidHeader = TRUE,
            textOutput("np_notes.str")
          )
        )
      )
    ),
    
    tabItem(
      tabName = "options",
      h2("Options"),
      
      actionButton('force_data_refresh', label = "Force Data Refresh", icon = icon("redo-alt"))
      
    )
  )
)

ui <- dashboardPage(
  skin = "green",
  header,
  sidebar,
  body
)
