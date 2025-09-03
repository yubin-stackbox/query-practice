/*
Problem: Top 10 Songs 2010 (stratascratch #9650)
Link: https://platform.stratascratch.com/coding/9650-find-the-top-10-ranked-songs-in-2010?code_type=3
Difficulty: Medium

Description:
Find the top 10 ranked songs in 2010. Output the rank, group name, and song name, but do not show the same song twice. Sort the result based on the rank in ascending order.

Approach:
1. Filter out the rows whoes year is 2010 and whose rank is between 1 and 10
2. Show the unique song
3. Order by the rank

Notes / Pitfalls:
- DISTINCE used for the all combinationi of the columns (which means same as DISTINCT (column1, column))
*/

SELECT DISTINCT song_name, group_name, year_rank
FROM billboard_top_100_year_end
WHERE year = 2010 AND year_rank <= 10
ORDER BY year_rank
