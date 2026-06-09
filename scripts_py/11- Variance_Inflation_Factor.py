# Step 11: Variation Inflation Factor

import pandas as pd
import numpy as np
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import variance_inflation_factor, OLSInfluence
import matplotlib.pyplot as plt
from scipy import stats
from scipy.stats import f
import seaborn as sns

# Extract independent variables from the model
X_VIF = X_H05.values
# X_VIF = model_H05.model.exog               # Extracts the matrix from the fitted statsmodels OLS model
X_VIF_names = X_H05.columns
# X_VIF_names = model_H05.model.exog_names   # Get variable names

# Compute VIF using the manual approach
VIF_H05 = {}
for i in range(1, X_VIF.shape[1]):           # Skip intercept column
    X_foo = np.delete(X_VIF, i, axis=1)      # Remove ith column
    y_foo = X_VIF[:, i]                      # Set ith column as response variable
    
    # Compute projection matrix H_foo
    H_foo = X_foo @ np.linalg.inv(X_foo.T @ X_foo) @ X_foo.T
    y_hat_foo = H_foo @ y_foo  # Predicted values
    R2_foo = np.sum((y_hat_foo - np.mean(y_foo)) ** 2) / np.sum((y_foo - np.mean(y_foo)) ** 2)
    
    VIF_H05[X_VIF_names[i]] = 1 / (1 - R2_foo)

# Convert to DataFrame
VIF_df = pd.DataFrame.from_dict(VIF_H05, orient='index', columns=['VIF'])
print(VIF_df)

# Compute VIF using statsmodels function
VIF_values = pd.DataFrame({
    "Variable": X_VIF_names[1:],  # Exclude intercept
    "VIF": [variance_inflation_factor(X_VIF, i) for i in range(1, X_VIF.shape[1])]  # Exclude intercept
})

print(VIF_values)

# Plot VIF values
plt.figure(figsize=(8, 6))
colors = np.where(VIF_values["VIF"] > 10, "red", np.where(VIF_values["VIF"] > 5, "orange", "blue"))
plt.barh(VIF_values["Variable"], VIF_values["VIF"], color=colors)
plt.axvline(5, color="black", linestyle="--", label="VIF = 5 (Moderate)")
plt.axvline(10, color="red", linestyle="--", label="VIF = 10 (Severe)")
plt.xlabel("Variance Inflation Factor (VIF)")
plt.ylabel("Covariates")
plt.title("Multicollinearity Analysis using VIF")
plt.legend()
plt.show()

# Show variables with high multicollinearity
print("Variables with VIF > 10 (Severe Multicollinearity):", VIF_values[VIF_values["VIF"] > 10]["Variable"].tolist())
print("Variables with VIF > 5 (Moderate Multicollinearity):", VIF_values[(VIF_values["VIF"] > 5) & (VIF_values["VIF"] <= 10)]["Variable"].tolist())

# Create scatter plot
sns.scatterplot(x=data["area"], y=data["area_squared"], alpha=0.5)
plt.xlabel("Area")
plt.ylabel("Area²")
plt.title("Scatter plot of Area² vs Area")
plt.show()
