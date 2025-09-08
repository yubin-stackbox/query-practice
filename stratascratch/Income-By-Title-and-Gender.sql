/* Income-By-Title-and-Gender.sql
Problem: Income By Title and Gender (stratascratch #10077)
Link: https://platform.stratascratch.com/coding/10077-income-by-title-and-gender?code_type=3
Difficulty: Medium

Description:
Find the average total compensation (salary + bonus) based on the employee titles and gender. Exclude employees who haven't received bonus and one employee can have more than one bonus.
Output the employee title, gender, and the average total compensation.

Approach:
1. Create a cte for employees and their total bonus
2. Join the cte with the employee table and group by the title and sex for aggregation of the average of compensation(salary + total bonus)
3. Display employee_title, gender, and average compensation

Notes / Pitfalls:
- The sequence of aggregation should be considered. Without aggregating the bonus based on the employees, it cannot be guaranteed that the employee's bonuses are calculated correctly.
*/

WITH cte AS (
    SELECT worker_ref_id, SUM(bonus) total_bonus
    FROM sf_bonus
    GROUP BY worker_ref_id
)
SELECT employee_title, sex, AVG(salary + total_bonus) avg_compensation
FROM cte c JOIN sf_employee e ON c.worker_ref_id = e.id
GROUP BY 1, 2
