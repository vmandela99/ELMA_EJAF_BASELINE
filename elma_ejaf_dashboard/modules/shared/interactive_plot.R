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
      switch(plot_type,
             "bar" = create_bar_plot(plot_data),
             "pie" = create_pie_plot(plot_data),
             "line" = create_line_plot(plot_data),
             create_bar_plot(plot_data)
      )
    })
  })
}