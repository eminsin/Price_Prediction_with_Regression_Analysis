# Step 7: Model Selection

import numpy as np
import pandas as pd
import statsmodels.api as sm
from scipy.stats import f

# Compare AIC and BIC for model selection
aic_model = model.aic
bic_model = model.bic

aic_H01 = model_H01.aic
bic_H01 = model_H01.bic

print(f"Full Model AIC: {aic_model:.2f}, BIC: {bic_model:.2f}")
print(f"Restricted Model AIC: {aic_H01:.2f}, BIC: {bic_H01:.2f}")

# Interpretation
if aic_H01 < aic_model:
    print("The model_H01 has a lower AIC and is preferred based on AIC.")
else:
    print("The model_H0 is preferred based on AIC.")

if bic_H01 < bic_model:
    print("The model_H01 has a lower BIC and is preferred based on BIC.")
else:
    print("The model_H0 is preferred based on BIC.")


# Define a new restricted model excluding the non-significant heating categories from model_H01 and balcony, garden, barrierfree
independent_vars_H02 = [
    "area", "age", "rooms", "kitchen", "basement", "lift", "guesttoilet",
    "heating_cat_3.0", "heating_cat_4.0", "heating_cat_5.0"
]+ [col for col in data.columns if col.startswith(("condition_cat_", "appointments_cat_", "month_"))]  

X_H02 = sm.add_constant(data[independent_vars_H02])
model_H02 = sm.OLS(data[dependent_var], X_H02).fit()

print(model_H02.summary())


# Compare new current model, model_H02 with the first restricted model, model_H0
# Compare AIC and BIC for model selection
aic_H0 = model_H0.aic
bic_H0 = model_H0.bic

aic_H02 = model_H02.aic
bic_H02 = model_H02.bic

print(f"Full Model AIC: {aic_H0:.2f}, BIC: {bic_H0:.2f}")
print(f"Restricted Model AIC: {aic_H02:.2f}, BIC: {bic_H02:.2f}")


# Interpretation
if aic_H02 < aic_H0:
    print("The model_H02 has a lower AIC and is preferred based on AIC.")
else:
    print("The model_H0 is preferred based on AIC.")

if bic_H02 < bic_H0:
    print("The model_H02 has a lower BIC and is preferred based on BIC.")
else:
    print("The model_H0 is preferred based on BIC.")


# Define a new restricted model excluding the non-significant appointment category, appointments_cat_1, from model_H02
independent_vars_H03 = [
    "area", "age", "rooms", "kitchen", "basement", "lift", "guesttoilet",
    "heating_cat_3.0", "heating_cat_4.0", "heating_cat_5.0", "appointments_cat_2"
]+ [col for col in data.columns if col.startswith(("condition_cat_", "month_"))]   

X_H03 = sm.add_constant(data[independent_vars_H03])
model_H03 = sm.OLS(data[dependent_var], X_H03).fit()


# Print results
print(model_H03.summary())

# Compare adjusted R-squared
adj_rsq_H03 = model_H03.rsquared_adj
adj_rsq_H02 = model_H02.rsquared_adj

print(f"Adjusted R-squared for model_H0: {adj_rsq_H03:.4f}")
print(f"Adjusted R-squared for model_H02: {adj_rsq_H02:.4f}")

if adj_rsq_H02 > adj_rsq_H03:
    print("model_H02 is favored based on adjusted R-squared.")
else:
    print("model_H03 is favored based on adjusted R-squared.")


# Leave-One-Out Cross Validation (LOOCV)
h_ii_H03 = model_H03.get_influence().hat_matrix_diag
h_ii_H02 = model_H02.get_influence().hat_matrix_diag

loocv_error_H03 = np.mean(((data["netrent"] - model_H03.fittedvalues) / (1 - h_ii_H03))**2)
loocv_error_H02 = np.mean(((data["netrent"] - model_H02.fittedvalues) / (1 - h_ii_H02))**2)

