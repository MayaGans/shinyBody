# --------------------------------------------------------------
# All code adapted from:
# https://github.com/thebioengineer/colortable/blob/master/R/scale_color_vctr.R
# --------------------------------------------------------------

new_color_vctr <- function(vect, text_color = NA, background = NA, style = NA ){

  stopifnot(is.atomic(vect))
  stopifnot(length(text_color) == 1 | length(text_color) == length(vect))
  stopifnot(length(background) == 1 | length(background) == length(vect))
  stopifnot(length(style) == 1 | length(style) == length(vect))

  if (is.function(text_color))
    text_color <- text_color(vect)
  if (is.function(background))
    background <- background(vect)

  if (length(text_color) == 1)
    text_color <- rep(text_color, length(vect))
  if (length(background) == 1)
    background <- rep(background, length(vect))
  if (length(style) == 1)
    style <- rep(style, length(vect))

  return(
    structure(
      vect,
      ".text_color" = text_color,
      ".background" = background,
      ".style" = style,
      class = c("color_vctr",class(vect))
    )
  )
}


color_vctr <- function(x,..., text_color = NA, background = NA, style = NA){
  UseMethod("color_vctr",x)
}

#' @export
color_vctr.default <- function(x,...,text_color = NA, background = NA, style = NA) {
  new_color_vctr(
    x,
    text_color = text_color,
    background = background,
    style = style
  )
}

color_vctr.color_vctr <- function(x,...){

  coltable_nect_list <- list(x,...)

  vect <- do.call('c', lapply(coltable_nect_list, function(z) {
    .subset(z, seq_along(z))
  }))

  text_color <- do.call('c', lapply(coltable_nect_list, vctrs::field, ".text_color"))
  background <- do.call('c', lapply(coltable_nect_list, vctrs::field, ".background"))
  style      <- do.call('c', lapply(coltable_nect_list, vctrs::field, ".style"))

  return(new_color_vctr(
    vect,
    text_color = text_color,
    background = background,
    style = style
  ))
}

color_scale <- function(palette, na.color = "#808080") {
  function(x) {
    color_scaler <- switch(
      scale_col_type(x),
      continuous = scales::col_numeric(
        palette,
        domain = c(min(x, na.rm = TRUE),
                   max(x, na.rm = TRUE)),
        na.color = na.color
      ),
      binned = scales::col_factor(
        palette,
        levels = levels(factor(x)),
        na.color = na.color)
    )
    color_scaler(x)
  }
}


scale_col_type <- function(x) {
  ifelse(
    inherits(x,c("numeric","integer","Date", "POSIXt")),
    "continuous",
    "binned"
  )
}
