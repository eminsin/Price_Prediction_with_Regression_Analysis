# Step 14: Cook's Distance

import pandas as pd
import numpy as np
import statsmodels.api as sm
from statsmodels.stats.outliers_influence import OLSInfluence

# Compute Cook's Distance
influence = model_H05.get_influence()
cooks_d = influence.cooks_distance[0]  

# As a rule of thumb: 
# observations with Cook's Distance (CsD) > 0.5 are worthy of attention
# and observations with CsD > 1 should always be examined.

# Find observations where Cook's Distance > 1
high_cooks_d = np.where(cooks_d > 1)[0]  

# Print summary statistics of Cook's Distance
cooks_summary = pd.Series(cooks_d).describe()

print("Observations with high Cook's Distance (>1):", high_cooks_d)
print("\nSummary of Cook's Distance:\n", cooks_summary)




