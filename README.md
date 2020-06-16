
# shinyBody

<!-- badges: start -->
<!-- badges: end -->

A custom Shiny input widget built with HTML and CSS that lets you select a body part and will return that body part's name.You can also color limbs based on data by specifying high and low color values:

# Install using GitHub

```{r}
remotes::install_github("MayaGans/shinyBody")
```

# Use Case

```{r}
library(shiny)

ui <- function() {

    fluidPage(
            bodyInput("human", data = c(rnorm(13, 100))),
            verbatimTextOutput("debug")
    )
}

server <- function(input, output) {
    output$debug <- renderPrint(input$human)
}

shinyApp(ui = ui, server = server)
```

<img src="inst/images/README_img.png" width="30%" height="30%">
