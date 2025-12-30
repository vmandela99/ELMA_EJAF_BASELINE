# modules/study_design_ui.R
studyDesignUI <- function(id) {
  ns <- NS(id)
  tagList(
    h2("2.1 Study Design"),
    
    # Methodology Summary
    fluidRow(
      column(12,
             bs4Card(
               title = "Mixed Methods Approach",
               status = "primary",
               width = 12,
               closable = FALSE,
               div(
                 class = "summary-card",
                 h4("Integrated Research Methodology"),
                 p("The baseline study employed a mixed method approach using:"),
                 fluidRow(
                   column(6,
                          tags$ul(
                            tags$li(tags$b("Quantitative:"), " Face-to-face interviews with 465 AYPs"),
                            tags$li(tags$b("Qualitative:"), " 26 In-depth Interviews"),
                            tags$li(tags$b("Client Exit:"), " 250 post-service interviews"),
                            tags$li(tags$b("Mystery Client:"), " 4 quality assessment visits")
                          )
                   ),
                   column(6,
                          tags$ul(
                            tags$li(tags$b("FGDs:"), " 2 focus group discussions"),
                            tags$li(tags$b("YAPs:"), " Interviews with 15 Young Adolescent Peer Supporters"),
                            tags$li(tags$b("Providers:"), " 8 service provider interviews"),
                            tags$li(tags$b("Document Review:"), " Policy and program analysis")
                          )
                   )
                 )
               )
             )
      )
    ),
    
    # Methodology Components Visualization
    fluidRow(
      column(6,
             textToChartUI(ns("design_chart"), "Study Design Components")
      ),
      column(6,
             bs4Card(
               title = "Study Timeline",
               status = "info",
               width = 12,
               plotlyOutput(ns("timeline_chart"), height = "300px")
             )
      )
    ),
    
    # Data Collection Methods
    fluidRow(
      column(12,
             h3("Data Collection Instruments")
      )
    ),
    fluidRow(
      column(4,
             bs4Card(
               title = "Survey Tools",
               status = "success",
               width = 12,
               icon = icon("clipboard-check"),
               tags$ul(
                 tags$li("ODK-based electronic questionnaires"),
                 tags$li("Android tablets for data collection"),
                 tags$li("English and Luganda versions"),
                 tags$li("Skip patterns for user journey")
               )
             )
      ),
      column(4,
             bs4Card(
               title = "Qualitative Tools",
               status = "warning",
               width = 12,
               icon = icon("comments"),
               tags$ul(
                 tags$li("In-depth interview guides"),
                 tags$li("FGD discussion guides"),
                 tags$li("Voice recording with consent"),
                 tags$li("Thematic analysis framework")
               )
             )
      ),
      column(4,
             bs4Card(
               title = "Quality Assurance",
               status = "danger",
               width = 12,
               icon = icon("shield-alt"),
               tags$ul(
                 tags$li("3-day enumerator training"),
                 tags$li("Pre-testing of all tools"),
                 tags$li("Real-time validation rules"),
                 tags$li("Supportive supervision")
               )
             )
      )
    ),
    
    # Sampling Summary
    fluidRow(
      column(12,
             bs4Card(
               title = "Sampling Framework Summary",
               status = "primary",
               width = 12,
               collapsible = TRUE,
               collapsed = TRUE,
               DTOutput(ns("sampling_summary"))
             )
      )
    )
  )
}