# modules/ayp_behaviors_ui.R
aypBehaviorsUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    div(class = "section-header",
        h2(icon("user-check"), " 3.3 AYP Behaviors Influencing Service Uptake"),
        p("Analysis of behaviors affecting Mental Health, SRH, and HIV intervention uptake")
    ),
    
    # Key Statistics Row
    fluidRow(
      column(3, metricCardUI(ns("improved_behaviors"), "Improved Behaviors", "45.2%", "Composite score ≥18", "chart-line", "success")),
      column(3, metricCardUI(ns("depression_rate"), "Depression", "47.7%", "Based on PHQ-9", "frown", "warning")),
      column(3, metricCardUI(ns("traditional_media"), "Traditional Media", "65%", "Primary info source", "tv", "info")),
      column(3, metricCardUI(ns("peer_networks"), "Peer Networks", "High", "Key info source", "users", "primary"))
    ),
    
    # Improved Behaviors Composite Score
    fluidRow(
      column(12,
             h3(icon("brain"), " Improved Behaviors Composite Score", 
                style = "color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px;")
      )
    ),
    fluidRow(
      column(6,
             styledCardUI(
               id = ns("behavior_composite"),
               title = "Behavior Composite Indicator Methodology",
               content = HTML("
            <p><strong>Composite Score Calculation:</strong></p>
            <ul>
              <li><span class='stat-badge'>Mental Health:</span> 12 points maximum</li>
              <li><span class='stat-badge'>Sexual Reproductive Health:</span> 20 points maximum</li>
              <li><span class='stat-badge'>HIV Testing:</span> 6 points maximum</li>
            </ul>
            <p><strong>Total Maximum Score: 38 points</strong></p>
            <hr>
            <p><strong>Classification Criteria:</strong></p>
            <ul>
              <li>High knowledge: Score ≥ 18 (mean = 18.01)</li>
              <li>Low knowledge: Score < 18.01</li>
            </ul>
            <div class='progress' style='height: 25px; margin-top: 15px;'>
              <div class='progress-bar bg-success' role='progressbar' style='width: 45.2%' aria-valuenow='45.2' aria-valuemin='0' aria-valuemax='100'>
                <strong>45.2% High Behavioral Scores</strong>
              </div>
              <div class='progress-bar bg-light text-dark' role='progressbar' style='width: 54.8%' aria-valuenow='54.8' aria-valuemin='0' aria-valuemax='100'>
                54.8% Need Improvement
              </div>
            </div>
            <hr>
            <p><strong>Target:</strong> Increase by 10% points to reach 55% at endline</p>
          "),
               type = "info",
               icon = "calculator"
             )
      ),
      column(6,
             # textToChartUI(ns("behavior_components_chart"), "Behavior Components Distribution", height = "350px")
             plotlyOutput(ns("behavior_components_chart"), height = "350px")
      )
    ),
    
    # Depression Symptoms Analysis
    fluidRow(
      column(12,
             h3(icon("heartbeat"), " Anxiety and Depression Symptoms (PHQ-9)", 
                style = "color: #2c3e50; border-bottom: 2px solid #e74c3c; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             bs4Card(
               title = "Depression Severity Levels",
               status = "danger",
               width = 12,
               elevation = 2,
               DTOutput(ns("depression_table"))
             )
      ),
      column(6,
             div(class = "warning-box",
                 h5(icon("exclamation-triangle"), " Critical Mental Health Findings"),
                 HTML("
              <p><strong>Nearly Half of AYPs Affected:</strong></p>
              <ul>
                <li><span class='stat-badge'>47.7%</span> have some form of depression</li>
                <li><span class='stat-badge'>32.5%</span> mild depression</li>
                <li><span class='stat-badge'>11.4%</span> moderate depression</li>
                <li><span class='stat-badge'>3.8%</span> moderately severe to severe</li>
              </ul>
              <hr>
              <p><strong>Gender Distribution:</strong></p>
              <ul>
                <li>Females show slightly higher depression rates</li>
                <li>4.3% females vs 0.9% males with moderately severe symptoms</li>
                <li>No severe cases among males</li>
              </ul>
            ")
             ),
             bs4Card(
               title = "Depression Severity Visualization",
               status = "primary",
               width = 12,
               elevation = 2,
               style = "margin-top: 15px;",
               plotlyOutput(ns("depression_chart"), height = "250px")
             )
      )
    ),
    
    # Information Sources
    fluidRow(
      column(12,
             h3(icon("broadcast-tower"), " Sources of Health Information", 
                style = "color: #2c3e50; border-bottom: 2px solid #9b59b6; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             # textToChartUI(ns("info_sources_chart"), "Communication Channels Used by AYPs", height = "350px")
             plotlyOutput(ns("info_sources_chart"), height = "350px")
      ),
      column(6,
             highlightCardUI(
               id = ns("info_insights"),
               title = "Key Information Dissemination Patterns",
               content = HTML("
            <p><strong>Primary Information Sources:</strong></p>
            <ul>
              <li><span class='stat-badge'>Traditional Media</span> (TV, radio) - Most common</li>
              <li><span class='stat-badge'>Word of Mouth</span> from peers, friends, neighbors</li>
              <li><span class='stat-badge'>Healthcare Providers</span> and community workers</li>
              <li><span class='stat-badge'>Religious Institutions</span> (Church)</li>
            </ul>
            <hr>
            <p><strong>Qualitative Findings:</strong></p>
            <ul>
              <li>Peer-to-peer interactions are significant</li>
              <li>Social networks crucial for information sharing</li>
              <li>Community health workers bridge information gaps</li>
              <li>Specialized counseling centers trusted for MH info</li>
            </ul>
            <hr>
            <p><strong>Emerging Trends:</strong></p>
            <ul>
              <li>Social media platforms gaining importance</li>
              <li>Online resources from reputable organizations</li>
              <li>Electronic educational materials</li>
            </ul>
          "),
               highlight_text = "Peer Networks Critical"
             )
      )
    ),
    
    # Behavioral Targets
    fluidRow(
      column(12,
             h3(icon("target"), " Behavioral Improvement Targets", 
                style = "color: #2c3e50; border-bottom: 2px solid #f39c12; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(8,
             bs4Card(
               title = "Behavioral Improvement Roadmap",
               status = "warning",
               width = 12,
               elevation = 2,
               plotlyOutput(ns("behavior_targets_chart"), height = "300px")
             )
      ),
      column(4,
             styledCardUI(
               id = ns("intervention_focus"),
               title = "Intervention Focus Areas",
               content = HTML("
            <p><strong>Priority Areas for Improvement:</strong></p>
            <ul>
              <li>Address depression through MH services</li>
              <li>Strengthen peer education networks</li>
              <li>Leverage traditional media for awareness</li>
              <li>Enhance digital information channels</li>
              <li>Improve community health worker capacity</li>
            </ul>
            <hr>
            <p><strong>Expected Outcomes:</strong></p>
            <ul>
              <li>10% increase in improved behaviors</li>
              <li>Better mental health screening</li>
              <li>Enhanced information access</li>
              <li>Stronger community support systems</li>
            </ul>
          "),
               type = "success",
               icon = "bullseye",
               gradient = FALSE
             )
      )
    ),
    
    # Download Section
    fluidRow(
      column(12,
             downloadCardUI(
               ns("download_behaviors"),
               "Download Behavioral Analysis",
               "Complete analysis of AYP behaviors, depression symptoms, information sources, and targets",
               "AYP_Behaviors_Analysis.pdf",
               "Download Report",
               color = "success"
             )
      )
    )
  )
}