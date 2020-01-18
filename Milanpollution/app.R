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
library(forecast)
library(xts)


leggo <- read.csv(file="C:/Users/andre/Desktop/GitHub/R-exercises/Milan_airquality/Milan_airquality2019.csv", header=TRUE, sep=",")
#ggplot(Data,aes(displ,hwy,colour=blue)) + geom_point()

Data = leggo
Data$stazione_id=NULL
#summary(Data)
Data = Data[complete.cases(Data),]

test = aggregate(valore~ data+inquinante, Data , mean)
test

# Define UI for application that draws a histogram

ui <- fluidPage(
    titlePanel("Milan pollution 2019"),
    sidebarLayout(
        sidebarPanel(
            # Dropdown menu for selecting variable from GE data.
            selectInput("pollutant",
                        label = "Select pollutant type",
                        choices = unique(test$inquinante),
                        selected = "PM10"),
            hr(),
            helpText("Data from openData comune di Milano"),
            # Default selection
            sliderInput("lag",
                        "Forecasting lags:",
                        min = 1,  max = 50, value = 1),
        ),
        mainPanel(
            plotOutput("BarPlot"),
            plotOutput("Timeseries"),  
            plotOutput("Forecast")  
            
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    output$BarPlot <- renderPlot({          
        inp = input$pollutant
        
        poll = subset(test,subset= inquinante==inp)
        poll= poll[,c('data','valore')]
        ggplot(poll, aes(x=data,y=valore, group=1))+geom_point()+geom_line()+ geom_smooth(method="lm")
        
    
        
        # Render a barplot
    })
    
    
    output$Timeseries <- renderPlot({          
        inp = input$pollutant
        
        poll = subset(test,subset= inquinante==inp)
        poll= poll[,c('data','valore')]
        ggplot(poll, aes(x=data,y=valore, group=1))+geom_point()+geom_line()+ geom_smooth(method="lm")
        
        time = poll$data = NULL
        time.ts = as.ts(poll)
        plot(time.ts)
# Render a barplot

    })
    
    output$Forecast<- renderPlot({          
        inp = input$pollutant
        
        poll = subset(test,subset= inquinante==inp)
        poll= poll[,c('data','valore')]
        ggplot(poll, aes(x=data,y=valore, group=1, color=valore))+geom_point()+geom_line()+ geom_smooth(method="lm")
        
        time = poll$data = NULL
        time.ts = as.ts(poll)
        plot(time.ts)
        fit = auto.arima(time.ts)
        plot(forecast(fit,input$lag))
        
        # Render a forecast plot
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
