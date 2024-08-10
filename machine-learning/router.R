# router.R

library(plumber)
library(lubridate)

# Error handlers
error_handler_500 <- function(req, res, err) {
  res$status <- 500
  list(error = "Wystąpił błąd serwera", details = as.character(err))
}

error_handler_404 <- function(req, res) {
  res$status <- 404
  list(error = "Nie znaleziono zasobu")
}

# Define the path to your plumber.R file
plumber_file <- "plumber.R"

# Create a router
router <- plumb(plumber_file)

# Set error handlers
router$setErrorHandler(error_handler_500)
router$set404Handler(error_handler_404)

# Add CORS support
router$handle("OPTIONS", "/*", function(req, res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  res$setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE")
  res$setHeader("Access-Control-Allow-Headers", "Content-Type")
  res$status <- 200
  return(list())
})

# Run the API
router$run(host = "0.0.0.0", port = 8080)