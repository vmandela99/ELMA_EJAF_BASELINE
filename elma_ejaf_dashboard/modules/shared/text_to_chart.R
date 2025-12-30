# modules/shared/text_to_chart.R
textToChartUI <- function(id, title, chart_type = "bar", height = "400px") {
  ns <- NS(id)  # <-- Add this line
  
  bs4Card(
    title = title,
    status = "primary",
    width = 12,
    closable = FALSE,
    collapsible = TRUE,
    maximizable = TRUE,
    plotlyOutput(ns("chart"), height = height)  # <-- Use ns() here
  )
}

textToChartServer <- function(id, data, x_col = "Category", y_col = "Value", 
                              text_col = "Label", color = "#3498db", 
                              show_percent = TRUE) {
  moduleServer(id, function(input, output, session) {
    
    output$chart <- renderPlotly({
      if (nrow(data) == 0) return(plotly_empty())
      
      # Sort data by value
      data <- data %>%
        arrange(desc(.data[[y_col]]))
      
      # Create base plot
      p <- plot_ly(
        data,
        x = ~get(x_col),
        y = ~get(y_col),
        type = "bar",
        marker = list(color = color),
        text = if(show_percent) ~paste0(get(y_col), "%") else ~get(y_col),
        textposition = "outside",
        hovertemplate = paste(
          "<b>%{x}</b><br>",
          "Value: %{y}<br>",
          "<extra></extra>"
        )
      )
      
      # Add percentage labels if enabled
      if (show_percent) {
        p <- p %>% add_text(
          text = ~paste0(get(y_col), "%"),
          textposition = "top",
          showlegend = FALSE,
          textfont = list(size = 12, color = "#2c3e50")
        )
      }
      
      # Customize layout
      p <- p %>% layout(
        xaxis = list(
          title = "",
          categoryorder = "array",
          categoryarray = data[[x_col]],
          tickangle = -45
        ),
        yaxis = list(
          title = if(show_percent) "Percentage (%)" else "Value",
          range = if(show_percent) c(0, 100) else NULL
        ),
        showlegend = FALSE,
        margin = list(b = 100)
      )
      
      return(p)
    })
  })
}



# Helper function to extract data from text
extract_percentage_data <- function(text) {
  # This is a simplified version - in production, you'd use NLP or regex patterns
  patterns <- list(
    "HIV prevalence" = "\\d+\\.?\\d*%",
    "contraceptive use" = "\\d+\\.?\\d*%",
    "mental health" = "\\d+\\.?\\d*%"
  )
  
  # Placeholder data - replace with actual extraction logic
  data.frame(
    Category = character(),
    Value = numeric(),
    Label = character(),
    stringsAsFactors = FALSE
  )
}