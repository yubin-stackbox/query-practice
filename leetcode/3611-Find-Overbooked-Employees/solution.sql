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
