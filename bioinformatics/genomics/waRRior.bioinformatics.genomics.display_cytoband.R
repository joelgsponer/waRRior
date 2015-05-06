waRRior.bioinformatics.genomics.display_cytoband <- function(
   chr = 1
  ,create.plot = T
  ,color.bands = "black"
  ,color.centromere = "red"
  ,colo.border = "black"
  ,y.ubound = 1
  ,y.lbound = -1
  ,debug = T
){
  df <- waRRior.github.read.data("https://raw.githubusercontent.com/joelgsponer/annotate-it/master/bioinformatics/genomics/cytobandshg19.txt",do.dplyr = F,  sep = " ")
  if(debug)print(df)
  df <- df[as.numeric(as.character(df$chrnumeric)) == chr,]
  if(debug)print(df)
  if(create.plot)plot(1,1, xlim = range(c[,c(2,3)]), pch = NA, ylim = c(-5,5), ylab = NA, las = 2, xlab = NA)
  color.bands <- sapply(df$stain, FUN = function(x){waRRior.snippets.make_color_transparent(color.bands, alpha = x)})
  if(debug)print(color.bands)
  rect(
     df$start
    ,c(y.lbound)
    ,df$end
    ,c(y.ubound)
    ,col = color.bands
    ,border = color.border
  )
  df <- df[df$g == "acen",]
  if(debug)print(df)
  rect(
     df$start
    ,c(y.lbound)
    ,df$end
    ,c(y.ubound)
    ,col = color.centromere
    ,border = color.centromere)
}
