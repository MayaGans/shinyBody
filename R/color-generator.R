#' Color Generator for the Shiny body input
#'
#' @param n vector of values to create colors for
#' @param name the name of the color function
#' @param pal the color palette passed from body-input
#' @export
bodyPalette <- function (n, pal = "Blues") {
  colour_palette <- RColorBrewer::brewer.pal(9, pal)
  fn_colour <- grDevices::colorRampPalette(colour_palette, length(unique(n)))
  vec <- n
  print(fn_colour(vec))
  fn_colour(vec)
}
