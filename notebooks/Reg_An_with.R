# ################################################### #
#                                                     #
#### Price Predicition with Regression Analysis       ####
###  with R                                           ###
#                                                     #
# ################################################### #


# ####################################### #
#### load, select and pre-process data ####
# ####################################### #

### load data from .csv
flats_orig <- read.csv(file = "biele_WM_new.csv", header = TRUE)
head(flats_orig, 10)

### select subset of variables
flats_red <- flats_orig[,c("mietekalt", "qm_Preis", "wohnflaeche", "alter", "objektzustand", "zimmeranzahl", "balkon", "einbaukueche", "keller", "ausstattung_kat", "aufzug", "gaestewc", "garten", "heizungsart", "barrierefrei", "Einstellungsmonat")]
head(flats_red, 10)

### change variable names to english
names_eng         <- c("netrent", "rent_per_sqm", "area", "age", "condition_cat", "rooms", "balcony", "kitchen", "basement", "appointments_cat", "lift", "guesttoilet", "garden", "heating_cat", "barrierfree", "month")
names(flats_red)  <- names_eng
head(flats_red, 10)

### remove observations with missing values (NA)
no_NA     <- rowSums(is.na(flats_red)==TRUE)==0
flats_red <- flats_red[no_NA,]
head(flats_red, 10)

### some variables should/could be considered as categorical variables
flats_red$condition_cat     <- as.factor(flats_red$condition_cat)
flats_red$heating_cat       <- as.factor(flats_red$heating_cat)
flats_red$appointments_cat  <- as.factor(flats_red$appointments_cat)
flats_red$month             <- as.factor(flats_red$month)


### save final version
flats <- flats_red
head(flats, 10)

### attach to directly access variables
attach(flats)





# ####################################### #
#### OLS estimation                    ####
# ####################################### #

### define first linear model
formula_1 <- netrent ~ area + age + rooms + balcony + kitchen + basement + lift + guesttoilet + garden + barrierfree + condition_cat + appointments_cat + heating_cat + month

### could also model rent per sqm instead of net rent
# formula_1 <- rent_per_sqm ~ area + age + rooms + balcony + kitchen + basement + lift + guesttoilet + garden + barrierfree + condition_cat + appointments_cat + heating_cat + month

### estimate linear model using lm function
model_1 <- lm(formula_1)
summary(model_1)


### estimate the model using matrix algebra "by-hand"
X_1             <- model.matrix(formula_1)
y_1             <- netrent
beta_hat_1      <- solve(t(X_1) %*% X_1) %*% t(X_1) %*% y_1

H_1             <- X_1 %*% solve(t(X_1)%*%X_1) %*% t(X_1)
epsilon_hat_1   <- (diag(length(y_1)) - H_1) %*% y_1
y_hat_1         <- H_1 %*% y_1

sigma2_hat_1    <- as.numeric( 1/(nrow(X_1)-ncol(X_1)) * t(epsilon_hat_1)%*%epsilon_hat_1)

Cov_beta_hat_1  <- sigma2_hat_1 * solve(t(X_1)%*%X_1)
sd_beta_hat_1   <- sqrt(diag(Cov_beta_hat_1))

### compare estimates by lm-function and "by-hand"-estimates
rbind(model_1$coefficients, t(beta_hat_1))

### compare standard deviations estimated by lm-function and computed "by-hand"
rbind(summary(model_1)$coefficients[,2], t(sd_beta_hat_1))





# ####################################### #
#### Hypothesis Tests                  ####
# ####################################### #

summary(model_1)
### in the model_1 the variables balcony, garden and barrierfree are not statistically significantly different from zero
### make an F-test testing the joint hypothesis that they are jointly not significantly different from zero

formula_H0  <- netrent ~ area + age + rooms + kitchen + basement + lift + guesttoilet + condition_cat + appointments_cat + heating_cat + month
model_H0    <- lm(formula_H0)
summary(model_H0)

### perform F-test
SSE     <- sum(model_1$residuals^2)
SSE_H0  <- sum(model_H0$residuals^2)
n       <- length(model_1$fitted.values)
p       <- model_1$rank
r       <- model_1$rank - model_H0$rank
### calculate F-statistic
(F_H0   <- (n-p)/r * (SSE_H0-SSE)/SSE)
### critical value
qf(p = 0.95, df1 = r, df2 = n-p)
### p-value
pf(q = F_H0, df1 = r, df2 = n-p, lower.tail = FALSE)
### can't reject the null-hypothesis that balcony, garden and barrierfree are all not significantly different from zero





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




### ####################################### ###
###                                         ###
###       PROBLEM!!!                        ###
###                                         ###
### ####################################### ###

### we get NaN values, this usually happens when we devide by zero
### => check h_ii values
summary(h_ii_1)
summary(h_ii_2)
which(h_ii_1==1)
which(h_ii_2==1)
flats[which(h_ii_1==1), ]
### we have one observation with h_ii == 1. This means that the regression goes perfectly through this point

