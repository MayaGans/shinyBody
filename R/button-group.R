#' A Bootstrap Button Group Input
#'
#' This input operates like a [shiny::radioButtons()] or
#' [shiny::checkboxGroupInput()] input.
#'
#' @importFrom rlang %||%
#'
#' @param inputId The input id
#' @param choices A vector of choices for the button group. The names will be
#'   used for button labels and the value are returned by the input. If an
#'   unnamed vector is provided, the button labels and values returned will be
#'   the same.
#' @param choice_labels A list of labels for the choices that can be arbitrary
#'   HTML if wrapped in `HTML()`. Set to `""` or `NULL` for no label.
#' @param btn_class A single class applied to each individual button, or a
#'   vector of button classes for each button (must be same length as
#'   `choices`). For more information see
#'   <https://getbootstrap.com/docs/3.3/css/#buttons>. The default button class
#'   is, appropriately, `"btn-default"`. Be sure to include this or a similar
#'   button style class if you modify `btn_class`.
#' @param btn_icon An single icon name or a vector of icon names (must be the
#'   same length as `choices`) to be applied to the buttons. See [shiny::icon()]
#'   for more information.
#' @param btn_extra A list or list of lists of additional attributes to be added
#'   to the buttons. If the list does not contain sublists (i.e. depth 1), then
#'   the same attributes are applied to all of the buttons. Otherwise, the
#'   list of attributes should match the buttons generated from `choices`.
#'
#'   For example
#'
#'   ```
#'   buttonGroup(
#'     inputId = "special_group", choices = c("one", "two"),
#'     btn_extra = list(
#'       list(alt = "Button One"),
#'       list(alt = "Button Two")
#'     )
#'   )
#'   ```
#' @param selected The buttons, by button value, that should be activated.
#' @param multiple By default, only a single button may be toggled at a time.
#'   If `multiple` is `TRUE`, then `buttonGroup()` returns a character vector
#'   of the selected button values.
#' @param ... Passed to [htmltools::div()]
#'
#' @return The value returned by the input to the Shiny server is either `NULL`
#'   when no buttons are selected or a character vector containing the values
#'   from `choices` corresponding to the active buttons.
#'
#' @export
buttonGroup <- function(
  inputId,
  choices,
  choice_labels = names(choices) %||% choices,
  btn_class = "btn-default",
  btn_icon = NULL,
  btn_extra = NULL,
  selected = NULL,
  multiple = FALSE,
  ...
) {

  if (!is.null(choice_labels) && length(choice_labels) != length(choices)) {
    stop("`choice_labels` must be the same length as `choices`")
  }

  selected <- shiny::restoreInput(inputId, selected)
  if (!is.null(selected)) {
    stopifnot(!any(is.na(selected)))
    selected_lgl <- choices %in% selected
  } else {
    selected_lgl <- rep(FALSE, length(choices))
    selected <- NULL
  }

  btn_class <- btn_class %||% "btn-default"

  if (length(btn_class) > 1 && length(btn_class) != length(choices)) {
    stop("`btn_class` must be length one or the same length as `options`")
  }
  if (length(btn_class) == 1) btn_class <- rep(btn_class, length(choices))

  if (!is.null(btn_extra)) {
    if (!is.list(btn_extra)) stop("`btn_extra` must be a list or list of lists")

    if (is.list(btn_extra[[1]]) && length(btn_extra) != length(choices)) stop(
      "`btn_extra` has ", length(btn_extra), " option but there are ",
      length(choices), " buttons."
    )

    if (!is.list(btn_extra[[1]])) {
      btn_extra <- rep(list(btn_extra), length(choices))
    }
  }

  btn_icon <- prep_button_icon(btn_icon, choices)

  button_options <- list(
    input_id = paste0(inputId, "__", seq_along(choices)),
    value = choices,
    text = choice_labels,
    class = btn_class,
    icon = btn_icon,
    extra = btn_extra,
    selected = selected_lgl
  )

  button_list <- button_options %>%
    purrr::discard(is.null) %>%
    purrr::pmap(make_button)

  htmltools::tagList(
    htmltools::htmlDependency(
      name    = "shinyBody",
      version = utils::packageVersion("shinyBody"),
      package = "shinyBody",
      src     = "js",
      script  = "input-binding-button-group.js"
    ),
    tags$div(
      class = "shinybody-btn-group btn-group",
      id = inputId,
      `data-input-id` = inputId,
      `data-multiple` = as.integer(multiple),
      role = "group",
      ...,
      button_list
    )
  )
}

#' @describeIn buttonGroup Example app demonstrating usage of the buttonGroup
#'   input.
#' @inheritParams shiny::runApp
#' @export
buttonGroupDemo <- function(display.mode = c("showcase", "normal", "auto")) {
  shiny::runApp(
    pkg_file("examples", "buttonGroup"),
    display.mode = match.arg(display.mode)
  )
}

#' @describeIn buttonGroup Set active buttons to the choices in `values`, which
#'   must match the values in `choices` provided to `buttonGroup()`.
#' @param values The `choices` (not `choice labels`) that should be activated.
#'   Set to `NULL` to deactivate all buttons.
#' @param session The `session` object passed to function given to `shinyServer`.
#' @export
updateButtonGroupValue <- function(
  inputId,
  values = NULL,
  session = shiny::getDefaultReactiveDomain()
) {
  stopifnot(is.character(values) || is.null(values))

  if (is.null(values)) values <- list(NULL)

  session$sendInputMessage(inputId, list(value = values))
}

make_button <- function(
  input_id,
  value,
  text = NULL,
  class = "btn btn-default",
  icon = "",
  selected = FALSE,
  extra = NULL
) {
  class <- paste(class, collapse = " ")
  if (selected) class <- paste(class, "active")
  class <- paste("btn", class)
  button_args <- list(
    id = input_id,
    class = class,
    value = value,
    if (icon != "") shiny::icon(icon),
    text
  )
  button_args <- c(button_args, extra)
  htmltools::tag("button", button_args)
}

prep_button_icon <- function(btn_icon, choices) {
  if (is.null(btn_icon)) {
    return(rep("", length(choices)))
  }

  # btn icons must be length 1 (all buttons), length of choices, or named
  if (length(btn_icon) == 1) {
    btn_icon <- rep(btn_icon, length(choices))
  } else {
    if (is.null(names(btn_icon))) {
      if (length(btn_icon) != length(choices)) {
        stop("`btn_icon` must be length one or the same length as `options`")
      }
    } else {
      btn_icons <- rep("", length(choices))
      names(btn_icons) <- unname(choices)
      for (choice in intersect(choices, names(btn_icon))) {
        btn_icons[choice] <- btn_icon[choice]
      }
      btn_icon <- btn_icons
    }
  }
  return(btn_icon)
}
