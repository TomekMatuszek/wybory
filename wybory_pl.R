wybory_pl = function(kom1, kom2, kom3, kom4, kom5, frekwencja = 100){
  m = matrix( , ncol = 1, nrow = 5)
  for (i in 1:nrow(okregi)) {
    m2 = dhont(kom1, kom2, kom3, kom4, kom5, i, frekwencja = 100)
    m = cbind(m, m2)
  }
  dh = rowSums(m, na.rm = TRUE)
  m = matrix( , ncol = 1, nrow = 5)
  for (i in 1:nrow(okregi)) {
    m2 = sainte_lague(kom1, kom2, kom3, kom4, kom5, i, frekwencja = 100)
    m = cbind(m, m2)
  }
  sl = rowSums(m, na.rm = TRUE)
  m = matrix( , ncol = 1, nrow = 5)
  for (i in 1:nrow(okregi)) {
    m2 = hare_niemeyer(kom1, kom2, kom3, kom4, kom5, i, frekwencja = 100)
    m = cbind(m, m2)
  }
  hn = rowSums(m, na.rm = TRUE)
  m3 = matrix(c(dh, sl, hn), ncol = 3, nrow = 5)
  rownames(m3) = c("Komitet I", "Komitet II", "Komitet III", "Komitet IV", "Komitet V")
  colnames(m3) = c("D'Hont", "Sainte-Lague", "Hare-Niemeyer")
  m3
}
wybory_pl(42, 31, 12, 9, 6)
