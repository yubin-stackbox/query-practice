/*
Problem: Analyze Subscription Conversion (LeetCode #3497)
Link: https://leetcode.com/problems/analyze-subscription-conversion/
Difficulty: Medium

Description:
A subscription service wants to analyze user behavior patterns. The company offers a 7-day free trial, after which users can subscribe to a paid plan or cancel.
- Find users who converted from a free trial to a paid subscription
- Calculate each user's average daily activity duration during their free trial period (rounded to 2 decimal places)
- Calculate each user's average daily activity duration during their paid subscription period (rounded to 2 decimal places)
- Return the result table ordered by user_id in ascending order.

Approach:
1. Retrieve only users who have a 'paid' record.
2. Grouping the users by their user_id.
3. Calculate the average of free trial activity duration and paid activity duration.
4. Round them into 2 decimal places, and order the records by the user_id.

Notes / Pitfalls:
- The first step (filter the paid users only) can be replaced by:
HAVING SUM(activity_type = 'paid') > 0
*/

SELECT user_id, 
    ROUND(AVG(CASE WHEN activity_type = 'free_trial' THEN activity_duration END), 2) AS trial_avg_duration,
    ROUND(AVG(CASE WHEN activity_type = 'paid' THEN activity_duration END), 2) AS paid_avg_duration
FROM UserActivity u
WHERE EXISTS(SELECT DISTINCT user_id FROM UserActivity WHERE activity_type = 'paid' AND u.user_id = user_id)
GROUP BY user_id
ORDER BY user_id
