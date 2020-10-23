#Ponizsza funkcja oblicza podzial mandatów wg roznych metod na podstawie
#Macierzy wyników utworzonej przy pomocy konstruktora
#Wynikiem jest macierz przedstawiajaca liczbe zdobytych mandatów przez każdy komitet
#Oraz wykres slupkowy z zaznaczonym realnym poparciem partii a także progiem 230 mandatów
wybory_rok = function(wyniki){
  UseMethod("wybory_rok")
}

wybory_rok.macierz_wynikow = function(wyniki){
  dh_mx = matrix( ,nrow = 5, ncol = 1)
  for (i in 1:nrow(wyniki)) {
    dh = dhont(wyniki[i, 1], wyniki[i, 2], wyniki[i, 3], 
               wyniki[i, 4] - 0.01, wyniki[i, 5], i)
    dh_mx = cbind(dh_mx, dh)
  }
  dh_sum = rowSums(dh_mx, na.rm = TRUE)
  
  sl_mx = matrix( ,nrow = 5, ncol = 1)
  for (i in 1:nrow(wyniki)) {
    sl = sainte_lague(wyniki[i, 1], wyniki[i, 2], wyniki[i, 3], 
               wyniki[i, 4] - 0.01, wyniki[i, 5], i)
    sl_mx = cbind(sl_mx, sl)
  }
  sl_sum = rowSums(sl_mx, na.rm = TRUE)
  
  hn_mx = matrix( ,nrow = 5, ncol = 1)
  for (i in 1:nrow(wyniki)) {
    hn = hare_niemeyer(wyniki[i, 1], wyniki[i, 2], wyniki[i, 3], 
                      wyniki[i, 4] - 0.01, wyniki[i, 5], i)
    hn_mx = cbind(hn_mx, hn)
  }
  hn_sum = rowSums(hn_mx, na.rm = TRUE)
  
  wyniki_man = matrix(c(dh_sum, sl_sum, hn_sum), ncol = 3, nrow = 5)
  colnames(wyniki_man) = c("D'Hont", "Sainte-Lague", "Hare-Niemeyer")
  rownames(wyniki_man) = c("Komitet I", "Komitet II", "Komitet III", "Komitet IV", "Komitet V")
  
  barplot(wyniki_man, beside = TRUE, col = c("orange", "black", "darkgreen", "blue", "red"),
          ylim = c(0,250), ylab = "Liczba mandatów", xlab = "Metoda obliczania podzialu mandatów",
          main = "Podzial mandatów w Sejmie")
  abline(h = 230, col = "red", lwd = 2)
  abline(h = 460 * (mean(wyniki[ ,1]) / 100), col = "orange", lwd = 1.5)
  abline(h = 460 * (mean(wyniki[ ,2]) / 100), col = "black", lwd = 1.5)
  abline(h = 460 * (mean(wyniki[ ,3]) / 100), col = "darkgreen", lwd = 1.5)
  abline(h = 460 * (mean(wyniki[ ,4]) / 100), col = "blue", lwd = 1.5)
  abline(h = 460 * (mean(wyniki[ ,5]) / 100), col = "red", lwd = 1.5)
  text(18, 240, "230", col = "red")
  
  wyniki_man
}
wybory_rok(okregi_wyniki)

