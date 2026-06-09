# Step 8: Model Diagnosis

import numpy as np
import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt

# Extract residuals
residuals_H04 = model_H04.resid

# Compute leverage (hat matrix diagonal values)
h_ii_H04 = model_H04.get_influence().hat_matrix_diag

# Compute residual standard deviation (sigma)
sigma_H04 = np.sqrt(sum(residuals_H04**2) / (len(residuals_H04) - model_H04.df_model - 1))

# Compute standardized residuals
r_H04 = residuals_H04 / (sigma_H04 * np.sqrt(1 - h_ii_H04))

# Define function to plot residuals vs independent variables
def plot_residuals(x, y, xlabel):
    plt.scatter(x, y, alpha=0.5)
    plt.axhline(y=0, color='blue', linestyle='--')
    plt.xlabel(xlabel)
    plt.ylabel("Standardized Residuals")
    plt.title(f"Residuals vs {xlabel}")
    plt.show()

# Plot residuals against numerical variables
plot_residuals(data["area"], r_H04, "Area")
plot_residuals(data["age"], r_H04, "Age")
plot_residuals(data["rooms"], r_H04, "Rooms")

