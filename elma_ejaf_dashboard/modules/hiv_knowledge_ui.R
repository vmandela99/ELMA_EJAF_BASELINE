# modules/hiv_knowledge_ui.R
hivKnowledgeUI <- function(id) {
  ns <- NS(id)
  
  tagList(
    div(class = "section-header",
        h2(icon("shield-virus"), " 3.2.5 HIV Knowledge, ART & PrEP Awareness"),
        p("Assessment of AYPs' knowledge and attitudes towards HIV testing, ART, and PrEP")
    ),
    
    # Key Statistics Row
    fluidRow(
      column(3, metricCardUI(ns("hiv_knowledge"), "HIV Knowledge", "48.6%", "Adequate knowledge", "brain", "info")),
      column(3, metricCardUI(ns("positive_attitudes"), "Positive Attitudes", "49.9%", "Towards HIV services", "thumbs-up", "success")),
      column(3, metricCardUI(ns("condom_knowledge"), "Condom Knowledge", "97%", "Risk reduction", "shield-alt", "warning")),
      column(3, metricCardUI(ns("prep_awareness"), "PrEP Awareness", "45%", "Heard of PrEP", "capsules", "danger"))
    ),
    
    # HIV Knowledge Assessment
    fluidRow(
      column(12,
             h3(icon("chart-line"), " HIV Knowledge Composite Score", 
                style = "color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px;")
      )
    ),
    fluidRow(
      column(6,
             styledCardUI(
               id = ns("knowledge_assessment"),
               title = "Knowledge Assessment Methodology",
               content = HTML("
            <p><strong>Composite Knowledge Score (31 statements):</strong></p>
            <ul>
              <li>HIV Testing: 12 assessment statements</li>
              <li>ART Knowledge: 10 assessment statements</li>
              <li>PrEP Awareness: 9 assessment statements</li>
            </ul>
            <hr>
            <p><strong>Scoring System:</strong></p>
            <ul>
              <li>Correct answer = 1 point</li>
              <li>Wrong/Unsure = 0 points</li>
              <li>Cut-off threshold: 16.00 (mean score)</li>
              <li>Score > 16.00 = Adequate knowledge</li>
            </ul>
            <div class='progress' style='height: 25px; margin-top: 15px;'>
              <div class='progress-bar bg-info' role='progressbar' style='width: 48.6%' aria-valuenow='48.6' aria-valuemin='0' aria-valuemax='100'>
                <strong>48.6% Adequate Knowledge</strong>
              </div>
              <div class='progress-bar bg-light text-dark' role='progressbar' style='width: 51.4%' aria-valuenow='51.4' aria-valuemin='0' aria-valuemax='100'>
                51.4% Need Improvement
              </div>
            </div>
          "),
               type = "info",
               icon = "clipboard-check"
             )
      ),
      column(6,
             textToChartUI(ns("knowledge_components_chart"), "Knowledge Components Breakdown", height = "350px")
      )
    ),
    
    # Attitudes Assessment
    fluidRow(
      column(12,
             h3(icon("heart"), " Attitudes Towards HIV Services", 
                style = "color: #2c3e50; border-bottom: 2px solid #e74c3c; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             textToChartUI(ns("attitudes_chart"), "Attitudes Assessment Components", height = "350px")
      ),
      column(6,
             highlightCardUI(
               id = ns("attitudes_insights"),
               title = "Attitudes Assessment Methodology",
               content = HTML("
            <p><strong>22 Assessment Statements:</strong></p>
            <ul>
              <li>HIV Testing: 6 statements</li>
              <li>ART Attitudes: 9 statements</li>
              <li>PrEP Attitudes: 7 statements</li>
            </ul>
            <hr>
            <p><strong>5-Point Likert Scale Scoring:</strong></p>
            <ul>
              <li>Positive statements: 1-5 (Strongly Disagree to Strongly Agree)</li>
              <li>Negative statements: Reverse scoring (5-1)</li>
              <li>Median cut-off: 68 points</li>
              <li>Score ≥ 68 = Positive attitudes</li>
            </ul>
            <div class='progress' style='height: 25px; margin-top: 15px;'>
              <div class='progress-bar bg-success' role='progressbar' style='width: 49.9%' aria-valuenow='49.9' aria-valuemin='0' aria-valuemax='100'>
                <strong>49.9% Positive Attitudes</strong>
              </div>
              <div class='progress-bar bg-light text-dark' role='progressbar' style='width: 50.1%' aria-valuenow='50.1' aria-valuemin='0' aria-valuemax='100'>
                50.1% Negative/Neutral
              </div>
            </div>
          "),
               highlight_text = "Nearly 50% Positive"
             )
      )
    ),
    
    # HIV Transmission Awareness
    fluidRow(
      column(12,
             h3(icon("exchange-alt"), " HIV Transmission Awareness", 
                style = "color: #2c3e50; border-bottom: 2px solid #9b59b6; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             bs4Card(
               title = "Correct Knowledge of Transmission Modes",
               status = "success",
               width = 12,
               elevation = 2,
               DTOutput(ns("transmission_table"))
             )
      ),
      column(6,
             div(class = "warning-box",
                 h5(icon("exclamation-triangle"), " Persistent Myths and Misconceptions"),
                 HTML("
              <p><strong>Common Misconceptions:</strong></p>
              <ul>
                <li><span class='stat-badge'>23%</span> believe mosquito bites transmit HIV</li>
                <li><span class='stat-badge'>27%</span> think sharing silverware has transmission risk</li>
                <li>Significant knowledge gaps persist</li>
              </ul>
              <hr>
              <p><strong>Correctly Identified Myths:</strong></p>
              <ul>
                <li><span class='stat-badge'>87%</span> know bathing together doesn't transmit HIV</li>
              </ul>
            ")
             ),
             bs4Card(
               title = "HIV Risk Reduction Awareness",
               status = "info",
               width = 12,
               elevation = 2,
               style = "margin-top: 15px;",
               plotlyOutput(ns("risk_reduction_chart"), height = "200px")
             )
      )
    ),
    
    # Targets and Progress
    fluidRow(
      column(12,
             h3(icon("bullseye"), " Program Targets and Progress", 
                style = "color: #2c3e50; border-bottom: 2px solid #f39c12; padding-bottom: 10px; margin-top: 20px;")
      )
    ),
    fluidRow(
      column(6,
             styledCardUI(
               id = ns("knowledge_targets"),
               title = "Knowledge Improvement Targets",
               content = HTML("
            <table class='table table-bordered' style='width:100%'>
              <thead>
                <tr class='bg-light'>
                  <th>Indicator</th>
                  <th>Baseline</th>
                  <th>Endline Target</th>
                  <th>Expected Change</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>HIV Knowledge Score</td>
                  <td><span class='stat-badge'>48.6%</span></td>
                  <td><span class='stat-badge bg-success'>58%</span></td>
                  <td>+10% points</td>
                </tr>
                <tr>
                  <td>Positive Attitudes</td>
                  <td><span class='stat-badge'>49.9%</span></td>
                  <td><span class='stat-badge bg-success'>57%</span></td>
                  <td>+7.1% points</td>
                </tr>
              </tbody>
            </table>
            <hr>
            <p><strong>Intervention Focus Areas:</strong></p>
            <ul>
              <li>Address misconceptions about transmission</li>
              <li>Improve PrEP awareness (currently 45%)</li>
              <li>Enhance knowledge of ART benefits</li>
              <li>Promote positive service attitudes</li>
            </ul>
          "),
               type = "warning",
               icon = "target"
             )
      ),
      column(6,
             bs4Card(
               title = "Knowledge and Attitude Progress",
               status = "primary",
               width = 12,
               elevation = 2,
               plotlyOutput(ns("progress_chart"), height = "300px")
             )
      )
    ),
    
    # Download Section
    fluidRow(
      column(12,
             downloadCardUI(
               ns("download_hiv_knowledge"),
               "Download HIV Knowledge Analysis",
               "Complete analysis of HIV knowledge, attitudes, transmission awareness, and targets",
               "HIV_Knowledge_Analysis.pdf",
               "Download Report",
               color = "primary"
             )
      )
    )
  )
}