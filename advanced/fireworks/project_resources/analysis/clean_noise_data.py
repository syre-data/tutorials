# import libraries
import pandas as pd
import thot

# initialize thot database
db = thot.Database(dev_root="/absolute/path/to/silent_fireworks/data/Recipe C/Batch 2")

# get data
noise_data = db.find_asset(type="raw-data")
df = pd.read_csv(noise_data.file, index_col=0);

# remove invalid data
clean_df = df[df > 70].dropna()

# save cleaned data
data_path = db.add_asset(
    "noise_data-cleaned.csv",
    name="Noise Data - Cleaned",
    type="noise-data",
    tags=["cleaned"] # tag the data as cleaned for future reference
)

clean_df.to_csv(data_path)