print("** waRRior v0.1 is being loaded **")

functions.to.be.laoded.on.startup <- list(
  #General
   "https://raw.githubusercontent.com/joelgsponer/waRRior/master/refresh.R"
  #Github
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/github/read/data/waRRior.github.read.data.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/github/read/code/waRRior.github.read.code.R"
)

source_https <- function(url, ...) {
  # load package
  require(RCurl)
 
  # parse and evaluate each .R script
  sapply(c(url, ...), function(u) {
    eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
  })
}

for(f in functions.to.be.laoded.on.startup){
  tryCatch({
    source_https(f)
    function.id <- unlist(strsplit(f,"/"))
    function.id <- function.id[length(function.id)]
    print(function.id)
    },
    error = function(e, f_ = f){
     print(sprintf("Error loading %s", f_))
     print(e)
     })
}


print(" OK!")
