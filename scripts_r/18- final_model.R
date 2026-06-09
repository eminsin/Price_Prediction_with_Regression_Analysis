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
