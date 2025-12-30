# app.R
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(DT)
library(plotly)
library(ggplot2)
library(dplyr)
library(bs4Dash)
library(waiter)
library(forcats)

# Source modules
source("modules/shared/metric_card.R")
source("modules/shared/download_card.R")
source("modules/shared/interactive_plot.R")
source("modules/shared/text_to_chart.R")  # NEW: Text to chart module

source("modules/overview_ui.R")
source("modules/overview_server.R")
source("modules/project_context_ui.R")
source("modules/project_context_server.R")
source("modules/sampling_methods_ui.R")
source("modules/sampling_methods_server.R")
source("modules/study_design_ui.R")  # NEW: Study design module
source("modules/study_design_server.R")
source("modules/socio_demographic_ui.R")
source("modules/socio_demographic_server.R")
source("modules/awareness_knowledge_ui.R")
source("modules/awareness_knowledge_server.R")
source("modules/annexes_ui.R")
source("modules/annexes_server.R")

# Source data
source("data/project_context_data.R")
# source("data/sampling_data.R")
source("data/study_design_data.R")
source("data/awareness_data.R")

# UI
ui <- dashboardPage(
  dashboardHeader(
    title = div(
      img(src = "https://via.placeholder.com/40x40?text=T", height = "30px"),
      "Tiko Uganda Study Dashboard"
    ),
    titleWidth = 300
  ),
  
  dashboardSidebar(
    width = 300,
    sidebarMenu(
      id = "tabs",
      menuItem("Overview", tabName = "overview", icon = icon("home")),
      
      # STUDY BACKGROUND Section
      menuItem("1. STUDY BACKGROUND", tabName = "study_background", icon = icon("book"),
               menuSubItem("1.1 Project Context", tabName = "project_context"),
               menuSubItem("1.2 Tiko Intervention", tabName = "tiko_intervention"),
               menuSubItem("1.3 Research Objectives", tabName = "research_objectives")),
      
      # STUDY METHODOLOGY Section
      menuItem("2. STUDY METHODOLOGY", tabName = "study_methodology", icon = icon("flask"),
               menuSubItem("2.1 Study Design", tabName = "study_design"),
               menuSubItem("2.2 Study Location", tabName = "study_location"),
               menuSubItem("2.3 Sampling Methods", tabName = "sampling_methods"),
               menuSubItem("2.4 Data Collection", tabName = "data_collection"),
               menuSubItem("2.5 Field Procedures", tabName = "field_procedures"),
               menuSubItem("2.6 Data Quality", tabName = "data_quality"),
               menuSubItem("2.7 Data Analysis", tabName = "data_analysis"),
               menuSubItem("2.8 Ethical Considerations", tabName = "ethical_considerations")),
      
      # RESULTS AND DISCUSSIONS Section
      menuItem("3. RESULTS AND DISCUSSIONS", tabName = "results", icon = icon("chart-bar"),
               menuSubItem("3.1 Socio-demographic Profile", tabName = "socio_demographic"),
               menuSubItem("3.2 Awareness & Knowledge", tabName = "awareness_knowledge"),
               menuSubItem("3.3 AYP Behaviors", tabName = "ayp_behaviors"),
               menuSubItem("3.4 Integrated Services", tabName = "integrated_services"),
               menuSubItem("3.5 Program Implementation", tabName = "program_implementation")),
      
      # CONCLUSIONS Section
      menuItem("4. CONCLUSIONS", tabName = "conclusions", icon = icon("check-circle"),
               menuSubItem("4.1 Survey Limitations", tabName = "limitations"),
               menuSubItem("4.2 Implementation Implications", tabName = "implications"),
               menuSubItem("4.3 Recommendations", tabName = "recommendations")),
      
      # REFERENCES & ANNEXES
      menuItem("REFERENCES & ANNEXES", tabName = "references", icon = icon("file-alt"),
               menuSubItem("References", tabName = "references_tab"),
               menuSubItem("Annexes", tabName = "annexes_tab"))
    )
  ),
  
  dashboardBody(
    use_waiter(),
    tags$head(
      tags$style(HTML("
        .content-wrapper { background-color: #f4f6f9; }
        .card { box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .section-title { font-weight: 600; color: #2c3e50; }
        .value-box { margin: 5px; }
        .plot-container { background: white; border-radius: 5px; padding: 15px; }
        h3 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
        .summary-card { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
                        color: white; border-radius: 10px; padding: 20px; margin: 10px 0; }
        .stat-card { background: white; border-left: 4px solid #3498db; padding: 15px; margin: 10px 0; }
        .percentage-label { font-size: 0.8em; font-weight: bold; fill: #2c3e50; }
      "))
    ),
    
    tabItems(
      tabItem(tabName = "overview", overviewUI("overview")),
      tabItem(tabName = "project_context", projectContextUI("project_context")),
      tabItem(tabName = "study_design", studyDesignUI("study_design")),
      tabItem(tabName = "sampling_methods", samplingMethodsUI("sampling_methods")),
      # tabItem(tabName = "socio_demographic", socioDemographicUI("socio_demographic")),
      tabItem(tabName = "awareness_knowledge", awarenessKnowledgeUI("awareness_knowledge")),
      # tabItem(tabName = "annexes_tab", annexesUI("annexes")),
      
      # Other tabs with placeholder content
      tabItem(
        tabName = "data_collection",
        h2("2.4 Data Collection"),
        bs4Card(
          title = "Data Collection Methods",
          status = "info",
          width = 12,
          p("Quantitative and qualitative data collection methods were employed...")
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  
  # Call module servers
  overviewServer("overview")
  projectContextServer("project_context")
  studyDesignServer("study_design")
  samplingMethodsServer("sampling_methods")
  # socioDemographicServer("socio_demographic")
  awarenessKnowledgeServer("awareness_knowledge")
  # annexesServer("annexes")
}

# Run the application
shinyApp(ui = ui, server = server)