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
