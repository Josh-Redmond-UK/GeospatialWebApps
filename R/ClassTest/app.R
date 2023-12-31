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