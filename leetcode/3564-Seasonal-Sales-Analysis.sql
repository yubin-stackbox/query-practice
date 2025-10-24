/*
Problem: Seasonal Sales Analysis (LeetCode #3564)
Link: https://leetcode.com/problems/seasonal-sales-analysis/
Difficulty: Medium

Description:
Find the most popular product category, its total quantity and total revenue for each season, ordered by season.
The seasons are defined as:
    - Winter: December, January, February
    - Spring: March, April, May
    - Summer: June, July, August
    - Fall: September, October, November

Approach:
1. Write the first CTE seasonCategory to:
    - Join the sales data with the products data to retrieve the category for each rows in the sales,
    - Retrieve season from the sale_date for each record, and
    - Group by the season and the category to aggregate the total quantity and total revenue.
2. Write the second CTE ranking to rank each record based on the total quantity and revenue in each season.
3. Select only the top record (top categories) in each season via the main query.

Notes / Pitfalls:
- In MySQL, a column alias can be used in the GROUP BY clause, which differs from standard SQL. Aliases are generally not allowed in the GROUP BY clause because the GROUP BY clause is processed before the SELECT clause where aliases are defined.
*/

WITH seasonCategory AS (
    SELECT CASE WHEN MONTH(sale_date) IN (3,4,5) THEN 'Spring'
            WHEN MONTH(sale_date) IN (6,7,8) THEN 'Summer'
            WHEN MONTH(sale_date) IN (9,10,11) THEN 'Fall'
            ELSE 'Winter' END AS season,
        category, SUM(quantity) AS total_quantity, SUM(quantity * price) AS total_revenue
    FROM sales JOIN products USING(product_id)
    GROUP BY season, category
),
ranking AS (
    SELECT *, RANK() OVER(PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC) rnk
    FROM seasonCategory
)
SELECT season, category, total_quantity, total_revenue
FROM ranking
WHERE rnk = 1
ORDER BY 1
