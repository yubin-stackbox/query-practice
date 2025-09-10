/*
Problem: Retention Rate (stratascratch #2053)
Link: https://platform.stratascratch.com/coding/2053-retention-rate?code_type=3
Difficulty: Hard

Description:
Calculate monthly user retention ratios per account.
For each account_id, compute the retention rate for December 2020 and January 2021,
where retention = the percentage of users active in a month who are also active in any future month.
Output the ratio of January 2021 retention to December 2020 retention (0 if December retention is 0).

Approach:
1. Write the first CTE for data preparation:
   - Retrieve distinct records, formatting dates as needed (e.g., month).
2. Use the first CTE in a self-join:
   - Join condition: same account_id and user_id, with the first table’s month earlier than the second
     (a user is “retained” if active in a month and again in any future month).
   - Filter for the required year-month values.
   - Group by the first table’s account_id and month to calculate retention rates for Dec 2020 and Jan 2021.
3. In the main query, self-join the monthly_rate CTE:
   - Join on account_id, with the first month = Dec 2020 and the second month = Jan 2021.
   - If the Dec 2020 retention rate is 0, return 0. Otherwise, divide the Jan 2021 retention rate by the Dec 2020 rate.

Notes / Pitfalls:
- When no aggregation is needed and all columns are grouped, use DISTINCT instead.
- Handle division by zero explicitly (e.g., with IF).
- Some databases return integers for integer division (e.g., SQL Server, SQLite).
  Use * 1.0 or CAST(... AS float) to ensure decimal results.
*/

WITH cte AS (
    SELECT DISTINCT account_id, DATE_FORMAT(record_date, '%Y-%m') month, user_id
    FROM sf_events
)
, monthly_rate AS(
    SELECT c1.account_id, c1.month, COUNT(DISTINCT c2.user_id) / COUNT(DISTINCT c1.user_id) rate
    FROM cte c1 LEFT JOIN cte c2 ON c1.account_id = c2.account_id AND c1.user_id = c2.user_id AND c1.month < c2.month 
    WHERE c1.month = '2020-12' OR c1.month = '2021-01'
    GROUP BY c1.account_id, c1.month
)
SELECT m1.account_id, IF(m1.rate = 0, 0, m2.rate / m1.rate) retention
FROM monthly_rate m1 JOIN monthly_rate m2 ON m1.account_id = m2.account_id
AND m1.month = '2020-12' AND m2.month = '2021-01'
