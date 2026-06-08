#Step 1: Data Preparation

import pandas as pd
import numpy as np

# Load dataset
data = pd.read_csv('biele_WM_new.csv')

# Select relevant variables and update original dataset to data
columns = ["mietekalt", "qm_Preis", "wohnflaeche", "alter", "objektzustand", "zimmeranzahl", 
           "balkon", "einbaukueche", "keller", "ausstattung_kat", "aufzug", "gaestewc", 
           "garten", "heizungsart", "barrierefrei", "Einstellungsmonat"]
data = data[columns]

# Rename variables for clarity
data.rename(columns = {'mietekalt': 'netrent', 
                     'qm_Preis': 'rent_per_sqm', 
                     'wohnflaeche': 'area', 
                     'alter': 'age', 
                     'objektzustand': 'condition_cat', 
                     'zimmeranzahl': 'rooms', 
                     'balkon': 'balcony', 
                     'einbaukueche': 'kitchen', 
                     'keller': 'basement', 
                     'ausstattung_kat': 'appointments_cat', 
                     'aufzug': 'lift', 
                     'gaestewc': 'guesttoilet', 
                     'garten': 'garden', 
                     'heizungsart': 'heating_cat', 
                     'barrierefrei': 'barrierfree', 
                     'Einstellungsmonat': 'month'}, inplace= True)

# Drop rows with missing values
data = data.dropna()

# Encode categorical variables
data = pd.get_dummies(data,
                      columns = ['condition_cat', 'appointments_cat', 'heating_cat', 'month'],
                      drop_first = True, dtype = int)

# Define dependent and independent variables
dependent_var = 'netrent'
independent_vars = [col for col in data.columns if col not in [dependent_var, 'rent_per_sqm']]
