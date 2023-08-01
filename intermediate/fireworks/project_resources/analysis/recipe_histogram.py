# import libraries
import pandas as pd
import thot

# initialize thot database
db = thot.Database(dev_root="/absolute/path/to/silent_fireworks/data/Recipe A")

# find all data with type `noise-data` in the subtree
noise_data = db.find_assets(type="noise-data")

# load data into dataframe
df = []
for data in noise_data:
    tdf = pd.read_csv(data.file, index_col=0) # get file from Asset
    tdf = tdf.rename(columns={"Volume [dB]": data.metadata["batch"]}) # rename columns by batch
    df.append(tdf)

df = pd.concat(df, axis=1) # merge dataframes into one

# plot the data
ax = df.plot.hist(alpha=0.5)

# save plot
fig_path = db.add_asset(
    "noise_data_histogram.png",
    name="Noise Data Histogram",
    tags=["figure"],
    description="Histogram of noise data by batch."
)

ax.get_figure().savefig(fig_path)
