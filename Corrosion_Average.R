library(ggplot2)

# Data frame with treatments
data <- data.frame(
  Treatment = factor(c(1, 2, 3, 4), labels = c("NaCl", "Sucrose", "Fructose", "Sorbitol")),
  Average = c(7.98, 8.04, 8.09, 7.80),
  StandardDeviation = c(0.07338634448, 0.2166846146, 0.1582368127, 0.4436502627)
)

# Plot with named treatments
plot <- ggplot(data, aes(x = Treatment, y = Average, fill = Treatment)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  geom_errorbar(aes(ymin = Average - StandardDeviation, ymax = Average + StandardDeviation), width = 0.4, color = 'dimgray') +
  theme_minimal() +
  theme(axis.text.x = element_text(hjust = 1, size = 12, family = "Times New Roman"),
        axis.title = element_text(size = 14, family = "Times New Roman")) +
  labs(x = "Treatment", y = "Average Weight (g)") +
  scale_fill_manual(values = c("NaCl" = "palegoldenrod", "Sucrose" = "lightskyblue", "Fructose" = "cornflowerblue", 'Sorbitol' = 'blue')) +
  coord_cartesian(ylim = c(5.95, 8.5))

print(plot)

