## code to prepare `DATASET` dataset goes here

dane_linki = readxl::read_excel("data-raw/linki.xls")
usethis::use_data(dane_linki)
