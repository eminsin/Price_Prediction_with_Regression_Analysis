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
