/*
Problem: Analyze Organization Hierarchy (LeetCode #3482)
Link: https://leetcode.com/problems/analyze-organization-hierarchy/description/?envType=problem-list-v2&envId=n4wrvgr7
Difficulty: Hard

Description:
Analyze an organizational hierarchy to generate a summary for each employee, including:
1. Level in the organisation (CEO = 1, direct reports to the CEO = 2, etc.).
2. Team Size (total direct and indirect reports).
3. Salary Budget (sum of salaries under their management, including their own).
Results are returned as a table ordered by level (asc), budget (desc), and employee name (asc).

Approach:
1. Determine the organisational level with RECURSIVE CTE
    - Anchor: CEO whose manager_id is NULL has level as 1
    - Recursive query: add 1 to their manager's level
2. Create a table to show managers, their team members, and member's salary with RECURSIVE CTE
    - Anchor: Employees who are managers, and their direct reports
    - Recursive query: add employees who are in the colleague list and manager list (in Employees) for indirect reports
3. Write a main query for summary and aggregation
    - Left join the hierarchy table with the team table
    - GROUP BY the employee_id from the hierarchy table for aggregation
        - Count colleague for team size
        - Add employee's salary and SUM of the colleague_salary (with null handling) for budget
    - Display employee_id, employee_name, level from the hierarchy table, and the aggregation results
    - Order by level, budget descending, and employee_name

Notes / Pitfalls: RECURSIVE CTE
- Composition: Anchor(base row), Recursive query(to add rows)
- Separate rows into two sets:
    - Delta: Rows just added in the previous iteration
    - CTE so far: All rows accumulated up to the current iteration
- Iteration rule: Only the delta from the previous step is used to generate the next recursive step
- Detailed explanation: https://clean-hat-00e.notion.site/RECURSIVE-CTE-Analyse-Organisation-Hierarchy-265d5d617ff780558fb2d452e4ef7599?source=copy_link
*/

WITH RECURSIVE hierarchy AS (
    SELECT employee_id, employee_name, manager_id, salary, 1 AS level
    FROM Employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.employee_name, e.manager_id, e.salary, h.level + 1
    FROM Employees e JOIN hierarchy h ON e.manager_id = h.employee_id
)
, team AS(
    SELECT e.employee_id, c.employee_id AS colleague, c.salary AS colleague_salary
    FROM Employees e JOIN Employees c ON e.employee_id = c.manager_id
    UNION ALL
    SELECT t.employee_id, e.employee_id, e.salary
    FROM Employees e JOIN team t ON t.colleague = e.manager_id
)
SELECT h.employee_id, employee_name, level, COUNT(colleague) AS team_size, (SUM(IFNULL(colleague_salary,0)) + h.salary)AS budget
FROM hierarchy h LEFT JOIN team t USING(employee_id)
GROUP BY h.employee_id
ORDER BY level, budget DESC, employee_name
