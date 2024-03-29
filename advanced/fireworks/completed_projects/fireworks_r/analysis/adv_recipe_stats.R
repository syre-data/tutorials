# import libraries
suppressPackageStartupMessages(library(tidyverse))
library(moments)
library(ggplot2)
library(syre)

# initialize syre database
db <-
  database(dev_root = "/absolute/path/to/silent_fireworks/data/Recipe A")

# find all data with type `noise-data` in the subtree
noise_data <- db |> find_assets(type = "noise-data")

# load data into a dataframe
trials <- c()
volumes <- c()
batches <- c()
for (data in noise_data) {
  tdf <- data@file |> read_csv( # get file from Asset
    col_types = cols
    (Trial = col_integer(),
      "Volume [dB]" = col_double()))

  trials <- c(trials, tdf[["Trial"]])
  volumes <- c(volumes, tdf[["Volume [dB]"]])
  batches <-
    c(batches, rep(as.integer(data@metadata$batch), count(tdf)))
}

df <- tibble(trial = trials,
             volume = volumes,
             batch = batches)

# --- analysis ---
# check for trend across trials
p <-
  ggplot(data = df, aes(x = trial, y = volumes, group = batch)) + geom_line(aes(color = batch))

trial_vol_path <-
  db |> add_asset("figs/volume_by_trial.png", # place in the `figs` bucket
                  tags = list("figure"))

trial_vol_path |> ggsave(
  plot = p,
  width = 10,
  height = 6,
  dpi = 300
)

# fit normal distribution across all data
mu <- df$volume |> mean()
sigma <- df$volume |> sd()
ggplot(df, aes(x = volume)) +
  geom_histogram(position = "identity",
                 bins = 15, aes(y = after_stat(density))) +
  stat_function(fun = dnorm, args = list(mean = mu, sd = sigma))

norm_fit_path <-
  db |> add_asset("figs/norm_fit.png", # place in the `figs` bucket
                  tags = list("figure"))

norm_fit_path |> ggsave(
  plot = p,
  width = 10,
  height = 6,
  dpi = 300
)

# description of combined statistics
desc_df <- df |> summarise(
  count = n(),
  mean = mean(volume),
  std = sd(volume),
  min = min(volume),
  max = max(volume)
)

desc_path = db |> add_asset("stats/describe_all.csv") # place in the `stats` bucket
desc_df |> write.csv(desc_path, row.names = FALSE)

# skewness of batches
skew_df <- as_tibble(c(skewness(df |> filter(batch == 1) |> pull(volume)),
                       skewness(df |> filter(batch == 2) |> pull(volume))))

skew_path = db |> add_asset("stats/skew.csv") # place in the `stats` bucket
skew_df |> write.csv(skew_path)
