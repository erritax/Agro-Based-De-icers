library(ggplot2)

data <- data.frame(
  Treatment = rep(1:21, each = 1),
  Average = c(8.19, 7.913333333, 7.956666667, 8.07, 8.043333333, 7.913333333,
              7.673333333, 8.116666667, 8.096666667, 8.246666667, 8.08,
              8.103333333, 8.263333333, 8.12, 8.146666667, 7.833333333,
              7.016666667, 8.103333333, 7.883333333, 7.993333333, 7.993333333),
  StandardDeviation = c(0.02645751311, 0.3073000705, 0.4561067127, 0.3119294792, 0.3614323358, 0.04725815626,
                        0.4909514572, 0.187705443, 0.1703917056, 0.08386497084, 0.2165640783,
                        0.1965536398, 0.04509249753, 0.1216552506, 0.1738773514, 0.4697162264,
                        0.07767453465, 0.1850225212, 0.3350124376, 0.1703917056, 0.2400694344)
)

plot <- ggplot(data, aes(x = Treatment, y = Average, fill = factor(Treatment))) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  geom_errorbar(aes(ymin = Average - StandardDeviation, ymax = Average + StandardDeviation), width = 0.4, color = 'dimgray') +
  theme_minimal() +
  theme(axis.text.x = element_text(hjust = 1, vjust = 1, size = 15, family = "Times New Roman"), plot.title = element_text(size = 30, hjust = 0.5, family = "Times New Roman"),
        axis.title.x = element_text(size = 20, family = "Times New Roman", margin = margin(t = 10, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(size = 20, family = "Times New Roman", margin = margin(t = 0, r = 10, b = 0, l = 0))) +
  #, title = "Corrosion Test Weight Results"
  labs(x = "Treatment", y = "Average Weight (g)") +
  scale_fill_manual(values = c("palegoldenrod", 
                               "lightskyblue",
                               "lightskyblue",
                               'lightskyblue',
                               "lightskyblue",
                               "lightskyblue",
                               "cornflowerblue", 
                               "cornflowerblue",
                               "cornflowerblue",
                               "cornflowerblue",
                               "cornflowerblue",
                               'blue', 
                               'blue', 
                               'blue', 
                               'blue', 
                               'blue',
                               "navy",
                               "navy",
                               "navy",
                               "navy",
                               "navy")) +
  scale_x_continuous(breaks = 1:21, labels = 1:21) +
  coord_cartesian(ylim = c(5.95, 8.5))

print(plot)

