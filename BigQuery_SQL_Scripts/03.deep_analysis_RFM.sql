-- ==========================================================
-- CUSTOMER CHURN ANALYSIS & RFM MODELING
-- ==========================================================
-- Purpose:
-- Perform in-depth customer churn analysis to identify the
-- key drivers of churn, quantify business impact, and uncover
-- customer segments with the highest retention risk.
--
-- Analysis Areas:
-- 1. Overall churn performance and customer KPIs
-- 2. Churn trends across recency, membership tiers,
--    acquisition channels, demographics, and customer behavior
-- 3. Revenue impact of churn and revenue-at-risk estimation
-- 4. Churn reason analysis and identification of high-value
--    churned customers
-- 5. Customer segmentation using RFM (Recency, Frequency,
--    Monetary) analysis
-- 6. Development of a churn risk scoring model to classify
--    customers into High, Medium, and Low Risk groups
--
-- Outputs from this analysis are used to support retention
-- strategies, prioritize at-risk customers, and power the
-- Looker Studio dashboard.
-- ==========================================================


-- DEEP ANALYSIS
SELECT
  COUNT(*) AS total_customers,
  countif(is_churned = 1) AS total_churned,
  countif(is_churned = 0) AS total_active,
  round(countif(is_churned = 1) * 100.0 / nullif(COUNT(*), 0), 2)
    AS churn_rate_pct,
  round(avg(total_spent_inr), 2) AS avg_lieftime_value,
  round(sum(CASE WHEN is_churned = 1 THEN total_spent_inr END), 2)
    AS revenue_from_churned,
  round(sum(CASE WHEN is_churned = 0 THEN total_spent_inr END), 2)
    AS revenue_from_active,
  round(avg(total_orders), 2) AS avg_orders_per_customer,
  round(avg(sessions_per_month), 2) AS avg_monthly_sessions
FROM `ecommerce-churn2.ecom.clean_customers`;


SELECT
  recency_bucket,
  COUNT(*) AS customers,
  countif(is_churned = 1) AS churned,
  round(countif(is_churned = 1) * 100.0 / nullif(COUNT(*), 0), 2)
    AS churn_rate_pct,
  round(avg(total_spent_inr), 2) AS avg_spend
FROM `ecommerce-churn2.ecom.clean_customers`
GROUP BY recency_bucket
ORDER BY
  CASE recency_bucket
    WHEN '0-30 days' THEN 1
    WHEN '31-90 days' THEN 2
    WHEN '91-180 days' THEN 3
    WHEN '181-365 days' THEN 4
    WHEN '365+ days' THEN 5
    ELSE 6
    END;


SELECT
  format_date('%Y-%m', churn_date) AS churn_month,
  COUNT(*) AS customers_churned,
  round(avg(total_spent_inr), 2) AS avg_spend_of_churned_customers
FROM `ecommerce-churn2.ecom.clean_customers`
WHERE churn_date IS NOT NULL
GROUP BY churn_month
ORDER BY churn_month;


SELECT
  membership_tier AS tier,
  COUNT(*) AS customers,
  countif(is_churned = 1) AS churned,
  round(countif(is_churned = 1) * 100.0 / nullif(COUNT(*), 0), 2)
    AS churn_rate_pct,
  round(avg(total_spent_inr), 2) AS avg_spend
FROM `ecommerce-churn2.ecom.clean_customers`
GROUP BY tier
ORDER BY churn_rate_pct DESC;


SELECT
  acquisition_channel,
  COUNT(*) AS total_acquired,
  countif(is_churned = 1) AS churned,
  round(countif(is_churned = 1) * 100.0 / nullif(COUNT(*), 0), 2)
    AS churn_rate_pct,
  round(avg(total_spent_inr), 2) AS avg_lifetime_spend
FROM `ecommerce-churn2.ecom.clean_customers`
GROUP BY acquisition_channel
ORDER BY churn_rate_pct DESC;


SELECT
  favorite_category,
  preferred_device,
  COUNT(*) AS customers,
  countif(is_churned = 1) AS churned,
  round(countif(is_churned = 1) * 100.0 / nullif(COUNT(*), 0), 2)
    AS churn_rate_pct
FROM `ecommerce-churn2.ecom.clean_customers`
GROUP BY favorite_category, preferred_device
ORDER BY churn_rate_pct DESC;


SELECT
  age_group,
  COUNT(*) AS customers,
  countif(is_churned = 1) AS churned,
  round(countif(is_churned = 1) * 100.0 / nullif(COUNT(*), 0), 2)
    AS churn_rate_pct
FROM `ecommerce-churn2.ecom.clean_customers`
GROUP BY age_group
ORDER BY churn_rate_pct DESC;


