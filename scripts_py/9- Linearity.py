# Step 9: Linearity

import numpy as np
import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt

# Define new independent variables including non-linearity for area
independent_vars_H05 = independent_vars_H04 + ["area_squared"]

# Add squared term for area
data["area_squared"] = data["area"] ** 2

# Create design matrix with constant
X_H05 = sm.add_constant(data[independent_vars_H05])

# Fit new model including area^2
model_H05 = sm.OLS(data[dependent_var], X_H05).fit()

# Print summary
print(model_H05.summary())

# Calculate standardized residuals
h_ii_5 = model_H05.get_influence().hat_matrix_diag
r_5 = model_H05.resid / (model_H05.scale * np.sqrt(1 - h_ii_5))

# Plot residuals vs. area to check non-linearity
plt.scatter(data["area"], r_5, alpha=0.5)
plt.axhline(y=0, color="blue", linestyle="--")
plt.xlabel("Area")
plt.ylabel("Standardized Residuals")
plt.title("Residuals vs. Area")
plt.show()

# Model selection criteria comparison
print("Adjusted R²: model_H04 vs. model_H05:", model_H04.rsquared_adj, "<", model_H05.rsquared_adj)
print("LOO-CV Error: model_H04 vs. model_H05:", 
      np.mean((model_H04.resid / (1 - model_H04.get_influence().hat_matrix_diag)) ** 2), ">", 
      np.mean((model_H05.resid / (1 - model_H05.get_influence().hat_matrix_diag)) ** 2))
print("AIC: model_H04 vs. model_H05:", model_H04.aic, ">", model_H05.aic)
print("BIC: model_H04 vs. model_H05:", model_H04.bic, ">", model_H05.bic)

# Decision based on model selection criteria
if (model_H05.rsquared_adj > model_H04.rsquared_adj and
    model_H05.aic < model_H04.aic and
    model_H05.bic < model_H04.bic):
    print("model_H05 with area² is preferred over Model_H04.")
else:
    print("model_H04 remains the preferred model.")



