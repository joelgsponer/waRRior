waRRior.snippets.close_all_graphic_devices <- function(verbose = F){
  tryCatch({
      while(T) dev.off()
    },error = function(e){cat('waRRior: closed all graphic devices. \n')})
}
