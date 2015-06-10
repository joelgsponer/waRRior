
waRRior.machinelearning.h2o.ga_gbm <- function(
   response
  ,predictors
  ,h2oServer
  ,train_hex
  ,valid_hex
  ,test_hex
  ,feature.selection = T
  ,...
  ){

  evaluate_gbm <- function(
     object
    ,train_hex
    ,valid_hex
    ,test_hex
    ,response_ = response
    ,predictors_ = predictors
    ,feature.selection_ = feature.selection
  ){
    #Function code
    if(feature.selection_) predictors_ <-  predictors_[as.logical(object@chr[seq(1,length(predictors_))])]
    model <- h2o.gbm(
       x = predictors_
      ,y = response_
      ,data = train_hex
      ,distribution = object@chr$distribution
      ,n.trees = as.numeric(object@chr$n.trees)
      ,interaction.depth = as.numeric(object@chr$interaction.depth)
      ,n.minobsinnode = as.numeric(object@chr$n.minobsinnode)
      ,shrinkage = as.numeric(object@chr$shrinkage)
      ,n.bins = as.numeric(object@chr$n.bins)
      ,importance = F
      #,nfolds = 2
      ,validation = valid_hex
      #,balance.classes = F
      ,max.after.balance.size = as.numeric(object@chr$max.after.balance.size)
    )
    score <- h2o.get_auc(model, test_hex, response = response_, debug = F)
    #Retrun Score
    return(score)
  }

  if(feature.selection)chr.predictors <- as.list(sample(c(F,T), length(predictors), replace = T))
  chr <- list(
     n.trees = 5
    ,interaction.depth = 5
    ,n.minobsinnode = 10
    ,n.bins = 20
    ,max.after.balance.size = 5
    ,distribution = "multinomial"
    ,shrinkage = 0.1
  )
  if(feature.selection) chr <- c(chr.predictors, chr)

  if(feature.selection)genes.class.predictors <- as.list(rep("boolean", length(predictors)))
  genes.class <- list(
     "integer"
    ,"integer"
    ,"integer"
    ,"integer"
    ,"integer"
    ,"class"
    ,"float"
  )
  if(feature.selection)genes.class <- c(genes.class.predictors, genes.class)

  if(feature.selection)genes.range.predictors <- as.list(rep(T, length(predictors)))
  genes.range <- list(
    c(1,100)
   ,c(1,100)
   ,c(1,100)
   ,c(2,1000)
   ,c(1,100)
   ,c("multinomial","gaussian")
   ,c(0,1)
  )
  if(feature.selection)genes.range <- c(genes.range.predictors, genes.range)
  pop <- waRRior.machinelearning.geneticalgorithm.run(
     chr.init = chr
    ,genes.class = genes.class
    ,genes.range = genes.range
    ,train.data = train_hex
    ,validation.data = valid_hex
    ,test.data = test_hex
    ,evaluate.function = evaluate_gbm
    ,...
  ) 
}
