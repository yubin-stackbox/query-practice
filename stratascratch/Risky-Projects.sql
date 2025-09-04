/*
Problem: Risky Projects (stratascratch #10304)
Link: https://platform.stratascratch.com/coding/10304-risky-projects?code_type=3
Difficulty: Medium

Description:
Identify overbudget projects by comparing each project’s budget with the prorated employee salary.
- Each employee’s annual salary is prorated according to the exact number of days they work on a project (based on a 365-day year).
- The prorated salaries per project are summed
- The final output lists each overbudget project (prorated cost exceed budget) with its name, budget, and total expenses (rounded up to the nearest dollar).

Approach:
1. Join three tables to get salaries and assignment periods
2. Prorate each employee’s salary based on days worked (salary / 365 * DATEDIFF(end_date, start_date)).
3. Sum prorated salaries per project and round up (CEILING).
4. Return projects where total expenses exceed the budget.

Notes / Pitfalls:
- CEILING() always rounds a decimal up to the nearest integer. Unlike ROUND(), it's always upward, so the overbudget check is slightly conservative.
    e.g. 123.1 → 124, 123.9 → 124
- Opportunity to optimase the qurey by cte for JOIN and Aggragation because aggregration after joining all rows, which can be inefficient when the dataset is big
*/

SELECT title, budget, CEILING(SUM(salary/365* DATEDIFF(end_date, start_date))) AS prorated_employee_expense
FROM linkedin_projects p JOIN linkedin_emp_projects ep ON p.id = ep.project_id JOIN linkedin_employees e ON ep.emp_id = e.id
GROUP BY title
HAVING budget < prorated_employee_expense

-- Another (optimised) solution for bigger dataset
WITH prorated_salary AS (
    SELECT project_id, SUM(salary / 365) prorated
    FROM linkedin_emp_projects ep JOIN linkedin_employees e ON ep.emp_id = e.id
    GROUP BY project_id
)
SELECT title, budget, CEILING(prorated * DATEDIFF(end_date, start_date)) prorated_employee_expense
FROM prorated_salary s JOIN linkedin_projects p ON s.project_id = p.id
HAVING budget < prorated_employee_expense
