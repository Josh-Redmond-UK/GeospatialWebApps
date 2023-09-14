## Introduction to R Shiny

Thought those Python apps were cool? Well, R has a pretty advanced set of tools for creating dashboards and small apps with pure R code which is built straight into RStudio. R Shiny is a popular method for creating interactive data visualisations and analysis tools which allow you to share your research widely and easily. 

There are an impressive range of R Shiny apps available from a range of different sources which tackle different data and problems. 

This will be a simpler coding experience, but you will need to get your environment set up correctly! 

Unlike the Python section of this class, we won't be using jupyter notebooks, we'll be working directly in R Studio. 

If you are using Anaconda, you can create a new environment which uses R, and install Rstudio using the Anaconda navigator, this will allow you to manage the environment easily. Alternatively, you can download Rstudio from Posit's website: https://posit.co/products/open-source/rstudio/

Rstudio is an IDE for the R programming language, which allows you to easily interrogate and visualise your data. Compared to Python, R has a number of packages which are especially well suited to statistical analysis, such as geographically weighted regression and bayesian analysis, which are comparatively less developed in Python. 


As well as R studio, you will also need to install the R environment, Rstudio directs you to this when you try to download it, but just in case you missed it, you can find it here: https://cran.rstudio.com

Once you've done that, open up RStudio, the first thing you will need to do is install Shiny:

```install.packages("shiny")```

You will additionally need some other packages for the application to work, please run the following code:

``` 

install.packages("leaflet")
install.packages("rsconnect")
install.packages("raster")


```

Once you have done that, click on the new document icon on the top left of the interface, and scroll down to the 'new shiny app' option, select single file. 

Helpfully - this generates an example application for you! Click the 'run app' button and it will pop up in a web page. 