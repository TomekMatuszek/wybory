#' Funkcja przetwarzajaca dane o wynikach wyborow
#'
#' @description Funkcja tworzy ramke danych, w ktorej kazda kolumna zawiera wyniki wybranych
#' komitetow wyborczych. Kazdy wiersz to inny okreg. Stworzona ramka danych moze zostac pozniej
#' uzyta w funkcji wybory_rok w celu symulacji podzialu mandatow oraz funkcji wykres_wyniki w celach wizualizacji wynikow.
#'
#' @param nazwa sciezka do pliku CSV lub XLS pobranego ze strony PKW
#' @param kolumny wektor z numerami kolumn, w ktorych znajduja sie interesujace nas komitety,
#' moze zawierac rowniez nazwy tych komitetow jako nazwy elementow wektora
#'
#' @return ramka danych
#' @export
#'
#' @examples
#' wybory_2019 = konstruktor_wynikow("dane_wybory/wyniki2019.xlsx",
#' c("KO" = 9, "Konf" = 11, "PSL" = 12, "PIS" = 14, "Lewica" = 16, "BS" = 17, "MN" = 18))
konstruktor_wynikow = function(nazwa, kolumny, koalicje = NULL){
  if(stringr::str_detect(nazwa, ".xls")){
    okregi_wyniki = readxl::read_excel(nazwa, .name_repair = "minimal")
    if (any(stringr::str_detect(okregi_wyniki, "[0-9]+\\,{1}[0-9]+"))){
      for (i in 1:ncol(okregi_wyniki)) {
        for (j in 1:41) {
          okregi_wyniki[j, i] = stringr::str_replace_all(okregi_wyniki[j, i], ",", ".")
        }
      }
    }
    okregi_wyniki = sapply(okregi_wyniki, as.numeric)
    okregi_wyniki = as.data.frame(okregi_wyniki)
  } else if(stringr::str_detect(nazwa, ".csv$")){
    okregi_wyniki = read.csv(nazwa, sep = ";")
    for (i in 1:ncol(okregi_wyniki)) {
      for (j in 1:41) {
        okregi_wyniki[j, i] = stringr::str_replace_all(okregi_wyniki[j, i], ",", ".")
      }
    }
    okregi_wyniki = sapply(okregi_wyniki, as.numeric)
  } else{
    stop("Wybrano nie obslugiwany format pliku!")
  }

  if(is.null(names(kolumny))){
    names(kolumny) = paste0("Kol", 1:length(kolumny))
  }
  if(is.null(koalicje)){
    k_index = kolumny[kolumny %in% which(stringr::str_detect(colnames(okregi_wyniki), "KOALICYJNY") | stringr::str_detect(colnames(okregi_wyniki), "Koalicyjny"))]
  } else{
    k_index = koalicje
  }
  if(is.character(k_index)){
    names(kolumny)[names(kolumny) %in% k_index] = paste0(names(kolumny)[names(kolumny) %in% k_index], "(K)")
  } else if(is.numeric(k_index)){
    names(kolumny)[kolumny %in% k_index] = paste0(names(kolumny)[kolumny %in% k_index], "(K)")
  }

  okregi_wyniki = okregi_wyniki[ , kolumny]
  okregi_wyniki = cbind(data.frame(Okreg = 1:41), okregi_wyniki)
  colnames(okregi_wyniki)[-1] = names(kolumny)
  okregi_wyniki[is.na(okregi_wyniki)] = 0
  okregi_wyniki
}
