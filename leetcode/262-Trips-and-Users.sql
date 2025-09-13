/*
Problem: Trips and Users (LeetCode #262)
Link: https://leetcode.com/problems/trips-and-users/description/?envType=problem-list-v2&envId=n4wrvgr7
Difficulty: Hard

Description:
Compute the daily cancellation rate for trips between 2013-10-01 and 2013-10-03 where both client and driver are not banned. Only include days with at least one trip.
Cancellation Rate = (number of canceled trips by client or driver with unbanned users) / (total trips with unbanned users), rounded to two decimal points.

Approach:
1. Join Trips table with the Users table twice (one for client, another for driver) with the joining condition not banned
2. Filter out the specific time period
3. Aggregate the cancelled request divided by the total request for each date, covered by ROUND for decimal

Notes / Pitfalls:
- SUM(condition) to count the number of rows with the specific condition.
- COUNT(*) is generally faster than COUNT(column) because COUNT(*) doesn’t actually fetch the column, just counts rows.
- JOIN / SEMI-JOIN are usually faster than CTE because some database materialises the CTE (creates a temporary table in memory or disk). If so, each reference may trigger an extra scan.
- CTE for readability, complex logic, recursion, or when reusing the same dataset multiple times.
*/

SELECT request_at Day, ROUND(SUM(status != 'completed') / COUNT(*), 2) 'Cancellation Rate'
FROM Trips t 
JOIN Users c ON client_id = c.users_id AND c.banned = 'No'
JOIN Users d ON driver_id = d.users_id AND d.banned = 'No'
WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY 1;


-- CTE version
WITH valid_users AS (
    SELECT users_id
    FROM Users
    WHERE banned = 'No' 
)
SELECT request_at Day, ROUND(SUM(status != 'completed') / COUNT(id), 2) 'Cancellation Rate'
FROM Trips t JOIN valid_users c ON client_id = c.users_id 
JOIN valid_users d ON driver_id = d.users_id
WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY 1;

-- SEMI-JOIN version
SELECT request_at Day, ROUND(SUM(status != 'completed') / COUNT(id), 2) 'Cancellation Rate'
FROM Trips t
WHERE EXISTS (SELECT 1 FROM Users WHERE driver_id = users_id AND banned = 'No')
AND EXISTS (SELECT 1 FROM Users WHERE client_id = users_id AND banned = 'No')
AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY 1;
