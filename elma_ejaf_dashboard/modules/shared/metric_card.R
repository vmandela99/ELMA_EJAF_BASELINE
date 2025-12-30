# modules/shared/metric_card.R
metricCardUI <- function(id, title, value, subtitle = NULL, icon = NULL, color = "primary") {
  ns <- NS(id)
  bs4ValueBox(
    value = h3(value),
    subtitle = if(!is.null(subtitle)) subtitle else title,
    icon = if(!is.null(icon)) icon(icon),
    color = color,
    width = 3,
    footer = div(style = "height: 4px;")
  )
}

metricCardServer <- function(id, value_data) {
  moduleServer(id, function(input, output, session) {
    # Server logic if needed
    reactive({ value_data })
  })
}