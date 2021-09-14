header <- dashboardHeader(
  title = "Lureka"
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    selectInput("epoch", "Epoch", unique(complete_epoch5dde_data.df$epoch)),
    selectInput("map_id", "MAP ID", ""),
    hr(),
    menuItem("Summary Sheet", tabName = "summary_sheet", icon = icon("columns")),
    menuItem("Options", tabName = "options", icon = icon("cog"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "summary_sheet",
      h2("Neuropsychological Data Summary Sheet"),
      
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
            tableOutput("moca.df")
          ),
          box(
            title = "Learning & Memory", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>CVLT-II</h4></em>"),
            tableOutput("cvlt.df"),
            HTML("<em><h4>Biber</h4></em>"),
            tableOutput("biber.df")
          ),
          box(
            title = "Language", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>BNT-30 item (even)</h4></em>"),
            tableOutput("bnt.df"),
            HTML("<em><h4>Animals</h4></em>"),
            tableOutput("animals.df")
          ),
          box(
            title = "Mood", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>GDS</h4></em>"),
            tableOutput("gds.df")
          ),
          box(
            title = "Visuospatial Skills", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>HVOT</h4></em>"),
            tableOutput("hvot.df")
          )
        ),
        
        column(
          width = 7,
          box(
            title = "Attention/Executive Functioning/Information Processing", width = NULL, status = "primary", solidHeader = TRUE,
            HTML("<em><h4>DKEFS: Trail Making Test</h4></em>"),
            tableOutput("dkefs_trail.df"),
            HTML("<em><h4>DKEFS: Color-Word</h4></em>"),
            tableOutput("dkefs_color.df"),
            HTML("<em><h4>COWA</h4></em>"),
            tableOutput("cowa.df"),
            HTML("<em><h4>Tower Test</h4></em>"),
            tableOutput("tower.df"),
            HTML("<em><h4>Digit Symbol Coding</h4></em>"),
            tableOutput("digit_symbol.df"),
            HTML("<em><h4>Mental Control</h4></em>"),
            tableOutput("mc1.df"),
            tableOutput("mc2.df"),
            HTML("<em><h4>WMS-IV Symbol Span</h4></em>"),
            tableOutput("symbol_span.df")
          ),
          box(
            title = "Notes", width = NULL, status = "primary", solidHeader = TRUE,
            textOutput("np_notes.str")
          )
        )
      )
    ),
    
    tabItem(
      tabName = "dot_plots",
      fluidRow(
        box(
          title = "CVLT-II", width = 12, status = "primary", solidHeader = TRUE,
          plotlyOutput("cvlt_dot.plot")
        )
      ),
      fluidRow(
        box(
          title = "Biber", width = 12, status = "primary", solidHeader = TRUE,
          plotlyOutput("biber_dot.plot")
        )
      )
    ),
    
    tabItem(
      tabName = "line_plots",
      fluidRow(
        tabBox(
          title = "CVLT-II", width = 12, side = "left",
          tabPanel("Learning", plotlyOutput("cvlt_line_learning.plot")),
          tabPanel("Recall", plotlyOutput("cvlt_line_recall.plot")),
          tabPanel("Recognition", plotlyOutput("cvlt_line_recognition.plot"))
        )
      ),
      fluidRow(
        tabBox(
          title = "Biber", width = 12, side = "left",
          tabPanel("Learning", plotlyOutput("biber_line_learning.plot")),
          tabPanel("Recall", plotlyOutput("biber_line_recall.plot")),
          tabPanel("Recognition", plotlyOutput("biber_line_recognition.plot"))
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
  skin = "purple",
  header,
  sidebar,
  body
)
