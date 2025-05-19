# DataAnalytics-Assessment

## 1.High-Value Customers with Multiple Products
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits
### Explanation
1. This task involves data from three key tables: **users_customuser** (to retrieve customer names), **plans_plan** (to identify savings and investment plans), and **savings_savingsaccount** (to calculate total deposits). The query identifies active customers who hold both a funded savings plan and a funded investment plan. It does so by joining user records with plan data and using aggregate filters—specifically **SUM(P.is_a_fund)** and **SUM(P.is_regular_savings)**—to ensure each customer has at least one of each product type. The query then joins with the savings transactions table to compute total deposits, converting values from kobo to naira using **ROUND(SUM(S.confirmed_amount) / 100, 2)**. The final result includes customer IDs, full names, counts of each plan type, and their total deposits—effectively profiling high-value, cross-product users while ensuring data accuracy through structured joins and grouping logic.

