# Example of shinyBody Shiny Input
library(shiny)

ui <- function() {
    fluidPage(
        bodyInput("human"),
        verbatimTextOutput("debug")
    )
}

server <- function(input, output) {
    # this should print the body part...
    output$debug <- renderText(input$human)
}

shinyApp(ui = ui, server = server)
