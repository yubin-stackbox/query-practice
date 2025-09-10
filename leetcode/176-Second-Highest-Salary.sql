/*
Problem: Second Highest Salary (LeetCode #176)
Link: https://leetcode.com/problems/second-highest-salary
Difficulty: Medium

Description:
Find the second highest distinct salary from the Employee table. If there is no second highest salary, return null.

Approach:
1. In the subquery, apply dense_rank the salary (same salaries have the same rank)
2. Select only the salary which rank is 2
3. Return the maximum salary to:
  - handel NULL (return NULL if no value is found from the subquery)
  - ensure a single value when duplicates exist

Notes / Pitfalls:
- NULL management: In case of returning NULL when no record in the table, aggregation (e.g. MAX() in the solution query) or limit (with offset in the alternative solution query) can be options.

Alternative solution query:
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) SecondHighestSalary;

*/

SELECT MAX(salary) SecondHighestSalary
FROM (
    SELECT salary, DENSE_RANK() OVER(ORDER BY salary DESC) rnk 
    FROM Employee
) t
WHERE rnk = 2
