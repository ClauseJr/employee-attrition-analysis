SELECT * FROM employee_attrition_dataset;

-- Calculating the Total Number of Employees
SELECT
	COUNT(*) total_employees
FROM employee_attrition_dataset;

-- Calculating the Average Income for Employees
SELECT
	ROUND(AVG("Monthly Income")::numeric,2) total_income
FROM employee_attrition_dataset;

-- Calculating the Sum of Income for Employee by Gender
SELECT
	DISTINCT "Gender",
	SUM("Monthly Income") AS total_income
FROM employee_attrition_dataset
GROUP BY "Gender"
ORDER BY total_income DESC;

-- Calculating the sum of Income for Employess by Job Role and Gender
SELECT
	DISTINCT "Job Role",
	"Gender",
	COUNT(*) num_employees,
	SUM("Monthly Income") AS total_income
FROM employee_attrition_dataset
GROUP BY "Job Role","Gender"

-- Calculating the Total Attrition
SELECT
	"Attrition",
	COUNT(*) total_attrition
FROM employee_attrition_dataset
GROUP BY "Attrition";

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

-- Calculating the Total Attrition Rate by Job Role
SELECT
	"Job Role",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Job Role"
ORDER BY attrition_rate DESC;

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

-- Married couples have a high impact on leaving the company, compaired to Divorced and Single employees.

-- Calculating the Attrition Rate by Remote Jobs
SELECT
	"Remote Work",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Remote Work"
ORDER BY attrition_rate DESC;
-- Employees who are doing remote job have high probability of leaving the company compared to those doing full-time jobs 

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


-- Calculating the attrition rate by Leadership Capabilities
SELECT
	"Leadership Label",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Leadership Label"
ORDER BY attrition_rate DESC;

-- Calculating the attrition rate by Innovation Potentials 
SELECT
	"Innovation Label",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Innovation Label"
ORDER BY attrition_rate DESC;

-- Calculating the attrition rate based on Employees Reputation
SELECT
	"Reputation Label",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Reputation Label"
ORDER BY attrition_rate DESC;

-- Calculating the attriton rate by employees recognitions 
SELECT
	"Recognition Label",
	COUNT(*) total_employees,
	SUM(CASE WHEN "Attrition" = 'No' THEN 1 ELSE 0 END) num_employees_stayed,
	SUM(CASE WHEN "Attrition" = 'Yes' THEN 1 ELSE 0 END) num_employees_left,
	ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER(),2) attrition_rate 
FROM employee_attrition_dataset
GROUP BY "Recognition Label"
ORDER BY attrition_rate DESC;

-- High Risk Employees to Leave
WITH employee_risk AS
(
	SELECT
		"Marital Status",
		"Job Role",	
		"Monthly Income",
		"Age",
		risk_score,
		ROW_NUMBER() OVER(PARTITION BY "Job Role" ORDER BY risk_score DESC ) risk_rank
	FROM
	(
		SELECT
			"Employee ID",
			"Age",
			"Marital Status",
			"Job Role",	
			"Monthly Income",
			"Job Satisfaction",
			"Performance Rating",
			"Work-Life Balance",
			"Overtime",	
			"Employee Recognition",	
			"Company Reputation",
			"Leadership Opportunities",
			CASE
				WHEN "Work-Life Balance" <=2 THEN 1
				ELSE 0
			END +
			CASE 
				WHEN "Job Satisfaction" <= 2 THEN 1
				ELSE 0
			END +
			CASE 
				WHEN "Performance Rating" <= 2 THEN 1
				ELSE 0
			END +
			CASE
				WHEN "Number of Promotions" <= 2 THEN 1
				ELSE 0
			END +
			CASE
				WHEN "Leadership Opportunities" <= 2 THEN 1
				ELSE 0
			END +
			CASE
				WHEN "Overtime" = 'Yes' THEN 1
				ELSE 0
			END +
			CASE
				WHEN "Remote Work" = 'Yes' THEN 1
				ELSE 0
			END +
			CASE 
				WHEN "Employee Recognition" <= 2 THEN 1
				ELSE 0
			END +
			CASE 
				WHEN "Company Reputation" <= 2 THEN 1
				ELSE 0
			END +
			CASE
				WHEN "Employee Recognition" <= 2 THEN 1
				ELSE 0
			END +
			CASE
				WHEN "Leadership Opportunities" <= 2 THEN 1
				ELSE 0
			END risk_score
		FROM employee_attrition_dataset
		WHERE "Attrition" = 'No'
	)
)
SELECT
	"Job Role",
	"Marital Status",	
	"Monthly Income",
	"Age",
	risk_score,
	risk_rank
FROM employee_risk
WHERE risk_rank <= 3





