sainte_lague = function(kom1, kom2, kom3, kom4, kom5, okreg){
  liczba_glosow = c(kom1 / 100 * okregi[okreg, 1], 
                    kom2 / 100 * okregi[okreg, 1], 
                    kom3 / 100 * okregi[okreg, 1], 
                    kom4 / 100 * okregi[okreg, 1], 
                    kom5 / 100 * okregi[okreg, 1])
  dane = data.frame(komitet1 = vector(),
                    komitet2 = vector(),
                    komitet3 = vector(),
                    komitet4 = vector(),
                    komitet5 = vector(),
                    stringsAsFactors = FALSE)
  for (i in seq(from = 1, to = 9, by = 2)){
    x = data.frame(komitet1 = liczba_glosow[1] / i,
                   komitet2 = liczba_glosow[2] / i,
                   komitet3 = liczba_glosow[3] / i,
                   komitet4 = liczba_glosow[4] / i,
                   komitet5 = liczba_glosow[5] / i,
                   stringsAsFactors = FALSE)
    dane = rbind(dane, x)
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
  wynik_sl = matrix(c(pierwszy_mandaty, drugi_mandaty, trzeci_mandaty, czwarty_mandaty, piaty_mandaty), ncol = 1, nrow = 5)
  colnames(wynik_sl) = "Sainte-Lague"
  rownames(wynik_sl) = c("I Komitet", "II Komitet", "III Komitet", "IV Komitet", "V Komitet")
  wynik_sl
}
sainte_lague(37, 25, 16, 12, 10, 39)
