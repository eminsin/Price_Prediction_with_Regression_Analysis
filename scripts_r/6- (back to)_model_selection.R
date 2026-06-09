# ####################################### #
#### (back to) Model selection         ####
# ####################################### #

### compare now the new current model with one where we set balcony, garden and barrierfree to zero
formula_4 <- netrent ~ area + age + rooms + kitchen + basement + lift + guesttoilet + condition_cat + appointments_cat + I(heating_cat==3) + I(heating_cat==4) + I(heating_cat==5) + month
model_4   <- lm(formula_4)
summary(model_4)


summary(model_3)$adj.r.squared
summary(model_4)$adj.r.squared
### the adjusted R-squared favours the fourth, restricted model

### compare by leave-one-out cross validation:
mean(((model_3$model[,1] - model_3$fitted.values) / (1 - lm.influence(model_3)$hat))^2)
mean(((model_4$model[,1] - model_4$fitted.values) / (1 - lm.influence(model_4)$hat))^2)
### model 4 has a lower cross-validation error, hence model 4 is favoured compared to model 3

### compare by AIC
AIC(model_3)
AIC(model_4)
### model 4 has a lower AIC, hence model 4 is favoured compared to model 3

### compare by BIC
BIC(model_3)
BIC(model_4)
### model 4 has a lower BIC, hence model 4 is favoured compared to model 3



### test removing non-significant appointments category appointments_cat==1
formula_5 <- netrent ~ area + age + rooms + kitchen + basement + lift + guesttoilet + condition_cat + I(appointments_cat==2) + I(heating_cat==3) + I(heating_cat==4) + I(heating_cat==5) + month
model_5   <- lm(formula_5)
summary(model_5)

summary(model_4)$adj.r.squared < summary(model_5)$adj.r.squared
mean(((model_4$model[,1] - model_4$fitted.values) / (1 - lm.influence(model_4)$hat))^2) > mean(((model_5$model[,1] - model_5$fitted.values) / (1 - lm.influence(model_5)$hat))^2)
AIC(model_4) > AIC(model_5)
BIC(model_4) > BIC(model_5)
### model 4 is favoured by all model selection metrics but the BIC. We will keep the model_4 as our running model



### test removing month as a variable from the model since most categories are not significant at the 5% significance level
formula_6 <- netrent ~ area + age + rooms + kitchen + basement + lift + guesttoilet + condition_cat + appointments_cat + I(heating_cat==3) + I(heating_cat==4) + I(heating_cat==5)
model_6   <- lm(formula_6)
summary(model_6)

summary(model_4)$adj.r.squared < summary(model_6)$adj.r.squared
mean(((model_4$model[,1] - model_4$fitted.values) / (1 - lm.influence(model_4)$hat))^2) > mean(((model_6$model[,1] - model_6$fitted.values) / (1 - lm.influence(model_6)$hat))^2)
AIC(model_4) > AIC(model_6)
BIC(model_4) > BIC(model_6)
### model 6 is favoured by all model selection metrics but the adjusted R-squared, which is the weakest criterion.
### We will not remove the categorical variable for month from our model and use the model_6 as our running model
