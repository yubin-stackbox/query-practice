/*
Problem: Confirmation Rate (LeetCode #1934)
Link: https://leetcode.com/problems/confirmation-rate
Difficulty: Medium

Description:
Calculate the confirmation rate for each user. The confirmation rate is defined as the number of 'confirmed' messages divided by the total number of confirmation requests.
For users who did not request any confirmation messages, the confirmation rate should be 0. Round the confirmation rate to two decimal places.

Approach:
1. Left join the Signups table with the Confirmations table to include all users, even those who have not requested any confirmations.
2. Group by user_id to count the total number of requests per user.
3. Count the number of 'confirmed' actions and divide by the total requests to calculate the confirmation rate.

Notes / Pitfalls:
- SUM(condition) may return NULL for users with no requests. (COALESCE can be used as an alternative.)
  e.g. SELECT s.user_id, ROUND(COALESCE(SUM(action = "confirmed" ), 0) / COUNT(*), 2) AS confirmation_rate
*/

SELECT s.user_id, ROUND(SUM(CASE action WHEN "confirmed" THEN 1 ELSE 0 END) / COUNT(*), 2) AS confirmation_rate
FROM Signups s LEFT JOIN Confirmations c USING (user_id)
GROUP BY s.user_id
