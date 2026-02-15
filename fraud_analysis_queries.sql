-- 1. What percentage of total transactions are fraudulent?
SELECT 
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraudulent_transactions,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM transactions;

-- 2. Which fraud type causes the most financial damage?
SELECT 
    fraud_type,
    COUNT(*) AS total_occurrences,
    SUM(transaction_amount_inr) AS total_amount,
    ROUND(AVG(transaction_amount_inr), 2) AS avg_amount
FROM transactions
WHERE is_fraud = 1
GROUP BY fraud_type
ORDER BY total_amount DESC;

-- 3. Which merchants get hit the hardest by fraud?
SELECT 
    merchant_name,
    COUNT(*) AS fraud_count,
    SUM(transaction_amount_inr) AS total_fraud_amount,
    ROUND(AVG(fraud_score), 1) AS avg_fraud_score
FROM transactions
WHERE is_fraud = 1
GROUP BY merchant_name
ORDER BY fraud_count DESC
LIMIT 10;

-- 4. Do certain card types get targeted more often?
SELECT 
    card_type,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM transactions
GROUP BY card_type
ORDER BY fraud_rate_pct DESC;

-- 5. Which months have the highest fraud volume?
SELECT 
    EXTRACT(MONTH FROM transaction_date) AS month_num,
    TO_CHAR(transaction_date, 'Month') AS month_name,
    COUNT(*) AS fraud_count,
    SUM(transaction_amount_inr) AS total_fraud_amount
FROM transactions
WHERE is_fraud = 1
GROUP BY EXTRACT(MONTH FROM transaction_date), TO_CHAR(transaction_date, 'Month')
ORDER BY fraud_count DESC;

-- 6. How does fraud risk level break down by dollar amount?
SELECT 
    fraud_risk,
    COUNT(*) AS transaction_count,
    SUM(transaction_amount_inr) AS total_amount,
    ROUND(AVG(transaction_amount_inr), 2) AS avg_amount,
    MIN(transaction_amount_inr) AS min_amount,
    MAX(transaction_amount_inr) AS max_amount
FROM transactions
GROUP BY fraud_risk
ORDER BY total_amount DESC;

-- 7. Which bank's customers are most vulnerable to fraud?
SELECT 
    bank,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS fraud_count,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct,
    ROUND(AVG(fraud_score), 1) AS avg_fraud_score
FROM transactions
GROUP BY bank
ORDER BY fraud_rate_pct DESC;

-- 8. What's the relationship between fraud score and actual fraud?
SELECT 
    CASE 
        WHEN fraud_score BETWEEN 0 AND 25 THEN '0-25 Low'
        WHEN fraud_score BETWEEN 26 AND 50 THEN '26-50 Medium'
        WHEN fraud_score BETWEEN 51 AND 75 THEN '51-75 High'
        ELSE '76-100 Critical'
    END AS score_range,
    COUNT(*) AS total_transactions,
    SUM(is_fraud) AS actual_frauds,
    ROUND(SUM(is_fraud) * 100.0 / COUNT(*), 2) AS fraud_rate_pct
FROM transactions
GROUP BY score_range
ORDER BY score_range;