# Intermediate tutorial | Puzzle's Fireworks
> :clock9: **15 minutes**

## Where did we leave off?
Ahh, right. You had just saved the company by determining which of the two firework recipes was quieter. You created your first Thot project by creating the project structure, organizing and metadata tagging the raw data, and analyzing that data to quickly get the results you needed.

The aquarium's New Year's Eve extravaganza went off without a hitch, and both the people and fish loved the show. In the crowd was Famous Dave, from Famous Dave's Scuba Encounters. He was so impressed he wants to put on his own show for his clients, and has asked the Puzzle's team to make it happen!

> **Note**
> This project depends on the [beginner fireworks tutorial project](/beginner/fireworks).
> If you don't have it, you can [download it](/beginner/fireworks#sharing-results) at the bottom of the tutorial.

## A new recipe
The brilliant chemists in Puzzle's R&D department have just sent you a message
> We need your help!
> We just came up with a new recipe for the underwater fireworks, but aren't sure if it's better or worse.
> 
> Here is the data:
> [Recipe C data]()
>
> Can you help us?

Of course you can!

## Extending a project
As is typical in science, we always finish projects with more questions than we began, and need to be flexible to new requirements as we progress through our projects. We need an easy way to account for this, and with Thot, we have one.

### New data
Let's extend our project to account for this new recipe. [Duplicate](/beginner/fireworks#duplicating-subtrees) one of the other Recipe branches, and update the `Name` to **Recipe C** and the `recipe` metadata value to **C**.
Let's add the new data in, just as we did before.

![Adding Recipe C to the project](images/recipe_c_data.png)

We can now re-analyze the project to incorporate the new results and take a look to see if Recipe C is better.

### New analysis
Amazing! It looks like the researchers actually did find a recipe that is quieter. But we, what is that? The error on the values washes out the effect? Looks like we'll need to dig into these numbers a bit deeper to figure out if Recipe C really is better.

Let's write our own script to plot a histogram for all the trials in each recipe.
<details>
    <summary>Python</summary>
    Create a file called <code>recipe_histogram.py</code>, and add it to the project.
</details>
<details>
    <summary>R</summary>
    Create a file called <code>recipe_histogram.r</code>, and add it to the project.
</details>

> **Note**
> Adding a script to a project copies it in to the project's `analysis` folder, so be sure you are editing the correct file.

#### Interacting with the project
Thot allows us to interact with our project from our scripts. This way we can check our results without having to analyze the project every time we make a change.

Lets start by initializing the database for the script on our Recipe A Container.
Add the following lines to your new analysis script.
<details>
    <summary>Python</summary>
    ```python
    # import libraries
    import pandas as pd
    import thot

    # initialize thot database
    db = thot.Database(dev_root="/path/to/silent_fireworks/data/Recipe A")
    ```
</details>
<details>
    <summary>R</summary>
    ```r
    # import libraries
    suppressPackageStartupMessages(library(tidyverse))
    library(thot)

    # initialize thot database
    db = database(dev_root="/path/to/silent_fireworks/data/Recipe A")
    ```
</details>
