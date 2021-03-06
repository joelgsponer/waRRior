cat("
\n**********************************
\n** waRRior v0.1 is being loaded **
\n**********************************
\n")

source_https <- function(url, ...) {
  # load package
  require(RCurl)

  # parse and evaluate each .R script
  sapply(c(url, ...), function(u) {
    eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
  })
}

waRRior.files.to.be.loaded.on.startup <- list(
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
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.debug.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.make_color_transparent.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.create_random_string.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.source_folder.R"
  #Plotting
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/plot/waRRior.plot.connect_points_with_bezier.R"
  #Databases
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/databases/sqlite/waRRior.databases.sqlite.is_field_present.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/databases/sqlite/waRRior.databases.sqlite.add_field.R"
  #Machine Learning
  ##Data preparation
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/datapreparation/waRRior.machinelearning.datapreparation.dynamic_data_evaluation.R"
  ##Genetic algorithm
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/geneticalgorithm/waRRior.machinelearning.geneticalgorithm.individual.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/geneticalgorithm/waRRior.machinelearning.geneticalgorithm.crossover.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/geneticalgorithm/waRRior.machinelearning.geneticalgorithm.mating.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/geneticalgorithm/waRRior.machinelearning.geneticalgorithm.mutation.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/geneticalgorithm/waRRior.machinelearning.geneticalgorithm.run.R"
  ##h2o
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/h2o/waRRior.machinelearning.h2o.ga_gbm.R"
  ,"https://raw.githubusercontent.com/joelgsponer/waRRior/master/machinelearning/h2o/h2o_helpers.R"
)

if(exists('waRRior.local.path')){
  source(paste(waRRior.local.path,"/snippets/waRRior.snippets.verbose.R", sep = ""))
  waRRior.files.to.be.loaded.on.startup <- gsub("https://raw.githubusercontent.com/joelgsponer/waRRior/master", waRRior.local.path, waRRior.files.to.be.loaded.on.startup)
  waRRior.snippets.verbose("Loading files locally:", verbose_ = T)
  for(f in waRRior.files.to.be.loaded.on.startup){
    tryCatch({
      source(f)
      function.id <- unlist(strsplit(f,"/"))
      function.id <- function.id[length(function.id)]
      waRRior.snippets.verbose(paste("\t*",function.id), verbose_ = T)
      },
      error = function(e, f_ = f){
       waRRior.snippets.verbose(sprintf("ERROR loading %s", f_))
       print(e)
       })
  }
}else{
  source_https("https://raw.githubusercontent.com/joelgsponer/waRRior/master/snippets/waRRior.snippets.verbose.R")
  waRRior.snippets.verbose("Loading files:", verbose_ = T)
  for(f in waRRior.files.to.be.loaded.on.startup){
    tryCatch({
      source_https(f)
      function.id <- unlist(strsplit(f,"/"))
      function.id <- function.id[length(function.id)]
      waRRior.snippets.verbose(paste("\t*",function.id), verbose_ = T)
      },
      error = function(e, f_ = f){
       waRRior.snippets.verbose(sprintf("ERROR loading %s", f_))
       print(e)
       })
  }
}

waRRior.snippets.verbose("ready!", verbose_ = T)
