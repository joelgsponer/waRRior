$name$ <- function(
   url
  ,do.dplyr =T #Return result in dplyr's tbl_df
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = $id$ #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,...){
  tryCatch({
     
    #Actual Function code
    $$$
    
    #define response
    response <- $$$
    
    #Success message
    if(verbose) cat('waRRior:',function.id,'success')
    
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
