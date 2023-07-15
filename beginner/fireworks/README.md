# Beginner tutorial - Fireworks
> :clock9: **15 minutes**

Our deadline is approaching quickly, so we need to put a rush on this project. Luckily, our engineers have already collected the data and written the analysis scripts. It's up to you to run the analysis and get back to us with the results ASAP!

## Organizing Your Project
The first thing we need to do is organize our project. Thot uses a tree structure to organize your projects, giving your project different levels. The top level should be the most important grouping to you, becoming less important as you move down the tree. 

For this project the most important thing we need to test is which recipe is quieter, so our top level grouping will be the recipes. Unfortunately, testing underwater fireworks happens to be quite expensive, so we will only be able to make two batches for each recipe. The batches will be our second level. This gives us the tree below.

.. figure:: /_static/examples/fireworks/fireworks-tree.png
	:align: center
	:alt: Fireworks tree structure
	:figclass: align-center

	Project tree for the silent fireworks test.


### Creating a New Project
Our researchers have already recorded the data and written the analysis scripts and for us, so all we need to do is create a Thot project for our experiments and run the analysis.

Because of our short time frame to get this analysis done, we'll build this project quick and dirty, using the most used features of Thot.

### Setting Up Your Project Tree

After installing the Thot Desktop app, run it. A folder browser will appear titled **Select Project Root**. This will set the root (top level) of our project. 

.. figure:: /_static/get_started/local/root_selection.png
    :align: center
    :alt: Select project root dialog.
    :figclass: align-center

    Select Project Root dialog.

Navigate to the ``data`` folder of the project folder you downloaded and click **Open**. An alert titled **Initialize Thot Container** will appear stating that the selected folder is not a Thot Contiainer, and asking if we would like to make it one. Click **Yes**.

.. figure:: /_static/get_started/local/init_container.png
    :align: center
    :alt: Initializing a folder as a Container.
    :figclass: align-center

    Initializing the root Container.

This will open a **Container Properties** dialog where we can set the properties of our root Container. Enter the following information (leaving the rest blank), then click the :badge:`Submit, badge-success` button.

| **Name:** | Silent Fireworks |
| **Type:**	| project
| **Description:** | Determining whether recipe A or B is quieter. |


.. figure:: /_static/get_started/local/container_properties_dialog.png
    :align: center
    :alt: Container Properties dialog.
    :figclass: align-center

    Container Properties dialog.

Great! We just made our first Container. What do Containers do? Well, they Contain things. Namely, they can contain other Containers, Assets, and Script Associations. We'll get to the Assets and Script Associations later on.

Now that we've created and selected our root Container, the main workspace of Thot Desktop is available. You'll notice there are two main views available at the top of the workspace: 

* **Project:** Gives a visual representation of our project.
* **File Tree:** Shows the directory structure and files of our project.

.. figure:: /_static/get_started/local/project_view.png
    :align: center
    :alt: Thot Desktop Project view.
    :figclass: align-center

    Project view.

In this tutorial we will only use the Project view. Let's make the project tree now. 

From the **Project** view, click the plus icon :fa:`plus-circle, style=fas` of the ``Silent Fireworks`` Container. This opens the **Container Properties** dialog for the child to be added.

| --- | --- |
| **Name:** | Recipe A |
| **Type:** | recipe |

We'll also add metadata to this Container. This allows us to attach metadata to our data. Child Containers inherit the metadata from their ancestors, but can overwrite it by declaring a new value with the same name.

To add metadata click on the **Add Metadata** button and enter the following metadata.

| Name | Type | Value
| --- | 	--- | ---
| recipe | string | a

On to the batches. Create a child Container of ``Recipe A`` with the following information:

| --- | --- |
| **Name:** | Batch 1 |
| **Type:** | batch |
| **Metadata:**	| batch (number): 1 |

The notation for the metadata is of the form ``Name (Type): Value``.

.. figure:: /_static/get_started/local/metadata_example.png
    :align: center
    :alt: Batch 1 Container example.
    :figclass: align-center

    Batch 1 Container.

Repeat this for Batch 2.

| **Name:** | Batch 2 |
| **Type:**	| batch |
| **Metadata:** | batch (number): 2 |

Great! We've now created our ``Recipe A`` branch.

``Recipe B`` will have the exact same structure with only the name of the recipe Container changed. Let's saves ourselves some work by duplicating the ``Recipe A`` tree and changing the required information.

Right click on the ``Recipe A`` Container and select ``Duplicate tree``.

