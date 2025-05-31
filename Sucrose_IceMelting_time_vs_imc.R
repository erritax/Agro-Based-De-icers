library(ggplot2)
library(tidyr)
library(stringr)

data <- data.frame(
  Sucrose_Concentration = c(3.7, 7.1, 10.3, 13.3, 16.1),
  `5 minutes` = c(0.52, 0.53, 0.49, 0.50, 0.64),
  `10 minutes` = c(0.54, 0.74, 0.76, 0.66, 0.71),
  `15 minutes` = c(0.73, 0.68, 0.69, 0.78, 0.85),
  `30 minutes` = c(0.98, 0.91, 0.94, 0.97, 1.13),
  `45 minutes` = c(1.22, 1.22, 1.39, 1.36, 1.40))

data_long <- pivot_longer(data, cols = -Sucrose_Concentration, names_to = "Time_Interval", values_to = "Average")

data_long$Time_Interval <- str_extract(data_long$Time_Interval, "\\d+")

data_long$Time_Interval <- as.numeric(data_long$Time_Interval)

data_long$STD <- c(0.01, 0.05, 0.10, 0.09, 0.07, 0.09, 0.07, 0.03, 0.12, 0.09, 
                   0.04, 0.22, 0.06, 0.06, 0.17, 0.10, 0.08, 0.10, 0.09, 0.09, 
                   0.14, 0.08, 0.17, 0.14, 0.09)

ggplot(data_long, aes(x = Time_Interval, y = Average, color = factor(Sucrose_Concentration))) +
  geom_point() +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = Average - STD, ymax = Average + STD), width = 1) +
  labs(x = "Time (mins)", y = "Ice Melting Capacity (g/mL)", color = "Sucrose Concentration (wt%)") +
  theme_minimal() +
  theme(
    text = element_text(family = "Times New Roman"),
    plot.title = element_text(hjust = 0.5, size = 30),
    axis.title.x = element_text(size = 20),
    axis.title.y = element_text(size = 20, margin = margin(t = 0, r = 10, b = 0, l = 0)),
    axis.text.x = element_text(size = 15),
    legend.text = element_text(size = 15)) +
  ylim(0, 1.8)

