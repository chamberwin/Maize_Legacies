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
library(sf) #Load libraries
library(terra)
library(dplyr)
library(spData)
library(spDataLarge)
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2) # tidyverse data visualization package
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
