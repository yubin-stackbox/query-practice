/*
Problem: Find Category Recommendation Pairs (LeetCode #3554)
Link: https://leetcode.com/problems/find-category-recommendation-pairs
Difficulty: Hard

Description:
Identify shopping patterns across product categories to find the reportable category pairs, where a pair is defined as two distinct product categories from which at least three different customers have each bought products, by:
    1. Finding all category pairs, and
    2. For each pair, count the unique customers buying both.
Order results by customer_count (desc), category1, category2.

Approach:
1. Write a CTE to leave the unique user_id and the category, which minimises the amount of data to analyse.
2. In the main query, self-join the CTE table to create category pairs for each user.
3. Group by category 1 and category 2 to count the number of customers for each pair.
4. Filter out the category pairs bought by more than or equal to three customers.

Notes / Pitfalls:
- To optimise the query, use CTE to minimise (or reduce) the amount of data to analyse.
*/

WITH CategoryPurchase AS (
    SELECT DISTINCT P.user_id, I.category
    FROM ProductPurchases P JOIN ProductInfo I USING(product_id)
)
SELECT C1.category AS category1, C2.category AS category2, COUNT(*) AS customer_count
FROM CategoryPurchase C1 JOIN CategoryPurchase C2 ON C1.user_id = C2.user_id AND C1.category < C2.category
GROUP BY category1, category2
HAVING customer_count >=3
ORDER BY customer_count DESC, category1, category2
