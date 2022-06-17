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
#' konstruktor_okregow("okregi2019.csv")
konstruktor_okregow = function(nazwa){
  if(stringr::str_detect(nazwa, ".xls")){
    okregi = readxl::read_excel(nazwa, .name_repair = "minimal")
    okregi = sapply(okregi, as.numeric)
    okregi = as.data.frame(okregi)
  } else if(stringr::str_detect(nazwa, ".csv$")){
    okregi = read.csv(nazwa, sep = ";")
  } else{
    stop("Wybrano nie obslugiwany format pliku!")
  }
  rok = stringr::str_sub(stringr::str_extract(nazwa, pattern = "dane_wybory/.+"), start = 19, end = 22)
  if (rok == "2019" || rok == "2015"){
    okregi <<- data.frame(`Liczba wyborców` = okregi[ ,7],
                          `Liczba mandatów` = okregi[ ,3],
                          `Numer` = 1:nrow(okregi))
  } else if (rok == "2011"){
    okregi <<- data.frame(`Liczba wyborców` = okregi[ ,5],
                          `Liczba mandatów` = okregi[ ,2],
                          `Numer` = 1:nrow(okregi))
  } else if (rok == "2007"){
    okregi <<- data.frame(`Liczba wyborców` = okregi[ ,4],
                          `Liczba mandatów` = okregi[ ,3],
                          `Numer` = 1:nrow(okregi))
  }
  message("Stworzono obiekt o nazwie 'okregi'")
}
