/*
Problem: Meta/Facebook Accounts (stratascratch #10296)
Link: https://platform.stratascratch.com/coding/10296-facebook-accounts?code_type=3
Difficulty: Medium

Description:
Of all accounts with status records on January 10th, 2020, calculate the ratio of those with 'closed' status.

Approach:
1. Filter out the records in specific date '2020-01-10'
2. Calculate the closed_ratio by dividing the number of 'closed' account by all accounts
3. Show the result in 2 rounded float

Notes / Pitfalls:
- Use Simple CASE WHEN to count the rows that match the condition
*/

SELECT ROUND(COUNT(CASE status WHEN 'closed' THEN 1 END) / COUNT(*), 2) AS closed_ratio
FROM fb_account_status
WHERE status_date = '2020-01-10'
