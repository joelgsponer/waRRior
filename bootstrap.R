cat("** waRRior v0.1 is being loaded **\n\n")

functions.to.be.laoded.on.startup <- list(
  #Libraries
  "https://raw.githubusercontent.com/joelgsponer/waRRior/master/libraries/waRRior.libraries.startup.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/libraries/waRRior.libraries.checkPkg.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/libraries/waRRior.libraries.install.R" #depends on checkPkg
  #General
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/refresh.R"
  #Github
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/github/read/data/waRRior.github.read.data.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/github/read/code/waRRior.github.read.code.R"
  #Google
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/google/colors/waRRior.google.colors.load.R"
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
  cat("Loading functions:\n")
  tryCatch({
    source_https(f)
    function.id <- unlist(strsplit(f,"/"))
    function.id <- function.id[length(function.id)]
    cat(function.id, "\n")
    },
    error = function(e, f_ = f){
     print(sprintf("Error loading %s", f_))
     print(e)
     })
}


cat("waRRior is ready!\n")
