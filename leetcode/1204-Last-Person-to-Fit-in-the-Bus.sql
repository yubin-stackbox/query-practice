/*
Problem: Last Person to Fit in the Bus (LeetCode #1204)
Link: https://leetcode.com/problems/last-person-to-fit-in-the-bus
Difficulty: Medium

Description:
Find the name of the last person that can fit on the bus without exceeding the weight limit of 1000 kilograms. Note that:
- the first person does not exceed the weight limit, and 
- only one person can board the bus at any given turn.

Approach:
1. Write a subquery to calculate the cumulative total weight for each passenger.
2. Select the only person's name, who has the maximum total_weight, and less then 1000 kg.

Notes / Pitfalls:
- CTE to find the maximum weight can reduce the performance of the query because it scan the data three times, whereas the solution scans once.
  WITH cte AS (
    SELECT person_name, SUM(weight) OVER(ORDER BY turn) AS total_weight 
    FROM Queue
  )
  SELECT person_name
  FROM cte
  WHERE total_weight = (SELECT MAX(total_weight) FROM cte WHERE total_weight <= 1000)

  1) Scan the DB to build the cte that calculates the all cumulative sum of weight.
  2) Scan the cte to find the maximum total_weight that is less than or equal to 1000.
  3) Scan the cte to to find the person_name whose total_weight matches the goal number.

*/

SELECT person_name
FROM (SELECT person_name, SUM(weight) OVER(ORDER BY turn) AS total_weight FROM Queue) t
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1;
