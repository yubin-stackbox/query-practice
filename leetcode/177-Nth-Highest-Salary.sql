/*
Problem: Nth Highest Salary (LeetCode #177)
Link: https://leetcode.com/problems/nth-highest-salary/
Difficulty: Medium

Description:
Write a solution to find the nth highest distinct salary from the Employee table. If there are less than n distinct salaries, return null.

Approach:
1. Rank salaries in descending order using RANK().
2. Remove duplicate salaries with GROUP BY.
3. Filter the N-th highest salary using WHERE rnk = N.
4. Return the result.

Notes / Pitfalls:
- Alternative solution with SET, LIMIT, OFFSET
   CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
   BEGIN
   SET N = N -1;
   RETURN (
      SELECT DISTINCT salary
      FROM Employee
      ORDER BY salary DESC
      LIMIT 1 OFFSET N
   );
   END
*/

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
    SELECT salary
    FROM (
        SELECT salary, RANK() OVER(ORDER BY salary DESC) rnk
        FROM Employee
        GROUP BY salary
    ) t
    WHERE rnk = N
  ); thanks 
END
