wybory = function(kom1, kom2, kom3, kom4, kom5, okreg){
  system_dhonta = as.matrix(dhont(kom1, kom2, kom3, kom4, kom5, okreg))
  system_sainte_lague = as.matrix(sainte_lague(kom1, kom2, kom3, kom4, kom5, okreg))
  system_hare_niemeyer = as.matrix(hare_niemeyer(kom1, kom2, kom3, kom4, kom5, okreg))
  wyniki = cbind(system_dhonta, system_sainte_lague, system_hare_niemeyer)
  wyniki
}
wybory(37, 25, 16, 12, 10, 39)
