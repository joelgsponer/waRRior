   waRRior.bioinformatics.flowcytometry.color_cell_cycle <- function(
      fcs.file
     ,destination
     ,channel = "PMT 9 Area"
     ,nr.peaks.to.color = 2
     ,colors.peaks = waRRior.google.colors.accents()[c(1,2)]
     ,color.histogram = "#000000FF"
     ,color.background = "#FFFFFFFF"
     ,color.lines = "#000000FF"
     ,breaks.histogram = 2000
     ,xlim = c(5000,35000)
     ,ylim = c(0,300)
     ,xstep.axis = 10000
     ,ystep.axis = 50
     ,image.format = "pdf"
     ,is.silent = F #it T supresses raising of errors, istead return a list with error information.
     ,function.id = "waRRior.bioinformatics.flowcytometry.color_cell_cycle" #Use this to identfy the function in error (or success messages if applicable) messages.
     ,verbose = T #Turn messages on and off
     ,debug = T #Turn debug messages on and off
     ,...){
     tryCatch({
       
       #Actual Function code
       require(flowCore)
       require(flowViz)
       
       if(length(colors.peaks) != nr.peaks.to.color){
         if(length(colors.peaks) == 1){
           colors.peaks <- rep(colors.peaks, nr.peaks.to.color)
           waRRior.snippets.verbose('expanding colors.')
         }else{
           stop('wrong number of colors.peaks. Has to be either 1 or equal to nr.peaks.to.color')
         }
       }
       
       x <- read.FCS(fcs.file, transformation=FALSE)
       x <- exprs(x)
       
       if(!(channel %in% colnames(x))){
         waRRior.snippets.verbose('designated channel is not present in the FCS file please choose one from the ones below:', verbose_ = verbose) 
         for(i in colnames(x)) cat("\t*",i,"\n")
       }
       
       h <- hist(x[,channel], xlab = NA, breaks=breaks.histogram, xlim = xlim, ylim = ylim)

       
       c <- rep(color.histogram, length(h$breaks))
       for(i in seq(1,nr.peaks.to.color)){
         l <- locator(2)
         c[h$breaks > l$x[1] & h$breaks < l$x[2]] <- colors.peaks[i]
       }
      waRRior.snippets.close_all_graphic_devices() 
   
     #Final histogram
     switch(image.format,
      png = png(file = destination,width = 3, height = 3, unit = "in", res = 600)
     ,pdf = pdf(file = destination,width = 3, height = 3)
     )
     par(
        mar = c(5,5,2,2)
       ,bg = color.background
       ,col = color.lines
       ,col.axis = color.lines
     )
     
     h <- hist(
        x[,channel]
       ,xlab = NA
       ,breaks=breaks.histogram
       ,xlim = xlim
       ,ylim = ylim
       ,xaxt = "n"
       ,yaxt = "n"
       ,ylab = NA
       ,main = NA
       ,col = c
       ,border = c
     )
     axis(1,seq(5000,100000000,xstep.axis), las = 2, col = color.lines)
     axis(2,seq(0, 1000000, ystep.axis), las = 2, col = color.lines)
     
     dev.off()
     waRRior.snippets.verbose(paste('image saved to', destination), verbose_ = verbose)
       
       #define response
       response <- list(
          result = h
         ,message = paste(function.id, 'success')
         ,error = 0
         ,e = NULL
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
