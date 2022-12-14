library(httr)
library(rvest)
# Create some empty vectors to hold data temporarily

# City name column
city <- c()
# Weather column, rainy or cloudy, etc
weather <- c()
# Sky visibility column
visibility <- c()
# Current temperature column
temp <- c()
# Max temperature column
temp_min <- c()
# Min temperature column
temp_max <- c()
# Pressure column
pressure <- c()
# Humidity column
humidity <- c()
# Wind speed column
wind_speed <- c()
# Wind direction column
wind_deg <- c()
# Forecast timestamp
forecast_datetime <- c()
# Season column
# Note that for season, you can hard code a season value from levels Spring, Summer, Autumn, and Winter based on your current month.
season <- c()
# Get forecast data for a given city list
get_weather_forecaset_by_cities <- function(city_names){
  df <- data.frame()
  for (city_name in city_names){
    # Forecast API URL
    forecast_url <- 'https://api.openweathermap.org/data/2.5/forecast'
    # Create query parameters
    forecast_query <- list(q = city_name, appid = "ef9bb0dd91538d62881342afe14fa979", units="metric")
    # Make HTTP GET call for the given city
    response_new <- GET(forecast_url, query=forecast_query)
    # Note that the 5-day forecast JSON result is a list of lists. You can print the response to check the results
    #results <- json_list$list
    json_list <- content(response_new, as = "parsed")
    results <- json_list$list
    # Loop the json result
    for(result in results) {
      city <- c(city, results$city_name)
      weather <- c(weather, results$weather[[1]]$main)
      visibility < c(visibility, results$visibility)
      temp <- c(temp, results$visibility)
      temp_max <- c(temp_max, results$main$temp_max)
      temp_min <- c(temp_min, results$main$temp_min)
      pressure <- c(pressure, results$main$pressure)
      humidity <- c(humidity, results$main$humidity)
      wind_speed <- c(wind_speed, results$wind$speed)
      wind_deg <- c(wind_deg, results$wind$speed)
      forecast_datetime <- c(forecast_datetime, results$dt_txt)
    }
    
    # Add the R Lists into a data frame
    df <- data.frame(city=city,
                     weather=weather,
                     visibility=visibility,
                     temp=temp,
                     temp_min=temp_min,
                     temp_max=temp_max,
                     pressure=pressure,
                     humidity=humidity,
                     wind_speed=wind_speed,
                     wind_deg=wind_deg,
                     forecast_datetime=forecast_datetime,
                     season=season
                     
    )
  }
  
  # Return a data frame
  return(df)
  
}
cities <- c("Seoul", "Washington, D.C.", "Paris", "Suzhou")
cities_weather_df <- get_weather_forecaset_by_cities(cities)
cities_weather_df
# Write cities_weather_df to `cities_weather_forecast.csv`
write.csv(cities_weather_df, "C:/Users/musak/Documents/cities_weather_forecast.csv", row.names=FALSE)

