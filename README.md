# Zaawansowane API Analizy Danych i Uczenia Maszynowego

To repozytorium zawiera zaawansowane API stworzone przy użyciu pakietu Plumber w R, skonteneryzowane w Dockerze. API oferuje szereg zaawansowanych funkcji analizy danych i uczenia maszynowego.

## Funkcjonalności

1. Przewidywanie cen domów z wykorzystaniem XGBoost
2. Zaawansowana analiza sentymentu tekstu z użyciem word embeddings
3. Prognozowanie szeregów czasowych z wykorzystaniem modelu Prophet
4. Klasyfikacja obrazów (symulowana, przygotowana do integracji z modelami CNN)
5. Segmentacja klientów z wykorzystaniem algorytmu k-means
6. Wykrywanie anomalii w szeregach czasowych

## Wymagania systemowe

- Docker
- Minimum 4GB RAM
- 10GB wolnego miejsca na dysku

## Instalacja i uruchomienie

1. Sklonuj to repozytorium:
   ```
   git clone [URL_REPOZYTORIUM]
   cd [NAZWA_KATALOGU]
   ```

2. Zbuduj obraz Docker:
   ```
   docker build -t advanced-plumber-api .
   ```

3. Uruchom kontener:
   ```
   docker run -p 8080:8080 advanced-plumber-api
   ```

API będzie dostępne pod adresem `http://localhost:8080`.

## Endpointy API i przykłady użycia

### 1. Przewidywanie cen domów (XGBoost)

- Metoda: POST
- Endpoint: `/predict_house_price_xgboost`
- Przykład użycia:
  ```bash
  curl -X POST "http://localhost:8080/predict_house_price_xgboost" \
       -H "Content-Type: application/json" \
       -d '{
         "area": 150,
         "bedrooms": 3,
         "bathrooms": 2,
         "age": 10,
         "location_score": 7.5,
         "crime_rate": 25.3
       }'
  ```

### 2. Zaawansowana analiza sentymentu

- Metoda: POST
- Endpoint: `/advanced_sentiment_analysis`
- Przykład użycia:
  ```bash
  curl -X POST "http://localhost:8080/advanced_sentiment_analysis" \
       -H "Content-Type: text/plain" \
       -d "To jest niezwykle fascynujący i inspirujący artykuł o najnowszych osiągnięciach w dziedzinie sztucznej inteligencji."
  ```

### 3. Zaawansowane prognozowanie szeregu czasowego

- Metoda: POST
- Endpoint: `/advanced_time_series_forecast`
- Przykład użycia:
  ```bash
  curl -X POST "http://localhost:8080/advanced_time_series_forecast" \
       -H "Content-Type: application/json" \
       -d '{
         "dates": ["2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05", "2023-01-06", "2023-01-07"],
         "values": [100, 110, 120, 115, 125, 130, 140],
         "forecast_days": 14
       }'
  ```

### 4. Klasyfikacja obrazów

- Metoda: POST
- Endpoint: `/classify_image`
- Przykład użycia:
  ```bash
  curl -X POST "http://localhost:8080/classify_image" \
       -H "Content-Type: multipart/form-data" \
       -F "image=@/path/to/your/image.jpg"
  ```

### 5. Grupowanie klientów

- Metoda: POST
- Endpoint: `/customer_segmentation`
- Przykład użycia:
  ```bash
  curl -X POST "http://localhost:8080/customer_segmentation" \
       -H "Content-Type: application/json" \
       -d '[
         {"age": 25, "income": 50000, "spending_score": 75},
         {"age": 40, "income": 70000, "spending_score": 60},
         {"age": 35, "income": 65000, "spending_score": 80},
         {"age": 50, "income": 90000, "spending_score": 50},
         {"age": 30, "income": 55000, "spending_score": 70}
       ]'
  ```

### 6. Wykrywanie anomalii w szeregu czasowym

- Metoda: POST
- Endpoint: `/anomaly_detection`
- Przykład użycia:
  ```bash
  curl -X POST "http://localhost:8080/anomaly_detection" \
       -H "Content-Type: application/json" \
       -d '{
         "dates": ["2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05", "2023-01-06", "2023-01-07"],
         "values": [100, 110, 120, 300, 125, 130, 140]
       }'
  ```

## Uwagi

- Upewnij się, że port 8080 jest wolny na Twoim komputerze przed uruchomieniem kontenera.
- Niektóre modele (np. klasyfikacja obrazów) używają symulowanych danych dla celów demonstracyjnych. W rzeczywistym scenariuszu należy je zastąpić prawdziwymi, wytrenowanymi modelami.
- API wykorzystuje znaczną ilość pamięci RAM ze względu na zaawansowane modele uczenia maszynowego. Upewnij się, że Twój system ma wystarczające zasoby.
- W przypadku problemów z instalacją pakietów R, może być konieczne dostosowanie Dockerfile lub instalacja dodatkowych zależności systemowych.

## Rozwiązywanie problemów

1. Jeśli napotkasz problemy z pamięcią, spróbuj zwiększyć ilość pamięci dostępnej dla Dockera w ustawieniach.
2. W przypadku problemów z instalacją pakietów R, sprawdź logi Dockera, aby zidentyfikować brakujące zależności systemowe.
3. Jeśli API działa wolno, rozważ optymalizację modeli lub użycie mniejszych zbiorów danych do treningu.

## Rozwój projektu

Aby rozwijać projekt:

1. Zmodyfikuj `plumber.R`, aby dodać nowe endpointy lub zmienić istniejące.
2. Zaktualizuj Dockerfile, jeśli potrzebujesz dodatkowych pakietów R lub zależności systemowych.
3. Po wprowadzeniu zmian, przebuduj obraz Docker i uruchom kontener ponownie.

## Licencja

[Dodaj informacje o licencji]

## Kontakt

[Dodaj informacje kontaktowe]