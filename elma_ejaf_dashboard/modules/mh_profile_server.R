# modules/mh_profile_server.R
mhProfileServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Depression Pie Chart Data
    depression_pie_data <- data.frame(
      Severity = c("None", "Mild", "Moderate", "Moderately Severe", "Severe"),
      Percentage = c(52.3, 32.5, 11.4, 3.4, 0.4),
      Color = c("#2ecc71", "#3498db", "#f39c12", "#e74c3c", "#c0392b"),
      stringsAsFactors = FALSE
    )
    
    # Gender Comparison Data
    gender_comparison_data <- data.frame(
      Severity = rep(c("None", "Mild", "Moderate", "Moderately Severe", "Severe"), 2),
      Gender = c(rep("Female", 5), rep("Male", 5)),
      Percentage = c(50.6, 33.0, 11.6, 4.3, 0.6, 57.5, 31.0, 10.6, 0.9, 0.0),
      stringsAsFactors = FALSE
    )
    
    # Mental Health Conditions Data
    conditions_data <- data.frame(
      Condition = c("Anxiety Disorders", "Depressive Disorders", "Substance Abuse", 
                    "Stress-related Issues", "Eating Disorders", "PTSD"),
      Prevalence = c(55, 47.7, 25, 40, 12, 18),
      Urgency = c("High", "High", "Medium", "High", "Low", "Medium"),
      Color = c("#3498db", "#e74c3c", "#f39c12", "#9b59b6", "#95a5a6", "#34495e"),
      stringsAsFactors = FALSE
    )
    
    # Render Depression Pie Chart
    output$depression_pie_chart <- renderPlotly({
      plot_ly(
        depression_pie_data,
        labels = ~Severity,
        values = ~Percentage,
        type = "pie",
        hole = 0.4,
        marker = list(colors = ~Color),
        textinfo = "label+percent",
        hovertemplate = "<b>%{label}</b><br>Percentage: %{percent}<br>Value: %{value}%<extra></extra>",
        textposition = "outside"
      ) %>%
        layout(
          title = "Depression Severity Distribution (PHQ-9)",
          showlegend = TRUE,
          legend = list(orientation = "h", x = 0.5, y = -0.2, xanchor = "center"),
          annotations = list(
            list(
              text = "47.7%<br>Have Depression",
              x = 0.5, y = 0.5,
              font = list(size = 14, color = "#e74c3c"),
              showarrow = FALSE
            )
          )
        )
    })
    
    # Render Gender Comparison Chart
    output$gender_comparison_chart <- renderPlotly({
      plot_ly(
        gender_comparison_data,
        x = ~Severity,
        y = ~Percentage,
        color = ~Gender,
        type = "bar",
        colors = c("Female" = "#e74c3c", "Male" = "#3498db"),
        text = ~paste0(Percentage, "%"),
        textposition = "outside"
      ) %>%
        layout(
          title = "Depression Severity by Gender",
          xaxis = list(title = "", tickangle = -45, 
                       categoryorder = "array",
                       categoryarray = c("None", "Mild", "Moderate", "Moderately Severe", "Severe")),
          yaxis = list(title = "Percentage (%)", range = c(0, 70)),
          barmode = "group",
          showlegend = TRUE,
          legend = list(orientation = "h", x = 0.5, y = -0.3, xanchor = "center"),
          margin = list(b = 100, t = 50)
        ) 
    })
    
    # Render Conditions Chart
    output$conditions_chart <- renderPlotly({
      plot_ly(
        conditions_data,
        x = ~reorder(Condition, Prevalence),
        y = ~Prevalence,
        type = "bar",
        marker = list(color = ~Color),
        text = ~paste0(Prevalence, "%"),
        textposition = "outside"#,
        # hovertemplate = "<b>%{x}</b><br>Prevalence: %{y}%<br>Urgency: %{text}<extra></extra>",
        # text = ~Urgency
      ) %>%
        layout(
          title = "Prevalent Mental Health Conditions Among AYPs",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Estimated Prevalence (%)", range = c(0, 60)),
          showlegend = FALSE,
          margin = list(b = 100, t = 50)
        )
    })
    
    # Initialize metric cards
    metricCardServer("any_depression", "47.7%")
    metricCardServer("moderate_severe", "15.2%")
    metricCardServer("no_depression", "52.3%")
    metricCardServer("female_depression", "49.6%")
  })
}