#' Color Generator for the Shiny body input
#'
#' @param n vector of values to create colors for
#' @param low.col the color palette passed from body-input
#' @param high.col the color palette passed from body-input
#' @export
bodyPalette <- function (n, low.col = "#eef4fb", high.col = "#164a85") {
  attr(color_vctr(n, text_color = color_scale(grDevices::colorRamp(c(low.col,high.col)))), ".text_color")
}