### check distribution of categorical variables
summary(condition_cat)
summary(appointments_cat)
summary(heating_cat)
summary(month)
### heating_cat==11 has only one observation, so the estimated parameter is an intercept for just this one observation
summary(model_1)
### many of the estimated heating parameters are not significant, others have almost no observations

### perform an F-test to check if the non-significant heating category variables are jointly zero
formula_H0  <- netrent ~ area + age + rooms + balcony + kitchen + basement + lift + guesttoilet + garden + barrierfree + condition_cat + appointments_cat + I(heating_cat==3) + I(heating_cat==4) + I(heating_cat==5) + month
model_H0    <- lm(formula_H0)
summary(model_H0)

### perform F-test
SSE     <- sum(model_1$residuals^2)
SSE_H0  <- sum(model_H0$residuals^2)
n       <- length(model_1$fitted.values)
p       <- model_1$rank
r       <- model_1$rank - model_H0$rank
### calculate F-statistic
(F_H0   <- (n-p)/r * (SSE_H0-SSE)/SSE)
### critical value
qf(p = 0.95, df1 = r, df2 = n-p)
### p-value
pf(q = F_H0, df1 = r, df2 = n-p, lower.tail = FALSE)
### we can't reject the null hypothesis that the selected heating categories have jointly no significant influence on the model

### restricted model is new current model
model_3 <- model_H0
summary(model_3)




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





# ####################################### #
#### Model diagnosis                   ####
# ####################################### #

### calculate standardized residuals
r_6 <- as.numeric(model_6$residuals/(summary(model_6)$sigma*sqrt(1-lm.influence(model_6)$hat)))


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




### ######################### ###
### Homoscedasticity          ###
### ######################### ###

### calculate standardized residuals
r_7 <- as.numeric(model_7$residuals/(summary(model_7)$sigma*sqrt(1-lm.influence(model_7)$hat)))

plot(r_7 ~ model_7$fitted.values); abline(h=0, col="blue")
### we have in the plot a clear indication for heteroscedastic errors
### we will have to deal with this in the next part.




### ######################### ###
### Variance Inflation Factor ###
### ######################### ###

VIF <- function(model){
  VIF <- numeric(ncol(model.matrix(model))-1)
  for(i in 2:ncol(model.matrix(model))){
    X_foo     <- model.matrix(model)[,-i]
    y_foo     <- as.numeric(model.matrix(model)[,i])
    H_foo     <- X_foo %*% solve(t(X_foo)%*%X_foo) %*% t(X_foo)
    y_hat_foo <- H_foo %*% y_foo
    R2_foo    <- sum((y_hat_foo-mean(y_foo))^2) / sum((y_foo-mean(y_foo))^2)
    VIF[i-1]  <- 1/(1 - R2_foo)
  }
  names(VIF) <- colnames(model.matrix(model))[-1]
  VIF
}
(VIF_7 <- VIF(model_7))

plot_vif <- function(VIF_valuse){
  par(mar=c(4,8,0,2))
  plot <- barplot(VIF_valuse, horiz = TRUE, col = as.numeric(VIF_valuse>10)+as.numeric(VIF_valuse>5), las=2 )
  abline(v = c(5,10), col = c(1,2))
  names(VIF_valuse)[VIF_valuse>10]
  names(VIF_valuse)[VIF_valuse>5]
  par(mar=c(5.1, 4.1, 4.1, 2.1))
  return(plot)
}
test <- plot_vif(VIF_7)
### We have a variance inflation for the area variables.
### This is not to surprising since we only have positive values for the area and get
plot(area^2 ~ area)
### The other variables indicate no problems.




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




### ######################### ###
### Cook's Distance           ###
### ######################### ###

CsD <- cooks.distance(model_7)
(highCsD <- which(CsD>1))
summary(CsD)
### no observations with a high Cook's distance
### non of the observations habe an unusualy high influence on out of sample prediction





# ####################################### #
#### Heteroscedastic Errors            ####
# ####################################### #

### we have seen in the plot that we likely have Heteroscedastic Errors
plot(r_7 ~ model_7$fitted.values); abline(h=0, col="blue")



### ######################### ###
### Breusch-Pagan test        ###
### ######################### ###

lmtest::bptest(model_7, studentize=FALSE)
### Breusch-Pagan test has a p-value < 2.2e-16, 
### so we have to reject the Null-hypothesis that we have homoscedastic errors



### ######################### ###
### Two-Stage Least Squares   ###
### ######################### ###

### estimate an auxiliary regression to predict squared residuals to use as weights
### by hand
log_sig_i                 <- as.numeric(log(model_7$residuals^2))
X_foo                     <- model.matrix(model_7)
H_foo                     <- X_foo %*% solve(t(X_foo)%*%X_foo) %*% t(X_foo)
log_sig_i_hat             <- H_foo %*% log_sig_i
w_i_hat                   <- as.numeric(1/exp(log_sig_i_hat))

### or with lm-function
formula_7_weights         <- log(model_7$residuals^2) ~ area + I(area^2) + age + rooms + kitchen + basement + lift + guesttoilet + condition_cat + appointments_cat + I(heating_cat == 3) + I(heating_cat == 4) + I(heating_cat == 5)
model_7_logweights        <- lm(formula_7_weights)
w_i_hat                   <- as.numeric(1/exp(model_7_logweights$fitted.values))


