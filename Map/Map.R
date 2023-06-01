# Install needed packages
install.packages(c("rgdal", "raster", "sp" , "ggplot2" , "readr"))

# Required libraries
library(rgdal)
library(sp)
library(sf)
library(raster)
library(ggplot2)
library(readr)

# Set working directory
setwd("C:/Users/chamb/Documents/Maize_Legacies/Map")

# Load altitude data for Peru and make raster readable
altitude_file <- "C:/Users/chamb/Documents/Maize_Legacies/Map/Map_Shape.shp"
altitude <- st_read(altitude_file)

# Convert the shapefile to a data frame
df_altitude <- as.data.frame(altitude)

# Plot altitude map of Peru
ggplot() +
  geom_raster(data = df_altitude, aes(x = x, y = y, fill = layer)) +
  scale_fill_gradientn(colours = terrain.colors(10)) +
  theme_minimal() +
  labs(title = "Altitude Map of Peru", x = "Longitude", y = "Latitude") +
  coord_equal()







# Check the properties of the raster
altitude

# Everything above works right!

# Plot altitude map of Peru
ggplot() +
  geom_raster(data = altitude, aes(x = x, y = y, fill = value), interpolate = TRUE) +
  scale_fill_gradientn(colours = terrain.colors(10)) +
  theme_minimal() +
  labs(title = "Altitude Map of Peru", x = "Longitude", y = "Latitude") +
  coord_equal()

rlang::last_error()

# Load latitude and longitude data
data_file <- "C:/Users/chamb/Documents/Maize_Legacies/Map/Maize_List.csv"
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

# Plot altitude map of Peru
ggplot() +
  geom_sf(data = df_altitude, aes(fill = alt_value)) +
  scale_fill_gradientn(colours = terrain.colors(10)) +
  theme_minimal() +
  labs(title = "Altitude Map of Peru", x = "Longitude", y = "Latitude") +
  coord_sf()

#Not working yet

# Save the final map with symbols
ggsave("path/to/output_map.png", width = 10, height = 10)
