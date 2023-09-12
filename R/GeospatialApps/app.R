#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel(
    
    titlePanel("Demonstration App"),
    
    sliderInput("c_slider", "C: ", 0, 5, 1),
    
    sliderInput("m_slider", "M: ", 0, 5, 1)),
    mainPanel (
    plotOutput(outputId = 'scatterPlot')))
    
  
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  
  output$scatterPlot <- renderPlot({
    x <- seq(0, 100)
    y <- x* input$c_slider * input$m_slider
    ggplot() + geom_line(aes(x, y))
  })
  

}

# Run the application 
shinyApp(ui = ui, server = server)
