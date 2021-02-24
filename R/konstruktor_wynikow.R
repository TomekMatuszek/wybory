#' Konstruktor macierzy wyników wyborów
#'
#' @description Funkcja tworzy macierz, w ktorej każda kolumna zawiera wyniki wybranych
#' komitetów wyborczych. Każdy wiersz to inny okręg. Stworzona macierz może zostać później
#' użyta w funkcji wybory_rok w celu symulacji podziału mandatów.
#'
#' @param nazwa sciezka do pliku CSV lub XLS pobranego ze strony PKW
#' @param ... numery kolumn w ktorych znajduja sie wyniki interesujacych nas komitetow
#'
#' @return macierz klasy 'macierz_wynikow'
#' @export
#'
#' @examples
#' konstruktor_wynikow("sejm_wyniki_2019.xlsx", 9, 11, 12, 14, 16)
konstruktor_wynikow = function(nazwa, ...){
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
