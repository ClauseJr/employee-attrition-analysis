# Employee Turnover Analysis (End-to-End Analysis)

## Executive Summary

### Overview Findings
This project presents an end-to-end analysis of employee attrition using Excel, SQL, Python, and Power BI. It explores how factors such as job satisfaction, leadership, work-life balance, innovation, and overtime influences employee turnover.

Key metrics like attrition rate and category-based risk patterns were analyzed through segmentation and visualization techniques. The project identifies high-risk employee groups and highlights the main drivers of attrition, providing actionable insights to support data-driven retention strategies.

The interactive Power BI dashboard enables us to:
  -  Analysis of employee attrition drivers, including job satisfaction, leadership, work-life balance, innovation, overtime, company reputation, and employee recognition.
  -  Identification of patterns in attrition rates and key factors influencing employee turnover.
  -  Segmentation of employees to highlight high-risk groups prone to attrition.
  -  Development of an interactive dashboard to support data-driven insights into workforce retention and turnover risk.
  -  Comparison of attrition rates across different employee groups to uncover disparities and prioritize targeted retention strategies.

### Data Sources

A synthetically generated employee attrition dataset designed for data analytics and visualization practice, comprising of over 60,000 records. It models key workforce attributes such as demographics, job satisfaction, leadership, work-life balance, innovation, and overtime to support analysis of attrition patterns and underlying drivers of employee turnover.

---
## Tools Used
a. Excel

Excel was used as the initial data preparation tool to:
  -  Clean and standardize column formats (texts, numerical fields)
  -  Handle missing, duplicates and inconsistent values
  -  Validate data integrity before visualization

This step was used for light-weight data preparations before ingestion into notebook for heavy analysis

b.  Python(Jupyter Notebook)

The data was loaded into jupyter notebook, to help in:
  -  Dataset cleaning and standardizing columns formarts i.e gender
  -  Handling inconsistency, duplicates and missing data sections
  -  Data transformation and preprocessing
  -  Explanatory data analysis(EDA)
  -  Validation of data for integrity before performing descriptive analysis

c. SQL(PostgreSQL)

The data was intergrated into PostgreSQl for SQL analysis and querying, to help in:
  -  Data extraction and Performing structured analysis
  -  Explanatory analysis, Descriptive analysis and Predictive preparation
  -  Validation of data for integrity before visualization

d. Power BI

Within Power BI:
  -  Creation of custom columns and conditional columns for data segmentation
  -  DAX measures were created for the following KPIs:
      -  Total Employees
      -  Total Attrition
      -  Attrition Rate
      -  Average Salary
      -  Average Tenure
  -  Visual storytelling through charts and KPIs
  -  Enabling stakeholder interactions and decision-making

Slicers were implemented for dynamic analysis, using Gender slicers.

---
## Data Analysis
```python
df = pd.read_csv('messy_employee_attrition_dataset.csv')
print(df.to_string(max_rows = 10))

# -- Exporting cleaned employee attrition dataset inform of csv
df.to_csv('cleaned_employee_attrition_dataset.csv', index=False)

# -- Exporting cleaned employee attrition dataset into the database
password = quote_plus("Phabiansharish@254")
engine = create_engine(f'postgresql://postgres:{password}@localhost:5432/HR_ANALYTICSDB')
df.to_sql(
    'employee_attrition_dataset',
    engine,
    if_exists='replace', 
    index=False
)
```

```sql
-- Calculating the Attrition Rate
SELECT
	"Attrition",
	COUNT(*) total_attrition,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
-- WHERE "Attrition" = 'Yes'
GROUP BY "Attrition";

-- the attrition rate recorded from employees were as follow:
	-- The Total number of Employees who stayed == 89.11%
	-- Total attrition == 6534
	-- Total attrition rate == 10.89%
```
```sql
-- Calculating the Attrition Rate by Marital Status
SELECT
	"Marital Status",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Marital Status"
ORDER BY attrition_rate DESC;

SELECT
	DISTINCT "Marital Status",
	"Gender",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Marital Status", "Gender"

```
```sql

-- Calculating the Attrition Rate by Job Satisfaction 
SELECT
	"Job Satisfaction Label",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Job Satisfaction Label"
ORDER BY attrition_rate DESC;
	-- Employees with medium job satisfactions are showing high risks of leaving the company at 28.87%

-- Calculating the attrition rate by Work Life Balance
SELECT
	"Work-Life Balance Label",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Work-Life Balance Label"
ORDER BY attrition_rate DESC;
	-- Employees with Good work life Balance have high chance of leaving the company at a rate of 28.88%

-- Calculating the attrition rate by Performance Rating 
SELECT
	"Performance Rating Label",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Performance Rating Label"
ORDER BY attrition_rate DESC;
```
---
## Project Dashboards
The project includes interactive Power BI dashboards designed to analyze employee attrition from multiple perspectives, including workforce overview, attrition drivers, and demographic insights.

Key KPIs:
  -  Total Employees
  -  Total Attrition
  -  Attrition Rate
  -  Average Tenure

###  1. Overview Dashboard
This dashboard provides a high-level summary of employee attrition. It highlights key distributions across leadership, performance, job satisfaction, and work-life balance..

Analytical Insights:
  -  Higher attrition rates of 30% were recorded for employees who had a low Job satisfaction compared to employees with high Job satisfaction.
  -  It was recorded that employees between the age of 25 to 45 had a higher attrition rates compared to the other ages
  -  Higher turnovers were recorded for male employees compared to female employees.
  -  Employees with high and low performance ratings in the company recorded higher attrition rates compared to employees with average performance ratings though their attrition value was high.
  -  There is a higher attrition rate among employees who work overtime (20%) compared to employees who do not engage in overtime work
  -  The overall number of employee in the company was 60,000 and out of that, only 6,534 employees left as a result of such factors like job satisfaction, working overtime, recognition, and reputations among other factors.
    
 This dashboard functions as an executive summary, offering quick insight for total employees, employee attrition and attrition rates.

![Dashboard 1](visuals/attrition_overview_dashboard.png)

###  2. Attrition Dashboard
![Dashboard 2](visuals/attrition_dashboard.png)

###  3. Analysis Dashboard
![Dashboard 3](visuals/analysis_dashboard.png)


