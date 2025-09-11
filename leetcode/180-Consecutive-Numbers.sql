/*
Problem: Consecutive Numbers (LeetCode #180)
Link: https://leetcode.com/problems/consecutive-numbers
Difficulty: Medium

Description:
Find all numbers that appear at least three times consecutively.

Approach:
1. Write a subquery to retrieve the previous and next numbers for each row.
2. In the main query, filter rows where the three values are the same, which indicates the number is consecutively repeated three times.
3. Select the unique numbers to retrieve all values that appear at least three times consecutively.

Notes / Pitfalls:
- LEAD(): A window function that returns values from rows after the current row within a defined result set, without requiring a self-join.
- LAG(): A window function that returns values from rows before the current row within a defined result set, without requiring a self-join.
*/

SELECT DISTINCT num ConsecutiveNums
FROM (
    SELECT num, LAG(num) OVER(ORDER BY id) previous, LEAD(num) OVER(ORDER BY id) next
    FROM Logs
) t
WHERE num = previous AND previous = next
