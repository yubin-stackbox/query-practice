/*
Problem: User with Most Approved Flags (stratascratch #2104)
Link: https://platform.stratascratch.com/coding/2104-user-with-most-approved-flags?code_type=3
Difficulty: Medium

Description:
Find the user or users who flagged the most different videos that YouTube approved. Show their full name (first name + space + last name) in a single column. If there’s a tie, include all tied users.

Approach:
1. Write a subquery for providing ranking
    - Join the two tables using the same attribute
    - Filter the review outcome which is 'APPROVED'
    - Group by the user name that is the combination of the user's first name, space, and last name
    - Count the distinct video_ids and use to rank over
2. Print out the user_name(s) whose ranking is 1

Notes / Pitfalls:
- After clearly identifying the relationship between the tables, it's easier to write a query
*/

SELECT user_name
FROM (
    SELECT 
        CONCAT(user_firstname, ' ', user_lastname) user_name, 
        RANK() OVER(ORDER BY COUNT(DISTINCT video_id) DESC) rnk
    FROM user_flags u JOIN flag_review r USING(flag_id)
    WHERE reviewed_outcome = 'APPROVED'
    GROUP BY user_name) r
WHERE rnk = 1
