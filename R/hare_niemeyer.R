hare_niemeyer = function(..., okreg, frekwencja = 100){
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
    warning(paste("Suma poparcia wszystkich komitetów wynosi", sum(wyniki), "%. \n To oznacza, że", 100 - sum(wyniki), "% głosów została oddana nieważnych lub na komitety, które nie przekroczyły progu wyborczego."))
  }

  liczba_glosow = wyniki / 100 * (frekwencja / 100) * okregi[okreg, 1]

  hn = liczba_glosow / ((frekwencja / 100) * okregi[okreg, 1]) * okregi[okreg, 2]
  hn2 = floor(hn)
  mandaty_integer = data.frame("Hare-Niemeyer" = hn2)
  hn3 = hn - hn2

  brak = okregi[okreg, 2] - sum(mandaty_integer)
  while (brak >= length(wyniki[wyniki > 0])){
    mandaty_integer[which(hn > 0), ] = mandaty_integer[which(hn > 0), ] + 1
    brak = okregi[okreg, 2] - sum(mandaty_integer)
  }

  dod_mandaty = data.frame(dod = rep(0, times = length(wyniki)))
  n = length(wyniki)
  if (sum(mandaty_integer) < okregi[okreg, 2]){
    granica = sort(hn3, partial = n - (brak - 1))[n - (brak - 1)]
    dod_mandaty = as.data.frame(hn3 >= granica)
  }
  if (sum(mandaty_integer) + sum(dod_mandaty) > okregi[okreg, 2]){
    a = 0
    for (i in 1:length(wyniki)) {
      for (j in 1:length(wyniki)) {
        if (hn3[i] == hn3[j] && (i != j) && any(c(hn3[i], hn3[j]) == granica)){
          dod_mandaty[max(c(i, j)), 1] = FALSE
          a = a + 1
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
  mandaty_integer$`Hare-Niemeyer` = rowSums(mandaty_integer)

  cyfry_rzymskie = c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X")
  mandaty_integer = data.frame("Komitet" = paste(cyfry_rzymskie[1:length(wyniki)], "Komitet"),
                               "Hare-Niemeyer" = mandaty_integer$`Hare-Niemeyer`)
  mandaty_integer
}
