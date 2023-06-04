suppressPackageStartupMessages(library(tidyverse))
library(thot)

# initialize thot project
db <- database(dev_root = "/Users/nacho/work/thot/demo/base_projects/fireworks_r/data/Recipe\ A")

# get recipe name
recipe <- root(db)

# get noise-stats data
noise_stats <- db |> find_assets(type = "noise-stats")

# read data
df <- list()
for (stat in noise_stats) {
    tdf <- stat@file |> read_csv()
    df[[length(df) + 1]] <- tdf
}

# combine all the data frames into one
df <- do.call(rbind, df)

# Calculate the mean of the 'mean' column
mean_of_mean <- mean(df$mean)

# Calculate the mean of the 'std' column
mean_of_std <- mean(df$std)

# Create a new data frame with mean_of_mean and mean_of_std
rsdf <- data.frame(
    mean = mean_of_mean,
    std = mean_of_std
)

name <- paste(recipe@name, "Statistics")

# create new asset for the statistics
stats_path <- db |> add_asset("recipe-stats.csv", name = name, type = "recipe-stats")

# save the statistics to the new asset
rsdf |> write.csv(stats_path, row.names = FALSE)
