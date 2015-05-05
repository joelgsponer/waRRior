waRRior.databases.sqlite.is_field_present <- function(db, table, field){
    Fields <- dbListFields(db, table)
    if(field %in% Fields){
        return(T)
    }else{return(F)}    
}
