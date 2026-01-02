# modules/ayp_behaviors_server.R
aypBehaviorsServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Behavior Components Data
    behavior_components_data <- data.frame(
      Component = c("Mental Health", "Sexual Reproductive Health", "HIV Testing"),
      Max_Score = c(12, 20, 6),
      Average_Score = c(7.2, 11.5, 3.8),
      Contribution = c(31.6, 50.5, 17.9),
      Color = c("#9b59b6", "#e74c3c", "#3498db"),
      stringsAsFactors = FALSE
    )
    
    # Depression Table Data
    depression_table_data <- data.frame(
      Severity = c("None", "Mild", "Moderate", "Moderately Severe", "Severe"),
      Overall = c(52.3, 32.5, 11.4, 3.4, 0.4),
      Female = c(50.6, 33.0, 11.6, 4.3, 0.6),
      Male = c(57.5, 31.0, 10.6, 0.9, 0.0),
      Color = c("#2ecc71", "#3498db", "#f39c12", "#e74c3c", "#c0392b"),
      stringsAsFactors = FALSE
    )
    
    # Information Sources Data
    info_sources_data <- data.frame(
      Source = c("Traditional Media (TV/Radio)", "Word of Mouth (Peers/Friends)", 
                 "Healthcare Providers", "Religious Institutions", 
                 "Social Media Platforms", "Community Health Workers",
                 "Counseling Centers", "Online Resources"),
      Percentage = c(65, 58, 45, 38, 35, 32, 28, 25),
      Category = c("Traditional", "Informal", "Formal", "Traditional", 
                   "Digital", "Formal", "Formal", "Digital"),
      stringsAsFactors = FALSE
    )
    
    # Behavioral Targets Data
    behavior_targets_data <- data.frame(
      Indicator = c("Improved Behaviors", "Depression Screening", 
                    "Information Access", "Peer Education", "Digital Reach"),
      Baseline = c(45.2, 35, 65, 40, 30),
      Target = c(55, 60, 80, 65, 50),
      Improvement = c(9.8, 25, 15, 25, 20),
      Color = c("#2ecc71", "#3498db", "#9b59b6", "#f39c12", "#e74c3c"),
      stringsAsFactors = FALSE
    )
    
    # Render Behavior Components Chart
    output$behavior_components_chart <- renderPlotly({
      plot_ly(
        behavior_components_data,
        x = ~Component,
        y = ~Average_Score,
        type = "bar",
        name = "Average Score",
        marker = list(color = ~Color),
        text = ~paste0(Average_Score, "/", Max_Score),
        textposition = "outside",
        hovertemplate = "<b>%{x}</b><br>Average: %{y}/%{data.max_score}<extra></extra>"
      ) %>%
        layout(
          title = "Behavior Components Distribution",
          xaxis = list(title = ""),
          yaxis = list(title = "Average Score (out of max)", range = c(0, 20)),
          showlegend = FALSE,
          margin = list(b = 80)
        )
    })
    
    # Render Depression Table
    output$depression_table <- renderDT({
      datatable(
        depression_table_data,
        options = list(
          pageLength = 10,
          dom = 't',
          columnDefs = list(
            list(className = 'dt-center', targets = 1:4)
          )
        ),
        rownames = FALSE,
        class = 'compact stripe hover'
      ) %>%
        formatStyle(
          columns = 2:4,
          background = styleColorBar(depression_table_data[, 2:4], '#ffcdd2'),
          backgroundSize = '100% 90%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        )
    })
    
    # Render Depression Chart
    output$depression_chart <- renderPlotly({
      depression_long <- depression_table_data %>%
        pivot_longer(cols = c(Overall, Female, Male), 
                     names_to = "Gender", 
                     values_to = "Percentage")
      
      plot_ly(
        depression_long,
        x = ~Severity,
        y = ~Percentage,
        color = ~Gender,
        type = "bar",
        colors = c("Overall" = "#3498db", "Female" = "#e74c3c", "Male" = "#2ecc71"),
        text = ~paste0(Percentage, "%"),
        textposition = "outside"
      ) %>%
        layout(
          title = "Depression Severity by Gender",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage (%)", range = c(0, 60)),
          barmode = "group",
          showlegend = TRUE,
          legend = list(orientation = "h", x = 0.5, y = -0.3, xanchor = "center"),
          margin = list(b = 100, t = 50)
        )
    })
    
    # Render Info Sources Chart
    output$info_sources_chart <- renderPlotly({
      plot_ly(
        info_sources_data,
        x = ~reorder(Source, Percentage),
        y = ~Percentage,
        color = ~Category,
        type = "bar",
        colors = c("Traditional" = "#3498db", "Informal" = "#2ecc71", 
                   "Formal" = "#9b59b6", "Digital" = "#f39c12"),
        text = ~paste0(Percentage, "%"),
        textposition = "outside",
        hovertemplate = "<b>%{x}</b><br>Percentage: %{y}%<br>Category: %{marker.color}<extra></extra>"
      ) %>%
        layout(
          title = "Communication Channels for Health Information",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage Using Channel (%)", range = c(0, 100)),
          showlegend = TRUE,
          legend = list(orientation = "h", x = 0.5, y = -0.3, xanchor = "center"),
          margin = list(b = 150, t = 50)
        )
    })
    
    # Render Behavior Targets Chart
    output$behavior_targets_chart <- renderPlotly({
      targets_long <- behavior_targets_data %>%
        pivot_longer(cols = c(Baseline, Target), 
                     names_to = "Phase", 
                     values_to = "Value")
      
      plot_ly(
        targets_long,
        x = ~Indicator,
        y = ~Value,
        color = ~Phase,
        type = "bar",
        colors = c("Baseline" = "#3498db", "Target" = "#2ecc71"),
        text = ~paste0(Value, "%"),
        textposition = "outside"
      ) %>%
        layout(
          title = "Behavioral Improvement Targets",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage (%)", range = c(0, 100)),
          barmode = "group",
          showlegend = TRUE,
          legend = list(orientation = "h", x = 0.5, y = -0.3, xanchor = "center"),
          margin = list(b = 100, t = 50)
        )
    })
    
    # Initialize metric cards
    metricCardServer("improved_behaviors", "45.2%")
    metricCardServer("depression_rate", "47.7%")
    metricCardServer("traditional_media", "65%")
    metricCardServer("peer_networks", "High")
  })
}