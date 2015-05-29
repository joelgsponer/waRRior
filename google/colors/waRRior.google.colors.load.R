waRRior.google.colors.load <- function(
  url = "https://raw.githubusercontent.com/joelgsponer/waRRior/master/google/colors/waRRior.google.colors.json"
){
  waRRior.snippets.verbose("loading google.colors.\n")
  google.colors <- fromJSON(getURL(url))
  assign("google.colors", google.colors, envir = .GlobalEnv)
  waRRior.snippets.verbose("google.colors loaded.\n")
}

waRRior.google.colors.load()
