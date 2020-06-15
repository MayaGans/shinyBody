# Example of shinyBody Shiny Input
library(shiny)

ui <- function() {

    fluidPage(
        bodyInput("human",
                  data = c(30,20,40,60,90,100,25,50,40,20,70,70,30),
                  pal = "Blues"),
        verbatimTextOutput("debug")
    )
}

server <- function(input, output) {
    output$debug <- renderPrint(input$human)
}

shinyApp(ui = ui, server = server)
