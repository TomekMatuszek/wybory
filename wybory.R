#Argumentami funkcji są wartości procentowe poparcia pięciu największych komitetów wyborczych oraz nr okręgu wyborczego, a opcjonalnie także frekwencji
#Suma poparcia wszystkich 5 komitetów nie może być większa niż 100%, natomiast gdy jest mniejsza niż 90% - pojawi się ostrzeżenie
#Numer okręgu wyborczego musi być liczbą całkowitą z przedziału (1,41)
#Użytkownik może także zdefiniować frekwencję w danym okręgu, domyślnie jest ona jednak ustawiona na 100%.
#Produktem funkcji jest macierz przedstawiająca podział mandatów przy podanych wynikach dla róznych metod
wybory = function(kom1, kom2, kom3, kom4, kom5, okreg, frekwencja = 100){
  if (is.numeric(c(kom1, kom2, kom3, kom4, kom5)) == FALSE){
    stop("Wprowadzane argumenty muszą być liczbami!")
  }
  if (frekwencja > 100 || frekwencja < 0){
    stop("Frekwencja musi być liczbą z przedziału (0,100)!")
  }
  if (sum(kom1, kom2, kom3, kom4, kom5) > 100){
    stop("Suma poparcia poszczególnych komitetów jest wyższa niż 100%!")
  }
  if (is.numeric(okreg) == FALSE || round(okreg, 0) != okreg || okreg > 41 || okreg < 1){
    stop("Wybierz numer okręgu z przedziału liczb całkowitych (1,41)!")
  }
  if (sum(kom1, kom2, kom3, kom4, kom5) < 90){
    warning(paste("Suma poparcia wszystkich komitetów wynosi", sum(kom1, kom2, kom3, kom4, kom5), "%. \n To oznacza, że", 100 - sum(kom1, kom2, kom3, kom4, kom5), "% głosów została oddana nieważnych lub na komitety, które nie przekroczyły progu wyborczego."))
  }
  
  system_dhonta <<- as.matrix(dhont(kom1, kom2, kom3, kom4, kom5, okreg, frekwencja))
  system_sainte_lague <<- as.matrix(sainte_lague(kom1, kom2, kom3, kom4, kom5, okreg, frekwencja))
  system_hare_niemeyer <<- as.matrix(hare_niemeyer(kom1, kom2, kom3, kom4, kom5, okreg, frekwencja))
  
  wyniki <<- cbind(system_dhonta, system_sainte_lague, system_hare_niemeyer)
  
  barplot(wyniki, beside = TRUE, col = c("orange", "black", "darkgreen", "blue", "red"))
  
  wyniki
}
wybory(35, 29, 25, 6, 5, 39)
