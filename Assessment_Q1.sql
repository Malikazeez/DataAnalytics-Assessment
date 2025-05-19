WITH username AS (
    SELECT 
        P.owner_id,CONCAT(UC.first_name, ' ', UC.last_name) AS full_name,
        SUM(P.is_a_fund) AS investment_count,
        SUM(P.is_regular_savings) AS savings_count
    FROM users_customuser AS UC
    JOIN plans_plan AS P ON UC.id = P.owner_id
    GROUP BY P.owner_id, full_name
    HAVING investment_count >= 1 AND savings_count >= 1
)
SELECT U.owner_id, U.full_name, U.investment_count, U.Savings_count, ROUND(SUM(S.confirmed_amount) / 100,2) AS total_deposit
From username as U
JOIN savings_savingsaccount AS S ON U.owner_id=S.owner_id
GROUP BY U.owner_id, U.full_name, U.investment_count, U.Savings_count;


