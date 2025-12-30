# modules/shared/download_card.R
downloadCardUI <- function(id, title, content_text, filename, button_label = "Download", 
                           icon_name = "download", color = "success") {
  ns <- NS(id)
  bs4Card(
    title = title,
    status = color,
    width = 12,
    closable = FALSE,
    collapsible = TRUE,
    div(
      p(content_text),
      downloadButton(ns("download"), button_label, class = paste0("btn-", color))
    )
  )
}

downloadCardServer <- function(id, filename, content_function) {
  moduleServer(id, function(input, output, session) {
    output$download <- downloadHandler(
      filename = function() {
        filename
      },
      content = function(file) {
        content_function(file)
      }
    )
  })
}