#' Obliczanie rozkladu mandatow w okregu
#'
#' @description Funkcja tworzy macierz zawierajaca informacje o liczbie mandatow z okregu przyznanych
#' komitetom wg trzech roznych metod. Wyswietlany także jest wykres zawierajacy wspomniane informacje,
#' a takze wizualizujacy realne poparcie w okregu w odniesieniu do dostepnych mandatow.
#'
#' @param ... wyniki wyborcze komitetow w % (max. 10 komitetów)
#' @param okreg liczba z przedzialu (1, 41); numer okregu, w ktorym chcemy obliczyc rozklad mandatow
#' @param frekwencja frekwencja wyborcza, domyslnie ustawiona na 100%
#'
#' @return macierz z wynikami oraz wykres obrazujacy wyniki
#' @export
#'
#' @examples
#' wybory_okreg(30, 29, 10, 7, 6, okreg = 4)
wybory_okreg = function(..., okreg, frekwencja = 100){
  `%>%` = dplyr::`%>%`
  wyniki = c(...)
  if (exists("okregi") == FALSE){
    stop("Nie zostal stworzony obiekt 'okregi'! Uzyj najpierw funkcji 'konstruktor_okregow'.")
  }
  if (is.numeric(wyniki) == FALSE){
    stop("Wprowadzane argumenty muszą być liczbami!")
  }
  if (frekwencja > 100 || frekwencja < 0){
    stop("Frekwencja musi być liczbą z przedziału (0,100)!")
  }
  if (round(sum(wyniki)) > 100){
    stop("Suma poparcia poszczególnych komitetów jest wyższa niż 100%!")
  }
  if (is.numeric(okreg) == FALSE || round(okreg, 0) != okreg || okreg > 41 || okreg < 1){
    stop("Wybierz numer okręgu z przedziału liczb całkowitych (1,41)!")
  }
  if (sum(wyniki) < 90){
    warning(paste("Suma poparcia wszystkich komitetów wynosi", sum(wyniki), "%. \n To oznacza, że", 100 - sum(wyniki), "% głosów została oddana nieważnych lub na komitety, które nie przekroczyły progu wyborczego."))
  }

  system_dhonta = dhont(wyniki, okreg = okreg)
  system_sainte_lague = sainte_lague(wyniki, okreg = okreg)
  system_hare_niemeyer = hare_niemeyer(wyniki, okreg = okreg)

  wyniki_man = system_dhonta %>%
    dplyr::left_join(system_sainte_lague, by = "Komitet") %>%
    dplyr::left_join(system_hare_niemeyer, by = "Komitet")
  cols = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3",
           "gold", "forestgreen", "darkorchid3", "cornflowerblue", "lightgoldenrod4")

  # barplot(wyniki_man, beside = TRUE,
  #         col = cols[1:length(wyniki)],
  #         ylim = c(0, max(wyniki_man) + 2),
  #         border = cols[1:length(wyniki)],
  #         ylab = "Liczba mandatów", xlab = "Metoda obliczania podziału mandatów",
  #         main = c("Podział mandatów w okręgu", okreg))
  # for (i in 1:length(wyniki)) {
  #   abline(h = okregi[okreg, 2] * (wyniki[i] / 100),
  #          col = cols[i], lwd = 1.5)
  # }
  # nazwy_legenda = paste0("Kom", 1:length(wyniki))
  # legend("top", nazwy_legenda, ncol = as.integer(length(wyniki) / 2) + 1,
  #        fill = cols[1:length(wyniki)])

  wyniki_man
}
