/*
    Number of employees hired for each job and department in 2021 divided by quarter. The
        table must be ordered alphabetically by department and job.
*/

WITH cte_with_quarter AS (
	SELECT *, 
	EXTRACT(QUARTER FROM TO_TIMESTAMP(he.datetime, 'YYYY-MM-DD"T"HH24:MI:SS"Z"'))
		AS quarter 
	FROM bronze.hired_employees he 
	INNER JOIN bronze.jobs j ON j.id = he.job_id 
	INNER JOIN bronze.departments d ON d.id = he.department_id
),
cte_grouped AS (
	SELECT departments AS department,
	job,
	quarter,
	count(*)
	FROM cte_with_quarter
	GROUP BY 
	departments,
	job,
	quarter
)
SELECT department, job, 
COALESCE(SUM(count) FILTER (WHERE quarter =  1),0) as q1,
COALESCE(SUM(count) FILTER (WHERE quarter =  2),0) as q2,
COALESCE(SUM(count) FILTER (WHERE quarter =  3),0) as q3,
COALESCE(SUM(count) FILTER (WHERE quarter =  4),0) as q4
FROM cte_grouped
GROUP BY department, job
ORDER BY department, job;