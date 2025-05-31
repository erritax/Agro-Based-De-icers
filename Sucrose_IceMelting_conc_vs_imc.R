library(ggplot2)
library(tidyr)
library(stringr)

data <- data.frame(
  time_intervals = c(5, 10, 15, 30, 45),
  `3.7 wt%` = c(0.52, 0.54, 0.73, 0.98, 1.22),
  `7.1 wt%` = c(0.53, 0.74, 0.68, 0.91, 1.22),
  `10.3 wt%` = c(0.49, 0.76, 0.69, 0.94, 1.39),
  `13.3 wt%` = c(0.50, 0.66, 0.78, 0.97, 1.36),
  `16.7 wt%` = c(0.64, 0.71, 0.85, 1.13, 1.40))

data_long <- pivot_longer(data, cols = -time_intervals, names_to = "concentration", values_to = "Average")

data_long$concentration <- str_extract(data_long$concentration, "\\d+")

data_long$concentration <- as.numeric(data_long$concentration)

data_long$STD <- c(0.01, 0.09, 0.04, 0.06, 0.08, 0.05, 0.07, 0.22, 0.08, 0.17, 0.10, 0.17, 0.06, 0.10, 0.14,
                   0.09, 0.03, 0.12, 0.09, 0.16, 0.07, 0.07, 0.21, 0.17, 0.09)

ggplot(data_long, aes(x = concentration, y = Average, color = factor(time_intervals))) +
  geom_point() +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = Average - STD, ymax = Average + STD), width = 1) +
  labs(x = "Sucrose Concentration (wt%)", y = "Ice Melting Capacity (g/mL)", color = "Rocking Time (mins)") +
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

