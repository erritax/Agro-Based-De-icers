library(ggplot2)
library(tidyr)
library(stringr)

data <- data.frame(
  time_intervals = c(5, 10, 15, 30, 45),
  `3.7 wt%` = c(0.46, 0.48, 0.56, 0.86, 1.35),
  `7.1 wt%` = c(0.52, 0.67, 0.80, 1.06, 1.58),
  `10.3 wt%` = c(0.47, 0.79, 0.80, 1.00, 1.25),
  `13.3 wt%` = c(0.67, 0.64, 0.68, 0.97, 1.43),
  `16.7 wt%` = c(0.49, 0.60, 0.71, 1.05, 1.32))

data_long <- pivot_longer(data, cols = -time_intervals, names_to = "concentration", values_to = "Average")

data_long$concentration <- str_extract(data_long$concentration, "\\d+")

data_long$concentration <- as.numeric(data_long$concentration)

data_long$STD <- c(0.09, 0.04, 0.12, 0.08, 0.15, 0.17, 0.14, 0.13, 0.08, 0.01, 0.01, 
                   0.11, 0.06, 0.22, 0.13, 0.05, 0.10, 0.06, 0.09, 0.11, 0.08, 0.19, 0.16, 0.01, 0.11)

ggplot(data_long, aes(x = concentration, y = Average, color = factor(time_intervals))) +
  geom_point() +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = Average - STD, ymax = Average + STD), width = 1) +
  labs(x = "Sorbitol Concentration (wt%)", y = "Ice Melting Capacity (g/mL)", color = "Rocking Time (mins)") +
  theme_minimal() +
  theme(
    text = element_text(family = "Times New Roman"),
    plot.title = element_text(hjust = 0.5, size = 30),
    axis.title.x = element_text(size = 20),
    axis.title.y = element_text(size = 20, margin = margin(t = 0, r = 10, b = 0, l = 0)),
    axis.text.x = element_text(size = 15),
    legend.text = element_text(size = 15)) +
  ylim(0, 1.8) +
  xlim(0, 20)

