# Step 3: Model by Hand

import pandas as pd
import numpy as np
import statsmodels.api as sm

# Extract values of dependent and independent variables
X_val = data[independent_vars].values
y_val = data[dependent_var].values

# Add intercept
intercept = np.ones((X_val.shape[0], 1))             # Create a column of ones
X_with_intercept = np.hstack((intercept, X_val))     # Combine intercept with X

# X_1: Design matrix (including intercept column)
# y_1: Dependent variable (netrent)
X_1 = np.array(X_with_intercept)
y_1 = np.array(y_val)

# Estimate beta_hat
beta_hat_1 = np.linalg.inv(X_1.T @ X_1) @ X_1.T @ y_1

# Compute the hat matrix (H)
H_1 = X_1 @ np.linalg.inv(X_1.T @ X_1) @ X_1.T

# Residuals (epsilon_hat)
epsilon_hat_1 = (np.eye(len(y_1)) - H_1) @ y_1

# Fitted values (y_hat)
y_hat_1 = H_1 @ y_1

# Estimate sigma^2 (residual variance)
n, k = X_1.shape
sigma2_hat_1 = (1 / (n - k)) * (epsilon_hat_1.T @ epsilon_hat_1)

# Covariance matrix of beta_hat
Cov_beta_hat_1 = sigma2_hat_1 * np.linalg.inv(X_1.T @ X_1)

# Standard errors of beta_hat
sd_beta_hat_1 = np.sqrt(np.diag(Cov_beta_hat_1))

# Print results
print("Beta_hat:", beta_hat_1)
print("Residual variance (sigma^2):", sigma2_hat_1)
print("Covariance matrix of beta_hat:\n", Cov_beta_hat_1)
print("Standard errors of beta_hat:", sd_beta_hat_1)

# Comparison of coefficients and standard deviations
coeff_comparison = np.vstack([model.params, beta_hat_1])
stddev_comparison = np.vstack([model.bse, sd_beta_hat_1])

# Display results
print("Comparison of Coefficients:")
print(pd.DataFrame(coeff_comparison, index=["Statsmodels", "By-Hand"], 
                   columns=['intercept'] + independent_vars))
print("\nComparison of Standard Deviations:")
print(pd.DataFrame(stddev_comparison, index=["Statsmodels", "By-Hand"], 
                   columns=['intercept'] + independent_vars))



