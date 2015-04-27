waRRior.bioinformatics.acgh.nowaves <- function(
   input
  ,do.dplyr =T #Return result in dplyr's tbl_df
  ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
  ,function.id = "waRRior.bioinformatics.acgh.nowaves" #Use this to identfy the function in error (or success messages if applicable) messages.
  ,verbose = T #Turn messages on and off
  ,...){
  tryCatch({
     
    #Actual Function code
    require(NoWaves)
	
	  CGHTumor <- data.frame(input$probe, input$chr, input$start, input$log2ratio)
  	names(CGHTumor) <- c("Name", "Chr", "Position", "M.observed")
	
	  if (is.na(calibrationFile) == TRUE){
	  	calibrationFile = paste(sourceFolder,"/Annotation/Agilent180KCalibration.Rdata", sep = "")
  	} 
	
  	if(exists("NormalSmooth") == FALSE){
	  	load(calibrationFile)
	  	NormalSmooth <- SmoothNormals(CGHNormal, bandwidth = bandwidth)
		  assign("NormalSmooth", NormalSmooth, envir = globalenv())
  	}
  	cormat <- CorTumNorm(CGHTumor, NormalSmooth)
	  if(verbose)cat("waRRior: correlation matrix");print(cormat)
  	correctedInput <- CorrectTumors(CGHTumor, NormalSmooth)
  	
    #define response
    response <- correctedInput
    
    #Success message
    if(verbose) cat('waRRior:',function.id,'success)
    
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
