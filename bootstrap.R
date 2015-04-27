cat("
\n**********************************
\n** waRRior v0.1 is being loaded **
\n**********************************
\n")

files.to.be.loaded.on.startup <- list(
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
  ##Colors
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/google/colors/waRRior.google.colors.load.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/google/colors/waRRior.google.colors.accents.R"
  #Statistics
  ##General
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/statistics/general/warrior.statistics.general.ptostars.R"
  ##Views
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/statistics/views/waRRior.statistics.views.barplot.R"
  ##Survival
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/statistics/survival/waRRior.statistics.survival.cutoff.R"
  #Bioinformatics
  ##aCGH
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/bioinformatics/acgh/waRRior.bioinformatics.acgh.nowaves.R"
)

source_https <- function(url, ...) {
  # load package
  require(RCurl)
 
  # parse and evaluate each .R script
  sapply(c(url, ...), function(u) {
    eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
  })
}

cat("Loading files:\n")
for(f in files.to.be.loaded.on.startup){
  tryCatch({
    source_https(f)
    function.id <- unlist(strsplit(f,"/"))
    function.id <- function.id[length(function.id)]
    cat("\t*",function.id, "\n")
    },
    error = function(e, f_ = f){
     cat(sprintf("\nwaRRior: ERROR loading %s !!!!!!!\n", f_))
     print(e)
     })
}


cat("waRRior is ready!\n")
