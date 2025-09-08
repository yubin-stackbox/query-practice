/*
Problem: Most Popular Client For Calls (stratascratch #120290090)
Link: https://platform.stratascratch.com/coding/2029-the-most-popular-client_id-among-users-using-video-and-voice-calls?code_type=3
Difficulty: Hard

Description:
Select the most popular client_id based on the number of users who individually have at least 50% of their events from the following list: 
- 'video call received' 
- 'video call sent' 
- 'voice call received' 
- 'voice call sent'

Approach:
1. Create a CTE to find the valid users and their clients:
    - Determine the proportion of events that are in 
      ('video call received', 'video call sent', 'voice call received', 'voice call sent').
    - Check whether this proportion is greater than or equal to 0.5.
2. Group by client_id to calculate the number of users for each client_id.
3. Order by the number of users in descending order and return the first value only.

Notes / Pitfalls:
- Risk: When the number of users is the same for multiple clients, the query will still return only one due to 'LIMIT 1'. 
  To avoid this, consider using RANK().
  Example replacement for the main query:
  SELECT client_id
  FROM (
      SELECT client_id, RANK() OVER(ORDER BY COUNT(user_id) DESC) rnk
      FROM cte
      GROUP BY client_id
  ) t
  WHERE rnk = 1;
*/

WITH cte AS (
    SELECT user_id, client_id
    FROM fact_events
    GROUP BY user_id, client_id
    HAVING COUNT(CASE WHEN event_type IN ('video call received', 'video call sent', 'voice call received', 'voice call sent') THEN 1 END) / COUNT(id) >= 0.5
)
SELECT client_id, COUNT(user_id)
FROM cte
GROUP BY client_id
ORDER BY COUNT(user_id) DESC 
LIMIT 1
