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
  if(stringr::str_detect(nazwa, ".xls")){
    okregi_wyniki_df = readxl::read_excel(nazwa, .name_repair = "minimal")
    if (any(stringr::str_detect(okregi_wyniki_df, "[0-9]+\\,{1}[0-9]+"))){
      for (i in 1:ncol(okregi_wyniki_df)) {
        for (j in 1:41) {
          okregi_wyniki_df[j, i] = stringr::str_replace_all(okregi_wyniki_df[j, i], ",", ".")
        }
      }
    }
    okregi_wyniki_df = sapply(okregi_wyniki_df, as.numeric)
    okregi_wyniki_df = as.data.frame(okregi_wyniki_df)
  } else if(stringr::str_detect(nazwa, ".csv$")){
    okregi_wyniki_df = read.csv(nazwa, sep = ";")
    okregi_wyniki_df = sapply(okregi_wyniki_df, as.numeric)
  }
  kolumny = c(...)
  for (i in 1:ncol(okregi_wyniki_df)) {
    if (length(which(okregi_wyniki_df[ , i] > 0)) == 1){
      okregi_wyniki_df[ , i] = rep(0, times = 41)
      kolumny = kolumny[kolumny != i]
    }
  }
  okregi_wyniki_df = okregi_wyniki_df[, kolumny]
  okregi_wyniki_df = cbind(data.frame(Okreg = 1:41), okregi_wyniki_df)
  colnames(okregi_wyniki_df)[-1] = paste0("Kol", 1:length(kolumny))
  okregi_wyniki_df = tidyr::pivot_longer(okregi_wyniki_df,
                                         cols = 2:ncol(okregi_wyniki_df),
                                         names_to = "komitet")
  cols = c("tomato", "black", "limegreen", "dodgerblue3", "violetred3",
           "gold", "forestgreen", "darkorchid3", "cornflowerblue", "lightgoldenrod4")

  ggplot2::ggplot(data = okregi_wyniki_df, ggplot2::aes(x = komitet, y = value, color = komitet)) +
    ggplot2::geom_boxplot(color = "gray40") + ggplot2::geom_jitter(size = 1.5, alpha = 0.3, width = 0.3) +
    ggplot2::scale_color_manual(values = cols[1:length(kolumny)]) +
    ggplot2::labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia") +
    ggplot2::ggtitle("Rozkład wyników poszczególnych komitetów w okręgach wyborczych") +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::geom_hline(yintercept = 5, color = "gray40", size = 0.5)
}
