/*
Problem: Find Students Who Improved (LeetCode #3421)
Link: https://leetcode.com/problems/find-students-who-improved
Difficulty: Medium

Description:
Retrieve the students who have shown improvement between their first score and the last score for each subject.
Return the result table ordered by student_id and subject.

Approach:
1. Write a temporary table to find the first and the last score for each student and subject
2. In the main query, filter out the students and subjects whose latest score is greater than the first score.

Notes / Pitfalls:
- LAST_VALUE() has the default range of ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW, which means it always has the same value with the current one. Therefore, it should be specified the range to retrieve the last value in the partition.
e.g. LAST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) latest_score
    
*/

WITH cte AS (
    SELECT DISTINCT student_id, subject, 
        FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date) first_score,
        FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date DESC) latest_score
    FROM Scores
)
SELECT student_id, subject, first_score, latest_score
FROM cte
WHERE latest_score > first_score 
ORDER BY student_id, subject
