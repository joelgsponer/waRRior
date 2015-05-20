setClass("waRRior.machinelearning.geneticalgorithm.individual",
  ,slots = c(
     name       = "character"
    ,chr        = "list"
    ,score      = "numeric"
  )
) 

setMethod("show", "waRRior.machinelearning.geneticalgorithm.individual", function(object){
  cat("--- Individual ---\n")
  cat("Name : ",object@name,"\n")
  cat("---\n")
  for(i in seq(1,length(object@chr))){
    cat(names(object@chr)[i],": ",object@chr[[i]], "\n")
  }
  cat("---\n")
  cat("Score : ",object@score,"\n")
  cat("---\n")
})

waRRior.machinelearning.geneticalgorithm.create_individual <- function(
   name = character(0)
  ,chr
  ,score = numeric(0) 
  ,create.random.name = F
){
  newIndividual <- new("waRRior.machinelearning.geneticalgorithm.individual")
  if(create.random.name){
    name <- waRRior.snippets.create_random_string(2)
  }
  newIndividual@name <- name
  newIndividual@chr <- chr
  newIndividual@score <- score  
  return(newIndividual)
}
