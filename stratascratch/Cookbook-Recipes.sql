/*
Problem: Cookbook Recipes (stratascratch #2089)
Link: https://platform.stratascratch.com/coding/2089-cookbook-recipes?code_type=3
Difficulty: Hard

Description:
Format cookbook recipes by double-page spreads. Each spread has an even-numbered left page and the following odd-numbered right page. Return three columns:
   - left_page_number: the even page starting the spread
   - left_title: recipe title on the left page (or NULL if none)
   - right_title: recipe title on the right page (or NULL if none)
Include all pages up to the maximum page number. Page 0 is always included. Each page contains at most one recipe.

Approach:
1. Generate left page numbers for each spread:
   - Even pages remain the same, odd pages map to the previous even page.
2. Use a LEFT JOIN to associate recipes with each left page.
3. Group by left_page_number to aggregate each spread into a single row.
4. Use MAX(CASE WHEN ...) to:
   - separate left and right titles, and 
   - retrieve the non-null value

Notes / Pitfalls:
- COALESCE() does not pick the first non-NULL across multiple rows.
*/

WITH page AS (
    SELECT DISTINCT CASE WHEN page_number %2 = 0 THEN page_number ELSE page_number -1 END AS left_page_number
    FROM cookbook_titles
)
SELECT left_page_number,
    MAX(CASE WHEN left_page_number = page_number THEN title END) AS left_title,
    MAX(CASE WHEN left_page_number != page_number THEN title END) AS right_title
FROM page p LEFT JOIN cookbook_titles c 
ON IF(page_number %2=0, left_page_number = page_number, left_page_number = page_number - 1)
GROUP BY left_page_number
