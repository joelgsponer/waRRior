
waRRior.snippets.backup_file <- function(
   file
  ,destination
  ,identifier = "UNKNOWN"
  ,max.backup.files = 5
  ,create.folders = T
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = "waRRior.snippets.backup_file" #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,debug = F
  ,...){
  tryCatch({
     
    #Actual Function code
    
    if(verbose) cat("waRRior: backing up file",file,"to",destination, "\n")
    files.in.backup.location <- sort(list.files(destination, pattern=identifier))
    if(verbose)cat("waRRior: files in backup location matching the identifier\n")
    if(verbose){
      for(f in files.in.backup.location) cat("\t*",f,"\n")
    }
    nr.files.in.backup.location <- length(files.in.backup.location)
    if(verbose)cat("waRRior: total number of files", nr.files.in.backup.location,"\n")
    
    while(nr.files.in.backup.location >= max.backup.files){
      if(verbose)cat("waRRior: deleting previous backup file",files.in.backup.location[1],"due to max.backup.files restriction (max files:",max.backup.files,"\n")
      res.file.remove <- file.remove(paste(destination,files.in.backup.location[1],sep ="/"))
      if(debug)print(res.file.remove)
      if(!(res.file.remove))stop("Error while deleting files")
      files.in.backup.location <- sort(list.files(destination, pattern=identifier))
      nr.files.in.backup.location <- length(files.in.backup.location)
    }
    
    backup.file.name <- gsub(" ","_",paste(Sys.time(),identifier,sep = "_"))
    backup.file.name <- gsub(":","_",backup.file.name)
    if(debug)print(backup.file.name)
    if(debug)print(file)
    backup.file.ending <- unlist(strsplit(file,"[.]"))[length(unlist(strsplit(file,"[.]")))]
    if(debug)print(backup.file.ending)
    backup.file.name <- paste(backup.file.name,backup.file.ending,sep = ".")
    if(debug)print(backup.file.name)
    
    backup.file.path <- paste(destination, backup.file.name, sep = "/")
    if(verbose)cat("waRRior: creating backup",backup.file.path,"\n")
    res.file.copy <- file.copy(file, backup.file.path)
    if(debug)print(res.file.copy)
    if(!(res.file.copy))stop("Error while copying files")
    
    #define response
    response <- list(
       message <- "Backup created"
      ,error = 0
      ,e = NA
    )
    
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
