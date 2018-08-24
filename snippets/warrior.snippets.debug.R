waRRior.snippets.debug <- function(message, object, debug_ = T){
  if(debug_){
    cat("[",format(Sys.time()),"] waRRior ####DEBUG####: ",message,"\n", sep = "")
    print(object)
    cat("#############\n")
  }
}
