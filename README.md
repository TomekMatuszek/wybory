# Wstep
Ten zestaw funkcji pozwoli Ci na przeliczanie podziału mandatów w danych okręgach wyborczych do Sejmu RP.

## Funkcja "wybory"
Użyj funkcji `wybory`, wpisz poparcie dla 5 komitetów wyborczych oraz wybierz numer okręgu wyborczego, aby zobaczyć jak rozkładałyby się w takiej sytuacji mandaty pomiędzy komitetami w zależności od zastosowanej metody: **D'Honta** , **Sainte-Lague** lub **Hare-Niemeyera**. Jako siódmą zmienną możesz także ustalić frekwencję wyborczą - domyślnie ustawiona jest ona na 100%.
Funkcja zwraca wynik w formie macierzy w której każda kolumna zawiera liczbę mandatów uzyskanych przez komitet wg danej metody. Zobaczysz także wygenerowany wykres slupkowy.

![](wybory_wykres.png)

## Funkcja "wybory_pl"
Możesz użyć także funkcji `wybory_pl`, która symuluje rozkład mandatów w Sejmie różnymi metodami w hipotetycznym przypadku równomiernego rozkładu głosów na partie w każdym okręgu. Jako argumenty należy podać poparcie poszczególnych komitetów oraz ewentualnie frekwencję (domyślnie 100%). Funkcja nie uwzględnia jednak na ten moment ograniczenia w postaci 5-procentowego progu wyborczego dla komitetu - mandaty dostanie każda partia której one przysługują, niezależnie od wyniku ogólnopolskiego. Tutaj także rozklad mandatów zostanie przedstawiony dodatkowo w formie wykresów slupkowych.

![](wyborypl_wykres.png)

## Funkcja "wybory_rok"
Funkcja `wybory_rok` oblicza realny rozkład mandatów w Sejmie dla procentowych wyników wyborów z danego roku używając do tego wszystkich trzech wspomnianych metod. Jej jedynym argumentem jest macierz klasy **macierz_wynikow**, którą można stworzyć przy użyciu konstruktora - `konstruktor_wynikow`. Potrzebujesz do niego danych z wynikami w formie pliku CSV możliwego do pobrania ze strony PKW. Oprócz nazwy pliku, należy podać numery kolumn, w których znajdują się interesujące nas dane nt. poparcia poszczególnych komitetów.
Funkcja `konstruktor_wynikow` zwraca obiekt o nazwie "okregi_wyniki".

Wygenerowany za pomoca funkcji `wybory_rok` wykres obrazujacy rozklad mandatow w Sejmie po wyborach parlamentarnych 2019 w zaleznosci od wybranej metody przeliczania. Czerwona przerywana linia oznacza liczbe mandatów potrzebnych do uzyskania wiekszosci w Sejmie, natomiast ciensze, kolorowe linie obrazuja realne poparcie danych komitetów w przeliczeniu na sejmowe mandaty:
![](wyboryrok_wykres.png)

## Wykres pudekowy
Funkcja `konstruktor_wynikow` tworzy także ramke danych o nazwie "okregi_wyniki_df". Możesz jej użyć jako argument w funkcji `wykres_wyniki`, aby stworzyć wykres pudelkowy wizualizujacy podstawowe statystyki dot. poparcia komitetów wyborczych w danym roku.
Oprócz standardowych informacji wykresu pudelkowego (np. mediana czy zakres miedzykwantylowy), widoczne beda wyniki każdego komitetu w poszczególnych okregach.

![](wykres.png)

# Uwagi
- Funkcja niestety nie zawsze radzi sobie w przypadku potrójnych remisów - sytuacji gdy trzy komitety osiągnęły dokładnie ten sam wynik. Z tego względu, celem uniknięcia błędów staraj się różnicować wyniki choćby o ułamki procentów. Zwykłe remisy są rozstrzygane poprawnie.
- Dostępne są także funkcje składowe: `dhont`, `sainte_lague` oraz `hare_niemeyer`.