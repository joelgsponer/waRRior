
waRRior.snippets.backup_file <- function(
   file
  ,destination
  ,identifier = "UNKNOWN"
  ,max.backup.files = 5
  ,create.folders = T
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = "waRRior.snippets.backup_file" #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,...){
  tryCatch({
     
    #Actual Function code
    if(verbose) cat("waRRior: backing up file",file,"to",destination, "\n")
    files.in.backup.location <- sort(list.files(destination, pattern=identifier))
    if(verbose)cat("waRRior: files in backup location matching the identifier\n")
    if(verbose){
      for(file in files.in.backup.location) cat("\t*",file,"\n")
    }
    nr.files.in.backup.location <- length(files.in.backup.location)
    if(verbose)cat("waRRior: total number of files", nr.files.in.backup.location,"\n")
    
    while(nr.files.in.backup.location >= max.backup.files){
      if(verbose)cat("waRRior: deleting previous backup file",files.in.backup.location[1],"due to max.backup.files restriction (max files:",max.backup.files,"\n")
      file.remove(paste(destination,files.in.backup.location[1],sep =""))
    }
    backup.file.name <- paste(Sys.time,identifier,sep = "_")
    backup.file.path <- paste(destination, backup.file.name, sep = "/")
    if(verbose)cat("waRRior: creating backup",backup.file.name,"\n")
    file.copy(file, backup.file.path)
    
    #define response
    response <- T
    
    #Success message
    if(verbose) cat('waRRior:',function.id,'success\n')
    
    #Return response
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
