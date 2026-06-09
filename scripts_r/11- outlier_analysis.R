### ######################### ###
### Outliers                  ###
### ######################### ###

### we need studentized residuals:
studRes     <- as.numeric(MASS::studres(model_7))

### get the critical value of the t distribution to test at a 5% significance level:
crit_t_val  <- qt(p = 1-.05/2, df = model_7$df.residual-1)
outliers    <- which(abs(studRes)>crit_t_val)
length(outliers)/length(studRes)
### we detect at the 5% significance level about 5% outliers
cbind(studRes[outliers], flats[outliers,])[order(studRes[outliers]),]

### fit a model excluding the outliers
model_7_noOutliers <- lm(formula_7, data = flats[-outliers,])

### compare the estimates:
rbind("full data" = model_7$coefficients,
      "no outliers" = model_7_noOutliers$coefficients)

summary(model_7)
summary(model_7_noOutliers)
### obtain slightly different estimates
max(abs((model_7$coefficients - model_7_noOutliers$coefficients)/model_7$coefficients)*100)
### maximum percentage difference between the estimates is 47.8%
### direction of the effects is still the same
