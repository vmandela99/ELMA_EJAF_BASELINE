source("data/awareness_data.R")

# modules/mh_awareness_ui.R
mhAwarenessUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    div(class = "section-header",
        h2(icon("brain"), " 3.2.1 Awareness, Knowledge and Attitudes of Mental Health"),
        p("Analysis of mental health awareness, self-reported status, and perceptions among AYPs")
    ),
    
    # Key Statistics Row
    fluidRow(
      column(3, metricCardUI(ns("mh_excellent"), "Excellent MH", "33.8%", "Had Excellent MH", "smile", "success")),
      column(3, metricCardUI(ns("mh_good"), "Good MH", "33.3%", "Had Good MH", "meh", "warning")),
      column(3, metricCardUI(ns("male_excellent"), "Males Excellent", "42%", "vs 31% females", "male", "info")),
      column(3, metricCardUI(ns("stress_financial"), "Financial Stress", "29%", "Leading cause", "money-bill-wave", "danger"))
    ),
    
    # Mental Health Status
    fluidRow(
      column(12,
             h3(icon("heartbeat"), " Mental Health Self-Assessment", 
                style = "color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px;")
      )
    ),
    fluidRow(
      column(6,
             styledCardUI(
               id = ns("mh_status_card"),
               title = "Mental Health Status Distribution",
               content = HTML("
            <div style='text-align: center;'>
              <div style='display: inline-block; margin: 10px;'>
                <div class='stat-badge' style='background: #2ecc71;'>34%</div>
                <p>Excellent</p>
              </div>
              <div style='display: inline-block; margin: 10px;'>
                <div class='stat-badge' style='background: #3498db;'>33%</div>
                <p>Somewhat Good</p>
              </div>
              <div style='display: inline-block; margin: 10px;'>
                <div class='stat-badge' style='background: #f39c12;'>19%</div>
                <p>Neutral</p>
              </div>
              <div style='display: inline-block; margin: 10px;'>
                <div class='stat-badge' style='background: #e74c3c;'>14%</div>
                <p>Poor/Very Poor</p>
              </div>
            </div>
            <p class='text-muted'><strong>Key Insight:</strong> More males (42%) report excellent mental health status compared to females (31%)</p>
          "),
               type = "info",
               icon = "chart-pie"
             )
      ),
      column(6,
             # textToChartUI(ns("stress_causes_chart"), "Leading Causes of Stress", height = "350px")
             plotly::plotlyOutput(ns("stress_causes_chart"), height = "300px")
      )
    ),
    
    # Mental Health Empowerment Section
    fluidRow(
      column(12,
             h3(icon("user-shield"), " Mental Health Empowerment", 
                style = "color: #2c3e50; border-bottom: 2px solid #2ecc71; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             highlightCardUI(
               id = ns("self_esteem_card"),
               title = "Self-Esteem Assessment (Rosenberg Scale)",
               content = HTML("
            <p><strong>Key Findings:</strong></p>
            <ul>
              <li><span class='stat-badge'>14%</span> of AYPs have low self-esteem</li>
              <li><span class='stat-badge'>15% females</span> vs <span class='stat-badge'>12% males</span> with low self-esteem</li>
              <li>No significant gender difference (p=0.783)</li>
              <li>95% agreed: 'I can do things as well as most people'</li>
            </ul>
            <hr>
            <p><strong>Negative Self-Perceptions:</strong></p>
            <ul>
              <li>31% feel useless at times</li>
              <li>85% wish they had more self-respect</li>
              <li>49% not proud of themselves</li>
            </ul>
          "),
               highlight_text = "Positive Self-Efficacy: 95%"
             )
      ),
      column(6,
             # textToChartUI(ns("self_esteem_chart"), "Self-Esteem Indicators", height = "400px")
             plotly::plotlyOutput(ns("self_esteem_chart"), height = "300px")
      )
    ),
    
    # Support Structures Awareness
    fluidRow(
      column(12,
             h3(icon("hands-helping"), " Awareness of Mental Health Support Structures", 
                style = "color: #2c3e50; border-bottom: 2px solid #9b59b6; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             # textToChartUI(ns("support_awareness_chart"), "Support Structure Awareness", height = "300px")
             plotly::plotlyOutput(ns("support_awareness_chart"), height = "300px")
      ),
      column(6,
             div(class = "insight-box",
                 h5(icon("lightbulb"), " Critical Insights"),
                 HTML("
              <ul>
                <li><strong>63%</strong> know where to seek mental health support</li>
                <li><strong>41%</strong> believe community would support them</li>
                <li>Significant gap in perceived community support</li>
                <li>Need for community awareness programs</li>
              </ul>
              <hr>
              <p><em>'People in the community would support me in case of a mental health need'</em></p>
              <div class='progress' style='height: 20px; margin-top: 10px;'>
                <div class='progress-bar bg-warning' role='progressbar' style='width: 41%' aria-valuenow='41' aria-valuemin='0' aria-valuemax='100'>41% Agree</div>
              </div>
            ")
             )
      )
    ),
    
    # Perceptions and Attitudes
    fluidRow(
      column(12,
             h3(icon("eye"), " Perceptions and Attitudes about Mental Health", 
                style = "color: #2c3e50; border-bottom: 2px solid #e74c3c; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             bs4Card(
               title = "Perception Indicators Analysis",
               status = "danger",
               width = 12,
               elevation = 2,
               DTOutput(ns("perceptions_table"))
             )
      ),
      column(6,
             styledCardUI(
               id = ns("perceptions_summary"),
               title = "Knowledge Gaps and Stigma",
               content = HTML("
            <p><strong>Concerning Perceptions:</strong></p>
            <ul>
              <li><span class='stat-badge' style='background: #e74c3c;'>68%</span> believe mental health is visible physically</li>
              <li><span class='stat-badge' style='background: #f39c12;'>27%</span> consider MH problems as 'insanity'</li>
              <li><span class='stat-badge' style='background: #f39c12;'>22%</span> believe MH sufferers cannot make friends</li>
              <li><span class='stat-badge' style='background: #3498db;'>59%</span> believe anyone can suffer from MH problems</li>
            </ul>
            <hr>
            <p><strong>Positive Note:</strong> 59% recognize mental health can affect anyone</p>
          "),
               type = "warning",
               icon = "exclamation-triangle"
             )
      )
    ),
    
    # Factors Associated with Mental Health Perceptions
    fluidRow(
      column(12,
             h3(icon("briefcase"), " Factors Associated with Mental Health Perceptions", 
                style = "color: #2c3e50; border-bottom: 2px solid #34495e; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(12,
             bs4Card(
               title = "Association Analysis (No Significant Differences Found)",
               status = "secondary",
               width = 12,
               closable = FALSE,
               DTOutput(ns("mh_factors_table"))
             )
      )
    )
  )
}