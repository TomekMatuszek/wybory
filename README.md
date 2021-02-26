# Pakiet 'wybory'

## Spis treści
* [Instalacja](#Instalacja)
* [Wstęp](#Wstęp)
* [wybory_okreg](#Funkcja-wybory_okreg)
* [wybory_pl](#Funkcja-wybory_pl)
* [wybory_rok](#Funkcja-wybory_rok)
* [Wykres eksploracyjny](#Funkcja-wykres_wyniki---wykres-eksploracyjny)
* [Uwagi](#Uwagi)

## Instalacja
Aby pobrać ten pakiet, użyj poniższych poleceń aby połączyć się z repozytorium GitHub.

```r
install.packages("remotes")
remotes::install_github("TomekMatuszek/wybory")
library(wybory)
```

## Wstęp
Ten zestaw funkcji pozwoli Ci na przeliczanie podziału mandatów w danych okręgach wyborczych do Sejmu RP trzema różnymi metodami: **D'Honta** , **Sainte-Lague** oraz **Hare-Niemeyera**. Określając wyniki procentowe dla poszczególnych komitetów lub korzystając z prawdziwych wyników pobranych ze strony PKW możesz sprawdzić jak rozkladałyby się mandaty na poziomie okregów lub całego kraju.

Przed rozpoczęciem korzystania z właściwych funkcji tego pakietu, **musisz pobrać** ze strony PKW aktualny plik CSV zawierajacy dane dotyczące okregów wyborczych w Polsce. Bez tych informacji (liczby mandatów oraz wyborców w okregu) inne funkcje nie bedą działały poprawnie.

Link do aktualnych (2019) danych o okręgach wyborczych do Sejmu: [LINK](https://sejmsenat2019.pkw.gov.pl/sejmsenat2019/data/csv/okregi_sejm_csv.zip)

Następnie należy użyć funkcji `konstruktor_okregow` wpisujac ścieżkę do pobranego i rozpakowanego pliku. Nie zwróci ona żadnego wyniku, wyświetli jedynie komunikat "Stworzono obiekt o nazwie 'okregi'".

```r
konstruktor_okregow("okregi_sejm.csv")
```

## Funkcja wybory_okreg
Użyj funkcji `wybory_okreg`, wpisz poparcie dla dowolnej ilości komitetów wyborczych (max. 10) oraz wybierz numer okręgu wyborczego, aby zobaczyć jak rozkładałyby się w takiej sytuacji mandaty pomiędzy komitetami w zależności od zastosowanej metody podziału mandatów. Jako ostatnią zmienną możesz także ustalić frekwencję wyborczą - domyślnie ustawiona jest ona na 100%.
Funkcja zwraca wynik w formie macierzy w której każda kolumna zawiera liczbę mandatów uzyskanych przez komitet wg danej metody. Zobaczysz także wygenerowany wykres słupkowy. Poziome linie wyznaczaja realne poparcie komitetów w odniesieniu do liczby mandatów dostepnych w danym okregu wyborczym.

```r
wybory_okreg(30, 29, 10, 7, 6, okreg = 4, frekwencja = 100)
```

![](wyboryokreg_wykres.png)

## Funkcja wybory_pl
Możesz użyć także funkcji `wybory_pl`, która symuluje rozkład mandatów w Sejmie różnymi metodami w hipotetycznym przypadku równomiernego rozkładu głosów na partie w każdym okręgu. Jako argumenty należy podać poparcie poszczególnych komitetów oraz ewentualnie frekwencję (domyślnie 100%). Tutaj także oprócz macierzy wyników rozkład mandatów zostanie przedstawiony dodatkowo w formie wykresów słupkowych. Ciagłe kolorowe linie wyznaczaja realne poparcie komitetów w przeliczeniu na mandaty poselskie, natomiast czerwona linia przerywana ilustruje próg 231 mandatów - tyle ile jest potrzebne do samodzielnych rządów w polskim parlamencie.

```r
wybory_pl(33, 24, 13, 9, 7)
```

![](wyborypl_wykres.png)

## Funkcja wybory_rok
Funkcja `wybory_rok` oblicza realny rozkład mandatów w Sejmie dla wyników wyborów z danego roku używając do tego wszystkich trzech wspomnianych metod. Jej jedynym argumentem jest macierz klasy **macierz_wynikow**, którą można stworzyć przy użyciu konstruktora - `konstruktor_wynikow`. Potrzebujesz do niego danych z wynikami w formie pliku CSV lub XLS możliwego do pobrania ze strony PKW. Oprócz nazwy pliku, należy podać numery kolumn, w których znajdują się interesujące nas dane nt. poparcia poszczególnych komitetów.
Funkcja `konstruktor_wynikow` zwraca obiekt o nazwie "okregi_wyniki".

**Przyklad:** 
1. Pobranie pliku CSV z wynikami wyborów parlamentarnych w 2019 roku - [LINK](https://sejmsenat2019.pkw.gov.pl/sejmsenat2019/data/csv/wyniki_gl_na_listy_po_okregach_sejm_csv.zip)
2. Rozpakowanie pliku .zip w wybranym folderze.
3. Przeglądnięcie pliku w programie obsugujacym arkusze kalkulacyjne lub przy pomocy funkcji read.csv() w języku R; zidentyfikowanie w których kolumnach arkusza znajdują się wyniki interesujących nas komitetów.
4. Użycie poniższego kodu.

```r
wybory_2019 = konstruktor_wynikow("sejm_wyniki2019.csv", 9, 11, 12, 14, 16)
wybory_rok(wybory_2019)
```

Wygenerowany za pomoca funkcji `wybory_rok` wykres obrazuje rozkład mandatów w Sejmie po wyborach parlamentarnych 2019 w zależności od wybranej metody przeliczania. Czerwona przerywana linia oznacza liczbe mandatów potrzebnych do uzyskania wiekszosci w Sejmie, natomiast cieńsze, kolorowe linie obrazują realne poparcie danych komitetów w przeliczeniu na sejmowe mandaty:
![](wyboryrok_wykres.png)

## Funkcja wykres_wyniki - wykres eksploracyjny
Używając funkcji `wykres_wyniki` o identycznych argumentach jak w funkcji `konstruktor_wynikow` możemy stworzyć wykres pudełkowy obrazujacy rozklad wyników poszczególnych komitetów wyborczych w okregach. Szara pozioma linia oznacza próg 5% obowiązujący startujące komitety.

```r
wykres_wyniki("sejm_wyniki2019.csv", 9, 11, 12, 14, 16)
```

![](wykres.png)

# Uwagi
- Funkcja niestety nie zawsze radzi sobie w przypadku potrójnych remisów - sytuacji gdy trzy komitety osiągnęły dokładnie ten sam wynik. Z tego względu, celem uniknięcia błędów staraj się różnicować wyniki choćby o ułamki procentów. Zwykłe remisy są rozstrzygane poprawnie.
- Dostępne są także funkcje składowe: `dhont`, `sainte_lague` oraz `hare_niemeyer`.
