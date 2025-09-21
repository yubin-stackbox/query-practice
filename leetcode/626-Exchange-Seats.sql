/*
Problem: Exchange Seats (LeetCode #626)
Link: https://leetcode.com/problems/exchange-seats
Difficulty: Medium

Description:
Swap the seat id of every two consecutive students, and order by id. If the number of students is odd, the id of the last student is not swapped.

Approach:
1. If the id is odd, take the next student name. If not, take the previous student name.
2. In case the number of students is odd, the last student will have NULL. So, use COALESCE to keep not swapped.

Notes / Pitfalls:
- COALESCE to manage the NULL by retrieving the first not-null value
*/

SELECT id,
    COALESCE(IF(id % 2 = 1, LEAD(student) OVER(ORDER BY id), LAG(student) OVER(ORDER BY id)), student) student
FROM Seat
ORDER BY id
