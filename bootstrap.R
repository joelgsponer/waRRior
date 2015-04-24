source_https <- function(url, ...) {
  # load package
  require(RCurl)
 
  # parse and evaluate each .R script
  sapply(c(url, ...), function(u) {
    eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
  })
}

sink("~/.waRRior-log")
source_https(
   "https://raw.githubusercontent.com/joelgsponer/waRRior/master/github/read/data/waRRior.github.read.data.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/github/read/code/waRRior.github.red.code.R"
)
sink()