print(f"LOOCV Error for model_H0: {loocv_error_H03:.4f}")
print(f"LOOCV Error for model H02: {loocv_error_H02:.4f}")

if loocv_error_H02 < loocv_error_H03:
    print("model_H02 is favored based on lower cross-validation error.")
else:
    print("model_H03 is favored based on lower cross-validation error.")


# Compare AIC
aic_model_H03 = model_H03.aic
aic_model_H02 = model_H02.aic

print(f"AIC for model_H0: {aic_model_H03:.2f}")
print(f"AIC for model_H02: {aic_model_H02:.2f}")

if aic_model_H02 < aic_model_H03:
    print("model_H02 is favored based on AIC.")
else:
    print("model_H03 is favored based on AIC.")


# Compare BIC
bic_model_H03 = model_H03.bic
bic_model_H02 = model_H02.bic

print(f"BIC for model_H0: {bic_model_H03:.2f}")
print(f"BIC for model_H02: {bic_model_H02:.2f}")

if bic_model_H02 < bic_model_H03:
    print("model_H02 is favored based on BIC.")
else:
    print("model_H03 is favored based on BIC.")


# Define a new restricted model excluding the non-significant month category as almost all of its categories are not significant
independent_vars_H04 = [
    "area", "age", "rooms", "kitchen", "basement", "lift", "guesttoilet",
    "heating_cat_3.0", "heating_cat_4.0", "heating_cat_5.0"
]+ [col for col in data.columns if col.startswith(("condition_cat_", "appointments_cat_"))]   

X_H04 = sm.add_constant(data[independent_vars_H04])
model_H04 = sm.OLS(data[dependent_var], X_H04).fit()


# Print results
print(model_H04.summary())


# Compare adjusted R-squared
adj_rsq_H04 = model_H04.rsquared_adj
adj_rsq_H02 = model_H02.rsquared_adj

print(f"Adjusted R-squared for model_H04: {adj_rsq_H04:.4f}")
print(f"Adjusted R-squared for model_H02: {adj_rsq_H02:.4f}")

if adj_rsq_H02 > adj_rsq_H04:
    print("model_H02 is favored based on adjusted R-squared.")
else:
    print("model_H04 is favored based on adjusted R-squared.")


# Leave-One-Out Cross Validation (LOOCV)
h_ii_H04 = model_H04.get_influence().hat_matrix_diag
h_ii_H02 = model_H02.get_influence().hat_matrix_diag

loocv_error_H04 = np.mean(((data["netrent"] - model_H04.fittedvalues) / (1 - h_ii_H04))**2)
loocv_error_H02 = np.mean(((data["netrent"] - model_H02.fittedvalues) / (1 - h_ii_H02))**2)

print(f"LOOCV Error for model_H04: {loocv_error_H04:.4f}")
print(f"LOOCV Error for model H02: {loocv_error_H02:.4f}")

if loocv_error_H02 < loocv_error_H04:
    print("model_H02 is favored based on lower cross-validation error.")
else:
    print("model_H04 is favored based on lower cross-validation error.")


# Compare AIC
aic_model_H04 = model_H04.aic
aic_model_H02 = model_H02.aic

print(f"AIC for model_H04: {aic_model_H04:.2f}")
print(f"AIC for model_H02: {aic_model_H02:.2f}")

if aic_model_H02 < aic_model_H04:
    print("model_H02 is favored based on AIC.")
else:
    print("model_H04 is favored based on AIC.")


# Compare BIC
bic_model_H04 = model_H04.bic
bic_model_H02 = model_H02.bic

print(f"BIC for model_H04: {bic_model_H04:.2f}")
print(f"BIC for model_H02: {bic_model_H02:.2f}")

if bic_model_H02 < bic_model_H04:
    print("model_H02 is favored based on BIC.")
else:
    print("model_H04 is favored based on BIC.")




