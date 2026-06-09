# Step 12: Outlier Analysis

import pandas as pd
import numpy as np
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import OLSInfluence
from scipy import stats
from scipy.stats import t

# Compute Studentized residuals
studRes = pd.Series(OLSInfluence(model_H05).resid_studentized_external, index=data.index)

# Compute critical t-value for a 5% significance level
alpha = 0.05
crit_t_val = stats.t.ppf(1 - alpha / 2, df=model_H05.df_resid)  # Two-tailed critical t-value

# Identify outliers
outliers = data.index[abs(studRes) > crit_t_val]  # Ensure proper indexing
outlier_ratio = len(outliers) / len(studRes)

print(f"Outlier ratio at 5% significance level: {outlier_ratio:.3%}")

# Create outlier dataframe
outlier_data = data.loc[outliers].copy()
outlier_data["Studentized Residual"] = studRes.loc[outliers]  # Fix indexing issue

print(outlier_data)

# Remove outliers from the dataset
data_no_outliers = data.drop(index=outliers)

# Create new design matrix
X_H05_noOutliers = sm.add_constant(data_no_outliers[independent_vars_H05])

# Fit new model
model_H05_noOutliers = sm.OLS(data_no_outliers[dependent_var], X_H05_noOutliers).fit()

# Compare coefficients
coef_comparison = pd.DataFrame({
    "Full Data": model_H05.params,
    "No Outliers": model_H05_noOutliers.params
})
coef_comparison["% Difference"] = (coef_comparison["Full Data"] - coef_comparison["No Outliers"]) / coef_comparison["Full Data"] * 100

print(coef_comparison)

print(model_H05.summary())
print(model_H05_noOutliers.summary())

