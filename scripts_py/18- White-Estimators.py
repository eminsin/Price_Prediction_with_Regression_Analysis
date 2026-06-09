# Step 18: White-Estimators

import pandas as pd
import numpy as np
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import OLSInfluence

# Get the robust variance-covariance matrix (White’s heteroskedasticity-consistent estimator)
vcov_robust = model_H05.get_robustcov_results(cov_type="HC0").cov_params()

# Compute robust standard errors
sd_beta_White = np.sqrt(np.diag(vcov_robust))

# Extract standard errors from the default model summary
sd_beta_standard = model_H05.bse

# Compare standard vs robust standard errors
comparison = np.vstack([sd_beta_standard, sd_beta_White])
comparison_df = pd.DataFrame(comparison, index=["Standard", "Robust"], columns=X_H05.columns)

# Display results
print(comparison_df)




