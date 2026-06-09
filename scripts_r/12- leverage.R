### ######################### ###
### Leverage                  ###
### ######################### ###

h_ii          <- as.numeric(lm.influence(model_7)$hat)
high_leverage <- which(h_ii > 2*model_7$rank/length(model_7$fitted.values))
cbind(h_ii[high_leverage], flats[high_leverage,])[order(h_ii[high_leverage], decreasing = TRUE),]
### observations with the highest leverage all have condition_cat==8
table(condition_cat)
### only 15 observations have condition_cat==8, which explains the high leverage
### could test if removing this variable is viable
