#' Wykres wizualizujący wyniki wyborow
#'
#' @description Nowa wersja wykresu słupkowego z wynikami w podziale na mateody
#'
#' @param wyniki obiekt z wynikami podziału mandatów
#'
#' @return wykres słupkowy
#' @export
#'
#' @examples
#' wykres_mandaty(wyniki_2019)
wykres_mandaty = function(wyniki){
  `%>%` = dplyr::`%>%`
  liczba_mandatow = sum(wyniki[, 2])
  wyniki_longer = tidyr::pivot_longer(wyniki, cols = 2:4,
                                      names_to = "metoda")
  wyniki_longer$pop_man = round(wyniki_longer$poparcie / 100 * liczba_mandatow, 1)
  wyniki_longer$diff = wyniki_longer$value - wyniki_longer$pop_man

  p = ggplot2::ggplot(wyniki_longer) +
    ggplot2::geom_bar(ggplot2::aes(x = metoda, y = value, fill = Komitet, alpha = "uzyskany wynik"),
                      position = "dodge", stat = "identity") +
    ggplot2::geom_bar(ggplot2::aes(x = metoda, y = poparcie * liczba_mandatow / 100, fill = Komitet),
                      colour = "black", alpha = 0.2, show.legend = FALSE,
                      position = "dodge", stat = "identity") +
    ggplot2::geom_text(ggplot2::aes(x = metoda, y = -(liczba_mandatow / 70), label = round(diff, 1), group = Komitet),
                       position = ggplot2::position_dodge(width = 0.9), hjust = 0.5, fontface = "bold", size = 3,
                       color = ifelse(wyniki_longer$diff < 0, "red",
                                      ifelse(wyniki_longer$diff == 0, "orange", "forestgreen"))) +
    ggplot2::scale_y_continuous(sec.axis = ggplot2::sec_axis(~. / liczba_mandatow * 100, name = "poparcie w %")) +
    ggplot2::scale_alpha_manual(name = NULL, values = rep(1, nrow(wyniki)),
                                guide = ggplot2::guide_legend(
                                  override.aes = list(colour = "black", fill = NA)
                                )) +
    ggplot2::labs(title = "Podział mandatów w zależności od metody",
                  x = "metoda podziału",
                  y = "liczba mandatów",
                  fill = "otrzymane mandaty",
                  subtitle = paste("Liczba mandatów:", liczba_mandatow)) +
    ggplot2::theme_bw() +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5, face = "bold"),
                   plot.subtitle = ggplot2::element_text(hjust = 0.5))
  #+ ggplot2::scale_fill_manual(values = palette.colors(palette = "Set1"))
  if (liczba_mandatow == 460){
    p = p + ggplot2::geom_hline(yintercept = 230, size = 1.5, colour = "red") +
      ggplot2::annotate("text", x = 3.25, y = 238, label = "większość (230)", colour = "red")
  }
  p
}
