#Replace the github Version of waRRior with a local one to ensure updates do not break a working project
waRRior.bootstrap.local <- function(path="waRRior/"){
  cat("
    ***********************************
    ** local waRRior is being loaded **
    ***********************************
  ")

  cat("waRRior: cleaning the workspace.")
  rm(grep("waRRior.*",ls()))

  file.sources = list.files(pattern="waRRior/*.R")
  sapply(file.sources,source,.GlobalEnv)
