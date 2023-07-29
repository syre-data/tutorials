# import libraries
import numpy as np
import pandas as pd
from scipy.stats import norm
import thot

# initialize thot database
db = thot.Database(dev_root="/absolute/path/to/silent_fireworks/data/Recipe A")

# get data
noise_data = db.find_assets(type="noise-data")
df = []
for data in noise_data:
    tdf = pd.read_csv(data.file, index_col=0)
    tdf = tdf.rename(columns={"Volume [dB]": data.metadata["batch"]})
    df.append(tdf)

df = pd.concat(df, axis=1)

# combine all data
all_df = pd.DataFrame(df.values.flatten()).dropna()

# --- analysis ---
# check for trend across trials
ax = df.plot()
trial_vol_path = db.add_asset(
    "figs/volume_by_trial.png", # place in the `figs` bucket
    tags=["figure"]
)

ax.get_figure().savefig(trial_vol_path)

# fit normal distribution across all data
norm_fit = norm.fit(all_df)
x_vals = np.linspace(all_df.min(), all_df.max(), 100)
y_vals = norm.pdf(x_vals, *norm_fit)

ax = all_df.plot.hist()
ax.twinx().plot(x_vals, y_vals, c='C1')

norm_fit_path = db.add_asset(
    "figs/norm_fit.png", # place in the `figs` bucket
    tags=["figure"]
)

ax.get_figure().savefig(norm_fit_path)

# description of combined data
desc_df = all_df.describe()
desc_path = db.add_asset("stats/describe_all.csv")  # place in the `stats` bucket
desc_df.to_csv(desc_path)

# skewness of batches
skew_df = df.skew()
skew_path = db.add_asset("stats/skew.csv") # place in the `stats` bucket
skew_df.to_csv(skew_path)
