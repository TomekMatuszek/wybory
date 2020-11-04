#Ponizsze linijki kodu tworza macierz okregow wyborczych
#Zawiera ona liczbe wyborcow w danym okregu oraz przypadajacych na niego mandatow
okregi = read.csv("okregi_sejm.csv", sep = ";")
okregi = matrix(c(okregi[ ,7], okregi[ ,3]), ncol = 2, nrow = 41)
colnames(okregi) = c("Liczba wyborców", "Liczba mandatów")

#Konstruktor wynikow tworzy macierz wynikow o strukturze pozwalajacej uzyc funkcji przydzielajacych mandaty
#Nalezy wpisac sciezke do pobranego przez nas pliku excel z wynikami wyborow ze strony PKW
#Kolejne argumenty (max 5) oznaczaja numery kolumn w ktorych znajduja sie wyniki interesujacych nas komitetow
library(readxl)
library(stringr)
konstruktor_wynikow = function(nazwa, kol1, kol2, kol3, kol4, kol5){
  okregi_wyniki = read_excel(nazwa, skip = 1, col_names = FALSE, .name_repair = "minimal")
  okregi_wyniki = sapply(okregi_wyniki, as.numeric)
  okregi_wyniki = as.data.frame(okregi_wyniki)
  #okregi_wyniki = read.csv(nazwa, sep = ";")
  okregi_wyniki = matrix(c(okregi_wyniki[ ,kol1], okregi_wyniki[ ,kol2], okregi_wyniki[ ,kol3], 
                           okregi_wyniki[ ,kol4], okregi_wyniki[ ,kol5]),
                         nrow = 41, ncol = 5)
  colnames(okregi_wyniki) = c("Kom1", "Kom2", "Kom3", "Kom4", "Kom5")
  okregi_wyniki = structure(okregi_wyniki, class = "macierz_wynikow")
  okregi_wyniki
}
wybory_2019 = konstruktor_wynikow("sejm_wyniki2019.csv", 9, 11, 12, 14, 16)
wybory_2015 = konstruktor_wynikow("sejm_wyniki_2015.xls", 9, 10, 13, 15, 16)
okregi_wyniki


if(str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == "xls"){
  okregi_wyniki = read_excel(nazwa, skip = 1, col_names = FALSE, .name_repair = "minimal")
  okregi_wyniki = sapply(okregi_wyniki, as.numeric)
  okregi_wyniki = as.data.frame(okregi_wyniki)
} else if(str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == "csv"){
  okregi_wyniki = read.csv(nazwa, sep = ";")
}
