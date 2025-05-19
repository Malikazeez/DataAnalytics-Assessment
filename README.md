# DataAnalytics-Assessment

## 1.High-Value Customers with Multiple Products
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits
### Explanation
1. The task affects three tables to get a. Customer's Name (users_customer) b. Savings plan and investment plan (Plans_plan) C. Total Deposits (savings_savingsaccount)
2. This query identifies active customers who use both investment and savings products by joining user data with account plans and applying a HAVING filter to require at least one of each account type (tracked via SUM(P.is_a_fund) and SUM(P.is_regular_savings)). It then calculates their total deposits by joining with transaction data, converting amounts from kobo to naira (ROUND(SUM(S.confirmed_amount)/100,2), and returns customer IDs, names, their account counts, and aggregate deposits - efficiently profiling this valuable customer segment while handling currency conversion and ensuring data quality through explicit joins and grouping.

