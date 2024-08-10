# plumber.R

library(plumber)
library(lubridate)
library(caret)
library(randomForest)
library(xgboost)
library(text2vec)
library(glmnet)
library(tseries)
library(prophet)
library(imager)
library(kernlab)

#* @apiTitle Zaawansowane API Analizy Danych i Uczenia Maszynowego

#* Przewidywanie cen domów z wykorzystaniem XGBoost
#* @param features Cechy domu jako JSON
#* @post /predict_house_price_xgboost
function(req) {
  features <- jsonlite::fromJSON(req$postBody)
  
  # Symulacja danych treningowych
  set.seed(123)
  train_data <- data.frame(
    price = runif(1000, 100000, 1000000),
    area = runif(1000, 50, 300),
    bedrooms = sample(1:5, 1000, replace = TRUE),
    bathrooms = sample(1:3, 1000, replace = TRUE),
    age = sample(0:50, 1000, replace = TRUE),
    location_score = runif(1000, 0, 10),
    crime_rate = runif(1000, 0, 100)
  )
  
  # Trenowanie modelu XGBoost
  dtrain <- xgb.DMatrix(data = as.matrix(train_data[, -1]), label = train_data$price)
  params <- list(
    objective = "reg:squarederror",
    eval_metric = "rmse",
    max_depth = 6,
    eta = 0.3,
    nrounds = 100
  )
  model <- xgb.train(params, dtrain, nrounds = 100)
  
  # Przewidywanie
  new_data <- as.matrix(features)
  prediction <- predict(model, new_data)
  
  list(predicted_price = round(prediction, 2))
}

#* Zaawansowana analiza sentymentu z wykorzystaniem word embeddings
#* @param text Tekst do analizy
#* @post /advanced_sentiment_analysis
function(req) {
  text <- req$postBody
  
  # Przygotowanie danych
  tokens <- space_tokenizer(text)
  it <- itoken(tokens, progressbar = FALSE)
  vocab <- create_vocabulary(it)
  vectorizer <- vocab_vectorizer(vocab)
  dtm <- create_dtm(it, vectorizer)
  
  # Symulacja modelu (w rzeczywistości powinien być wcześniej wytrenowany)
  set.seed(123)
  model <- glmnet(dtm, rnorm(nrow(dtm)), alpha = 1, family = "gaussian")
  
  # Przewidywanie
  sentiment_score <- predict(model, dtm, s = 0.01, type = "response")
  
  # Klasyfikacja sentymentu
  sentiment <- case_when(
    sentiment_score > 0.5 ~ "pozytywny",
    sentiment_score < -0.5 ~ "negatywny",
    TRUE ~ "neutralny"
  )
  
  list(
    sentiment = sentiment,
    score = as.numeric(sentiment_score)
  )
}

#* Zaawansowane prognozowanie szeregu czasowego z wykorzystaniem Prophet
#* @param dates Daty w formacie YYYY-MM-DD
#* @param values Wartości odpowiadające datom
#* @param forecast_days Liczba dni do prognozowania
#* @post /advanced_time_series_forecast
function(req) {
  data <- jsonlite::fromJSON(req$postBody)
  
  # Przygotowanie danych
  df <- data.frame(
    ds = as.Date(data$dates),
    y = as.numeric(data$values)
  )
  
  # Trenowanie modelu Prophet
  model <- prophet(df)
  
  # Prognozowanie
  future <- make_future_dataframe(model, periods = as.numeric(data$forecast_days))
  forecast <- predict(model, future)
  
  # Przygotowanie wyników
  result <- tail(forecast[c("ds", "yhat", "yhat_lower", "yhat_upper")], as.numeric(data$forecast_days))
  names(result) <- c("date", "forecast", "lower_95", "upper_95")
  
  return(result)
}

#* Klasyfikacja obrazów z wykorzystaniem wstępnie wytrenowanej sieci konwolucyjnej
#* @param image Ścieżka do pliku obrazu
#* @post /classify_image
function(req) {
  # Wczytanie obrazu
  img <- load.image(req$files$image$datapath)
  
  # Przeskalowanie obrazu do wymaganego rozmiaru
  img_resized <- resize(img, 224, 224)
  
  # Symulacja predykcji (w rzeczywistości użylibyśmy tu wstępnie wytrenowanej sieci CNN)
  set.seed(123)
  classes <- c("kot", "pies", "ptak", "ryba", "koń")
  probabilities <- runif(length(classes))
  probabilities <- probabilities / sum(probabilities)
  
  predicted_class <- classes[which.max(probabilities)]
  
  list(
    predicted_class = predicted_class,
    probabilities = as.list(setNames(probabilities, classes))
  )
}

#* Grupowanie klientów z wykorzystaniem algorytmu k-means
#* @param features Cechy klientów jako JSON
#* @post /customer_segmentation
function(req) {
  features <- jsonlite::fromJSON(req$postBody)
  
  # Normalizacja danych
  scaled_features <- scale(features)
  
  # Określenie optymalnej liczby klastrów za pomocą metody łokcia
  wss <- sapply(1:10, function(k) {
    kmeans(scaled_features, centers = k, nstart = 10)$tot.withinss
  })
  optimal_k <- which(diff(wss) < mean(diff(wss)))[1]
  
  # Grupowanie k-means
  kmeans_result <- kmeans(scaled_features, centers = optimal_k, nstart = 25)
  
  # Przygotowanie wyników
  result <- list(
    clusters = as.numeric(kmeans_result$cluster),
    cluster_centers = kmeans_result$centers,
    optimal_k = optimal_k
  )
  
  return(result)
}

#* Wykrywanie anomalii w szeregu czasowym
#* @param dates Daty w formacie YYYY-MM-DD
#* @param values Wartości odpowiadające datom
#* @post /anomaly_detection
function(req) {
  data <- jsonlite::fromJSON(req$postBody)
  
  # Przygotowanie danych
  ts_data <- ts(data$values, frequency = 7)  # Zakładamy dane tygodniowe
  
  # Dekompozycja szeregu czasowego
  decomp <- stl(ts_data, s.window = "periodic")
  
  # Wykrywanie anomalii
  residuals <- decomp$time.series[, "remainder"]
  anomalies <- which(abs(residuals) > 2 * sd(residuals))
  
  # Przygotowanie wyników
  result <- list(
    anomalies = as.list(data$dates[anomalies]),
    anomaly_scores = as.list(residuals[anomalies])
  )
  
  return(result)
}