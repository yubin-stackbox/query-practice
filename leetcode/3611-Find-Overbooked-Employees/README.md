<h2>
  <a href="https://leetcode.com/problems/find-loyal-customers/?envType=problem-list-v2&envId=n4wrvgr7">3611. Find Overbooked Employees</a>
</h2> 
<p><strong>[Medium]</strong></p>

<p>Table: <code>employees</code></p>

<pre>
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| employee_id   | int     |
| employee_name | varchar |
| department    | varchar |
+---------------+---------+
employee_id is the unique identifier for this table.
Each row contains information about an employee and their department.
</pre>

<p>Table: <code>meetings</code></p>

<pre>
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| meeting_id    | int     |
| employee_id   | int     |
| meeting_date  | date    |
| meeting_type  | varchar |
| duration_hours| decimal |
+---------------+---------+
meeting_id is the unique identifier for this table.
Each row represents a meeting attended by an employee. meeting_type can be 'Team', 'Client', or 'Training'.
</pre>

<p>Write a solution to find employees who are meeting-heavy - employees who spend more than 50% of their working time in meetings during any given week.</p>
<ul>
  <li>Assume a standard work week is 40 hours</li>
  <li>Calculate total meeting hours per employee per week (Monday to Sunday)</li>
  <li>An employee is meeting-heavy if their weekly meeting hours > 20 hours (50% of 40 hours)</li>
  <li>Count how many weeks each employee was meeting-heavy</li>
  <li>Only include employees who were meeting-heavy for at least 2 weeks</li>
</ul>

Return the result table ordered by the number of meeting-heavy weeks in descending order, then by employee name in ascending order.
The result format is in the following example.<br><br>


<p><strong class="example">Example:</strong></p>

<pre>
<strong>Input:</strong> 
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


<strong>Output:</strong> 
+-------------+----------------+-------------+---------------------+
| employee_id | employee_name  | department  | meeting_heavy_weeks |
+-------------+----------------+-------------+---------------------+
| 1           | Alice Johnson  | Engineering | 2                   |
| 4           | David Wilson   | Engineering | 2                   |
+-------------+----------------+-------------+---------------------+
</pre>
