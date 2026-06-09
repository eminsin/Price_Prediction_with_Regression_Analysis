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
