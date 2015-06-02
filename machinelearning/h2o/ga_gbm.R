
response = coretable.cleaned.vanilla$variables.output[2]
predictors = coretable.cleaned.vanilla$variables.input

evaluate_gbm <- function(
   object
  ,train_hex
  ,valid_hex
  ,test_hex
  ,response_ = response
  ,predictors_ = predictors
){
  #Function code
  model <- h2o.gbm(
     x = predictors_[object@chr$variables.include]
    ,y = response_
    ,data = train_hex
    ,distribution = "multinomial"
    ,n.trees = object@chr$n.trees
    ,interaction.depth = object@chr$interaction.depth
    ,n.minobsinnode = 10
    ,shrinkage = 0.1
    ,n.bins = 20
    ,importance = F
    #, nfolds = 2
    ,validation = valid_hex
    ,balance.classes = FALSE
    ,max.after.balance.size = 5
  )
  score <- h2o.get_auc(model, test_hex, response = response_)
  #Retrun Score
  return(score)
}


chr <- list(
   n.trees = 5
  ,interaction.depth = 5
  ,n.minobsinnode = 10
  ,n.bins = 20
  ,max.after.balance.size = 5
  ,balance.classes = FALSE
  ,distribution = "multinomial"
  ,variables.include = sample(c(F,T), length(predictors), replace = T)
  ,shrinkage = 0.1
)

genes.class <- list(
   "integer"
  ,"integer"
  ,"integer"
  ,"integer"
  ,"integer"
  ,"boolean"
  ,"class"
  ,"boolean.vector"
  ,"float"
)
genes.range <- list(
  c(1,100)
 ,c(1,100)
 ,c(1,100)
 ,c(1,100)
 ,c(1,100)
 ,c(F,T)
 ,c("multinomial","gaussian")
 ,c(F,T)
 ,c(0,1)
)

waRRior.machinelearning.geneticalgorithm.run(
   chr.init = chr
  ,genes.class = genes.class
  ,genes.range = genes.range
  ,train.data = train_hex
  ,validation.data = valid_hex
  ,test.data = test_hex
  ,evaluate.function = evaluate_gbm
  ,verbose = F
  ,plot.logscale = F
)
