$name$ <- function(
   x
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = $id$ #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,debug = F #Turn debug messages on and off
  ,...){
  tryCatch({
    t <- Sys.time() 
    #Actual Function code
    $$$
    
    #define response
    response <- list(
       result <- $$$
      ,message <- paste(function.id, 'success')
      ,error = 0
      ,e = NULL
      ,time.elapsed = as.numeric(difftime(Sys.time(), t), units = "secs")
    )
    
    #Success message
    waRRior.snippets.verbose(paste(function.id,'success'), verbose_ = verbose)
    
    #Return respond
    return(response)
  
   #Error handling
   }, error = function(e, silent = is.silent){
     #If silent supress error and return list instead
      if(silent){
       return(list(
          message = sprintf("Error during function: %s", function.id)
         ,error = 1
         ,e = e
       ))
      }else{
        stop(e)
      }
     }
  )
}
