# modules/hiv_knowledge_server.R
hivKnowledgeServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Knowledge Components Data
    knowledge_components_data <- data.frame(
      Component = c("HIV Testing Knowledge", "ART Knowledge", "PrEP Knowledge"),
      Statements = c(12, 10, 9),
      Adequate_Knowledge = c(52, 50, 45),
      Target = c(62, 60, 55),
      Color = c("#3498db", "#2ecc71", "#9b59b6"),
      stringsAsFactors = FALSE
    )
    
    # Attitudes Components Data
    attitudes_components_data <- data.frame(
      Component = c("HIV Testing Attitudes", "ART Attitudes", "PrEP Attitudes"),
      Statements = c(6, 9, 7),
      Positive_Attitudes = c(55, 52, 43),
      Target = c(65, 62, 53),
      Color = c("#e74c3c", "#f39c12", "#34495e"),
      stringsAsFactors = FALSE
    )
    
    # Transmission Awareness Data for Table
    transmission_table_data <- data.frame(
      Transmission_Mode = c("Having oral sex", "Sharing needles", "Blood transfusion (unscreened)",
                            "Bathing in same water (MYTH)", "Mosquito bites (MYTH)", 
                            "Sharing silverware (MYTH)"),
      Correct_Answer = c("TRUE", "TRUE", "TRUE", "FALSE", "FALSE", "FALSE"),
      Correctly_Identified = c(84, 98, 94, 86.6, 23, 27),
      Category = c("Actual", "Actual", "Actual", "Myth", "Myth", "Myth"),
      stringsAsFactors = FALSE
    )
    
    # Risk Reduction Awareness Data
    risk_reduction_data <- data.frame(
      Method = c("Correct condom use", "New needles", "Abstinence", "PrEP"),
      Percentage = c(97, 94, 95, 54),
      stringsAsFactors = FALSE
    )
    
    # Progress Data
    progress_data <- data.frame(
      Indicator = rep(c("HIV Knowledge", "Positive Attitudes"), each = 3),
      Phase = rep(c("Baseline", "Endline Target", "Gap"), 2),
      Value = c(48.6, 58, 9.4, 49.9, 57, 7.1),
      Group = c("Knowledge", "Knowledge", "Knowledge", "Attitudes", "Attitudes", "Attitudes"),
      stringsAsFactors = FALSE
    )
    
    # Render Knowledge Components Chart
    output$knowledge_components_chart <- renderPlotly({
      plot_ly(
        knowledge_components_data,
        x = ~Component,
        y = ~Adequate_Knowledge,
        type = "bar",
        name = "Current",
        marker = list(color = ~Color),
        text = ~paste0(Adequate_Knowledge, "%"),
        textposition = "outside"
      ) %>%
        add_trace(
          y = ~Target,
          name = "Target",
          marker = list(color = "#95a5a6", line = list(color = "#7f8c8d", width = 2))
        ) %>%
        layout(
          title = "Knowledge Components Breakdown",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage with Adequate Knowledge (%)", range = c(0, 100)),
          barmode = "group",
          showlegend = FALSE,
          legend = list(orientation = "h", x = 0.5, y = -0.2, xanchor = "center"),
          margin = list(b = 80)
        )
    })
    
    # Render Attitudes Chart
    output$attitudes_chart <- renderPlotly({
      plot_ly(
        attitudes_components_data,
        x = ~Component,
        y = ~Positive_Attitudes,
        type = "bar",
        name = "Current",
        marker = list(color = ~Color),
        text = ~paste0(Positive_Attitudes, "%"),
        textposition = "outside"
      ) %>%
        # add_trace(
        #   y = ~Target,
        #   name = "Target",
        #   marker = list(color = "#bdc3c7", line = list(color = "#7f8c8d", width = 2))
        # ) %>%
        layout(
          title = "Attitudes Assessment Components",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage with Positive Attitudes (%)", range = c(0, 100)),
          barmode = "group",
          showlegend = FALSE,
          legend = list(orientation = "h", x = 0.5, y = -0.2, xanchor = "center"),
          margin = list(b = 80)
        )
    })
    
    # Render Transmission Table
    output$transmission_table <- renderDT({
      datatable(
        transmission_table_data,
        options = list(
          pageLength = 10,
          dom = 't',
          columnDefs = list(
            list(className = 'dt-center', targets = 1:3)
          )
        ),
        rownames = FALSE,
        class = 'compact stripe hover'
      ) %>%
        formatStyle(
          'Correctly_Identified',
          background = styleColorBar(transmission_table_data$Correctly_Identified, '#3498db'),
          backgroundSize = '100% 90%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        ) %>%
        formatStyle(
          'Category',
          backgroundColor = styleEqual(
            c("Actual", "Myth"),
            c('#e8f5e9', '#ffebee')
          )
        )
    })
    
    # Render Risk Reduction Chart
    output$risk_reduction_chart <- renderPlotly({
      plot_ly(
        risk_reduction_data,
        x = ~reorder(Method, Percentage),
        y = ~Percentage,
        type = "bar",
        marker = list(color = c("#2ecc71", "#3498db", "#9b59b6", "#f39c12")),
        text = ~paste0(Percentage, "%"),
        textposition = "outside",
        hovertemplate = "<b>%{x}</b><br>Percentage: %{y}%<extra></extra>"
      ) %>%
        layout(
          title = "Awareness of HIV Risk Reduction Methods",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage Aware (%)", range = c(0, 100)),
          showlegend = FALSE,
          margin = list(b = 100, t = 50)
        )
    })
    
    # Render Progress Chart
    output$progress_chart <- renderPlotly({
      plot_ly(
        progress_data[progress_data$Phase != "Gap",],
        x = ~Indicator,
        y = ~Value,
        color = ~Phase,
        type = "bar",
        colors = c("Baseline" = "#3498db", "Endline Target" = "#2ecc71"),
        text = ~paste0(Value, "%"),
        textposition = "outside"
      ) %>%
        layout(
          title = "Baseline vs Endline Targets",
          xaxis = list(title = ""),
          yaxis = list(title = "Percentage (%)", range = c(0, 70)),
          barmode = "group",
          showlegend = TRUE,
          legend = list(orientation = "h", x = 0.5, y = -0.2, xanchor = "center")
        )
    })
    
    # Initialize metric cards
    metricCardServer("hiv_knowledge", "48.6%")
    metricCardServer("positive_attitudes", "49.9%")
    metricCardServer("condom_knowledge", "97%")
    metricCardServer("prep_awareness", "45%")
  })
}