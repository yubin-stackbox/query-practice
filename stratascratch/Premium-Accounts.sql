/*
Problem: Premium Accounts (stratascratch #2097)
Link: https://platform.stratascratch.com/coding/2097-premium-acounts?code_type=3
Difficulty: Medium

Description:
For the first 7 dates in the dataset, count premium accounts with final_price > 0 (actively paying). Then, count how many of those same accounts are still actively paying exactly 7 days later. 
Output: date, paying accounts on that day, paying accounts after 7 days.

Approach:
1. Self left join the table to determine whehter the user is active(final_price > 0) 7 days later
    - Joining condition: account_id and the first entry date + 7 days = second entry_date 
2. Filter out 
- Count the number of accounts who are active on the date and 7 days later
2. Count the number of accounts who are active on the date

Notes / Pitfalls:
- Clear understanding of the business requirements is crucial. In this case, the concept of the premium account is the users who are active on both today and 7 days later.
*/

SELECT t1.entry_date, COUNT(t1.account_id) premium_paid_accounts, COUNT(t2.account_id) premium_paid_accounts_after_7d
FROM premium_accounts_by_day t1 LEFT JOIN premium_accounts_by_day t2 ON t1.account_id = t2.account_id 
AND DATE_ADD(t1.entry_date, INTERVAL 7 DAY) = t2.entry_date
WHERE t1.final_price > 0 AND t2.final_price > 0
GROUP BY t1.entry_date
ORDER BY t1.entry_date
LIMIT 7;
