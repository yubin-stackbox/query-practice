/*
Problem: Game Play Analysis IV (LeetCode #550)
Link: https://leetcode.com/problems/game-play-analysis-iv/description/?envType=problem-list-v2&envId=n4wrvgr7
Difficulty: Medium

Description:
Report the fraction of players who logged in the day after their first login, rounded to 2 decimal places.

Approach:
1. Write a subquery to get the first login date.
2. Left join the subquery with the Activity table to select the second login date for each player.
3. Calculate the fraction of the players whose difference of two dates is 1, rounded to 2 decimal points.

Notes / Pitfalls:
- COUNT(CASE WHEN ...)  Retrieve 0 when there's no matching record
- SUM(CASE WHEN ...)    Retrieve NULL when there's no matching record
*/

SELECT ROUND(COUNT(CASE WHEN DATEDIFF(event_date, first_date) = 1 THEN 1 END)/ COUNT(a1.player_id), 2) fraction
FROM (
    SELECT player_id, MIN(event_date) first_date
    FROM Activity
    GROUP BY player_id
) a1 LEFT JOIN Activity a2 ON a1.player_id = a2.player_id AND first_date + 1 = event_date

  
-- Another possible answer with WINDOW functions
WITH cte AS (
   SELECT player_id, DATEDIFF(LEAD(event_date) OVER(PARTITION BY player_id ORDER BY event_date), event_date) df
   FROM (
      SELECT player_id, event_date, ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) rn
      FROM Activity
   ) t
   WHERE rn <=2
)
SELECT ROUND(COUNT(CASE WHEN df = 1 THEN 1 END) / COUNT(DISTINCT player_id), 2) fraction
FROM cte
