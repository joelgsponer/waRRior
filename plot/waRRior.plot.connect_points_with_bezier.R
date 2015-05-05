waRRior.plot.connect_points_with_bezier <- function(
 values
,kappa = 0.5
,cols = goolgeColors.accent()
,verbose = F
,ybaseline = 0
,curve.height.min = 0.3
,curve.height.max = 3
,curve.lwd = 2
,allow.negative = T
){
	require(Hmisc)
	if(verbose)cat("poinst.connect.bezier v0.1:\n")
	if(verbose)cat("n datapoints:", dim(values)[1], "\n")
	if(length(cols) < dim(values)[1]){
		cat("expanding colors.\n")
		cols <- rep(cols, dim(values)[1])
	}
	if(verbose)cat("colors:", cols, "\n")
	i <- 1
    while(i < dim(values)[1]){
      if(verbose) cat("i:",i,"\n")
      x <- c(values[i,1],mean(c(values[i,2],values[i,1])), values[i,2])
      
      y <- c(ybaseline,(values[i,2] - values[i,1])*kappa, ybaseline)
      
      
      if(y[2] < curve.height.min & y[2] > 0) y[2]<- curve.height.min
      if(y[2] > curve.height.max & y[2] > 0) y[2]<- curve.height.max
      if(allow.negative){
        if(-1*y[2] < curve.height.min & y[2] < 0) y[2]<- -1 * curve.height.min
        if(-1*y[2] > curve.height.max & y[2] < 0) y[2]<- -1 * curve.height.max
      }else{
        if(y[2] < 0) y[2] <- -1*y[2]
      }
      if(verbose) cat("x:",x,"\n")
      if(verbose) cat("y:",y,"\n")
      if(verbose) points(x,y)
      points(bezier(x,y), type = "l", col = cols[i], lwd = curve.lwd)
      i <- i + 1
    }

}
