/*
Problem: Immediate Food Delivery II (LeetCode #1174)
Link: https://leetcode.com/problems/immediate-food-delivery-ii
Difficulty: Medium

Description:
Calculate the percentage of immediate orders (where the preferred delivery date is the same as the order date) among the first orders of all customers, rounded to 2 decimal places.

Approach:
1. Write a subquery to identify each custemr's first order.
2. Count the numver of immediate orders(order_date = customer_pref_delivery_date), devide by the total number of first orders, then multiply by 100. Round the result to 2 decimal places.
    
Notes / Pitfalls:
 - Use SUM(condition) to count records that satisfy the condition.
 - Ensure correct handling of rounding to avoid precision issues.
*/

SELECT ROUND(SUM(order_date = customer_pref_delivery_date) / COUNT(*) * 100, 2) AS immediate_percentage
FROM (
    SELECT order_date, customer_pref_delivery_date, RANK() OVER(PARTITION BY customer_id ORDER BY order_date) rnk
    FROM Delivery
) t
WHERE rnk = 1
