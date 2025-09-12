/*
Problem: Apple Product Counts (stratascratch #10141)
Link: https://platform.stratascratch.com/coding/10141-apple-product-counts?code_type=3
Difficulty: Medium

Description:
Count distinct users of 'macbook pro', 'iphone 5s', and 'ipad air' by language, compare with total users per language, and sort results by highest total users.

Approach:
1. Join two tables with the same column name
2. Group by the language
3. Count the number of distinct user_id who used device "macbook pro", "iphone 5s", or "ipad air"
4. Count the number of distinct user_id
5. Order by the highest total users

Notes / Pitfalls:
- Understanding the business description is the first and the most important thing to do.
*/

SELECT language, 
    COUNT(DISTINCT CASE WHEN device IN ("macbook pro", "iphone 5s", "ipad air") THEN e.user_id END) AS n_apple_user,
    COUNT(DISTINCT e.user_id) AS n_total_users
FROM playbook_users u JOIN playbook_events e USING(user_id)
GROUP BY language
ORDER BY total_users DESC
