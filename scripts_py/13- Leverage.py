# Step 13: Leverage

import pandas as pd
import numpy as np
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import OLSInfluence

# Compute leverage values (hat matrix diagonal)
h_ii_5 = model_H05.get_influence().hat_matrix_diag

# Identify high leverage points: h_ii_5 > 2 * (p / n)
p = model_H05.df_model + 1                          # Number of predictors + intercept
n = len(model_H05.fittedvalues)                     # Number of observations
high_leverage = np.where(h_ii_5 > 2 * (p / n))[0]   # Get indices of high leverages 

# the rule of thumb ->  observations with h_ii_5 > 2 * (p / n) (twice the average) should be examined more closely.

# Extract high leverage observations and sort them
high_leverage_data = data.iloc[high_leverage].copy()    # Extract rows
high_leverage_data["leverage"] = h_ii_5[high_leverage]  # Add leverage values
high_leverage_data = high_leverage_data.sort_values(by="leverage", ascending=False)  # Sort by leverage


""" A large leverage (close to 1) implies two things. 
First, the variance of residual is small, or even near zero when leverage is close to
one. In the case of a single covariate, the regression line nearly passes through
the point (yi, xi), regardless of any other observation. Thus an observation
with high leverage has a considerable influence on the estimation results. """

# Display high leverage observations

# print(high_leverage_data)

# from IPython.display import display
# display(high_leverage_data)

# high_leverage_data.to_csv("high_leverage_data.csv", index=True)


# Check frequency of dummy variables for 'condition_cat'
condition_cat_dummies = [col for col in data.columns if col.startswith("condition_cat_")]
print(high_leverage_data[condition_cat_dummies].sum())










