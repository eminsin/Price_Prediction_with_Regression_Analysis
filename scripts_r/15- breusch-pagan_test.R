### ######################### ###
### Breusch-Pagan test        ###
### ######################### ###

lmtest::bptest(model_7, studentize=FALSE)
### Breusch-Pagan test has a p-value < 2.2e-16, 
### so we have to reject the Null-hypothesis that we have homoscedastic errors
