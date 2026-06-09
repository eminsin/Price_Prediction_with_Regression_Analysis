### ######################### ###
### Cook's Distance           ###
### ######################### ###

CsD <- cooks.distance(model_7)
(highCsD <- which(CsD>1))
summary(CsD)
### no observations with a high Cook's distance
### non of the observations habe an unusualy high influence on out of sample prediction
