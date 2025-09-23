/*
Problem: Customers Who Bought All Products (LeetCode #1045)
Link: https://leetcode.com/problems/customers-who-bought-all-products
Difficulty: Medium

Description:
Report the customer ids who bought all the products in the Product table.

Approach:
1. Count the unique products for each customer
2. Show only customers who have the same number of products bought with the all product in the product table

Notes / Pitfalls:
- This solution ensures that the product_key in the Customer table is the FK of the product_key in the Product table. In other words, if the customer table has a product_key which does not exist in the product table, the solution may not work.
*/

SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(DISTINCT product_key) FROM Product)

-- alternative solution for the Pitfall (in case of referential integrity violation)
SELECT customer_id
FROM Customer JOIN Product USING(product_key)
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(DISTINCT product_key) FROM Product)
