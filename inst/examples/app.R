# Example of shinyBody Shiny Input
library(shiny)

ui <- function() {

    fluidPage(
        bodyInput("human",
                  data = c(30,20,40,60,90,100,14,50,40,20,70,70,30),
                  low.col = "#eef4fb", high.col = "#164a85"),
        verbatimTextOutput("debug")
    )
}

server <- function(input, output) {
    output$debug <- renderPrint(input$human)
}

shinyApp(ui = ui, server = server)
