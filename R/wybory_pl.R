#' Obliczanie rozkladu mandatow przy rownomiernym poparciu w skali kraju
#'
#' @description Funkcja tworzy macierz zawierajacą informacje o liczbie mandatow poselskich przyznanych
#' komitetom wg trzech roznych metod w przypadku gdyby wszystkie komitety otrzymaly rownomierne poparcie w skali kraju.
#' Wyswietlany także jest wykres zawierajacy wspomniane informacje,
#' a takze wizualizujacy realne poparcie w okregu w odniesieniu do dostepnych mandatow w skali kraju.
#'
#' @param ... wyniki wyborcze komitetow w % (max. 10 komitetów)
#' @param frekwencja frekwencja wyborcza, domyslnie ustawiona na 100%
#'
#' @return macierz z wynikami oraz wykres obrazujacy wyniki
#' @export
#'
#' @examples
#' wybory_pl(30, 29, 10, 7, 6)
wybory_pl = function(..., frekwencja = 100){
  wyniki = c(...)
  if (exists("okregi") == FALSE){
    stop("Nie zostal stworzony obiekt 'okregi'! Uzyj najpierw funkcji 'konstruktor_okregow'.")
  }
  m = matrix( , ncol = 1, nrow = length(wyniki))
  for (i in 1:nrow(okregi)) {
    m2 = dhont(wyniki, okreg = i, frekwencja = 100)
    m = cbind(m, m2)
  }
  dh = rowSums(m, na.rm = TRUE)
  m = matrix( , ncol = 1, nrow = length(wyniki))
  for (i in 1:nrow(okregi)) {
    m2 = sainte_lague(wyniki, okreg = i, frekwencja = 100)
    m = cbind(m, m2)
  }
  sl = rowSums(m, na.rm = TRUE)
  m = matrix( , ncol = 1, nrow = length(wyniki))
  for (i in 1:nrow(okregi)) {
    m2 = hare_niemeyer(wyniki, okreg = i, frekwencja = 100)
    m = cbind(m, m2)
  }
  hn = rowSums(m, na.rm = TRUE)
  m3 = matrix(c(dh, sl, hn), ncol = 3, nrow = length(wyniki))
  cyfry_rzymskie = c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X")
  nazwy_wierszy = c()
  for (i in 1:length(wyniki)) {
    nazwy_wierszy = c(nazwy_wierszy, paste("Komitet", cyfry_rzymskie[i]))
  }
  rownames(m3) = nazwy_wierszy
  colnames(m3) = c("D'Hont", "Sainte-Lague", "Hare-Niemeyer")
  cols = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3",
           "gold", "forestgreen", "darkorchid3", "cornflowerblue", "lightgoldenrod4")

  barplot(m3, beside = TRUE,
          col = cols[1:length(wyniki)],
          ylim = c(0,250), ylab = "Liczba mandatów",
          xlab = "Metoda obliczania podzialu mandatów",
          border = cols[1:length(wyniki)],
          main = "Podzial mandatów w Sejmie")
  abline(h = 230, col = "red", lwd = 2, lty = 2)
  for (i in 1:length(wyniki)) {
    abline(h = 460 * (wyniki[i] / 100),
           col = cols[i], lwd = 1.5)
  }
  text(18, 240, "230", col = "red")

  m3
}
