# ################################################### #
#                                                     #
#### Price Predicition with Regression Analysis       ####
###  with R                                           ###
#                                                     #
# ################################################### #


# ####################################### #
#### load, select and pre-process data ####
# ####################################### #

### load data from .csv
flats_orig <- read.csv(file = "biele_WM_new.csv", header = TRUE)
head(flats_orig, 10)

### select subset of variables
flats_red <- flats_orig[,c("mietekalt", "qm_Preis", "wohnflaeche", "alter", "objektzustand", "zimmeranzahl", "balkon", "einbaukueche", "keller", "ausstattung_kat", "aufzug", "gaestewc", "garten", "heizungsart", "barrierefrei", "Einstellungsmonat")]
head(flats_red, 10)

### change variable names to english
names_eng         <- c("netrent", "rent_per_sqm", "area", "age", "condition_cat", "rooms", "balcony", "kitchen", "basement", "appointments_cat", "lift", "guesttoilet", "garden", "heating_cat", "barrierfree", "month")
names(flats_red)  <- names_eng
head(flats_red, 10)

### remove observations with missing values (NA)
no_NA     <- rowSums(is.na(flats_red)==TRUE)==0
flats_red <- flats_red[no_NA,]
head(flats_red, 10)

### some variables should/could be considered as categorical variables
flats_red$condition_cat     <- as.factor(flats_red$condition_cat)
flats_red$heating_cat       <- as.factor(flats_red$heating_cat)
flats_red$appointments_cat  <- as.factor(flats_red$appointments_cat)
flats_red$month             <- as.factor(flats_red$month)


### save final version
flats <- flats_red
head(flats, 10)

### attach to directly access variables
attach(flats)