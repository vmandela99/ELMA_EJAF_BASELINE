# modules/mh_profile_ui.R
mhProfileUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    div(class = "section-header",
        h2(icon("heartbeat"), " 3.3.2 Mental Health Profile of AYPs"),
        p("Detailed analysis of anxiety, depression symptoms, and mental health conditions among adolescents and young people")
    ),
    
    # Key Statistics Row
    fluidRow(
      column(3, metricCardUI(ns("any_depression"), "Any Depression", "47.7%", "PHQ-9 ≥ 5", "frown", "warning")),
      column(3, metricCardUI(ns("moderate_severe"), "Moderate-Severe", "15.2%", "PHQ-9 ≥ 10", "exclamation-triangle", "danger")),
      column(3, metricCardUI(ns("no_depression"), "No Depression", "52.3%", "PHQ-9 < 5", "smile", "success")),
      column(3, metricCardUI(ns("female_depression"), "Female Depression", "49.6%", "vs 42.5% males", "female", "info"))
    ),
    
    # Depression Severity Overview
    fluidRow(
      column(12,
             h3(icon("chart-pie"), " Depression Severity Distribution (PHQ-9)", 
                style = "color: #2c3e50; border-bottom: 2px solid #e74c3c; padding-bottom: 10px;")
      )
    ),
    fluidRow(
      column(6,
             bs4Card(
               title = "PHQ-9 Depression Severity Scale",
               status = "danger",
               width = 12,
               elevation = 2,
               plotlyOutput(ns("depression_pie_chart"), height = "350px")
             )
      ),
      column(6,
             styledCardUI(
               id = ns("phq9_scale"),
               title = "PHQ-9 Assessment Scale",
               content = HTML("
            <p><strong>Patient Health Questionnaire-9 (PHQ-9):</strong></p>
            <ul>
              <li>9-item depression screening instrument</li>
              <li>Scores range from 0 to 27</li>
              <li>Higher scores indicate greater depression severity</li>
            </ul>
            <hr>
            <p><strong>Severity Categories:</strong></p>
            <ul>
              <li><span class='stat-badge' style='background: #2ecc71;'>0-4:</span> None/Minimal</li>
              <li><span class='stat-badge' style='background: #3498db;'>5-9:</span> Mild</li>
              <li><span class='stat-badge' style='background: #f39c12;'>10-14:</span> Moderate</li>
              <li><span class='stat-badge' style='background: #e74c3c;'>15-19:</span> Moderately Severe</li>
              <li><span class='stat-badge' style='background: #c0392b;'>20-27:</span> Severe</li>
            </ul>
            <hr>
            <p><strong>Clinical Significance:</strong></p>
            <ul>
              <li>47.7% scored ≥5 (clinical cutoff)</li>
              <li>15.2% scored ≥10 (need clinical intervention)</li>
              <li>3.8% scored ≥15 (urgent intervention needed)</li>
            </ul>
          "),
               type = "warning",
               icon = "stethoscope"
             )
      )
    ),
    
    # Gender Comparison
    fluidRow(
      column(12,
             h3(icon("venus-mars"), " Gender Comparison of Depression Symptoms", 
                style = "color: #2c3e50; border-bottom: 2px solid #9b59b6; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             textToChartUI(ns("gender_comparison_chart"), "Depression Severity by Gender", height = "350px")
      ),
      column(6,
             div(class = "info-box",
                 h5(icon("balance-scale"), " Gender Disparities in Depression"),
                 HTML("
              <p><strong>Notable Gender Differences:</strong></p>
              <ul>
                <li><span class='stat-badge'>49.6%</span> females vs <span class='stat-badge'>42.5%</span> males with any depression</li>
                <li><span class='stat-badge'>4.9%</span> females vs <span class='stat-badge'>0.9%</span> males with moderately severe symptoms</li>
                <li><span class='stat-badge'>0.6%</span> females vs <span class='stat-badge'>0%</span> males with severe depression</li>
              </ul>
              <hr>
              <p><strong>Clinical Implications:</strong></p>
              <ul>
                <li>Females show higher depression prevalence</li>
                <li>More severe cases among females</li>
                <li>Need for gender-sensitive interventions</li>
                <li>Targeted mental health support for young women</li>
              </ul>
            ")
             )
      )
    ),
    
    # Prevalent Mental Health Conditions
    fluidRow(
      column(12,
             h3(icon("head-side-virus"), " Prevalent Mental Health Conditions", 
                style = "color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             highlightCardUI(
               id = ns("mh_conditions"),
               title = "Common Mental Health Disorders Among AYPs (15-24)",
               content = HTML("
            <p><strong>Based on Qualitative Findings:</strong></p>
            <ul>
              <li><span class='stat-badge' style='background: #3498db;'>Anxiety Disorders</span> - Most prevalent</li>
              <li><span class='stat-badge' style='background: #e74c3c;'>Depressive Disorders</span> - 47.7% prevalence</li>
              <li><span class='stat-badge' style='background: #f39c12;'>Substance Abuse Disorders</span> - Emerging concern</li>
              <li><span class='stat-badge' style='background: #9b59b6;'>Stress-related Issues</span> - Linked to life challenges</li>
            </ul>
            <hr>
            <p><strong>Risk Factors Identified:</strong></p>
            <ul>
              <li>Financial constraints and unemployment</li>
              <li>Academic pressure and school-related stress</li>
              <li>Relationship and family problems</li>
              <li>Limited access to mental health services</li>
              <li>Stigma and discrimination</li>
            </ul>
            <hr>
            <p><strong>Comorbidity Patterns:</strong></p>
            <ul>
              <li>Depression often co-occurs with anxiety</li>
              <li>Substance use as coping mechanism</li>
              <li>Physical health impacts mental wellbeing</li>
            </ul>
          "),
               highlight_text = "Multiple Co-occurring Conditions"
             )
      ),
      column(6,
             bs4Card(
               title = "Mental Health Conditions Distribution",
               status = "primary",
               width = 12,
               elevation = 2,
               plotlyOutput(ns("conditions_chart"), height = "300px")
             )
      )
    ),
    
    # Intervention Recommendations
    fluidRow(
      column(12,
             h3(icon("hands-helping"), " Intervention Recommendations", 
                style = "color: #2c3e50; border-bottom: 2px solid #2ecc71; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(4,
             styledCardUI(
               id = ns("screening_card"),
               title = "Screening & Early Detection",
               content = HTML("
            <ul>
              <li>Routine PHQ-9 screening in all services</li>
              <li>Train providers in mental health assessment</li>
              <li>Develop referral pathways</li>
              <li>Implement digital screening tools</li>
            </ul>
          "),
               type = "info",
               icon = "search",
               gradient = FALSE
             )
      ),
      column(4,
             styledCardUI(
               id = ns("treatment_card"),
               title = "Treatment & Support",
               content = HTML("
            <ul>
              <li>Cognitive Behavioral Therapy programs</li>
              <li>Peer support groups</li>
              <li>Medication management where needed</li>
              <li>Crisis intervention services</li>
            </ul>
          "),
               type = "success",
               icon = "user-md",
               gradient = FALSE
             )
      ),
      column(4,
             styledCardUI(
               id = ns("prevention_card"),
               title = "Prevention & Promotion",
               content = HTML("
            <ul>
              <li>Mental health literacy programs</li>
              <li>Stress management workshops</li>
              <li>Resilience building activities</li>
              <li>Anti-stigma campaigns</li>
            </ul>
          "),
               type = "warning",
               icon = "shield-alt",
               gradient = FALSE
             )
      )
    ),
    
    # Download Section
    fluidRow(
      column(12,
             downloadCardUI(
               ns("download_mh_profile"),
               "Download Mental Health Profile Analysis",
               "Complete analysis of depression symptoms, gender disparities, prevalent conditions, and intervention recommendations",
               "MH_Profile_Analysis.pdf",
               "Download Report",
               color = "danger"
             )
      )
    )
  )
}