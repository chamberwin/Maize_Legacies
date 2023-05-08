install.packages("remotes") #Prepare to use same packages as https://geocompr.robinlovelace.net/adv-map.html
# To reproduce the first Part (chapters 1 to 8):
remotes::install_github("geocompr/geocompkg")
# To reproduce all chapters (install lots of packages, may take some time!)
remotes::install_github("geocompr/geocompkg", dependencies = TRUE)
install.packages("sf") #Install packages
install.packages("terra")
install.packages("spData")
install.packages("spDataLarge", repos = "https://nowosad.r-universe.dev")
install.packages("dplyr")
install.packages("shiny")
install.packages("tmap")
install.packages("leaflet")
install.packages("ggplot2")
library(sf) # classes and functions for vector data
library(terra) # classes and functions for raster data
library(dplyr)
library(spData) # load geographic data
library(spDataLarge) # load larger geographic data
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2) # tidyverse data visualization package
# libraries we need
library(elevatr)
library(tidyverse)
library(giscoR)
library(marmap)

#Get Map
sf_peru <-
  gisco_get_countries(country = c('Peru'))
plot(st_geometry(sf_peru),
     col = c("grey", "orange", "deepskyblue2"))
title(sub = gisco_attributions(), line = 1)
country_transformed <- sf_peru

#Test https://milospopovic.net/crisp-topography-map-with-r/
#Bring in country script https://www.rdocumentation.org/packages/giscoR/versions/0.1.1/topics/gisco_get_countries

get_elevation_data <- function(country_elevation, country_elevation_df) {
  
  country_elevation <- get_elev_raster(
    locations = country_transformed, 
    z = 9, 
    clip = "locations") 
  
  country_elevation_df <- as.data.frame(country_elevation, xy = T) %>%
    na.omit()
  
  colnames(country_elevation_df)[3] <- "elevation"
  return(country_elevation_df)
}

country_elevation_df <- get_elevation_data()

head(country_elevation_df)

#Practice using provided dataset
nz_elev = rast(system.file("raster/nz_elev.tif", package = "spDataLarge")) #Load data
# Add fill layer to nz shape
tm_shape(nz) +
  tm_fill() 
# Add border layer to nz shape
tm_shape(nz) +
  tm_borders() 
# Add fill and border layers to nz shape
tm_shape(nz) +
  tm_fill() +
  tm_borders() 
map_nz = tm_shape(nz) + tm_polygons()
class(map_nz)
#> [1] "tmap"
#> map_nz1 = map_nz +
tm_shape(nz_elev) + tm_raster(alpha = 0.7)
map_nz1 = map_nz +
  tm_shape(nz_elev) + tm_raster(alpha = 0.7)
nz_water = st_union(nz) |> st_buffer(22200) |> 
  st_cast(to = "LINESTRING")
map_nz2 = map_nz1 +
  tm_shape(nz_water) + tm_lines()
map_nz3 = map_nz2 +
  tm_shape(nz_height) + tm_dots()
tmap_arrange(map_nz1, map_nz2, map_nz3)
