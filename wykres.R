library(ggplot2)

wykres_wyniki = function(data_frame){
  ggplot(data = data_frame, aes(x = komitet, y = wynik, color = komitet)) + 
    geom_boxplot(color = "black") + geom_jitter(size = 2, alpha = 0.3, width = 0.3) +
    scale_color_manual(values = c("orange", "black", "darkgreen", "blue", "red")) +
    labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia")
}
wykres_wyniki(okregi_wyniki_df)
  
