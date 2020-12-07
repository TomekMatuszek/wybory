#' Obliczanie rozkladu mandatow przy rownomiernym poparciu w skali kraju
#'
#' @description Funkcja tworzy macierz zawierajaca informacje o liczbie mandatow poselskich przyznanych
#' komitetom wg trzech roznych metod w przypadku gdyby wszystkie komitety otrzymaly rownomierne poparcie w skali kraju.
#' Wyswietlany także jest wykres zawierajacy wspomniane informacje,
#' a takze wizualizujacy realne poparcie w okregu w odniesieniu do dostepnych mandatow w skali kraju.
#'
#' @param kom1,kom2,kom3,kom4,kom5 wyniki wyborcze komitetow w %
#' @param frekwencja frekwencja wyborcza, domyslnie ustawiona na 100%
#'
#' @return macierz z wynikami oraz wykres obrazujacy wyniki
#' @export
#'
#' @examples
#' wybory_pl(kom1 = 30, kom2 = 29, kom3 = 10, kom4 = 7, kom5 = 6)
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
