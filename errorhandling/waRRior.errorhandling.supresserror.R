waRRior.errorhandling.supresserror <- function(x, error.message.print = T){
  tryCatch(x, error = function(e){if(error.message.print)print(e)}
}
