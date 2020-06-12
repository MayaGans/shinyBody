# Example of buttonGroup shinyBody Shiny Input
library(shiny)

button_choices <- c(
    "Eleven" = "eleven",
    "Will Byers" = "will",
    "Mike Wheeler" = "mike",
    "Dustin Henderson" = "dustin",
    "Lucas Sinclair" = "lucas"
)

two_col <- function(a, b) {
    fluidRow(
        div(class = "col-xs-12 col-sm-6", a),
        div(class = "col-xs-12 col-sm-6", b)
    )
}

ui <- function(request) {
    fluidPage(
        titlePanel("shinyBody Button Group"),
        id = "button_group_page",

        # tags$h4("A regular button"),
        # actionButton("button_regular", "Regular Button"),

        two_col(
            tagList(
                tags$h4("Radio Toggle Buttons"),
                buttonGroup(
                    inputId = "button_radio",
                    choices = button_choices
                ),
                tags$p(),
                verbatimTextOutput("chosen_radio")
            ),
            tagList(
                tags$h4("Checkbox Buttons"),
                buttonGroup(
                    inputId = "button_checkbox",
                    choices = button_choices,
                    multiple = TRUE
                ),
                tags$p(),
                verbatimTextOutput("chosen_checkbox")
            )
        ),

        two_col(
            tagList(
                tags$h4("Buttons with Style"),
                buttonGroup(
                    inputId = "button_style",
                    choices = names(button_choices),
                    choice_labels = names(button_choices),
                    btn_class = paste0("btn-", c("primary", "success", "info", "warning", "danger")),
                    multiple = TRUE
                ),
                tags$p(),
                verbatimTextOutput("chosen_style")
            ),
            tagList(
                tags$h4("Buttons with Initial Settings"),
                buttonGroup(
                    inputId = "button_init",
                    choices = button_choices,
                    selected = c("eleven", "mike", "lucas"),
                    btn_class = "btn-default btn-sm",
                    multiple = TRUE
                ),
                tags$p(),
                verbatimTextOutput("chosen_init")
            )
        ),

        two_col(
            tagList(
                tags$h4("Buttons with icons"),
                buttonGroup(
                    inputId = "button_icon",
                    choices = c("left", "center", "justify", "right"),
                    btn_icon = paste0("align-", c("left", "center", "justify", "right")),
                    multiple = FALSE
                ),
                tags$p(),
                verbatimTextOutput("chosen_icon")
            ),
            tagList(
                tags$h4("Buttons with HTML"),
                buttonGroup(
                    inputId = "button_html",
                    choices = c("bold", "italic", "underline", "strikethrough"),
                    choice_labels = list(
                        HTML("<strong>B</strong>"),
                        HTML("<i>I</i>"),
                        HTML("<span style='text-decoration: underline'>U</span>"),
                        HTML("<del>S</del>")
                    ),
                    multiple = TRUE
                ),
                tags$p(),
                verbatimTextOutput("chosen_html")
            )
        ),

        bookmarkButton()
    )
}

server <- function(input, output) {
    output$chosen_radio    <- renderPrint(input$button_radio)
    output$chosen_checkbox <- renderPrint(input$button_checkbox)
    output$chosen_style    <- renderPrint(input$button_style)
    output$chosen_init     <- renderPrint(input$button_init)
    output$chosen_icon     <- renderPrint(input$button_icon)
    output$chosen_html     <- renderPrint(input$button_html)
}

shinyApp(ui = ui, server = server, enableBookmarking = "url")
