/*
Problem: Restaurant Growth (LeetCode #1321)
Link: https://leetcode.com/problems/restaurant-growth
Difficulty: Medium

Description:
Calculate the moving total and average of customer payments over a seven-day window (i.e., the current day plus the six preceding days). The average_amount should be rounded to two decimal places and results should be ordered by visited_on.

Approach:
1. Create a subquery to retrieve the total amount paid on each day.
2. Using the subquery, calculate the moving total and moving average for the six previous days plus the current day.
3. Display only the records where a full seven-day window of data is available.

Notes / Pitfalls:
- EXISTS() usually performs better than IN().
- DATEDIFF() provides more precise date calculations than using 'date - N'.
*/

WITH cte AS (
    SELECT visited_on, 
        SUM(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND(AVG(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount
    FROM (
        SELECT visited_on, SUM(amount) AS amount
        FROM Customer
        GROUP BY visited_on
    ) t
)
SELECT *
FROM cte
WHERE EXISTS(SELECT 1 FROM Customer WHERE DATEDIFF(cte.visited_on, Customer.visited_on) = 6)
ORDER BY visited_on
