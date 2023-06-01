# Load required libraries
library(dplyr)
library(raster)
library(ggplot2)

# Set the directory where the Worldclim data is located
worldclim_dir <- "/path/to/worldclim/directory"

# Set the filenames of the Worldclim environmental variables
bio_filenames <- c("bio1.tif", "bio2.tif", "bio3.tif", "bio4.tif", "bio5.tif", "bio6.tif", "bio7.tif", "bio8.tif", "bio9.tif", "bio10.tif", "bio11.tif", "bio12.tif", "bio13.tif", "bio14.tif", "bio15.tif", "bio16.tif", "bio17.tif", "bio18.tif", "bio19.tif")

# Load maize DNA sequence data
# Replace 'maize_data.csv' with the actual filename or path to your data
maize_data <- read.csv("maize_data.csv")

# Load Worldclim environmental variables
bio_data <- stack(file.path(worldclim_dir, bio_filenames))

# Extract the Worldclim data for the maize DNA sequences
# Figure out where on the maize_data.csv we need to add GPS points
maize_env_data <- extract(bio_data, maize_data[, c("Longitude", "Latitude")])

# Perform Principal Component Analysis
pca_result <- prcomp(maize_env_data, center = TRUE, scale. = TRUE)

# Get the proportion of variance explained by each principal component
var_explained <- pca_result$sdev^2 / sum(pca_result$sdev^2)

# Plot the scree plot
plot(1:length(var_explained), var_explained, type = "b", xlab = "Principal Component", ylab = "Proportion of Variance Explained", main = "Scree Plot")

# Create a dataframe with the principal components and their corresponding DNA sequences
pca_df <- data.frame(PC1 = pca_result$x[, 1], PC2 = pca_result$x[, 2], DNA_Sequence = maize_data$DNA_Sequence)

# Plot the first two principal components
ggplot(pca_df, aes(x = PC1, y = PC2, color = DNA_Sequence)) + geom_point() + labs(title = "PCA Plot")

