# Example of shinyBody Shiny Input
library(shiny)

ui <- function() {

    fluidPage(
        bodyInput("human",
                  data = c(rnorm(13, 100))),
        verbatimTextOutput("debug")
    )
}

server <- function(input, output) {
    output$debug <- renderPrint(input$human)
}

shinyApp(ui = ui, server = server)
