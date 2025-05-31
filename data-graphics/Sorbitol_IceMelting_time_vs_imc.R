library(ggplot2)
library(tidyr)
library(stringr)

data <- data.frame(
  Sorbitol_Concentration = c(3.7, 7.1, 10.3, 13.3, 16.1),
  `5 minutes` = c(0.46, 0.52, 0.47, 0.67, 0.49),
  `10 minutes` = c(0.48, 0.67, 0.79, 0.64, 0.60),
  `15 minutes` = c(0.56, 0.80, 0.80, 0.68, 0.71),
  `30 minutes` = c(0.86, 1.06, 1.00, 0.97, 1.05),
  `45 minutes` = c(1.35, 1.58, 1.25, 1.43, 1.32))

data_long <- pivot_longer(data, cols = -Sorbitol_Concentration, names_to = "Time_Interval", values_to = "Average")

data_long$Time_Interval <- str_extract(data_long$Time_Interval, "\\d+")

data_long$Time_Interval <- as.numeric(data_long$Time_Interval)

data_long$STD <- c(0.09, 0.17, 0.01, 0.05, 0.08, 0.04, 0.14, 0.11, 0.10, 0.19, 0.12, 0.13, 0.06, 
                   0.06, 0.16, 0.08, 0.08, 0.22, 0.09, 0.01, 0.15, 0.01, 0.13, 0.11, 0.11)

ggplot(data_long, aes(x = Time_Interval, y = Average, color = factor(Sorbitol_Concentration))) +
  geom_point() +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = Average - STD, ymax = Average + STD), width = 1) +
  labs(x = "Time (mins)", y = "Ice Melting Capacity (g/mL)", color = "Sorbitol Concentration (wt%)") +
  theme_minimal() +
  theme(
    text = element_text(family = "Times New Roman"),
    plot.title = element_text(hjust = 0.5, size = 30),
    axis.title.x = element_text(size = 20),
    axis.title.y = element_text(size = 20, margin = margin(t = 0, r = 10, b = 0, l = 0)),
    axis.text.x = element_text(size = 15)) +
  ylim(0, 1.8)

