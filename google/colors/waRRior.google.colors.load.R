waRRior.google.colors.load <- function(
  url = "https://raw.githubusercontent.com/joelgsponer/waRRior/master/google/colors/waRRior.google.colors.json"
){
  cat("waRRior: Loading google.colors.\n")
  google.colors <- fromJSON(getURL(tmp))
  assign("google.colors", google.colors, envir = .GlobalEnv)
  cat("waRRior: google.colors loaded.\n")
}

waRRior.google.colors.load()
