/*
Problem: Find Consistently Improving Employees (LeetCode #3580)
Link: https://leetcode.com/problems/find-consistently-improving-employees
Difficulty: Medium

Description:
Find employees with at least 3 reviews whose last 3 ratings (by review_date) are strictly increasing.
Compute improvement_score = latest_rating − earliest_rating among those 3 reviews.
Return employee_id, name, and improvement_score, ordered by improvement_score DESC, then name ASC.

Approach:
1. Write a first CTE to rank the ratings based on the most recent review date.
2. Write a second CTE to:
    - retrieve employees who have at least 3 records, and
    - extract their latest, middle, and oldest ratings.
3. In the main query:
    - join the RANKING CTE with the employees table to include employee names,
    - filter only rows where oldest_rating < middle_rating < latest_rating,
    - return the employee_id, name, and the improvement_score (latest − oldest rating).

Notes / Pitfalls:
- Using a window function with nested subqueries or an EXISTS subquery can harm performance.
- Use CTEs to minimize table scans (reduce redundant scans on the dataset) and optimize the query.
*/

WITH CTE AS (
    SELECT 
        employee_id, 
        rating, 
        review_date, 
        RANK() OVER(PARTITION BY employee_id ORDER BY review_date DESC) rnk
    FROM performance_reviews
)
, RANKING AS (
    SELECT employee_id, 
        MAX(CASE WHEN rnk = 1 THEN rating END) AS latest,
        MAX(CASE WHEN rnk = 2 THEN rating END) AS rating,
        MAX(CASE WHEN rnk = 3 THEN rating END) AS oldest
    FROM CTE
    GROUP BY employee_id
    HAVING COUNT(*) >=3
)
SELECT R.employee_id, name, latest - oldest AS improvement_score
FROM RANKING R JOIN employees USING(employee_id)
WHERE oldest < rating AND rating < latest
ORDER BY improvement_score DESC, name
