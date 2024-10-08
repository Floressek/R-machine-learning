# Use the official R base image
FROM r-base:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libsodium-dev \
    pkg-config \
    libfftw3-dev \
    libgdal-dev \
    libudunits2-dev \
    libx11-dev \
    libglpk-dev \
    libtiff5-dev \
    libcairo2-dev \
    libxt-dev \
    libmagick++-dev

# Install R packages
RUN R -e "install.packages(c('plumber', 'lubridate', 'caret', 'randomForest', 'xgboost', 'text2vec', 'glmnet', 'tseries', 'prophet', 'imager', 'kernlab', 'jsonlite'), repos='http://cran.rstudio.com/', dependencies=TRUE)"

# Create app directory
WORKDIR /app

# Copy R scripts
COPY plumber.R /app/plumber.R
COPY router.R /app/router.R

# Expose port 8080
EXPOSE 8080

# Run the API
CMD ["Rscript", "router.R"]
