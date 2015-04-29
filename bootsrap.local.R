#Replace the github Version of waRRior with a local one to ensure updates do not break a working project
waRRior.bootstrap.local <- function(path="waRRior/", verbose = T){
  if(verbose)cat("
    ***********************************
    ** local waRRior is being loaded **
    ***********************************\n
  ")

  if(verbose)cat("waRRior: cleaning the workspace.\n")
  rm(ls()[grep("waRRior", ls())])
  
  if(verbose)cat("waRRior: loading local files in path",path,".\n")
  file.sources = list.files(pattern=paste(path,"*.R",sep = "")
  sapply(file.sources,source,.GlobalEnv)
}
