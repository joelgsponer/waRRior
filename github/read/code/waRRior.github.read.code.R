github.read.code <- function(
   url
  ,do.dplyr =T #Return result in dplyr's tbl_df
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = 'github.read.code' #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,...){
  tryCatch({
     
    #Actual Function code
    # load package
    require(RCurl)
 
    # parse and evaluate each .R script
    sapply(c(url, ...), function(u) {
      eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
    })
    
    #define response
    response <- NULL
    
    #Success message
    if(verbose) cat('waRRior:',function.id,'success\n')
    
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
