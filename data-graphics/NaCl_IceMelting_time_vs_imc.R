library(ggplot2)
library(tidyr)
library(stringr)

data <- data.frame(
  Nacl_Concentration = c(0, 5, 10, 15, 20, 23.3, 25),
  `5 minutes` = c(-0.07, 0.19, 0.28, 0.43, 0.29, 0.48, 0.44),
  `10 minutes` = c(-0.10, 0.22, 0.50, 0.51, 0.49, 0.68, 0.61),
  `15 minutes` = c(-0.19, 0.18, 0.40, 0.55, 0.69, 0.76, 0.76),
  `30 minutes` = c(0.02, 0.43, 0.70, 0.70, 0.85, 1.03, 1.17),
  `45 minutes` = c(0.17, 0.62, 0.82, 1.02, 1.18, 1.27, 1.29))

data_long <- pivot_longer(data, cols = -Nacl_Concentration, names_to = "Time_Interval", values_to = "Average")

data_long$Time_Interval <- str_extract(data_long$Time_Interval, "\\d+")

data_long$Time_Interval <- as.numeric(data_long$Time_Interval)

data_long$STD <- c(0.12, 0.14, 0.13, 0.06, 0.09, 0.05, 0.13, 0.10, 0.15, 0.16, 0.15, 0.12, 0.10, 0.04, 0.09,
                   0.03, 0.10, 0.04, 0.13, 0.05, 0.16, 0.11, 0.14, 0.07, 0.09, 0.05, 0.04, 0.24, 0.21, 0.14,
                   0.20, 0.26, 0.06, 0.03, 0.21)

ggplot(data_long, aes(x = Time_Interval, y = Average, color = factor(Nacl_Concentration))) +
  geom_point() +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = Average - STD, ymax = Average + STD), width = 1) +
  labs(x = "Time (mins)", y = "Ice Melting Capacity (g/mL)", color = "NaCl Concentration (wt%)") +
  theme_minimal() +
  theme(
    text = element_text(family = "Times New Roman"),
    plot.title = element_text(hjust = 0.5, size = 30),
    axis.title.x = element_text(size = 20),
    axis.title.y = element_text(size = 20, margin = margin(t = 0, r = 10, b = 0, l = 0)),
    axis.text.x = element_text(size = 15),
    legend.text = element_text(size = 15)) +
  ylim(-0.5, 1.8)

