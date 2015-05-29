waRRior.snippets.verbose <- function(message,verbose_ = T){
  if(verbose_){
    cat("waRRior:",message,"\t\t(", format(Sys.time()),")\n")
  }
}
