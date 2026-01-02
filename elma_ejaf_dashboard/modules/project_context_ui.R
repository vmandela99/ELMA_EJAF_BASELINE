# modules/project_context_ui.R
projectContextUI <- function(id) {
  ns <- NS(id)
  tagList(
    h2("1.1 Project Context"),
    
    # Summary Cards
    fluidRow(
      column(6, metricCardUI(ns("stat1"), "AYP Population", "8.2M", "Ages 10-24", "users", "info")),
      column(6, metricCardUI(ns("stat2"), "New HIV Infections", "60%", "Among AYP", "virus", "danger")),
      column(6, metricCardUI(ns("stat3"), "Contraceptive Use", "9.4%", "Age 15-19", "baby-carriage", "warning")),
      column(6, metricCardUI(ns("stat4"), "MH Disorders", "12.5%", "Among youth", "brain", "success"))
    ),
    
    fluidRow(
      column(12,
             bs4Card(
               title = "Executive Summary",
               status = "info",
               width = 12,
               closable = FALSE,
               collapsible = TRUE,
               div(
                 class = "summary-card",
                 h4("Key Context Highlights"),
                 p("Adolescents and Young People (15-24) in Uganda face significant challenges:"),
                 tags$ul(
                   tags$li("Account for 60% of new HIV infections"),
                   tags$li("Only 9.4% modern contraceptive use among adolescents"),
                   tags$li("25% adolescent pregnancy rate with high unmet family planning needs"),
                   tags$li("12.5% suffer from mental health disorders affecting SRH outcomes")
                 )
               )
             )
      )
    ),
    
    # HIV Statistics Section
    fluidRow(
      column(12,
             h3("HIV Epidemiology Among Key Populations")
      )
    ),
    fluidRow(
      column(6,
             textToChartUI(ns("hiv_chart"), "HIV Prevalence Among Different Groups")
      ),
      column(6,
             bs4Card(
               title = "Key Insights",
               status = "warning",
               width = 12,
               tags$ul(
                 tags$li("Young females have disproportionately higher HIV rates"),
                 tags$li("Key populations (sex workers, MSM) show significantly higher prevalence"),
                 tags$li("20% of Uganda's population is aged 15-24 years")
               )
             )
      )
    ),
    
    # Contraceptive and Pregnancy Section
    fluidRow(
      column(12,
             h3("Contraceptive Use and Pregnancy Trends")
      )
    ),
    fluidRow(
      column(6,
             textToChartUI(ns("contraceptive_chart"), "Contraceptive Coverage and Targets")
      ),
      column(6,
             textToChartUI(ns("pregnancy_chart"), "Adolescent Pregnancies by District (2020)")
      )
    ),
    
    # Mental Health Section
    fluidRow(
      column(12,
             h3("Mental Health and SRH Correlation")
      )
    ),
    fluidRow(
      column(6,
             textToChartUI(ns("mh_chart"), "Mental Health Impact on SRH Outcomes")
      ),
      column(6,
             bs4Card(
               title = "Critical Findings",
               status = "danger",
               width = 12,
               tags$ul(
                 tags$li("Mental health disorders increase risky sexual behaviors"),
                 tags$li("40% less condom use among those with mental health issues"),
                 tags$li("Higher rates of STIs and unintended pregnancies"),
                 tags$li("Correlation with substance abuse and multiple partners")
               )
             )
      )
    ),
    
    # Wealth Disparity Section
    fluidRow(
      column(12,
             bs4Card(
               title = "Wealth Disparity in Adolescent Pregnancy",
               status = "success",
               width = 12,
               closable = FALSE,
               collapsible = TRUE,
               div(
                 class = "stat-card",
                 h5("Socioeconomic Impact"),
                 p("Adolescent pregnancy rate is highest among girls from the poorest households and lowest among those from the richest households."),
                 p("This highlights the need for targeted interventions addressing economic disparities.")
               )
             )
      )
    ),
    
    # Download Section
    fluidRow(
      column(12,
             downloadCardUI(
               ns("context_download"),
               "Download Context Analysis",
               "Complete analysis of project context including all statistics and charts",
               "Project_Context_Analysis.pdf",
               "Download Report"
             )
      )
    )
  )
}