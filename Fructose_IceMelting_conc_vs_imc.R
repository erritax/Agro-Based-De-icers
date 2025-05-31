library(ggplot2)
library(tidyr)
library(stringr)

data <- data.frame(
  time_intervals = c(5, 10, 15, 30, 45),
  `3.7 wt%` = c(0.60, 0.62, 0.66, 0.88, 1.35),
  `7.1 wt%` = c(0.61, 0.78, 0.72, 1.01, 1.29),
  `10.3 wt%` = c(0.70, 0.84, 0.98, 0.91, 1.31),
  `13.3 wt%` = c(0.66, 0.72, 0.77, 0.98, 1.22),
  `16.7 wt%` = c(0.58, 0.78, 0.72, 1.03, 1.46))

data_long <- pivot_longer(data, cols = -time_intervals, names_to = "concentration", values_to = "Average")

data_long$concentration <- str_extract(data_long$concentration, "\\d+")

data_long$concentration <- as.numeric(data_long$concentration)

data_long$STD <- c(0.08, 0.03, 0.12, 0.11, 0.11, 0.06, 0.03, 0.11, 0.14, 0.11, 0.09, 0.10, 0.15, 0.09, 0.09, 
                   0.07, 0.06, 0.02, 0.15, 0.08, 0.09, 0.07, 0.03, 0.07, 0.10)

ggplot(data_long, aes(x = concentration, y = Average, color = factor(time_intervals))) +
  geom_point() +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = Average - STD, ymax = Average + STD), width = 1) +
  labs(x = "Fructose Concentration (wt%)", y = "Ice Melting Capacity (g/mL)", color = "Rocking Time (mins)") +
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

