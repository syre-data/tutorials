# import packages
import pandas as pd
import thot

# initialize thot project
db = thot.Database()

# get noise data from asset
noise_data = db.find_asset({'type': 'noise-data'})

# import noise data into a pandas data frame
df = pd.read_csv(noise_data.file, header = 0, index_col = 0, names = ('trial', 'volume'))

# compute statistics
stats = df.describe()

# create a new asset for the statistics
stats_properties = {
	'name': 'Noise Statistics',
	'type': 'noise-stats',
	'file': 'noise-stats.csv'
}

stats_path = db.add_asset(stats_properties)

# export the statistics to the new asset
stats.to_csv(stats_path) 
