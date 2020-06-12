`%||%` <- function(x, y) if (is.null(x)) y else x

pkg_file <- function(...) {
  system.file(..., package = "shinyThings", mustWork = TRUE)
}

spaces <- function(...) {
  x <- lapply(list(...), function(x) paste(x, collapse = " "))
  paste(x, collapse = " ")
}

dbg <- function(..., id = NULL) {
  if (getOption("shinyThings.debug", FALSE)) {
    id <- if (!is.null(id)) paste0("[", id, "] ")
    message(id, ..., appendLF = TRUE)
  }
}
