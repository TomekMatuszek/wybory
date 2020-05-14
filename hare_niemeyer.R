hare_niemeyer = function(kom1, kom2, kom3, kom4, kom5, okreg, frekwencja = 100){
  if (is.numeric(c(kom1, kom2, kom3, kom4, kom5)) == FALSE){
    stop("Wprowadzane argumenty muszą być liczbami!")
  }
  if (frekwencja > 100 || frekwencja < 0){
    stop("Frekwencja musi być liczbą z przedziału (0,100)!")
  }
  if (sum(kom1, kom2, kom3, kom4, kom5) > 100){
    stop("Suma poparcia poszczególnych komitetów jest wyższa niż 100%!")
  }
  if (is.numeric(okreg) == FALSE || round(okreg, 0) != okreg || okreg > 41 || okreg < 1){
    stop("Wybierz numer okręgu z przedziału liczb całkowitych (1,41)!")
  }
  if (sum(kom1, kom2, kom3, kom4, kom5) < 90){
    warning(paste("Suma poparcia wszystkich komitetów wynosi", sum(kom1, kom2, kom3, kom4, kom5), "%. \n To oznacza, że", 100 - sum(kom1, kom2, kom3, kom4, kom5), "% głosów została oddana nieważnych lub na komitety, które nie przekroczyły progu wyborczego."))
  }
  
  liczba_glosow = c(kom1 / 100 * (frekwencja / 100) * okregi[okreg, 1], 
                    kom2 / 100 * (frekwencja / 100) * okregi[okreg, 1], 
                    kom3 / 100 * (frekwencja / 100) * okregi[okreg, 1], 
                    kom4 / 100 * (frekwencja / 100) * okregi[okreg, 1], 
                    kom5 / 100 * (frekwencja / 100) * okregi[okreg, 1])
  hn = c(liczba_glosow[1] / ((frekwencja / 100) * okregi[okreg, 1]) * okregi[okreg, 2],
         liczba_glosow[2] / ((frekwencja / 100) * okregi[okreg, 1]) * okregi[okreg, 2],
         liczba_glosow[3] / ((frekwencja / 100) * okregi[okreg, 1]) * okregi[okreg, 2],
         liczba_glosow[4] / ((frekwencja / 100) * okregi[okreg, 1]) * okregi[okreg, 2],
         liczba_glosow[5] / ((frekwencja / 100) * okregi[okreg, 1]) * okregi[okreg, 2])
  mandaty_integer = matrix(c(as.integer(hn[1]),
                             as.integer(hn[2]),
                             as.integer(hn[3]),
                             as.integer(hn[4]),
                             as.integer(hn[5])),
                           ncol = 1, nrow = 5)
  
  hn2 = c()
  for (i in 1:length(hn)) {
    hn2 = c(hn2, hn[i] - as.integer(hn[i]))
  }
  n = length(hn2)
  granica = sort(hn2, partial = n - ((okregi[okreg, 2] - sum(mandaty_integer)) - 1))[n - ((okregi[okreg, 2] - sum(mandaty_integer)) - 1)]
  dod_mandaty = as.matrix(hn2 >= granica)
  
  if (colSums(mandaty_integer) + colSums(dod_mandaty) > okregi[okreg, 2]){
    a <<- 0
    for (i in 1:5) {
      for (j in 1:5) {
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
  wynik_hn = matrix(rowSums(mandaty_integer), ncol = 1, nrow = 5)
  colnames(wynik_hn) = "Hare-Niemeyer"
  rownames(wynik_hn) = c("I Komitet", "II Komitet", "III Komitet", "IV Komitet", "V Komitet")
  wynik_hn
}
