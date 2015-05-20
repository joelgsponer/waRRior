waRRior.machinelearning.geneticalgorithm.mating <- function(
   o
  ,drop.percent = 20
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = 'waRRior.machinelearning.genetic_algorithm.mating' #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,debug = F #Turn debug messages on and off
  ,simpleReturn = T
  ,...
){
  tryCatch({
    t <- Sys.time() 
    #Actual Function code
    nr_individuals <- length(o)
    waRRior.snippets.verbose(paste('nr of individuals:', nr_individuals), verbose_ = verbose)

    #drop
    o <- o[1:(nr_individuals - round((nr_individuals/100*drop.percent),0))]
    nr_individuals <- length(o)
    if(debug)print(o)
    w <- rev(round(pexp(seq(1,nr_individuals),1/nr_individuals, log = F)*100,0))
    if(debug)print(w)
    mating_pool <- rep(o,w)
        
    #define response
    response <- list(
       result <- as.list(mating_pool)
      ,message <- paste(function.id, 'success')
      ,error = 0
      ,e = NULL
      ,time.elapsed = as.numeric(difftime(Sys.time(), t), units = "secs")
    )
    
    #Success message
    waRRior.snippets.verbose(paste(function.id,'success'), verbose_ = verbose)
    
    #Return respond
    if(simpleReturn)return(mating_pool)
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
