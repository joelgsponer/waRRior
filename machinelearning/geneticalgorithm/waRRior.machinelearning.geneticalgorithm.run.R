waRRior.machinelearning.geneticalgorithm.run <- function(
   chr.init
  ,evaluate.function
  ,train.data
  ,validation.data = NA
  ,test.data = NA
  ,genes.class = list("integer")
  ,genes.range = list(c(1,100))
  ,population.size = 10
  ,mutation.frequency = 0.1
  ,generation.maximum = 1000
  ,keep.best = T #keep the best individual untouched
  ,higher.score = T
  ,plot.scores.history =  T
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = "waRRior.machinelearning.geneticalgorithm.run" #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = F #Turn messages on and off
  ,simpleReturn = F
  ,debug = T #Turn debug messages on and off
  ,plot.logscale = F
  ,save.population = T
  ,save.population.path = NA
  ,...){
  tryCatch({
    t <- Sys.time() 
    #Actual Function code
    
    #Initalization
    scores.history <- c()
    if(is.na(save.population.path)) save.population.path <- paste("GA-",population.size,"-",Sys.Date(), ".Rdata", sep = "")
    population <- list()
    par(lwd = 1)
    waRRior.snippets.verbose("creating intial population", verbose_ = verbose)
    for(i in seq(1, population.size)){
      population <- c(population, waRRior.machinelearning.geneticalgorithm.create_individual(
         chr = waRRior.machinelearning.geneticalgorithm.mutation(
            chr.init
           ,mutation.frequency = 1
           ,genes.class = genes.class
           ,genes.range = genes.range
           ,verbose = verbose
           ,debug = debug
          ) 
        ,create.random.name=T
        )
      )  
    }    
    waRRior.snippets.verbose("evaluating intial population", verbose_ = verbose)
    for(i in seq(1, population.size)){
      s <- evaluate.function(population[[i]], train.data, validation.data,test.data,...)
      population[[i]]@score <- s
    }
    
    #Loop
    generation <- 1
    while(generation <= generation.maximum){
      waRRior.snippets.verbose(paste("generation:",generation), verbose_ = verbose)
      scores <- unlist(lapply(population, function(x){x@score}))
      scores[scores == Inf | scores == -Inf] <- NA
      o <- order(scores)
      if(higher.score)o <- rev(order(scores))
      best.individual <- population[[o[1]]]
      if(debug)print(best.individual@score)
      waRRior.snippets.verbose(paste("best score:",scores[o[1]]), verbose_ = verbose)
      mating_pool <- waRRior.machinelearning.geneticalgorithm.mating(o)

      old_population <- population
      scores.history <- c(scores.history, scores[o[1]])

    if(plot.scores.history){
      if(plot.logscale)plot(log(scores.history,10),col = google.colors$DeepOrange$main, type = "l", main = scores[o[1]], cex = 0.5, xlim = c(0,generation.maximum))
      else plot(scores.history,col = google.colors$DeepOrange$main, type = "l", main = scores[o[1]], cex = 0.5, xlim = c(0,generation.maximum))
    }
    
    #Generate new Population/Generation
    population <- list()

    for(i in seq(1, population.size)){
    
      #Define Mother and Father    
      mother <- sample(mating_pool,1)
      if(debug){
        print("Mother:")
        print(mother)
      }
      father <- sample(mating_pool,1)
      if(debug){
        print("Father")
        print(father)
      }
      
      #Mutation and Crossover
      new_chr <- waRRior.machinelearning.geneticalgorithm.crossover(
                   old_population[[mother]]@chr
                   ,old_population[[father]]@chr
                   ,verbose = verbose
                   ,debug = debug
                   ,simpleReturn = T
                   )
      new_chr <- waRRior.machinelearning.geneticalgorithm.mutation(new_chr
                   ,mutation.frequency = mutation.frequency
                   ,verbose = verbose
                   ,debug = debug
                   ,simpleReturn = T
                   ,genes.class = genes.class
                   ,genes.range = genes.range
                  )
      
      #Generate Individuum
      population <- c(population, waRRior.machinelearning.geneticalgorithm.create_individual(
         chr = new_chr
        ,name=old_population[[father]]@name
        )
      )  
    }
    if(keep.best) old_population[[1]] <- best.individual
    for(i in seq(1, population.size)){
      s <- evaluate.function(population[[i]], train.data,validation.data,test.data,...)
      population[[i]]@score <- s
    }
      if(save.population) save(population, file = save.population.path)
      generation <- generation + 1
    }

    scores <- unlist(lapply(population, function(x){x@score}))
    scores[scores == Inf | scores == -Inf] <- NA
    o <- order(scores)
    if(higher.score)o <- rev(order(scores))
    
    #define response
    if(simpleReturn)return(population[o[1]])
    response <- list(
       population <- population[o[1]]
      ,scores <- scores
      ,message <- paste(function.id, 'success')
      ,error = 0
      ,e = NULL
      ,time.elapsed = as.numeric(difftime(Sys.time(), t), units = "secs")
    )
    
    #Success message
    waRRior.snippets.verbose(paste(function.id,'success'), verbose_ = verbose)
    
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
        if(debug)print(population)
        stop(e)
      }
     }
  )
}
