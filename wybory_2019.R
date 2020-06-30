wybory_2019 = function(){
  dh_mx = matrix( ,nrow = 5, ncol = 1)
  for (i in 1:nrow(okregi_wyniki)) {
    dh = dhont(okregi_wyniki[i, 1], okregi_wyniki[i, 2], okregi_wyniki[i, 3], 
               okregi_wyniki[i, 4] - 0.01, okregi_wyniki[i, 5], i)
    dh_mx = cbind(dh_mx, dh)
  }
  dh_sum = rowSums(dh_mx, na.rm = TRUE)
  
  sl_mx = matrix( ,nrow = 5, ncol = 1)
  for (i in 1:nrow(okregi_wyniki)) {
    sl = sainte_lague(okregi_wyniki[i, 1], okregi_wyniki[i, 2], okregi_wyniki[i, 3], 
               okregi_wyniki[i, 4] - 0.01, okregi_wyniki[i, 5], i)
    sl_mx = cbind(sl_mx, sl)
  }
  sl_sum = rowSums(sl_mx, na.rm = TRUE)
  
  hn_mx = matrix( ,nrow = 5, ncol = 1)
  for (i in 1:nrow(okregi_wyniki)) {
    hn = hare_niemeyer(okregi_wyniki[i, 1], okregi_wyniki[i, 2], okregi_wyniki[i, 3], 
                      okregi_wyniki[i, 4] - 0.01, okregi_wyniki[i, 5], i)
    hn_mx = cbind(hn_mx, hn)
  }
  hn_sum = rowSums(hn_mx, na.rm = TRUE)
  
  wyniki = matrix(c(dh_sum, sl_sum, hn_sum), ncol = 3, nrow = 5)
  colnames(wyniki) = c("D'Hont", "Sainte-Lague", "Hare-Niemeyer")
  rownames(wyniki) = c("KO", "Konf", "PSL", "PiS", "Lewica")
  wyniki
}
wybory_2019()
