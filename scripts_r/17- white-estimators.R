### ######################### ###
### White Estimator           ###
### ######################### ###

### robust variance-covariance-Matrix
vcov                      <- sandwich::vcovHC(model_7, type = "HC")
sd_beta_White             <- sqrt(diag(vcov))

rbind("standard" = summary(model_7)$coefficients[,2], 
      "robust"   = sd_beta_White)
