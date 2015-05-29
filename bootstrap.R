cat("
\n**********************************
\n** waRRior v0.1 is being loaded **
\n**********************************
\n")

files.to.be.loaded.on.startup <- list(
  #Libraries
   "https://raw.githubusercontent.com/joelgsponer/waRRior/master/libraries/waRRior.libraries.startup.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/libraries/waRRior.libraries.checkPkg.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/libraries/waRRior.libraries.install.R" #depends on checkPkg
  #General
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/refresh.R"
  #Github
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/github/read/data/waRRior.github.read.data.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/github/read/code/waRRior.github.read.code.R"
  #Google
  ##Colors
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/google/colors/waRRior.google.colors.load.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/google/colors/waRRior.google.colors.accents.R"
  #Statistics
  ##General
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/statistics/general/warrior.statistics.general.ptostars.R"
  ##Views
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/statistics/views/waRRior.statistics.views.barplot.R"
  ##Survival
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/statistics/survival/waRRior.statistics.survival.cutoff.R"
  #Bioinformatics
  ##aCGH
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/bioinformatics/acgh/waRRior.bioinformatics.acgh.nowaves.R"
  ##Flowcytometry
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/bioinformatics/flowcytomety/waRRior.bioinformatics.flowcytometry.color_cell_cycle.R"
  ##Genomics
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/bioinformatics/genomics/waRRior.bioinformatics.genomics.display_cytoband.R"
  #Snippets
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.close_all_graphic_devices.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.backup_file.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.verbose.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.make_color_transparent.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.create_random_string.R"
  #Plotting
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/plot/waRRior.plot.connect_points_with_bezier.R"
  #Databases
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/databases/sqlite/waRRior.databases.sqlite.is_field_present.R"
  ,"https://github.com/joelgsponer/waRRior/blob/master/databases/sqlite/waRRior.databases.sqlite.add_field.R"
  #Machine Learning
  ##Genetic algorithm
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/geneticalgorithm/waRRior.machinelearning.geneticalgorithm.individual.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/geneticalgorithm/waRRior.machinelearning.geneticalgorithm.crossover.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/geneticalgorithm/waRRior.machinelearning.geneticalgorithm.mating.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/geneticalgorithm/waRRior.machinelearning.geneticalgorithm.mutation.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/geneticalgorithm/waRRior.machinelearning.geneticalgorithm.run.R"
)

source_https <- function(url, ...) {
  # load package
  require(RCurl)
 
  # parse and evaluate each .R script
  sapply(c(url, ...), function(u) {
    eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
  })
}
source_https("https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.verbose.R")
waRRior.snippets.verbose("Loading files:", verbose_ = T)
for(f in files.to.be.loaded.on.startup){
  tryCatch({
    source_https(f)
    function.id <- unlist(strsplit(f,"/"))
    function.id <- function.id[length(function.id)]
    waRRior.snippets.verbose(paste("\t*",function.id, "\n"))
    },
    error = function(e, f_ = f){
     cat(sprintf("\nwaRRior: ERROR loading %s !!!!!!!\n", f_))
     print(e)
     })
}


waRRior.snippets.verbose("waRRior is ready!", verbose_ = T)
