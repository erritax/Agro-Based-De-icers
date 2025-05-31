library(ggplot2)
library(tidyr)
library(stringr)

data <- data.frame(
  time_intervals = c(5, 10, 15, 30, 45),
  `0 wt%` = c(-0.07, -0.10, -0.19, 0.02, 0.17),
  `5.0 wt%` = c(0.19, 0.22, 0.18, 0.43, 0.62),
  `10.0 wt%` = c(0.28, 0.50, 0.40, 0.70, 0.82),
  `15.0 wt%` = c(0.43, 0.51, 0.55, 0.70, 1.02),
  `20.0 wt%` = c(0.29, 0.49, 0.69, 0.85, 1.18),
  `23.3 wt%` = c(0.48, 0.68, 0.76, 1.03, 1.27),
  `25.0 wt%` = c(0.44, 0.61, 0.76, 1.17, 1.29))

data_long <- pivot_longer(data, cols = -time_intervals, names_to = "concentration", values_to = "Average")

data_long$concentration <- str_extract(data_long$concentration, "\\d+")

data_long$concentration <- as.numeric(data_long$concentration)

data_long$STD <- c(0.12, 0.10, 0.09, 0.11, 0.21, 0.14, 0.15, 0.03, 0.14, 0.14, 0.13, 0.16, 0.10, 0.07, 0.20, 0.06, 0.15, 0.04, 0.09, 0.26,
                   0.09, 0.12, 0.13, 0.05, 0.06, 0.05, 0.10, 0.05, 0.04, 0.03, 0.13, 0.04, 0.16, 0.24, 0.21)

ggplot(data_long, aes(x = concentration, y = Average, color = factor(time_intervals))) +
  geom_point() +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = Average - STD, ymax = Average + STD), width = 1) +
  labs(x = "NaCl Concentration (wt%)", y = "Ice Melting Capacity (g/mL)", color = "Rocking Time (mins)") +
  theme_minimal() +
  theme(
    text = element_text(family = "Times New Roman"),
    plot.title = element_text(hjust = 0.5, size = 30),
    axis.title.x = element_text(size = 20),
    axis.title.y = element_text(size = 20, margin = margin(t = 0, r = 10, b = 0, l = 0)),
    axis.text.x = element_text(size = 15),
    legend.text = element_text(size = 15)) +
  ylim(-0.5, 1.8) +
  xlim(0, 27.5)

