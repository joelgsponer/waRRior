github.read.data <- function(
   url
  ,do.dplyr =T #Return result in dplyr's tbl_df
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = "github.read.data" #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,...){
  tryCatch({
     
    #Actual Function code
    require(RCurl)
    if(do.dplyr)require(dplyr)
    x <- getURL(url)
    y <- read.delim(text = x, ...)
    if(do.dplyr){
      y <- tbl_df(y)
    }
    
    #define response
    response <- y
    
    #Success message
    if(verbose) cat('waRRior: Sucssfully loaded data form:',url,'with',function.id, "\n")
    
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
