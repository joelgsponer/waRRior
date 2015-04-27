waRRior.statistics.views.barplot <- function(
   tab
  ,threshold = 1
  ,color.fill = NA
  ,color.text = "red"
  ,color.border = "black"
  ,ylim = NULL
  ,digits = 1
  ,legendText = NA, ...
){
   par(mar = c(4,4,4,10), lwd = 2)
	 bar <- barplot(tab
     ,ylim = ylim
     ,col = color.fill
     ,ylab = "%"
     ,border = color.border
   )
  for(i in seq(1, dim(tab)[2])){
	  csum <- c(0,cumsum(tab[,i]))
	  mids <- c()
	
	  for(j in seq(1, length(csum) - 1)){
		    mids <- c(mids, (csum[j+1] + csum[j]) / 2) 
	     }
	     print(mids)
	     if(is.null(ylim) == F) mids[1] <-  (ylim[1] + csum[2]) / 2
	     print(mids)
	     text(bar[i], mids, ifelse(tab[,i] > threshold, paste(round(tab[,i],digits),"%"), NA), cex = 1.5, font = 2, col = color.text)  
     }
    if(is.null(ylim) == F){
	         par(xpd = T)
	         text(bar, ylim[1] , "==>", srt = 270, cex = 0.8, font = 1)
	         
	}
	par(xpd = T) 
	legend(bar[length(bar)] + 0.8, max(tab, na.rm = T)/100*25, legend = legendText, cex = 0.9, fill = color.fill)
	par(xpd = F)
    return(bar)

}
