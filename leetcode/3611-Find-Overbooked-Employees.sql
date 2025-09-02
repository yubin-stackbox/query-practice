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
*/

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
