# 📖 Data Dictionary
## Silent Exit — E-Commerce Churn Dataset
### 1,05,000 rows · 34 columns

---

## Tables

| Table | Description |
|-------|-------------|
| `raw_customers` | Original uploaded data with all quality issues |
| `clean_customers` | Cleaned production table used for all analysis |

---

## Column Reference

| # | Column | Type | Description | Raw Issues |
|---|--------|------|-------------|------------|
| 1 | `customer_id` | STRING | Unique customer ID (CUST000001) | Stored as INT64 in raw |
| 2 | `first_name` | STRING | First name | None |
| 3 | `last_name` | STRING | Last name | None |
| 4 | `full_name` | STRING | Concatenated full name | Derived column |
| 5 | `email` | STRING | Email address | Nulls, missing @, junk (N/A, null@gmail.com) |
| 6 | `phone` | STRING | 10-digit mobile number | Mixed formats (+91-XXXXX), short, dummy (0000000000) |
| 7 | `gender` | STRING | Male/Female/Other/Unknown | M, F, 0, 1, male, MALE, NA |
| 8 | `age` | INT64 | Age in years | Nulls, impossible (0, -1, 150, 999) |
| 9 | `age_group` | STRING | Age bucket | Derived: 18-25, 26-35, 36-45, 46-55, 56+ |
| 10 | `city` | STRING | Customer city | None |
| 11 | `state` | STRING | Customer state | ~3% city-state mismatches |
| 12 | `pincode` | STRING | 6-digit postal code | ~3% missing, some "000000" |
| 13 | `signup_date` | DATE | Registration date | 50 rows with future dates |
| 14 | `membership_tier` | STRING | Silver/Gold/Platinum/None | Typos: Sivler, G0ld, Platinium |
| 15 | `acquisition_channel` | STRING | How acquired | None |
| 16 | `preferred_device` | STRING | Mobile/Desktop/Tablet/App | None |
| 17 | `preferred_os` | STRING | Android/iOS/Windows/MacOS | None |
| 18 | `preferred_payment` | STRING | Payment method | Mixed case: upi, CREDIT CARD, cod |
| 19 | `total_orders` | INT64 | Total orders placed | None |
| 20 | `total_spent_inr` | FLOAT64 | Total spend in INR | ~182 negatives, ~1,050 nulls |
| 21 | `avg_order_value_inr` | FLOAT64 | Average order value | ~2,600 nulls (recalculated where possible) |
| 22 | `favorite_category` | STRING | Top shopping category | None |
| 23 | `favorite_subcategory` | STRING | Top subcategory | None |
| 24 | `last_purchase_date` | DATE | Most recent order | None |
| 25 | `days_since_last_purchase` | INT64 | Days since last order | ~840 negative values |
| 26 | `recency_bucket` | STRING | Recency group | Derived column |
| 27 | `total_returns` | INT64 | Items returned | Some > total_orders (impossible) |
| 28 | `return_reason` | STRING | Return reason | Empty string instead of NULL |
| 29 | `total_complaints` | INT64 | Complaints raised | None |
| 30 | `avg_product_rating` | FLOAT64 | Avg rating (1.0–5.0) | Values outside range: 0.0, 7.3, 10.0 |
| 31 | `sessions_per_month` | INT64 | Monthly sessions | None |
| 32 | `discount_usage_pct` | FLOAT64 | % orders with discount | None |
| 33 | `coupons_used` | INT64 | Coupons applied | None |
| 34 | `churn` | BOOLEAN | TRUE=churned, FALSE=active | Stored as BOOL not STRING |
| 35 | `is_churned` | INT64 | 1=churned, 0=active | Derived column |
| 36 | `churn_date` | DATE | Date of churn | NULL for active customers |
| 37 | `churn_reason` | STRING | Why they churned | Empty string, "null" as text |

---

## Recency Bucket Definition

| Bucket | Days Since Last Purchase | Risk Level |
|--------|--------------------------|------------|
| 0–30 days | 0 to 30 | Very Low |
| 31–90 days | 31 to 90 | Low |
| 91–180 days | 91 to 180 | Medium |
| 181–365 days | 181 to 365 | High |
| 365+ days | More than 365 | Very High |

---

## RFM View Columns (`rfm_scores`)

| Column | Description | Range |
|--------|-------------|-------|
| `r_score` | Recency NTILE score | 1–5 (5 = most recent) |
| `f_score` | Frequency NTILE score | 1–5 (5 = most orders) |
| `m_score` | Monetary NTILE score | 1–5 (5 = highest spend) |
| `rfm_total_score` | R + F + M | 3–15 |
| `customer_segment` | RFM segment | Champions/Loyal/At Risk/About to Churn/Lost |
| `churn_risk_score` | Rule-based risk | 0–100 |
| `risk_tier` | Risk category | High/Medium/Low |

---

## 4 Looker Studio Views

| View | Purpose | Key Columns |
|------|---------|-------------|
| `kpi_summary` | Executive KPIs | total_customers, churned, active, churn_rate, total_revenue |
| `segment_churn` | Behaviour analysis | membership_tier, gender, age_group, device, channel, recency_bucket |
| `churn_trend` | Monthly trend | churn_month, churned_count, revenue_lost, churn_reason |
| `risk_scores` | Risk dashboard | customer_id, risk_tier, churn_risk_score, customer_segment |
