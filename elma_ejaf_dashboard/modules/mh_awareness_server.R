# modules/mh_awareness_server.R
mhAwarenessServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Mental Health Status Data
    mh_status_data <- data.frame(
      Status = c("Excellent", "Somewhat Good", "Neutral", "Somewhat Poor", "Very Poor"),
      Percentage = c(33.8, 33.3, 19.0, 10.5, 3.4),
      Male = c(42, 30, 18, 7, 3),
      Female = c(31, 34, 19, 12, 4),
      Color = c("#2ecc71", "#3498db", "#f39c12", "#e74c3c", "#95a5a6"),
      stringsAsFactors = FALSE
    )
    
    # Stress Causes Data
    stress_causes_data <- data.frame(
      Cause = c("Financial constraints", "Relationship problems", "Academic pressure", 
                "Family issues", "Health problems", "Unemployment", "Other"),
      Percentage = c(29, 18, 15, 12, 10, 8, 8),
      stringsAsFactors = FALSE
    )
    
    # Self-Esteem Indicators Data
    self_esteem_data <- data.frame(
      Statement = c("I can do things as well as most people",
                    "I feel I have good qualities",
                    "I take a positive attitude toward myself",
                    "On the whole, I am satisfied with myself",
                    "I feel useless at times",
                    "I wish I could have more respect for myself",
                    "I feel I don't have much to be proud of"),
      Agree_Percentage = c(95, 88, 82, 76, 31, 85, 49),
      Type = c("Positive", "Positive", "Positive", "Positive", "Negative", "Negative", "Negative"),
      stringsAsFactors = FALSE
    )
    
    # Support Awareness Data
    support_awareness_data <- data.frame(
      Statement = c("Know where to seek mental health support",
                    "People in community would support me",
                    "Would tell friends about MH issues",
                    "Would seek professional help"),
      Percentage = c(63, 41, 28, 35),
      Category = c("Knowledge", "Perceived Support", "Disclosure", "Help-Seeking"),
      stringsAsFactors = FALSE
    )
    
    # Perceptions Data for Table
    perceptions_table_data <- data.frame(
      Perception = c("MH problems visible through physical appearance",
                     "MH sufferers cannot make friends",
                     "Anyone can suffer from MH problems",
                     "People with MH problems are insane",
                     "Wouldn't tell friends about MH disorder",
                     "Only weak people affected by MH problems"),
      Strongly_Agree = c(31.8, 11.8, 58.7, 7.5, 13.8, 6.9),
      Agree = c(37.2, 21.9, 32.9, 20.4, 28.2, 25.4),
      Neutral = c(5.4, 9.0, 2.2, 12.3, 6.5, 13.8),
      Disagree = c(20.2, 43.2, 4.7, 43.7, 37.0, 41.7),
      Strongly_Disagree = c(5.4, 14.0, 1.5, 16.1, 14.6, 12.3),
      stringsAsFactors = FALSE
    )
    
    # MH Factors Table Data
    mh_factors_data <- data.frame(
      Variable = c("Poverty Status", "Sex", "Age Group"),
      Total = c(465, 465, 465),
      Negative_Perceptions = c("70/264 (26.5%)", "62/264 (23%)", "40/264 (15%)"),
      Positive_Perceptions = c("51/201 (25%)", "51/201 (25%)", "38/201 (19%)"),
      Chi_Square = c("0.077", "0.221", "1.869"),
      P_Value = c("0.781", "0.638", "0.393"),
      Significance = c("Not Significant", "Not Significant", "Not Significant"),
      stringsAsFactors = FALSE
    )
    
    # Render Stress Causes Chart
    output$stress_causes_chart <- renderPlotly({
      plot_ly(
        stress_causes_data,
        x = ~reorder(Cause, Percentage),
        y = ~Percentage,
        type = "bar",
        marker = list(color = "#e74c3c"),
        text = ~paste0(Percentage, "%"),
        textposition = "outside",
        hovertemplate = "<b>%{x}</b><br>Percentage: %{y}%<extra></extra>"
      ) %>%
        layout(
          title = "Leading Causes of Stress Among AYPs",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage (%)", range = c(0, 35)),
          showlegend = FALSE,
          margin = list(b = 100)
        )
    })
    
    # Render Self-Esteem Chart
    output$self_esteem_chart <- renderPlotly({
      # Create color vector based on type
      colors <- ifelse(self_esteem_data$Type == "Positive", "#2ecc71", "#e74c3c")
      
      plot_ly(
        self_esteem_data,
        x = ~reorder(Statement, Agree_Percentage),
        y = ~Agree_Percentage,
        type = "bar",
        marker = list(color = colors),
        text = ~paste0(Agree_Percentage, "%"),
        textposition = "outside",
        hovertemplate = "<b>%{x}</b><br>Agree/Strongly Agree: %{y}%<extra></extra>"
      ) %>%
        layout(
          title = "Self-Esteem Indicators (Rosenberg Scale)",
          xaxis = list(title = "", tickangle = -45, showticklabels = FALSE),
          yaxis = list(title = "Percentage Agreeing (%)", range = c(0, 100)),
          showlegend = FALSE,
          margin = list(b = 50)
        ) %>%
        add_annotations(
          x = 1:7,
          y = self_esteem_data$Agree_Percentage + 5,
          text = self_esteem_data$Statement,
          xref = "x",
          yref = "y",
          showarrow = FALSE,
          font = list(size = 10),
          xanchor = "right",
          textangle = -45
        )
    })
    
    # Render Support Awareness Chart
    output$support_awareness_chart <- renderPlotly({
      plot_ly(
        support_awareness_data,
        x = ~reorder(Statement, Percentage),
        y = ~Percentage,
        type = "bar",
        marker = list(color = "#9b59b6"),
        text = ~paste0(Percentage, "%"),
        textposition = "outside",
        hovertemplate = "<b>%{x}</b><br>Percentage: %{y}%<extra></extra>"
      ) %>%
        layout(
          title = "Awareness of Mental Health Support Structures",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage (%)", range = c(0, 100)),
          showlegend = FALSE,
          margin = list(b = 100)
        )
    })
    
    # Render Perceptions Table
    output$perceptions_table <- renderDT({
      datatable(
        perceptions_table_data,
        options = list(
          pageLength = 10,
          dom = 't',
          scrollX = TRUE,
          columnDefs = list(
            list(className = 'dt-center', targets = 1:5)
          )
        ),
        rownames = FALSE,
        class = 'compact stripe hover'
      ) %>%
        formatStyle(
          columns = c('Strongly_Agree', 'Agree'),
          backgroundColor = styleInterval(c(20, 40), c('#ffebee', '#ffcdd2', '#f44336')),
          color = styleInterval(30, c('black', 'white'))
        ) %>%
        formatStyle(
          columns = c('Strongly_Disagree', 'Disagree'),
          backgroundColor = styleInterval(c(20, 40), c('#e8f5e9', '#c8e6c9', '#4caf50')),
          color = styleInterval(30, c('black', 'white'))
        )
    })
    
    # Render MH Factors Table
    output$mh_factors_table <- renderDT({
      datatable(
        mh_factors_data,
        options = list(
          pageLength = 10,
          dom = 't',
          columnDefs = list(
            list(className = 'dt-center', targets = 1:7)
          )
        ),
        rownames = FALSE,
        class = 'compact stripe hover'
      ) %>%
        formatStyle(
          'Significance',
          backgroundColor = styleEqual(
            c("Not Significant", "Significant"),
            c('#e8f5e9', '#ffebee')
          )
        ) %>%
        formatStyle(
          'P_Value',
          color = styleInterval(
            c(0.05, 0.01),
            c('#f44336', '#ff9800', '#4caf50')
          )
        )
    })
    
    # Initialize metric cards
    metricCardServer("mh_excellent", "33.8%")
    metricCardServer("mh_good", "33.3%")
    metricCardServer("male_excellent", "42%")
    metricCardServer("stress_financial", "29%")
  })
}