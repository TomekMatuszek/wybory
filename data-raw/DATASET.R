## code to prepare `DATASET` dataset goes here

dane_linki = readxl::read_excel("linki.xls")
usethis::use_data(dane_linki)
