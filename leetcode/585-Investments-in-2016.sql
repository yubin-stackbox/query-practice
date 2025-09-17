/*
Problem: Investments in 2016 (LeetCode #585)
Link: https://leetcode.com/problems/investments-in-2016
Difficulty: Medium

Description:
Report the sum of all total investment values in 2016(tiv_2016), rounded to two decimal places, for all policyholders who:
- have the same tiv_2015 value as one or more other policyholders, and
- are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).

Approach:
1. Find the rows from Insurance, which has the same tiv_2015 from others (EXISTS).
2. Find the rows from Insurance, which does not have the same lat, lon value from others (NOT EXISTS).
3. Calculate the total amount of tiv_2016 and round two decimal places.

Notes / Pitfalls:
- The tuple IN usually increases the scanning time, which can drop the performance.
    (EXISTS, NOT EXISTS can be alternatives)
*/

SELECT ROUND(SUM(i1.tiv_2016), 2) tiv_2016
FROM Insurance i1 
WHERE EXISTS (SELECT 1 FROM Insurance i2 WHERE i1.pid != i2.pid AND i1.tiv_2015 = i2.tiv_2015)
AND NOT EXISTS (SELECT 1 FROM Insurance i2 WHERE i1.pid != i2.pid AND (i1.lat, i1.lon) = (i2.lat, i2.lon))


-- with CTE and JOIN
WITH same_tiv_2015 AS (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) >=2
)
, different_city AS (
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) =1
)
SELECT ROUND(SUM(tiv_2016), 2) tiv_2016
FROM Insurance i JOIN same_tiv_2015 s ON i.tiv_2015 = s.tiv_2015
JOIN different_city d ON i.lat = d.lat AND i.lon = d.lon

-- with tuple IN
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (SELECT tiv_2015 FROM Insurance GROUP BY tiv_2015 HAVING COUNT(*) >=2) 
AND (lat, lon) IN (SELECT lat, lon FROM Insurance GROUP BY lat, lon HAVING COUNT(*) <2)
