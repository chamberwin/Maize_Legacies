# Install needed packages
install.packages(c("rgdal", "raster", "sp" , "ggplot2" , "readr"))


# Required libraries
library(raster)
library(ggplot2)
library(readr)

# Set working directory
setwd("C:/Users/chamb/Documents/Maize_Legacies/Map")

# Load altitude data for Peru
alt_file <- "C:/Users/chamb/Documents/Maize_Legacies/Map/Map_Shape.shp"
altitude <- raster(alt_file)

# Load latitude and longitude data
data_file <- "path/to/coordinates.csv"
coordinates <- read_csv(data_file)

# Extract altitude values at each coordinate
coordinates$Altitude <- extract(altitude, coordinates[, c("Longitude", "Latitude")])

# Load climate data from WorldClim database
climate_file <- "path/to/worldclim_data.tif"
climate_data <- raster(climate_file)

# Extract climate data at each coordinate
coordinates$ClimateData <- extract(climate_data, coordinates[, c("Longitude", "Latitude")])

# Plot altitude map of Peru
ggplot() +
  geom_raster(data = altitude, aes(x = x, y = y, fill = value), interpolate = TRUE) +
  scale_fill_gradientn(colours = terrain.colors(10)) +
  theme_minimal() +
  labs(title = "Altitude Map of Peru", x = "Longitude", y = "Latitude") +
  coord_equal()

# Plot symbols on the map
ggplot() +
  geom_raster(data = altitude, aes(x = x, y = y, fill = value), interpolate = TRUE) +
  scale_fill_gradientn(colours = terrain.colors(10)) +
  geom_point(data = coordinates, aes(x = Longitude, y = Latitude), color = "red", size = 3) +
  theme_minimal() +
  labs(title = "Altitude Map of Peru with Symbols", x = "Longitude", y = "Latitude") +
  coord_equal()

# Save the final map with symbols
ggsave("path/to/output_map.png", width = 10, height = 10)
