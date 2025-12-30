# modules/overview_server.R
overviewServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$overview_timeline <- renderPlotly({
      plot_ly(
        x = c("Jan 2023", "Mar 2023", "Jun 2023", "Sep 2023", "Dec 2023"),
        y = c(1, 2, 3, 2, 1),
        type = "scatter",
        mode = "lines+markers",
        name = "Study Progress"
      ) %>%
        layout(
          title = "Study Implementation Timeline",
          xaxis = list(title = "Timeline"),
          yaxis = list(title = "Activity Intensity")
        )
    })
    
    output$download_summary <- downloadHandler(
      filename = function() {
        "Tiko_Study_Executive_Summary.pdf"
      },
      content = function(file) {
        # Generate PDF content
        writeLines("Executive Summary Content", file)
      }
    )
    
    # Initialize metric cards
    metricCardServer("overview1", "1,250")
    metricCardServer("overview2", "24")
    metricCardServer("overview3", "18")
  })
}