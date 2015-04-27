waRRior.bioinformatics.acgh.nowaves <- function(
   input
  ,calibration.file = NA
  ,bandwidth = 1
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
	

	
  	if(exists("NormalSmooth") == FALSE){
	if (is.na(calibration.file)){
	  if(verbose)cat("waRRior: trying to download calibration file, as none was specified.\n")
	    calibration.file = getURL('http://raw.githubusercontent.com/joelgsponer/annotate-it/master/bioinformatics/cancer/acgh/Agilent180KCalibration.Rdata')
	}
	if(verbose)cat("waRRior: calibration file = ",calibration.file, "\n")
        load(calibration.file)
	waRRior.bioinfomatics.acgh.normalsmooth <- SmoothNormals(CGHNormal, bandwidth = bandwidth)
	assign("waRRior.bioinfomatics.acgh.normalsmooth", waRRior.bioinfomatics.acgh.normalsmooth, envir = globalenv())
  	}
  	cormat <- CorTumNorm(CGHTumor, waRRior.bioinfomatics.acgh.normalsmooth)
	if(verbose)cat("waRRior: correlation matrix");print(cormat)
  	correctedInput <- CorrectTumors(CGHTumor, waRRior.bioinfomatics.acgh.normalsmooth)
  	
    #define response
    response <- correctedInput
    
    #Success message
    if(verbose) cat('waRRior:',function.id,'success')
    
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
