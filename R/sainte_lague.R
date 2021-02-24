sainte_lague = function(..., okreg, frekwencja = 100){
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
  dane = data.frame(pusta = vector() , stringsAsFactors = FALSE)
  nazwy_kolumn = c()
  for (i in 1:length(wyniki)) {
    x = data.frame(kolumna = vector(), stringsAsFactors = FALSE)
    dane = cbind(dane, x)
    nazwy_kolumn = c(nazwy_kolumn, paste0("komitet", i))
  }
  dane = dane[ , 2:(length(wyniki) + 1)]
  colnames(dane) = nazwy_kolumn
  for (i in seq(from = 1, to = 1 + (okregi[okreg, 2] * 2), by = 2)){
    x = data.frame(pusta = 0, stringsAsFactors = FALSE)
    for (j in 1:length(wyniki)) {
      y = data.frame(kolumna = liczba_glosow[j] / i, stringsAsFactors = FALSE)
      x = cbind(x, y)
      if (x[1, 1] == 0){
        x = x$kolumna
      }
    }
    colnames(x) = nazwy_kolumn
    dane = rbind(dane, x)
  }

  for (i in 1:(okregi[okreg, 2])) {
    for (j in 1:length(wyniki)) {
      for (k in 1:(okregi[okreg, 2])) {
        for (l in 1:length(wyniki)) {
          if (dane[i, j] == dane[k, l] && (i != k || j != l)){
            if (j < l){
              dane[i, j] = dane[i, j] + 0.1
            } else if (j >= l){
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

  macierz_dane = c()
  for (i in 1:length(wyniki)) {
    macierz_dane = c(macierz_dane, sum(przydzial[ , i]))
  }
  wynik_sl = matrix(macierz_dane, ncol = 1, nrow = length(wyniki))

  cyfry_rzymskie = c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X")
  colnames(wynik_sl) = "Sainte-Lague"
  nazwy_wierszy = c()
  for (i in 1:length(wyniki)) {
    nazwy_wierszy = c(nazwy_wierszy, paste(cyfry_rzymskie[i], "Komitet"))
  }
  rownames(wynik_sl) = nazwy_wierszy
  wynik_sl
}
