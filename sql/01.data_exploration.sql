-- ==========================================================
-- EXPLORATORY DATA ANALYSIS (EDA)
-- ==========================================================
-- Purpose:
-- Analyze the raw customer dataset to understand data quality,
-- identify missing values, detect invalid records, validate
-- business rules, explore categorical distributions, and
-- uncover issues that must be addressed during data cleaning.
--
-- The findings from this analysis are used to guide data
-- cleaning, feature engineering, and customer churn modeling.
-- ==========================================================
SELECT
  COUNT(*) AS total_records,
  COUNT(DISTINCT customer_id) AS unique_customers,
  countif(churn = TRUE) AS total_churned,
  countif(churn = FALSE) AS total_active,
  round(countif(churn = TRUE) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
  min(signup_date) AS earliest_signup,
  max(signup_date) AS latest_signup
FROM `ecommerce-churn2.ecom.raw_customers`;

SELECT
  countif(email IS NULL OR trim(email) = '') AS null_emails,
  countif(phone IS NULL) AS null_phones,
  countif(gender IS NULL) AS null_gender,
  countif(age IS NULL) AS null_ages,
  countif(total_spent_inr IS NULL) AS null_total_spent,
  countif(avg_order_value_inr IS NULL) AS null_avg_order,
  countif(avg_product_rating IS NULL) AS null_ratings,
  countif(pincode IS NULL) AS null_pincodes,
  countif(churn_date IS NULL) AS null_churn_dates
FROM `ecommerce-churn2.ecom.raw_customers`;

SELECT age, COUNT(*) AS count
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE CAST(age AS float64) < 18 OR CAST(age AS float64) > 100
GROUP BY age
ORDER BY count DESC;

SELECT avg_product_rating, COUNT(*) AS count
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE avg_product_rating > 5 OR avg_product_rating < 1
GROUP BY avg_product_rating
ORDER BY avg_product_rating;

SELECT COUNT(*) AS negative_spend_records
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE total_spent_inr < 0;

SELECT COUNT(*) AS impossible_returns
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE total_returns > total_orders;

SELECT COUNT(*) AS future_churn_dates
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE
  churn_date IS NOT NULL
  AND CAST(churn_date AS date) > current_date('Asia/Kolkata');

SELECT gender, COUNT(*) AS count
FROM `ecommerce-churn2.ecom.raw_customers`
GROUP BY gender
ORDER BY count DESC;

SELECT membership_tier, COUNT(*) AS count
FROM `ecommerce-churn2.ecom.raw_customers`
GROUP BY membership_tier
ORDER BY count DESC;

SELECT preferred_payment, COUNT(*) AS count
FROM `ecommerce-churn2.ecom.raw_customers`
GROUP BY preferred_payment
ORDER BY count DESC;

SELECT first_name, last_name, email, signup_date, COUNT(*) AS appearances
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE
  email IS NOT NULL
  AND lower(trim(email))
    NOT IN ('n/a', 'na', 'null', '-', 'none', 'test', 'unknown')
GROUP BY first_name, last_name, email, signup_date
HAVING appearances > 1
ORDER BY appearances DESC
LIMIT 20;

SELECT COUNT(*) AS negative_days
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE days_since_last_purchase < 0;

SELECT COUNT(*) AS negative_complaints
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE total_complaints < 0;

SELECT COUNT(*) AS active_but_has_churn_date
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE churn = FALSE AND churn_date IS NOT NULL;

SELECT COUNT(*) AS churned_but_no_churn_date
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE churn = TRUE AND churn_date IS NULL;

SELECT COUNT(*) AS zero_sessions
FROM `ecommerce-churn2.ecom.raw_customers`
WHERE sessions_per_month <= 0;
