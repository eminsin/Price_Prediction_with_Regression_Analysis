# ####################################### #
#### Model selection                   ####
# ####################################### #

### compare the model_1 and the restricted model, now called model_2
model_2 <- model_H0

### compare by adjusted R-squared
summary(model_1)$adj.r.squared
summary(model_2)$adj.r.squared
### favours the second, restricted model

### compare by leave-one-ouut cross validation:
h_ii_1 <- as.numeric(lm.influence(model_1)$hat)
h_ii_2 <- as.numeric(lm.influence(model_2)$hat)
mean(((model_1$model[,1] - model_1$fitted.values) / (1 - h_ii_1))^2)
mean(((model_2$model[,1] - model_2$fitted.values) / (1 - h_ii_2))^2)
