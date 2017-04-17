library(shiny)
library(ggplot2)
library(plyr)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlotly({
    regions <- c('East Asia & Pacific',
                 'Europe & Central Asia',
                 'Latin America & Caribbean',
                 'Middle East & North Africa',
                 'North America',
                 'South Asia',
                 'Sub-Saharan Africa')
    #regions <- regions[!input$continents]
    print(regions)
    print(regions[-2])
    worldbank <- read.csv('worldbank.csv')
    continent <- read.csv('continent.csv')
    continent <- continent[continent$Region %in% regions,]
    fertility <- read.csv('fertility.csv')
    popn <- read.csv('population.csv')
    world_cont <- join(worldbank,continent, by = 'Country.Code', type='right')
    popn <- join(popn,continent, by = 'Country.Code', type='right')
    fert <- join(fertility,continent, by = 'Country.Code', type='right')
    
    Population <- popn[paste('X',input$year,sep='')]
    print(input$continents)
    Fertility <- fert[paste('X',input$year,sep='')]
    Life_Expectancy <- world_cont[paste('X',input$year,sep='')]
    ggplotly(ggplot(data=world_cont, aes(x=Life_Expectancy,
                                         y=Fertility,
                                         text=paste('Country:', Country.Name))) + 
      geom_point(aes(size=Population, colour = Region))+
      xlab("Life Expectancy")+
      ylab("Fertility Rate")+
      scale_x_continuous(limits = c(20,90), breaks=c(20,30,40,50,60,70,80,90))+
      scale_y_continuous(limits = c(1,9), breaks=c(1,2,3,4,5,6,7,8,9))+
        theme(panel.background = element_blank(),
              panel.grid.major = element_line(colour='grey'),
              panel.border = element_rect(color = 'grey', fill=NA),
              axis.ticks = element_line(color='grey')))
    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2] 
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})

