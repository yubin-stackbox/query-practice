/*
Problem: Friend Requests II: Who Has the Most Friends (LeetCode #602)
Link: https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends
Difficulty: Medium

Description:
Find the people who have the most friends and the most friends number.

Approach:
1. Write a cte to retrieve all ids both requesters and acceptees.
2. From the cte, rank the ids based on the number of rows.
3. Show the ids that have the most friends requests and accepts.

Notes / Pitfalls:
- UNION ALL to collect all records ignoring the redundant.
*/

WITH all_ids AS (
    SELECT requester_id AS id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
    FROM RequestAccepted
)
SELECT id, num
FROM (
    SELECT id, COUNT(*) num, RANK() OVER(ORDER BY COUNT(*) DESC) rnk
    FROM all_ids
    GROUP BY id
) t
WHERE rnk = 1
