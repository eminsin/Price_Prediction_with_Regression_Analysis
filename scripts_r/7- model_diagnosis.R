# ####################################### #
#### Model diagnosis                   ####
# ####################################### #

### calculate standardized residuals
r_6 <- as.numeric(model_6$residuals/(summary(model_6)$sigma*sqrt(1-lm.influence(model_6)$hat)))

