
waRRior.machinelearning.datapreparation.dynamic_data_evaluation <- function(df, as.dplyr = t){
  par(lwd = 3)
  save.df <- function(){
      b <- readline("do you want to save the df? (y/n)")
      if(b == "y"){
        p <- readline("please indicate path:")
        save(df, file = p)
      }
  }
  v.scaled = c()
  df <- as.data.frame(df)
  waRRior.snippets.verbose("dimensions:")
  print(dim(df))
  waRRior.snippets.verbose("press key to cycle through collumns.")
  readline()
  readline()
  for(col in names(df)){
    user.input <- ""
    while(user.input != "n"){
      cat("---\n\n")
      waRRior.snippets.verbose(col)

      user.input <- readline("action ('H' = help):")
      tryCatch({
        switch(user.input
          ,p = print(df[,col])
          ,t = print(table(df[,col]))
          ,s = print(summary(df[,col]))
          ,n = waRRior.snippets.verbose("...next...")
          ,b = {
            barplot(table(df[,col]), col = google.colors$Indigo$accent[1], border = google.colors$Indigo$accent[4], lwd = 3, las = 2, cex.names = 0.7)
          }
          ,h = {
            hist(df[,col], col = google.colors$Indigo$accent[1], border = google.colors$Indigo$accent[4], lwd = 3, main = NA, xlab = col)
          }
          ,c = print(class(unlist(df[1,col])))
          ,r = {
            waRRior.snippets.verbose("convert class to?\n('c' = character,'n' = numeric,'f' = factor,'l' = logical, 'd' = date or 'a' = abort")
            as.what <- readline()
            df[,col] <- switch(as.what
              ,c = as.character(df[,col])
              ,n = as.numeric(df[,col])
              ,f = as.factor(df[,col]) 
              ,l = as.logical(df[,col])
              ,d = as.Date(df[,col])
              ,a = df[,col]  
            )
          }
          ,e = return(df)
          ,x = {names(df) <- gsub(col,paste(col,"exclude",sep = "_"),names(df))
                print(names(df))
               }
           ,log = {
              v.scales = c(v.scaled,col)
              df[,col] <- log(df[,col])
            }         
          ,low = {names(df) <- gsub(col,paste(col,"low_importance",sep = "_"),names(df))
                print(names(df))
               }
          ,high = {names(df) <- gsub(col,paste(col,"high_importance",sep = "_"),names(df))
                print(names(df))
               }
          ,q = {
            qqnorm(df[,col],pch = 20,col = google.colors$Indigo$accent[4])
            abline(1,1)
          }
          ,S = save.df()
          ,z = {
              v.scales = c(v.scaled,col)
              df[,col] <- scale(df[,col])
            }
          ,m = dev.off()
          ,H = {waRRior.snippets.verbose("HELP
              ,'p'    = print
              ,'t'    = print table
              ,'s'    = print summary
              ,'n'    = next collumn
              ,'b'    = barplot
              ,'c'    = print class
              ,'r'    = recode calss
              ,'e'    = exit and return df
              ,'x'    = mark for exclusion
              ,'S'    = save
              ,'z'    = z transform
              ,'b'    = qq plot normal distribution
              ,'m'    = close plot
              ,'low'  = low importance
              ,'high' = high importance
              ,'log'  = log transoform"
          )}
          )
        }, error = function(e){print(e)})
    }
  }
  save.df()
  waRRior.snippets.verbose("variables that have been scaled:")
  print(v.scaled)
  if(as.dplyr){
    require(dplyr)
    return(tbl_df(df))
  }
  return(df)
}
