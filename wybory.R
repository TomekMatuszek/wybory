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
  if (sum(kom1, kom2, kom3, kom4, kom5) < 95){
    warning("Suma poparcia wszystkich komitetów nie mieści się w przedziale (95,100). Lepiej, aby suma głosów nieważnych oraz tych na mniejsze komitety nie przekraczała 5%.")
  }
  system_dhonta <<- as.matrix(dhont(kom1, kom2, kom3, kom4, kom5, okreg))
  system_sainte_lague <<- as.matrix(sainte_lague(kom1, kom2, kom3, kom4, kom5, okreg))
  system_hare_niemeyer <<- as.matrix(hare_niemeyer(kom1, kom2, kom3, kom4, kom5, okreg))
  wyniki <<- cbind(system_dhonta, system_sainte_lague, system_hare_niemeyer)
  wyniki
}
wybory(45, 15, 18, 12, 10, 39)
