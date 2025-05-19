WITH last_inflow AS (
    SELECT s.plan_id, MAX(s.transaction_date) AS last_transaction_date
    FROM savings_savingsaccount s
    WHERE s.confirmed_amount > 0
    GROUP BY s.plan_id
),

inactivity AS (
    SELECT p.id AS plan_id, p.owner_id,
		CASE 
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
            ELSE 'Other'
        END AS type,
        li.last_transaction_date,
        DATEDIFF(CURDATE(), li.last_transaction_date) AS inactivity_days
    FROM plans_plan p
    LEFT JOIN last_inflow li ON p.id = li.plan_id
    WHERE (p.is_regular_savings = 1 OR p.is_a_fund = 1)
)

SELECT *
FROM inactivity
WHERE last_transaction_date IS NULL 
   OR DATEDIFF(CURDATE(), last_transaction_date) > 365
ORDER BY inactivity_days DESC;
