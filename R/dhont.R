dhont = function(..., okreg, frekwencja = 100){
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
  if (round(sum(wyniki, na.rm = TRUE)) > 100){
    stop("Suma poparcia poszczególnych komitetów jest wyższa niż 100%!")
  }
  if (is.numeric(okreg) == FALSE || round(okreg, 0) != okreg || okreg > 41 || okreg < 1){
    stop("Wybierz numer okręgu z przedziału liczb całkowitych (1,41)!")
  }
  if (sum(wyniki, na.rm = TRUE) < 90){
    warning(paste("Suma poparcia wszystkich komitetów wynosi", sum(wyniki), "%. \n To oznacza, że",
                  100 - sum(wyniki), "% głosów została oddana nieważnych lub na komitety, które nie przekroczyły progu wyborczego."))
  }

  liczba_glosow = wyniki / 100 * (frekwencja / 100) * okregi[okreg, 1]
  nazwy_kolumn = paste0("komitet", 1:length(wyniki))
  dane = data.frame(dzielnik = 1:okregi[okreg, 2])
  for (i in 1:length(liczba_glosow)) {
    dane = cbind(dane, liczba_glosow[i] / dane$dzielnik)
  }
  dane = dane[ , -1]
  colnames(dane) = nazwy_kolumn

  for (i in 1:(okregi[okreg, 2])) {
    for (j in 1:length(wyniki)) {
      for (k in 1:(okregi[okreg, 2])) {
        for (l in 1:length(wyniki)) {
          if (dane[i, j] == dane[k, l] && (i != k || j != l)){
            if (wyniki[j] > wyniki[l]){
              dane[i, j] = dane[i, j] + 0.1
            } else if (wyniki[j] < wyniki[l]){
              dane[k, l] = dane[k, l] + 0.1
            }
          }
        }
      }
    }
  }

  dane2 = c()
  for (i in 1:length(wyniki)) {
    dane2 = c(dane2, dane[ ,i])
  }
  n = length(dane2)
  granica = sort(dane2, partial = n - (okregi[okreg, 2] - 1))[n - (okregi[okreg, 2] - 1)]
  przydzial = as.data.frame(dane >= granica)

  macierz_dane = colSums(przydzial) %>% unname()

  cyfry_rzymskie = c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X")
  wynik_dhont = data.frame("Komitet" = paste(cyfry_rzymskie[1:length(wyniki)], "Komitet"),
                           "D'Hont" = macierz_dane)
  wynik_dhont
}
