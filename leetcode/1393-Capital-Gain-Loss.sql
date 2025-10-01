/*
Problem: Capital Gain/Loss (LeetCode #1393)
Link: https://leetcode.com/problems/capital-gainloss
Difficulty: Medium

Description:
Report the capital gain or loss (the net result after buying and selling a stock) for each stock.

Approach:
1. When a stock is bought, subtract its price.
2. When a stock is sold, add its price.

Notes / Pitfalls:
- The CASE statement is supported by most database systems, whereas the IF() function is specific to MySQL.
*/

SELECT stock_name, SUM(CASE WHEN operation = 'Buy' THEN -price ELSE price END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;
