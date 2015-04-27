warrior.statistics.general.ptostars <- function(pval){
	if(pval > 0.05) return("n.s.")
	else if(pval > 0.01) return("*")
	     else if(pval > 0.001) return("**")
	          else return("***")	
}