### estimate weighted model using the lm-function
model_7_weighted          <- lm(formula_7, weights = w_i_hat)
summary(model_7_weighted)
rbind(model_7$coefficients, model_7_weighted$coefficients)

### estimate "by-hand"
y_foo                     <- as.numeric(model_7$model[,1])
beta_hat_7_weightd        <- as.numeric(solve(t(X_foo) %*% diag(w_i_hat) %*% X_foo) %*% t(X_foo) %*% diag(w_i_hat) %*% y_foo)
rbind("unweighted"       = model_7$coefficients, 
      "weighted lm"      = model_7_weighted$coefficients, 
      "weighted by-hand" = beta_hat_7_weightd)

### estimate standard errors "by-hand"
epsilon_hat_7_weighted    <- y_foo - X_foo %*% beta_hat_7_weightd
sigma2_hat_7_weighted     <- as.numeric(1/(nrow(X_foo)-ncol(X_foo)) * t(epsilon_hat_7_weighted) %*% diag(w_i_hat) %*% epsilon_hat_7_weighted)
Cov_beta_hat_7_weighted   <- sigma2_hat_7_weighted * solve(t(X_foo) %*% diag(w_i_hat) %*% X_foo)
sd_beta_hat_7_weighted    <- sqrt(diag(Cov_beta_hat_7_weighted))
rbind("unweighted"       = summary(model_7)$coefficients[,2], 
      "weighted lm"      = summary(model_7_weighted)$coefficients[,2], 
      "weighted by-hand" = sd_beta_hat_7_weighted)


r_7_weighted              <- as.numeric(model_7_weighted$residuals/(summary(model_7_weighted)$sigma*sqrt(1-lm.influence(model_7_weighted)$hat)))*model_7_weighted$weights
par(mfrow = c(1,2))
plot(r_7 ~ model_7$fitted.values); abline(h=0, col="blue")
plot(r_7_weighted ~ model_7_weighted$fitted.values); abline(h=0, col="blue")
par(mfrow = c(1,1))
### Weighted standardized residuals have lower indication of Heteroscedastie
### Could try non-linear model for weights to improve even further



### ######################### ###
### White Estimator           ###
### ######################### ###

### robust variance-covariance-Matrix
vcov                      <- sandwich::vcovHC(model_7, type = "HC")
sd_beta_White             <- sqrt(diag(vcov))

rbind("standard" = summary(model_7)$coefficients[,2], 
      "robust"   = sd_beta_White)



# ####################################### #
#### Final Model                       ####
# ####################################### #

### 
summary(model_7_weighted)
### with the Two-Stage Least Squares estimates we get new standard errors for the estimates
### some of the variables are now not statistically significant at the 5% significance levels (lift, guesttoilet, appointments_cat==2 and heating_cat==3)
### with this information, we could go back to model selection.




# ####################################### #
#### Prediction                        ####
# ####################################### #

### new example flat
new_obs                   <- flats[1,]
new_obs$netrent           <- 1400
new_obs$area              <- 144
new_obs$rent_per_sqm      <- new_obs$netrent/new_obs$area
new_obs$age               <- 66
new_obs$condition_cat     <- as.factor(7)
new_obs$rooms             <- 6
new_obs$balcony           <- 0
new_obs$kitchen           <- 1
new_obs$basement          <- 1
new_obs$barrierfree       <- 0
new_obs$appointments_cat  <- as.factor(1)
new_obs$lift              <- 0
new_obs$guesttoilet       <- 1
new_obs$garden            <- 0
new_obs$heating_cat       <- as.factor(13)
new_obs$month             <- 3


### un-weighted model
### prediction for new observation
pred_new        <- predict(object = model_7, newdata = new_obs, se.fit = TRUE)
pred_new$fit

### 95% Prediction interval for the conditional expectation:
pred_new$fit + c(-1,1) * qt(0.975, model_7$df.residual) * pred_new$se.fit

### 95% Prediction interval for specific new observation:
pred_new$fit + c(-1,1) * qt(0.975, model_7$df.residual) * sqrt(summary(model_7)$sigma^2 + pred_new$se.fit^2)


### for weighted model:
### prediction for new observation
pred_new_w      <- predict(object = model_7_weighted, newdata = new_obs, se.fit = TRUE)
pred_new_w$fit

### 95% Prediction interval for the conditional expectation:
pred_new_w$fit + c(-1,1) * qt(0.975, model_7_weighted$df.residual)*pred_new_w$se.fit

### 95% Prediction interval for specific new observation:
### have to calculate the observation specific predicted sigma_i^2
sigma2_hat_new  <- exp(predict(model_7_logweights, newdata = new_obs))*summary(model_7_weighted)$sigma^2
pred_new_w$fit + c(-1,1) * qt(0.975, model_7_weighted$df.residual) * sqrt(sigma2_hat_new + pred_new_w$se.fit^2)



