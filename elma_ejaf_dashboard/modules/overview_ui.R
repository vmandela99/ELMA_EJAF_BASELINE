# modules/overview_ui.R
overviewUI <- function(id) {
  ns <- NS(id)  # <-- THIS LINE IS CRITICAL
  
  tagList(
    fluidRow(
      column(12,
             bs4Card(
               title = "Tiko Uganda Study Dashboard",
               status = "primary",
               width = 12,
               closable = FALSE,
               div(
                 h3("Comprehensive Analysis of AYP Health Interventions"),
                 p("This dashboard presents findings from the Tiko Uganda study on integrated mental health, SRH, and HIV services for adolescents and young people."),
                 hr(),
                 fluidRow(
                   column(6,
                          h4("Key Sections:"),
                          tags$ul(
                            tags$li(tags$b("Study Background:"), " Context, intervention description, and research objectives"),
                            tags$li(tags$b("Methodology:"), " Study design, sampling, data collection, and analysis methods"),
                            tags$li(tags$b("Results:"), " Socio-demographic profiles, awareness levels, behavioral outcomes"),
                            tags$li(tags$b("Conclusions:"), " Recommendations and implementation implications")
                          )
                   ),
                   column(6,
                          h4("Quick Stats:"),
                          metricCardUI(ns("overview1"), "Total Participants", "1,250", "Survey Respondents", "users"),
                          metricCardUI(ns("overview2"), "FGDs Conducted", "24", "Focus Group Discussions", "comments"),
                          metricCardUI(ns("overview3"), "KIIs", "18", "Key Informant Interviews", "user-md")
                   )
                 )
               )
             )
      )
    ),
    fluidRow(
      column(6,
             # interactivePlotUI(ns("overview_timeline"), "Study Timeline")
             plotlyOutput(ns("overview_timeline"))
      ),
      column(6,
             bs4Card(
               title = "Download Executive Summary",
               status = "success",
               width = 12,
               closable = FALSE,
               collapsible = TRUE,
               div(
                 p("Complete executive summary of the Tiko Uganda study findings"),
                 downloadButton(ns("download_summary"), "Download PDF", class = "btn-success")
               )
             )
      )
    )
  )
}