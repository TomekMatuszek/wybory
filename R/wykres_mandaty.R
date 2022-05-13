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
  wyniki_longer$poparcie = wyniki_longer$poparcie / 100 * liczba_mandatow

  p = ggplot2::ggplot(wyniki_longer) +
    ggplot2::geom_bar(ggplot2::aes(x = metoda, y = value, fill = Komitet),
                      position = "dodge", stat = "identity") +
    ggplot2::geom_bar(ggplot2::aes(x = metoda, y = poparcie, fill = Komitet),
                      colour = "black", alpha = 0.3, show.legend = FALSE,
                      position = "dodge", stat = "identity")
  #+ ggplot2::scale_fill_manual(values = palette.colors(palette = "Set1"))
  if (liczba_mandatow == 460){
    p = p + ggplot2::geom_hline(yintercept = 230, size = 1.5, colour = "red")
  }
  p
}
