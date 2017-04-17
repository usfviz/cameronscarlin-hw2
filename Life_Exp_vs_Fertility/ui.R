library(shiny)
library(ggplot2)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Fertility Rate vs Life Expectancy by Year"),
  
  # Sidebar with a slider input for number of bins 

    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("distPlot", height='450%', width='150%'),
       sliderInput('year','Year:',
                   min = 1960,
                   max = 2014,
                   value = 1960,
                   sep = '',
                   animate=TRUE)
    )
    
  )
)
