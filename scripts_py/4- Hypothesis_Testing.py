# Step 4: Hypothesis Testing

import pandas as pd
import numpy as np
import statsmodels.api as sm
from scipy.stats import f

# List of variables to exclude
exclude_vars = ['balcony', 'garden', 'barrierfree']

# Restrict independent_vars by excluding the specified variables
independent_vars_H0 = [col for col in independent_vars if col not in exclude_vars]

# Restricted independent variables
X_H0 = data[independent_vars_H0]

# Add intercept to X_H0
X_H0 = sm.add_constant(X_H0)

# Fit the reduced model
model_H0 = sm.OLS(y, X_H0).fit()

# Print results
print(model_H0.summary())

##### PERFORM F-TEST

SSE_full = np.sum(model.resid ** 2)             # Residual Sum of Squares for full model
SSE_H0 = np.sum(model_H0.resid ** 2)            # Residual Sum of Squares for reduced model

n = len(y)                 # Number of observations
p_full = X.shape[1]        # Number of parameters in full model
p_H0 = X_H0.shape[1]       # Number of parameters in reduced model
r = p_full - p_H0          # Number of restrictions

# Calculate F-statistic
F_H0 = ((SSE_H0 - SSE_full) / r) / (SSE_full / (n - p_full))
print(f"F-statistic: {F_H0}")

# f_statistics = model.compare_f_test(model_H0)

# Calculate critical value
alpha = 0.05
F_critical = f.ppf(1 - alpha, dfn=r, dfd=n - p_full)
print(f"Critical value (alpha={alpha}): {F_critical}")

# Calculate p-value
p_value = 1 - f.cdf(F_H0, dfn=r, dfd=n - p_full)
print(f"P-value: {p_value}")

# Interpretation of results
if p_value < alpha:
    print("Reject the null hypothesis: The variables are jointly significantly different than zero.")
else:
    print("Fail to reject the null hypothesis: The variables are jointly not significantly different than zero.")




