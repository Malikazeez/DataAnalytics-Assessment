WITH monthly_transactions AS (
    SELECT 
        s.owner_id, YEAR(s.transaction_date) AS year, MONTH(s.transaction_date) AS month,
        COUNT(*) AS transactions_per_month
    FROM savings_savingsaccount s
    WHERE transaction_status = "success"
    GROUP BY s.owner_id, year, month
),

average_transactions AS (
    SELECT owner_id,AVG(transactions_per_month) AS avg_transactions_per_month
    FROM monthly_transactions
    GROUP BY owner_id
),

categories AS (
    SELECT owner_id, avg_transactions_per_month,
		CASE
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM average_transactions
)

SELECT
    frequency_category, COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM categories
GROUP BY frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;
