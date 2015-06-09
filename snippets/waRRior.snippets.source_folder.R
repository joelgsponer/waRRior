waRRior.snippets.source_folder <- function(path, lazy=F, verbose = T){
  waRRior.snippets.verbose(paste("loading files in folder:",path), verbose_ = verbose)
  for(file in list.files(path)){
    tryCatch({
      cat("\t*Loading",file,"\t\t|")
      source(paste(path, file, sep = "/"))
      cat("OK.\n")
    }, error = function(e){
      if(lazy){
        print(e)
      }else{
        stop(e)
      }      
    })
  }
}
 
