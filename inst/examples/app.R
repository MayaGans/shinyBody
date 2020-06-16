# Example of shinyBody Shiny Input
library(shiny)

ui <- function() {

    fluidPage(
        sidebarPanel(
            bodyInput("human", data = c(rnorm(13, 100))),
            textInput("test", "test")
        ),
        mainPanel(
            verbatimTextOutput("debug")
        )
    )
}

server <- function(input, output) {
    output$debug <- renderPrint(input$human)
}

shinyApp(ui = ui, server = server)
