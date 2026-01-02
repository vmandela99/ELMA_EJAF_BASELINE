# modules/socio_demographic_ui.R
socioDemographicUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    div(class = "section-header",
        h2(icon("users"), " 3.1 Socio-demographic Profile of AYPs"),
        p("Analysis of 465 Adolescents and Young People (AYPs) surveyed in Kampala")
    ),
    
    # Key Statistics Row
    fluidRow(
      column(3, metricCardUI(ns("total_ayp"), "Total AYPs", "465", "Surveyed", "users", "primary")),
      column(3, metricCardUI(ns("females"), "Female AYPs", "352", "75.7%", "female", "danger")),
      column(3, metricCardUI(ns("males"), "Male AYPs", "113", "24.3%", "male", "info")),
      column(3, metricCardUI(ns("mpi_poor"), "MPI Poor", "26%", "Multi-dimensionally poor", "exclamation-triangle", "warning"))
    ),
    
    # Executive Summary
    fluidRow(
      column(12,
             styledCardUI(
               id = ns("exec_summary"),
               title = "Executive Summary",
               content = HTML("
            <p><strong>Key Findings from 465 AYP Participants:</strong></p>
            <ul>
              <li><span class='stat-badge'>76% Female</span> majority in the sample</li>
              <li><span class='stat-badge'>53% Aged 21-24</span> years old</li>
              <li><span class='stat-badge'>59% Secondary Education</span> completed</li>
              <li><span class='stat-badge'>26% MPI Poor</span> with gender disparity (28.4% females vs 18.6% males)</li>
              <li><span class='stat-badge'>69% Sexually Active</span> with significant gender differences</li>
            </ul>
          "),
               type = "info",
               icon = "chart-pie",
               gradient = FALSE
             )
      )
    ),
    
    # Age Distribution Section
    fluidRow(
      column(12,
             h3(icon("calendar-alt"), " Age Distribution by Gender", 
                style = "color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px;")
      )
    ),
    fluidRow(
      column(6,
             textToChartUI(ns("age_chart"), "Age Distribution (%)", height = "350px")
      ),
      column(6,
             highlightCardUI(
               id = ns("age_insights"),
               title = "Age Distribution Insights",
               content = HTML("
            <p><strong>Notable Patterns:</strong></p>
            <ul>
              <li>Majority (53%) are 21-24 years old</li>
              <li>More males in younger age groups (15-20 years)</li>
              <li>More females in older age group (21-24 years)</li>
              <li>Chi-square test shows significant association (p=0.001*)</li>
            </ul>
          "),
               highlight_text = "Significant Gender-Age Association"
             )
      )
    ),
    
    # Education Level Section
    fluidRow(
      column(12,
             h3(icon("graduation-cap"), " Education Level Distribution", 
                style = "color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             textToChartUI(ns("education_chart"), "Education Levels (%)", height = "350px")
      ),
      column(6,
             highlightCardUI(
               id = ns("education_insights"),
               title = "Educational Attainment",
               content = HTML("
            <p><strong>Key Observations:</strong></p>
            <ul>
              <li>59% completed secondary education</li>
              <li>Similar patterns for males and females</li>
              <li>Only 0.4% never attended school</li>
              <li>Chi-square test shows no significant gender difference (p=0.395)</li>
            </ul>
          "),
               highlight_text = "No Significant Gender Difference"
             )
      )
    ),
    
    # Sexual Behavior Section
    fluidRow(
      column(12,
             h3(icon("heart"), " Sexual Behavior Patterns", 
                style = "color: #2c3e50; border-bottom: 2px solid #e74c3c; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             textToChartUI(ns("sexual_behavior_chart"), "Sexual Behavior by Gender (%)", height = "300px")
      ),
      column(6,
             div(class = "warning-box",
                 h5(icon("exclamation-triangle"), " Significant Gender Differences"),
                 HTML("
              <ul>
                <li><strong>75% females</strong> vs <strong>50% males</strong> sexually active</li>
                <li><strong>72% females</strong> vs <strong>49% males</strong> have sexual partner</li>
                <li>Chi-square tests highly significant (p<0.001*)</li>
                <li>Higher sexual activity among females</li>
              </ul>
            ")
             )
      )
    ),
    
    # Poverty Status Section
    fluidRow(
      column(12,
             h3(icon("hand-holding-usd"), " Poverty Status (MPI)", 
                style = "color: #2c3e50; border-bottom: 2px solid #f39c12; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             textToChartUI(ns("poverty_chart"), "Poverty Status by Gender (%)", height = "300px")
      ),
      column(6,
             div(class = "info-box",
                 h5(icon("chart-bar"), " Poverty Disparities"),
                 HTML("
              <ul>
                <li><strong>28.4% females</strong> are MPI poor vs <strong>18.6% males</strong></li>
                <li>Significant gender association (p=0.038*)</li>
                <li>More girls/women from poor backgrounds</li>
                <li>Highlights socioeconomic vulnerability</li>
              </ul>
            ")
             )
      )
    ),
    
    # Client Exit Interviews Section
    fluidRow(
      column(12,
             h3(icon("sign-out-alt"), " Client Exit Interviews (CEIs) Demographics", 
                style = "color: #2c3e50; border-bottom: 2px solid #9b59b6; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             bs4Card(
               title = "CEI Sample Overview",
               status = "primary",
               width = 12,
               elevation = 2,
               DTOutput(ns("cei_table"))
             )
      ),
      column(6,
             highlightCardUI(
               id = ns("cei_insights"),
               title = "CEI Key Findings",
               content = HTML("
            <p><strong>248 AYPs who accessed services:</strong></p>
            <ul>
              <li><span class='stat-badge'>80% Female</span> majority</li>
              <li><span class='stat-badge'>53% Aged 21-24</span> years</li>
              <li><span class='stat-badge'>59% Secondary Education</span></li>
              <li><span class='stat-badge'>29% Married</span> (34% females vs 8% males)</li>
              <li><span class='stat-badge'>36% Have sexual partner</span></li>
            </ul>
            <p class='text-muted'><small>*Significant age and relationship status differences by gender</small></p>
          "),
               highlight_text = "Service Access Patterns"
             )
      )
    ),
    
    # Download Section
    fluidRow(
      column(12,
             downloadCardUI(
               ns("download_demographics"),
               "Download Demographic Analysis",
               "Complete socio-demographic profile including all statistics, charts, and insights",
               "SocioDemographic_Analysis.pdf",
               "Download Report",
               color = "success"
             )
      )
    )
  )
}