waRRior.snippets.close_all_graphic_devices <- function(verbose = F){
  tryCatch({
      while(T) dev.off()
    },error = function(e){
      waRRior.snippets.verbose('closed all graphic devices.', verbose_ = verbose)
    })
}
