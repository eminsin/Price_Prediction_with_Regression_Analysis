# Step 2: Model with statsmodels

import pandas as pd
import numpy as np
import statsmodels.api as sm

# Fit the linear regression model
X = data[independent_vars]
y = data[dependent_var]
X = sm.add_constant(X)
model = sm.OLS(y, X).fit()

print(model.summary())
