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
    bodyInput("human"),
    verbatimTextOutput("debug")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$debug <- renderText(input$human)
}

# Run the application
shinyApp(ui = ui, server = server)
