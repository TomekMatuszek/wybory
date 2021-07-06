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
    okregi = sapply(okregi, as.numeric)
    okregi = as.data.frame(okregi)
  } else if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".csv"){
    okregi = read.csv(nazwa, sep = ";")
  } else{
    stop("Wybrano nie obslugiwany format pliku!")
  }
  okregi <<- matrix(c(okregi[ ,7], okregi[ ,3]), ncol = 2, nrow = 41)
  colnames(okregi) <<- c("Liczba wyborców", "Liczba mandatów")
  message("Stworzono obiekt o nazwie 'okregi'")
}
