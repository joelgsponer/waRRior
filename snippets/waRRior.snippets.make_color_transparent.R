waRRior.snippets.make_color_transparent <- function(..., alpha=0.5, verbose = F) {
  
  if(alpha<0 | alpha>1) stop("alpha must be between 0 and 1")
  if(alpha == 0) alpha <- 0.000001
  if(is.na(alpha))alpha <- 0.000001

  alpha <-  floor(255*alpha)
  waRRior.snippets.verbose(paste("alpha:",alpha), verbose_ = verbose)
  col   <- unlist(list(...))
  waRRior.snippets.verbose(paste("col:",col), verbose_ = verbose)
  newColor = col2rgb(col , alpha=FALSE)
  
  .makeTransparent = function(col, alpha) {
    waRRior.snippets.verbose(paste("alpha:",alpha), verbose_ = verbose)
    waRRior.snippets.verbose(paste("col:",col), verbose_ = verbose)
    rgb(red=col[1], green=col[2], blue=col[3], alpha=alpha, maxColorValue=255)
  }
  newColor = apply(newColor, 2, .makeTransparent, alpha=alpha)
  
  return(newColor)
  
}
