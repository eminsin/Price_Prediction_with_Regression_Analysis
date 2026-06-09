### ######################### ###
### Linearity                 ###
### ######################### ###

### check non-linearities w.r.t. numerical variables
plot(r_6 ~ area); abline(h=0, col="blue")
plot(r_6 ~ age); abline(h=0, col="blue")
plot(r_6 ~ rooms); abline(h=0, col="blue")
### slight hint of non-linearity w.r.t. area

### include non-linearity w.r.t. area into the model
formula_7 <- netrent ~ area + I(area^2) + age + rooms + kitchen + basement + lift + guesttoilet + condition_cat + appointments_cat + I(heating_cat==3) + I(heating_cat==4) + I(heating_cat==5)
### could also include higher order terms:
#formula_7 <- netrent ~ area + I(area^2) + I(area^3) + age + rooms + kitchen + basement + lift + guesttoilet + condition_cat + appointments_cat + I(heating_cat==3) + I(heating_cat==4) + I(heating_cat==5)
model_7   <- lm(formula_7)
summary(model_7)

### check non-linearities w.r.t. numerical variables
r_7       <- as.numeric(model_7$residuals/(summary(model_7)$sigma*sqrt(1-lm.influence(model_7)$hat)))
plot(r_7 ~ area); abline(h=0, col="blue")

### check by model selection criteria
summary(model_6)$adj.r.squared < summary(model_7)$adj.r.squared
mean(((model_6$model[,1] - model_6$fitted.values) / (1 - lm.influence(model_6)$hat))^2) > mean(((model_7$model[,1] - model_7$fitted.values) / (1 - lm.influence(model_7)$hat))^2)
AIC(model_6) > AIC(model_7)
BIC(model_6) > BIC(model_7)
### the model 7 with non-linear effects of the area is favoured by all model selection criteria, so this will replace our current model
