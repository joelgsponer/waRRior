waRRior.machinelearning.geneticalgorithm.crossover <- function(
   #The chromosomes can be passed as a list.
   ...
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = 'waRRior.machinelearning.genetic_algorithm.crossover' #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,simpleReturn = T
  ,debug = F #Turn debug messages on and off
){
  tryCatch({
    t <- Sys.time() 
    #Actual Function code
    chrs <- list(...)

    
    nr_of_chrs <- length(chrs)
    waRRior.snippets.verbose(paste('nr of chromosomes:', nr_of_chrs), verbose_ = verbose)

    nr_of_genes <- length(chrs[[1]])
    
    mat <- matrix(unlist(chrs),nr_of_genes, nr_of_chrs)
    colnames(mat) <- names(chrs)
    rownames(mat) <- names(chrs[[1]])
    
    if(verbose){
    	waRRior.snippets.verbose('avaiable chromosomes:', verbose_ = verbose)
    	print(mat)  	
    }
    
    if(nr_of_genes != mean(unlist(lapply(chrs, FUN = length))))stop("chromosomes must have equal length (number of genes)")
    waRRior.snippets.verbose(paste('nr of genes:', nr_of_genes), verbose_ = verbose)
    
    
    new_chr <- apply(mat, 1, FUN = sample, size = 1) 
    if(debug) print(new_chr)
        
    #define response
    if(simpleReturn) return(as.list(new_chr))
    response <- list(
       result <- as.list(new_chr)
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