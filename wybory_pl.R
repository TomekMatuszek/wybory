wybory_pl = function(kom1, kom2, kom3, kom4, kom5, frekwencja = 100){
  m = matrix( , ncol = 1, nrow = 5)
  for (i in 1:nrow(okregi)) {
    m2 = dhont(kom1, kom2, kom3, kom4, kom5, i, frekwencja = 100)
    m = cbind(m, m2)
  }
  m3 = matrix(rowSums(m, na.rm = TRUE), ncol = 1, nrow = 5)
  rownames(m3) = c("Komitet I", "Komitet II", "Komitet III", "Komitet IV", "Komitet V")
  colnames(m3) = "mandaty"
  m3
}
wybory_pl(35, 29, 25, 6, 5)
