# DataAnalytics-Assessment

## 1.High-Value Customers with Multiple Products
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits
### Explanation
This task involves data from three key tables: **users_customuser** (to retrieve customer names), **plans_plan** (to identify savings and investment plans), and **savings_savingsaccount** (to calculate total deposits). The query identifies active customers who hold both a funded savings plan and a funded investment plan. It does so by joining user records with plan data and using aggregate filters—specifically **SUM(P.is_a_fund)** and **SUM(P.is_regular_savings)**—to ensure each customer has at least one of each product type. The query then joins with the savings transactions table to compute total deposits, converting values from kobo to naira using **ROUND(SUM(S.confirmed_amount) / 100, 2)**. The final result includes customer IDs, full names, counts of each plan type, and their total deposits—effectively profiling high-value, cross-product users while ensuring data accuracy through structured joins and grouping logic.

## 2. Transaction Frequency Analysis
Task: Calculate the average number of transactions per customer per month and categorize them: "High Frequency" (≥10 transactions/month), "Medium Frequency" (3-9 transactions/month), "Low Frequency" (≤2 transactions/month)
### Explanation
This query analyzes customer transaction frequency in three steps: **First**, it counts successful monthly transactions per customer. **Second**, it calculates each customer's average monthly transactions. **Third**, it classifies customers into High (10+ transactions/month), Medium (3-9), or Low (<3) frequency tiers. The final output shows how many customers fall into each category along with their average transaction counts, sorted from most to least active. The approach transforms raw transaction data into actionable customer segments by progressively aggregating and categorizing the data while ensuring accuracy through proper **filtering of only successful transactions**

## 3. Account Inactivity Alert
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)
### Explanation
This query identifies inactive savings and investment accounts in three stages: **First**, it finds the last deposit date for each account by filtering for positive transactions (confirmed_amount > 0) and selecting the most recent date (MAX). **Second**, it categorizes each account as Savings, Investment, or Other, and calculates inactivity duration in days (DATEDIFF). **Finally**, it filters for accounts with no deposits (NULL) or over 365 days of inactivity, sorted by longest inactive first. The approach systematically isolates dormant accounts by verifying transaction history while excluding irrelevant account types, providing a clear view of customer engagement gaps.

## 4. Customer Lifetime Value (CLV) Estimation
Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate: Account tenure (months since signup), Total transactions
Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction), Order by estimated CLV from highest to lowest
### Explanation
This query calculates customer lifetime value (CLV) in three phases: **First**, it compiles user profiles including their transaction history and tenure by joining user data with successful transactions (transaction_status = 'success'). **Second**, it computes key metrics - transaction counts and total deposit amounts (converted from kobo to naira). **Finally**, it estimates CLV by combining transaction frequency (adjusted to annual rate) with average transaction value (scaled by 0.001), presenting results in descending order of customer value. The NULLIF safeguards prevent division errors for new or inactive customers, while the ROUND function ensures clean monetary formatting. This approach effectively transforms raw transaction data into actionable customer value insights.

## Challenges faced during the assessment
1. The database file wasn't universal, It could be only be used on MySQL
