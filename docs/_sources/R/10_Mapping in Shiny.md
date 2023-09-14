## Mapping in Shiny

Shiny has support for leaflet, the same package that powers ipyleaflet. This allows you to easily create interactive mapping visualisations in much the same way as you did in the Python part of this course. Using the leaflet library, it is easy to add an interactive map to your application, though it requires a slightly different process to Python:


``` 
library(shiny)
library(leaflet)

ui <- fluidPage(
  leafletOutput("Map")
  

)

server <- function(input, output) {
  output$Map <- renderLeaflet({
    leaflet() %>% 
      addTiles() 
    
  })
}

shinyApp(ui = ui, server = server)
```

Notice here how rather than using the map object to directly show the map, we pass it to the server's output, and use that in the interface part of the application to create the map. 

Leaflet also works easily with the layout tools we saw earlier:

``` 
library(shiny)
library(leaflet)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
  titlePanel("Mapping App")),
    
  mainPanel(leafletOutput("Map")))
  

)

server <- function(input, output) {
  output$Map <- renderLeaflet({
    leaflet() %>% 
      addTiles() 
    
  })
}

shinyApp(ui = ui, server = server)
```


Similarly, we can also use the widgets as inputs to code which models our data. Thankfully, it is also much easier to add raster data to maps when using leaflet in R comapred to Python! Below we'll take a look at some example code for re-creating the heatwave modelling app in R:

```
library(shiny)
library(leaflet)
library(raster)

NDVI <- raster('Data/leeds_NDVI_aug_highres.tif')
NDWI <- raster('Data/leeds_NDWI_aug_highres.tif')
NDBI <- raster('Data/leeds_NDBI_aug_highres.tif')

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
  titlePanel("Heatwave Modelling App"),
  sliderInput('solarRad', 'Solar Irradiance', 0, 15, 4),
  sliderInput('ndviBeta', 'NDVI Coefficient', -5, 5, 0),
  sliderInput('ndwiBeta', 'NDWI Coefficient', -5, 5, 0),
  sliderInput('ndbiBeta', 'NDBI Coefficient', -5, 5, 0)
  ),
    
  mainPanel(leafletOutput("Map")))
  

)

server <- function(input, output) {
  
  output$Map <- renderLeaflet({
    heatwaveRaster <- (NDBI*input$ndbiBeta) + (NDVI*input$ndviBeta) + (NDWI*input$ndwiBeta) + input$solarRad + 15
  
    #Similarly to Python, we have to generate a colour palette for the dataset
    pallette = colorNumeric(c('#0000FF', '#FF0000'), values(heatwaveRaster), na.color = "transparent")
    
    leaflet() %>% 
      addTiles() %>%
      addRasterImage(heatwaveRaster, colors=pallette) %>%
      addLegend(pal=pallette, values=values(heatwaveRaster))
      
    
  })
}

shinyApp(ui = ui, server = server)

```

Ok, great! You now have a heatwave app in R and Python. What if you want to add in some utility for your user to share their findings? Adding download functionality in R Shiny is super easy:


```

library(shiny)
library(leaflet)
library(raster)

NDVI <- raster('Data/leeds_NDVI_aug_highres.tif')
NDWI <- raster('Data/leeds_NDWI_aug_highres.tif')
NDBI <- raster('Data/leeds_NDBI_aug_highres.tif')

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
  titlePanel("Heatwave Modelling App"),
  sliderInput('solarRad', 'Solar Irradiance', 0, 15, 4),
  sliderInput('ndviBeta', 'NDVI Coefficient', -5, 5, 0),
  sliderInput('ndwiBeta', 'NDWI Coefficient', -5, 5, 0),
  sliderInput('ndbiBeta', 'NDBI Coefficient', -5, 5, 0),
  downloadButton('downloadButton', 'Download Map')
  ),
    
  mainPanel(leafletOutput("Map")))
  

)

server <- function(input, output) {
  
  output$Map <- renderLeaflet({
    heatwaveRaster <- (NDBI*input$ndbiBeta) + (NDVI*input$ndviBeta) + (NDWI*input$ndwiBeta) + input$solarRad + 15
  
    #Similarly to Python, we have to generate a colour palette for the dataset
    pallette = colorNumeric(c('#0000FF', '#FF0000'), values(heatwaveRaster), na.color = "transparent")
    
    leaflet() %>% 
      addTiles() %>%
      addRasterImage(heatwaveRaster, colors=pallette) %>%
      addLegend(pal=pallette, values=values(heatwaveRaster))
      
    
  })
  
  output$downloadButton = downloadHandler(filename='map.tif', 
                                          content=function(file){
                                            heatwaveRaster <- (NDBI*input$ndbiBeta) + (NDVI*input$ndviBeta) + (NDWI*input$ndwiBeta) + input$solarRad + 15
                                            writeRaster(heatwaveRaster, file)
                                          })
}

shinyApp(ui = ui, server = server)
```


EXERCISE 1:

Similarly to the example in python, add a chart next to the map which shows the distribution of values in the heatwave raster. 


```
library(shiny)
library(leaflet)
library(raster)

NDVI <- raster('Data/leeds_NDVI_aug_highres.tif')
NDWI <- raster('Data/leeds_NDWI_aug_highres.tif')
NDBI <- raster('Data/leeds_NDBI_aug_highres.tif')

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      titlePanel("Heatwave Modelling App"),
      sliderInput('solarRad', 'Solar Irradiance', 0, 15, 4),
      sliderInput('ndviBeta', 'NDVI Coefficient', -5, 5, 1),
      sliderInput('ndwiBeta', 'NDWI Coefficient', -5, 5, 2),
      sliderInput('ndbiBeta', 'NDBI Coefficient', -5, 5, -1),
      downloadButton('downloadButton', 'Download Map')
    ),
    
    mainPanel(leafletOutput("Map"),
              plotOutput("Histogram")))
  
  
)

server <- function(input, output) {
  
  output$Histogram <- renderPlot({
    heatwaveRaster <- (NDBI*input$ndbiBeta) + (NDVI*input$ndviBeta) + (NDWI*input$ndwiBeta) + input$solarRad + 15
    hist(values(heatwaveRaster))
    
  })
  
  output$Map <- renderLeaflet({
    heatwaveRaster <- (NDBI*input$ndbiBeta) + (NDVI*input$ndviBeta) + (NDWI*input$ndwiBeta) + input$solarRad + 15
    
    #Similarly to Python, we have to generate a colour palette for the dataset
    pallette = colorNumeric(c('#0000FF', '#FF0000'), values(heatwaveRaster), na.color = "transparent")
    
    leaflet() %>% 
      addTiles() %>%
      addRasterImage(heatwaveRaster, colors=pallette) %>%
      addLegend(pal=pallette, values=values(heatwaveRaster))
    
    
  })
  
  output$downloadButton = downloadHandler(filename='map.tif', 
                                          content=function(file){
                                            heatwaveRaster <- (NDBI*input$ndbiBeta) + (NDVI*input$ndviBeta) + (NDWI*input$ndwiBeta) + input$solarRad + 15
                                            writeRaster(heatwaveRaster, file)
                                          })
}

shinyApp(ui = ui, server = server)

```