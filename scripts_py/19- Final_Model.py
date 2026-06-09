# Step 19: Final Model and Prediction

import pandas as pd
import numpy as np
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import OLSInfluence
from scipy.stats import t

# Create a new example flat (same as `new_obs`)
new_obs = data.iloc[[0]].copy()  # Take the first row as an example

# Modify the values
new_obs["netrent"] = 1400
new_obs["area"] = 144
new_obs["rent_per_sqm"] = new_obs["netrent"] / new_obs["area"]
new_obs["age"] = 66
new_obs["condition_cat_7"] = 1       # Assuming dummy variables are used for categories
new_obs["rooms"] = 6
new_obs["balcony"] = 0
new_obs["kitchen"] = 1
new_obs["basement"] = 1
new_obs["barrierfree"] = 0
new_obs["appointments_cat_1"] = 1    # Assuming dummy variables are used for categories
new_obs["lift"] = 0
new_obs["guesttoilet"] = 1
new_obs["garden"] = 0
new_obs["heating_cat_13"] = 1        # Assuming dummy variables are used for categories
new_obs["month"] = 3

# Ensure new_obs contains only the independent variables
X_new = new_obs[X_H05.columns.drop("const", errors="ignore")]  # Drop 'const' if it exists

# Add constant term (intercept), same as in model_H05
X_new = sm.add_constant(X_new, has_constant="add")

##### Unweighted Model Prediction

pred_new = model_H05.get_prediction(X_new)
pred_new_fit = pred_new.predicted_mean
se_fit = pred_new.se_mean

# 95% Prediction Interval for Conditional Expectation
df_residual = model_H05.df_resid
t_val = t.ppf(0.975, df_residual)
ci_expectation = pred_new_fit + np.array([-1, 1]) * t_val * se_fit

# 95% Prediction Interval for a Specific New Observation
sigma_hat = np.sqrt(model_H05.scale)  # Standard error of residuals
ci_new_obs = pred_new_fit + np.array([-1, 1]) * t_val * np.sqrt(sigma_hat**2 + se_fit**2)

##### Weighted Model Prediction

pred_new_w = model_H05_weighted.get_prediction(X_new)
pred_new_w_fit = pred_new_w.predicted_mean
se_fit_w = pred_new_w.se_mean

# 95% Prediction Interval for Conditional Expectation (Weighted)
df_residual_w = model_H05_weighted.df_resid
t_val_w = t.ppf(0.975, df_residual_w)
ci_expectation_w = pred_new_w_fit + np.array([-1, 1]) * t_val_w * se_fit_w

# 95% Prediction Interval for Specific New Observation (Weighted)
sigma2_hat_new = np.exp(aux_model.predict(X_new)) * model_H05_weighted.scale
ci_new_obs_w = np.vstack([
    pred_new_w_fit + (-1) * t_val_w * np.sqrt(sigma2_hat_new + se_fit_w**2),
    pred_new_w_fit + (1)  * t_val_w * np.sqrt(sigma2_hat_new + se_fit_w**2)
]).T  # Transpose to keep a consistent shape

# Print results
print("Unweighted Prediction:", pred_new_fit)
print("95% CI (Expectation):", ci_expectation)
print("95% CI (New Observation):", ci_new_obs)

print("Weighted Prediction:", pred_new_w_fit)
print("95% CI (Expectation, Weighted):", ci_expectation_w)
print("95% CI (New Observation, Weighted):", ci_new_obs_w)







