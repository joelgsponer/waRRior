waRRior.statistics.survival.cutoff <- function(
	 time
	,status
	,strataValue
	,step = NA
	,main = NA
	,cutoffs = NA
	,minPatients = 10
	,path = NA
	,LogRankScore = T
	,verbose = T
	,fileType = "png"
	,writeToDisk = T
	,colorSet = c("forestgreen", "darkblue")
	,decimalPoints = 5
	,borderColor = "black"
	,box.col = "black"
	,function.id= "waRRior.statistics.survival.cutoff"
	,...
){
	privCuts <- function(strataValue){
      cutoffs <- c()
      strataValue <- sort(strataValue)
      for(i in seq(1,length(strataValue))){
	    cutoffs <- c(cutoffs, (strataValue[i]+strataValue[i+1])/2)
      }
	  return(cutoffs)
    }

	if(verbose)cat("waRRior: calculating optimal survival cutoff. v1")
	if(verbose)cat("Stratification values:\n")
	if(verbose)print(summary(strataValue))

	require(survival)

	if(is.na(step)) step <- max(strataValue, na.rm = T) / 100
    if(verbose)cat('Step:',step,"\n")

	if(is.na(cutoffs)) cutoffs <- privCuts(strataValue)
	
    pvalues <- c()
	n1 <- c()
	n2 <- c()
	cuts <- c()
	scores <- c()


    for(i in seq(1, length(cutoffs))){
    	strat <- rep(0,length(strataValue))
		strat[strataValue > cutoffs[i]] <- 1

		tryCatch(
			{Surv1 <- Surv(time, status)
			 Fit1 <- survfit(Surv1 ~ strat)},
			 error = function(e){print(e)})
		sec1 <- tryCatch(
				{logrankTest <- survdiff(Surv1 ~ strat)
				 if(verbose > 2) print(logrankTest)
				 coxTest     <- coxph(Surv1 ~ strat)
	    		 p.val <- 1 - pchisq(logrankTest$chisq, length(logrankTest$n) - 1)
	    		 if(verbose > 1) print(p.val)
				 pvalues <- c(pvalues,p.val)
				 n1 <- c(n1,logrankTest$n[1])
				 n2 <- c(n2,logrankTest$n[2])

				 }, error=function(e){
				 					return(FALSE)})
		coxTest     <- coxph(Surv1 ~ strat)
		scores <- c(scores,coxTest$score)
		n1[i] <- table(strat)[1]
		n2[i] <- table(strat)[2]
		if(n1[i] < minPatients) sec1 <-  FALSE
		if(n2[i] < minPatients) sec1 <-  FALSE
		if(sec1 == FALSE){

			pvalues[i] <- 1
			n1[i] <- table(strat)[1]
			n2[i] <- table(strat)[2]
			scores[i] <- 0
			}
		cuts <- c(cuts,cutoffs[i])
		if(n2[i] <= minPatients) break
		if(verbose > 2) cat(".")

	}

	 cut <- cuts[pvalues == min(pvalues, rm.na = T)]
	 cut <- cut[1]

	 par(mfrow = c(2,1))
	 if(LogRankScore) par(mfrow = c(3,1))
	 plot(cuts
        , log(pvalues)
        , type = "l"
        , lwd = 2
        , col = "darkblue"
        , ylim = log(c(min(pvalues) - min(pvalues)/100*10,1))
        , main = paste(main, " Cutoff = ", cut, sep = "")
        , yaxt ="n"
        , xlab = 'Cutoff'
        )
	 axis(2
        , at = log(seq(1e-20,1,0.1))
        , labels = format(seq(1e-20,1,0.1))
        ,cex.axis = 0.4
        , las = 2
        )
	 abline(h = log(0.05)
          , lty = 3
          , col = "forestgreen"
          )
	 abline(v = cut
          , lty = 2
          , col = "red"
          )
	 plot(cuts
        ,n1
        , type = "l"
        ,lwd = 2
        , col = "red"
        , ylim = c(0, max(c(n1,n2), na.rm = T))
        , xlab = 'Cutoff'
        , ylab = "N"
        )

	 points(cuts, n2, type = "l", lwd = 2, col = "darkgreen")

	 abline(v = cut, lty = 2, col = "red")
	 if(LogRankScore == T){
     			plot(cuts,scores, type = 'l', lwd = 2, col = "magenta4", xlab = 'Cutoff', ylab = 'Logrank Score')
     			print('Scores:')
     			print(scores)
     			abline(v = cut, lty = 2, col = "red")
     }

	 strat <- rep(0,length(strataValue))
	 strat[strataValue > cut] <- 1

	 Surv1 <- Surv(time, status)

	 Fit1 <- survfit(Surv1 ~ strat)
	 dev.new()
	 par(...)
	 plot(Fit1, col = colorSet, lwd = 3, main = main)
	 legend(max(time, na.rm = T)-(max(time, na.rm = T)/100*25),0.2, fill = colorSet, legend = c(paste("Low:",n1[pvalues == min(pvalues)][1]),paste("High:",n2[pvalues == min(pvalues)][1])), border = borderColor, box.col = box.col)
	 test <- survdiff(Surv1 ~ strat)
	 if(verbose)print(test)
	 pVal <- format(1 - pchisq(test$chisq, length(test$n) - 1),5)
	 pVal <- paste(round(as.numeric(pVal), decimalPoints),sep = " ")
     text(max(time, na.rm = T)/100*40,0,paste("p-value = ", pVal," Logrank Score = ",round(max(scores,na.rm = T)[1],2)))

     if(verbose)cat('waRRior: optimal cutoff:', cut[1], '\n')

	return(pVal)
}
