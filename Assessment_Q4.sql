WITH user_details AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
        COUNT(s.id) AS total_transactions,
        SUM(s.confirmed_amount) / 100 AS total_value_naira
    FROM users_customuser u
    JOIN savings_savingsaccount s ON u.id = s.owner_id
    WHERE s.transaction_status = 'success'
    GROUP BY u.id, name, tenure_months
)

SELECT 
    customer_id, name, tenure_months, total_transactions,
    ROUND(
        (total_transactions / NULLIF(tenure_months, 0)) * 12 * (0.001 * (total_value_naira / NULLIF(total_transactions, 0)))
    , 2) AS estimated_clv
FROM user_details
ORDER BY estimated_clv DESC;
