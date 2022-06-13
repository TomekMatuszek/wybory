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
wykres_wyniki = function(wyniki){
  kolumny = 2:ncol(wyniki)
  for (i in kolumny) {
    if (length(which(wyniki[ , i] > 0)) == 1){
      wyniki = wyniki[ , -i]
    }
  }
  wyniki_longer = tidyr::pivot_longer(wyniki, cols = 2:ncol(wyniki), names_to = "komitet")

  ggplot2::ggplot(data = wyniki_longer, ggplot2::aes(x = komitet, y = value, color = komitet)) +
    ggplot2::coord_cartesian(xlim = c(1, ncol(wyniki) - 1), clip = "off") +
    ggplot2::geom_boxplot(color = "gray40") + ggplot2::geom_jitter(size = 2, alpha = 0.5, width = 0.3) +
    ggplot2::scale_color_manual(values = c(palette.colors(palette = "Set1")[-6], palette.colors(palette = "Dark2"))) +
    ggplot2::labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia") +
    ggplot2::ggtitle("Rozkład wyników poszczególnych komitetów w okręgach wyborczych") +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
    ggplot2::geom_hline(yintercept = 5, color = "red", size = 1) +
    ggplot2::annotate("text", x = ncol(wyniki) - 0.05, y = 5.5, label = "próg 5%",
                      colour = "red", fontface = "bold") +
    ggplot2::theme_bw() +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5, face = "bold"),
                   plot.subtitle = ggplot2::element_text(hjust = 0.5),
                   plot.background = ggplot2::element_rect(fill = "gray80"),
                   legend.background = ggplot2::element_blank(),
                   legend.key = ggplot2::element_blank())
}
