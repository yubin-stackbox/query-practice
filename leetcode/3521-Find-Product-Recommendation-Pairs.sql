/*
Problem: Find Product Recommendation Pairs (LeetCode #3521)
Link: https://leetcode.com/problems/find-product-recommendation-pairs
Difficulty: Medium

Description:
To provide co-purchase patterns for recommendations (at least 3 different customers purchased), determine:
    1. The distinct product pairs purchased together by the same customers, and
    2. The number of customers who purchased the pair.
    It is ordered by customer_count in descending order, and in case of a tie, by product1_id and then product2_id.

Approach:
1. Write a CTE to make the dataset smaller for representation:
    - Self-join the ProductPurchases table to make pairs of products for each customer.
    - To avoid the redundant pair, use the joining condition that the first product_id is smaller than the second one.
    - Group by the product_id pair to leave the distinct pairs.
    - Filter out the pairs bought by three or more customers.
2. In the main query, join the ProductInfo table twice to match products and the category name.

Notes / Pitfalls:
- Through GROUP BY product1_id, product2_id, the duplicate customer purchases are removed.
- The CTE filters a massive amount of data down to a small, manageable set at the beginning of the process.
*/

WITH cte AS (
    SELECT P1.product_id AS product1_id, P2.product_id AS product2_id, COUNT(*) AS customer_count
    FROM ProductPurchases P1 JOIN ProductPurchases P2 ON P1.product_id < P2.product_id AND P1.user_id = P2.user_id
    GROUP BY product1_id, product2_id
    HAVING customer_count >= 3
)
SELECT product1_id, product2_id, I1.category AS product1_category, I2.category AS product2_category, customer_count
FROM cte JOIN ProductInfo I1 ON product1_id = I1.product_id JOIN ProductInfo I2 ON product2_id = I2.product_id
ORDER BY customer_count DESC, product1_id, product2_id


-- slower solution (before optimised)
SELECT
    P1.product_id AS product1_id, P2.product_id AS product2_id, 
    I1.category AS product1_category, I2.category AS product2_category, 
    COUNT(*) AS customer_count
FROM ProductPurchases P1 JOIN ProductPurchases P2 ON P1.product_id < P2.product_id AND P1.user_id = P2.user_id
JOIN ProductInfo I1 ON P1.product_id = I1.product_id
JOIN ProductInfo I2 ON P2.product_id = I2.product_id
GROUP BY product1_id, product2_id
HAVING customer_count >= 3
ORDER BY customer_count DESC, product1_id, product2_id
