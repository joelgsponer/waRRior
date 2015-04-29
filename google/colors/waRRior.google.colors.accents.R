waRRior.google.colors.accents <- function(level = 4, shuffle = F, show = F){
	if(exists("google.colors")){
	  r <- c()
	  for(i in seq(1,length(google.colors))){
	  	r <- c(r, google.colors[[i]]$accent[level])
	  }
	  if(shuffle) r <- sample(r)
	  if(show)par(mar = c(4,8,4,4));barplot(rep(1,16), col = r, names = paste(seq(1,16), r), las = 2, horiz = T, xaxt = "n")
	  return(r)
	}else{
	  stop("google colors have not been loaded.")
	}
}
