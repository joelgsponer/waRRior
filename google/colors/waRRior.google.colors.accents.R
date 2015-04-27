waRRior.google.colors.accents <- function(level = 4, shuffle = F){
	if(exists("google.colors")){
	  r <- c()
	  for(i in seq(1,length(google.colors))){
	  	r <- c(r, google.colors[[i]]$accent[level])
	  }
	  if(shuffle) r <- sample(r)
	  return(r)
	}else{
	  stop("google colors have not been loaded.")
	}
}
