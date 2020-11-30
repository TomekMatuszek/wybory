#Funkcja przeprowadza funkcje wybory dla wszystkich okregow i sumuje wyniki
#Zachodzi tu hipotetyczna sytuacja rownomiernego rozkladu glosów w skali kraju
#Argumentami sa kolejno wyniki pieciu komitetów wyborczych oraz frekwencja
#Produktem funkcji jest macierz przedstawiająca podział mandatów przy podanych wynikach dla róznych metod
#Wyswietlony zostanie takze wykres slupkowy obrazujacy wyniki z macierzy
#Wraz z liniami pokazujacymi realne poparcie komitetu w relacji do wszystkich mandatow
#' @export
wybory_pl = function(kom1, kom2, kom3, kom4, kom5, frekwencja = 100){
  if (exists("okregi") == FALSE){
    stop("Nie zostal stworzony obiekt 'okregi'! Uzyj najpierw funkcji 'konstruktor_okregow'.")
  }
  m = matrix( , ncol = 1, nrow = 5)
  for (i in 1:nrow(okregi)) {
    m2 = dhont(kom1, kom2, kom3, kom4, kom5, i, frekwencja = 100)
    m = cbind(m, m2)
  }
  dh = rowSums(m, na.rm = TRUE)
  m = matrix( , ncol = 1, nrow = 5)
  for (i in 1:nrow(okregi)) {
    m2 = sainte_lague(kom1, kom2, kom3, kom4, kom5, i, frekwencja = 100)
    m = cbind(m, m2)
  }
  sl = rowSums(m, na.rm = TRUE)
  m = matrix( , ncol = 1, nrow = 5)
  for (i in 1:nrow(okregi)) {
    m2 = hare_niemeyer(kom1, kom2, kom3, kom4, kom5, i, frekwencja = 100)
    m = cbind(m, m2)
  }
  hn = rowSums(m, na.rm = TRUE)
  m3 = matrix(c(dh, sl, hn), ncol = 3, nrow = 5)
  rownames(m3) = c("Komitet I", "Komitet II", "Komitet III", "Komitet IV", "Komitet V")
  colnames(m3) = c("D'Hont", "Sainte-Lague", "Hare-Niemeyer")

  barplot(m3, beside = TRUE,
          col = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3"),
          ylim = c(0,250), ylab = "Liczba mandatów",
          xlab = "Metoda obliczania podzialu mandatów",
          border = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3"),
          main = "Podzial mandatów w Sejmie")
  abline(h = 230, col = "red", lwd = 2, lty = 2)
  abline(h = 460 * (kom1 / 100),
         col = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3")[1], lwd = 1.5)
  abline(h = 460 * (kom2 / 100),
         col = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3")[2], lwd = 1.5)
  abline(h = 460 * (kom3 / 100),
         col = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3")[3], lwd = 1.5)
  abline(h = 460 * (kom4 / 100),
         col = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3")[4], lwd = 1.5)
  abline(h = 460 * (kom5 / 100),
         col = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3")[5], lwd = 1.5)
  text(18, 240, "230", col = "red")

  m3
}