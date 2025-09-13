/*
Problem: Department Highest Salary (LeetCode #184)
Link: https://leetcode.com/problems/department-highest-salary
Difficulty: Medium

Description:
Write a solution to find employees who have the highest salary in each of the departments.

Approach:
1. Write a subquery to add the ranking to the salary in each department
2. Join the subquery with the department table to get the department name
3. Filter out the employees who are receving the maximum salary amount in their department

Notes / Pitfalls:
- Alternative solution with FIRST_VALUE()
e.g. 
SELECT d.name Department, e.name Employee, salary Salary
FROM (
    SELECT *, FIRST_VALUE(salary) OVER(PARTITION BY departmentId ORDER BY salary DESC) max_salary
    FROM Employee
) e LEFT JOIN Department d ON e.departmentId = d.id
WHERE salary = max_salary
*/

SELECT d.name Department, e.name Employee, salary Salary
FROM (
    SELECT *, RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) rnk
    FROM Employee
) e LEFT JOIN Department d ON e.departmentId = d.id
WHERE rnk = 1
