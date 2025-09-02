/*
Problem: Find Loyal Customers (LeetCode #3657)
Link: https://leetcode.com/problems/find-loyal-customers/
Difficulty: Medium

Description:
Identify loyal customers from the 'customer_transactions' table.
A loyal customer if they:
1. Made at least 3 purchase transactions,
2. Active for at least 30 days (difference between first and last transaction dates), and
3. Refund rate is less than 20% (number of refunds / total transactions).

Approach:
1. Aggregate transactions per customer:
   - Group by customer_id to calculate metrics per customer.
2. Count purchase and refund transactions:
   - COUNT(CASE WHEN transaction_type = 'purchase' THEN 1 END) → number of purchases
   - COUNT(CASE WHEN transaction_type = 'refund' THEN 1 END) → number of refunds
3. Calculate active period:
   - DATEDIFF(MAX(transaction_date), MIN(transaction_date)) → total active days
   - Ensures customer has been active for at least 30 days
4. Filter loyal customers:
   - Purchase count >= 3
   - Active period >= 30 days
   - Refund rate = refund_count / total_transaction_count < 0.2
5. Order results:
   - ORDER BY 1 (customer_id ascending)

Notes / Pitfalls:
- DATEDIFF(bigger_date, smaller_dat) as it will bigger_date - smaller_date for returning the positive value
*/

SELECT customer_id
FROM customer_transactions
GROUP BY customer_id
HAVING COUNT(CASE WHEN transaction_type = 'purchase' THEN 1 END) >= 3
AND DATEDIFF(MAX(transaction_date), MIN(transaction_date)) >= 30
AND COUNT(CASE WHEN transaction_type = 'refund' THEN 1 END) / COUNT(*) < 0.2
ORDER BY customer_id;