.. figure:: /_static/get_started/local/duplicate_tree.png
    :align: center
    :alt: Duplicate tree.
    :figclass: align-center

    Duplicate tree.

Click on the pen icon :fa:`pen, style=fas` of the ``Recipe A (copy)`` Container to open its editor and change its name to ``Recipe B``.

.. figure:: /_static/get_started/local/project_view_complete_structure.png
    :align: center
    :alt: Complete tree structure.
    :figclass: align-center

    Complete tree structure.

Great! Our project's structure is now complete, and we can start adding data to it.

## Adding Data to Your Project
Now that we have our tree, we can add data. Most often data is added to the lowest level Containers in our project because these are the things we actually run experiments on.
In Thot, any data file we want to analyze -- CSV, text, images, binary, anything -- is called an Asset.

We want to add our Assets to the batches. Let's preview the project's Assets by clicking on the dropdown menu in the upper left of the workspace where it says **-None-** and select **Assets**. 

.. figure:: /_static/get_started/local/project_view_assets_preview.png
    :align: center
    :alt: Project view Assets preview.
    :figclass: align-center

    Project view Assets preview.

Now open a file explorer and navigate to the project's data folder. Drag and drop the data for each of the batches on to the respective container. (e.g. Drop ``a1-data.csv`` on the ``Recipe A > Batch 1`` Container.) You'll see the Assets appear in the preview as you add them. 

### Bulk Editing

Let's edit the names of Assets to make them more descriptive. :kbd:`Ctrl (Cmd) + click` on each of them. This opens the ``Bulk Editing`` menu. Using this same technique you can select multiple Containers as well, or a mix of Containers and Assets.

.. figure:: /_static/get_started/local/bulk_edit_menu-quick_start.png
    :align: center
    :alt: Bulk edit menu.
    :figclass: align-center

    Bulk edit menu.

Click the ``Properties`` item in the Bulk Edit menu and set the name of all of the Assets to ``Noise Data``.

.. figure:: /_static/get_started/local/assets_complete.png
    :align: center
    :alt: Project with all the Assets added.
    :figclass: align-center

    Project with all the Assets added.


Wonderful! We've now created our project structure and added our data. Next we'll look at how to analyze the data using Thot Scripts.


## Analyzing the Data
Analysis of a Thot project starts at the bottom most level of the project tree and works its way up. Each Script can be thought of as a machine that takes Assets in and produces new Assets that can then be consumed by other Scripts. Our analysis scripts have already been implemented, so all we need to do is assign them to the correct Containers.

.. note::

	Thot exposes a simple interface that is meant to wrap around the actual analysis that you do in your scripts. We won't cover how this works in this tutorial for the sake of time, so we encourage you to open the provided analysis files and take a look for yourself. The longest is 20 lines of code with comments explaining each line.

	You can learn more in the :doc:`Analyzing the Data <full_tutorial/scripts>` chapter of the :doc:`full tutorial <full_tutorial/index>`, or in the :doc:`Writing Scripts <writing_scripts>` tutorial.

Let's start by changing our preview mode (top left corner) to ``Scripts`` so we can verfiy our actions. Select all the ``Batch`` Containers and click on the ``Scripts`` item in the ``Bulk Editing`` menu. Click the ``Add Script`` button and add the ``analysis/noise_stats.py`` script. Repeat this adding the ``analysis/recipe_stats.py`` script to both recipe Containers, and the ``analysis/recipe_comparison.py`` script to the root Container, ``Silent Fireworks``.

.. figure:: /_static/get_started/local/script_associations.png
        :align: center
        :alt: Script Associations.
        :figclass: align-center

        Script Associations.

We're almost there now! Let's change our preview back to ``Assets`` and click the ``Analyze`` button to run our analysis.

.. warning::

    Running the analysis by pressing the ``Analyze`` button may give you an error. If this occurs please attempt to run the analysis from the command line.

    To do this open up a terminal (Anaconda prompt on Windows) navigate to teh project root (**data** folder) and run ``thot run``.

    More information is available in the ``cli`` tab of this section.

.. figure:: /_static/get_started/local/analyze-quick_start.png
        :align: center
        :alt: Analyze button.
        :figclass: align-center

        Analyze button.

Once the analysis is complete you'll seet he newly created Assets appear in the project tree. Which recipe is quieter? Open the ``Recipe Comparison`` Assets in the ``Silent Fireworks`` Container to find out. (No, you're not seeing double, there are two of them. One is a CSV file and the other is a plot.) To preview an Asset, or a Script for that matter, :kbd:`Alt + click` on it.

> [Download the final project]()
