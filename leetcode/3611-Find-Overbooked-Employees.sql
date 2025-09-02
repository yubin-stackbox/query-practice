/*
Problem: Find Overbooked Employees (LeetCode #3611)
Link: https://leetcode.com/problems/find-overbooked-employees/
Difficulty: Medium

Description:
Identify employees who spend more than 50% of their working hours in meetings during any given week.
Only include employees who had at least 2 weeks of such overbooked schedules.

Approach:
1. Calculate total meeting hours per employee per week(starting from Monday):
   - Use the 'meetings' table, group by employee_id and week of the meeting_date.
   - Sum the duration_hours for each week.
   - Keep only weeks where total meeting hours exceed 20 hours.
2. Join the CTE with the 'employees' table:
   - Retrieve employee_name and department for each overbooked employee.
3. Count the number of overbooked weeks per employee:
   - Use COUNT(*) grouped by employee_id to get 'meeting_heavy_weeks'.
   - Keep only employees with 2 or more overbooked weeks.
4. Order the results:
   - First by meeting_heavy_weeks descending.
   - Then by employee_name ascending.

Notes / Pitfalls:
- How to retrieve the week starting as Monday: WEEK(meeting_date, 1)


Example:

Input:
employees table:
+-------------+----------------+-------------+
| employee_id | employee_name  | department  |
+-------------+----------------+-------------+
| 1           | Alice Johnson  | Engineering |
| 2           | Bob Smith      | Marketing   |
| 3           | Carol Davis    | Sales       |
| 4           | David Wilson   | Engineering |
| 5           | Emma Brown     | HR          |
+-------------+----------------+-------------+
meetings table:
+------------+-------------+--------------+--------------+----------------+
| meeting_id | employee_id | meeting_date | meeting_type | duration_hours |
+------------+-------------+--------------+--------------+----------------+
| 1          | 1           | 2023-06-05   | Team         | 8.0            |
| 2          | 1           | 2023-06-06   | Client       | 6.0            |
| 3          | 1           | 2023-06-07   | Training     | 7.0            |
| 4          | 1           | 2023-06-12   | Team         | 12.0           |
| 5          | 1           | 2023-06-13   | Client       | 9.0            |
| 6          | 2           | 2023-06-05   | Team         | 15.0           |
| 7          | 2           | 2023-06-06   | Client       | 8.0            |
| 8          | 2           | 2023-06-12   | Training     | 10.0           |
| 9          | 3           | 2023-06-05   | Team         | 4.0            |
| 10         | 3           | 2023-06-06   | Client       | 3.0            |
| 11         | 4           | 2023-06-05   | Team         | 25.0           |
| 12         | 4           | 2023-06-19   | Client       | 22.0           |
| 13         | 5           | 2023-06-05   | Training     | 2.0            |
+------------+-------------+--------------+--------------+----------------+

Output:
+-------------+----------------+-------------+---------------------+
| employee_id | employee_name  | department  | meeting_heavy_weeks |
+-------------+----------------+-------------+---------------------+
| 1           | Alice Johnson  | Engineering | 2                   |
| 4           | David Wilson   | Engineering | 2                   |
+-------------+----------------+-------------+---------------------+
*/

-- SQL Solution:
WITH cte AS (
    SELECT employee_id, SUM(duration_hours) AS total_meeting_hours
    FROM meetings 
    GROUP BY employee_id, WEEK(meeting_date, 1)
    HAVING SUM(duration_hours) > 20
)
SELECT c.employee_id, employee_name, department, COUNT(*) AS meeting_heavy_weeks
FROM cte c JOIN employees e USING (employee_id)
GROUP BY c.employee_id
HAVING meeting_heavy_weeks >=2
ORDER BY meeting_heavy_weeks DESC, employee_name;
