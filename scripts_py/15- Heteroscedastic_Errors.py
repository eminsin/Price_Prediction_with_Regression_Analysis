# Step 15: Heteroscedastic Errors

import numpy as np
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import OLSInfluence
import matplotlib.pyplot as plt

# Compute standardized residuals
influence = model_H05.get_influence()
studentized_residuals = influence.resid_studentized_internal

# Plot residuals vs. fitted values
plt.scatter(model_H05.fittedvalues, studentized_residuals, alpha=0.5)
plt.axhline(y=0, color='blue', linestyle='dashed')  # Reference line at 0
plt.xlabel("Fitted Values")
plt.ylabel("Studentized Residuals")
plt.title("Residuals vs. Fitted Values (Checking for Heteroscedasticity)")
plt.show()




