# Set working directory
# setwd("C:/Users/chamb/Documents/Maize_Legacies/Map")
#install.packages("ggplot2")
#Necessary? Seems to install with ggplot2
#install.packages("rlang")

#Good enough! Does not display border in first layer, but that is ok.
library(ggplot2)
library(sp)
library(raster)

# Read the data from the "Maize_List" file
maize_data <- read.csv("C:/Users/chamb/Documents/Maize_Legacies/Map/Maize_List.csv")

# Read the elevation raster
elevation_raster <- raster("C:/Users/chamb/Documents/Maize_Legacies/Map/elevation_1KMmd_SRTM.tif")

# Load the country map data for Peru
map_data_peru <- map_data("world", region = "Peru")

# Subset the elevation raster to a smaller extent
subset_extent <- extent(-81, -68, -19, -0.5)
elevation_raster_subset <- crop(elevation_raster, subset_extent)

# Convert elevation raster to a data frame
elevation_df <- as.data.frame(rasterToPoints(elevation_raster_subset))
colnames(elevation_df) <- c("x", "y", "value")  # Rename columns

# Divide elevation values by 2
elevation_df$value <- elevation_df$value / 2

# Create the plot
ggplot() +
  ## First layer: Country border
  geom_path(data = map_data("world", region = "Peru"),
            aes(x = long, y = lat),
            color = "seagreen", size = 0.5) +
  ## Second layer: Elevation raster
  geom_tile(data = elevation_df,
            aes(x = x, y = y, fill = value)) +
  scale_fill_gradient(low = "darkorchid3", high = "orange", name = "Elevation (masl)") +
  ## Third layer: Points from "Maize_List"
  geom_point(data = maize_data,
             aes(x = Longitude, y = Latitude),
             color = 'springgreen', size = 2) +
  coord_map() +
  coord_fixed(1.3,
              xlim = c(-81, -68),
              ylim = c(-19, -0.5)) +
  xlab("Longitude") +
  ylab("Latitude")
