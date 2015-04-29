  require(plyr)
  mapcolors <- function(x, j){

    choosecolor <- function(x){
      tryCatch({
      if(x < 0) return(deletions.color)
      if(x > 0) return(amplifcations.color)
      if(x >= lbound & x <= ubound) return('white')
      }, error = function(e){return(error.color)})
    }
    col <- choosecolor(x)
    print(col)
    a <- ifelse(abs(x/limits[2]) > 1,1,abs(x/limits[2]))
    if(is.na(a)) a <- 1
    print(a)
    return(util_makeTransparent(
      col
      , alpha = a
      )
    )
  }
