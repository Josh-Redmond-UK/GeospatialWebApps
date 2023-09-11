
## Getting Started

In this course, we will take a guided project-based approacht to build a web-app which explores noise pollution in London, and lets users explore future scenarios and changes to their local area, and export their findings. I have already curated and set up all the data, functions, and code needed to handle the modelling of noise pollution and creating results. This course will teach you how to take those functions, code, and models, and turn them into an app which lets uers interact with parameters and explore results. 

In this part of the class, we will set up our Python environment so that we can use all the tools and functions necessary for the rest of the project. 

First, if you need to, navigate to and download the Anaconda installer, [available here](https://www.anaconda.com/download). 

Install Anaconda. Once this process is completed, create a new environment for this course, call it something like "geospatialWebApps" or whatever you like. 

[screenshot showing buttons to click]

Next, either clone the GitHub repo or download the files from the web page.  

[screeenshot showing download button here]

Then, if you need to, extract the files from the zip and place them somewhere easy to access. 

Open up Anaconda, select the environment you have just created, and select 'open terminal' 

[image]

Then, navigate to the directory you have put the downloaded repository in, choosing the subfolder which contains the files for the Python part of the course. 

    cd path_to_my_directory/GeospatialWebApps/python

Now, using conda, install the packages required for the course, this will install all of the libraries, tools, and packages required for the project. 

    conda env update --name geospatialWebApps --file environment.yml

If you would rather use pip or are using a different environment manager, you can also install from the requirements.txt file as an alternative. 

    pip install -r requirements.txt

Then, open Anaconda Navigator and start up Jupyter notebook. 

[image]

If you aren't using Anaconda navigator, you can open jupyter notebook by running the following in your terminal:

    jupyter notebook

Now, let's begin! 

