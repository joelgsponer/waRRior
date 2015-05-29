waRRior.libraries.checkPkg <- function(pkg){
  if(!is.element(pkg, installed.packages()[,1]))
    {
   waRRior.snippets.verbose(paste("package",pkg,"not found - trying to install"), verbose_ = T)
   install.packages(pkg, repos="http://cran.rstudio.org")
  }else {waRRior.snippets.verbose(paste("\t*",pkg,"library already installed"), verbose_=T)}
}
