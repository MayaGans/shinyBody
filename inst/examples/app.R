# Example of buttonGroup shinyBody Shiny Input
library(shiny)

ui <- function() {
    fluidPage(
        bodyInput("human"),
        verbatimTextOutput("debug")
    )
}

server <- function(input, output) {
    output$debug <- renderText(input$human)
}

shinyApp(ui = ui, server = server)
