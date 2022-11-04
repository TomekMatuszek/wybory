#' Obliczanie rozkladu mandatow przy rownomiernym poparciu w skali kraju
#'
#' @description Funkcja tworzy macierzramke danych zawierajaca informacje o liczbie mandatow poselskich przyznanych
#' komitetom wg trzech roznych metod w przypadku gdyby wszystkie komitety otrzymaly rownomierne poparcie w skali kraju.
#'
#' @param ... wyniki wyborcze komitetow w % (max. 10 komitetów)
#' @param koalicje wektor zawierajacy numery komitetow (w kolejnosci podawania), ktore startowaly jako KKW
#' @param frekwencja frekwencja wyborcza, domyslnie ustawiona na 100%
#'
#' @return ramka danych z wynikami
#' @export
#'
#' @examples
#' wybory_pl(34.5, 25.4, 9.6, 9.4, 5.5, 4.7, koalicje = c(2))
wybory_pl = function(..., koalicje = NULL, frekwencja = 100){
  `%>%` = dplyr::`%>%`
  wyniki = c(...)
  if (exists("okregi") == FALSE){
    stop("Nie zostal stworzony obiekt 'okregi'! Uzyj najpierw funkcji 'konstruktor_okregow'.")
  }

  wyniki[(!(wyniki %in% wyniki[koalicje]) & wyniki < 5) | (wyniki %in% wyniki[koalicje] & wyniki < 8)] = 0
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
