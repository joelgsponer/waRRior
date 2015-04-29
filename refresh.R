waRRior.refresh <- function(verbose = T){
  if(verbose)cat("waRRior: refreshing.\n")
  if(verbose)cat("waRRior: cleaning up.\n")
  rm(ls()[grep("waRRior", ls())])
  waRRior.github.read.code("https://raw.githubusercontent.com/joelgsponer/waRRior/master/bootstrap.R")
  if(verbose)cat("waRRior: done refreshing.\n")
}
