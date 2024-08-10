# Advanced Data Analytics and Machine Learning APIs.

This repository contains advanced APIs created using the Plumber package in R, containerized in Docker. The API offers a number of advanced data analysis and machine learning features.

## Functionalities

1. House price prediction using XGBoost
2. Advanced text sentiment analysis using word embeddings
3. Time series forecasting using Prophet model
4. Image classification (simulated, prepared for integration with CNN models)
5. Customer segmentation using the k-means algorithm
6. Detection of anomalies in time series

## System requirements

- Docker
- 4GB RAM minimum
- 10GB of free disk space

## Installation and startup

1 Clone this repository:
   ```
   git clone [URL_REPOZYTORIUM]
   cd [CATALOG NAME].
   ```

2 Build the Docker image:
   ```
   docker build -t advanced-plumber-api .
   ```

3. Launch the container:
   ```
   docker run -p 8080:8080 advanced-plumber-api
   ```

The API will be available at `http://localhost:8080`.

## API endpoints and usage examples

### 1. House price prediction (XGBoost).

- Method: POST
- Endpoint: `/predict_house_price_xgboost`.
- Usage example:
   ```bash
  curl -X POST "http://localhost:8080/predict_house_price_xgboost" \
       -H "Content-Type: application/json". \
       -d '{
         'area': 150,
         'bedrooms': 3,
         "bathrooms": 2,
         "age": 10,
         "location_score": 7.5,
         "crime_rate": 25.3
       }'
  ```

### 2. Advanced sentiment analysis

- Method: POST
- Endpoint: `/advanced_sentiment_analysis`.
- Usage example:
   ```bash
  curl -X POST "http://localhost:8080/advanced_sentiment_analysis" \
       -H "Content-Type: text/plain". \
       -d "This is an extremely fascinating and inspiring article about the latest developments in artificial intelligence."
  ```

### 3. Advanced time series forecasting

- Method: POST
- Endpoint: `/advanced_time_series_forecast`.
- Usage example:
   ```bash
  curl -X POST "http://localhost:8080/advanced_time_series_forecast" \
       -H "Content-Type: application/json". \
       -d '{
         "dates": ["2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05", "2023-01-06", "2023-01-07"],
         "values": [100, 110, 120, 115, 125, 130, 140],
         "forecast_days": 14
       }'
  ```

### 4. Image classification

- Method: POST
- Endpoint: `/classify_image`.
- Usage example:
   ```bash
  curl -X POST "http://localhost:8080/classify_image" \
       -H "Content-Type: multipart/form-data". \
       -F "image=@/path/to/your/image.jpg"
  ```

### 5. Client grouping

- Method: POST
- Endpoint: `/customer_segmentation`.
- Usage example:
   ```bash
  curl -X POST "http://localhost:8080/customer_segmentation" \
       -H "Content-Type: application/json". \
       -d '[
         { "age": 25, "income": 50000, "spending_score": 75},
         { "age": 40, "income": 70000, "spending_score": 60},
         { "age": 35, "income": 65000, "spending_score": 80},
         { "age": 50, "income": 90000, "spending_score": 50},
         { "age": 30, "income": 55000, "spending_score": 70}
       ]'
  ```

### 6. detecting anomalies in the time series

- Method: POST
- Endpoint: `/anomaly_detection`.
- Usage example:
   ```bash
  curl -X POST "http://localhost:8080/anomaly_detection" \
       -H "Content-Type: application/json". \
       -d '{
         "dates": ["2023-01-01", "2023-01-02", "2023-01-03", "2023-01-04", "2023-01-05", "2023-01-06", "2023-01-07"],
         "values": [100, 110, 120, 300, 125, 130, 140]
       }'
  ```

## Notes

- Make sure port 8080 is free on your computer before running the container.
- Some models (such as image classification) use simulated data for demonstration purposes. In a real-world scenario, replace them with real, trained models.
- The API uses a significant amount of RAM due to advanced machine learning models. Make sure your system has sufficient resources.
- If you have problems installing R packages, you may need to adjust the Dockerfile or install additional system dependencies.

## Troubleshooting

1. If you encounter memory problems, try increasing the amount of memory available for Docker in the settings.
2. If you have problems installing R packages, check Docker logs to identify missing system dependencies.
3. If the API is running slowly, consider optimizing models or using smaller datasets for training.

## Project development

To develop the project:

1. Modify `plumber.R` to add new endpoints or change existing ones.
2. Update the Dockerfile if you need additional R packages or system dependencies.
3. After making changes, rebuild the Docker image and restart the container.

## License

[Add license information]

## Contact.

[Add contact information]

Translated with DeepL.com (free version)
