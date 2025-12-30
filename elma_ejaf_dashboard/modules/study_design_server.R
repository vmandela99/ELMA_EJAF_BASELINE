# modules/study_design_server.R
studyDesignServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Study design components chart
    textToChartServer("design_chart",
                      data = study_design_data,
                      x_col = "Component",
                      y_col = "Count",
                      show_percent = FALSE)
    
    # Timeline chart
    output$timeline_chart <- renderPlotly({
      plot_ly(
        study_timeline,
        x = ~Start,
        xend = ~End,
        y = ~Phase,
        yend = ~Phase,
        type = "scatter",
        mode = "lines",
        line = list(color = "#3498db", width = 10),
        hoverinfo = "text",
        text = ~paste("<b>", Phase, "</b><br>",
                      format(Start, "%b %d"), "-", format(End, "%b %d"), "<br>",
                      "Progress: ", Progress, "%")
      ) %>%
        layout(
          title = "Study Implementation Timeline",
          xaxis = list(title = "Timeline"),
          yaxis = list(title = "", autorange = "reversed"),
          showlegend = FALSE
        )
    })
    
    # Sampling summary table
    output$sampling_summary <- renderDT({
      datatable(
        data.frame(
          Component = c("AYP Survey", "Client Exit Interviews", "YAPs Interviews", 
                        "In-depth Interviews", "FGDs", "Mystery Client"),
          Target = c(595, 250, 30, 31, 2, 5),
          Achieved = c(465, 250, 15, 26, 2, 4),
          Response_Rate = c("78.2%", "100%", "50%", "83.9%", "100%", "80%")
        ),
        options = list(
          pageLength = 10,
          dom = 't',
          columnDefs = list(
            list(className = 'dt-center', targets = 1:3)
          )
        ),
        rownames = FALSE
      )
    })
  })
}