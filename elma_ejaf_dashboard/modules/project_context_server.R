# modules/project_context_server.R
projectContextServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Render HIV chart
    textToChartServer("hiv_chart", 
                      data = hiv_data,
                      x_col = "Category",
                      y_col = "Value",
                      text_col = "Label",
                      color = "#e74c3c",
                      show_percent = TRUE)
    
    # Render contraceptive chart
    textToChartServer("contraceptive_chart",
                      data = contraceptive_data,
                      x_col = "Category",
                      y_col = "Value",
                      color = "#3498db",
                      show_percent = TRUE)
    
    # Render pregnancy chart (bar chart for districts)
    output$pregnancy_chart <- renderPlotly({
      plot_ly(
        district_pregnancy,
        x = ~District,
        y = ~Pregnancies,
        type = "bar",
        marker = list(color = ~Pregnancies, 
                      colorscale = "Viridis",
                      showscale = TRUE),
        text = ~paste0(format(Pregnancies, big.mark = ","), " cases"),
        textposition = "outside",
        hovertemplate = paste(
          "<b>%{x}</b><br>",
          "Pregnancies: %{y:,}<br>",
          "Region: ", district_pregnancy$Region,
          "<extra></extra>"
        )
      ) %>%
        layout(
          title = "Adolescent Pregnancies by District (2020)",
          xaxis = list(title = "", tickangle = -45),
          yaxis = list(title = "Number of Pregnancies"),
          showlegend = FALSE,
          margin = list(b = 100)
        )
    })
    
    # Render mental health chart
    textToChartServer("mh_chart",
                      data = mental_health_data,
                      x_col = "Category",
                      y_col = "Value",
                      color = "#9b59b6",
                      show_percent = TRUE)
    
    # Initialize metric cards
    metricCardServer("stat1", context_summary_stats$total_ayp)
    metricCardServer("stat2", context_summary_stats$hiv_new_infections)
    metricCardServer("stat3", context_summary_stats$contraceptive_use)
    metricCardServer("stat4", context_summary_stats$mental_health_disorders)
    
    # Download handler
    output$context_download <- downloadHandler(
      filename = function() {
        "Project_Context_Analysis.pdf"
      },
      content = function(file) {
        # Generate PDF report
        writeLines("Project Context Analysis Report", file)
      }
    )
  })
}