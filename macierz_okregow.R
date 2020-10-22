okregi = read.csv("okregi_sejm.csv", sep = ";")
okregi = matrix(c(okregi[ ,7], okregi[ ,3]), ncol = 2, nrow = 41)
colnames(okregi) = c("Liczba wyborców", "Liczba mandatów")

konstruktor_wynikow = function(nazwa, kol1, kol2, kol3, kol4, kol5){
  okregi_wyniki <<- read.csv(nazwa, sep = ";")
  okregi_wyniki <<- matrix(c(okregi_wyniki[ ,kol1], okregi_wyniki[ ,kol2], okregi_wyniki[ ,kol3], 
                           okregi_wyniki[ ,kol4], okregi_wyniki[ ,kol5]),
                         nrow = 41, ncol = 5)
  colnames(okregi_wyniki) <<- c("Kom1", "Kom2", "Kom3", "Kom4", "Kom5")
  okregi_wyniki <<- structure(okregi_wyniki, class = "macierz_wynikow")
}
konstruktor_wynikow("sejm_wyniki.csv", 9, 11, 12, 14, 16)
konstruktor_wynikow("sejm_wyniki2.csv", 9, 10, 13, 15, 16)
