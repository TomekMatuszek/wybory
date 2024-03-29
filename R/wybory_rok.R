#' Obliczanie rozkladu mandatow dla wynikow z danego roku wg roznych metod
#'
#' @description Funkcja tworzy macierz zawierajaca informacje o liczbie mandatow poselskich przyznanych
#' komitetom wg trzech roznych metod w wyborach parlamentarnych wybranego roku.
#' Do poprawnego dzialania funkcji wymagane jest pobranie arkusza z wynikami wyborow z PKW oraz
#' przetworzenie ich przy pomocy funkcji 'konstruktor_wynikow'.
#'
#' @param wyniki ramka danych z wynikami stworzona przez funkcję 'konstruktor_wynikow'
#'
#' @return ramka danych z wynikami
#' @export
#'
#' @examples
#' konstruktor_wynikow("sejm_wyniki_2019.xlsx", 9, 11, 12, 14, 16)
#' wybory_rok(wybory_2019)
#' @export
wybory_rok = function(wyniki){
  if (exists("okregi") == FALSE){
    stop("Nie zostal stworzony obiekt 'okregi'! Uzyj najpierw funkcji 'konstruktor_okregow'.")
  }
  wyniki_kraj = c()
  for (i in 2:ncol(wyniki)) {
    prog = ifelse(stringr::str_detect(colnames(wyniki)[i], "\\(K\\)"), 8, 5)
    wynik_kraj = sum(wyniki[, i] / 100 * okregi[, 1]) / sum(okregi[, 1]) * 100
    wyniki_kraj = c(wyniki_kraj, wynik_kraj)
    if (wynik_kraj < prog && length(which(wyniki[ , i] > 0)) > 1){
      wyniki[ , i] = rep(0, times = 41)
    }
  }
  `%>%` = dplyr::`%>%`
  cyfry_rzymskie = c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X")
  komitety = paste(cyfry_rzymskie[1:(ncol(wyniki) - 1)], "Komitet")

  dh_mx = data.frame("Komitet" = komitety)
  for (i in 1:nrow(wyniki)) {
    argumenty = wyniki[i, -1] %>% unlist() %>% unname()
    argumenty[4] = argumenty[4] - 0.01
    dh = dhont(argumenty, okreg = i)
    dh_mx = dh_mx %>% dplyr::left_join(dh, by = "Komitet")
  }
  dh_sum = rowSums(dh_mx[, -1], na.rm = TRUE)

  sl_mx = data.frame("Komitet" = komitety)
  for (i in 1:nrow(wyniki)) {
    argumenty = wyniki[i, -1] %>% unlist() %>% unname()
    sl = sainte_lague(argumenty, okreg = i)
    sl_mx = sl_mx %>% dplyr::left_join(sl, by = "Komitet")
  }
  sl_sum = rowSums(sl_mx[, -1], na.rm = TRUE)

  hn_mx = data.frame("Komitet" = komitety)
  for (i in 1:nrow(wyniki)) {
    argumenty = wyniki[i, -1] %>% unlist() %>% unname()
    hn = hare_niemeyer(argumenty, okreg = i)
    hn_mx = hn_mx %>% dplyr::left_join(hn, by = "Komitet")
  }
  hn_sum = rowSums(hn_mx[, -1], na.rm = TRUE)

  wyniki_man = data.frame("Komitet" = factor(colnames(wyniki)[-1], levels = colnames(wyniki)[-1]),
                          "D'Hont" = dh_sum,
                          "Sainte-Lague" = sl_sum,
                          "Hare-Niemeyer" = hn_sum,
                          "poparcie" = round(wyniki_kraj, 2))
  wyniki_man
}
