
waRRior.machinelearning.datapreparation.dynamic_data_evaluation <- function(df, as.dplyr = t){
  #Style
  par(lwd = 3)
  dev.off()
  #Functions
  save.df <- function(){
      b <- readline("do you want to save the df? (y/n)")
      if(b == "y"){
        p <- readline("please indicate path:")
        save(df, file = p)
      }
  }
  #Variables
  variables.output = c()
  variables.input = c()
  variables.input.high.importance = c()
  variables.input.low.importance = c()
  variables.scaled = c()
  variables.logtransformed = c()
  variables.exclude = c()

  df <- as.data.frame(df)
  waRRior.snippets.verbose("dimensions:")
  print(dim(df))

  waRRior.snippets.verbose("press key to cycle through collumns.")
  readline()

  for(col in names(df)){
    user.input <- ""
    while(user.input != "n"){
      cat("---\n\n")
      waRRior.snippets.verbose(col)

      user.input <- readline("action ('H' = help):")
      tryCatch({
        switch(user.input
          #Inspect
          ,p = print(df[,col])
          ,t = print(table(df[,col]))
          ,s = print(summary(df[,col]))
          ,b = {
            barplot(table(df[,col]), col = google.colors$Indigo$accent[1], border = google.colors$Indigo$accent[4], lwd = 3, las = 2, cex.names = 0.7)
          }
          ,h = {
            hist(df[,col], col = google.colors$Indigo$accent[1], border = google.colors$Indigo$accent[4], lwd = 3, main = NA, xlab = col)
          }
          ,a = {
            tmp <- df[,col]
            tmp.log <- log(df[,col])
            tmp.z <- scale(df[,col])
            tmp.log.z <- scale(tmp.log)

            dev.new(width = 12, height = 6)
            par(mfrow = c(2,4))
            tmp.plot <- function(x, x.title){
              hist(x, col = google.colors$Indigo$accent[1], border = google.colors$Indigo$accent[4], lwd = 3, main = col, xlab = col)
              qqnorm(x,pch = 20,col = google.colors$Indigo$accent[4], main = x.title)
              qqline(x)
            }
            tmp.plot(tmp, "Vanilla")
            tmp.plot(tmp.log, "Log transformed")
            tmp.plot(tmp.z, "Z scaled")
            tmp.plot(tmp.log.z, "Log transformed and z scaled")            
          }
          ,c = print(class(unlist(df[1,col])))
          ,q = {
            qqnorm(df[,col],pch = 20,col = google.colors$Indigo$accent[4])
            qqline(df[,col])
          }
          #Modify
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
          ,x = {
            variables.exclude = c(variables.exclude, col)
            waRRior.snippets.verbose("excluded variables:")
            print(variables.exclude)
            user.input = 'n'    
          }
          ,l = {
            variables.logtransformed = c(variables.logtransformed, col)
            df[,col] <- log(df[,col])
            waRRior.snippets.verbose("log transformed variables:")
            print(variables.logtransformed)            
          } 
          ,z = {
            variables.scaled = c(variables.scaled, col)
            df[,col] <- scale(df[,col])
            waRRior.snippets.verbose("scaled input variables:")
            print(variables.scaled)            
          }        
          ,low = {
            variables.input = c(variables.input, col)
            variables.input.low.importance = c(jvariables.input.low.importance, col)
            waRRior.snippets.verbose("low importance input variables:")
            print(variables.input.low.importance)
          }
          ,high = {
            variables.input = c(variables.input, col)
            variables.input.high.importance = c(variables.input.high.importance, col)
            waRRior.snippets.verbose("high importance input variables:")
            print(variables.input.high.importance)
          }
          ,out = {
            variables.output = c(variables.output, col)
            waRRior.snippets.verbose("output variables:")
            print(variables.output)
          }
          #Controls
          ,n = waRRior.snippets.verbose("...next...")
          ,e = return(df)
          ,S = save.df()
          ,m = dev.off()
          ,H = {waRRior.snippets.verbose("
            HELP
            
            Inspection:
            'p'    = print
            't'    = print table
            's'    = print summary
            'c'    = print class
            'b'    = barplot
            'q'    = qq plot normal distribution

            Modify:
            'r'    = recode class
            'z'    = z transform
            'l'    = log transoform

            Classification:
            'x'    = mark for exclusion
            'out'  = output variable
            'low'  = low importance
            'high' = high importance

            Controls:
            'n'    = next collumn
            'm'    = close plot
            'S'    = save
            'e'    = exit and return df

            "
          )}
          )
        }, error = function(e){print(e)})
    }
  }

  save.df()

  if(as.dplyr){
    require(dplyr)
    df <- tbl_df(df)
  }

  return(list(
     data = df
    ,variables.output = unique(variables.output)
    ,variables.input = unique(variables.input)
    ,variables.input.high.importance = unique(variables.input.high.importance)
    ,variables.input.low.importance = unique(variables.input.low.importance)
    ,variables.scaled = unique(variables.scaled)
    ,variables.logtransformed = unique(variables.logtransformed)
    ,varibales.exclude = unique(varibales.exclude)
  ))
}
