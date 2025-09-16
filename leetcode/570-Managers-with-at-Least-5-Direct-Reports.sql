/*
Problem: Managers with at Least 5 Direct Reports (LeetCode #570)
Link: https://leetcode.com/problems/managers-with-at-least-5-direct-reports
Difficulty: Medium

Description:
Find managers with at least five direct reports.

Approach:
1. Self INNER JOIN the Employee table not to leave NULL if there's no record.
2. Count the number of employees for each manager.
3. Retrieve the manager's names who have greater than or equal to 5 direct reports.

Notes / Pitfalls:
- LEFT JOIN leaves NULL, whereas (INNER) JOIN doesn't.
*/

SELECT m.name
FROM Employee e JOIN Employee m ON e.managerId = m.id
GROUP BY e.managerId
HAVING COUNT(e.id) >=5
