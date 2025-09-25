/*
Problem: Product Price at a Given Date (LeetCode #1164)
Link: https://leetcode.com/problems/product-price-at-a-given-date
Difficulty: Medium

Description:
All products initially have a price of 10. The task is to determine the price of each product as of 2019-08-16.

Approach:
1. Create a CTE that retrieves the most recent price for each product on or before 2019-08-16.
2. Join the full list of products with the CTE.
3. For each product, return the most recent price. If no price update exists, default to 10.

Notes / Pitfalls:
- Use a LEFT JOIN to ensure all products are included.
- Apply IFNULL (or equivalent) to handle missing prices.
*/

WITH cte AS (
    SELECT product_id, new_price, RANK() OVER(PARTITION BY product_id ORDER BY change_date DESC) rnk
    FROM Products
    WHERE change_date <= '2019-08-16'
)
SELECT p.product_id, IFNULL(new_price, 10) price
FROM (SELECT DISTINCT product_id FROM Products) p LEFT JOIN cte c ON p.product_id = c.product_id AND c.rnk = 1
