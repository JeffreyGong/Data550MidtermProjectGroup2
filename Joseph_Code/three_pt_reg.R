library(tidyverse)
library(here)
library(gtsummary)

here::i_am("Joseph_Code/three_pt_reg.R")

WHICH_CONFIG = Sys.getenv("WHICH_CONFIG")

Data <- readRDS(here(file_path = paste0("Clean_Data/data_",WHICH_CONFIG,".rds")))

# Filter out players who attempted less than 10 total three-pointers
filtered_data <- Data %>%
  filter(X3PA >= 10)

# regression: Total Points (PTS) as a function of Three-Point Attempts (X3PA)
reg_model <- lm(PTS ~ X3PA, data = filtered_data)

summary(reg_model)

# Creat regression table
reg_table <- tbl_regression(reg_model)

saveRDS(reg_table, here::here("Outputs/3pts_reg_table.rds"))

# Create scatter plot w/ regression line (Each point represents one player's season data)
scatterplot <- ggplot(filtered_data, aes(x = X3PA, y = PTS)) +
  geom_point(color = "darkgreen") +      
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(
    title = "Regression Analysis: Three-Point Attempts vs. Total Points",
    x = "Three-Point Attempts",
    y = "Total Points"
  ) +
  theme_light()

ggsave(
  here::here("Outputs/three_pt_regression_plot.png"),
  plot = scatterplot,
  device = "png"
)

