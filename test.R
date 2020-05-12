if (colSums(mandaty_integer) + colSums(dod_mandaty) != okregi[okreg, 2]){
  for (i in 1:5) {
    for (j in 1:5) {
      if (dod_mandaty[i, 1] == dod_mandaty[j, 1] && i != j){
        dod_mandaty[max(c(i, j)), 1] = 0
      }
    }
  }
}