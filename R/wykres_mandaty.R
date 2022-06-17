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
  wyniki_longer$repr = wyniki_longer$poparcie * ifelse(wyniki_longer$value > 0, 1, 0)

  p = ggplot2::ggplot(wyniki_longer) +
    ggplot2::geom_bar(ggplot2::aes(x = metoda, y = value, fill = Komitet, alpha = "uzyskany wynik"),
                      position = "dodge", stat = "identity") +
    ggplot2::geom_bar(ggplot2::aes(x = metoda, y = poparcie * liczba_mandatow / 100, fill = Komitet),
                      colour = "gray10", alpha = 0.2, show.legend = FALSE, size = 1,
                      position = "dodge", stat = "identity") +
    ggplot2::geom_text(ggplot2::aes(x = metoda, y = -(liczba_mandatow / 70), label = round(diff, 1), group = Komitet),
                       position = ggplot2::position_dodge(width = 0.9), hjust = 0.5, fontface = "bold",
                       size = 1 / (nrow(wyniki) / 20),
                       color = ifelse(wyniki_longer$diff < 0, "red",
                                      ifelse(wyniki_longer$diff == 0, "orange", "forestgreen"))) +
    ggplot2::geom_label(ggplot2::aes(x = metoda, y = ifelse(value < 0.025 * liczba_mandatow, 0.05 * liczba_mandatow, value / 2), label = value, group = Komitet),
                       position = ggplot2::position_dodge(width = 0.9), hjust = 0.5, fontface = "bold",
                       size = 1 / (nrow(wyniki) / 20), color = "black", label.size = NA, alpha = 0.9,
                       label.padding = grid::unit(0.1, "lines"), label.r = grid::unit(0, "lines")) +
    ggplot2::coord_cartesian(xlim = c(1, 3), clip = "off") +
    ggplot2::scale_x_discrete(labels = c("D'Honta", "Sainte-Lague", "Hare-Nimeyera")) +
    ggplot2::scale_y_continuous(sec.axis = ggplot2::sec_axis(~. / liczba_mandatow * 100, name = "poparcie w %")) +
    ggplot2::scale_alpha_manual(name = NULL, values = rep(1, nrow(wyniki)),
                                guide = ggplot2::guide_legend(
                                  override.aes = list(colour = "black", fill = "gray", alpha = 0.2)
                                )) +
    ggplot2::labs(title = "Podział mandatów w zależności od metody",
                  x = "metoda podziału",
                  y = "liczba mandatów",
                  fill = "otrzymane mandaty",
                  subtitle = paste("Liczba mandatów:", liczba_mandatow)) +
    ggplot2::theme_bw() +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5, face = "bold"),
                   plot.subtitle = ggplot2::element_text(hjust = 0.5),
                   plot.background = ggplot2::element_rect(fill = "gray80"),
                   legend.background = ggplot2::element_blank(),
                   legend.key = ggplot2::element_blank()) +
    ggplot2::scale_fill_manual(values = c(palette.colors(palette = "Set1")[-6], palette.colors(palette = "Dark2")))
  if (liczba_mandatow == 460){
    p = p + ggplot2::geom_hline(yintercept = 230, size = 1.5, colour = "red") +
      ggplot2::annotate("text", x = 4, y = 232, label = "większość (230)", colour = "red", fontface = "bold") +
      ggplot2::labs(caption = paste("Reprezentowanych wyborców:", sum(wyniki_longer$repr) / 3, "%"))
  }
  p
}
