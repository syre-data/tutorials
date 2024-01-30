# import libraries
suppressPackageStartupMessages(library(tidyverse))
library(syre)

# initialize syre database
db <- database(dev_root = "/absolute/path/to/silent_fireworks/data/Recipe C/Batch 2")

# get data
noise_data <- db |> find_asset(type = "raw-data")
df <- noise_data@file |> read_csv(
  col_types = cols(
    Trial = col_integer(),
    `Volume [dB]` = col_double()
  )
)

# remove invalid data
clean_df <- df |> filter("Volume [dB]" > 70)

# save cleaned data
data_path = db |> add_asset(
  "noise_data-cleaned.csv",
  name="Noise Data - Cleaned",
  type="noise-data",
  tags=list("cleaned") # tag the data as cleaned for future reference
)

clean_df |> write.csv(data_path, row.names = FALSE)
