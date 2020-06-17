

# Example of shinyBody Shiny Input
library(shiny)
library(shinyBody)

ui <- function() {

    fluidPage(
            bodyInput("human",
                      data = c(rnorm(13, 100)),
                      low.col = "#800000",
                      high.col = "#ffe8e8"),
            verbatimTextOutput("debug")
    )
}

server <- function(input, output) {
    output$debug <- renderPrint(input$human)
}

shinyApp(ui = ui, server = server)
