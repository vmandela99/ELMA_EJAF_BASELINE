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
library(tidyr)
library(fresh)  # For custom theming


# Source modules
source("modules/shared/metric_card.R")
source("modules/shared/download_card.R")
source("modules/shared/interactive_plot.R")
source("modules/shared/text_to_chart.R")
source("modules/shared/styled_card.R")  # New styled card module

source("modules/overview_ui.R")
source("modules/overview_server.R")
source("modules/project_context_ui.R")
source("modules/project_context_server.R")
source("modules/study_design_ui.R")
source("modules/study_design_server.R")
source("modules/sampling_methods_ui.R")
source("modules/sampling_methods_server.R")

# NEW MODULES for Results Section
source("modules/socio_demographic_ui.R")
source("modules/socio_demographic_server.R")
source("modules/mh_awareness_ui.R")  # Mental Health Awareness
source("modules/mh_awareness_server.R")
source("modules/hiv_knowledge_ui.R")  # HIV Knowledge
source("modules/hiv_knowledge_server.R")
source("modules/ayp_behaviors_ui.R")  # AYP Behaviors
source("modules/ayp_behaviors_server.R")
source("modules/mh_profile_ui.R")  # Mental Health Profile
source("modules/mh_profile_server.R")

source("modules/awareness_knowledge_ui.R")
source("modules/awareness_knowledge_server.R")
source("modules/annexes_ui.R")
source("modules/annexes_server.R")

# Source data
source("data/project_context_data.R")
source("data/sampling_data.R")
source("data/study_design_data.R")
source("data/socio_demographic_data.R")  # New data file

# Custom theme for sidebar and main menu
mytheme <- create_theme(
  bs4dash_vars(
    navbar_light_color = "#2c3e50",
    navbar_light_active_color = "#FFF",
    navbar_light_hover_color = "#3498db",
    sidebar_light_bg = "#34495e",  # Dark blue sidebar
    sidebar_light_hover_bg = "#2c3e50",
    sidebar_light_color = "#FFF",
    sidebar_light_submenu_bg = "#2c3e50",
    sidebar_light_submenu_color = "#ecf0f1",
    sidebar_light_submenu_hover_color = "#3498db"
  ),
  bs4dash_yiq(
    contrasted_threshold = 10,
    text_dark = "#272c30"
  ),
  bs4dash_layout(
    main_bg = "#f8f9fa"
  ),
  bs4dash_sidebar_light(
    bg = "#2c3e50",  # Dark blue
    color = "#ecf0f1",
    hover_color = "#3498db",
    submenu_bg = "#34495e",
    submenu_color = "#bdc3c7",
    submenu_hover_color = "#3498db"
  )
)

