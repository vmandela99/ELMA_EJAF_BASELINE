# modules/sampling_methods_server.R
samplingMethodsServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Sample data
    sample_data <- data.frame(
      Method = c("Survey", "FGDs", "KIIs"),
      Sample_Size = c(1250, 240, 18),
      Age_Range = c("15-24", "16-24", "18+"),
      Gender_Ratio = c("55% F, 45% M", "50% F, 50% M", "60% F, 40% M"),
      Locations = c("5 districts", "Urban areas", "Mixed")
    )
    
    output$sample_table <- renderDT({
      datatable(
        sample_data,
        options = list(
          pageLength = 5,
          dom = 't'
        ),
        rownames = FALSE
      )
    })
    
    output$sampling_flow <- renderPlotly({
      # Create sampling flow diagram
      nodes <- data.frame(
        name = c("Total Population", "Sampling Frame", "Clusters", "Households", "Individuals", "Final Sample"),
        x = c(0, 1, 2, 3, 4, 5),
        y = c(0, 0, 0, 0, 0, 0)
      )
      
      plot_ly(
        type = "scatter",
        mode = "lines+markers+text",
        x = nodes$x,
        y = nodes$y,
        text = nodes$name,
        textposition = "top center",
        marker = list(size = 20, color = "#3498db"),
        line = list(color = "#7f8c8d", width = 2)
      ) %>%
        layout(
          title = "Sampling Flow Diagram",
          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
          showlegend = FALSE
        )
    })
    
    output$download_methodology <- downloadHandler(
      filename = function() {
        "Sampling_Methodology.docx"
      },
      content = function(file) {
        writeLines("Detailed sampling methodology", file)
      }
    )
  })
}