# Step 16: Breusch-Pagan Test

import pandas as pd
import numpy as np
import statsmodels.api as sm
import statsmodels.stats.diagnostic as smd

# Perform Breusch-Pagan test
bp_test = smd.het_breuschpagan(model_H05.resid, model_H05.model.exog)

# Print test results
print("Breusch-Pagan Test Results:")
print(f"Test Statistic: {bp_test[0]:.4f}")
print(f"P-Value: {bp_test[1]:.4f}")

# Interpretation
if bp_test[1] < 0.05:
    print("❌ We reject the null hypothesis: Heteroscedasticity is present!")
else:
    print("✅ Fail to reject the null hypothesis: No significant heteroscedasticity detected.")














