/*
Problem: Product Sales Analysis III (LeetCode stratascratch #1070)
Link: https://leetcode.com/problems/product-sales-analysis-iii
Difficulty: Medium

Description:
Find all sales that occurred in the first year each product was sold with the columns:  product_id, first_year, quantity, and price.

Approach:
1. Write a CTE to rank the year for each product (earliest year rank as 1).
2. Retrieve the required columns with the rows in the first rank.

Notes / Pitfalls:
- RANK() can manage the same ranks.
*/

WITH cte AS (
    SELECT *, RANK() OVER(PARTITION BY product_id ORDER BY year) rnk
    FROM Sales
)
SELECT product_id, year first_year, quantity, price
FROM cte
WHERE rnk = 1
