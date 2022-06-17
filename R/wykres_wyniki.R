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

wykres_wyniki = function(wyniki, type = "boxplot"){
  `%>%` = dplyr::`%>%`
  kolumny = 2:ncol(wyniki)
  for (i in kolumny) {
    if (length(which(wyniki[ , i] > 0)) == 1){
      warning(paste0("Z wykresu usunięto komitet ", colnames(wyniki)[i],
                     " z racji zbyt małej liczby okręgów w których był zarejestrowany."))
      wyniki = wyniki[ , -i]
    }
  }
  wyniki_longer = tidyr::pivot_longer(wyniki, cols = 2:ncol(wyniki), names_to = "komitet")
  if(type == "boxplot"){
    wykres_wyniki.boxplot(wyniki_longer)
  } else if(type == "violin"){
    wykres_wyniki.violin(wyniki_longer)
  } else if(type == "dotplot"){
    wykres_wyniki.dotplot(wyniki_longer)
  } else if(type == "scatter"){
    wykres_wyniki.scatter(wyniki_longer)
  }
}

wykres_wyniki.boxplot = function(wyniki){
  ggplot2::ggplot(data = wyniki, ggplot2::aes(x = komitet, y = value, color = komitet)) +
    ggplot2::coord_cartesian(xlim = c(1, length(unique(wyniki$komitet))), clip = "off") +
    ggplot2::geom_boxplot(color = "gray40") + ggplot2::geom_jitter(size = 2, alpha = 0.5, width = 0.3) +
    ggplot2::scale_color_manual(values = c(palette.colors(palette = "Set1")[-6], palette.colors(palette = "Dark2"))) +
    ggplot2::labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia") +
    ggplot2::ggtitle("Rozkład wyników poszczególnych komitetów w okręgach wyborczych") +
    ggplot2::geom_hline(yintercept = 5, color = "red", size = 1) +
    ggplot2::annotate("text", x = length(unique(wyniki$komitet)) + 1 - 0.05, y = 5.5, label = "próg 5%",
                      colour = "red", fontface = "bold") +
    ggplot2::theme_bw() +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5, face = "bold"),
                   plot.subtitle = ggplot2::element_text(hjust = 0.5),
                   plot.background = ggplot2::element_rect(fill = "gray80"),
                   legend.background = ggplot2::element_blank(),
                   legend.key = ggplot2::element_blank())
}

wykres_wyniki.violin = function(wyniki){
  ggplot2::ggplot(data = wyniki, ggplot2::aes(x = komitet, y = value, color = komitet, fill = komitet)) +
    ggplot2::geom_hline(yintercept = 5, color = "red", size = 1) +
    ggplot2::geom_violin(size = 1, alpha = 0.3, scale = "width", adjust = 1, trim = TRUE) +
    ggplot2::coord_flip(xlim = c(1, length(unique(wyniki$komitet))), clip = "off") +
    ggplot2::ggtitle("Rozkład wyników poszczególnych komitetów w okręgach wyborczych") +
    ggplot2::labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia", fill = "Komitet/partia") +
    ggplot2::scale_color_manual(values = c(palette.colors(palette = "Set1")[-6], palette.colors(palette = "Dark2")),
                                labels = sort(unique(wyniki$komitet))) +
    ggplot2::scale_fill_manual(values = c(palette.colors(palette = "Set1")[-6], palette.colors(palette = "Dark2")),
                               labels = sort(unique(wyniki$komitet))) +
    ggplot2::annotate("text", x = 0.25, y = 5, label = "5%",
                      colour = "red", fontface = "bold") +
    ggplot2::theme_bw() +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5, face = "bold"),
                   plot.subtitle = ggplot2::element_text(hjust = 0.5),
                   plot.background = ggplot2::element_rect(fill = "gray80"),
                   legend.background = ggplot2::element_blank(),
                   legend.key = ggplot2::element_blank())
}

wykres_wyniki.dotplot = function(wyniki){
  ggplot2::ggplot(data = wyniki, ggplot2::aes(x = komitet, y = value, color = komitet, fill = komitet)) +
    ggplot2::geom_hline(yintercept = 5, color = "red", size = 1) +
    ggplot2::geom_dotplot(binaxis = "y", stackdir = "center", binwidth = 0.5) +
    ggplot2::coord_flip(xlim = c(1, length(unique(wyniki$komitet))), clip = "off") +
    ggplot2::ggtitle("Rozkład wyników poszczególnych komitetów w okręgach wyborczych") +
    ggplot2::labs(x = "Komitet", y = "Wynik w %", color = "Komitet/partia", fill = "Komitet/partia") +
    ggplot2::scale_color_manual(values = c(palette.colors(palette = "Set1")[-6], palette.colors(palette = "Dark2")),
                                labels = sort(unique(wyniki$komitet))) +
    ggplot2::scale_fill_manual(values = c(palette.colors(palette = "Set1")[-6], palette.colors(palette = "Dark2")),
                               labels = sort(unique(wyniki$komitet))) +
    ggplot2::annotate("text", x = 0.25, y = 5, label = "5%",
                      colour = "red", fontface = "bold") +
    ggplot2::theme_bw() +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5, face = "bold"),
                   plot.subtitle = ggplot2::element_text(hjust = 0.5),
                   plot.background = ggplot2::element_rect(fill = "gray80"),
                   legend.background = ggplot2::element_blank(),
                   legend.key = ggplot2::element_blank())
}

wykres_wyniki.scatter = function(wyniki){
  `%>%` = dplyr::`%>%`
  wyniki = dplyr::left_join(wyniki, okregi %>% dplyr::mutate(rat = Liczba.wyborców / Liczba.mandatów),
                            by = c("Okreg" = "Numer"))

  ggplot2::ggplot(data = wyniki, ggplot2::aes(x = Liczba.wyborców, y = value, color = komitet)) +
    ggplot2::geom_point(size = 2) +
    # ggplot2::geom_smooth(data = wyniki[-which(wyniki$Liczba.wyborców == max(wyniki$Liczba.wyborców)),],
    #                      #method = "lm",
    #                      se = FALSE) +
    ggplot2::geom_smooth(se = FALSE, linetype = "dashed") +
    ggplot2::scale_x_continuous(trans = "log10") +
    ggplot2::scale_color_manual(values = c(palette.colors(palette = "Set1")[-6], palette.colors(palette = "Dark2")),
                                labels = sort(unique(wyniki$komitet))) +
    ggplot2::labs(x = "Liczba ludności okręgu", y = "Wynik w %",
                  title = "Zależność między wielkością okręgu a poparciem dla partii") +
    ggplot2::theme_bw() +
    ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5, face = "bold"),
                   plot.subtitle = ggplot2::element_text(hjust = 0.5),
                   plot.background = ggplot2::element_rect(fill = "gray80"),
                   legend.background = ggplot2::element_blank(),
                   legend.key = ggplot2::element_blank())
}
