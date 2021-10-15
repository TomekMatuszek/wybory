# Pakiet 'wybory'

## Spis treści
* [Instalacja](#Instalacja)
* [Wstęp i pobranie danych](#Wstęp-i-pobranie-danych)
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

## Wstęp i pobranie danych
Ten pakiet funkcji pozwoli Ci na przeliczanie podziału mandatów w danych okręgach wyborczych do Sejmu RP trzema różnymi metodami: **D'Honta** , **Sainte-Lague** oraz **Hare-Niemeyera**. Określając wyniki procentowe dla poszczególnych komitetów lub korzystając z prawdziwych wyników pobranych ze strony PKW możesz sprawdzić jak rozkladałyby się mandaty na poziomie okregów lub całego kraju.

Przed rozpoczęciem korzystania z właściwych funkcji tego pakietu, należy **pobrać pliki** zawierające informacje o okręgach wyborczych oraz wyniki wyborów parlamentarnych w wybranym przez użytkownika roku (aktualnie dostępne są wyniki z lat 2007-2019). Aby tego dokonać, należy użyć funkcję `pobierz_wyniki` poprzez podanie jako argumentu wybranego roku, w którym odbyły się wybory do Sejmu.

```r
pobierz_wyniki(2019)
```

W wyniku działania tej funkcji powstanie folder **dane_wybory**, w którym znajdują się dwa pliki w formie arkuszów kalkulacyjnych: jeden zawierający dane o okręgach wyborczych (liczba wyborców i mandatów) oraz drugi, w którym znajdują się wyniki wyborcze poszczególnych komitetów. Funkcja stworzy również od razu na podstawie pliku 'okregi[rok].xlsx' obiekt `okregi` potrzebny w funkcjach obliczających rozkład mandatów - dzięki temu użytkownik nie musi zaglądać do wyżej wspomnianego pliku.

Jeśli jednak użytkownika nie interesują historyczne wyniki wyborów i chce on używać jedynie funkcji zajmujących się sztucznie stworzonymi wynikami, może on samemu pobrać jedynie plik z danymi o okręgach ze strony PKW [Link do danych na rok 2019](https://sejmsenat2019.pkw.gov.pl/sejmsenat2019/data/csv/okregi_sejm_csv.zip)

Następnie należy użyć funkcji `konstruktor_okregow` wpisujac ścieżkę do pobranego i rozpakowanego pliku. Nie zwróci ona żadnego wyniku, wyświetli jedynie komunikat "Stworzono obiekt o nazwie 'okregi'". **UWAGA!** W powyższej sytuacji należy ręcznie zmienić nazwę pliku na 'okregi2019.csv'!

```r
konstruktor_okregow("okregi2019.csv")
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
Funkcja `wybory_rok` oblicza realny rozkład mandatów w Sejmie dla wyników wyborów z danego roku używając do tego wszystkich trzech wspomnianych metod. Jej jedynym argumentem jest macierz klasy **macierz_wynikow**, którą można stworzyć przy użyciu konstruktora - `konstruktor_wynikow`. Potrzebujesz do niego danych pobranych przy pomocy funkcji `pobierz_wyniki`, a konkretnie - pliku **wyniki[rok].xlsx**. Oprócz ścieżki do pliku, należy podać numery kolumn, w których znajdują się interesujące nas dane nt. poparcia poszczególnych komitetów.

**Przyklad:** 

```r
pobierz_wyniki(2019)
wybory_2019 = konstruktor_wynikow("dane_wybory/wyniki2019.xlsx", 9, 11, 12, 14, 16)
wybory_rok(wybory_2019)
```

Wygenerowany za pomoca funkcji `wybory_rok` wykres obrazuje rozkład mandatów w Sejmie po wyborach parlamentarnych w wybranym roku, w zależności od wybranej metody przeliczania. Czerwona przerywana linia oznacza liczbę mandatów potrzebnych do uzyskania wiekszosci w Sejmie, natomiast cieńsze, kolorowe linie obrazują realne poparcie danych komitetów w przeliczeniu na sejmowe mandaty. **Przykład:** jeśli komitet uzyskał 20% poparcia, to linia ta wskazuje poziom 20% mandatów w Sejmie, czyli 92. Tą wartość można dzięki temu łatwo porównać z realnym wynikiem uzyskanym przez partię w wyborach.
![](wyboryrok_wykres.png)

## Funkcja wykres_wyniki - wykres eksploracyjny
Używając funkcji `wykres_wyniki` o identycznych argumentach jak w funkcji `konstruktor_wynikow` możemy stworzyć wykres pudełkowy obrazujacy rozklad wyników poszczególnych komitetów wyborczych w okregach. Szara pozioma linia oznacza próg 5% obowiązujący startujące komitety.

```r
wykres_wyniki("dane_wybory/wyniki2019.xlsx", 9, 11, 12, 14, 16)
```

![](wykres.png)

# Uwagi
- Funkcja niestety nie zawsze radzi sobie w przypadku potrójnych remisów - sytuacji gdy trzy komitety osiągnęły dokładnie ten sam wynik. Z tego względu, celem uniknięcia błędów staraj się różnicować wyniki choćby o ułamki procentów. Zwykłe remisy są rozstrzygane poprawnie.
- Dostępne są także funkcje składowe: `dhont`, `sainte_lague` oraz `hare_niemeyer`.
