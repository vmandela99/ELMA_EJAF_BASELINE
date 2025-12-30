# data/study_design_data.R

# Study Design Components
study_design_data <- data.frame(
  Component = c("Quantitative Survey", "Qualitative Interviews", 
                "Client Exit Interviews", "Mystery Client Visits",
                "Focus Group Discussions", "Document Review"),
  Count = c(465, 26, 250, 4, 2, 10),
  Color = c("#3498db", "#2ecc71", "#e74c3c", "#f39c12", "#9b59b6", "#34495e"),
  Description = c("AYP face-to-face interviews", "IDIs with providers & stakeholders",
                  "Post-service interviews", "Quality monitoring visits",
                  "Group discussions with AYP", "Policy and program documents"),
  stringsAsFactors = FALSE
)

# Timeline Data
study_timeline <- data.frame(
  Phase = c("Planning", "Training", "Data Collection", "Analysis", "Reporting"),
  Start = as.Date(c("2023-12-01", "2024-01-01", "2024-01-04", "2024-01-25", "2024-02-01")),
  End = as.Date(c("2023-12-31", "2024-01-03", "2024-01-24", "2024-01-31", "2024-02-15")),
  Progress = c(100, 100, 100, 80, 60)
)