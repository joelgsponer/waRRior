waRRior.statistics.views.barplot <- function(
   x
  ,y
  ,margin = 1
  ,is.percent = T
  ,threshold = 1
  ,color.fill = NA
  ,color.text = "red"
  ,color.border = "black"
  ,is.statistical.test = T
  ,ylim = NULL
  ,digits = 1
  ,legend.text = NA
  ,verbose = F
  ,...
){
  tab <- table(x,y)
  tab_n <- tab
  if(is.percent)tab = prop.table(tab, margin) * 100
  if(is.na(legend.text)) legend.text = rownames(tab)
  
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
	     if(verbose)print(mids)
	     if(is.null(ylim) == F) mids[1] <-  (ylim[1] + csum[2]) / 2
	     if(verbose)print(mids)
	     text(bar[i], mids, ifelse(tab[,i] > threshold, paste(round(tab[,i],digits),"%"), NA), cex = 1.5, font = 2, col = color.text)  
     }
    if(is.null(ylim) == F){
	         par(xpd = T)
	         text(bar, ylim[1] , "==>", srt = 270, cex = 0.8, font = 1)
	         
	}
	par(xpd = T) 
	legend(bar[length(bar)] + 0.8, max(tab, na.rm = T)/100*25, legend = legend.text, cex = 0.9, fill = color.fill)
	par(xpd = F)
    if(is.statistical.test){
      print(tab_n)
      if(dim(tab_n)[1]==2 & dim(tab_n)[2]==2){
        print(fisher.test(tab_n))
      }else{
        print(chisq.test(tab_n))
      }
    }
    return(bar)
}
