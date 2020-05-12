wybory = function(kom1, kom2, kom3, kom4, kom5, okreg){
  if (is.numeric(c(kom1, kom2, kom3, kom4, kom5)) == FALSE){
    stop("Wprowadzane argumenty muszą być liczbami!")
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
  
  system_dhonta <<- as.matrix(dhont(kom1, kom2, kom3, kom4, kom5, okreg))
  system_sainte_lague <<- as.matrix(sainte_lague(kom1, kom2, kom3, kom4, kom5, okreg))
  system_hare_niemeyer <<- as.matrix(hare_niemeyer(kom1, kom2, kom3, kom4, kom5, okreg))
  
  wyniki <<- cbind(system_dhonta, system_sainte_lague, system_hare_niemeyer)
  wyniki
}
wybory(53.29, 18.57, 11.31, 8.17, 2.89, 39)
