if (colSums(mandaty_integer) + colSums(dod_mandaty) != okregi[okreg, 2]){
  a = 0
  for (i in 1:5) {
    for (j in 1:5) {
      if (dod_mandaty[i, 1] == dod_mandaty[j, 1] && i != j){
        dod_mandaty[max(c(i, j)), 1] = 0
        a = a + 1
      }
      if (a > 0){
        break
      }
    }
  }
}