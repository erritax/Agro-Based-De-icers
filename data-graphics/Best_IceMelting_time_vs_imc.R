library(ggplot2)
library(tidyr)
library(stringr)

# Define treatment order
treatment_order <- c('25.0 wt% NaCl', '16.1 wt% Sucrose + 19.4 wt% NaCl', '16.1 wt% Fructose + 19.4 wt% NaCl', '7.1 wt% Sorbitol + 21.4 wt% NaCl')

data <- data.frame(
  treatment = factor(c('25.0 wt% NaCl', '16.1 wt% Sucrose + 19.4 wt% NaCl', '16.1 wt% Fructose + 19.4 wt% NaCl', '7.1 wt% Sorbitol + 21.4 wt% NaCl'), levels = treatment_order),
  `5 minutes` = c(0.44, 0.64, 0.58, 0.52),
  `10 minutes` = c(0.61, 0.71, 0.78, 0.67),
  `15 minutes` = c(0.76, 0.85, 0.72, 0.80),
  `30 minutes` = c(1.17, 1.13, 1.03, 1.06),
  `45 minutes` = c(1.29, 1.40, 1.46, 1.58))

data_long <- pivot_longer(data, cols = -treatment, names_to = "Time_Interval", values_to = "Average")

data_long$Time_Interval <- str_extract(data_long$Time_Interval, "\\d+")

data_long$Time_Interval <- as.numeric(data_long$Time_Interval)

data_long$STD <- c(0.12, 0.14, 0.13, 0.06, 0.09, 0.05, 0.13, 0.10, 0.15, 0.16, 0.15, 0.12, 0.10, 0.04, 0.09,
                   0.03, 0.10, 0.04, 0.13, 0.05)

ggplot(data_long, aes(x = Time_Interval, y = Average, color = treatment)) +
  geom_point() +
  geom_line(linewidth = 1) +
  geom_errorbar(aes(ymin = Average - STD, ymax = Average + STD), width = 1) +
  labs(x = "Time (mins)", y = "Ice Melting Capacity (g/mL)", color = "Deicer Composition") +
  theme_minimal() +
  theme(
    text = element_text(family = "Times New Roman"),
    plot.title = element_text(hjust = 0.5, size = 30),
    axis.title.x = element_text(size = 20),
    axis.title.y = element_text(size = 20, margin = margin(t = 0, r = 10, b = 0, l = 0)),
    axis.text.x = element_text(size = 15),
    legend.text = element_text(size = 15)) +
  ylim(0, 1.8)

