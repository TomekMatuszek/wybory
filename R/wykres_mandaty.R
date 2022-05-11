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
wykres_mandaty = function(wyniki, wyniki_raw = NA){
  `%>%` = dplyr::`%>%`
  wyniki_longer = tidyr::pivot_longer(wyniki, cols = 2:4,
                                      names_to = "metoda")
  if (is.data.frame(wyniki_raw)){
    wyniki_raw_longer = tidyr::pivot_longer(wyniki_raw, cols = 2:ncol(wyniki_raw),
                                            names_to = "komitet")
    wyniki_raw_longer = wyniki_raw_longer %>% dplyr::group_by(komitet) %>%
      dplyr::summarise(mean = mean(value) / 100)
  }

  p = ggplot2::ggplot(wyniki_longer, ggplot2::aes(x = metoda, y = value, fill = Komitet)) +
    ggplot2::geom_bar(position = "dodge", stat = "identity")
  if (sum(wyniki[, -1]) / 3 == 460){
    p = p + ggplot2::geom_hline(yintercept = 230, size = 1.5, colour = "red")
  }
  if (is.data.frame(wyniki_raw)){
    p = p + ggplot2::geom_hline(data = wyniki_raw_longer, size = 1, show.legend = FALSE,
                                ggplot2::aes(yintercept = 460 * mean, colour = komitet))
  }
  p
}
