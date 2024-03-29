#' Funkcja pobierająca dane dot. wyników wyborów do Sejmu RP
#'
#' @description Funkcja pobiera pliki .xlsx i .csv z wynikami wyborów
#' dla podanego przez użytkownika roku, a także z danymi o okręgach wyborczych
#'
#' @param rok rok, w którym odbyły się wybory parlamentarne (do wyboru: 2007, 2011, 2015, 2019)
#' @param path folder, w którym mają zostać zapisane pobrane pliki, domyślnie jest to aktualny folder roboczy
#'
#' @return pobrane pliki w folderze 'dane_wybory'
#' @export
#'
#' @examples
#' pobierz_wyniki(2019)
pobierz_wyniki = function(rok, path = getwd()){
  linki = dane_linki
  if (rok == 2019){
    download.file(linki$link_wyniki[linki$rok == 2019],
                  destfile = paste0(path, "/wyniki2019.zip"))
    download.file(linki$link_okregi[linki$rok == 2019],
                  destfile = paste0(path, "/okregi2019.zip"))

    unzip(paste0(path, "/wyniki2019.zip"), exdir = paste0(path, "/dane_wybory"))
    unzip(paste0(path, "/okregi2019.zip"), exdir = paste0(path, "/dane_wybory"))

    file.rename(paste0(path, "/dane_wybory/okregi_sejm.xlsx"),
                paste0(path, "/dane_wybory/okregi2019.xlsx"))
    file.rename(paste0(path, "/dane_wybory/wyniki_gl_na_listy_po_okregach_proc_sejm.xlsx"),
                paste0(path, "/dane_wybory/wyniki2019.xlsx"))

    file.remove(paste0(path, "/wyniki2019.zip"))
    file.remove(paste0(path, "/okregi2019.zip"))
  } else if (rok == 2015){
    download.file(linki$link_wyniki[linki$rok == 2015],
                  destfile = paste0(path, "/wyniki2015.zip"))
    download.file(linki$link_okregi[linki$rok == 2019],
                  destfile = paste0(path, "/okregi2015.zip"))

    unzip(paste0(path, "/wyniki2015.zip"), exdir = paste0(path, "/dane_wybory"))
    unzip(paste0(path, "/okregi2015.zip"), exdir = paste0(path, "/dane_wybory"))

    file.rename(paste0(path, "/dane_wybory/okregi_sejm.xlsx"),
                paste0(path, "/dane_wybory/okregi2015.xlsx"))
    file.rename(paste0(path, "/dane_wybory/2015-gl-lis-okr-proc.xls"),
                paste0(path, "/dane_wybory/wyniki2015.xls"))

    file.remove(paste0(path, "/wyniki2015.zip"))
    file.remove(paste0(path, "/okregi2015.zip"))
  } else if (rok == 2011){
    plik_html = xml2::read_html(linki$link_wyniki[linki$rok == 2011])
    tabela_html = rvest::html_node(plik_html, "table.wikitable:nth-child(51)")
    tabela_r = rvest::html_table(tabela_html, fill = TRUE, header = TRUE)
    colnames(tabela_r) = tabela_r[1,]
    wyniki2011 = tabela_r[2:42, ]
    wyniki2011$Okręg = as.numeric(stringr::str_sub(wyniki2011$Okręg, start = 1, end = 2))
    for (i in 3:13) {
      for (j in 1:nrow(wyniki2011)) {
        wyniki2011[j , i] = stringr::str_replace_all(wyniki2011[j , i], "\\,", "\\.")
      }
    }
    dir.create(paste0(path, "/dane_wybory"))
    writexl::write_xlsx(wyniki2011, paste0(path, "/dane_wybory/wyniki2011.xlsx"))

    download.file(linki$link_okregi[linki$rok == 2011],
                  destfile = paste0(path, "/okregi2011.zip"))
    unzip(paste0(path, "/okregi2011.zip"), exdir = paste0(path, "/dane_wybory"))
    okregi2011 = read.csv(paste0(path, "/dane_wybory/okregi.csv"), sep = ";")
    okregi2011 = okregi2011[1:41, 3:8]
    colnames(okregi2011) = c("nr_okregu", "liczba_mandatow", "liczba_komitetow",
                             "liczba_kandydatow", "liczba_wyborcow", "granice")
    writexl::write_xlsx(okregi2011, paste0(path, "/dane_wybory/okregi2011.xlsx"))

    file.remove(paste0(path, "/dane_wybory/okregi.csv"))
    file.remove(paste0(path, "/okregi2011.zip"))
  } else if (rok == 2007){
    plik_html = xml2::read_html(linki$link_wyniki[linki$rok == 2007])
    tabela_html = rvest::html_node(plik_html, "table.wikitable:nth-child(100)")
    tabela_r = rvest::html_table(tabela_html, fill = TRUE, header = TRUE)
    colnames(tabela_r) = tabela_r[1 ,]
    wyniki2007 = tabela_r[2:42, ]
    wyniki2007$Okręg = as.numeric(stringr::str_sub(wyniki2007$Okręg, start = 1, end = 2))
    for (i in 3:12) {
      for (j in 1:nrow(wyniki2007)) {
        wyniki2007[j , i] = as.numeric(stringr::str_replace_all(wyniki2007[j , i], "\\,", "\\."))
      }
    }
    dir.create(paste0(path, "/dane_wybory"))
    writexl::write_xlsx(wyniki2007, paste0(path, "/dane_wybory/wyniki2007.xlsx"))

    plik_html = xml2::read_html(linki$link_okregi[linki$rok == 2007])
    tabela_html = rvest::html_node(plik_html, "table.wikitable:nth-child(82)")
    tabela_r = rvest::html_table(tabela_html, fill = TRUE, header = TRUE)
    okregi2007 = tabela_r[, c(1, 3, 4, 6)]
    okregi2007[ , 4] = as.numeric(stringr::str_replace_all(okregi2007[ , 4], pattern = "\\s+", replacement = ""))
    writexl::write_xlsx(okregi2007, paste0(path, "/dane_wybory/okregi2007.xlsx"))
  } else{
    stop("W podanym roku nie odbyły się wybory parlamentarne! Jako argument funkcji wpisz jedną z dat: 2007, 2011, 2015, 2019")
  }
  konstruktor_okregow(paste0(path, "/dane_wybory/", "okregi", rok, ".xlsx"))
}
