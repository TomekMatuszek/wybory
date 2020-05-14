dhont = function(kom1, kom2, kom3, kom4, kom5, okreg, frekwencja = 100){
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
  dane = data.frame(komitet1 = vector(),
                    komitet2 = vector(),
                    komitet3 = vector(),
                    komitet4 = vector(),
                    komitet5 = vector(),
                    stringsAsFactors = FALSE)
  for (i in 1:(okregi[okreg, 2])){
    x = data.frame(komitet1 = liczba_glosow[1] / i,
                   komitet2 = liczba_glosow[2] / i,
                   komitet3 = liczba_glosow[3] / i,
                   komitet4 = liczba_glosow[4] / i,
                   komitet5 = liczba_glosow[5] / i,
                   stringsAsFactors = FALSE)
    dane = rbind(dane, x)
  }
  
  for (i in 1:(okregi[okreg, 2])) {
    for (j in 1:5) {
      for (k in 1:(okregi[okreg, 2])) {
        for (l in 1:5) {
          if (dane[i, j] == dane[k, l] && (i != k || j != l)){
            if (j < l){
              dane[i, j] = dane[i, j] + 0.1
            } else if (j > l){
              dane[k, l] = dane[k, l] + 0.1
            }
          }
        }
      }
    }
  }
  
  dane2 = c(dane$komitet1, dane$komitet2, dane$komitet3, dane$komitet4, dane$komitet5)
  n = length(dane2)
  granica = sort(dane2, partial = n - (okregi[okreg, 2] - 1))[n - (okregi[okreg, 2] - 1)]
  przydzial = as.data.frame(dane >= granica)
  
  pierwszy_mandaty = sum(przydzial$komitet1)
  drugi_mandaty = sum(przydzial$komitet2)
  trzeci_mandaty = sum(przydzial$komitet3)
  czwarty_mandaty = sum(przydzial$komitet4)
  piaty_mandaty = sum(przydzial$komitet5)
  
  wynik_dhont = matrix(c(pierwszy_mandaty, drugi_mandaty, trzeci_mandaty, czwarty_mandaty, piaty_mandaty), ncol = 1, nrow = 5)
  colnames(wynik_dhont) = "D'Hont"
  rownames(wynik_dhont) = c("I Komitet", "II Komitet", "III Komitet", "IV Komitet", "V Komitet")
  wynik_dhont
}
