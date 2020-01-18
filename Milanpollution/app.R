#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram

ui <- fluidPage(
    titlePanel("Milan pollution 2019"),
    sidebarLayout(
        sidebarPanel(
            # Dropdown menu for selecting variable from GE data.
            selectInput("Pollutant:",
                        label = "Select pollutant type",
                        choices = c("PM10" = 12, "PM25" = 13),
                        selected = 13),
            hr(),
            helpText("Data from openData comune di Milano")
            # Default selection
        ),
        mainPanel(
            plotOutput("BarPlot")  
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$BarPlot <- renderPlot({          
        # Render a barplot
        barplot(co, 
                main=input$region,
                ylab="Value",
                xlab="Day")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
