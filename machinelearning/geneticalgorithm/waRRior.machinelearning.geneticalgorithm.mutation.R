waRRior.machinelearning.geneticalgorithm.mutation   <- function(
   chr
  ,mutation.frequency = 0.01
  ,genes.class = list("integer")
  ,genes.range = list(c(0,100)) 
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = 'waRRior.machinelearning.genetic_algorithm.mutation' #Use this to identfy the function in error (or success messages if applicable) messages.
  ,simpleReturn = T
  ,verbose = F #Turn messages on and off
  ,debug = F #Turn debug messages on and off
  ,...
){
  tryCatch({
    if(!(simpleReturn))t <- Sys.time() 
    #Actual Function code
    nr_genes <- length(chr)
    waRRior.snippets.verbose(paste("number of genes:", nr_genes), verbose_ = verbose)
    waRRior.snippets.verbose(paste("number of classes:", length(genes.class)), verbose_ = verbose)
    if(debug)print(genes.class)
    waRRior.snippets.verbose(paste("number of ranges:", length(genes.range)), verbose_ = verbose)
    if(debug)print(genes.range)
    
    if(length(genes.class) != length(genes.range)) stop("nucleotides.class and nucleotides.range must have the same length (either 1 or equal to the number of genes)")
    if(length(genes.class) == 1 & length(genes.range) == 1 & nr_genes != 1){
       waRRior.snippets.verbose("expanding genes.class and genes genes.range.", verbose_ = verbose)
       genes.class_ <- genes.class
       for(i in seq(2, nr_genes))genes.class <- c(genes.class, genes.class_)
       if(debug)print(genes.class)
       genes.range_ <- genes.range
       for(i in seq(2, nr_genes))genes.range <- c(genes.range, genes.range_)
       if(debug)print(genes.range)
    }
    if((length(genes.class) != 1 | length(genes.range) != 1) & (length(genes.class) != nr_genes | length(genes.range) != nr_genes)) stop("genes.class and genes.range have to be either 1 or eual to to the number of genes")
    is.mutated <- rbinom(nr_genes, 1, mutation.frequency)
    if(debug)print(is.mutated)
    new_chr <- chr
    for(i in seq(1,nr_genes)){
      if(is.mutated[i]){
        new_chr[i] <- switch(genes.class[[i]][1],
             integer        = sample(seq(genes.range[[i]][1], genes.range[[i]][2], 1),1)
            ,boolean        = sample(c(F,T),1)
            ,float          = sample(runif(1, genes.range[[i]][1], genes.range[[i]][2]),1)
            ,class          = sample(genes.range[[i]],1)
            ,boolean_vector = {
              sample(c(F,T),size = 5, replace = T)
            }
         )
        if(debug)print("New chr:")
        if(debug)print(new_chr[i])
      }
    }
    if(debug)print(new_chr)
    #define response
    if(simpleReturn)return(as.list(new_chr))
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
