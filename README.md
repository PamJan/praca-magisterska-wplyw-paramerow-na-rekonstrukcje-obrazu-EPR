# Skrypty użyte w celu badania wpływu parametrów rekonstrukcji obrazów EPR na dokładność odwzorowania obiektów trójwymiarowych
## Przygotowanie do uruchomienia
1. pobrać i wypakować pliki (folder "master_program", folder "Eprit": https://github.com/o2mdev/eprit, oraz bibliotekę "Mesh voxelisation": https://www.mathworks.com/matlabcentral/fileexchange/27390-mesh-voxelisation)
2. w pliku Eprit/toolbox_path.m uzupełnić ścieżkę do folderu (zmienna epr_toolbox_path) i uruchomić skrypt (w przypadku pojawienia się okienka z zapytaniem o reset ścieżki wybrać  przycisk "yes")
3. w pliku "master_path.m" uzupełnić odpowiednie ścieżki i uruchomić skrypt

## rekonstrukcja 
Plik reconstrucion.m przeprowadza rekonstrukcje obrazu na podstawie: 
1. wczytanych zmiennych:
    - `scenario_file` - scenariusz użyty do akwizycji danych
    - `protocole_file` - protokół rekonstrukcji sygnału zawiera wszystkie zmienne potrzebne do przeprowadzenia rekonstrukcji
    - `raw_data_name` - nazwa eksperymentu
    - `arrangment` - ustawienie fantomu podczas akwizycji danych
    - `oxygen` - definiuje rodzaj protokołu  akwizycji sygnału
    - `acquisition_name` - nazwa pliku zawierające dane z akwizycji sygnału EPR
2. optymalizowanych parametrów:
    - `matrix_size` - wielkość w wokselach rekonstruowanego obrazu
    - `FOV` - wielkość rekonstruowanego obrazu w cm
    - `cutoff` - miary odcięcia filtra (Ram-Lacka)

Optymalizowane parametry zastępują `x` w poniższych zmiennych:
  - `x_size_start` - wartość startowa iteracji
  - `x_size_step` - krok iteracji
  - `x_end` - wartość kończąca iteracje.

Czas rekonstrukcji zalezy wprost proporcjonalnie od wielkości wartości `matrix_size` oraz `FOV` (może wynosić kilkanaście minut dla jednej rekonstrukcji).


## stworzenie referencji
Plik reference.m tworzy 3D binaraną macierz o wymiarach 256x256x256 dla modelu referencyjne (.stl).

## implementacja współczynnika Dice’a-Sørensena
Plik diec.m zawiera implementacje współczynnik Dice’a-Sørensena.

## implementacja odległości Hausdorffa oraz 95 centyla odległości Hausdorfa
Plik hausdorf_distance_3D.m zawiera implementacje odległości Hausdorffa oraz 95 centyla odległości Hausdorfa (HD95).

## binaryzacja
Binaryzację zrekonstruowanych obrazów przeprowadzono za pomocą programu ibGUI z "Eprit". 
Procedura binaryzacji:
1. Uruchomienie ibGUI (wpisanie do terminala ibGUI)
2. wybranie z rozwijanej listy "File", a następnie wczytanie za pomocą przycisku "Load file" surowych danych zrekonstruowanego obrazu (np. `Matrix-32_FOV-35_CutOff-00_bot_Medium`).
3. wybranie z rozwijanej listy "File", a następnie wczytanie za pomocą przycisku "Load file" informacje na temat ciśnienia pracjalnego tlenu zrekonstruowanego obrazu (np. `pMatrix-32_FOV-35_CutOff-00_bot_Medium`).
4. Po pojawieniu się okienka "LoadCalibrationDLG" wybranie z rozwijanej list "Select CALIBRATION" kalibracji: `Ox71-720-1mM PBS(New)-37C` i zatwierdzenie przyciskiem "OK".
5. Wybranie z rozwijanej listy "Mask" przycisku "Mask toolbar" (ten krok trzeba przeprowadzić tylko raz dla raz uruchomionego ibGUI).
6. Dodanie nowej warstwy za pomocą przycisku  "+".
7. Z paska uruchomionego za pomocą przycisku "Mask toolbar" wybranie funkcji "SelectByThreshold( 3D)" i potwierdzenie przyciskiem "OK".
8. Z paska uruchomionego za pomocą przycisku "Mask toolbar" wybranie "Save mask" i zapisanie maski w odpowiednim folderze (np. \master_programe\data\binarized\260603\bot\Medium).
9. przed rozpoczęciem binaryzacji kolejnego obrazu koniecznie jest usunięcie stworzonej maski, przyciskiem "-".
Procedura binaryzacji jest powtarzalną procedura, dlatego w przypadku pracy magisterskiej zautomatyzowano tą procedurę za pomocą programu PyMacroRecord.

## Obliczenie podobieństwa między zrekonstruowanym obrazem, a obrazem referencyjnym 
Plik compere.m oblicza odległość Hausdorfa (oraz HD95) i współczynni Dice’a-Sørensena dla badanych obrazów.
Skrypt operuje na zbinaryzowanych obrazach otrzymanych z binaryzacji zrekonstruowanych obrazów. 
Odpowiednia nazewnictwo zbinaryzowanych obrazów jest niezbędne do działania skryptu: "pMatrix-`matrix_size`_FOV-`FOV`_CutOff-`cutoff`_`arrangment`_`oxygen`".mat
