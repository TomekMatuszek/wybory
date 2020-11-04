library(ggplot2)

wykres_wyniki = function(nazwa, kol1, kol2, kol3, kol4, kol5){
  okregi_wyniki_df = read.csv(nazwa, sep = ";")
  okregi_wyniki_df = data.frame(komitet = c(rep("Kom1", times = 41), rep("Kom2", times = 41),
                                            rep("Kom3", times = 41), rep("Kom4", times = 41),
                                            rep("Kom5", times = 41)),
                                okreg = c(rep(1:41, times = 5)),
                                wynik = c(okregi_wyniki_df[ ,kol1], okregi_wyniki_df[ ,kol2], okregi_wyniki_df[ ,kol3],
                                          okregi_wyniki_df[ ,kol4], okregi_wyniki_df[ ,kol5])
                                )
  
  ggplot(data = okregi_wyniki_df, aes(x = komitet, y = wynik, color = komitet)) + 
    geom_boxplot(color = "black") + geom_jitter(size = 2, alpha = 0.3, width = 0.3) +
    scale_color_manual(values = c("orange", "black", "darkgreen", "blue", "red")) +
    labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia")
}
wykres_wyniki("sejm_wyniki2019.csv", 9, 11, 12, 14, 16)
