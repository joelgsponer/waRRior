waRRior.snippets.verbose <- function(message,verbose_ = verbose){
  if(verbose_){
    cat("waRRior:",message,"\t\t(", format(Sys.time()),")\n")
  }
}
