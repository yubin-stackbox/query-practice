/*
Problem: Monthly Transactions I (LeetCode #1193)
Link: https://leetcode.com/problems/monthly-transactions-i
Difficulty: Medium

Description:
 For each month and country, calculate:
 - The total number of transactions and their total amount.
 - The number of approved transactions and their total amount.

Approach:
 1. Format trans_date as YYYY-MM and group by it.
 2. Group by country.
 3. Calculate:
    - COUNT(*) for total transaction count.
    - SUM(state = 'approved') for approved transaction count.
    - SUM(amount) for total transaction amount.
    - SUM(IF(state = 'approved', amount, 0)) for approved transaction amount.

Notes / Pitfalls:
- Use DATE_FORMAT to extract year and month from trans_date.
*/

SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') month, 
    country, 
    COUNT(*) trans_count, 
    SUM(state = 'approved') approved_count, 
    SUM(amount) trans_total_amount, 
    SUM(IF(state = 'approved', amount, 0)) approved_total_amount
FROM Transactions
GROUP BY month, country
