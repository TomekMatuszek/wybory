hare_niemeyer = function(..., okreg, frekwencja = 100){
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
  if (round(sum(wyniki, na.rm = TRUE)) > 100){
    stop("Suma poparcia poszczególnych komitetów jest wyższa niż 100%!")
  }
  if (is.numeric(okreg) == FALSE || round(okreg, 0) != okreg || okreg > 41 || okreg < 1){
    stop("Wybierz numer okręgu z przedziału liczb całkowitych (1,41)!")
  }
  if (sum(wyniki, na.rm = TRUE) < 90){
    warning(paste("Suma poparcia wszystkich komitetów wynosi", sum(wyniki), "%. \n To oznacza, że", 100 - sum(wyniki), "% głosów została oddana nieważnych lub na komitety, które nie przekroczyły progu wyborczego."))
  }

  liczba_glosow = c()
  for (i in wyniki) {
    liczba_glosow = c(liczba_glosow, i / 100 * (frekwencja / 100) * okregi[okreg, 1])
  }
  hn = c()
  for (i in 1:length(liczba_glosow)) {
    hn = c(hn, liczba_glosow[i] / ((frekwencja / 100) * okregi[okreg, 1]) * okregi[okreg, 2])
  }
  mandaty_dane = c()
  for (i in 1:length(wyniki)) {
    mandaty_dane = c(mandaty_dane, as.integer(hn[i]))
  }
  mandaty_integer = matrix(mandaty_dane,
                           ncol = 1, nrow = length(wyniki))

  hn2 = c()
  for (i in 1:length(hn)) {
    hn2 = c(hn2, hn[i] - as.integer(hn[i]))
  }
  brak = okregi[okreg,2] - colSums(mandaty_integer)
  if (brak >= length(wyniki)){
    mandaty_integer[which(hn > 0), ] = mandaty_integer[which(hn > 0), ] + 1
    brak = okregi[okreg,2] - colSums(mandaty_integer)
  }
  n = length(hn2)
  dod_mandaty = matrix(rep(0, times = length(wyniki)))
  if (sum(mandaty_integer) < okregi[okreg, 2]){
    granica = sort(hn2, partial = n - ((okregi[okreg, 2] - sum(mandaty_integer)) - 1))[n - ((okregi[okreg, 2] - sum(mandaty_integer)) - 1)]
    dod_mandaty = as.matrix(hn2 >= granica)
  }
  if (colSums(mandaty_integer) + colSums(dod_mandaty) > okregi[okreg, 2]){
    a <<- 0
    for (i in 1:length(wyniki)) {
      for (j in 1:length(wyniki)) {
        if (hn2[i] == hn2[j] && (i != j) == TRUE && any(c(hn2[i], hn2[j]) == granica) == TRUE){
          dod_mandaty[max(c(i, j)), 1] = FALSE
          a <<- a + 1
        }
        if (a > 2){
          break
        }
      }
      if (a > 2){
        break
      }
    }
  }

  mandaty_integer = cbind(mandaty_integer, dod_mandaty)
  wynik_hn = matrix(rowSums(mandaty_integer), ncol = 1, nrow = length(wyniki))

  cyfry_rzymskie = c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X")
  colnames(wynik_hn) = "Hare-Niemeyer"
  nazwy_wierszy = c()
  for (i in 1:length(wyniki)) {
    nazwy_wierszy = c(nazwy_wierszy, paste(cyfry_rzymskie[i], "Komitet"))
  }
  rownames(wynik_hn) = nazwy_wierszy
  wynik_hn
}
