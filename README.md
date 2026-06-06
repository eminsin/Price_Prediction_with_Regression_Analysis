## 🧰 Source of The Project    


---

<p align="center">
  <img src="https://github.com/user-attachments/assets/8086b092-fe7c-4e07-9ffd-daee2dbb372a" alt="banner" width="30%">
</p>

<h1 align="center">Regression Analysis</h1>



---

***Table of Contents***


---

## 🎯 Project Overview
+ Developed and validated multiple linear regression models for real estate price prediction using Python (pandas, statsmodels), incorporating feature engineering, dummy variable encoding, and heteroscedasticity correction with weighted least squares.
+ Conducted comprehensive regression diagnostics and influence analysis, including leverage (hat values), Cook’s distance, Breusch-Pagan test for heteroscedasticity, and robust standard error estimation (White’s correction), improving model reliability and interpretability.
+ Implemented prediction interval estimation for new observations using both standard and weighted models, demonstrating expertise in model evaluation, statistical inference, and advanced econometric techniques relevant to pricing, forecasting, and risk analysis.

---

## 📘 What You’ll Learn

- How to simulate binary outcome data (e.g. conversion)
- Run hypothesis tests: manual Z-test and `scipy` t-test
- Calculate and visualize confidence intervals
- Understand p-values, alpha levels, and Type I/II errors
- Simulate and explore the False Positive Risk (FPR)
- Visualize “what if” scenarios: low power, small effects, bad design

---

## 📂 Folder Structure

```
AB-Testing_Causal-Inference-Starter/
├── notebooks/
│   └── 01_ab_test_simulation.ipynb       # Main walkthrough notebook
├── data/
│   └── synthetic_ab_test.csv            # Simulated experiment dataset
├── scripts/
│   └── abtest_utils.py                  # Reusable functions
├── images/
│   └── pvalue_distribution.png          # Visual outputs for README/docs
├── README.md                            # Project overview (you are here)
└── LICENSE                              # MIT License
```

---

## 🚀 Getting Started

### 1. Clone the repo
```bash
git clone https://github.com/your-username/AB-Testing_Causal-Inference-Starter.git
cd AB-Testing_Causal-Inference-Starter
```

### 2. Install requirements
```bash
pip install numpy pandas matplotlib scipy jupyter
```

### 3. Launch the notebook
```bash
jupyter notebook notebooks/01_ab_test_simulation.ipynb
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

## 🧑‍🏫 For Students
Each notebook section includes:
- 👩‍🏫 **Teaching comments** and annotated code
- 📌 Real-world context from online experimentation
- 💡 Insights from industry practice (Expedia, Microsoft, Airbnb)

---

## 📸 Sample Visuals
See the `/images` folder for example outputs:
- p-value distributions
- confidence interval charts
- bootstrap effect distributions

---

## 🛠 Built With
- Python 3.8+
- `numpy`, `pandas`, `scipy`, `matplotlib`
- Jupyter Notebook

---

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🌱 Inspired By
- *Trustworthy Online Controlled Experiments* by Ron Kohavi et al.
- "False Positives in A/B Tests" (KDD '24)
- [Andrew Gelman & John Carlin on sign and magnitude errors](https://doi.org/10.1177/1745691614551642)

---

## 🤝 Connect
If you’re a recruiter, data science student, or just excited about experimentation, feel free to reach out or star this repo!

Let’s learn causal inference—one experiment at a time. 🌱
