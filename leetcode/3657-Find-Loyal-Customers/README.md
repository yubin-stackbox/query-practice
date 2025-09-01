<h2>
  <a href="https://leetcode.com/problems/find-loyal-customers/?envType=problem-list-v2&envId=n4wrvgr7">3657. Find Loyal Customers</a>
</h2> 
<p><strong>[Medium]</strong></p>

<p>Table: <code>customer_transactions</code></p>

<pre>
+------------------+---------+
| Column Name      | Type    | 
+------------------+---------+
| transaction_id   | int     |
| customer_id      | int     |
| transaction_date | date    |
| amount           | decimal |
| transaction_type | varchar |
+------------------+---------+
transaction_id is the unique identifier for this table.
transaction_type can be either 'purchase' or 'refund'.
</pre>

<p>Write a solution to find <strong>loyal customers</strong>. A customer is considered <strong>loyal</strong> if they meet ALL the following criteria:</p>
<ul>
  <li>Made at least 3 purchase transactions.</li>
  <li>Have been active for at least 30 days.</li>
  <li>Their refund rate is less than 20% .</li>
</ul>

Return the result table ordered by <code>customer_id</code> in ascending order.
The result format is in the following example.<br><br>


<p><strong class="example">Example:</strong></p>

<pre>
<strong>Input:</strong> 
customer_transactions table:
+----------------+-------------+------------------+--------+------------------+
| transaction_id | customer_id | transaction_date | amount | transaction_type |
+----------------+-------------+------------------+--------+------------------+
| 1              | 101         | 2024-01-05       | 150.00 | purchase         |
| 2              | 101         | 2024-01-15       | 200.00 | purchase         |
| 3              | 101         | 2024-02-10       | 180.00 | purchase         |
| 4              | 101         | 2024-02-20       | 250.00 | purchase         |
| 5              | 102         | 2024-01-10       | 100.00 | purchase         |
| 6              | 102         | 2024-01-12       | 120.00 | purchase         |
| 7              | 102         | 2024-01-15       | 80.00  | refund           |
| 8              | 102         | 2024-01-18       | 90.00  | refund           |
| 9              | 102         | 2024-02-15       | 130.00 | purchase         |
| 10             | 103         | 2024-01-01       | 500.00 | purchase         |
| 11             | 103         | 2024-01-02       | 450.00 | purchase         |
| 12             | 103         | 2024-01-03       | 400.00 | purchase         |
| 13             | 104         | 2024-01-01       | 200.00 | purchase         |
| 14             | 104         | 2024-02-01       | 250.00 | purchase         |
| 15             | 104         | 2024-02-15       | 300.00 | purchase         |
| 16             | 104         | 2024-03-01       | 350.00 | purchase         |
| 17             | 104         | 2024-03-10       | 280.00 | purchase         |
| 18             | 104         | 2024-03-15       | 100.00 | refund           |
+----------------+-------------+------------------+--------+------------------+

<strong>Output:</strong> 
+-------------+
| customer_id |
+-------------+
| 101         |
| 104         |
+-------------+
</pre>
