# ####################################### #
#### Heteroscedastic Errors            ####
# ####################################### #

### we have seen in the plot that we likely have Heteroscedastic Errors
plot(r_7 ~ model_7$fitted.values); abline(h=0, col="blue")
