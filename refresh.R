waRRior.refresh <- function(verbose = T){
  waRRior.snippets.verbose('refreshing.')
  waRRior.snippets.verbose('cleaning up.')
  for(i in grep("waRRior", ls(),value = T)) rm(i)
  waRRior.github.read.code("https://raw.githubusercontent.com/joelgsponer/waRRior/master/bootstrap.R")
  waRRior.snippets.verbose('waRRior: done refreshing.')
}
