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
- Anchor: CEO whoes manager_id is NULL has level as 1
- Recursive query: add 1 to their manager's level
2. 

Notes / Pitfalls: RECURSIVE CTE
- Composition: Anchor(base row), Recursive query(to add rows)
- Separate rows into two sets:
    - Delta: Rows just added in the previous iteration
    - CTE so far: All rows accumulated up to the current iteration
- Iteration rule: Only the delta from the previous step is used to generate the next recursive step
- Detailed explanation: https://clean-hat-00e.notion.site/Analyse-Organisation-Hierarchy-265d5d617ff780558fb2d452e4ef7599?source=copy_link
*/

WITH RECURSIVE hierarchy AS (
    SELECT employee_id, manager_id, 1 AS level
    FROM Employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.manager_id, c.level + 1
    FROM Employees e JOIN hierarchy h ON e.manager_id = c.employee_id
)
