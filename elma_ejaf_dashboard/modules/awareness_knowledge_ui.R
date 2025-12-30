# modules/awareness_knowledge_ui.R
awarenessKnowledgeUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    h2("3.2 Awareness, Knowledge, Attitudes towards MH, SRH and HIV"),
    
    # Summary Metrics
    fluidRow(
      column(3, metricCardUI(ns("card1"), "MH Awareness", "65%", "High awareness level", "brain", "info")),
      column(3, metricCardUI(ns("card2"), "HIV Knowledge", "78%", "Prevention knowledge", "shield-virus", "success")),
      column(3, metricCardUI(ns("card3"), "Stigma Level", "42%", "Negative attitudes", "ban", "warning")),
      column(3, metricCardUI(ns("card4"), "PrEP Awareness", "45%", "Heard of PrEP", "capsules", "danger"))
    ),
    
    tabsetPanel(
      id = ns("awareness_tabs"),
      
      tabPanel("Mental Health",
               fluidRow(
                 column(12,
                        bs4Card(
                          title = "Mental Health Awareness and Stigma",
                          status = "primary",
                          width = 12,
                          closable = FALSE,
                          collapsible = TRUE,
                          div(
                            p("Analysis of mental health awareness levels and stigma indicators among AYPs.")
                          )
                        )
                 )
               ),
               fluidRow(
                 column(6,
                        textToChartUI(ns("mh_awareness"), "Mental Health Awareness Levels")
                 ),
                 column(6,
                        bs4Card(
                          title = "Stigma Indicators",
                          status = "warning",
                          width = 12,
                          plotlyOutput(ns("mh_stigma"), height = "350px")
                        )
                 )
               ),
               fluidRow(
                 column(6,
                        bs4Card(
                          title = "Mental Health Empowerment",
                          status = "success",
                          width = 12,
                          plotlyOutput(ns("mh_empowerment_chart"), height = "350px")
                        )
                 ),
                 column(6,
                        bs4Card(
                          title = "Key Findings",
                          status = "info",
                          width = 12,
                          tags$ul(
                            tags$li("65% of AYPs show high mental health awareness"),
                            tags$li("45% hold misconceptions about mental health"),
                            tags$li("Only 35% would seek professional help"),
                            tags$li("42% believe mental health issues indicate personal weakness")
                          ),
                          hr(),
                          htmlOutput(ns("awareness_summary"))
                        )
                 )
               )
      ),
      
      tabPanel("HIV Knowledge",
               fluidRow(
                 column(6,
                        textToChartUI(ns("hiv_knowledge"), "HIV Knowledge Scores")
                 ),
                 column(6,
                        textToChartUI(ns("prep_knowledge"), "PrEP Awareness Levels")
                 )
               ),
               fluidRow(
                 column(6,
                        bs4Card(
                          title = "Attitudes Towards HIV Services",
                          status = "success",
                          width = 12,
                          plotlyOutput(ns("hiv_attitudes_chart"), height = "350px")
                        )
                 ),
                 column(6,
                        bs4Card(
                          title = "HIV Service Insights",
                          status = "danger",
                          width = 12,
                          tags$ul(
                            tags$li("85% know HIV transmission modes"),
                            tags$li("Only 45% are aware of PrEP"),
                            tags$li("72% comfortable with HIV testing"),
                            tags$li("45% willing to disclose HIV status")
                          )
                        )
                 )
               )
      ),
      
      tabPanel("Service Awareness",
               fluidRow(
                 column(12,
                        bs4Card(
                          title = "Service Awareness vs Utilization",
                          status = "info",
                          width = 12,
                          plotlyOutput(ns("service_awareness_chart"), height = "400px")
                        )
                 )
               ),
               fluidRow(
                 column(12,
                        bs4Card(
                          title = "Service Gap Analysis",
                          status = "warning",
                          width = 12,
                          p("While awareness of various services is moderate, utilization rates remain significantly lower, indicating barriers to access or uptake."),
                          tags$ul(
                            tags$li("Biggest gap: Telehealth options (28% aware vs 12% utilization)"),
                            tags$li("Smallest gap: Community outreach (55% aware vs 32% utilization)"),
                            tags$li("School-based services show 23% utilization gap"),
                            tags$li("Peer support groups have 20% utilization gap")
                          )
                        )
                 )
               )
      ),
      
      tabPanel("Detailed Data",
               fluidRow(
                 column(12,
                        bs4Card(
                          title = "Complete Awareness Data",
                          status = "primary",
                          width = 12,
                          maximizable = TRUE,
                          DTOutput(ns("awareness_table"))
                        )
                 )
               ),
               fluidRow(
                 column(12,
                        downloadCardUI(
                          ns("download_awareness"),
                          "Download Awareness Data",
                          "Complete dataset of all awareness, knowledge, and attitude indicators",
                          "awareness_data_export.csv",
                          "Download CSV"
                        )
                 )
               )
      )
    )
  )
}