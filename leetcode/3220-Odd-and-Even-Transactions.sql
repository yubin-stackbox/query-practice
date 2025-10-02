/*
Problem: Odd and Even Transactions (LeetCode #3220)
Link: https://leetcode.com/problems/odd-and-even-transactions
Difficulty: Medium

Description:
Calculate the total amounts of odd and even transactions for each day, ordered by transaction_date in ascending order. If there are no transactions for a specific date, display 0.

Approach:
1. Group by transaction_date to calculate totals for each day.
2. Use the modulo operator (%) to determine whether an amount is odd or even, and sum the amounts based on that condition.
3. Use COALESCE to return 0 when the total amount is NULL.

Notes / Pitfalls:
- Alternatively, CASE WHEN ... THEN ... ELSE 0 can be used inside SUM to handle the conditions explicitly.
  e.g. SUM(CASE WHEN amount %2=0 THEN amount ELSE 0 END) AS even_sum
*/

SELECT transaction_date, 
    COALESCE(SUM(CASE WHEN amount %2=1 THEN amount END), 0) AS odd_sum, 
    COALESCE(SUM(CASE WHEN amount %2=0 THEN amount END), 0) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date
