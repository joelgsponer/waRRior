waRRior.refresh <- function(development = F, verbose = T){
  waRRior.snippets.verbose('refreshing.', verbose_ = verbose)
  waRRior.snippets.verbose('cleaning up.', verbose_ = verbose)
  for(i in grep("waRRior", ls(),value = T)){
    if(i != "waRRior.local.path")rm(i)
  } 
  waRRior.github.read.code("https://raw.githubusercontent.com/joelgsponer/waRRior/master/bootstrap.R")
  waRRior.snippets.verbose('waRRior: done refreshing.', verbose_ = verbose)
}
