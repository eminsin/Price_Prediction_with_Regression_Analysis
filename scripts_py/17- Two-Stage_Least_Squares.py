# Step 17: Two-Stage Least Squares

import pandas as pd
import numpy as np
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import OLSInfluence
import matplotlib.pyplot as plt

# Compute log of squared residuals
log_sig_i = np.log(model_H05.resid**2)

# Create design matrix (independent variables)
X_aux = X_H05  # Uses the same independent variables as model_H05

# Fit auxiliary regression to estimate weights
aux_model = sm.OLS(log_sig_i, X_aux).fit()
log_sig_i_hat = aux_model.fittedvalues
w_i_hat = 1 / np.exp(log_sig_i_hat)  # Compute weights

# Transform dependent and independent variables
sqrt_w = np.sqrt(w_i_hat)  # Take square root of weights

y_transformed = data[dependent_var] * sqrt_w    # Transform dependent variable
X_transformed = X_H05.multiply(sqrt_w, axis=0)  # Transform independent variables

# Fit weighted model using OLS
model_H05_weighted = sm.OLS(y_transformed, X_transformed).fit()

# Print summary
print(model_H05_weighted.summary())

# Compare results of unweighted and weighted models
comparison_df = pd.DataFrame({
    "Unweighted": model_H05.params,
    "Weighted WLS": model_H05_weighted.params
})

comparison_df["% Difference"] = (comparison_df["Weighted WLS"] - comparison_df["Unweighted"]) / comparison_df["Unweighted"] * 100

print(comparison_df)

# Compute weighted residuals
epsilon_hat_H05_weighted = model_H05_weighted.resid  # Residuals from the weighted model

# Compute leverage values
influence = model_H05_weighted.get_influence()  # Influence measures
hat_values_weighted = influence.hat_matrix_diag  # Extract leverage (h_ii)

# Compute standard deviation of residuals
sigma_hat_weighted = model_H05_weighted.scale ** 0.5

# Compute studentized residuals (weighted)
r_H05_weighted = (
    epsilon_hat_H05_weighted / (sigma_hat_weighted * np.sqrt(1 - hat_values_weighted))
) * sqrt_w

print("Max leverage value:", np.max(hat_values_weighted))
print("Min leverage value:", np.min(hat_values_weighted))

# Plot residuals before and after weighting
fig, axes = plt.subplots(1, 2, figsize=(12, 5))

axes[0].scatter(model_H05.fittedvalues, studentized_residuals, alpha=0.5)
axes[0].axhline(y=0, color='blue', linestyle='dashed')
axes[0].set_xlabel("Fitted Values")
axes[0].set_ylabel("Studentized Residuals")
axes[0].set_title("Unweighted Model Residuals")

axes[1].scatter(model_H05_weighted.fittedvalues, r_H05_weighted, alpha=0.5)
axes[1].axhline(y=0, color='blue', linestyle='dashed')
axes[1].set_xlabel("Fitted Values")
axes[1].set_ylabel("Weighted Studentized Residuals")
axes[1].set_title("Weighted Model Residuals")

plt.show()







