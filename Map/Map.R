<<<<<<< HEAD
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
=======
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
>>>>>>> 6f395bc73d933d17fcfdb8d0e03acbc95072a3fe
