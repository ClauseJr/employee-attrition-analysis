# Employee Turnover Analysis (End-to-End Analysis)

## Executive Summary

### Overview Findings
This project presents an end-to-end analysis of employee attrition using Excel, SQL, Python, and Power BI. It explores how factors such as job satisfaction, leadership, work-life balance, innovation, and overtime influences employee turnover.

Key metrics like attrition rate and category-based risk patterns were analyzed through segmentation and visualization techniques. The project identifies high-risk employee groups and highlights the main drivers of attrition, providing actionable insights to support data-driven retention strategies.

The interactive Power BI dashboard enables us to perform:
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
  -  It was recorded that employees between the age of 25 and 45 had a higher attrition rates compared to the other ages
  -  Higher turnovers were recorded for male employees compared to female employees.
  -  Employees with high and low performance ratings in the company recorded higher attrition rates compared to employees with average performance ratings though their attrition value was high.
  -  There is a higher attrition rate among employees who work overtime (20%) compared to employees who do not engage in overtime work
  -  The overall number of employee in the company was 60,000 and out of that, only 6,534 employees left as a result of such factors like job satisfaction, working overtime, recognition, and reputations among other factors.
    
 This dashboard functions as an executive summary, offering quick insight for total employees, employee attrition and attrition rates.

![Dashboard 1](visuals/attrition_overview_dashboard.png)

###  2. Attrition Analysis Dashboard
This dashboard focuses on identifying key drivers of attrition. It explores attrition rates across job satisfaction, work-life balance, employee recognition, and company reputation, enabling identification of high-risk employee segments.

Key Insights:
  -  Divorced employees recorded a high attrition rates compared to single and married employees, the following is the summarry of attrition rates by marital status:
     -	Divorced employees 11.14% with a total attrition of 2,119 employees
     -	Married employees 10.71% with a total attrition of 2,364 employees
     -	Single employees 10.84% with a total attrition of 2,051 employees
  -  Employees with poor work-life balance encountered the highest attrition rates at 30.37% compared to employees with fair and excellent work-life balance.
  -  Employees with Masters Degree(10.88%) and Bachelors Degree(11.18%) recorded a higher attrition rate compared to employees with PhD and high school certificates.
  -  Employees working in small companies recorded a higher attrition rate at 11.14% compared to employees working at large companies with many employees.

![Dashboard 2](visuals/attrition_dashboard.png)

###  3. Employee Insights Dashboard
This dashboard analyzes attrition across employee demographics and behavioral factors such as Leadership opportunities, gender, company recognition, job satisfaction, work-life balance, attrition, and performance ratings. It also includes trend-like analysis of total attrition across education and job roles.


![Dashboard 3](visuals/analysis_dashboard.png)

---
## Key Areas of Analysis

### 1.	Employee Attrition Overview Analysis
-	Overall employee attrition rate and workforce stability assessment
-	Comparison between employees who stayed vs those who left
-	Identification of baseline turnover levels across the company


### 2.	Job Satisfaction and Attrition Analysis
-	Employees with low job satisfaction recorded the highest attrition rates compared to those with high satisfaction
-	Medium satisfaction employees also showed notable turnover risk, indicating dissatisfaction is not always extreme to trigger attrition
-	Job satisfaction is a strong predictor of employee retention and exit behavior


### 3.	Work-Life Balance Impact on Attrition
-	Employees with poor work-life balance recorded the highest attrition rates compared to those with fair and excellent balance
-	Even employees with “good” work-life balance showed noticeable turnover risk, indicating perceived imbalance can vary by individual expectations
-	Work-life balance is a critical retention driver across multiple employee segments

  
### 4.	Overtime and Workload Pressure Analysis
-	Employees who worked overtime showed a higher likelihood of leaving the organization (20%) compared to those who did not work overtime
-	Overtime exposure is strongly associated with increased workload pressure and turnover risk
-	Employees without overtime work demonstrated comparatively lower attrition rates


