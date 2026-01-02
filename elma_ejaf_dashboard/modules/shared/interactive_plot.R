# modules/shared/interactive_plot.R
interactivePlotUI <- function(id, title, plot_height = "400px") {
  ns <- NS(id)
  bs4Card(
    title = title,
    status = "primary",
    width = 12,
    closable = FALSE,
    collapsible = TRUE,
    maximizable = TRUE,
    plotlyOutput(ns("plot"), height = plot_height)
  )
}


interactivePlotServer <- function(id, plot_data, plot_type = "bar") {
  moduleServer(id, function(input, output, session) {
    output$plot <- renderPlotly({
      # Create plot based on type
      if (plot_type == "bar") {
        plot_ly(
          plot_data,
          x = ~x,
          y = ~y,
          type = "bar",
          marker = list(color = "#3498db")
        ) %>%
          layout(
            xaxis = list(title = plot_data$x_title),
            yaxis = list(title = plot_data$y_title)
          )
      } else if (plot_type == "pie") {
        plot_ly(
          plot_data,
          labels = ~labels,
          values = ~values,
          type = "pie",
          hole = 0.3
        )
      }
    })
  })
}