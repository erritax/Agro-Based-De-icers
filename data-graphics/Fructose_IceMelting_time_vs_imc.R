library(ggplot2)
library(tidyr)
library(stringr)

data <- data.frame(
  Fructose_Concentration = c(3.7, 7.1, 10.3, 13.3, 16.1),
  `5 minutes` = c(0.60, 0.61, 0.70, 0.66, 0.58),
  `10 minutes` = c(0.62, 0.78, 0.84, 0.72, 0.78),
  `15 minutes` = c(0.66, 0.72, 0.98, 0.77, 0.72),
  `30 minutes` = c(0.88, 1.01, 0.91, 0.98, 1.03),
  `45 minutes` = c(1.35, 1.29, 1.31, 1.22, 1.46))

data_long <- pivot_longer(data, cols = -Fructose_Concentration, names_to = "Time_Interval", values_to = "Average")

data_long$Time_Interval <- str_extract(data_long$Time_Interval, "\\d+")

data_long$Time_Interval <- as.numeric(data_long$Time_Interval)

data_long$STD <- c(0.08, 0.06, 0.09, 0.07, 0.09, 0.03, 0.03, 0.10, 0.06, 0.07, 0.12, 0.11,
                   0.15, 0.02, 0.03, 0.11, 0.14, 0.09, 0.15, 0.07, 0.11, 0.11, 0.09, 0.08, 0.10)

ggplot(data_long, aes(x = Time_Interval, y = Average, color = factor(Fructose_Concentration))) +
  geom_point() +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = Average - STD, ymax = Average + STD), width = 1) +
  labs(x = "Time (mins)", y = "Ice Melting Capacity (g/mL)", color = "Fructose Concentration (wt%)") +
  theme_minimal() +
  theme(
    text = element_text(family = "Times New Roman"),
    plot.title = element_text(hjust = 0.5, size = 30),
    axis.title.x = element_text(size = 20),
    axis.title.y = element_text(size = 20, margin = margin(t = 0, r = 10, b = 0, l = 0)),
    axis.text.x = element_text(size = 15),
    legend.text = element_text(size = 15)) +
  ylim(0, 1.8)
