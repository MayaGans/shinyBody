#' Color Generator for the Shiny body input
#'
#' @param n vector of values to create colors for
#' @param name the name of the color function
#' @param palette the color palette passed from body-input
#' @export
bodyPalette <- function (n, name = c("body.colors"), pal = "Blues") {

  # --------------------------------------------------
  # Create palette using user supplied values
  # Default is blues
  # --------------------------------------------------
  colors <- fBasics::seqPalette(15, pal)

  r <- grDevices::col2rgb(colors)[1,]
  g <- grDevices::col2rgb(colors)[2,]
  b <- grDevices::col2rgb(colors)[3,]

  body.colors = rgb(r,g,b,maxColorValue = 255)
  name = match.arg(name)
  orig = eval(parse(text = name))
  rgb = t(col2rgb(orig))
  temp = matrix(NA, ncol = 3, nrow = n)
  x = seq(0, 1, , length(orig))
  xg = seq(0, 1, , n)
  for (k in 1:3) {
    hold = spline(x, rgb[, k], n = n)$y
    hold[hold < 0] = 0
    hold[hold > 255] = 255
    temp[, k] = round(hold)
  }
  palette = rgb(temp[, 1], temp[, 2], temp[, 3], maxColorValue = 255)
  palette
}
