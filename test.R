library(wybory)
devtools::load_all()

pobierz_wyniki(2007)
konstruktor_okregow("dane_wybory/okregi2019.xlsx")
wybory_2019 = konstruktor_wynikow("dane_wybory/wyniki2019.xlsx",
                                  c("KO" = 9, "Konf" = 11, "PSL" = 12, "PIS" = 14,
                                    "Lewica" = 16, "BS" = 17, "MN" = 18))
wybory_2015 = konstruktor_wynikow("dane_wybory/wyniki2015.xls",
                                  c("PIS" = 9, "PO" = 10, "Raz" = 11, "Kor" = 12,
                                    "PSL" = 13, "ZL" = 14,"K15" = 15, "N" = 16, "MN" = 24))
wybory_2011 = konstruktor_wynikow("dane_wybory/wyniki2011.xlsx",
                                  c(3, 4, 5, 6, 7, 8, 9, 11))
wybory_2007 = konstruktor_wynikow("dane_wybory/wyniki2007.xlsx",
                                  c(3, 4, 5, 6, 8, 10))

wykres_wyniki(wybory_2019, type = "boxplot")
wykres_wyniki(wybory_2019, type = "violin")
wykres_wyniki(wybory_2019, type = "dotplot")
wykres_wyniki(wybory_2019, type = "scatter")
wykres_wyniki(wybory_2015)
wykres_wyniki(wybory_2011)
wykres_wyniki(wybory_2007)

wyniki4 = wybory_okreg(30, 29, 10, 7, 6, 5, okreg = 4)
wyniki4 = wybory_okreg(wybory_2019, okreg = 4)
wyniki_pl = wybory_pl(34.5, 25.4, 9.6, 9.4, 5.5, 4.7, koalicje = c(2))
wyniki_2019 = wybory_rok(wybory_2019)
wyniki_2015 = wybory_rok(wybory_2015)
wyniki_2011 = wybory_rok(wybory_2011)
wyniki_2007 = wybory_rok(wybory_2007)

wykres_mandaty(wyniki_2019)
wykres_mandaty(wyniki_2015)
wykres_mandaty(wyniki_pl)
wykres_mandaty(wyniki4)

?konstruktor_okregow
?konstruktor_wynikow
?wybory_okreg
?wybory_pl
?wybory_rok
?wykres_wyniki
?wykres_mandaty
