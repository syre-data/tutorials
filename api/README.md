# API
Thot's API is available for
+ [Python](python)
+ [R](r)

If your favorite language isn't yet supported let us know either on our [Discord](https://discord.gg/Kv2c5XynfV) or by email at <info@thot.so>.

Below is an overview of Thot's API. For more details and examples, visit your languages docs.

## Sandwich model
Thot uses a sandwich model to allow you to interact with your projects, where Thot is the bread and your analysis is the meat.
This allows you to easily adapt scripts you've already created to Thot, or take Thot scripts and use them outside the framework.

![Thot's API sandwich model](images/sandwich_model.png)

## Initializing a database
The first thing to do in any project is initialize the database. This gives you access to your project.
If you want to interact with your project manually, assign the `dev_root` parameter to the absolute path of the Container you want to interact with. When analyzing a project, the `dev_root` is ignored.

## Getting resources
Thot only exposes four methods to get project resources.
+ **`find_asset` / `find_container`:** Finds a single Asset/Container matching the provided filter, returning the languages `None` type if no matches are found.
If multiple Assets are found matching the filter, a random one is returned.
+ **`find_assets` / `find_containers`:** Finds multiple Assets/Containers, returning them as the languages `list` type.

Each of these functions accepts filter parameters that correspond to the properties you can assign them in the details bar of the desktop app
+ name 
+ type
+ tags (list)
+ metadata (dictionary)

A resource must match all of the provided filter parameters.

## Adding Assets
To add a new Asset to your project, use the **`add_asset`** method.
This takes the file name to use for the Asset and each of properties you want to assign to it.

### Buckets
If you give the file name as a relative path, e.g. `bucket/my_data.png`, Thot will create subfolders mathing the path to store the file in. These subfolders are used to organize Assets without creating new Containers, and are called **buckets**.

## Dev Mode
You can perform certain tasks in a script only when you are interacting with it manually.
Think of these as debug statements that are ignored when you are actually analyzing your project.
This is done with the **`dev_mode`** method, which returns `true` when you manually running the script, and `false` when the script is being run by Thot.

## Filtering resources
You can filter resources you've already collected using the **`filter`** method. This takes in a list of resources and filter parameters, and returns a new list containing only those that match.
