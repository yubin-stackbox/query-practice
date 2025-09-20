/*
Problem: Human Traffic of Stadium (LeetCode #601)
Link: https://leetcode.com/problems/human-traffic-of-stadium
Difficulty: Hard

Description:
Display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each, ordered by visit_date.

Approach:
1. Write a cte to group the consecutive records whose 'people' is greater than or equal to 100.
    - ROW_NUMBER() is made for the records of people >=100.
    - grp is changed based on the difference of id and ROW_NUMBER(). 
        e.g. 
        +------+------------+-----------+--------------+-----+
        | id   | visit_date | people    | ROW_NUMBER() | grp |
        +------+------------+-----------+--------------+-----+
        | 1    | 2017-01-01 | 10        |              |     |
        | 2    | 2017-01-02 | 109       | 1            | 1   |
        | 3    | 2017-01-03 | 150       | 2            | 1   |
        | 4    | 2017-01-04 | 99        |              |     |
        | 5    | 2017-01-05 | 145       | 3            | 2   |
        | 6    | 2017-01-06 | 1455      | 4            | 2   |
        +------+------------+-----------+--------------+-----+
2. Through the main query, show the required columns whose grp has more than 2 records.

Notes / Pitfalls:
- id - ROW_NUMBER() is a common SQL trick to identify and group consecutive rows.
*/

WITH cte AS (
    SELECT *, id - ROW_NUMBER() OVER(ORDER BY id) grp
    FROM Stadium
    WHERE people >=100
)
SELECT id, visit_date, people
FROM cte
WHERE grp IN (SELECT grp FROM cte GROUP BY grp HAVING COUNT(*) >=3)


-- alternative solution with Window function
WITH cte AS (
    SELECT *, 
        CASE 
            WHEN LAG(people, 2) OVER(ORDER BY id) >= 100 AND LAG(people) OVER(ORDER BY id) >=100 THEN 1
            WHEN LAG(people) OVER(ORDER BY id) >=100 AND LEAD(people) OVER(ORDER BY id) >=100 THEN 1
            WHEN LEAD(people) OVER(ORDER BY id)  >=100 AND LEAD(people, 2) OVER(ORDER BY id) >=100 THEN 1
        ELSE 0 END AS marker
    FROM Stadium
)
SELECT id, visit_date, people
FROM cte
WHERE people >=100 AND marker = 1
ORDER BY visit_date
