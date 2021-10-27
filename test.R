library(wybory)
devtools::load_all()

pobierz_wyniki(2007)
wybory_2019 = konstruktor_wynikow("dane_wybory/wyniki2019.xlsx", 9, 11, 12, 14, 16, 17, 18)
wybory_2015 = konstruktor_wynikow("dane_wybory/wyniki2015.xls", 9, 10, 13, 15, 16, 24)
wybory_2011 = konstruktor_wynikow("dane_wybory/wyniki2011.xlsx", 3, 4, 5, 6, 7, 8, 9, 11)
wybory_2007 = konstruktor_wynikow("dane_wybory/wyniki2007.xlsx", 3, 4, 5, 6, 8, 10)

wybory_okreg(30, 29, 10, 7, 6, 5, okreg = 4)
wybory_pl(33, 24, 13, 9, 7, 4, 3)
wybory_rok(wybory_2019)
wybory_rok(wybory_2015)
wybory_rok(wybory_2011)
wybory_rok(wybory_2007)

wykres_wyniki("dane_wybory/wyniki2019.xlsx", 9, 11, 12, 14, 16)
wykres_wyniki("dane_wybory/wyniki2015.xls", 9, 10, 13, 15, 16)

?konstruktor_okregow
?konstruktor_wynikow
?wybory_okreg
?wybory_pl
?wybory_rok
?wykres_wyniki
