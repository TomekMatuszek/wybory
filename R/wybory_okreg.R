#' Obliczanie rozkladu mandatow w okregu
#'
#' @description Funkcja tworzy ramke danych zawierajaca informacje o liczbie mandatow z okregu przyznanych
#' komitetom wg trzech roznych metod.
#'
#' @param ... wyniki wyborcze komitetow w % (max. 10 komitetów)
#' @param okreg liczba z przedzialu (1, 41); numer okregu, w ktorym chcemy obliczyc rozklad mandatow
#' @param frekwencja frekwencja wyborcza, domyslnie ustawiona na 100%
#'
#' @return ramka danych z wynikami
#' @export
#'
#' @examples
#' wybory_okreg(30, 29, 10, 7, 6, okreg = 4)
wybory_okreg = function(..., okreg, frekwencja = 100){
  `%>%` = dplyr::`%>%`
  wyniki = c(...)
  if (is.numeric(okreg) == FALSE || round(okreg, 0) != okreg || okreg > 41 || okreg < 1){
    stop("Wybierz numer okręgu z przedziału liczb całkowitych (1,41)!")
  }
  if (class(wyniki[1]) == "list"){
    wyniki = wyniki %>% as.data.frame() %>% .[okreg, 2:length(wyniki)] %>% as.numeric()
  }
  if (exists("okregi") == FALSE){
    stop("Nie zostal stworzony obiekt 'okregi'! Uzyj najpierw funkcji 'konstruktor_okregow'.")
  }
  if (frekwencja > 100 || frekwencja < 0){
    stop("Frekwencja musi być liczbą z przedziału (0,100)!")
  }
  if (round(sum(wyniki)) > 100){
    stop("Suma poparcia poszczególnych komitetów jest wyższa niż 100%!")
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
  if (class(c(...)[1]) == "list"){
    wyniki_man$poparcie = wyniki
  } else{
    wyniki_man$poparcie = c(...)
  }

  wyniki_man
}
