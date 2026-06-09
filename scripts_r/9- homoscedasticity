### ######################### ###
### Homoscedasticity          ###
### ######################### ###

### calculate standardized residuals
r_7 <- as.numeric(model_7$residuals/(summary(model_7)$sigma*sqrt(1-lm.influence(model_7)$hat)))

plot(r_7 ~ model_7$fitted.values); abline(h=0, col="blue")
### we have in the plot a clear indication for heteroscedastic errors
### we will have to deal with this in the next part.
