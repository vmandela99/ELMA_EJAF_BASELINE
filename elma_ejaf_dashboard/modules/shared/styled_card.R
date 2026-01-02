# modules/shared/styled_card.R
styledCardUI <- function(id, title, content, 
                         type = "info", 
                         icon = NULL,
                         width = 12,
                         collapsible = TRUE,
                         gradient = TRUE) {
  ns <- NS(id)
  
  # Define colors based on type
  colors <- list(
    info = list(bg = "#3498db", light = "#e3f2fd"),
    success = list(bg = "#2ecc71", light = "#e8f5e9"),
    warning = list(bg = "#f39c12", light = "#fff3e0"),
    danger = list(bg = "#e74c3c", light = "#ffebee"),
    primary = list(bg = "#9b59b6", light = "#f3e5f5")
  )
  
  card_color <- colors[[type]]
  
  if (gradient) {
    gradient_style <- sprintf(
      # "background: linear-gradient(135deg, %s 0%, %s 100%); color: white;",
      "background: linear-gradient(135deg, %s 0%%, %s 100%%); color: white;",
      card_color$bg,
      colorspace::darken(card_color$bg, 0.2)
    )
  } else {
    gradient_style <- sprintf("background: %s; color: #2c3e50;", card_color$light)
  }
  
  bs4Card(
    title = if(!is.null(icon)) tagList(icon(icon), title) else title,
    status = type,
    width = width,
    closable = FALSE,
    collapsible = collapsible,
    elevation = 3,
    div(
      style = gradient_style,
      class = "card-content",
      if (is.character(content)) HTML(content) else content
    )
  )
}

highlightCardUI <- function(id, title, content, 
                            highlight_text = NULL,
                            highlight_color = "#3498db") {
  ns <- NS(id)
  
  div(
    class = "highlight-card",
    style = sprintf("border-left-color: %s;", highlight_color),
    h5(title, style = "color: #2c3e50; margin-top: 0;"),
    if (!is.null(highlight_text)) {
      div(
        class = "stat-badge",
        style = sprintf("background: %s;", colorspace::lighten(highlight_color, 0.3)),
        highlight_text
      )
    },
    if (is.character(content)) HTML(content) else content
  )
}