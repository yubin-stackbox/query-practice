/*
Problem: Count Salary Categories (LeetCode #1907)
Link: https://leetcode.com/problems/count-salary-categories
Difficulty: Medium

Description:
Calculate the number of bank accounts for each salary category. The salary categories are defined as:
- Low Salary: All salaries less than $20,000.
- Average Salary: All salaries between $20,000 and $50,000 (inclusive).
- High Salary: All salaries greater than $50,000.
The result table must always include all three categories. If a category has no accounts, return a count of 0.

Approach:
1. Create a temporary table containing all salary categories.
2. Assign each account to the appropriate category based on its income.
3. Perform a left join between the category table and the account table to count the accounts in each category, ensuring categories with no accounts are included with a 0 count.

Notes / Pitfalls:
- Since UNION requires a deduplication step (sort + unique check), in general, UNION ALL is more efficient.
*/

WITH category AS (
    SELECT "Low Salary" AS category UNION ALL
    SELECT "Average Salary" UNION ALL
    SELECT "High Salary"
)
, accounts AS (
    SELECT account_id, income, 
        CASE WHEN income < 20000 THEN "Low Salary" 
             WHEN income > 50000 THEN "High Salary" 
             ELSE "Average Salary" END AS category
    FROM Accounts
)
SELECT c.category, COUNT(account_id) AS accounts_count
FROM category c LEFT JOIN accounts a ON c.category = a.category
GROUP BY c.category
