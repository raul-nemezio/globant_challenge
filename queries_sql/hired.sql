/*
    List of ids, name and number of employees hired of each department that hired more
    employees than the mean of employees hired in 2021 for all the departments, ordered
    by the number of employees hired (descending).
*/
WITH cte_year AS(
    SELECT *, 
	EXTRACT(YEAR FROM TO_TIMESTAMP(he.datetime, 'YYYY-MM-DD"T"HH24:MI:SS"Z"'))
		AS year 
	FROM bronze.hired_employees he 
	INNER JOIN bronze.jobs j ON j.id = he.job_id 
	INNER JOIN bronze.departments d ON d.id = he.department_id
),
cte_departments_year AS (
    SELECT department, count(*) FROM cte_year
WHERE year = 2021
GROUP BY department
),
cte_mean AS (
    SELECT AVG(COUNT) AS MEAN_HIRED FROM cte_departments_year
),
cte_departments_hired AS (
    SELECT department_id, department, count(*) AS hired FROM cte_year
    GROUP BY department_id, department
)
SELECT * FROM cte_departments_hired
WHERE hired > (select * from cte_mean)
ORDER BY hired DESC;