SELECT
  round(sum(CASE WHEN is_churned = 1 THEN total_spent_inr ELSE 0 END), 2)
    AS historical_revenue_from_churned,
  round(sum(CASE WHEN is_churned = 1 THEN avg_order_value_inr ELSE 0 END), 2)
    AS potential_next_order_revenue_lost,
  round(avg(CASE WHEN is_churned = 1 THEN total_spent_inr END), 2)
    AS avg_revenue_per_churned_customer,
  round(avg(CASE WHEN is_churned = 0 THEN total_spent_inr END), 2)
    AS avg_revenue_per_active_customer
FROM `ecommerce-churn2.ecom.clean_customers`;


SELECT
  membership_tier,
  favorite_category,
  countif(is_churned = 1) AS churned_count,
  round(sum(CASE WHEN is_churned = 1 THEN avg_order_value_inr ELSE 0 END), 2)
    AS monthly_revenue_at_risk,
  round(
    sum(CASE WHEN is_churned = 1 THEN avg_order_value_inr ELSE 0 END) * 12, 2)
    AS annual_revenue_at_risk
FROM `ecommerce-churn2.ecom.clean_customers`
GROUP BY membership_tier, favorite_category
ORDER BY annual_revenue_at_risk DESC;


SELECT
  churn_reason,
  COUNT(*) AS customers_churned,
  round(COUNT(*) * 100.0 / nullif(sum(COUNT(*)) OVER (), 0), 2)
    AS pct_of_total_churn,
  round(avg(total_spent_inr), 2) AS avg_spend
FROM `ecommerce-churn2.ecom.clean_customers`
WHERE churn_date IS NOT NULL AND churn_reason IS NOT NULL
GROUP BY churn_reason
ORDER BY customers_churned DESC;


SELECT
  customer_id,
  full_name,
  city,
  membership_tier,
  total_spent_inr,
  total_orders,
  churn_reason,
  days_since_last_purchase
FROM `ecommerce-churn2.ecom.clean_customers`
WHERE is_churned = 1
ORDER BY total_spent_inr DESC
LIMIT 20;


--RFM_Scores
CREATE OR REPLACE VIEW `ecommerce-churn2.ecom.rfm_scores`
AS
WITH
  rfm_raw AS (
    SELECT
      customer_id,
      full_name,
      membership_tier,
      favorite_category,
      total_complaints,
      city,
      is_churned,
      churn_reason,
      avg_order_value_inr,
      days_since_last_purchase AS recency_days,
      ntile(5) OVER (ORDER BY days_since_last_purchase DESC) AS r_score,
      total_orders,
      ntile(5) OVER (ORDER BY total_orders ASC) AS f_score,
      total_spent_inr,
      ntile(5) OVER (ORDER BY total_spent_inr ASC) AS m_score
    FROM `ecommerce-churn2.ecom.clean_customers`
    WHERE days_since_last_purchase IS NOT NULL AND total_spent_inr IS NOT NULL
  )
SELECT
  *,
  (r_score + f_score + m_score) AS rfm_total_score,
  CASE
    WHEN (r_score + f_score + m_score) >= 13 THEN 'Champions'
    WHEN (r_score + f_score + m_score) >= 10 THEN 'Loyal Customers'
    WHEN (r_score + f_score + m_score) >= 7 THEN 'At Risk'
    WHEN (r_score + f_score + m_score) >= 4 THEN 'About to Churn'
    ELSE 'Lost'
    END AS customer_segment,
  least(
    100,
    greatest(
      0,
      CASE
        WHEN recency_days > 365 THEN 40
        WHEN recency_days > 180 THEN 25
        WHEN recency_days > 90 THEN 12
        ELSE 0
        END
        + CASE
          WHEN total_orders <= 2 THEN 20
          WHEN total_orders <= 5 THEN 10
          ELSE 0
          END
        + CASE
          WHEN membership_tier = 'None' THEN 15
          WHEN membership_tier = 'Silver' THEN 8
          WHEN membership_tier = 'Gold' THEN 3
          ELSE 0
          END
        + CASE
          WHEN total_spent_inr < 500 THEN 15
          WHEN total_spent_inr < 2000 THEN 8
          ELSE 0
          END
        + 10 * least(1, total_complaints))) AS churn_risk_score
FROM rfm_raw;



SELECT
  CASE
    WHEN churn_risk_score >= 70 THEN 'High Risk'
    WHEN churn_risk_score >= 40 THEN 'Medium Risk'
    ELSE 'Low Risk'
    END AS risk_tier,
  COUNT(*) AS customers,
  countif(is_churned = 1) AS actually_churned,
  round(countif(is_churned = 1) * 100.0 / nullif(COUNT(*), 0), 2)
    AS actual_churn_rate,
  round(avg(total_spent_inr), 2) AS avg_spend
FROM `ecommerce-churn2.ecom.rfm_scores`
GROUP BY risk_tier
ORDER BY actual_churn_rate DESC;
