/*
Problem: Rank Scores (LeetCode #178)
Link: https://leetcode.com/problems/rank-scores/description
Difficulty: Medium

Description:
Rank scores in descending order. Ties share the same rank. Next ranks are consecutive (no gaps). Return results sorted by score.

Approach:
1. Rank scores in descending order with DENSE_RANK()

Notes / Pitfalls:
- When using the word same as one of the keywords in SQL (e.g. rank) as alias, use quotes
*/

SELECT score, DENSE_RANK() OVER(ORDER BY score DESC) AS 'rank'
FROM Scores
