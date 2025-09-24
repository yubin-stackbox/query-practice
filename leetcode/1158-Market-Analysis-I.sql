/*
Problem: Market Analysis I (LeetCode #1158)
Link: https://leetcode.com/problems/market-analysis-i
Difficulty: Medium

Description:
Find, for each user, their join date and the number of orders they placed as a buyer in 2019.

Approach:
1. Join the Users and Orders tables on user_id = buyer_id, filtering orders where the order date is in 2019.
    - If the order date is not in 2019, the join will return NULL for that order.
2. Group by user_id (aliased as buyer_id).
3. Count the number of order_id values per user.

Notes / Pitfalls:
- Handle NULL values carefully in the join condition. If the condition isn’t met, the join will produce NULL results.
*/

SELECT user_id AS buyer_id, join_date, COUNT(order_id) AS orders_in_2019
FROM Users u LEFT JOIN Orders o ON u.user_id = o.buyer_id AND YEAR(order_date) = '2019'
GROUP BY user_id
