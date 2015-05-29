waRRior.libraries.checkPkg <- function(pkg){
  if(!is.element(pkg, installed.packages()[,1]))
    {
   waRRior.snippets.verbose("!",pkg,"not found - trying to install", verbose_ = T)
   install.packages(pkg, repos="http://cran.us.r-project.org")
  }else {waRRior.snippets.verbose("\t*",pkg,"library already installed\n", verbose_=T)}
}
