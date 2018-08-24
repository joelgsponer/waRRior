waRRior.snippets.debug <- function(message, object, debug_ = T){
  if(debug_){
    cat("[",format(Sys.time()),"] ####Start DEBUG Message####: ",message,"\n", sep = "")
    print(object)
    cat(sprintf("####End DEBUG Message####:%s\n", message))
  }
}
