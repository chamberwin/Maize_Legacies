## Concat names for MDP to be Location_Name

# Load the necessary libraries
library(dplyr)

# Set the file path
file_path <- "C:/Users/chamb/Desktop/MDP/MASTER_MODERN_MAIZE_LIST.txt"

# Read the original file
original_data <- read.delim(file_path, stringsAsFactors = FALSE)

# Create a new column "Sample_Name" by combining "Location" and "Name" with "_"
original_data <- original_data %>%
  mutate(Sample_Name = paste(Location, Name, sep = "_"))

# Reorder the columns with "Sample_Name" as the first column
original_data <- original_data %>%
  select(Sample_Name, everything())

# Define the new file path for export
output_file_path <- "C:/Users/chamb/Desktop/MDP/Master_MDP.txt"

# Export the modified data frame to a new file
write.table(original_data, file = output_file_path, sep = "\t", quote = FALSE, row.names = FALSE)

# Print a message to confirm completion
cat("File exported as 'Master_MDP.txt'\n")
