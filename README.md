# Online Retail II — End-to-End Data Analysis

## Project Overview

This project analyzes the Online Retail II dataset to understand sales performance, customer purchasing behavior, product demand, and country-level sales patterns.

The goal is to transform raw retail transaction data into actionable business insights that can support better business decisions.

## Business Objectives

- Analyze overall sales performance and order trends.
- Understand customer purchasing behavior and repeat purchases.
- Identify top-performing products by sales and quantity.
- Compare sales performance across countries.
- Examine returns and cancellations.
- Build an interactive Power BI dashboard to communicate key findings.

## Tools & Technologies

- **Python:** Data cleaning and preprocessing
- **Pandas:** Data manipulation and data quality checks
- **SQL Server:** Data storage, querying, and business analysis
- **Power BI:** Interactive dashboards and data visualization
- **DAX:** KPI calculations and analytical measures

## Project Workflow

1. **Data Cleaning — Python & Pandas**
   - Inspected the raw dataset.
   - Handled duplicate records and data quality issues.
   - Reviewed missing values and invalid transactions.
   - Prepared the cleaned dataset for further analysis.

2. **Data Analysis — SQL Server**
   - Analyzed sales and order performance.
   - Examined customer purchasing frequency.
   - Identified top-performing products.
   - Compared sales across countries.
   - Investigated returns and cancellations.

3. **Data Visualization — Power BI**
   - Created an Executive Overview dashboard.
   - Analyzed customer behavior and repeat purchases.
   - Explored product sales and demand patterns.
   - Compared country-level sales performance.

## Key Business Findings

- Total sales were approximately **10.27 million** in the dataset's transaction currency.
- The United Kingdom was the largest market, contributing approximately **8.81 million** in sales.
- Customer purchasing frequency showed that repeat customers represented approximately **67%** of customers with identifiable customer IDs.
- Sales activity increased toward the end of the observed period, with November 2010 recording the highest monthly sales in the analysis.
- Returns and cancellations were important data-quality and business considerations when evaluating sales performance.

*Note: December 2010 is only partially represented in the available dataset. The dataset does not contain product cost information, so profit and profit margin were not calculated.*

## Power BI Dashboard

The report includes four analytical pages:

1. **Executive Overview** — Overall sales performance and key KPIs.
2. **Customer Analysis** — Customer purchasing frequency and sales contribution.
3. **Product Analysis** — Product performance and demand patterns.
4. **Country Analysis** — Geographic sales comparisons and country-level trends.

*Dashboard screenshots will be added here.*

## Dataset

The project uses the **Online Retail II** dataset from the UCI Machine Learning Repository.

Dataset source: https://archive.ics.uci.edu/dataset/502/online+retail+ii

The original dataset contains retail transactions from December 2009 to December 2011. This project analyzes the available portion used in the project workflow.

## Repository Structure

```text
online-retail-ii-analysis/
├── python/
│   └── data_cleaning.ipynb
├── sql/
│   ├── 01_data_validation.sql
│   ├── 02_sales_analysis.sql
│   ├── 03_customer_analysis.sql
│   ├── 04_product_analysis.sql
│   └── 05_country_analysis.sql
├── powerbi/
│   └── Online_Retail_Analysis.pbix
├── images/
│   ├── executive_overview.png
│   ├── customer_analysis.png
│   ├── product_analysis.png
│   └── country_analysis.png
└── README.md
```

*The folder and file names above are a suggested structure; adjust them to match the actual files in this repository.*

## Author

**Mohamed Ayman**

Aspiring Data Analyst | Python | SQL Server | Power BI

GitHub: https://github.com/aymoonm

LinkedIn: https://www.linkedin.com/in/mohamed-ayman-ds/
