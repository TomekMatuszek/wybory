#' Wykres eksploracyjny - wyniki wyborow
#'
#' @description Funkcja ta tworzy wykres pudelkowy obrazujacy rozklad wynikow poszczegolnych komitetow wyborczych w okregach
#'
#' @param nazwa sciezka do pliku z wynikami wyborow pobranego ze strony PKW
#' @param ... numery kolumn w ktorych znajduja sie wyniki interesujacych nas komitetow
#'
#' @return wykres pudelkowy obrazujacy rozklad wynikow partii w okregach
#' @export
#'
#' @examples
#' wykres_wyniki("sejm_wyniki_2019.xlsx", 9, 11, 12, 14, 16)
wykres_wyniki = function(nazwa, ...){
  if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".xls"){
    okregi_wyniki_df = readxl::read_excel(nazwa, skip = 1, col_names = FALSE, .name_repair = "minimal")
    #for (i in 1:ncol(okregi_wyniki_df)) {
     # for (j in 1:41) {
      #  okregi_wyniki_df[j, i] = stringr::str_replace_all(okregi_wyniki_df[j, i], ",", ".")
      #}
    #}
    okregi_wyniki_df = sapply(okregi_wyniki_df, as.numeric)
    okregi_wyniki_df = as.data.frame(okregi_wyniki_df)
  } else if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".csv"){
    okregi_wyniki_df = read.csv(nazwa, sep = ";")
    for (i in 1:ncol(okregi_wyniki_df)) {
      for (j in 1:41) {
        okregi_wyniki_df[j, i] = stringr::str_replace_all(okregi_wyniki_df[j, i], ",", ".")
      }
    }
    okregi_wyniki_df = sapply(okregi_wyniki_df, as.numeric)
  }
  kolumny = c(...)
  kol_komitet = c()
  for (i in 1:length(kolumny)) {
    kol_komitet = c(kol_komitet, rep(paste0("Kom", i), times = nrow(okregi_wyniki_df)))
  }
  kol_wyniki = c()
  for (i in kolumny) {
    kol_wyniki = c(kol_wyniki, okregi_wyniki_df[ , i])
  }
  okregi_wyniki_df = data.frame(komitet = kol_komitet,
                                okreg = c(rep(1:41, times = length(kolumny))),
                                wynik = kol_wyniki
  )
  cols = c("orange", "black", "darkgreen", "blue", "red", "limegreen", "lightblue")

  ggplot2::ggplot(data = okregi_wyniki_df, ggplot2::aes(x = komitet, y = wynik, color = komitet)) +
    ggplot2::geom_boxplot(color = "black") + ggplot2::geom_jitter(size = 1, alpha = 0.3, width = 0.3) +
    ggplot2::scale_color_manual(values = cols[1:length(kolumny)]) +
    ggplot2::labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia") +
    ggplot2::ggtitle("Rozkład wyników poszczególnych komitetów w okręgach wyborczych") +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::geom_hline(yintercept = 5, color = "gray40", size = 0.5)
}
