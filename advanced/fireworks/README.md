# Advanced tutorial | Puzzle's Fireworks
> :clock9: **15 minutes**

## Cleaning up our data
It looks like we have an outlier in the Recipe C > Batch 2 data.
After a call with our engineers, we know that our equipment could only measure down to 70 dB, so we
can remove any measurements below that as an error.
Let's create a new script for this.

Let's first adjust our noise data in Recipe C > Batch 2, changing the `type` to **raw-data**.

Now, create a new project script called `clean_noise_data`.
<details>
    <summary>Python</summary>

    # import libraries
    import pandas as pd
    import thot

    # initialize thot database
    db = thot.Database(dev_root="/absolute/path/to/silent_fireworks/data/Recipe C/Batch 2")

    # get data
    noise_data = db.find_asset(type="raw-data")
    df = pd.read_csv(noise_data.file, index_col=0);

    # remove invalid data
    cdf = df[df > 70].dropna()

    # save cleaned data
    data_path = db.add_asset(
        "noise_data-cleaned.csv),
        name="Noise Data - Cleaned",
        type="noise_data"
    )

    cdf.to_csv(data_path)
</details>
<details>
    <summary>R</summary>

</details>

But how do we tell Thot that the `noise_stats` script needs to run after the `clean_noise_data` script?

### Analysis dependencies
