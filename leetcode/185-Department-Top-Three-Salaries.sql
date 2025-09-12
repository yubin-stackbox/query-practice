/*
Problem: Department Top Three Salaries (LeetCode #185)
Link: https://leetcode.com/problems/department-top-three-salaries
Difficulty: Hard

Description:
Identify employees with top three unique salaries in each department and return the results.

Approach:
1. Write a CTE to retrieve the department id, employee name, and their salary whose salary is in the top 3 salaries in their department.
2. Join the department table with the cte to show the department name.

Notes / Pitfalls: Optimisation
- Tuple IN can prevent the optimizer from using indexes efficiently.
- Retrieve only the necessary columns and rows; proper joins can optimize the query.
*/

WITH cte AS(
    SELECT departmentId, name Employee, salary Salary
    FROM(
        SELECT departmentId, name, salary, DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) rnk
        FROM Employee) t
    WHERE rnk <= 3
)
SELECT d.name Department, Employee, Salary
FROM Department d JOIN cte c ON c.departmentId = d.id
