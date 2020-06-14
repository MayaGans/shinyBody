# Example of shinyBody Shiny Input
library(shiny)

ui <- function() {
    fluidPage(
        bodyInput("human", data = c(10,20,40,60,90,100,25,50,15,20,70,70,30)),
        verbatimTextOutput("debug")
    )
}

server <- function(input, output) {
    output$debug <- renderPrint(input$human)
}

shinyApp(ui = ui, server = server)
