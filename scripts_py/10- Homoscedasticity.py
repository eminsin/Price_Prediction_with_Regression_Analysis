# Step 10: Homoscedasticity

import numpy as np
import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt

# Calculate standardized residuals
h_ii_5 = model_H05.get_influence().hat_matrix_diag
r_5 = model_H05.resid / (model_H05.scale * np.sqrt(1 - h_ii_5))

# Plot residuals vs. fitted values
plt.scatter(model_H05.fittedvalues, r_5, alpha=0.5)
plt.axhline(y=0, color="blue", linestyle="--")
plt.xlabel("Fitted Values")
plt.ylabel("Standardized Residuals")
plt.title("Residuals vs. Fitted Values (Homoscedasticity Check)")
plt.show()

# Interpretation
print("If the residuals show a funnel shape or any clear pattern, there is heteroscedasticity.")
print("If the residuals are randomly scattered around zero, the assumption of homoscedasticity holds.")



