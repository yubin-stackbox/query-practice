/*
Problem: Find the percentage of shipable orders (stratascratch #10090)
Link: https://platform.stratascratch.com/coding/10090-find-the-percentage-of-shipable-orders?code_type=3
Difficulty: Medium

Description:
Find the percentage of shipable orders which are orders that the customer's address is known.

Approach:
1. Join the order table with the customer table to link order and address
2. Count the customer records whose address is not null, devided by the all records

Notes / Pitfalls:
- COUNT with CASE WHEN
*/

SELECT COUNT(CASE WHEN address IS NOT NULL THEN 1 END) / COUNT(*) * 100 AS percent_shipable
FROM orders o JOIN customers c ON o.cust_id = c.id
