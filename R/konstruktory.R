#' Konstruktor macierzy okregow wyborczych
#'
#' @description Funkcja tworzy macierz, w ktorej znajduja sie informacje dotyczace
#' okregow wyborczych - liczby ludnosci oraz dostepnych mandatow.
#'
#' @param nazwa sciezka do pliku CSV lub XLS pobranego ze strony PKW
#'
#' @return macierz o nazwie 'okregi'
#' @export
#'
#' @examples
#' konstruktor_okregow("okregi_sejm.csv")
konstruktor_okregow = function(nazwa){
  if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".xls"){
    okregi = readxl::read_excel(nazwa, skip = 1, col_names = FALSE, .name_repair = "minimal")
    okregi = sapply(okregi_dane, as.numeric)
    okregi = as.data.frame(okregi_dane)
  } else if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".csv"){
    okregi = read.csv(nazwa, sep = ";")
  } else{
    stop("Wybrano nie obslugiwany format pliku!")
  }
  okregi <<- matrix(c(okregi[ ,7], okregi[ ,3]), ncol = 2, nrow = 41)
  colnames(okregi) <<- c("Liczba wyborców", "Liczba mandatów")
  message("Stworzono obiekt o nazwie 'okregi'")
}
konstruktor_okregow("okregi_sejm.csv")

#Konstruktor wynikow tworzy macierz wynikow o strukturze pozwalajacej uzyc funkcji przydzielajacych mandaty
#Nalezy wpisac sciezke do pobranego przez nas pliku excel z wynikami wyborow ze strony PKW
#Kolejne argumenty (max 5) oznaczaja numery kolumn w ktorych znajduja sie wyniki interesujacych nas komitetow
konstruktor_wynikow2 = function(nazwa, ...){
  if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".xls"){
    okregi_wyniki = readxl::read_excel(nazwa, skip = 1, col_names = FALSE, .name_repair = "minimal")
    okregi_wyniki = sapply(okregi_wyniki, as.numeric)
    okregi_wyniki = as.data.frame(okregi_wyniki)
  } else if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".csv"){
    okregi_wyniki = read.csv(nazwa, sep = ";")
  } else{
    stop("Wybrano nie obslugiwany format pliku!")
  }
  kolumny = c(...)
  wektor_wyniki = c()
  for (i in kolumny) {
    wektor_wyniki = c(wektor_wyniki, okregi_wyniki[ ,i])
  }
  okregi_wyniki = matrix(wektor_wyniki , nrow = 41, ncol = length(kolumny))
  nazwy_kolumn = c()
  for (i in 1:length(kolumny)) {
    nazwy_kolumn = c(nazwy_kolumn, paste0("Kol", i))
  }
  colnames(okregi_wyniki) = nazwy_kolumn
  okregi_wyniki = structure(okregi_wyniki, class = "macierz_wynikow")
  okregi_wyniki
}
