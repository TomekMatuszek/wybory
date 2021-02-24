#' Obliczanie rozkladu mandatow dla wyników z danego roku wg różnych metod
#'
#' @description Funkcja tworzy macierz zawierajacą informacje o liczbie mandatow poselskich przyznanych
#' komitetom wg trzech roznych metod w wyborach parlamentarnych wybranego roku.
#' Wyswietlany także jest wykres zawierajacy wspomniane informacje,
#' a takze wizualizujacy realne poparcie w okregu w odniesieniu do dostepnych mandatow w skali kraju.
#' Do poprawnego działania funkcji wymagane jest pobranie arkusza z wynikami wyborów z PKW oraz
#' przetworzenie ich przy pomocy funkcji 'konstruktor_wynikow'.
#'
#' @param wyniki obiekt klasy 'macierz_wynikow' tworzony przez funkcję 'konstruktor_wynikow'
#'
#' @return macierz z wynikami oraz wykres obrazujacy wyniki
#' @export
#'
#' @examples
#' konstruktor_wynikow("sejm_wyniki_2019.xlsx", 9, 11, 12, 14, 16)
#' wybory_rok(wybory_2019)
wybory_rok = function(wyniki){
  UseMethod("wybory_rok")
}

#' @export
wybory_rok.macierz_wynikow = function(wyniki){
  if (exists("okregi") == FALSE){
    stop("Nie zostal stworzony obiekt 'okregi'! Uzyj najpierw funkcji 'konstruktor_okregow'.")
  }
  dh_mx = matrix( ,nrow = ncol(wyniki), ncol = 1)
  for (i in 1:nrow(wyniki)) {
    argumenty = c()
    for (j in 1:ncol(wyniki)) {
      argumenty = c(argumenty, wyniki[i, j])
    }
    argumenty[4] = argumenty[4] - 0.01
    dh = dhont(argumenty, okreg = i)
    dh_mx = cbind(dh_mx, dh)
  }
  dh_sum = rowSums(dh_mx, na.rm = TRUE)

  sl_mx = matrix( ,nrow = ncol(wyniki), ncol = 1)
  for (i in 1:nrow(wyniki)) {
    argumenty = c()
    for (j in 1:ncol(wyniki)) {
      argumenty = c(argumenty, wyniki[i, j])
    }
    sl = sainte_lague(argumenty, okreg = i)
    sl_mx = cbind(sl_mx, sl)
  }
  sl_sum = rowSums(sl_mx, na.rm = TRUE)

  hn_mx = matrix( ,nrow = ncol(wyniki), ncol = 1)
  for (i in 1:nrow(wyniki)) {
    argumenty = c()
    for (j in 1:ncol(wyniki)) {
      argumenty = c(argumenty, wyniki[i, j])
    }
    hn = hare_niemeyer(argumenty, okreg = i)
    hn_mx = cbind(hn_mx, hn)
  }
  hn_sum = rowSums(hn_mx, na.rm = TRUE)

  wyniki_man = matrix(c(dh_sum, sl_sum, hn_sum), ncol = 3, nrow = ncol(wyniki))
  cyfry_rzymskie = c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X")
  colnames(wyniki_man) = c("D'Hont", "Sainte-Lague", "Hare-Niemeyer")
  nazwy_wierszy = c()
  for (i in 1:ncol(wyniki)) {
    nazwy_wierszy = c(nazwy_wierszy, paste(cyfry_rzymskie[i], "Komitet"))
  }
  rownames(wyniki_man) = nazwy_wierszy
  cols = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3",
           "gold", "forestgreen", "darkorchid3", "cornflowerblue", "lightgoldenrod4")

  barplot(wyniki_man, beside = TRUE,
          col = cols[1:ncol(wyniki)],
          ylim = c(0,250), ylab = "Liczba mandatów",
          xlab = "Metoda obliczania podzialu mandatów",
          border = cols[1:ncol(wyniki)],
          main = "Podzial mandatów w Sejmie")
  abline(h = 230, col = "red", lwd = 2, , lty = 2)
  for (i in 1:ncol(wyniki)) {
    abline(h = 460 * (mean(wyniki[ , i]) / 100),
           col = cols[i], lwd = 1.5)
  }
  text(18, 240, "230", col = "red")

  wyniki_man
}
