# data/project_context_data.R

# HIV Statistics
hiv_data <- data.frame(
  Category = c("AYP share of new infections", "Female HIV infection rate", 
               "Male HIV infection rate", "Sex workers HIV prevalence", 
               "MSM HIV prevalence", "Young population (15-24 years)"),
  Value = c(60, 35, 13.7, 36, 13.7, 20),
  Label = c("60% of new HIV infections", "35-37% prevalence", 
            "13.7% prevalence", "35-37% prevalence", "13.7% prevalence", 
            "20% of population"),
  Color = c("#e74c3c", "#e74c3c", "#3498db", "#9b59b6", "#9b59b6", "#2ecc71"),
  stringsAsFactors = FALSE
)

# Contraceptive Statistics
contraceptive_data <- data.frame(
  Category = c("Modern contraceptive prevalence (15-19)", 
               "Unmet need for family planning (15-24)",
               "Current modern contraception use",
               "Target modern contraception use",
               "Adolescent pregnancy prevalence"),
  Value = c(9.4, 30, 35, 67, 25),
  Label = c("9.4% among adolescents 15-19", ">30% unmet need",
            "35% of sexually active girls/women", "67% target for 2040",
            "25% adolescent pregnancy rate"),
  Color = c("#3498db", "#e74c3c", "#f39c12", "#2ecc71", "#9b59b6"),
  stringsAsFactors = FALSE
)

# District Pregnancy Data
district_pregnancy <- data.frame(
  District = c("Wakiso", "Kampala", "Kasese", "Kamuli", "Oyam", "Mayuge"),
  Pregnancies = c(10439, 8460, 7319, 6535, 6449, 6205),
  Region = c("Central", "Central", "Western", "Eastern", "Northern", "Eastern"),
  stringsAsFactors = FALSE
)

# Mental Health Statistics
mental_health_data <- data.frame(
  Category = c("Young people with mental disorders", 
               "Condom non-use with MH issues",
               "STI rate with MH issues",
               "Unintended pregnancies with MH issues",
               "Multiple partners with MH issues"),
  Value = c(12.5, 40, 30, 35, 45),
  Label = c("12.5% of young people", "40% less likely to use condoms",
            "30% higher STI rates", "35% more unintended pregnancies",
            "45% more multiple partners"),
  Color = c("#9b59b6", "#e74c3c", "#f39c12", "#3498db", "#2ecc71"),
  stringsAsFactors = FALSE
)

# Summary Statistics for Cards
context_summary_stats <- list(
  total_ayp = "8.2M",
  hiv_new_infections = "60%",
  contraceptive_use = "9.4%",
  mental_health_disorders = "12.5%",
  adolescent_pregnancy = "25%"
)