okregi = read.csv("okregi_sejm.csv", sep = ";")
okregi = matrix(c(okregi[ ,7], okregi[ ,3]), ncol = 2, nrow = 41)
colnames(okregi) = c("Liczba wyborców", "Liczba mandatów")

okregi_wyniki = read.csv("sejm_wyniki.csv", sep = ";")
okregi_wyniki = matrix(c(okregi_wyniki[ ,9], okregi_wyniki[ ,11], okregi_wyniki[ ,12], 
                         okregi_wyniki[ ,14], okregi_wyniki[ ,16], okregi_wyniki[ ,18]),
                       nrow = 41, ncol = 6)
colnames(okregi_wyniki) = c("KO", "Konf", "PSL", "PiS", "Lewica", "MN")
