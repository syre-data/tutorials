# import libraries
suppressPackageStartupMessages(library(tidyverse))
library(ggplot2)
library(thot)

# initialize thot database
db <-
  database(dev_root = "/absolute/path/to/silent_fireworks/data/Recipe A")

# find all data with type `noise-data` in the subtree
noise_data <- db |> find_assets(type = "noise-data")

# load data into a dataframe
volumes <- c()
batches <- c()
for (data in noise_data) {
  tdf <- data@file |> read_csv(# get file from Asset
    col_types = cols
    (Trial = col_integer(),
      "Volume [dB]" = col_double()))

  # store volume and batch
  volumes <- c(volumes, tdf[["Volume [dB]"]])
  batches <-
    c(batches, rep(as.integer(data@metadata$batch), count(tdf)))
}

df <- tibble(volume = volumes, batch = batches)

# plot the data
p <- ggplot(df, aes(x = volume, fill = factor(batch))) +
  geom_histogram(position = "identity",
                 alpha = 0.5,
                 bins = 15)

# save plot
fig_path <- db |> add_asset(
  "noise_data_histogram.png",
  name = "Noise Data Histogram",
  tags = list("figure"),
  description = "Histogram of noise data by batch."
)

fig_path |> ggsave(
  plot = p,
  width = 10,
  height = 6,
  dpi = 300
)
