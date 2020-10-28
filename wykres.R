library(ggplot2)
okregi_wyniki_df = data.frame(komitet = c(rep("Kom1", times = 41), rep("Kom2", times = 41),
                                          rep("Kom3", times = 41), rep("Kom4", times = 41),
                                          rep("Kom5", times = 41)),
                              okreg = c(rep(1:41, times = 5)),
                              wynik = c(okregi_wyniki[ ,1], okregi_wyniki[ ,2], okregi_wyniki[ ,3],
                                        okregi_wyniki[ ,4], okregi_wyniki[ ,5]) )
okregi_wyniki_df
ggplot(data = okregi_wyniki_df, aes(x = komitet, y = wynik, color = komitet)) + 
  geom_boxplot(color = "black") + geom_jitter(size = 2, alpha = 0.3, width = 0.2) +
  scale_color_manual(values = c("orange", "black", "darkgreen", "blue", "red")) +
  labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia")
  
