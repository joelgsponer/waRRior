waRRior.snippets.create_random_string <- function(n){
  return(paste(sample(c(0:9, letters, LETTERS), 10, replace = T),collapse = ""))
}
