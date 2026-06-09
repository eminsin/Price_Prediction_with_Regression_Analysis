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
