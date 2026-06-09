# Step 5: Model Selection

import numpy as np
import pandas as pd
import statsmodels.api as sm
import scipy

# Compare adjusted R-squared
adj_rsq_model = model.rsquared_adj
adj_rsq_model_H0 = model_H0.rsquared_adj

print("Adjusted R-squared:")
print(f"Full model: {adj_rsq_model}")
print(f"Reduced model: {adj_rsq_model_H0}")

# Leverage values (hat matrix diagonal elements)
influence_model = model.get_influence()
h_ii_1 = influence_model.hat_matrix_diag

influence_model_H0 = model_H0.get_influence()
h_ii_2 = influence_model_H0.hat_matrix_diag

# Compute leave-one-out cross-validation error (LOOCV)
y_actual = model.model.endog  # Dependent variable values

loocv_model = np.mean(((y_actual - model.fittedvalues) / (1 - h_ii_1)) ** 2)
loocv_model_H0 = np.mean(((y_actual - model_H0.fittedvalues) / (1 - h_ii_2)) ** 2)

print("\nLOOCV Error:")
print(f"Full model: {loocv_model}")
print(f"Reduced model: {loocv_model_H0}")






















