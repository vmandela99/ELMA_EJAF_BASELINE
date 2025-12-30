# utils/helpers.R
create_bar_plot <- function(data) {
  plot_ly(
    data,
    x = ~x,
    y = ~y,
    type = "bar",
    marker = list(color = "#3498db")
  ) %>%
    layout(
      xaxis = list(title = data$x_title),
      yaxis = list(title = data$y_title),
      showlegend = FALSE
    )
}

create_pie_plot <- function(data) {
  plot_ly(
    data,
    labels = ~labels,
    values = ~values,
    type = "pie",
    hole = 0.3,
    marker = list(colors = c("#e74c3c", "#3498db", "#2ecc71", "#f39c12"))
  )
}

create_line_plot <- function(data) {
  plot_ly(
    data,
    x = ~x,
    y = ~y,
    type = "scatter",
    mode = "lines+markers"
  )
}