# UI
ui <- dashboardPage(
  freshTheme = mytheme,
  
  dashboardHeader(
    title = div(
      img(src = "https://via.placeholder.com/40x40/3498db/ffffff?text=T", 
          height = "30px", 
          style = "border-radius: 50%; margin-right: 10px;"),
      span("Tiko Uganda Study Dashboard", style = "font-weight: 600; color: #2c3e50;")
    ),
    titleWidth = 300,
    fixed = TRUE,
    skin = "light",
    status = "white",
    border = TRUE,
    compact = TRUE
  ),
  
  dashboardSidebar(
    width = 300,
    skin = "light",
    elevation = 3,
    fixed = TRUE,
    collapsed = FALSE,
    
    sidebarMenu(
      id = "tabs",
      menuItem("Overview", tabName = "overview", icon = icon("home", class = "text-primary")),
      
      # STUDY BACKGROUND Section
      menuItem("1. STUDY BACKGROUND", 
               tabName = "study_background", 
               icon = icon("book", class = "text-info"),
               menuSubItem("1.1 Project Context", tabName = "project_context", icon = icon("globe-africa")),
               menuSubItem("1.2 Tiko Intervention", tabName = "tiko_intervention", icon = icon("handshake")),
               menuSubItem("1.3 Research Objectives", tabName = "research_objectives", icon = icon("bullseye"))),
      
      # STUDY METHODOLOGY Section
      menuItem("2. STUDY METHODOLOGY", 
               tabName = "study_methodology", 
               icon = icon("flask", class = "text-warning"),
               menuSubItem("2.1 Study Design", tabName = "study_design", icon = icon("project-diagram")),
               menuSubItem("2.2 Study Location", tabName = "study_location", icon = icon("map-marker-alt")),
               menuSubItem("2.3 Sampling Methods", tabName = "sampling_methods", icon = icon("filter")),
               menuSubItem("2.4 Data Collection", tabName = "data_collection", icon = icon("clipboard-check")),
               menuSubItem("2.5 Field Procedures", tabName = "field_procedures", icon = icon("procedures")),
               menuSubItem("2.6 Data Quality", tabName = "data_quality", icon = icon("shield-alt")),
               menuSubItem("2.7 Data Analysis", tabName = "data_analysis", icon = icon("chart-bar")),
               menuSubItem("2.8 Ethical Considerations", tabName = "ethical_considerations", icon = icon("balance-scale"))),
      
      # RESULTS AND DISCUSSIONS Section
      menuItem("3. RESULTS AND DISCUSSIONS", 
               tabName = "results", 
               icon = icon("chart-bar", class = "text-success"),
               menuSubItem("3.1 Socio-demographic Profile", tabName = "socio_demographic", icon = icon("users")),
               menuSubItem("3.2 MH Awareness & Knowledge", tabName = "mh_awareness", icon = icon("brain")),
               menuSubItem("3.3 HIV Knowledge", tabName = "hiv_knowledge", icon = icon("shield-virus")),
               menuSubItem("3.4 AYP Behaviors", tabName = "ayp_behaviors", icon = icon("user-check")),
               menuSubItem("3.5 MH Profile & Symptoms", tabName = "mh_profile", icon = icon("heartbeat"))),
      
      # CONCLUSIONS Section
      menuItem("4. CONCLUSIONS", 
               tabName = "conclusions", 
               icon = icon("check-circle", class = "text-danger"),
               menuSubItem("4.1 Survey Limitations", tabName = "limitations", icon = icon("exclamation-triangle")),
               menuSubItem("4.2 Implementation Implications", tabName = "implications", icon = icon("lightbulb")),
               menuSubItem("4.3 Recommendations", tabName = "recommendations", icon = icon("tasks"))),
      
      # REFERENCES & ANNEXES
      menuItem("REFERENCES & ANNEXES", 
               tabName = "references", 
               icon = icon("file-alt", class = "text-secondary"),
               menuSubItem("References", tabName = "references_tab", icon = icon("book-open")),
               menuSubItem("Annexes", tabName = "annexes_tab", icon = icon("paperclip")))
    ),
    
    # Sidebar footer with summary
    tags$div(
      class = "sidebar-footer",
      style = "padding: 15px; background: #2c3e50; color: white;",
      h5("Study Summary", style = "color: #3498db;"),
      tags$ul(
        style = "font-size: 12px; padding-left: 15px;",
        tags$li("Total AYPs: 465"),
        tags$li("Females: 76%"),
        tags$li("Males: 24%"),
        tags$li("Age: 15-24 years")
      )
    )
  ),
  
  dashboardBody(
    use_waiter(),
    tags$head(
      tags$style(HTML("
        /* Custom CSS for enhanced styling */
        .content-wrapper { 
          background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }
        
        .card {
          border-radius: 10px;
          box-shadow: 0 4px 6px rgba(0,0,0,0.1);
          border: none;
          transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .card:hover {
          transform: translateY(-5px);
          box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        
        .value-box {
          border-radius: 8px;
          margin: 5px;
          overflow: hidden;
        }
        
        .section-header {
          background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
          color: white;
          padding: 15px;
          border-radius: 8px;
          margin-bottom: 20px;
        }
        
        .highlight-card {
          border-left: 5px solid #3498db;
          background: white;
          padding: 15px;
          margin: 10px 0;
          border-radius: 5px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .stat-badge {
          background: #e3f2fd;
          color: #1976d2;
          padding: 5px 10px;
          border-radius: 20px;
          font-weight: 600;
          font-size: 0.9em;
        }
        
        .insight-box {
          background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
          color: white;
          padding: 15px;
          border-radius: 8px;
          margin: 10px 0;
        }
        
        .warning-box {
          background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
          color: white;
          padding: 15px;
          border-radius: 8px;
          margin: 10px 0;
        }
        
        .info-box {
          background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
          color: white;
          padding: 15px;
          border-radius: 8px;
          margin: 10px 0;
        }
        
        .sidebar-footer {
          border-top: 2px solid #3498db;
          margin-top: 20px;
        }
        
        .tab-content {
          background: white;
          border-radius: 8px;
          padding: 20px;
          margin-top: 10px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        /* Custom scrollbar */
        ::-webkit-scrollbar {
          width: 8px;
        }
        
        ::-webkit-scrollbar-track {
          background: #f1f1f1;
          border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb {
          background: #3498db;
          border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
          background: #2980b9;
        }
      "))
    ),
    
    tabItems(
      tabItem(tabName = "overview", overviewUI("overview")),
      tabItem(tabName = "project_context", projectContextUI("project_context")),
      tabItem(tabName = "study_design", studyDesignUI("study_design")),
      tabItem(tabName = "sampling_methods", samplingMethodsUI("sampling_methods")),
      tabItem(tabName = "socio_demographic", socioDemographicUI("socio_demographic")),
      tabItem(tabName = "mh_awareness", mhAwarenessUI("mh_awareness")),
      tabItem(tabName = "hiv_knowledge", hivKnowledgeUI("hiv_knowledge")),
      tabItem(tabName = "ayp_behaviors", aypBehaviorsUI("ayp_behaviors")),
      tabItem(tabName = "mh_profile", mhProfileUI("mh_profile")),
      tabItem(tabName = "awareness_knowledge", awarenessKnowledgeUI("awareness_knowledge")),
      # tabItem(tabName = "annexes_tab", annexesUI("annexes")),
      
      # Other tabs (placeholders)
      tabItem(
        tabName = "tiko_intervention",
        div(class = "section-header", h2("1.2 Tiko Intervention Description")),
        bs4Card(
          title = "Intervention Overview",
          status = "primary",
          width = 12,
          elevation = 3,
          "Content coming soon..."
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
  socioDemographicServer("socio_demographic")
  mhAwarenessServer("mh_awareness")
  hivKnowledgeServer("hiv_knowledge")
  aypBehaviorsServer("ayp_behaviors")
  mhProfileServer("mh_profile")
  awarenessKnowledgeServer("awareness_knowledge")
  # annexesServer("annexes")
}

# Run the application
shinyApp(ui = ui, server = server)