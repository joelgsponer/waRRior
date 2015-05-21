waRRior.machinelearning.geneticalgorithm.run <- function(
   chr.init
  ,evaluate.function
  ,test.data
  ,population.size = 10
  ,mutation.frequency = 0.1
  ,generation.maximum = 1000
  ,plot.scores.history =  T
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = "waRRior.machinelearning.geneticalgorithm.run" #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,simpleReturn = T
  ,debug = F #Turn debug messages on and off
  ,...){
  tryCatch({
    t <- Sys.time() 
    #Actual Function code
    
    #Initalization
    scores.history <- c()
    population <- list()
    par(lwd = 3)
    for(i in seq(1, population.size)){
      population <- c(population, waRRior.machinelearning.geneticalgorithm.create_individual(
         chr = waRRior.machinelearning.geneticalgorithm.mutation(chr.init
           ,mutation.frequency = 1
           ,verbose = F
          ) 
        ,create.random.name=T
        )
      )  
    }
    for(i in seq(1, population.size)){
      s <- evaluate.function(population[[i]], test.data)
      population[[i]]@score <- s
    }
    
    #Loop
    generation <- 1
    while(generation <= generation.maximum){
      scores <- unlist(lapply(population, function(x){x@score}))
      scores[scores == Inf | scores == -Inf] <- NA
      o <- order(scores)

      mating_pool <- waRRior.machinelearning.geneticalgorithm.mating(o)

      old_population <- population
      scores.history <- c(scores.history, min(scores, na.rm = T))

    if(plot.scores.history){
      plot(log(scores.history,10),col = google.colors$DeepOrange$main, type = "b", main = min(scores.history), cex = 0.5, xlim = c(0,generation.maximum))
    }
    population <- list()

    for(i in seq(1, population.size)){
      mother <- sample(mating_pool,1)
      father <- sample(mating_pool,1)

      new_chr <- waRRior.machinelearning.geneticalgorithm.crossover(old_population[[mother]]@chr, old_population[[father]]@chr, verbose = F, debug = F, simpleReturn = T)
      new_chr <- waRRior.machinelearning.geneticalgorithm.mutation(new_chr, mutation.frequency = mutation.frequency, verbose = F, debug = F, simpleReturn = T)

      population <- c(population, waRRior.machinelearning.geneticalgorithm.create_individual(
         chr = new_chr
        ,name=old_population[[father]]@name
        )
      )  
    }
    for(i in seq(1, population.size)){
      s <- evaluate.function(population[[i]], test.data)
      population[[i]]@score <- s
    }
      generation <- generation + 1
      waRRior.snippets.verbose(paste("generation:", generation), verbose_ = verbose)
    }

    scores <- unlist(lapply(population, function(x){x@score}))
    scores[scores == Inf | scores == -Inf] <- NA
    o <- order(scores)
    
    #define response
    if(simpleReturn)return(population[o[1]])
    response <- list(
       result <- population[o[1]]
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
