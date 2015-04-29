waRRior.refresh <- function(verbose = T){
  if(verbose)cat("waRRior: refreshing.")
  if(verbose)cat("waRRior: cleaning up.")
  rm(ls()[grep("waRRior", ls())])
  waRRior.github.read.code("https://raw.githubusercontent.com/joelgsponer/waRRior/master/bootstrap.R")
  if(verbose)cat("waRRior: done refreshing.")
}
