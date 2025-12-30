# modules/sampling_methods_ui.R
samplingMethodsUI <- function(id) {
  ns <- NS(id)
  tagList(
    h2("2.3 Sampling Methods and Sample Sizes"),
    fluidRow(
      column(12,
             bs4Card(
               title = "Sampling Design Overview",
               status = "primary",
               width = 12,
               div(
                 h4("Multi-stage Sampling Approach"),
                 p("The study employed a mixed-methods approach with stratified random sampling:"),
                 tags$ul(
                   tags$li("Survey: Multi-stage cluster sampling"),
                   tags$li("FGDs: Purposive sampling"),
                   tags$li("KIIs: Maximum variation sampling")
                 )
               )
             )
      )
    ),
    fluidRow(
      column(6,
             interactivePlotUI(ns("sampling_flow"), "Sampling Flow Diagram")
      ),
      column(6,
             bs4Card(
               title = "Sample Size Distribution",
               status = "info",
               width = 12,
               DTOutput(ns("sample_table"))
             )
      )
    ),
    fluidRow(
      column(12,
             bs4Card(
               title = "Download Sampling Methodology",
               status = "success",
               width = 12,
               closable = FALSE,
               collapsible = TRUE,
               div(
                 p("Detailed sampling methodology and power calculations"),
                 downloadButton(ns("download_methodology"), "Download Document", class = "btn-success")
               )
             )
      )
    )
  )
}