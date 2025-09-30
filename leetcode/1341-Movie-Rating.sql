/*
Problem: Movie Rating (LeetCode #1341)
Link: https://leetcode.com/problems/movie-rating
Difficulty: Medium

Description:
Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie title.

Approach:
1. Join the Users and MovieRating tables to count the number of ratings per user, then select the user with the most ratings (breaking ties using lexicographic order).
2. Join the Movies and MovieRating tables to calculate the average rating for each movie in February 2020, then select the movie with the highest average rating (breaking ties using lexicographic order).
3. Use UNION ALL to combine the results.

Notes / Pitfalls:
- To use UNION ALL with multiple ORDER BY and/or LIMIT clauses, parentheses are required.
*/

(
  SELECT name AS results
  FROM Users u JOIN MovieRating m USING(user_id)
  GROUP BY u.user_id
  ORDER BY COUNT(*) DESC, name
  LIMIT 1
)
UNION ALL
(
  SELECT title AS results
  FROM Movies m JOIN MovieRating mr USING(movie_id)
  WHERE DATE_FORMAT(created_at, '%Y-%m') = '2020-02'
  GROUP BY m.movie_id
  ORDER BY AVG(rating) DESC, title
  LIMIT 1
)
