okregi = read.csv("okregi_sejm.csv", sep = ";")
okregi = matrix(c(okregi[ ,7], okregi[ ,3]), ncol = 2, nrow = 41)
colnames(okregi) = c("Liczba wyborców", "Liczba mandatów")
