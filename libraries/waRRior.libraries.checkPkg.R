waRRior.libraries.checkPkg <- function(pkg){
  if(!is.element(pkg, installed.packages()[,1]))
    {
   cat("#!",pkg,"not found - trying to install")
   install.packages(pkg, repos="http://cran.us.r-project.org")
  }else {cat("#!",pkg,"library already installed\n")}
}
