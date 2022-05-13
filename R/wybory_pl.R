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
  `%>%` = dplyr::`%>%`
  wyniki = c(...)
  if (exists("okregi") == FALSE){
    stop("Nie zostal stworzony obiekt 'okregi'! Uzyj najpierw funkcji 'konstruktor_okregow'.")
  }
  wyniki[wyniki < 5] = 0
  cyfry_rzymskie = c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X")
  komitety = paste(cyfry_rzymskie[1:length(wyniki)], "Komitet")

  m = data.frame("Komitet" = komitety)
  for (i in 1:nrow(okregi)) {
    m2 = dhont(wyniki, okreg = i, frekwencja = 100)
    m = m %>% dplyr::left_join(m2, by = "Komitet")
  }
  dh = rowSums(m[, -1], na.rm = TRUE)
  m = data.frame("Komitet" = komitety)
  for (i in 1:nrow(okregi)) {
    m2 = sainte_lague(wyniki, okreg = i, frekwencja = 100)
    m = m %>% dplyr::left_join(m2, by = "Komitet")
  }
  sl = rowSums(m[, -1], na.rm = TRUE)
  m = data.frame("Komitet" = komitety)
  for (i in 1:nrow(okregi)) {
    m2 = hare_niemeyer(wyniki, okreg = i, frekwencja = 100)
    m = m %>% dplyr::left_join(m2, by = "Komitet")
  }
  hn = rowSums(m[, -1], na.rm = TRUE)

  m3 = data.frame("Komitet" = komitety,
                  "D'Hont" = dh,
                  "Sainte-Lague" = sl,
                  "Hare-Niemeyer" = hn,
                  "poparcie" = c(...))
  m3
}
