waRRior.snippets.verbose <- function(message,verbose_ = T){
  if(verbose_){
    cat("[",format(Sys.time()),"] waRRior: ",message,"\n", sep = "")
  }
}
