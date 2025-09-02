/*
Problem: Host Popularity Rental Prices (Stratascratch #9632)
Link: https://platform.stratascratch.com/coding/9632-host-popularity-rental-prices?code_type=3
Difficulty: Medium

Description:
Calculate the rental price statistics (min, avg, max) grouped by host popularity.
The popularity is defined by the number of reviews a host has:
- 0 reviews → 'New'
- 1–5 reviews → 'Rising'
- 6–15 reviews → 'Trending Up'
- 16–40 reviews → 'Popular'
- > 40 reviews → 'Hot'

Approach:
1. Build a CTE to assign each host a popularity category using a CASE expression on number_of_reviews.
2. From the CTE, group by the derived popularity category.
3. For each group, calculate MIN(price), AVG(price), and MAX(price).
4. Order the result by min_price for better readability.

Notes / Pitfalls:
- Very high or low prices could skew the average.
- Ensure number_of_reviews does not contain NULLs; if it does, decide whether to classify as 'New' or exclude.
- Simple CASE WHEN only can compare two values rather than flexibly using expression (which can be done through Searched CASE WHEN).
- GROUP BY can use alias in MySQL (not in standard - SQL PostgreSQL / Oracle / SQL Server)
*/

WITH cte AS (
    select id, price, number_of_reviews,
        CASE WHEN number_of_reviews = 0 THEN 'New'
            WHEN number_of_reviews BETWEEN 1 AND 5 THEN 'Rising'
            WHEN number_of_reviews BETWEEN 6 AND 15 THEN 'Trending Up'
            WHEN number_of_reviews BETWEEN 16 AND 40 THEN 'Popular'
            ELSE 'Hot' END AS host_popularity
    FROM airbnb_host_searches
)
SELECT host_popularity, MIN(price) min_price, AVG(price) avg_price, MAX(price) max_price
FROM cte
GROUP BY host_popularity
ORDER BY min_price
