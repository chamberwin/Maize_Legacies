# Trying from https://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html
install.packages(c("ggplot2", "devtools", "dplyr", "stringr"))
install.packages(c("maps", "mapdata"))

library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(mapproj)

# Set working directory
setwd("C:/Users/chamb/Documents/Maize_Legacies/Map")

#Load libraries
library(ggplot2)
library(raster)

#Load elevation .tif
elevation_file <- "C:/Users/chamb/Documents/Maize_Legacies/Map/Peru_Elevation.tif"
elevation_raster <- raster(elevation_file)

#Make .tif into dataframe
elevation_df <- as.data.frame(elevation_raster, xy = TRUE)
colnames(elevation_df) <- c("Longitude", "Latitude", "Elevation")

#Works?
ggplot() +
  ## First layer: worldwide map
  geom_polygon(data = map_data("world"),
               aes(x = long, y = lat, group = group),
               color = '#9c9c9c', fill = '#f3f3f3') +
  ## Second layer: Country map
  geom_polygon(data = map_data_es,
               aes(x = long, y = lat, group = group),
               color = 'red', fill = 'pink') +
  ## Third layer: Points from "Maize_List"
  geom_point(data = maize_data,
             aes(x = Longitude, y = Latitude),
             color = 'blue', size = 2) +
  ## Fourth layer: Elevation color scale
  geom_raster(data = elevation_df,
              aes(x = Longitude, y = Latitude, fill = Elevation)) +
  scale_fill_gradient(low = "blue", high = "red") +
  coord_map() +
  coord_fixed(1.3,
              xlim = c(-81, -68),
              ylim = c(-19, -0.5))
#Does not work. I don't think the USGS file is right







# Read the data from the "Maize_List" file
maize_data <- read.csv("Maize_List.csv")

# Create the plot
ggplot() +
  ## First layer: worldwide map
  geom_polygon(data = map_data("world"),
               aes(x = long, y = lat, group = group),
               color = '#9c9c9c', fill = '#f3f3f3') +
  ## Second layer: Country map
  geom_polygon(data = map_data_es,
               aes(x = long, y = lat, group = group),
               color = 'red', fill = 'pink') +
  ## Third layer: Points from "Maize_List"
  geom_point(data = maize_data,
             aes(x = Longitude, y = Latitude),
             color = 'blue', size = 3) +
  ## Fourth layer: Elevation color scale
  geom_raster(data = raster_data,  # Replace "elevation_data" with your own elevation data
              aes(x = Longitude, y = Latitude, fill = Elevation)) +
  scale_fill_gradient(low = "blue", high = "red") +  # Adjust the color scale as desired
  coord_map() +
  coord_fixed(1.3,
              xlim = c(-81, -68),
              ylim = c(-19, -0.5))


#ChatGPTs help with adding data points

# Read the data from the "Maize_List" file
maize_data <- read.csv("Maize_List.csv")

# Create the plot
ggplot() +
  ## First layer: worldwide map
  geom_polygon(data = map_data("world"),
               aes(x = long, y = lat, group = group),
               color = '#9c9c9c', fill = '#f3f3f3') +
  ## Second layer: Country map
  geom_polygon(data = map_data_es,
               aes(x = long, y = lat, group = group),
               color = 'red', fill = 'pink') +
  ## Third layer: Points from "Maize_List"
  geom_point(data = maize_data,
             aes(x = Longitude, y = Latitude),
             color = 'blue', size = 2) +
  coord_map() +
  coord_fixed(1.3,
              xlim = c(-81, -68),
              ylim = c(-19, -0.5))
#Works!
#To add elevation to the map, I need to download elevation raster from USGS
library(ggplot2)

# Read the data from the "Maize_List" file
maize_data <- read.csv("Maize_List.csv")

# Create the plot
ggplot() +
  ## First layer: worldwide map
  geom_polygon(data = map_data("world"),
               aes(x = long, y = lat, group = group),
               color = '#9c9c9c', fill = '#f3f3f3') +
  ## Second layer: Country map
  geom_polygon(data = map_data_es,
               aes(x = long, y = lat, group = group),
               color = 'red', fill = 'pink') +
  ## Third layer: Points from "Maize_List"
  geom_point(data = maize_data,
             aes(x = Longitude, y = Latitude),
             color = 'blue', size = 3) +
  ## Fourth layer: Elevation color scale
  geom_raster(data = elevation_data,  # Replace "elevation_data" with your own elevation data
              aes(x = Longitude, y = Latitude, fill = Elevation)) +
  scale_fill_gradient(low = "blue", high = "red") +  # Adjust the color scale as desired
  coord_map() +
  coord_fixed(1.3,
              xlim = c(-81, -68),
              ylim = c(-19, -0.5))


#Set map to Peru
map_data_es <- map_data('world')[map_data('world')$region == "Peru",]

ggplot() +
  ## First layer: worldwide map
  geom_polygon(data = map_data("world"),
               aes(x=long, y=lat, group = group),
               color = '#9c9c9c', fill = '#f3f3f3') +
  ## Second layer: Country map
  geom_polygon(data = map_data_es,
               aes(x=long, y=lat, group = group),
               color = 'red', fill = 'pink') +
  coord_map() +
  coord_fixed(1.3,
              xlim = c(-81, -68),
              ylim = c(-19, -0.5))+
ggtitle("A Map of Peru") +
  theme(panel.background =element_rect(fill = 'blue'))
#Works!

#Need to download Peru elevations in raster format from USGS, then use this code
library(ggplot2)

# Read the data from the "Maize_List" file
maize_data <- read.csv("Maize_List.csv")

# Create the plot
ggplot() +
  ## First layer: worldwide map
  geom_polygon(data = map_data("world"),
               aes(x = long, y = lat, group = group),
               color = '#9c9c9c', fill = '#f3f3f3') +
  ## Second layer: Country map
  geom_polygon(data = map_data_es,
               aes(x = long, y = lat, group = group),
               color = 'red', fill = 'pink') +
  ## Third layer: Points from "Maize_List"
  geom_point(data = maize_data,
             aes(x = Longitude, y = Latitude),
             color = 'blue', size = 2) +
  ## Fourth layer: Elevation color scale
  geom_raster(data = elevation_data,  # Replace "elevation_data" with your own elevation data
              aes(x = Longitude, y = Latitude, fill = Elevation)) +
  scale_fill_gradient(low = "blue", high = "red") +  # Adjust the color scale as desired
  coord_map() +
  coord_fixed(1.3,
              xlim = c(-81, -68),
              ylim = c(-19, -0.5))

