-- ==========================================================
-- ANALYTICS VIEWS FOR DASHBOARD REPORTING
-- ==========================================================
-- Purpose:
-- Create reusable analytical views that serve as the data
-- foundation for the Customer Churn Dashboard in Looker Studio.
--
-- Views Created:
-- 1. kpi_summary
--    - Executive KPI metrics including customer count,
--      churn rate, active customers, and revenue metrics.
--
-- 2. segment_churn
--    - Customer-level attributes for churn analysis across
--      demographics, behavior, channels, devices, and
--      recency segments.
--
-- 3. churn_trend
--    - Monthly churn trends, churn reasons, and revenue
--      lost from churned customers.
--
-- 4. risk_scores
--    - RFM-based customer risk scores, customer segments,
--      and churn risk classifications used for retention
--      analysis.
--
-- These views provide optimized datasets for dashboard
-- visualizations, KPI tracking, customer segmentation,
-- trend analysis, and churn risk monitoring.
-- ==========================================================





-- VIEWS
CREATE OR REPLACE VIEW `ecommerce-churn2.ecom.kpi_summary`
AS
SELECT
  COUNT(*) AS total_customers,
  countif(is_churned = 1) AS churned,
  countif(is_churned = 0) AS active,
  round(countif(is_churned = 1) * 100.0 / nullif(COUNT(*), 0), 2) AS churn_rate,
  round(sum(total_spent_inr), 2) AS total_revenue,
  round(avg(total_spent_inr), 2) AS avg_spent_revenue
FROM `ecommerce-churn2.ecom.clean_customers`;

SELECT *
FROM `ecommerce-churn2.ecom.kpi_summary`;

CREATE OR REPLACE VIEW `ecommerce-churn2.ecom.segment_churn`
AS
SELECT
  membership_tier,
  acquisition_channel,
  favorite_category,
  preferred_device,
  preferred_payment,
  gender,
  age_group,
  city,
  churn,
  is_churned,
  total_spent_inr,
  total_orders,
  avg_order_value_inr,
  sessions_per_month,
  discount_usage_pct,
  total_complaints,
  recency_bucket,
  CASE
    WHEN recency_bucket = '0-30 days' THEN 1
    WHEN recency_bucket = '31-90 days' THEN 2
    WHEN recency_bucket = '91-180 days' THEN 3
    WHEN recency_bucket = '181-365 days' THEN 4
    WHEN recency_bucket = '365+ days' THEN 5
    ELSE 6
    END AS recency_sort,
  days_since_last_purchase,
  total_returns
FROM `ecommerce-churn2.ecom.clean_customers`;

SELECT *
FROM `ecommerce-churn2.ecom.segment_churn`;

CREATE OR REPLACE VIEW `ecommerce-churn2.ecom.churn_trend`
AS
SELECT
  date_trunc(churn_date, month) AS churn_month,
  churn_reason,
  COUNT(*) AS churned_count,
  round(sum(total_spent_inr), 2) AS revenue_lost
FROM `ecommerce-churn2.ecom.clean_customers`
WHERE churn_date IS NOT NULL AND is_churned = 1
GROUP BY churn_month, churn_reason;

SELECT *
FROM `ecommerce-churn2.ecom.churn_trend`;

CREATE OR REPLACE VIEW `ecommerce-churn2.ecom.risk_scores`
AS
SELECT
  customer_id,
  full_name,
  membership_tier,
  favorite_category,
  city,
  recency_days,
  total_orders,
  total_spent_inr,
  r_score,
  f_score,
  m_score,
  rfm_total_score,
  customer_segment,
  churn_risk_score,
  CASE
    WHEN churn_risk_score >= 70 THEN 'High Risk'
    WHEN churn_risk_score >= 40 THEN 'Medium Risk'
    ELSE 'Low Risk'
    END AS risk_tier,
  is_churned,
  churn_reason
FROM `ecommerce-churn2.ecom.rfm_scores`;

SELECT *
FROM `ecommerce-churn2.ecom.risk_scores`;
