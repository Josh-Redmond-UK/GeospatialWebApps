## Widgets in R Shiny

Widgets in Shiny work much the same way as they do in ipython, but with a few caveats. The skills you have practiced earlier in designing interfaces with containers, and creating widgets that update data and call functions. The main difference is that rather than keeping everything in a single cell or document, RShiny specifically splits up your code into the interface and server, this is analagous to the front end and back end of the application, where the user interacts with the front end and the computer crunches the numbers and produces output on the back end. 


An empty RShiny app looks like this:

~~~
library(shiny)

ui <- fluidPage()

server <- function(input, output) {}

shinyApp(ui = ui, server = server)

~~~



Notice how the front-end is an object you create, but the back end is a function that processses and returns data. 

Now, lets create a simple application like we did for the beginning of the Python part of the class, we'll generate some data, and plot it, with the interface updates affecting the generation parameters. 

``` 

library(shiny)
library(ggplot2)

# Define UI for application that lets you draw a scatter plot
ui <- fluidPage(
  
  
    
    titlePanel("Demonstration App"),
    
    sliderInput("c_slider", "C: ", 0, 5, 1),
    
    sliderInput("m_slider", "M: ", 0, 5, 1),
    
    plotOutput(outputId = 'scatterPlot')
    
  
  
)

# Define server logic required to draw a scatter plot
server <- function(input, output) {

  
  output$scatterPlot <- renderPlot({
    x <- seq(0, 100)
    y <- x input$m_slider +  input$c_slider 
    ggplot() + geom_point(aes(x, y))
  })
  

}

# Run the application 
shinyApp(ui = ui, server = server)


```


Next, we will arrange this to be a bit more aesthetically pleasing, this can be done in a very similar way to the widgets in python we used earlier by defining containers and layouts which are relative to one another. 

```
library(shiny)
library(ggplot2)

ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel(
    
    titlePanel("Demonstration App"),
    
    sliderInput("c_slider", "C: ", 0, 5, 1),
    
    sliderInput("m_slider", "M: ", 0, 5, 1)),
    mainPanel (
    plotOutput(outputId = 'scatterPlot')))
    
  
  
)

server <- function(input, output) {

  
  output$scatterPlot <- renderPlot({
    x <- seq(0, 100)
    y <- x * input$m_slider +  input$c_slider 
    ggplot() + geom_point(aes(x, y))
  })
  

}

# Run the application 
shinyApp(ui = ui, server = server)

```

### Exercise 1: Create a new shiny app which shows a line plot alongside the scatter plot for the same function




### Exercise 2: Using the tabset layout, create an interface which allows the user to tab between the line and scatterplots 
HINT: in the main panel, use something like
```
tabsetPanel(tabPanel("Title", contents),tabPanel("Title", contents))
```
The layout options are more extensive in Shiny than when using Ipywidgets, so have a look at the layout guide here for inspiration: https://shiny.posit.co/r/articles/build/layout-guide/ 



### Exercise 1 Solution:
```
library(shiny)
library(ggplot2)

ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      
      titlePanel("Demonstration App"),
      
      sliderInput("c_slider", "C: ", 0, 5, 1),
      
      sliderInput("m_slider", "M: ", 0, 5, 1)),
    mainPanel (
      plotOutput(outputId = 'scatterPlot'),
      plotOutput(outputId = 'linePlot')
      
      )
    
    )
  
  
  
)

server <- function(input, output) {
  
  
  output$scatterPlot <- renderPlot({
    x <- seq(0, 100)
    y <- x * input$m_slider +  input$c_slider 
    ggplot() + geom_point(aes(x, y))
  })
  
  output$linePlot <- renderPlot({
    x <- seq(0, 100)
    y <- x * input$m_slider +  input$c_slider 
    ggplot() + geom_line(aes(x, y))
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)


```


### Exercise 2 Solution

```
library(shiny)
library(ggplot2)

ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      
      titlePanel("Demonstration App"),
      
      sliderInput("c_slider", "C: ", 0, 5, 1),
      
      sliderInput("m_slider", "M: ", 0, 5, 1)),
    mainPanel(tabsetPanel (
      tabPanel("Scatter", plotOutput(outputId = 'scatterPlot')),
      tabPanel("Line", plotOutput(outputId = 'linePlot'))
      
      ))
    
    )
  
  
  
)

server <- function(input, output) {
  
  
  output$scatterPlot <- renderPlot({
    x <- seq(0, 100)
    y <- x * input$m_slider +  input$c_slider 
    ggplot() + geom_point(aes(x, y))
  })
  
  output$linePlot <- renderPlot({
    x <- seq(0, 100)
    y <- x * input$m_slider +  input$c_slider 
    ggplot() + geom_line(aes(x, y))
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)


```