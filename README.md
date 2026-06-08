---

<p align="center">
  <img width="600" height="500" alt="image_summary of the project" src="https://github.com/user-attachments/assets/c1ee2e36-5001-4e0d-b871-f6be9350877b" />
</p>

<h1 align="center">Regression Analysis -- Theory-to-Implementation Study</h1>



---

## 🎯 Project Overview

This project was designed as an in-depth study of **_regression analysis_**, with a primary focus on understanding and practicing the underlying statistical and mathematical theory rather than treating regression as a black-box modeling technique.   
The objective was to manually implement core regression concepts and compare the results with established R and Python libraries to gain a detailed understanding of estimation, inference, and model evaluation.

---

## 📘 What I Did

+ Developed and validated **_multiple linear regression_** models for real estate price prediction incorporating **_feature engineering_**, **_dummy variable encoding_**, and **_heteroscedasticity correction_** with **_weighted least squares_**.
+ Conducted comprehensive **_regression diagnostics_** and **_influence analysis_**, including **_leverage (hat values)_**, **_Cook’s distance_**, **_Breusch-Pagan test_** for heteroscedasticity, and robust standard error estimation (**_White’s correction_**), improving model reliability and interpretability.
+ Implemented **_prediction interval estimation_** for new observations using both standard and weighted models, demonstrating expertise in **_model evaluation_**, **_statistical inference_**, and advanced econometric techniques relevant to **_pricing, forecasting, and risk analysis_**.

---

## 📂 Folder Structure

```
AB-Testing_Causal-Inference-Starter/
├── notebooks/
│   └── Reg_An_with.ipynb                                              # Main walkthrough notebooks 
|   └── Reg_An_with.R 
├── data/
│   └── biele_WM_new.csv                                               # Real-world dataset
├── scripts/
│   └── 1- Data Preprocessing                                          # Step-by-step analysis
│   └── 2-
│   └── 3-
│   └── 4-
│   └── 5-
│   └── 6-
│   └── 7-
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

### 📊 1. Simulate Control and Treatment
- Conversion rates (e.g. 10% vs 11%)
- Generate binary data for 10,000 users each group

### ✍️ 2. Manual Hypothesis Testing
- Pooled standard error
- Z-statistic
- Manual p-value calculation

### 🧪 3. Use `scipy` to Validate
- `scipy.stats.ttest_ind` or z-proportion test
- Compare with manual results

### 📉 4. Visualize Confidence Intervals
- Bar plots with error bars
- Bootstrap sampling distributions

### ❗ 5. Simulate False Positives
- Run 1000 null experiments
- Show that ~5% are “significant” by chance
- Explore what happens when power is low

### 🧮 6. What-If Scenarios
- Low sample size vs. high MDE
- Winner’s curse demonstration
- Sign vs magnitude errors

---



## 🛠 Built With
- Python 3.12 and R 
- `numpy`, `pandas`, `scipy`, `statsmodels`, `scikitlearn`, `seaborn`, `matplotlib` 
- Jupyter Notebook, RStudio

---



## 🌱 Inspired By
- *Regression Models, Methods and Applications* by Ludwig Fahrmeir et al.

---

## 🤝 Connect
Feel free to reach out or star this repo!

Let’s learn together. 🌱
