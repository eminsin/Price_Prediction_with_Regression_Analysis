# Step 6: Problem Analysis

import numpy as np
import pandas as pd
import statsmodels.api as sm
from scipy.stats import f

# Identify problematic observations where leverage = 1
high_leverage_1 = np.where(h_ii_1 == 1)[0]
high_leverage_2 = np.where(h_ii_2 == 1)[0]

print("Observations with h_ii == 1 in full model:", high_leverage_1)
print("Observations with h_ii == 1 in reduced model:", high_leverage_2)

# Reload the original dataset
data = pd.read_csv('biele_WM_new.csv')
columns = ["mietekalt", "qm_Preis", "wohnflaeche", "alter", "objektzustand", "zimmeranzahl", "balkon", "einbaukueche", "keller", "ausstattung_kat", "aufzug", "gaestewc", "garten", "heizungsart", "barrierefrei", "Einstellungsmonat"]
data = data[columns]
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
data = data.dropna()

# Check categorical variable distribution
print("Condition category summary:\n", data['condition_cat'].value_counts())
print("Appointments category summary:\n", data['appointments_cat'].value_counts())
print("Heating category summary:\n", data['heating_cat'].value_counts())
print("Month summary:\n", data['month'].value_counts())

# Encode categorical variables
data = pd.get_dummies(data,
                      columns = ['condition_cat', 'heating_cat', 'appointments_cat', 'month'],
                      drop_first = True, dtype = int)

# Define a new restricted model excluding the non-significant heating categories
independent_vars_H01 = [
    "area", "age", "rooms", "kitchen", "basement", "lift", "guesttoilet", "balcony", "garden", "barrierfree",
    "heating_cat_3.0", "heating_cat_4.0", "heating_cat_5.0", "heating_cat_2.0", "heating_cat_7.0"
]+ [col for col in data.columns if col.startswith(("condition_cat_", "appointments_cat_", "month_"))]  

X_H01 = sm.add_constant(data[independent_vars_H01])
model_H01 = sm.OLS(data[dependent_var], X_H01).fit()

# Print results
print(model_H01.summary())

##### PERFORM F-TEST

SSE = np.sum(model.resid**2)
SSE_H01 = np.sum(model_H01.resid**2)
n = len(model.fittedvalues)
p = model.df_model + 1                    # Number of parameters including intercept
r = model.df_model - model_H01.df_model   # Difference in model complexity

# Compute F-statistic
F_H01 = ((n - p) / r) * (SSE_H01 - SSE) / SSE
print(f"F-statistic: {F_H01}")

# f_statistics = model.compare_f_test(model_H01)

# Compute critical value and p-value
F_critical = f.ppf(0.95, dfn=r, dfd=n - p)
p_value = 1 - f.cdf(F_H01, dfn=r, dfd=n - p)

print(f"Critical value at 95% confidence: {F_critical}")
print(f"P-value: {p_value}")

if p_value < 0.05:
    print("Reject the null hypothesis: Heating categories jointly significantly influence the model.")
else:
    print("Fail to reject the null hypothesis: Heating categories have no joıntly significant influence.")








