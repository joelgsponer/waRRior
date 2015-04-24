waRRior.google.colors.load <- function(
  url = "https://gist.githubusercontent.com/joelgsponer/4c131e60302b4a6d2264/raw/936a0349c46ba123f22f9eba1a416e755473638d/googlecolors.json"
){
  cat("waRRior: Loading google.colors.\n")
  google.colors <- fromJSON(getURL(tmp))
  assign("google.colors", google.colors, envir = .GlobalEnv)
  cat("waRRior: google.colors loaded.\n")
}

waRRior.google.colors.load()
