#' Wykres eksploracyjny - wyniki wyborow
#'
#' @description Funkcja ta tworzy wykres pudelkowy obrazujacy rozklad wynikow poszczegolnych komitetow wyborczych w okregach
#'
#' @param nazwa sciezka do pliku z wynikami wyborow pobranego ze strony PKW
#' @param kol1,kol2,kol3,kol4,kol5 numery kolumn w ktorych znajduja sie wyniki interesujacych nas pieciu komitetow
#'
#' @return wykres pudelkowy obrazujacy rozklad wynikow partii w okregach
#' @export
#'
#' @examples
#' wykres_wyniki("sejm_wyniki_2019.xlsx", kol1 = 9, kol2 = 11, kol3 = 12, kol4 = 14, kol5 = 16)
wykres_wyniki = function(nazwa, kol1, kol2, kol3, kol4, kol5){
  if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".xls"){
    okregi_wyniki_df = readxl::read_excel(nazwa, skip = 1, col_names = FALSE, .name_repair = "minimal")
    okregi_wyniki_df = sapply(okregi_wyniki_df, as.numeric)
    okregi_wyniki_df = as.data.frame(okregi_wyniki_df)
  } else if(stringr::str_extract(nazwa, pattern = "[\\.]+[a-z]{3}") == ".csv"){
    okregi_wyniki_df = read.csv(nazwa, sep = ";")
  }
  okregi_wyniki_df = data.frame(komitet = c(rep("Kom1", times = 41), rep("Kom2", times = 41),
                                            rep("Kom3", times = 41), rep("Kom4", times = 41),
                                            rep("Kom5", times = 41)),
                                okreg = c(rep(1:41, times = 5)),
                                wynik = c(okregi_wyniki_df[ ,kol1], okregi_wyniki_df[ ,kol2], okregi_wyniki_df[ ,kol3],
                                          okregi_wyniki_df[ ,kol4], okregi_wyniki_df[ ,kol5])
                                )

  ggplot2::ggplot(data = okregi_wyniki_df, ggplot2::aes(x = komitet, y = wynik, color = komitet)) +
    ggplot2::geom_boxplot(color = "black") + ggplot2::geom_jitter(size = 2, alpha = 0.3, width = 0.3) +
    ggplot2::scale_color_manual(values = c("orange", "black", "darkgreen", "blue", "red")) +
    ggplot2::labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia") +
    ggplot2::ggtitle("Rozklad wyników poszczególnych komitetów w okregach wyborczych") +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
}
