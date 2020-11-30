library(wybory)
devtools::load_all()

konstruktor_okregow("okregi_sejm.csv")
wybory_2019 = konstruktor_wynikow("sejm_wyniki_2019.xlsx", 9, 11, 12, 14, 16)
wybory_2015 = konstruktor_wynikow("sejm_wyniki_2015.xls", 9, 10, 13, 15, 16)

wybory_okreg(30, 29, 10, 7, 6, 4)
wybory_pl(33, 24, 13, 9, 7)
wybory_rok(wybory_2019)
wybory_rok(wybory_2015)

wykres_wyniki("sejm_wyniki_2019.xlsx", 9, 11, 12, 14, 16)
wykres_wyniki("sejm_wyniki_2015.xls", 9, 10, 13, 15, 16)
?konstruktor_okregow
