# modules/awareness_knowledge_server.R
awarenessKnowledgeServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Load awareness data
    mh_awareness_data <- data.frame(
      Category = c("High Awareness", "Moderate Awareness", "Low Awareness", 
                   "No Awareness", "Misconceptions"),
      Value = c(65, 25, 7, 3, 45),
      Label = c("65% can identify disorders", "25% basic knowledge", 
                "7% limited understanding", "3% completely unaware", 
                "45% have misconceptions"),
      Color = c("#2ecc71", "#3498db", "#f39c12", "#e74c3c", "#9b59b6"),
      stringsAsFactors = FALSE
    )
    
    # Stigma indicators data
    stigma_data <- data.frame(
      Indicator = c("Would seek professional help", 
                    "Would tell friends about MH issues",
                    "Believe MH issues are personal weakness",
                    "Think MH issues are contagious",
                    "Would date someone with MH history"),
      Percentage = c(35, 28, 42, 18, 25),
      Response_Type = c("Positive", "Positive", "Negative", "Negative", "Positive"),
      stringsAsFactors = FALSE
    )
    
    # HIV knowledge data
    hiv_knowledge_data <- data.frame(
      Question = c("Knows HIV transmission modes", 
                   "Knows prevention methods",
                   "Aware of PrEP existence",
                   "Knows ART benefits",
                   "Understands viral suppression"),
      Correct_Answers = c(85, 78, 45, 62, 55),
      Age_Group = c("All", "All", "18-24", "All", "20-24"),
      stringsAsFactors = FALSE
    )
    
    # PrEP awareness data
    prep_data <- data.frame(
      Category = c("Heard of PrEP", 
                   "Knows where to get PrEP",
                   "Knows PrEP is daily medication",
                   "Believes PrEP is effective",
                   "Would recommend PrEP to peers"),
      Percentage = c(45, 28, 32, 41, 38),
      Gender = c("Both", "Both", "Both", "Both", "Both"),
      stringsAsFactors = FALSE
    )
    
    # Attitudes towards HIV services
    hiv_attitudes_data <- data.frame(
      Statement = c("Comfortable with HIV testing", 
                    "Willing to disclose HIV status",
                    "Would support HIV+ partner",
                    "Believe stigma is decreasing",
                    "Trust healthcare providers"),
      Agreement = c(72, 45, 68, 52, 78),
      Age_Category = c("15-19", "20-24", "15-24", "15-24", "15-24"),
      stringsAsFactors = FALSE
    )
    
    # Mental health empowerment data
    mh_empowerment_data <- data.frame(
      Aspect = c("Can identify symptoms", 
                 "Knows coping strategies",
                 "Accesses MH resources",
                 "Supports peers with MH issues",
                 "Advocates for MH services"),
      Empowerment_Level = c(58, 42, 35, 52, 28),
      Improvement_Needed = c(42, 58, 65, 48, 72),
      stringsAsFactors = FALSE
    )
    
    # Service awareness data
    service_awareness_data <- data.frame(
      Service = c("Youth-friendly clinics", 
                  "School-based services",
                  "Peer support groups",
                  "Telehealth options",
                  "Community outreach"),
      Awareness = c(62, 45, 38, 28, 55),
      Utilization = c(35, 22, 18, 12, 32),
      stringsAsFactors = FALSE
    )
    
    # Render Mental Health Awareness Chart
    textToChartServer("mh_awareness", 
                      data = mh_awareness_data,
                      x_col = "Category",
                      y_col = "Value",
                      text_col = "Label",
                      color = "#3498db",
                      show_percent = TRUE)
    
    # Render Stigma Indicators Chart with custom colors
    output$mh_stigma <- renderPlotly({
      # Create custom color scale based on response type
      colors <- ifelse(stigma_data$Response_Type == "Positive", "#2ecc71", "#e74c3c")
      
      plot_ly(
        stigma_data,
        x = ~Indicator,
        y = ~Percentage,
        type = "bar",
        marker = list(color = colors),
        text = ~paste0(Percentage, "%"),
        textposition = "outside",
        hoverinfo = "text",
        hovertext = ~paste0("<b>", Indicator, "</b><br>",
                            "Percentage: ", Percentage, "%<br>",
                            "Response Type: ", Response_Type)
      ) %>%
        layout(
          title = "Mental Health Stigma Indicators",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage (%)", range = c(0, 100)),
          showlegend = FALSE,
          margin = list(b = 120)
        )
    })
    
    # Render HIV Knowledge Chart
    textToChartServer("hiv_knowledge",
                      data = hiv_knowledge_data,
                      x_col = "Question",
                      y_col = "Correct_Answers",
                      color = "#e74c3c",
                      show_percent = TRUE)
    
    # Render PrEP Awareness Chart
    textToChartServer("prep_knowledge",
                      data = prep_data,
                      x_col = "Category",
                      y_col = "Percentage",
                      color = "#9b59b6",
                      show_percent = TRUE)
    
    # Additional outputs for the tab panels
    output$hiv_attitudes_chart <- renderPlotly({
      plot_ly(
        hiv_attitudes_data,
        x = ~Statement,
        y = ~Agreement,
        type = "bar",
        marker = list(color = "#3498db"),
        text = ~paste0(Agreement, "%"),
        textposition = "outside",
        hoverinfo = "text",
        hovertext = ~paste0("<b>", Statement, "</b><br>",
                            "Agreement: ", Agreement, "%<br>",
                            "Age Group: ", Age_Category)
      ) %>%
        layout(
          title = "Attitudes Towards HIV Services",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage Agreeing (%)", range = c(0, 100)),
          margin = list(b = 100)
        )
    })
    
    output$mh_empowerment_chart <- renderPlotly({
      plot_ly(
        mh_empowerment_data,
        x = ~Aspect,
        y = ~Empowerment_Level,
        type = "bar",
        name = "Current Level",
        marker = list(color = "#2ecc71"),
        text = ~paste0(Empowerment_Level, "%"),
        textposition = "outside"
      ) %>%
        add_trace(
          y = ~Improvement_Needed,
          name = "Improvement Needed",
          marker = list(color = "#f39c12")
        ) %>%
        layout(
          title = "Mental Health Empowerment Levels",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage (%)", range = c(0, 100)),
          barmode = "group",
          margin = list(b = 100)
        )
    })
    
    output$service_awareness_chart <- renderPlotly({
      plot_ly(
        service_awareness_data,
        x = ~Service,
        y = ~Awareness,
        type = "bar",
        name = "Awareness",
        marker = list(color = "#3498db"),
        text = ~paste0(Awareness, "%"),
        textposition = "outside"
      ) %>%
        add_trace(
          y = ~Utilization,
          name = "Utilization",
          marker = list(color = "#9b59b6"),
          text = ~paste0(Utilization, "%"),
          textposition = "outside"
        ) %>%
        layout(
          title = "Service Awareness vs Utilization",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Percentage (%)", range = c(0, 100)),
          barmode = "group",
          margin = list(b = 100)
        )
    })
    
    # Download handler for awareness data
    output$download_awareness_data <- downloadHandler(
      filename = function() {
        paste0("awareness_knowledge_data_", Sys.Date(), ".csv")
      },
      content = function(file) {
        combined_data <- data.frame(
          Metric = c(
            mh_awareness_data$Category,
            stigma_data$Indicator,
            hiv_knowledge_data$Question,
            prep_data$Category
          ),
          Value = c(
            mh_awareness_data$Value,
            stigma_data$Percentage,
            hiv_knowledge_data$Correct_Answers,
            prep_data$Percentage
          ),
          Category = c(
            rep("MH Awareness", nrow(mh_awareness_data)),
            rep("Stigma Indicators", nrow(stigma_data)),
            rep("HIV Knowledge", nrow(hiv_knowledge_data)),
            rep("PrEP Awareness", nrow(prep_data))
          ),
          Date_Collected = Sys.Date()
        )
        write.csv(combined_data, file, row.names = FALSE)
      }
    )
    
    # Reactive summary statistics
    awareness_summary <- reactive({
      list(
        avg_mh_awareness = mean(mh_awareness_data$Value, na.rm = TRUE),
        avg_hiv_knowledge = mean(hiv_knowledge_data$Correct_Answers, na.rm = TRUE),
        avg_prep_awareness = mean(prep_data$Percentage, na.rm = TRUE),
        stigma_level = mean(stigma_data$Percentage[stigma_data$Response_Type == "Negative"], na.rm = TRUE),
        total_indicators = nrow(mh_awareness_data) + nrow(stigma_data) + 
          nrow(hiv_knowledge_data) + nrow(prep_data)
      )
    })
    
    # Output summary statistics
    output$awareness_summary <- renderText({
      summary <- awareness_summary()
      paste(
        "Summary Statistics:<br>",
        "• Average MH Awareness: ", round(summary$avg_mh_awareness, 1), "%<br>",
        "• Average HIV Knowledge: ", round(summary$avg_hiv_knowledge, 1), "%<br>",
        "• Average PrEP Awareness: ", round(summary$avg_prep_awareness, 1), "%<br>",
        "• Stigma Level: ", round(summary$stigma_level, 1), "%<br>",
        "• Total Indicators: ", summary$total_indicators
      )
    })
    
    # Data table for detailed view
    output$awareness_table <- renderDT({
      detailed_data <- rbind(
        data.frame(
          Type = "MH Awareness",
          Indicator = mh_awareness_data$Category,
          Value = paste0(mh_awareness_data$Value, "%"),
          Description = mh_awareness_data$Label
        ),
        data.frame(
          Type = "Stigma",
          Indicator = stigma_data$Indicator,
          Value = paste0(stigma_data$Percentage, "%"),
          Description = paste("Response Type:", stigma_data$Response_Type)
        ),
        data.frame(
          Type = "HIV Knowledge",
          Indicator = hiv_knowledge_data$Question,
          Value = paste0(hiv_knowledge_data$Correct_Answers, "%"),
          Description = paste("Age Group:", hiv_knowledge_data$Age_Group)
        ),
        data.frame(
          Type = "PrEP Awareness",
          Indicator = prep_data$Category,
          Value = paste0(prep_data$Percentage, "%"),
          Description = paste("Gender:", prep_data$Gender)
        )
      )
      
      datatable(
        detailed_data,
        options = list(
          pageLength = 10,
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel', 'pdf'),
          scrollX = TRUE
        ),
        extensions = 'Buttons',
        rownames = FALSE,
        class = 'display compact'
      )
    })
    
    # Observe tab changes for additional content
    observe({
      # This can be used to trigger specific actions when tabs change
      # For example, loading additional data when a tab is selected
    })
    
  })
}