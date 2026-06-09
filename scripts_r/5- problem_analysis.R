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