### 5.	Demographic-Based Attrition Analysis
-	Attrition varied across age groups, with employees between 25–45 years showing higher turnover rates
-	Male employees recorded slightly higher attrition compared to female employees
-	Marital status influenced attrition, with divorced employees showing relatively higher turnover risk compared to married and single employees

  
###	6.	Performance Rating and Attrition Patterns
-	Employees with both high and low performance ratings showed higher attrition compared to average performers
-	This suggests a dual risk pattern: high performers may leave due to opportunities, while low performers may exit due to disengagement
-	Performance alone is not a direct retention guarantee

###	7.	High-Risk Employee Segmentation
-	Employees with a combination of low job satisfaction, poor work-life balance, and overtime exposure showed the highest attrition risk
-	Certain demographic and behavioral clusters consistently appear in high-risk turnover groups
-	Attrition risk is multi-factored and cannot be explained by a single variable alone as the resultant factor

---
## Recommendations

### 1. Improve Job Satisfaction Through Continuous Engagement
Employees with low and medium job satisfaction show higher attrition rates, indicating dissatisfaction as a major driver of turnover. Organizations should implement regular employee feedback systems, recognition programs, and engagement surveys to identify concerns early and improve overall employee satisfaction.

### 2. Strengthen Work-Life Balance Policies 
Poor work-life balance is strongly associated with higher employee attrition. Companies should redesign workloads, reduce excessive pressure, and introduce flexible working arrangements where possible to ensure employees maintain a healthy balance between work and personal life.
   
### 3. Monitor and Reduce Excessive Overtime
Employees who work overtime show a significantly higher likelihood of leaving the organization. Management should closely monitor overtime patterns, redistribute workloads more effectively, and increase staffing levels in high-demand departments to reduce burnout and turnover risk.

### 4. Develop Targeted Retention Strategies for High-Risk Groups
Certain groups such as employees aged 25–45, divorced employees, and mid-level educated staff show higher attrition tendencies. Organizations should design targeted retention programs including mentorship, career development opportunities, and internal mobility pathways to improve retention in these segments.

### 5. Strengthen Career Development and Performance Management Systems
Both high-performing and low-performing employees show elevated attrition risk for different reasons. Organizations should implement structured career progression frameworks, continuous skill development programs, and tailored retention incentives to retain top talent and re-engage underperforming employees.

---
##	Limitations
This analysis has several limitations that should be acknowledged when interpreting the results:
-	The dataset used in this analysis is synthetically generated and does not reflect real organizational behavior. As a result, certain relationships between variables may be simplified or artificially structured, limiting the extent to which findings can be generalized to real-world workforce environments.
-	The dataset shows that approximately 6,534 of employees have left the organization, indicating an attrition rate of 10.89%. The remaining 89.11% represent retained employees, suggesting an imbalance in the target variable.
-	The datatest had alot of nulls and empty values that do not correlate to the real organisation dataset.
---
## Conclusions

This project analyzed the key factors influencing employee attrition using a combination of Excel, SQL, Python, and Power BI to explore workforce behavior and identify the main drivers of employee turnover. The analysis revealed that employee attrition is influenced by multiple interrelated factors rather than a single determinant. Job satisfaction and work-life balance emerged as strong predictors of employee retention, with lower satisfaction and poor balance consistently associated with higher attrition rates. Workload pressure, particularly in the form of overtime, was also identified as a significant contributor to employee turnover, indicating that excessive demands increase the likelihood of employees leaving the organization.

In addition, demographic and organizational factors such as age group, marital status, education level, and company size showed noticeable variations in attrition patterns, highlighting that certain employee groups are more vulnerable to turnover than others. Performance rating also presented a mixed effect, where both high-performing and low-performing employees exhibited elevated attrition risk, suggesting that retention challenges exist across different performance levels for different underlying reasons.

Overall, the findings demonstrate that employee retention is a multifaceted issue shaped by workplace environment, job satisfaction, workload distribution, and employee demographics. The project highlights the importance of adopting a holistic retention strategy that addresses both employee well-being and career development needs in order to effectively reduce turnover and improve organizational stability.

---
## References
1.	SQL for Data Engineering [Data with Baraa](https://www.youtube.com/watch?v=SSKVgrwhzus)
2.	Data Analytics with [Chandoo](https://www.youtube.com/results?search_query=chandoo)
3.	[HackerRank](https://www.hackerrank.com/dashboard)
