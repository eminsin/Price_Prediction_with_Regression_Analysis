---

<p align="center">
  <img width="600" height="500" alt="image_summary of the project" src="https://github.com/user-attachments/assets/c1ee2e36-5001-4e0d-b871-f6be9350877b" />
</p>

<h1 align="center">Theory-to-Implementation Study of Regression Analysis</h1>



---

## 🎯 Project Overview

This project was designed as an in-depth study of **_regression analysis_**, with a primary focus on understanding and practicing the underlying statistical and mathematical theory rather than treating regression as a black-box modeling technique.   
The objective was to manually implement core regression concepts and compare the results with established R and Python libraries to gain a detailed understanding of estimation, inference, and model evaluation.

---

## 🔬 Laboratory

+ Developed and validated **_multiple linear regression_** models for real estate price prediction incorporating **_feature engineering_**, **_dummy variable encoding_**, and **_heteroscedasticity correction_** with **_weighted least squares_**.
+ Conducted comprehensive **_regression diagnostics_** and **_influence analysis_**, including **_leverage (hat values)_**, **_Cook’s distance_**, **_Breusch-Pagan test_** for heteroscedasticity, and robust standard error estimation (**_White’s correction_**), improving model reliability and interpretability.
+ Implemented **_prediction interval estimation_** for new observations using both standard and weighted models, demonstrating expertise in **_model evaluation_**, **_statistical inference_**, and advanced econometric techniques relevant to **_pricing, forecasting, and risk analysis_**.

---

## 📂 Folder Structure

```
Price_Prediction_with_Regression_Analysis/
├── notebooks/
│   └── Regression_Analysis_with.ipynb                                 # Main walkthrough notebooks 
|   └── Regression_Analysis_with.R 
├── data/
│   └── biele_WM_new.csv                                               # Real-world dataset
├── scripts/
│   └── 1- Data_Preprocessing                                          # Step-by-step analysis
│   └── 2- OLS_Estimation
│   └── 3- Hypothesis_Testing
│   └── 4- Model_Selection
│   └── 5- Problem_Analysis
│   └── 6- (back to) Model_Selection
│   └── 7- Model_Diagnosis
│   └── 8- Linearity
│   └── 9- Homoscedasticity
│   └── 10- Variance_Inflation_Factor
│   └── 11- Outlier_Analysis
│   └── 12- Leverage
│   └── 13- Cook's_Distance
│   └── 14- Heteroscedastic_Errors
│   └── 15- Breusch-Pagan_Test
│   └── 16- Two-Stage_Least_Squares
│   └── 17- White-Estimators
│   └── 18- Final_Model
├── images/
│   └── Multicollinearity__VIF.png                                     # Visual outputs from the project
│   └── heteroscedasticerrors__residuals_vs_fitted_values.png
│   └── homoscedasticity__residuals_vs_fitted_values.png
│   └── linearity__residuals_vs_area.png
│   └── residuals_vs_age.png
│   └── residuals_vs_area.png
│   └── residuals_vs_rooms.png
│   └── unweighted_and_weigtehed_model_residuals.png
├── README.md                                                          # Project overview (you are here)
└── LICENSE                                                            # MIT License
```

---



## 🧠 Notebook Topics

### 🧮 1. Data Preprocessing
+ Cleaned and validated the dataset for missing values.
+ Transformed variables and prepared features for regression analysis.

### 🧮 2. OLS Estimation
+ Implemented OLS estimation and calculated regression coefficients manually.
+ Built an OLS regression model and interpreted coefficients, significance tests, and goodness-of-fit metrics.
+ Validated manual results against built-in statistical outputs.

### 🧮 3. Hypothesis Testing
+ Tested statistical significance of regression coefficients.
+ Conducted t-tests and evaluated p-values.
+ Assessed evidence for predictor effects on the response variable (F-Test).

### 🧮 4. Model Selection
+ Compared alternative model specifications.
+ Evaluated predictor relevance and model performance.
+ Selected variables based on statistical and practical significance.

### ❗ 5. Problem Analysis
+ Investigated potential issues affecting model validity.
+ Assessed assumptions and data characteristics.
+ Identified areas requiring further diagnostic analysis.

### 🧮 6. (back to) Model Selection
+ Refined the model by removing or retaining predictors.
+ Compared candidate models using performance metrics.
+ Improved model interpretability and predictive quality.

### 🧮 7. Model Diagnosis
+ Evaluated overall model assumptions and fit.
+ Analyzed residual behavior and model adequacy.
+ Identified sources of bias or misspecification.

### 🧮 8. Linearity
+ Verified the linear relationship between predictors and response.
+ Examined residual and fitted value plots.
+ Assessed whether linear regression assumptions were satisfied.

### 🧮 9. Homoscedasticity
+ Checked for constant variance of residuals.
+ Evaluated residual patterns across fitted values.
+ Assessed suitability of standard OLS inference.

### 🧮 10. Variance Inflation Factor
+ Measured multicollinearity among predictors.
+ Calculated VIF scores for each explanatory variable.
+ Identified variables causing instability in coefficient estimates.

### 🧮 11. Outlier Analysis
+ Detected observations with unusual residual behavior.
+ Evaluated the impact of extreme data points.
+ Determined whether outliers should be investigated further.

### 🧮 12. Leverage
+ Identified observations with extreme predictor values.
+ Assessed their potential influence on model estimates.
+ Examined leverage statistics and influence measures.

### 🧮 13. Cook's Distance
+ Measured the influence of individual observations.
+ Identified points that substantially affected regression results.
+ Evaluated robustness of model estimates.

### 🧮 14. Heteroscedastic Errors
+ Investigated non-constant error variance.
+ Analyzed residual dispersion patterns.
+ Assessed implications for statistical inference.

### 🧮 15. Breusch-Pagan Test
+ Performed a formal test for heteroscedasticity.
+ Evaluated whether residual variance depended on predictors.
+ Determined the validity of OLS standard errors.

### 🧮 16. Two-Stage Least Squares
+ Addressed potential endogeneity issues.
+ Implemented instrumental variable regression.
+ Estimated consistent coefficients under endogenous predictors.

### 🧮 17. White-Estimators
+ Computed heteroscedasticity-robust standard errors.
+ Improved inference when variance assumptions were violated.
+ Compared robust and conventional statistical results.

### 🧮 18. Final Model
+ Constructed the final validated regression model.
+ Incorporated diagnostic findings and model improvements.
+ Presented the final estimates, inference, and conclusions.


---



## 🛠 Built With
- Python 3.12 and R 4.4.0
- `numpy`, `pandas`, `scipy`, `statsmodels`, `scikitlearn`, `seaborn`, `matplotlib` 
- Jupyter Notebook, RStudio

---



## 🌱 Inspired By
- *Regression Models, Methods and Applications* by Ludwig Fahrmeir et al.

---

## 🤝 Connect
Feel free to reach out or star this repo!

Let’s learn together. 🌱
