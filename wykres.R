library(ggplot2)

okregi_wyniki_df
ggplot(data = okregi_wyniki_df, aes(x = komitet, y = wynik, color = komitet)) + 
  geom_boxplot(color = "black") + geom_jitter(size = 2, alpha = 0.3, width = 0.2) +
  scale_color_manual(values = c("orange", "black", "darkgreen", "blue", "red")) +
  labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia")
  
