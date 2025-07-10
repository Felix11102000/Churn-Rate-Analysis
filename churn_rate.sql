CREATE DATABASE project4;
USE project4;
# Input data from Excel
DESC telco_churn;
SELECT * FROM telco_churn LIMIT 100;

SELECT * FROM telco_churn
WHERE TotalCharges IS NULL;
SELECT 
    ROUND(100.0 * SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_missing_TotalCharges
FROM telco_churn;

#1 Hitung churn rate
SELECT
    Churn,
    COUNT(*) AS total
FROM telco_churn
GROUP BY Churn;

#2 Hitung Persentase Churn Rate 
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn;

#3 churn Rate by Contract Type
SELECT
    Contract,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

#4 Churn Rate by Internet Service
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_pct
FROM telco_churn
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;


