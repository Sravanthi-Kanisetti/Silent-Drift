-- ==========================================================
-- DATA CLEANING & VALIDATION
-- ==========================================================
-- Purpose:
-- Transform the raw customer dataset into a clean, reliable,
-- and analysis-ready dataset for churn analysis.
--
-- Data Cleaning Tasks:
-- 1. Standardized text formats and categorical values
-- 2. Handled missing, invalid, and placeholder values
-- 3. Cleaned email addresses and phone numbers
-- 4. Corrected inconsistent membership and payment categories
-- 5. Fixed invalid ages, ratings, spending amounts, and dates
-- 6. Created derived features such as full_name, age_group,
--    recency_bucket, and is_churned
-- 7. Removed duplicate customer records using ROW_NUMBER()
--
-- Data Validation Tasks:
-- 1. Verified row counts after cleaning
-- 2. Checked remaining null values and invalid records
-- 3. Validated churn metrics and business rules
-- 4. Confirmed dataset quality before analysis and modeling
--
-- The resulting clean_customers table serves as the
-- foundation for customer segmentation, churn risk scoring,
-- KPI reporting, and dashboard development.
-- ==========================================================



-- DATA CLEANING
CREATE OR REPLACE TABLE `ecommerce-churn2.ecom.clean_customers`
AS
SELECT
  trim(customer_id) AS customer_id,
  initcap(trim(first_name)) AS first_name,
  initcap(trim(last_name)) AS last_name,
  concat(initcap(trim(first_name)), ' ', initcap(trim(last_name))) AS full_name,
  CASE
    WHEN email IS NULL THEN NULL
    WHEN email NOT LIKE '%@%' THEN NULL
    WHEN
      lower(trim(email))
      IN ('n/a', 'na', 'null', 'test', 'none', 'unknown', '', '-')
      THEN NULL
    WHEN
      lower(trim(email)) LIKE 'null@%'
      OR lower(trim(email)) LIKE 'test@%'
      OR lower(trim(email)) LIKE 'none@%'
      OR lower(trim(email)) LIKE 'unknown@%'
      THEN NULL
    ELSE lower(trim(email))
    END AS email,
  CASE
    WHEN phone IS NULL THEN NULL
    WHEN length(regexp_replace(trim(phone), r'[^0-9]', '')) < 10 THEN NULL
    WHEN regexp_replace(trim(phone), r'[^0-9]', '') = '0000000000' THEN NULL
    ELSE RIGHT(regexp_replace(trim(phone), r'[^0-9]', ''), 10)
    END AS phone,
  CASE
    WHEN
      gender IS NULL
      OR upper(trim(gender)) IN ('N/A', 'NA', 'NULL', '', 'UNKNOWN', 'NONE')
      THEN 'Unknown'
    WHEN upper(trim(gender)) IN ('MALE', 'M', '1') THEN 'Male'
    WHEN upper(trim(gender)) IN ('FEMALE', 'F', '0') THEN 'Female'
    WHEN upper(trim(gender)) IN ('OTHER')
      THEN 'Other'
    ELSE 'Unknown'
    END AS gender,
  CASE
    WHEN age IS NULL THEN NULL
    WHEN age < 18 OR age > 90 THEN NULL
    ELSE CAST(age AS int64)
    END AS age,
  CASE
    WHEN age IS NULL OR age < 18 OR age > 90 THEN 'Unknown'
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 45 THEN '36-45'
    WHEN age BETWEEN 46 AND 55 THEN '46-55'
    WHEN age BETWEEN 56 AND 90 THEN '56+'
    ELSE 'Unknown'
    END AS age_group,
  initcap(trim(city)) AS city,
  initcap(trim(state)) AS state,
  CASE
    WHEN
      trim(CAST(pincode AS string)) = ''
      OR trim(CAST(pincode AS string)) = '000000'
      OR pincode IS NULL
      THEN NULL
    ELSE pincode
    END AS pincode,
  CASE
    WHEN CAST(signup_date AS date) > current_date('Asia/Kolkata') THEN NULL
    ELSE CAST(signup_date AS date)
    END AS signup_date,
  CASE
    WHEN lower(trim(membership_tier)) IN ('silver', 'sivler', 'sliver')
      THEN 'Silver'
    WHEN lower(trim(membership_tier)) IN ('gold', 'gol', 'g0ld') THEN 'Gold'
    WHEN lower(trim(membership_tier)) IN ('platinum', 'platinium', 'platnium')
      THEN 'Platinum'
    WHEN lower(trim(membership_tier)) = 'none' THEN 'None'
    ELSE initcap(trim(membership_tier))
    END AS membership_tier,
  initcap(trim(acquisition_channel)) AS acquisition_channel,
  initcap(trim(preferred_device)) AS preferred_device,
  initcap(trim(preferred_os)) AS preferred_os,
  CASE
    WHEN lower(trim(preferred_payment)) = 'upi' THEN 'UPI'
    WHEN lower(trim(preferred_payment)) = 'credit card' THEN 'Credit Card'
    WHEN lower(trim(preferred_payment)) = 'debit card' THEN 'Debit Card'
    WHEN lower(trim(preferred_payment)) IN ('cash on delivery', 'cod')
      THEN 'Cash On Delivery'
    WHEN lower(trim(preferred_payment)) IN ('net banking', 'net bank')
      THEN 'Net Banking'
    WHEN lower(trim(preferred_payment)) = 'emi' THEN 'EMI'
    WHEN lower(trim(preferred_payment)) = 'wallet' THEN 'Wallet'
    ELSE initcap(trim(preferred_payment))
    END AS preferred_payment,
  total_orders,
  CASE
    WHEN total_spent_inr IS NULL THEN NULL
    WHEN total_spent_inr < 0 THEN abs(total_spent_inr)
    WHEN total_spent_inr = 0 AND total_orders > 0 THEN NULL
    ELSE total_spent_inr
    END AS total_spent_inr,
  CASE
    WHEN
      avg_order_value_inr IS NULL
      AND total_spent_inr > 0
      AND total_orders > 0
      THEN
        round(abs(total_spent_inr) / nullif(total_orders, 0), 2)
    WHEN avg_order_value_inr IS NULL THEN NULL
    ELSE avg_order_value_inr
    END AS avg_order_value_inr,
  initcap(trim(favorite_category)) AS favorite_category,
  initcap(trim(favorite_subcategory)) AS favorite_subcategory,
  CAST(last_purchase_date AS date) AS last_purchase_date,
  CASE
    WHEN days_since_last_purchase < 0 THEN NULL
    ELSE days_since_last_purchase
    END AS days_since_last_purchase,
  CASE
    WHEN days_since_last_purchase BETWEEN 0 AND 30 THEN '0-30 days'
    WHEN days_since_last_purchase BETWEEN 31 AND 90 THEN '31-90 days'
    WHEN days_since_last_purchase BETWEEN 91 AND 180 THEN '91-180 days'
    WHEN days_since_last_purchase BETWEEN 181 AND 365 THEN '181-365 days'
    WHEN days_since_last_purchase > 365 THEN '365+ days'
    ELSE 'Unknown'
    END AS recency_bucket,
  CASE
    WHEN total_returns > total_orders THEN total_orders
    ELSE total_returns
    END AS total_returns,
  nullif(trim(return_reason), '') AS return_reason,
  total_complaints,
  CASE
    WHEN avg_product_rating IS NULL THEN NULL
    WHEN avg_product_rating < 1 OR avg_product_rating > 5 THEN NULL
    ELSE round(avg_product_rating, 1)
    END AS avg_product_rating,
  sessions_per_month,
  discount_usage_pct,
  coupons_used,
  churn,
  CASE WHEN churn = TRUE THEN 1 ELSE 0 END AS is_churned,
  churn_date,
  nullif(trim(churn_reason), '') AS churn_reason,
  row_number()
    OVER (
      PARTITION BY
        lower(trim(first_name)),
        lower(trim(last_name)),
        coalesce(lower(trim(email)), customer_id)
      ORDER BY signup_date
    ) AS row_num
FROM `ecommerce-churn2.ecom.raw_customers`
QUALIFY row_num = 1;

-- DATA VALIDATION

SELECT
  COUNT(*) AS total_rows_after_clean,
  countif(email IS NULL) AS null_emails,
  countif(age IS NULL) AS null_ages,
  countif(total_spent_inr < 0) AS negative_spends,
  countif(avg_product_rating > 5) AS invalid_ratings,
  round(countif(is_churned = 1) * 100.0 / nullif(COUNT(*), 0), 2)
    AS churn_rate_pct
FROM `ecommerce-churn2.ecom.clean_customers`;
