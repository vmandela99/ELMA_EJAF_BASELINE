# data/socio_demographic_data.R

# Age Distribution Data
age_data <- data.frame(
  Age_Group = c("15-17 years", "18-20 years", "21-24 years"),
  Overall = c(18.8, 30.1, 53.1),
  Female = c(13.6, 29.0, 57.0),
  Male = c(26.5, 34.0, 40.0),
  stringsAsFactors = FALSE
)

# Education Level Data
education_data <- data.frame(
  Level = c("Never attended", "Primary", "Secondary", "Technical/Vocational", "Higher Education", "Other"),
  Overall = c(0.4, 30.5, 58.7, 4.3, 5.8, 0.2),
  Female = c(0.6, 30.1, 58.5, 4.3, 6.5, 0.0),
  Male = c(0.0, 31.9, 59.3, 4.4, 3.5, 0.9),
  stringsAsFactors = FALSE
)

# Poverty Status Data
poverty_data <- data.frame(
  Status = c("Poor", "Not Poor"),
  Overall = c(26.0, 74.0),
  Female = c(28.4, 71.6),
  Male = c(18.6, 81.4),
  stringsAsFactors = FALSE
)

# Sexual Behavior Data
sexual_behavior_data <- data.frame(
  Behavior = c("Sexually Active", "Has Sexual Partner"),
  Overall = c(68.8, 66.2),
  Female = c(75.0, 71.9),
  Male = c(50.0, 48.7),
  stringsAsFactors = FALSE
)

# Sample Summary
sample_summary <- list(
  total_ayp = 465,
  females = 352,
  males = 113,
  female_percent = 75.7,
  male_percent = 24.3,
  avg_age = "19-21",
  mpi_poor = 26.0
)

# CEI Demographic Data
cei_demographics <- data.frame(
  Category = c("Total CEI Sample", "Females", "Males", "Married", "Secondary Education"),
  Count = c(258, 206, 52, 74, 152),
  Percentage = c(100, 79.8, 20.2, 28.7, 58.9),
  stringsAsFactors = FALSE
)

# Additional data for the new modules

# Mental Health Awareness Summary
mh_summary <- list(
  excellent_mh = 33.8,
  good_mh = 33.3,
  male_excellent = 42,
  female_excellent = 31,
  financial_stress = 29,
  low_self_esteem = 14,
  support_awareness = 63,
  community_support = 41
)

# HIV Knowledge Summary
hiv_summary <- list(
  adequate_knowledge = 48.6,
  positive_attitudes = 49.9,
  condom_knowledge = 97,
  prep_awareness = 45,
  oral_sex_knowledge = 84,
  needle_knowledge = 98,
  blood_transfusion_knowledge = 94
)

# Behavioral Summary
behavior_summary <- list(
  improved_behaviors = 45.2,
  any_depression = 47.7,
  traditional_media = 65,
  mild_depression = 32.5,
  moderate_depression = 11.4,
  severe_depression = 3.8
)

# Mental Health Profile Summary
mh_profile_summary <- list(
  any_depression = 47.7,
  moderate_severe = 15.2,
  no_depression = 52.3,
  female_any_depression = 49.6,
  male_any_depression = 42.5,
  female_moderate_severe = 5.3,
  male_moderate_severe = 1.5
)