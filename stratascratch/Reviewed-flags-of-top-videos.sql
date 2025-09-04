/*
Problem: Reviewed flags of top videos (stratascratch #2103)
Link: https://platform.stratascratch.com/coding/2103-reviewed-flags-of-top-videos?code_type=3
Difficulty: Hard

Description:
For the video (or videos) that received the most user flags, how many of these flags were reviewed by YouTube? Output the video ID and the corresponding number of reviewed flags. Ignore flags that do not have a corresponding flag_id.

Approach:
1. Build a CTE (flag_count) to aggregate the count of flags and sum of the reviewed by youtube
- Join two tables with the same column (flag_id), and
- Group by video_id for aggregation
2. Show the result only with the maximum flag count

Notes / Pitfalls: Optimisation
1. Original query
    - scan the user_flags twice (in flag_rank cte and aggregation of yt_reviewed) 
    - which can take much time to scan it if it has much data.
    -> Poor performance
2. Optimised query
    - scan the user_flags to aggregate the flag_count and yt_reviewed.
    - Outside of the flag_count(cte), show and use the outcome of it
    - which scan the cte take only once
*/

-- Optimised query
WITH flag_count AS(
    SELECT u.video_id, COUNT(f.flag_id) cnt, SUM(reviewed_by_yt) yt_reviewed
    FROM user_flags u JOIN flag_review f USING (flag_id)
    GROUP BY u.video_id
)
SELECT video_id, yt_reviewed
FROM flag_count
WHERE cnt IN (SELECT MAX(cnt) FROM flag_count);


-- Orignial query
WITH flag_rank AS (
    SELECT video_id, RANK() OVER(ORDER BY COUNT(DISTINCT flag_id) DESC) rnk
    FROM user_flags
    GROUP BY video_id
)
SELECT video_id, SUM(reviewed_by_yt) yt_reviewed
FROM user_flags u JOIN flag_review USING(flag_id)
WHERE video_id IN (SELECT video_id FROM flag_rank WHERE rnk = 1)
GROUP BY video_id;
