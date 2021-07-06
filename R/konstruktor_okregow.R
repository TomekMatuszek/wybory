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
  if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".xls"){
    okregi = readxl::read_excel(nazwa, skip = 1, col_names = FALSE, .name_repair = "minimal")
    okregi = sapply(okregi, as.numeric)
    okregi = as.data.frame(okregi)
  } else if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".csv"){
    okregi = read.csv(nazwa, sep = ";")
  } else{
    stop("Wybrano nie obslugiwany format pliku!")
  }
  rok = stringr::str_sub(nazwa, start = 7, end = 10)
  if (rok == "2019" || rok == "2015"){
    okregi <<- matrix(c(okregi[ ,7], okregi[ ,3]), ncol = 2, nrow = 41)
  } else if (rok == "2011"){
    okregi <<- matrix(c(okregi[ ,5], okregi[ ,2]), ncol = 2, nrow = 41)
  } else if (rok == "2007"){
    okregi <<- matrix(c(okregi[ ,4], okregi[ ,3]), ncol = 2, nrow = 41)
  }
  colnames(okregi) <<- c("Liczba wyborców", "Liczba mandatów")
  message("Stworzono obiekt o nazwie 'okregi'")
}
