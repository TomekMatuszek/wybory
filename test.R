library(wybory)
devtools::load_all()

konstruktor_okregow("okregi_sejm.csv")
wybory_2019 = konstruktor_wynikow("sejm_wyniki_2019.xlsx", 9, 11, 12, 14, 16, 17, 18)
wybory_2015 = konstruktor_wynikow("sejm_wyniki_2015.xls", 9, 10, 13, 15, 16, 24)

wybory_okreg(30, 29, 10, 7, 6, 5, okreg = 4)
wybory_pl(33, 24, 13, 9, 7, 5)
wybory_rok(wybory_2019)
wybory_rok(wybory_2015)

wykres_wyniki("sejm_wyniki_2019.xlsx", 9, 11, 12, 14, 16, 18)
wykres_wyniki("sejm_wyniki_2015.xls", 9, 10, 13, 15, 16)

?konstruktor_okregow
?wybory_okreg
?wykres_wyniki
?konstruktor_wynikow
