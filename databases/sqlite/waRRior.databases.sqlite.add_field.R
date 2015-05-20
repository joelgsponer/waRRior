#This function adds a field to the designated database and field if it does not yet exist (depends on dbCheckFields)
waRRior.databases.sqlite.add_field <- function(
   db
  ,field
  ,table
  ,type
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = 'waRRior.databases.sqlite.add_field' #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,debug = F #Turn debug messages on and off
  ,...){
  tryCatch({
    t <- Sys.time() 
    #Actual Function code
    if(!(waRRior.databases.sqlite.is_field_present(db, table, field))){
      dbSendQuery(conn = db,paste("ALTER TABLE", table, "ADD", field, type))
      r <- T
      waRRior.snippets.verbose(paste('field',field,'added to table',table,'(type',type,')'), verbose_ = verbose)
    }else{
      waRRior.snippets.verbose(paste('field',field,'already present in table'), verbose_ = verbose)
      r <- F
    }
    
    #define response
    response <- list(
       result <- r
      ,message <- paste(function.id, 'success')
      ,error = 0
      ,e = NULL
      ,time.elapsed = as.numeric(difftime(Sys.time(), t), units = "secs")
    )
    
    #Success message
    waRRior.snippets.verbose(paste(function.id,'success'), verbose = verbose_)
    
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
