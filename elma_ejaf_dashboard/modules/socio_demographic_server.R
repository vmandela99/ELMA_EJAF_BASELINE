# modules/socio_demographic_server.R
socioDemographicServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    # Age Distribution Chart
    output$age_chart <- renderPlotly({
      plot_ly(
        age_data,
        x = ~Age_Group,
        y = ~Overall,
        type = "bar",
        name = "Overall",
        marker = list(color = "#3498db"),
        text = ~paste0(Overall, "%"),
        textposition = "outside"
      ) %>%
        add_trace(
          y = ~Female,
          name = "Female",
          marker = list(color = "#e74c3c")
        ) %>%
        add_trace(
          y = ~Male,
          name = "Male",
          marker = list(color = "#2ecc71")
        ) %>%
        layout(
          title = "Age Distribution by Gender",
          xaxis = list(title = "Age Group", tickangle = -45),
          yaxis = list(title = "Percentage (%)", range = c(0, 100)),
          barmode = "group",
          legend = list(orientation = "h", x = 0.5, y = -0.2, xanchor = "center"),
          margin = list(b = 100)
        )
    })
    
    # Education Level Chart
    output$education_chart <- renderPlotly({
      education_long <- education_data %>%
        pivot_longer(cols = c(Overall, Female, Male), 
                     names_to = "Gender", 
                     values_to = "Percentage")
      
      plot_ly(
        education_long,
        x = ~Level,
        y = ~Percentage,
        color = ~Gender,
        type = "bar",
        colors = c("Overall" = "#3498db", "Female" = "#e74c3c", "Male" = "#2ecc71"),
        text = ~paste0(Percentage, "%"),
        textposition = "outside",
        hovertemplate = "<b>%{x}</b><br>%{data.name}: %{y}%<extra></extra>"
      ) %>%
        layout(
          title = "Education Level Distribution",
          xaxis = list(title = "Education Level", tickangle = -45),
          yaxis = list(title = "Percentage (%)"),
          barmode = "group",
          margin = list(b = 100)
        )
    })
    
    # Poverty Status Chart
    output$poverty_chart <- renderPlotly({
      poverty_long <- poverty_data %>%
        pivot_longer(cols = c(Overall, Female, Male), 
                     names_to = "Gender", 
                     values_to = "Percentage")
      
      plot_ly(
        poverty_long,
        x = ~Status,
        y = ~Percentage,
        color = ~Gender,
        type = "bar",
        colors = c("Overall" = "#3498db", "Female" = "#e74c3c", "Male" = "#2ecc71"),
        text = ~paste0(Percentage, "%"),
        textposition = "outside"
      ) %>%
        layout(
          title = "Poverty Status by Gender (MPI)",
          xaxis = list(title = "Poverty Status"),
          yaxis = list(title = "Percentage (%)", range = c(0, 100)),
          barmode = "group",
          showlegend = TRUE
        )
    })
    
    # Sexual Behavior Chart
    output$sexual_behavior_chart <- renderPlotly({
      sexual_long <- sexual_behavior_data %>%
        pivot_longer(cols = c(Overall, Female, Male), 
                     names_to = "Gender", 
                     values_to = "Percentage")
      
      plot_ly(
        sexual_long,
        x = ~Behavior,
        y = ~Percentage,
        color = ~Gender,
        type = "bar",
        colors = c("Overall" = "#3498db", "Female" = "#e74c3c", "Male" = "#2ecc71"),
        text = ~paste0(Percentage, "%"),
        textposition = "outside"
      ) %>%
        layout(
          title = "Sexual Behavior by Gender",
          xaxis = list(title = "Behavior", tickangle = -45),
          yaxis = list(title = "Percentage (%)", range = c(0, 100)),
          barmode = "group",
          margin = list(b = 80)
        )
    })
    
    # CEI Data Table
    output$cei_table <- renderDT({
      datatable(
        cei_demographics,
        options = list(
          pageLength = 10,
          dom = 't',
          columnDefs = list(
            list(className = 'dt-center', targets = 1:2)
          )
        ),
        rownames = FALSE,
        class = 'compact stripe hover'
      ) %>%
        formatStyle(
          'Percentage',
          background = styleColorBar(cei_demographics$Percentage, '#3498db'),
          backgroundSize = '100% 90%',
          backgroundRepeat = 'no-repeat',
          backgroundPosition = 'center'
        )
    })
    
    # Initialize metric cards
    metricCardServer("total_ayp", sample_summary$total_ayp)
    metricCardServer("females", sample_summary$females)
    metricCardServer("males", sample_summary$males)
    metricCardServer("mpi_poor", paste0(sample_summary$mpi_poor, "%"))
    
    # Download handler
    output$download_demographics <- downloadHandler(
      filename = function() {
        "SocioDemographic_Analysis.pdf"
      },
      content = function(file) {
        # Generate PDF report
        writeLines("Socio-Demographic Analysis Report", file)
      }
    )
  })
}